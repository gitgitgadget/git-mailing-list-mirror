Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4924C7260D
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 03:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766029534; cv=none; b=BtnXxklPdCjUZbgrtGEYnORJ8r9dnJMiKfZFjGIoR5k55WbDGR63h+R08weloRxK0TxxCAWqx0jlQa5wx/PwrobblQhSTWDFuTMgS9573EmVydvxOeGFBvwDsLBlKP6siVjCd4LGn7xD6bEeWjwTGifK1LRIMhLpkO+f1kC5Enw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766029534; c=relaxed/simple;
	bh=So5s03ArDmKYDb5gOic9ABygAv8AHxR4yTVYZle7kLc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Nx2OTU8JOQazn+Wza15Yk+51M0Rj4N2CaYVAHB4/Ey3E25h1jJTQwNmiOpUpSuCZc8njcCtx+Df8eM99A9IfQl8iRobWSf1ZWTAgThtfsYwOolR4slvCEUNyOpU/JhMj8He2azvaKUrxt2F7lWzv3Df5lKjEEhNZPxZtljd9B/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HlgtUSG4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OIWKnu8/; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HlgtUSG4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OIWKnu8/"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5A63614002EC;
	Wed, 17 Dec 2025 22:45:31 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 17 Dec 2025 22:45:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1766029531; x=1766115931; bh=mUsU+gApcd
	EcIYk+GPgZSPZ95mWAnawqqSTULa24/tA=; b=HlgtUSG4hq3xmEOeZmphnCJzfU
	6Ej2d/WOVLUWkhV/jCW57axjo2ArVOxhO+zjttBzyjMtueN7TukIsgJKzhBACxXr
	dxXVHVbHonBO/1q+aTTJKUeXO24UsRkcJ9fthocrT1axk0OA6itg2YSnJF85PMe4
	+NzvUN0apzI39y4/KiiK5E4k85SUaWGAfDB1vUr7GxJ8X+G7MAZEqWE8wCX9S3bL
	8UcdJ3mY7S+q+5wbBGwUbY53RStJiyxCwXndKdNZXY2TM2dlKAOeek1oUfQYom59
	zKWCj3+q43EgMvLsJj/G/6p5RJ6QoVl3LJ4F54yN9Hn5kaVdOH7YiRamOYXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766029531; x=1766115931; bh=mUsU+gApcdEcIYk+GPgZSPZ95mWAnawqqST
	ULa24/tA=; b=OIWKnu8//gNkdFteRxdbhfxPiZAzZC8bNBPvtGrQMRjHpZKnkKR
	vOYo9vp8LyHVFRdRpjV24TcXhdRLJ5RAZqzUVaaKoHXPLn3VFMR2xhTDRTUiCQKo
	vImRv8Es+ZSrbjusUxarOR2Z96MieyPoxDGBIV9He9cIOuS1l3fpOk0ymxapomSX
	E9tpCCBO+OVEGZTn6J48iZQ+LD1sHh9pcA2X0mLGOZppTQ1e+iO3EfRissGfBPAC
	vj30HG9GMZnRKpQpU9tA14nUfpHuWZLylno6ZTe3PmLR4UF2QfGttlqFfxX9H1Bn
	lqHhsqM/VlUOUtpPW1c2+UJXQi5rKaWfhyw==
X-ME-Sender: <xms:23hDaUJiZWdXo3FxqVmjRhvUUV5Twwyy2TfztNt-Eu_If8mxMPAAMQ>
    <xme:23hDabLieFCLZaDr0zUT5SgV6dK7ZG7ovhUtJraZooAsDIKQ0QZxO7FN0HqomJadD
    iQXZAG3VG7BpIn2YzcgF6LD5OMUwus8Ltyi2ondjJ518D8INK1cYUU>
X-ME-Received: <xmr:23hDaZt_JqWMFpLaF1cBKCtVso_4gBMTJlKhLXB1Wx9nGjOk8yoMK0t60hnVL9r3RM5PfEVraTDatFsdi6LE9CZsT5yW0doQ3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeggeefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeffieetueejveefheduvdejudffieejgeefhfdtvdekfeejjeehtdegfefgieej
    tdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhith
    hgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgfhhunhhnihdvfeegsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:23hDaQSlDc5T2qY1AlaX3GZBfxEJmql8OJzTUNUfqpjvKwCkdkzubw>
    <xmx:23hDaXMQAkO6sOmbk4_kanePvqYwl87ojj3GfCJFkuEubE7wRtkaqQ>
    <xmx:23hDadagQpUfTmM_gbFNyFmORbM_I3gMWw-lVQ1D9tLIJnP-IIEIMw>
    <xmx:23hDaZzSEctqOCqOr0L-zrh8SMz_xQqS2cnWIaQ2WrM8bWV7n7B-Jg>
    <xmx:23hDaZMVkOp5l9Bs5epJWU1fxOOJblEg57FAfv41sx8iYCVsJgkpWUfO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Dec 2025 22:45:30 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "AZero13 via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  AZero13 <gfunni234@gmail.com>
Subject: Re: [PATCH] open: check fd_flags value before calling fcntl
In-Reply-To: <pull.2131.git.git.1766027643744.gitgitgadget@gmail.com> (AZero's
	message of "Thu, 18 Dec 2025 03:14:03 +0000")
References: <pull.2131.git.git.1766027643744.gitgitgadget@gmail.com>
Date: Thu, 18 Dec 2025 12:45:29 +0900
Message-ID: <xmqqldj0xxk6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"AZero13 via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: AZero13 <gfunni234@gmail.com>
>
> Otherwise, fcntl can be called with invalid fd_flags.

This somehow feels mischaracterised.  The intent of the code is
already to check the current flags value using getfd and or-in the
cloexec bit to call setfd.  What this patch fixes is to handle
a failed getfd case correctly.

    Subject: git_open_cloexec(): handle failing F_GETFD

    Before using F_SETFD to add in fd_cloexec bit, the code uses
    F_GETFD to see the current set of flags.  As it does not pay
    attention to potential failures, F_SETFD may be called with a
    set of invalid fcntl bits.

    Continue without calling F_SETFD and behave the same way as the
    case where F_SETFD failed, when the initial F_GETFD failed.

or something like that, perhaps?

> Signed-off-by: Greg Funni <gfunni234@gmail.com>

The in-body "From: AZer..." line we see above should say "From: Greg..."
instead.  Set "git config set user.name 'Greg Funni'" in the repository
you use to contribute to this project, amend the commit so that it will
record "Greg..." instead of "AZer..." as its author, and force push
to GGG and tell GGG to send out the email, perhaps?

> ---
>     open: check fd_flags value before calling fcntl
>     
>     Otherwise, fcntl can be called with invalid fd_flags.
>     
>     Signed-off-by:Greg Funni gfunni234@gmail.com
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2131%2FAZero13%2Ffixopen-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2131/AZero13/fixopen-v1
> Pull-Request: https://github.com/git/git/pull/2131
>
>  compat/open.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/compat/open.c b/compat/open.c
> index 37ae2b1aeb..b313bcd364 100644
> --- a/compat/open.c
> +++ b/compat/open.c
> @@ -44,8 +44,8 @@ int git_open_cloexec(const char *name, int flags)
>  
>  		if (!o_cloexec && 0 <= fd && fd_cloexec) {
>  			/* Opened w/o O_CLOEXEC?  try with fcntl(2) to add it */
> -			int flags = fcntl(fd, F_GETFD);
> -			if (fcntl(fd, F_SETFD, flags | fd_cloexec))
> +			int fd_flags = fcntl(fd, F_GETFD);
> +			if (fd_flags < 0 || fcntl(fd, F_SETFD, fd_flags | fd_cloexec))
>  				fd_cloexec = 0;
>  		}
>  	}
>
> base-commit: c4a0c8845e2426375ad257b6c221a3a7d92ecfda
