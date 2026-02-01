Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0F12D7DD4
	for <git@vger.kernel.org>; Sun,  1 Feb 2026 08:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769935171; cv=none; b=i0sO3kOtTYPglTZoqqxMf76W300gR/5EY6o5UGHBdK9u3lMQaJp3UxCkWSD6dZMPfMA7foJg/EHysQpV/vlI1yWJdQImHCrjSkUg2vDKX9HEDJZjCdxatRckwdD/y6ap8l2fMVe6eMGG9d7qvuMOktyTJlF7T1VsToFMCKaTO74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769935171; c=relaxed/simple;
	bh=hEJpJv1RM4/LNLF8K4dvdMvpO2vcdEjb2MDYqjTEsFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rwwgz0WWNrj6ihhpc9/+3UmAPbCXTqINIqbKgKNhABwrxExZ0JDpW6lj3vcztNcuR9YBQz5mXC61aBxpT4lC/ua4OXdjmqDzST9Vfo1eDXTgkCMf1glIgDd4Xkj4RB7yPRx8rgc/EukHcRFeFpDL2F7CFNPeQhyXNCs6oPKOidM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=PFLU9UUI; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="PFLU9UUI"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 0580714C2D6;
	Sun,  1 Feb 2026 09:39:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1769935156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OvxOuN3ZB32jLl3KrRDgIymipwaQiSfBRulPcI3Camg=;
	b=PFLU9UUIlQpH39VNKYjAbOWDlWGBztjWQyX3Z0KxRaChYRRi62Cb/VkQ8VlaKt3o6Ae/fw
	LFZXI7EN+6jrostEwV6MEo4enPOf6N4tqdCao51pWJq8fLggbPW5NoYwfKH2BgzeGR+bnR
	qmJVNRpzyCwA8MrRfxOT6sZSLFuMNovz2QGhvRUldkuBuJBCxtMEFUWvlRycfhj6E+nF9T
	Wm+6Wwal5Yhc7oo+ufVGK0P+rS8JhiZ8MrQ1ycJFSoT2jgHOeK7s6dT7MxWC0jx2hQmyMU
	NG+/5Xc9r2PeKoErEjBgaWY4pmkE4s2uA7H9aof77kpMNN+boYnvCikxqMarmA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 738afec5;
	Sun, 1 Feb 2026 08:39:13 +0000 (UTC)
Date: Sun, 1 Feb 2026 17:38:58 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Julien Moutinho <julm@sourcephile.fr>
Subject: Re: [RFC PATCH] builtin/format-patch: print a warning for skipped
 merge commits?
Message-ID: <aX8RIq0ZUSoIue8G@codewreck.org>
References: <aVkKmcER2K8D9U4T@codewreck.org>
 <xmqqy0mep0y2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqy0mep0y2.fsf@gitster.g>

(It took me a while to get back to this...)

Junio C Hamano wrote on Sun, Jan 04, 2026 at 11:27:01AM +0900:
> Dominique Martinet <asmadeus@codewreck.org> writes:
> > Okay, I can see this being confusing to people not used to format-patch
> > even with a range, but I agree it'll be annoying more often than not in
> > general so I'm fine with this.
> 
> Yup, nobody stays to be newbie forever ;-).

I think I actually fell in this newbie category myself: I hadn't
realized how hard it is to specify exactly only a merge commit in normal
git usage.

In "confusing case" I was consulted about, Julien had used jj to
(involuntarily) make a merge commit that merged two parent commits like
this:
$ jj log
○  mkwklvul Julien Moutinho 1 hour ago openvpn* 0ef9a661
│  nixos/openvpn: format with nixfmt-rfc-style
@    qsusmwyp Julien Moutinho 1 hour ago 14ef78b3
├─╮  nixos/openvpn: add netns support
○ │  vltlsmty Julien Moutinho 23 hours ago services.netns git_head() 204ac248
├─╯  nixos/netns: init module to manage network namespaces
◆  ktsspxvy Yohann Boniface 1 day ago master@NixOS 04245c47
│  (empty) arduino-cli: 1.3.1 -> 1.4.0, use finalAttrs (#469365)

So specifying `git format-patch 14ef78b3^-` wouldn't generate any
commit;
but in the normal merge case using foo^- will grab commits that are in
the second parent that aren't in the first, so to get only the merge
commit you'd need to write `foo^- --not foo^2` or some other more
complex expression...
At which point I'm not sure this warning has much benefit, and the real
problem would more be that jj let him create such an useless merge
commit with non-trivial content..


If it was just very rarely useful I might still be tempted to send the
patch, but it also breaks patch counting with e.g. `git format-patch -3`
(test t4014-format-patch.sh "format-patch doesn't consider merge
commits"):
the -3 is done by common revision `.max_count` limit, so dropping
`rev.max_parents = 1` makes format-patch skip through merge commits
without re-adding further commits, and I'm not convinced this is all
worth it.

So, thank you for the quick replies (over new year festivities no
less!), but let's leave it at this unless something compelling comes
up...


Thanks,
-- 
Dominique Martinet | Asmadeus
