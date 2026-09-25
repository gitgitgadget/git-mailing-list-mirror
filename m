Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047C1346E7E
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 01:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790301121; cv=none; b=UUfaSsGqVh/OgBav+MLO/7SpBEgojRyNEl7oHtS5nmJeqxS/mCkqn72x7SkywA97KN9TLJ6PUoRCSjcQZwYjYBCZJZh9b2anyx2wYvGbUoeHBrwVvt39n+DCKq0aKfxjBY7NhAG3uVHNuch9kGXW6SsjLYdAoqGZmd7qMlNM9eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790301121; c=relaxed/simple;
	bh=VKljh7J28HYwy/IN86/5c92NKRukRsGLPw44ijdPHIY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oQ6q6jQgeMMW+oUTGeZyOTXQZ0d30AC3QZ36CRwdbDqUuJdFd51uCvPA86hScoazAbeDQI8JAGqVoSb88xyO/AgZqB8N30tb0//alc9NlBtb72gR5xXTld7bnqCdrh6KaCX0H/4ghlNG5jXspp8PeKJMbArlTjG1caeoY9AWAB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jIF1Zf8i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j8f9Br9B; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jIF1Zf8i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j8f9Br9B"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 2E4941D0010A;
	Thu, 24 Sep 2026 21:51:58 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 24 Sep 2026 21:51:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790301118; x=1790387518; bh=8qy2frHd/i
	ZkdQ988hodZ51VoRY91yjOv/ATC6GhF3k=; b=jIF1Zf8ig5JD4qYPGwS5RsmL8V
	B8C0imZbg71JQ4ljly05WuZEgt+zaVxLkySG4/5PLFrLpHZ5f4I9xuU/f6BlLFLR
	He1iVpbZkIwazf6A4+eOQKtGkgt/6QaYFOWQK5nPxbuOawV8dGUDzJZUWEOnkN9o
	nSB4+ZTWqFSQZvM3/aImOdYi98yBKpWJl7sjhc0xc5fEf5I2Gr8AilFbQtreakBm
	nomVDt8RO1TfwCaXL4ZyP2PNTBB0aVBQF14IvLsYhfbAj0kfankcee4oB38ggBLn
	9HFuT7u4a0+T/OUbETDNP78PqVsvQs9yICTsWc/2gG+pjaLArrC9aEzqMJsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790301118; x=1790387518; bh=8qy2frHd/iZkdQ988hodZ51VoRY91yjOv/A
	TC6GhF3k=; b=j8f9Br9Bc+0N5u/2uEUun0KRt87HV39yd+tVesv1FqJ0BAvtcds
	NeCJUjjS1GdwtQacfmnY2PW1PS/loPFqzSRrED/+yRjRe6M+JvViFkwHstwpWrmW
	QxNXwF5+SQ3CYOMvZRnJQKUdUDk8ncGaRdKOzRTkTqQ/nFA2Ub2EfP5GOxtU+Oox
	/IGnyEay1Y0Ey8lU9xJfNtW1Fa3g4lB4LSMQ64Ta2ZmbFcPUmR/lZhFxxwSKHQBA
	lsmJ9LO6Q6jLwQ40BqKmhzRgvuSoTSvZVd0e6PAlh4iykxbifH8/gsMkqr5sFhFG
	bM3YAysX16+0GVRpJW4VJXJJCMmdBbIKqoQ==
X-ME-Sender: <xms:vdO1ajbpGatOcjxt2Lw8SZbcTkEwlHeEwHsTusNok5ckXUCuBxTfPQ>
    <xme:vdO1apaQhVZKP8IynHQjrzot0iD_FFGLO1DTWBXf3rzE0VLeruIU06L8q_qcqB411
    2_MDSrM05gii0zEUz1pmKxM9YT3b-Cvl4NlHp-k7scgcqewEHhwvg>
X-ME-Received: <xmr:vdO1aq9h96ImPtrc0cByq6hPjXk_gDB9k64Z2SBio8uVrhc0GCqBEKXix2Yio4ubQi82G8S0EpwDX7GPKprLcWX_V32RLq5M9LIT>
X-ME-Proxy-Cause: dmFkZTEG6L26TxjpDK80RVlYTkn2HPZHA0QL1ddBHe8AVjUaqFy7Hp0dUT74TholpqL+Gf
    5Wz3BlSl2mCcbjwYKI5QZYEq6iEtjcknpq4F+FDNyVnhZuL71YZpex3iVN5XWOhimqXquM
    LzhbJb0tOFsZNEDYlNESdDv1W7L7P9WNZJw7bMj7kFOoGvcXoLPlgnt/NhAtDVfKEPI3l9
    uzIizM9vIrc10uan6aOSyp9uDd2SwfTvNR1mi2zI/T81M27nU1j636qJUtS8Sc82ZjiMzo
    y1vJ/qSsXmNV+wlA8h7b5dbkaz5tydP7xDIW/pK7JzGonyCl0Ke3S44m6EojRzUwAp0WCG
    KF9MMi919pG7vRV6y37lLasGz4heXJNL+NpznJjA5OdPSdEzm2Gbxi8e91BRrMwC2AGmMg
    +3a/VjCqYXFUMvPRgZARBLUmx+yeNBhdAltJHZQX76MMPMNO9wdSR4VcpSj3NlbfuTfI/b
    MYsFrV/BPNXiZtUVpLli8H7l357MuHR6DmK5ypnWvGfkSqw1Q9mn9nou0OirrbwIBjRIx0
    shA4ort96L/pNzVZTxEuw6UAemEIxubjbZzQ6GL93LYWl3WtQOGOebDGClydIY1WwQyJj2
    QXxiosI94WpwuLHgZcqqfhy7ttpxd9cqWQ//GeMce9d7Vx7hPITqDNi8S1bg
X-ME-Proxy: <xmx:vdO1aojfi01Vh-mn5iugUXEgdIgvpo7BIMpCkAjRNB55Wula7CN6Xg>
    <xmx:vdO1aqeSA17rDs-PxSKzOCNuyy1mmcK6jW6vy-y06bgUXiYWQJQ0Jw>
    <xmx:vdO1avrI0Y_UFxYOlxm_OePZrtz-18WAv8mHG7QUl9DUSvhn-V422w>
    <xmx:vdO1avBBRlGQZGGmN6ZOJdM5QoJkcvsI_2Xmqi2tGEoBE9b-pAWP0A>
    <xmx:vtO1aqfY9CoSgT6-6lePaIPS85htRLGdC1RxZ5VKc5uqPsiabFqN0Pmk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 21:51:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Nathan Froyd via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Nathan Froyd <froydnj@gmail.com>
Subject: Re: [PATCH] builtin/fetch-pack: indicate when we have an exact oid
In-Reply-To: <pull.2420.git.git.1790257834680.gitgitgadget@gmail.com> (Nathan
	Froyd via GitGitGadget's message of "Thu, 24 Sep 2026 13:50:34 +0000")
References: <pull.2420.git.git.1790257834680.gitgitgadget@gmail.com>
Date: Thu, 24 Sep 2026 18:51:56 -0700
Message-ID: <xmqqtsnexflv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Nathan Froyd via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Nathan Froyd <froydnj@gmail.com>
>
> The `git fetch` path, when parsing OIDs, properly sets `exact_oid` on
> the relevant refs; the equivalent path for `git fetch-pack` does not.
> This oversight results in an invocation of `git fetch-pack $OID`
> sending `want-ref $OID`, which results in errors like:
>
>   fatal: unknown ref $OID
>   fatal: remote error: unknown ref $OID
>
> Make the two paths equivalent by setting `exact_oid` properly.
>
> Signed-off-by: Nathan Froyd <froydnj@gmail.com>
> ---
>     builtin/fetch-pack: indicate when we have an exact oid
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2420%2Ffroydnj%2Ffroydnj-fetch-pack-exact-oid-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2420/froydnj/froydnj-fetch-pack-exact-oid-v1
> Pull-Request: https://github.com/git/git/pull/2420
>
>  builtin/fetch-pack.c               |  4 +-
>  t/t5703-upload-pack-ref-in-want.sh | 68 ++++++++++++++++++++++++++++++
>  2 files changed, 71 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
> index 86754296fa..bef8a3dfc5 100644
> --- a/builtin/fetch-pack.c
> +++ b/builtin/fetch-pack.c
> @@ -23,13 +23,14 @@ static void add_sought_entry(struct ref ***sought, int *nr, int *alloc,
>  	struct ref *ref;
>  	struct object_id oid;
>  	const char *p;
> +	int exact_oid = 0;
>  
>  	if (!parse_oid_hex(name, &oid, &p)) {
>  		if (*p == ' ') {
>  			/* <oid> <ref>, find refname */
>  			name = p + 1;
>  		} else if (*p == '\0') {
> -			; /* <oid>, leave oid as name */
> +			exact_oid = 1; /* <oid>, leave oid as name */
>  		} else {
>  			/* <ref>, clear cruft from oid */
>  			oidclr(&oid, the_repository->hash_algo);

Unlike "git fetch" that is a higher level wrapper, in "git fetch-pack",
a heuristic dwim like this is unwelcome.  In 

    $ git fetch-pack <repository> <ref>...

these <ref> arguments are meant to be passed exactly as given.

I am not sure if there days there still is a reason to run
"fetch-pack" directly instead of "git fetch", as the manual of "git
fetch-pack" itself suggets.  But if there is, then shouldn't we give
it an explicit way to say "this is not a ref but is an object name"
in a more unambiguous way.  Otherwise, we lose the ability to send
"want-ref 3ce1e94f7d5607971b5de6762bbdb57e86fc5707", even if we
wanted to, which is something "git fetch" does not let you do, and
in turn may be a valid reason why somebody want to use "fetch-pack"
over "fetch" in the first place.

