Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D01D40D596
	for <git@vger.kernel.org>; Sun, 21 Jun 2026 01:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782004678; cv=none; b=WPxJ6b9vn92SdhQZyiSOHolWZ1CpDtntR3tOA2dTQbdRWvzlRud9LOFvb6CoRbOMEAgfE3nBdt2i/OsiCBwwsMEc8eecvVsOdIMvUyyzalZvwLVZUY1kq1r4spctYqI7WA43YX0ES25pYpKQqhybsLfF5TrUZ8ZNMGLrWJoxIJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782004678; c=relaxed/simple;
	bh=N5a1DsvP1OzjsfTeDENOLslg40pw722uQ0dn/RyUWLE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OSM8rEkWefFdtwzn1slNfc8Li6dicVMzihlDTjXhfOJz/PWUve8PF1bqwBwfKKnI3YNJwtz60yNsoEgB48oKZSxWBrLp8TXrMkIMGH/2zP5rMCLHWXa5zD7/INYwzvehJlLYX/LvFZ+D0yN1c7IZjV7ScjZTUX5NUvAS9zyIMZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Fr4xAp5u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TOaxUN1b; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Fr4xAp5u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TOaxUN1b"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 39B1FEC02AA;
	Sat, 20 Jun 2026 21:17:56 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Sat, 20 Jun 2026 21:17:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782004676; x=1782091076; bh=nZ8g+Gfw+8
	jahKojD+Gx6JgCR2zUNPERjbOgz2O2G3U=; b=Fr4xAp5uRLew0638L6k6m8BGtq
	qMuwbypNigO6VoLF3RLSK2keiwfToemhtAiiGqV8IxdgQZ8NRSaFj5WrmiVtFeOY
	Cgeyt/nS0s+hPjZzewH8qaqmUF70r+0CwF2TOpN0oCzDRwsUyx4feoNVuAp49Mhu
	mFMqCGCt9A490snAVnj9cH4BExPlycGSvNwEcE3IJNR8wl0fgIT+j3UiUC05KptZ
	R0dt8HI1haJ+OaidYeShv6Mt4kAi1GBduZP/4UQrDc3d6Js+oQ+lU44/21F1h0lp
	CzLAGp7VeB3z29RZvq95zbXFP0OStzC0e7NuGpQ5eWTfHsTvhYbV/1dbEESw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782004676; x=1782091076; bh=nZ8g+Gfw+8jahKojD+Gx6JgCR2zUNPERjbO
	gz2O2G3U=; b=TOaxUN1bLD4MpVhZzvLP6GsV3+u5MlEQLdmcqlFZo45p1EOWoHY
	gJ/ifjIhJJUpoDVuxWtB8xYz4S+MADDGq+6XDHUXUbMamPDxM5qsnSClsQyvutM1
	O72OXRJtFiHDYUPKE1O+svpXgfJ30dPGM068mpIo7UuIb7eNuCXEbGwwfD/+MH+9
	s+9eJRbYh6xvp1rBYlUQxXu9MkhdtmTPe6ote4GoaXrp1JU86nS6PFR8dpyiyz/l
	qrwFC3GdQ59WozARQ9Or+/8pRRdSJF5t4UUboifriR244qLC8DmyCdffD1fVCBj+
	g+kXDrGnzhKJWPJ2y35UFCGDrA0AAO8bPwg==
X-ME-Sender: <xms:xDs3ahYzHwGHqqSzREB3EmflaXqu3vFNR8BIsPC0GqmVVbzBnr_Phw>
    <xme:xDs3avZEpRHUu032PFsoGGvgJiVvWh6zKqa9huUi2U4lWOdOdIz66lBkS1dfR53B-
    PtKEtLO1FmoCAS9kT6dT5CAetUygOcUpyGpdA5k3GymYVH9WLFVlQ>
X-ME-Received: <xmr:xDs3ao9uBVQmleqjuzajC2GC7b1h_i1x6uU575UERbg22wvXvHTpAZY2Qq1JuV5yBm36PIErqXCOlJEhkoLoXWBD8Ff7oZAAapN0Bso>
X-ME-Proxy-Cause: dmFkZTEvGMGTobMyBeWHiuhL2uqwp3oIPfAsNUqndZ1BrXbT8DMLxYMaNjbVk/KAWvPtzg
    sJFSqpvsUTt1GiNhon8pqmn3IDs05wk4gMjOVB/2p+WYp+USGwLC+kVoGQYxmc762htLOi
    T4PgEOyvvaFlJpzk3V4r/9ijzsbUpE84eAuDNUY4IOgUJgdXHVa5Qu4sha5wOtUPXgUQ7H
    kf4aUCulx4hZxC+jYr+tSjvvIvu4p+Z9TgjVX7lKpy4cE5Fx0P1Cs3aDNnH5hbihjeDCQQ
    9iR1CQjrn9X1e0prkibaIu5X/fJJeERngAxWwVTcFtjo1rCLXlYWYyeXXOnIREDFkrcHHF
    PgL9BfhSsYwr9HOj0Km4HEApDFog6+YKTmUPzKP5uE3jZyZyaAPBL1v/j94JqEyJ7R3Ubp
    mtOpVAlGMwuUepx21Q9+kWqXm7ovwt2so38i+Ghx0+NQDHsZIQue44OVVqpiSCgkVcw3Gp
    OEAtkTXb/cz8dQms9fj4D0KcVc4KGQnr34wj4ss8nHKvO8CSITVXYKtiEo2C+jcbCG5apN
    SAtw0xI7z13LNNc1MDiukxHQkLwlXDwJtlK6Zz/220EMyOk0T13pPIv5MsfDhYdP0/e3iF
    twkrF2Pitfsb7LVwfZMz82/p5zxdudYGkE+ZcmFeYO3k63omUCMJ0+UP5WzA
X-ME-Proxy: <xmx:xDs3auiamG4gDs5BzgHeEaQZQk58v48g0DvffMz-7a-6LbKyeOy2_A>
    <xmx:xDs3aoeaR91I7-eP5bWrjN3Nx-aDaAoBbBYH7FeNAqv8vXlo6e0VJw>
    <xmx:xDs3alpjXGGsPTpMIFr-TfXcRo-DMf-LA4xOmKK1NN513V5JebBb2g>
    <xmx:xDs3atA8fKA8Y3n4PLMiEOMQOI8fe_uqtZjvwSsmGPVs94K3JMlTWg>
    <xmx:xDs3aoe9X5zWq1U_ClvqoZ2PTt0nwSIpJkz-jWNp8nGvSN1aEYPemIOA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 20 Jun 2026 21:17:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Zakariyah Ali via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Zakariyah Ali <zakariyahali100@gmail.com>
Subject: Re: [PATCH v3 0/2] completion: hide dotfiles for selected path
 completion
In-Reply-To: <pull.2311.v3.git.git.1781978156.gitgitgadget@gmail.com>
	(Zakariyah Ali via GitGitGadget's message of "Sat, 20 Jun 2026
	17:55:54 +0000")
References: <pull.2311.v2.git.git.1779808987825.gitgitgadget@gmail.com>
	<pull.2311.v3.git.git.1781978156.gitgitgadget@gmail.com>
Date: Sat, 20 Jun 2026 18:17:54 -0700
Message-ID: <xmqq1pe0g08t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Zakariyah Ali via GitGitGadget" <gitgitgadget@gmail.com> writes:

> The completion helper for index paths uses git ls-files rather than shell
> filename completion. As a result, leading-dot paths such as a tracked
> .gitignore were offered even when the user had not started the path with ..
>
> Hide leading-dot path components for git rm, git mv, and git ls-files when
> completing an empty path component. Explicit dot completion is still
> preserved, so git rm . can still complete .gitignore.
>
> This removes the existing TODO expectations in t/t9902-completion.sh and
> adds coverage for explicit dot completion.

OK.

> Validation:
>
>  * git diff --check -- contrib/completion/git-completion.bash
>    t/t9902-completion.sh
>  * bash -n contrib/completion/git-completion.bash
>  * ./t9902-completion.sh

I am not sure what you wanted to say with these lines.  If you did
the above to build confidence that your patch works, that would be
great.  Or are you telling readers to do these things and when they
do not see any issues consider your patch perfect?

What is missing around here in this cover letter is a description of
how this iteration is different from the previous one.  And ...

> Zakariyah Ali (2):
>   completion: hide dotfiles for selected path completion
>   completion: hide dotfiles by default for path completion
>
>  contrib/completion/git-completion.bash | 53 +++++++++++++++-----------
>  t/t9902-completion.sh                  | 19 ++++-----
>  2 files changed, 40 insertions(+), 32 deletions(-)
>
>
> base-commit: 9b7fa37559a1b95ee32e32858b0d038b4cf583e5
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2311%2Falibaba0010%2Fcompletion-hide-dotfiles-v3
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2311/alibaba0010/completion-hide-dotfiles-v3
> Pull-Request: https://github.com/git/git/pull/2311
>
> Range-diff vs v2:
>
>  1:  056e239e06 = 1:  056e239e06 completion: hide dotfiles for selected path completion
>  -:  ---------- > 2:  7482ee4645 completion: hide dotfiles by default for path completion

... I find this range diff very troubling.  If we look at patch 2,
it seems that it redoes some part of what is done in patch 1 saying
"oops that was wrong, so let's do it better this time".  Such a
drunken-mans' walk that goes in one direction in an earlier step,
only to be corrected to move to a different course, is now how we
want a new topic to be presented.

The end result may be much easier to read, mostly thanks to updated
loop in the awk script, so if we really want to pretend this as two
patches for "small pieces are easier to digest" value, perhaps have
[PATCH 1/2] that updates the awk script (without doing anything
related to hide-dotfiles theme) to make it easier to read by not
having multiple "print pfx p" in it, and then build on top of that
improved base, have [PATCH 2/2] that adds the support to hide
dotfiles, perhaps?

Since the initial iteration was quite a while ago, I no longer
remember the details of the review I gave, but I recall having hard
time telling which callers of the complete-index-file helper hide
dotfiles from their output and which callers do not hide them, and
how the patch decided to choose which ones should and should not
hide.  Has it been improved and if so how?  That is something we
expect the cover letter to tell, too.

Thanks.
