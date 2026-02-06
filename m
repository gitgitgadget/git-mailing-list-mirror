Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38433136351
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 09:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770369865; cv=none; b=Vx3OVL9821YfHCMHtIx0kBcJFcDVVDiJwnCknPY6r5dgCjYHJ0MIShkhKoibcfKebjT12v4nqxA4T3o5mi50e3hEyCxeSgXpEYbVMXzslBN3q5HSVxi8QKETpnDZ2Ohk/HHF179/cmedZxLB7zWt2zzauAgXckVxw0ew+1NdPgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770369865; c=relaxed/simple;
	bh=HyDFqOZtJhrRHDSP2pp2taaXyYvTSa6hnNNaRi1erLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TA97iaFyEH5qpafdtQfPumv1Q+fZ/wEJuaf71M2svQDUcMVicgqPt9jpKOrxKR7EJglb7z4AZNxmhsupYzwYwSZfm3RKa6vsJz05Zp+0jzItqc3AmGepgLbBZcXsmw7qNh4Dm4yI+ZLdS26GGG2q3+ehq45cC0Vxsg7lvt0OGrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=E9WXPiMk; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="E9WXPiMk"
Received: (qmail 298093 invoked by uid 109); 6 Feb 2026 09:24:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=HyDFqOZtJhrRHDSP2pp2taaXyYvTSa6hnNNaRi1erLY=; b=E9WXPiMkeUV1Hf4YCjRWL7nfAlamTrbZKZT/u8aptWB9rpWQkedIlcQYu+xBlcMuuoHx+N0HG1kG0s9IZa3vPvjvEKPK56b5LUG3iyJ31yjw2JRb0mukKASDbipT6UrJBjah2DVAWUI2KgbdoQPsCrq82dYTVGc4t2ZVrG1VBcstEIVB+ycVFodwQyWIl8Tya84TKBNotehlSvXiwkSCINU7LjnUNk2qI7iKEmQGgM96dzQGJjdbYzNPQSaU6LG5XbPKEyuh/ZOK1CVWBdHr2dUkctVMu1Iv1/k4jy4Ct3zehwm6T/ElY/NzgCLoW4anzMyL3X0JYlSwInFFwYd62A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 06 Feb 2026 09:24:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 599006 invoked by uid 111); 6 Feb 2026 09:24:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 06 Feb 2026 04:24:28 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 6 Feb 2026 04:24:23 -0500
From: Jeff King <peff@peff.net>
To: Florian Weimer <fweimer@redhat.com>
Cc: Jacob Keller <jacob.keller@gmail.com>,
	Matthias Beyer <mail@beyermatthias.de>, git@vger.kernel.org
Subject: Re: git-am applies commit message diffs
Message-ID: <20260206092423.GB2761602@coredump.intra.peff.net>
References: <bcqvh7ahjjgzpgxwnr4kh3hfkksfruf54refyry3ha7qk7dldf@fij5calmscvm>
 <CA+P7+xqcBcV8uySGgDfvt2ruAnFmfgaUy6aRbUC2zCzmCgPubw@mail.gmail.com>
 <lhutsvuuu18.fsf@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <lhutsvuuu18.fsf@oldenburg.str.redhat.com>

On Fri, Feb 06, 2026 at 09:59:31AM +0100, Florian Weimer wrote:

> Isn't the format-patch output already unambiguous because the sequence
> of diffs is preceeded by the non-diff statistics section, and only then
> the commit message follows?  It's just not possible to process this
> correctly in one pass because only at the end of the input, you know
> that you have just seen the to-be-applied diffs.

That diffstat is optional, and not parsed by the receiving format-patch
at all. Keep in mind that in the world for which it was originally
designed, people were not necessarily using Git to generate their
emails. They could be patches emailed by random folks using "diff"
themselves.

> The other tool to look at is git rebase.  There have been problems with
> the lack of "From " encoding in commit messages in the past, which
> caused rebases to fail due to commit message contents (but I can totally
> imagine that this might have resulted in commit injection with more
> carefully crafted commit messages).

It has been a long time since I looked at it, but IIRC we did have a
problem with fidelity of commit message in git-rebase, since it was
based on a format-patch/am pipeline. And we solved it by teaching "git
am" a magic "--rebasing" flag which tells it to ignore the email
contents and find the actual commit in the object database. Gross, but
it works. But of course the same does not work for a true emailed patch,
since the point is that the receiver does not have the commit object
yet.

-Peff
