Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F409041A510
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 07:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788766872; cv=none; b=ZitTEFgA/9AwHlzavFlnJqjvgZoDrl3V1eQdqWofkLw7Dp8bU7ajhj3UeVPQw9yEWvUhJKCx1eR5xOp678rp4yG+euM3Ou2G9ghjUSIK38C6ocz8LJNApcB89HmO0N6Xt2Xc3fQfeFTrJbp3dSQme675h9QcBVPlwxdnVsBP8yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788766872; c=relaxed/simple;
	bh=6ojqilPsRjAJH5T7bm9fppYmOf9FPjr3M99yKAUk2M8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tk7xWMR4JOSp59SKJHrOzX0obNv12uhdwgXzlfB96FY0nw1SD5p8ofL89hDzU3SaCWlHsc7vDiY3KSkGcCPE+NYkJvlz1Me4xxHLAK4D4RxXpS2n3svChwQXGlCo0OaLMHYwPoJJ67dxPEjIKSXxcRpMnyK3vBa2k9P+wDz/SUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PsgMtLgC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yQNo3Qa7; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PsgMtLgC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yQNo3Qa7"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2A9EA1400202;
	Mon,  7 Sep 2026 03:41:10 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 07 Sep 2026 03:41:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1788766870; x=1788853270; bh=i98xOL74ro
	HsQiZEEBDVR4IW1bqoazhiiGoPAedmLAA=; b=PsgMtLgCvIkuk5XRyuCbjhX8uV
	T8p24VfjB6TStGO4fa6AKxJAIH4GpsyQxiFk0tOW/FZ7GoTeefx3JOcYWRQy82RW
	doe7YN5j6ogtfJSHmdREg5w3oDY0DJ+LEMQbYWeZOmsDuMezehwFh3y+IhsJBdVF
	TCXx7kxVhWaGdS2BK55p2KbYbjxu/BHWkEvt9Qe5GXQ+HOgCMp+iBqnh7f9mC1k5
	nkuc+jyBKX/KxjNKDIBhquvrVNuXXbWLsvNxp0egnmvgef0L5HwGBhd932Sgj0AC
	WBLqHnCvsVQkSzGEVFGeYSu2ZPY8YG3NfRNRK5/dZekCrHigPOKqI1mCC+hA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788766870; x=1788853270; bh=i98xOL74roHsQiZEEBDVR4IW1bqoazhiiGo
	PAedmLAA=; b=yQNo3Qa7Z57+ibCGiG9V0zuS1vskIKSoNXfIC5zV+X273pBrV8c
	6l/YFiQF1H988pfBj/Mn2/s9wOHaJaaoRshjE24mF0tcOXZtLS18jsOsziXsNJXD
	MNA0MVY/LzD/2nNN40Ur0wrLYo6Ii3VvcFmudHceQLrinAj2JICcbCZVcd9x38z5
	Xlkt2B+ylO+UD5WFQy7tu5j0ADfFBhQLH4EC6/OzsamlCQqiSJvRgOgj5FgNp7E1
	4rhOGDD+iUpPtZWjyaB4lOX0MfokKTRnCUPKzr7mHQUiaSX4ynVmAtNvVJW30sfG
	YeGzkGjS+XfslXcjtbebBf1iuU/oPsSMBmA==
X-ME-Sender: <xms:lWqeauv6XJrtSikiH24YewfOMK-Cs83Tsk-w5p0jzrnEFPeorVCRRw>
    <xme:lWqeagm1v5KFFFRdrgJ2GhgbAcZauDY7f2vOQZtGH44B2fpvgD2vqX_GDt4Kdan8S
    qGfBS9NDMhMpRWUa8UCYkhoTBsKf-z4xwF32-mSKHLH02OWour-IAA>
X-ME-Received: <xmr:lWqeaoyEjm7A9V77rf-Th_l-AzYdyAW92qFSMoraYD_c39uTf7mW3Q>
X-ME-Proxy-Cause: dmFkZTElsAXJQstPNiBx+qmhQ+eNgOaO3gs9Bhl5ZW/YB4E0K5pNfgGGWYPE/MOFNgHtNt
    UoG8CrQDPsKDdON7jydT/uabIhecm1za27mf/nkyNRU27ycv+GuwTNqlbMl8cddQLiHeT4
    ukQFHAZqUM8MiXd7msJRdfNULP9r+GwZcVRGaR/YWi7vEA9Flut2Hyw8VCgvOPToeKazS/
    SsIY0+F96p+2YEfLQ92uFalPVp/wbvwpj8rvoqyROzwEvXBYr7+aa4/KXP3iYXay+zzXE6
    rtuLYLOoZ4aw9OmYIvGZyAKj9sV7E/aiFEkikqZTdKSY+oB0coCrAhNt2UT+ptSp/mPNKV
    uWjJ02vfmmVRUXcb1Verv2podo7+Ev+5lVf7orbFrVaQiAe+3yaB+JgE/7Ig6RZezvttTm
    2yUv2NzJOKb+6FlJeEai1/8EDg4m5QZUt+92BlOUSIytGfr9mCz+tdkrCsS997WhzKR66w
    9qtmWXFYj5YVumwJynKPheceQA3k9/WA35XxQ5IiS9/8f6AugOucyXRC/k2ItteZ+KLcnA
    e8TEXGimMhZUDI1ARXoLonqIBlY0LXvdOHU1ekxFn3BhylXA3v+L9fF90uP9ssv03LkWF1
    TEuAijJAHdHsASAtoHKGyz3eDB/S5VPR/2Dy+v8oD0rpjQQx21Ds/LeIrcUQ
X-ME-Proxy: <xmx:lWqeaqN_DQ0XPda-FqWA2k4umrk2lN04d3DNCD7Fho3sIspNT9aoTA>
    <xmx:lWqeasoLIauOxT-J3e6AL3k9qDRq7ro1dlV3ACWVCFcF-e-n6lPFEg>
    <xmx:lWqearHbpOATf2Q6WMTyFrcWxhrQWUPtXjUzVkdaPMk5EgAsVXFV0g>
    <xmx:lWqeahoArKxlJvEKOGZFLJM7XH5Lp-ikxfcjafsAe4NR6Sl1flyfqQ>
    <xmx:lmqeaoPcg76To_4dbT8o2LfbMoOAk-8ZiZEsZJNT35f67f8KeZePp84G>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Sep 2026 03:41:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 54be2e1e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Sep 2026 07:41:06 +0000 (UTC)
Date: Mon, 7 Sep 2026 09:41:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Bachem <mail@thomasbachem.com>
Subject: Re: [PATCH v3] rerere: keep a background gc from killing a rebase
Message-ID: <ap5qj9wckDeKlI7i@pks.im>
References: <pull.2214.git.1788337897490.gitgitgadget@gmail.com>
 <pull.2214.v3.git.1788537081930.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2214.v3.git.1788537081930.gitgitgadget@gmail.com>

On Fri, Sep 04, 2026 at 03:51:21PM +0000, Thomas Bachem via GitGitGadget wrote:
> From: Thomas Bachem <mail@thomasbachem.com>
> 
> A "git rerere gc" holds MERGE_RR.lock for as long as pruning rr-cache
> takes, and since 2.54 the auto maintenance after every commit runs
> one whenever rr-cache has an entry. The commit a rebase spawns for a
> resolved pick starts it too, and the sequencer's repo_rerere() at the
> next conflict wants the lock a few milliseconds later. Both take it
> with LOCK_DIE_ON_ERROR, so whichever comes second dies. When it is
> the rebase, the index is written but the state for "git rebase
> --continue" is not, and every later continue refuses with "you have
> staged changes".

Haven't we said that this race is not exclusive to `git rerere gc` with
a concurrent writer though? It also happens between two normal writers.
So it's good to have the context that we discovered this race because of
the changed heuristics in maintenance, but we should clarify that it's a
longer-standing conceptual issue.

> diff --git a/Documentation/config/rerere.adoc b/Documentation/config/rerere.adoc
> index 3a78b5ebb1..14ef193545 100644
> --- a/Documentation/config/rerere.adoc
> +++ b/Documentation/config/rerere.adoc
> @@ -10,3 +10,13 @@ rerere.enabled::
>  	enabled if there is an `rr-cache` directory under the
>  	`$GIT_DIR`, e.g. if "rerere" was previously used in the
>  	repository.
> +
> +rerere.lockTimeout::
> +	The length of time, in milliseconds, to retry when trying to
> +	take the rerere lock while another process holds it, typically
> +	a background `git rerere gc`.  When the time is up, the command
> +	warns and goes on without rerere.  Value 0 means not to retry
> +	at all; -1 means to try indefinitely.  Default is 1000 (i.e.,
> +	retry for 1 second).  `git rerere gc` does not retry at all.
> +	`git rerere`, `git rerere forget` and `git rerere clear` retry
> +	the same way, but fail when the time is up instead of going on.

I'm not a 100% sold that it's sensible to just skip writing the rerere
entry. But maybe it's more sensible to regress gracefully compared to
just aborting the whole command?

In any case, I feel like this change warrants its own preparatory commit
so that we can discuss separately why it's a good idea to ignore those
failures.

Patrick
