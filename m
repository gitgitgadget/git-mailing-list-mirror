Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B281E377D
	for <git@vger.kernel.org>; Fri,  4 Oct 2024 17:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728062063; cv=none; b=S+Bs9n3WRocIeVC9FqpmABAnsweACReS2++k3X/vRZuGpC9cBPyryBY2uai6NUKGRSrAbPjisN2rF9zi6/zxsRbWodoQh0tqbLQVa7fhkW7falZ+R8fY0I8tjLETwd3Xr0gZt5dx6lcxUHNAi8JLgTNzSAKuHHCBmnyimP9Pa1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728062063; c=relaxed/simple;
	bh=STapKtzjVmcyv0G3iGqNeXfZIWTSqILeOxpgGlkwIkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PHDJvz+BYqyRTngoptnISlfiCwewW2poIxJIflUZ0DWspGFtO1oHupvXN+yWEwwKEDsPxDVFjawc0AxcKly0X36FwD1/yQE2zLiH7NDkgwFLYVY69KxK5bx98IOjJktQilxt2w8YBHSqBQ3+oCqzCwZw37t5LeMpedxmPGw/syM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MLqqGFL2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XQ6HpgTq; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MLqqGFL2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XQ6HpgTq"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id D1BD2138020F;
	Fri,  4 Oct 2024 13:14:19 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Fri, 04 Oct 2024 13:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728062059; x=1728148459; bh=7cgtzt1BAI
	oA81iX9doXMPURKMMM3fyp8i99arSYWUg=; b=MLqqGFL2kds0NrlVani1bPkOUl
	iWiGCdAct/2YFp57jdQ+VTDt2SLTluUudRIk6ecfA43PcET5aeBfTyZwngphLYbO
	ojO6LH7EgWdpm9hwvvVpG9ffuD+aIAmisYbS1okrn5EcbRs6JpPg82CVyxshQLLf
	rR4K/+7I1mHLAaSP1ba9m4gktMTTuXVr4yrx0aQyGUKOlukEV9cQNNKpfm0wENJD
	0s/r5sg6mOe4JX4RtyigeW4q6l9E8Xzb40CopLgoqxjUaQLGbmamAMDZowFoaSDW
	2MRpkPCbuMG18BVMOjS3QmGkC98IvtHgxhj31JXGsixLMYVbAkOyJn9j5W0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728062059; x=1728148459; bh=7cgtzt1BAIoA81iX9doXMPURKMMM
	3fyp8i99arSYWUg=; b=XQ6HpgTqXkO527ae/IbxYlSfkc7sfEIVp0kuttKpes0n
	lQjKWJOahQi33prdUWg0wfFMrmNQ3i9IFnhtFmQfbdDfzxsXuYnHPnpwfanwPHz6
	HihnuOhWpPATPDF6PPAzui7Jjd3KucgaSeDHyL1n2lYF6kr+PA9X0WWBstjxCkVZ
	ZUOBmF5DHZStQjK0dMPGvmtRQBZJTbgqNGm6I9V7NHY96GDdhOgCT+DxqoNAQs3r
	nQZq/Fr5Hk7NcrYPctv0nujnDbwRRxsd78EOBJhg76Ni+Y6+3ALwZACo4byoszu/
	RMhMLouYkbXD4Xsvm03rgLIIk6No2XA/SafX5K9Gkw==
X-ME-Sender: <xms:ayIAZ82rBBztLvZ0vtJ9hQg8dlCEEUMYl92RkqNXBD--bG89hm-wcg>
    <xme:ayIAZ3FwSY-jBqMGnMroGJBJxjRhwK6b_GexqeD9BIslOxHUJOjDRaJL02HDI5idI
    RE5C6Bg9nKVKEFdyA>
X-ME-Received: <xmr:ayIAZ06-1prntppj39MD9VqZrz-oGVhGRZdlON3aRF-fkMqKHjDOM8OHWEvbZqbR93a3P_R_puJAeIJMUjP3rE0NVAMOn0-kR96jDn0EUlKDa9pg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvfedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnse
    hgmhigrdguvgdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhl
    uhhsrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ayIAZ12HNDXRdqb6yZ8cNIHlxouTNP1RJ8EnDiwS4hemQCw46NKcIw>
    <xmx:ayIAZ_H0-oTyA3tibSDtJGpSyTfVkIuC9v1tPTzO9LXplBqzlj4LwA>
    <xmx:ayIAZ-9s_WOrW8afiZiHi8L9VR5Yb450vc5B_bike7lq0q3-fLpJiQ>
    <xmx:ayIAZ0mtt2OXWWQUEs2sEJ_XP0r7hKVU-FLXx3pBNpAo-qIJzUk_Lg>
    <xmx:ayIAZzg8zKZVjfelZmADZUooski4rZr-_YcxSV-XtbDc1ka6gVPmvK_K>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Oct 2024 13:14:18 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 128890ed (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 4 Oct 2024 17:13:23 +0000 (UTC)
Date: Fri, 4 Oct 2024 19:14:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	GIT Mailing-list <git@vger.kernel.org>
Subject: Re: v2.47.0-rc1 test failure on cygwin
Message-ID: <ZwAiXuNPK_SdnfEz@pks.im>
References: <b1b5fb40-f6c2-4621-b58c-9b7c8c64cc01@ramsayjones.plus.com>
 <Zv9oIrKveu-JAGQM@pks.im>
 <Zv-HbT8qrM6IYKb4@pks.im>
 <8718c5c4-1d0a-104b-eb39-6338ae9c5dbf@gmx.de>
 <Zv--68J5qv60IuQz@pks.im>
 <f29241a7-aadd-e824-97f3-a95ac6619951@gmx.de>
 <xmqqbjzzg89u.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbjzzg89u.fsf@gitster.g>

On Fri, Oct 04, 2024 at 09:09:01AM -0700, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> But unfortunately this still caused permission errors when the new path
> >> was held open by another process.
> >
> > Yes, this will _always_ be a problem, I think. The
> > `FILE_RENAME_POSIX_SEMANTICS` as per its documentation should help, but if
> > it does not in your tests it might actually not quite work as advertised
> > (wouldn't be the first time I encounter such an issue).
> >
> > I tried to read through the code (it's a lot!) to figure out whether there
> > is potentially any situation when the `tables.list` file is opened but not
> > closed immediately, but couldn't find any. Do you know off-hand of any
> > such scenario?
> >
> >> I think for now I'd still lean into the direction of adding the !WINDOWS
> >> prerequisite to the test and increasing timeouts such that I can
> >> continue to investigate without time pressure.
> >
> > Let me bang my head against this problem for a little while longer. You
> > might be right, though, that this is a thing we cannot fix in time for
> > v2.47.0, which would be sad.
> 
> If you folks think it would help stabilizing the tentative fix, I am
> open to the idea of delaying the 2.47 by a few days.  Currently the
> 2.47-final is scheduled on the 7th (Monday), but we can do 2.47-rc2
> on that day instead, and move the final to 10th (Thu) or 11th (Fri)
> [*].
> 
> Thanks, all, for working together.
> 
> 
> [Footnote]
> 
>  * All dates are US/Pacific, 10:00 am

Right now I don't yet have a good idea for how to fix the issue. I've
been trying a bunch of different things that, according to Windows docs,
should've made the renames work. But they didn't, and I don't really
have an alternative right now. So I'll need to keep on thinking about
this, and maybe get some more help from people familiar with Windows.

So deferring Git 2.47 because of it probably does not make much sense
unless somebody can up with a solution. Also, as noted already, this is
not a regression, the behaviour actually improved even on Windows. Not
to the degree I was hoping for, but at least a bit. So that's another
reason why I don't think it is worth deferring over this.

Thanks!

Patrick
