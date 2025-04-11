Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94751F5833
	for <git@vger.kernel.org>; Fri, 11 Apr 2025 14:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744382523; cv=none; b=Smj7tmr3BAOBGg5Ir8AgxqJynlMD/tKE687ZCiu56HsBhC4cJtXhNqAOsCt8uvboPzUd19WwnBycfgUIqiNdS3BfyGq9a3wjRMp6BSjBcMzFzXjFGKpbL0o72rD7qvYkJlWtVBPmrgRJhADla0U2B7M8l4tjN04rSSXZgr2E2e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744382523; c=relaxed/simple;
	bh=xvmTWAtm+EwGoTjNkX19eHZqkUm3F+CwT4i38qb9Ia8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=roovTO1lpxBAvUCfjnG7Uj4aByTjC+mXQY6wzYsd/zsGKATkyc8MSx2Fpyj4xiWTIF2hQkZHF5pLxCoS/u3EjkIJLfaxZgTqsx080yiD2vm61G6045NS2f2DqVPL57YHFb5ATZ68gJFr4+XLjfQZIJw1yVXMxQM+5nQgbsivaDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kdGbbrf5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XrVVOdzf; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kdGbbrf5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XrVVOdzf"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id D1B22138024D;
	Fri, 11 Apr 2025 10:41:59 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 11 Apr 2025 10:41:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744382519; x=1744468919; bh=oA8oQtgPEs
	VOW3vXQ6ng2OsivcU0sebkoa7ZWqGNVpI=; b=kdGbbrf53wKlrigjYU3ubwQnkl
	mofCYUbiqsdeGPQ95lvBwevunsbRqvlXM20SLUFIizvYFlnkq2XaWyng4qkVjh67
	H22dflcR5+fCBi1AxTQIhZlAuB9Gb5HFAETeR7sHboLa4iOQ2j9Ep96k4z/zAydL
	vr5KHLkUGpPjjH0nHJF0nZ7EjyoPKnhoMkeRfrAhyqzFxnKLN7hqcozM2+zI7Oi5
	QRRupxsIU/DZJLbWTBq/wMHhdL7zmvLFJMH9GlXRKHIxTxuRJ7rOqrtm0zGbOCU1
	r1DKymYs7lsBoz1/za/Y7Wk3yJi+vezZ+6OmgLjwV1vElwTBBKMLnITeyomg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744382519; x=1744468919; bh=oA8oQtgPEsVOW3vXQ6ng2OsivcU0sebkoa7
	ZWqGNVpI=; b=XrVVOdzfS7lHmCRY9IemEGqyZvpTDUlhr4/ElHZuMdY/g9QJt+p
	3xyv0ZuYPQRHk8xV84og7U6iK2WVdCC8v01UQVh7UG6jUfa6mMxKm/8uxyH5moV/
	U+0RE6ZVnWRBo6zfs/kUbKepNzMaNtAyKagDLX3w6deMMb1PPHOLOLD2RZT0Suwp
	nAXg8VqHFRXrx/WgwUcbnaSauVEI4gjSQWYl7ep6ECGhahl361wBGRvdGk6p9H4f
	KNRXQYbfIv8a0WDRkOF1Yjo9FZ0eB0OA02OWZoio5fjrn5dfTd7p8B+vN8srGGx3
	Am9D8QupuxAESJvSxJx1E4hjKS3JgFeVy6g==
X-ME-Sender: <xms:Nyr5Z-LIfsqXl8o2AHzsBbxLO1gvq6blMqH8NIyWKjl2VESDOFwoQA>
    <xme:Nyr5Z2KwxJQSH-2klintprQ7Zj47MLP14oNAt53Wq3uzsNxn0c4lrT1as24wu48L9
    mY-twINDjw-UkGUtw>
X-ME-Received: <xmr:Nyr5Z-t975sD8sbKN5yapFT_G83_7XjBG6SAYaW6TWeqiabBO88rrfvsEOF0xugO5JP23G0DLoQA4FS1EnjkwoIe3q1gTEkGJ26o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvuddvtdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmheslhhfuhhrih
    hordhushdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihooh
    guuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:Nyr5ZzYrobPSxc6yAv4zoJLOlGJ9uKisnLhsXbfOH5Y_yJMbzt30zw>
    <xmx:Nyr5Z1aufS6yaycnTh0stKQWWZecad-lBX7ZYKcG1hn8HIsDfDiaNg>
    <xmx:Nyr5Z_AaU4J-XWrOauRIuaOxZ4hFOh4bkeSnlcYNRLPPwc8KEBDRvA>
    <xmx:Nyr5Z7apc4-r9sCBX3Rvt0d_Lg-K9te0zCV5NePxgkpatalo7ZtxUA>
    <xmx:Nyr5Z2BtmXlWlxQeIXL24z46sM2EkmOp-14QOyyx0jHi7ijo47s1i6Cc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Apr 2025 10:41:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Matt Hunter <m@lfurio.us>
Cc: git@vger.kernel.org,  Johannes Sixt <j6t@kdbg.org>,  Phillip Wood
 <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2] revision: fix --left/right-only use with unrelated
 histories
In-Reply-To: <20250330112850.2477673-1-m@lfurio.us> (Matt Hunter's message of
	"Sun, 30 Mar 2025 07:24:06 -0400")
References: <20250330055809.1019090-1-m@lfurio.us>
	<20250330112850.2477673-1-m@lfurio.us>
Date: Fri, 11 Apr 2025 07:41:57 -0700
Message-ID: <xmqqecxyoj4a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Matt Hunter <m@lfurio.us> writes:

> This is a similar fix as 023756f4eb (revision walker: --cherry-pick is a
> limited operation), but for the --left-only and --right-only options.
>
> When computing a symmetric difference between two unrelated histories,
> no suitable merge base exists, and so no boundary commit is flagged as
> UNINTERESTING.  Previously, we relied on the presence of such boundary
> to trigger limiting and thus consideration of either "revs->left_only"
> or "revs->right_only".
>
> A number of other entries in the option parser have started including
> overrides for "revs->limited = 1".  Do the same for these options.
>
> Signed-off-by: Matt Hunter <m@lfurio.us>
> ---

Thanks.  As far as I can see, the whole patch looks sensible,
including its rewritten tests.

Let me mark the topic for 'next'.

Thanks, all.


> Range-diff against v1:
> 1:  1982f14d70 ! 1:  4f5b264b26 revision: fix --left/right-only use with unrelated histories
>     @@ t/t6000-rev-list-misc.sh: test_expect_success 'rev-list --unpacked' '
>      +	git rev-list --left-only  HEAD...cmp >head &&
>      +	git rev-list --right-only HEAD...cmp >cmp  &&
>      +
>     -+	test $(comm -12 <(sort head) <(sort cmp) | wc -l) = "0"
>     ++	sort head >head.sorted &&
>     ++	sort cmp >cmp.sorted &&
>     ++	comm -12 head.sorted cmp.sorted >actual &&
>     ++	test_line_count = 0 actual
>      +'
>      +
>       test_done
>
> base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
>
>  revision.c               |  2 ++
>  t/t6000-rev-list-misc.sh | 15 +++++++++++++++
>  2 files changed, 17 insertions(+)
>
> diff --git a/revision.c b/revision.c
> index c4390f0938..e045445bc3 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2488,10 +2488,12 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
>  			die(_("options '%s' and '%s' cannot be used together"),
>  			    "--left-only", "--right-only/--cherry");
>  		revs->left_only = 1;
> +		revs->limited = 1;
>  	} else if (!strcmp(arg, "--right-only")) {
>  		if (revs->left_only)
>  			die(_("options '%s' and '%s' cannot be used together"), "--right-only", "--left-only");
>  		revs->right_only = 1;
> +		revs->limited = 1;
>  	} else if (!strcmp(arg, "--cherry")) {
>  		if (revs->left_only)
>  			die(_("options '%s' and '%s' cannot be used together"), "--cherry", "--left-only");
> diff --git a/t/t6000-rev-list-misc.sh b/t/t6000-rev-list-misc.sh
> index 6289a2e8b0..d338f7ecb4 100755
> --- a/t/t6000-rev-list-misc.sh
> +++ b/t/t6000-rev-list-misc.sh
> @@ -182,4 +182,19 @@ test_expect_success 'rev-list --unpacked' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'rev-list one-sided unrelated symmetric diff' '
> +	test_tick &&
> +	git commit --allow-empty -m xyz &&
> +	git branch cmp &&
> +	git rebase --force-rebase --root &&
> +
> +	git rev-list --left-only  HEAD...cmp >head &&
> +	git rev-list --right-only HEAD...cmp >cmp  &&
> +
> +	sort head >head.sorted &&
> +	sort cmp >cmp.sorted &&
> +	comm -12 head.sorted cmp.sorted >actual &&
> +	test_line_count = 0 actual
> +'
> +
>  test_done
