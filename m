Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AB34219FD
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 16:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772468969; cv=none; b=Y5zFjwcQANvNeOJlafes3Rw83CM/lDAoxGAEe2KF3jQzM9Ae9Y4IIsUp6nsC6ICCUWL2IMeg1GWs6wJd9BlOxEk/DQf8CzrvDQLtThi21yIJtm5uI8bvKZE1e2YBoFqHK26fo5C9pDKSIWWiafcnkPiaE+eFLFFw0cGhiP2c3ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772468969; c=relaxed/simple;
	bh=fi33ezKtPeaN3kKejxXURJBLeNcE8sXVi9tNkyzshQQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OEdvsQyE0ak/8w6enRiEWcIrN+Nmu1X0mC7q9XB7UPosNjh3HI+XMAeJs3XxO5g5slpA0kpPn8GZ9O/3AgWdR2t2wOAKPOUuNBne7YpbyoomLFkIrKBkRu3u9oZzB/c8Q9VazAfE4zuU/aqc5Uq69ljl63GeaAL64f8BLH8xZ9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jRDXHukR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XoRY7C/+; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jRDXHukR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XoRY7C/+"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 157391D001DF;
	Mon,  2 Mar 2026 11:29:27 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 02 Mar 2026 11:29:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772468966; x=1772555366; bh=6dwQmGXNHk
	raUoWM1sx/qEVO7RZOjFkLobE1OfOM9qU=; b=jRDXHukROBdpMp+t3vvMCboFZj
	Ka4vHvOkxFm0KxjfV/hysL5eQ6vJD4pyCceMv9c3J4vcAEiT//0985cMSEw7eYEW
	3osQPcnFt8OcmLQETs7LnvRL2uQdHE5HI69LUCCnFVPX6AYTrb5LhwuvuWhqRQxS
	Tobq+uCZ/dWYAuBtN2boChfDLDwWZwf3ePqP0HSTHIj/1rupnxPXT6YBlT7EvaVn
	zisdZgq+xOm4e5du9a2Sef5ocmfjcXFa9Z+Hl6yeeLXB5OI2+AZGK9i590JZSIkS
	qM3pr0qYkZk4mVBKJY+TX3qVnj0PgJ28UT7C1fLjm5i1EiSbsUsJNDkEYLDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772468966; x=1772555366; bh=6dwQmGXNHkraUoWM1sx/qEVO7RZOjFkLobE
	1OfOM9qU=; b=XoRY7C/+RzZBSGo6xceBdhjdt3Iwei6hg1zARl2w43YgZFbctW6
	Z1z9lfsErhTnh/xlKVh088FevU57/Ln6yRDbxNm48R49VqMNkk6KTUr9eaMHA4Tx
	tqjPBoyhlvI00hVQQNRXHF0z5WP5GrgNOckHTtWu1P5MLUjcWeWuM5yotJxp6PaJ
	vq3bBz3SFI5ddGweAFv4AJsQPa+sywXQt9QVaq3B72edk2n1bIsXhYBrj1Mridkc
	aee8pm4tmf1/pICFGPeAFDm3rEmjRqaOudYhkazFVOx7esIknN7iYz+vyBlgP1bH
	wZUHPjdoA4i+yemdSYTKNZTVNvNq3OSyryg==
X-ME-Sender: <xms:5rqlac-PtvPXlaGuXNvgS7tfoNS-cWRhzf-F1c-l1giW-u0sD8h5ug>
    <xme:5rqlabv18UEdKqhVxD3n3-_XycZ1Y4tuXjBWyMJuSsvl9bB1G2GcmpA7uKGhRr1wp
    yPYe9EYIiSjFkkQg4w9rjoj8FG-l5BcqQEud4yq3ORCM8BA0J5E21M>
X-ME-Received: <xmr:5rqlaXCwGZcm1XaQkKaNqEXvk4ovxBPphN6uYPBzoLhgJMLF9W81NG2fSLwE2wW2Q-p0BYPb-NV0UuBkPYWoJXUND-v4CGcAdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheekudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhmohhnthgrlhgsohesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:5rqlabXN1ArpcE5UFXYIChvCpofZImLtz-Equ85q6imPMfyGMQYSFg>
    <xmx:5rqladBpiRPuW_VOS4HU-C0JnTDpqlVIuaMHfNlLgS3PCrH5AUZMNw>
    <xmx:5rqlaW876QBctwg49jP_z_CMq89q4J3HwOvtI2VmknyqBUiyujhHKQ>
    <xmx:5rqlacEb84L_pTkq7tgAJA0yKnPsXomnhS3tEhrgQ5xY-tnaWp5qkA>
    <xmx:5rqlaajCI1oaNbgAwd_2ctxTO8uQdVkInDV6IyGV_yJzyqY3kci9RJ4C>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 11:29:26 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Michael Montalbo <mmontalbo@gmail.com>
Subject: Re: [PATCH] diff: fix crash with --find-object outside repository
In-Reply-To: <pull.2057.git.1772310676438.gitgitgadget@gmail.com> (Michael
	Montalbo via GitGitGadget's message of "Sat, 28 Feb 2026 20:31:16
	+0000")
References: <pull.2057.git.1772310676438.gitgitgadget@gmail.com>
Date: Mon, 02 Mar 2026 08:29:25 -0800
Message-ID: <xmqqfr6i42l6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Michael Montalbo <mmontalbo@gmail.com>
>
> When "git diff --find-object=<oid>" is run outside a git repository,
> the option parsing callback eagerly resolves the OID via
> repo_get_oid(), which reaches get_main_ref_store() and hits a BUG()
> assertion because no repository has been set up.
>
> Check startup_info->have_repository before attempting to resolve the
> OID, and return a user-friendly error instead.
>
> Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
> ---
>     diff: fix crash with --find-object outside repository
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2057%2Fmmontalbo%2Ffix-find-object-crash-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2057/mmontalbo/fix-find-object-crash-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/2057
>
>  diff.c                   |  2 ++
>  t/t4053-diff-no-index.sh | 10 ++++++++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/diff.c b/diff.c
> index a68ddd2168..8f0f141be7 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -5215,6 +5215,8 @@ static int diff_opt_find_object(const struct option *option,
>  	struct object_id oid;
>  
>  	BUG_ON_OPT_NEG(unset);
> +	if (!startup_info->have_repository)
> +		return error(_("--find-object requires a git repository"));
>  	if (repo_get_oid(the_repository, arg, &oid))
>  		return error(_("unable to resolve '%s'"), arg);

Makes sense.

> diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
> index 69599279e9..15076dfe0d 100755
> --- a/t/t4053-diff-no-index.sh
> +++ b/t/t4053-diff-no-index.sh
> @@ -76,6 +76,16 @@ test_expect_success 'git diff --no-index executed outside repo gives correct err
>  	)
>  '
>  
> +test_expect_success 'git diff --find-object outside repo fails gracefully' '
> +	(
> +		GIT_CEILING_DIRECTORIES=$TRASH_DIRECTORY/non &&
> +		export GIT_CEILING_DIRECTORIES &&
> +		cd non/git &&
> +		test_must_fail git diff --find-object=abc123 2>err &&
> +		test_grep "find-object requires a git repository" err
> +	)
> +'

Looks good, too.

Will queue.  Thanks.



>  test_expect_success 'diff D F and diff F D' '
>  	(
>  		cd repo &&
>
> base-commit: 67ad42147a7acc2af6074753ebd03d904476118f
