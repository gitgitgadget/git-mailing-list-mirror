Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3A63A6B89
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 17:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784224797; cv=none; b=pD7S/FbQ5vKmxiR7mpOj4s9/8iIjYYQDwN89PxZu34HEKphOcOMvGDLwGOqp0xsF8ijBZHGcoCz47QOUaaL8dQ+857wAlKeboAMv3/u1JrbXXcgam7sVALrBlp49ZTD7KqRJZbKgBAhgZjT0Htq59M8A6/NQkBKslJl0gnBB12Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784224797; c=relaxed/simple;
	bh=uBr8Nne51GkflWjoSgvACXBQ5QMDK3fzuQQUodysivw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s9ya+Y2bJ8h1dF4WYspGOZN3ITDOgzgpIBFIzSMiapsO+fd5nf7fEY2+PaIwyqupSSlMWHWDaHPaoKAoZJGLDmzWyfE0JWHuJX8rtZCRurZNNFCSUZq4CwbtTROMMSNvNSsJ3IobkFDMdnVKCYDCGj0ZRf6Z8Gz1YQgMJz92HNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=wI6juCJ6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xgp3YQiJ; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="wI6juCJ6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xgp3YQiJ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 3239DEC01D6;
	Thu, 16 Jul 2026 13:59:55 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 16 Jul 2026 13:59:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784224795; x=1784311195; bh=Cuqy8HnueQ
	bSng8oRQhhgZV4u2+iFcRn2LXCVN2W9EM=; b=wI6juCJ69jfxXks089u2Uz49Ls
	mi8Eyp8oXrmSt16oHQP4b372dRZV6mug5qMptza3oZuA0cb7uBrGuaFHt6p+64MM
	oL/FpgxJD5ucPH0fntFDNgB5qSAApMgMvjIp8zDLQn2fFJygBI7K5sp8dnJVV9fc
	TSMAKX+OBeC8TATFulS2rIsDUKqNqDr3aLeWepBkdZ6BloBUCTwNKcqB7iYu1t1O
	vGRgxwGcQxwwaNRLu9oVEWL/1IJ1/tkrxk0yiWPPZdM97e1cSKGpSiUsefnSmenz
	344TfXO2AyDsNFd27n3PfAv0dsxmnVF+3XncuFLJ0s98syLT17azBQriaTqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784224795; x=1784311195; bh=Cuqy8HnueQbSng8oRQhhgZV4u2+iFcRn2LX
	CVN2W9EM=; b=Xgp3YQiJCU2xjYB9muZlTKtCqifv+mFCaIYWb7K75RSJNemxLuj
	eW4HVGNmY8eShdnmWsNVqb34IuiAbLNj7J8LGNqCMEOXiczKCZDdqw9rem5gckts
	C740WADnpe9qcnhuiIEm5S+Gt1iRWhKTg3AmC6CFtNUOfCMH0Nf9SjKv5yguEVx4
	HFEBM+oBX6h2Cw2naGqGKt2TY5pjAS7xQKCYF3MEoc0h7eiht44/bikwrnNu3x0Q
	UB798UoHK34bxwGiKp3XmkC1YmySeU44SheY4z6Ia8b4AcMxasly/q31yWZKi9aj
	/92wKF15xwe0lPkZUwlFhdLYK3jmV3TYEAg==
X-ME-Sender: <xms:GhxZauKs4qr2uS47RYK323Pr9Cw9kWhYy1E9kpJLuOvwMluuXHCZKQ>
    <xme:GhxZatCOW-GNfBVTEuG9OWIJo5rr4Dle7gMXNRpZlwZEKGTq8qDvyWyphbJvI0h2t
    zqw6mHcW4UEHUuWivLxdqxQObFercGV4bn_0qsGukHRKLQ1X2BxNg>
X-ME-Received: <xmr:GhxZanBBHeGdBGDM4zFXvAj2ldwG9VHxymxxn3n5_77rZRxV9mLoky4neBDZD7SmCpgogXRCWi-N1byi6bLUa1ooLaHFhyyrBK874Wc>
X-ME-Proxy-Cause: dmFkZTEwGGZxhZeeYBZ6kQgz4mwOt1elF1MPQeyrBeNh2oVeZiio+7GlpTLllrvPsf+d/F
    Tj319XqWLQkJO0ivgeT/zgjOCAWD47ieC9PYY5QLH0Ff0yYXKQTnG3CyxPU088NOW68rdZ
    VkOp2Y0ORKw7U55UfXqzeaHxbseb+NjuMDMqVYEoCQxLy5SCrYLfsHDjYs0Zhl0c5/6G3c
    xgaMPuug5y3WeoFW9sqOtvUtKWc808LP1gPPHoOk/INIgKzL34SW9newQuI+JlI0g+0eVv
    wkB0GxPwwxKpJLZaBDyL8UyC5fkqY8XfdFc4Mb0ihgYJqY7tL8tQHuUtP3szWAKBAb0DFl
    LqK+etc7hg/tWRBaiK8y65dg9qeoiWMSU2THYUgCWiqQ5ir6qoDvJvD0tJNdMFfRGJ90pN
    P8y67ZndAr/j9z4pxyWg4KBRlg5Z7FVSTUsEnD06Ktaip5Ri+VaCT0jYc/Ufa58BhC/E/X
    Z4SWpu7pezuh4PeepAvjU3FD78VSZ+3SM7Yw3ZljzXUM6oBYr6UMLy83gumonBTRbEoG4N
    HaCRr2j83i/X6UZcx4D6qaSz8PpLR7jYt+AlX/wyXgX1A+RJlmyi6QYUrv3aTZOI3gw1IC
    fW4fWKuWPF1gaHLrYEddnP7oeVzBDh0ZQX+gNd4gE69R66yorHFTlW7bsGdg
X-ME-Proxy: <xmx:GhxZavCmIBtA1fqMgsuksyjgTJtGhEb5JR1Wz-S9iYwEa8i4qhfDdQ>
    <xmx:GxxZaipxOB17UHUBYs_Ym0Oc_qHI4IhI4KgprCaOZDuSkWhj2U36hg>
    <xmx:GxxZaplEaOm-0nx-JvimcrKHtNQjuUMHBpQKRPIsIkTZxP9B3UX6MA>
    <xmx:GxxZaizzS1AKCeGnw29_232geLHkGUURg6kxRan9Uj3pAQdWzG9Qsg>
    <xmx:GxxZagksJF9b4K_RLVdkPpQXxO3k1adF37YAEe8cAPrLbVgv1S3hUcjt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 13:59:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Peter Colberg <pcolberg@redhat.com>,  Kristofer
 Karlsson <krka@spotify.com>
Subject: Re: [PATCH] revision: fix --no-walk path filtering regression
In-Reply-To: <pull.2181.git.1784198879711.gitgitgadget@gmail.com> (Kristofer
	Karlsson via GitGitGadget's message of "Thu, 16 Jul 2026 10:47:58
	+0000")
References: <pull.2181.git.1784198879711.gitgitgadget@gmail.com>
Date: Thu, 16 Jul 2026 10:59:53 -0700
Message-ID: <xmqq4ihyhl2e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Kristofer Karlsson <krka@spotify.com>
>
> Since dd4bc01c0a (revision: use priority queue for non-limited
> streaming walks, 2026-05-27), "git rev-list --no-walk <commit>
> -- <path>" ignores the path arguments and outputs all commits
> regardless of whether they touch the given paths.
>
> That commit introduced a REV_WALK_NO_WALK enum value to separate
> --no-walk from the streaming walk in get_revision_1(). The new
> case skips process_parents(), which is correct for not enqueuing
> parents, but also skips try_to_simplify_commit() which
> process_parents() calls to evaluate whether each commit touches
> the given paths.
>
> Add a call to try_to_simplify_commit() for the
> REV_WALK_NO_WALK case, folding it into the existing
> REV_WALK_REFLOG case which already does the same.
>
> Add tests for --no-walk path filtering to t6017. The
> "single commit, match" test is defensive and passes without
> the fix, while the other two fail without it.
>
> Reported-by: Peter Colberg <pcolberg@redhat.com>
> Signed-off-by: Kristofer Karlsson <krka@spotify.com>
> ---
>     revision: fix --no-walk path filtering regression
>     
>     Fix for a regression reported by Peter Colberg [1] where git rev-list
>     --no-walk <commit> -- <path> ignores path arguments since dd4bc01c0a.
>     
>     Verified against linux.git with the exact example from the report:
>     
>     git rev-list --topo-order v7.0..v7.1 -- drivers/gpu/drm/ |
>     git rev-list --stdin --no-walk=unsorted -- ':!drivers/gpu/drm/'
>     
>     
>     Without fix: 2026 commits (all pass through unfiltered) With fix: 146
>     commits (correctly filtered)
>     
>     [1]
>     https://lore.kernel.org/git/CAL71e4NjDTHbKR8z7pSrPpzDrX19JOTR04sArm7P=m5ivqkskA@mail.gmail.com/T/#u

OK.  Without this fix, a commit that applied this patch (which does
not touch Makefile) shows the commit message in

    $ git show HEAD -- Makefile

but with this fix, just like Git 2.54 did, the command stays silent.

Will queue.  Thanks.
