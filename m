Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D9579D0
	for <git@vger.kernel.org>; Tue, 13 May 2025 16:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747153865; cv=none; b=I1T9TxtEogUAKIMghTq/as8KlGMaoMwQ7YTMikY/9GNiVlovvoCMCWzv8o3HOXET89CwNKPKnw8VWR5ejHPld36g8BTZzNRFADcOWiYG/n22DrfGcNn3LY0rWQFOC6IFUdbH4ApLm/vDyLC5yHL+Fy6cLrvmSs75LR7Lcncr9Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747153865; c=relaxed/simple;
	bh=Mv9ZLAuVj0WVTq2Vql8uHwJI0uBEhy1ttdeSIqd0Cak=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HDf4bT/kpdjTrJzY5UF314+a4nXRYipEngjgpmNsLQSvI6gE58hKxf1NRq/gVPMEsGNLzg6QlIFVYt+M3debvI8MnEVcIs13nWM4tO0dF/eHYtXe6tUuzaSIC6kGOB6lSZ6EQ68ifssUlvV2vNOH6pm41jKDvGhlt4OYyW+ZY5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pODACUvv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XTujfpsD; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pODACUvv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XTujfpsD"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 576DA254015C;
	Tue, 13 May 2025 12:31:00 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Tue, 13 May 2025 12:31:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747153860; x=1747240260; bh=SdRgpO1QCp
	PjjVMtM5ZqQVN8/TkAR6/w9JzsRulDMUA=; b=pODACUvvGN+Qc4FT/cfLYiQAPL
	f52B1ry92egbPrOuJACtffZ6a569DrUyAmY3RRbSaNBSGvkFrGB0b8p+y/zUFsrT
	wQDAKHHMRbvTQS10PQfMpun8df70NKIdMCVP+Lpq670J7AdlqJYvuhSxELrdG9GJ
	W5iulHASJ/kchrwvBfjH81ScNTS9lAbzhqTgyXi1JuNlopdEHz8IwePhGCebyhwD
	rGyxG+XyuTB7tzWVVA/iKmA6f3cXaoUz+TWJtei0M5xz2EDyCU10r8feLzrk8k10
	bxGAKIKPUrj8IpqemVepr3BKQM5HB+l4GvnU8VXahSvPoo+01DGzg1pseWxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747153860; x=1747240260; bh=SdRgpO1QCpPjjVMtM5ZqQVN8/TkAR6/w9Jz
	sRulDMUA=; b=XTujfpsD4DQb6I24YOe8VN6+OVURX/kv8JChvVDVRImugRJvSvR
	R2+rK+pzLG/w1aCtxesgPQzUZcBeKnjWDd0nVNsXxSXES4AEYAMfewDkvUWIzr3J
	zNAa/0kuBgUuYbG2XFlEQ2v0kErs5cMtCKudBJBleeKmLBLMo7jmF1FNltQimwoY
	TdZIqsa0CInsinpILrRwxtUqamAPuCi2HDtW4/px6axaBxWPagTeGAPOR40r2hnD
	qblq83jtyXFCUXRqGiEw5aadDvWWLDhl9wVe7UF1gbbVdEfhJTXTeTlU+/0TKMSW
	0/WD6p8lwHv4fw6NkFxRWxb5YTPUsSjMgog==
X-ME-Sender: <xms:w3MjaNBuJdd1JSRoluCz08vCcRiotpRFejDIv8aILZyWhma-YYEkWA>
    <xme:w3MjaLgqNQzO5T9_pfKOuUxwLpKYZinX6DEVCpunQrFEc0RLRDN3tDk-ghGAM5U1N
    O9Co1llqG1nSSYz0g>
X-ME-Received: <xmr:w3MjaInYBODJxaBRPfryIi6xvGDpUqXShdOy-qIhu-TuvsOQG_ml_LAo-vYvZh4to-T0YrJxt-JVlFc1M-Y9fPs8u7BSGRqYcysDuDM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdegiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhhvghjihgrlh
    huohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehpsh
    esphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:w3MjaHy0ym0HFjmnSioy-vpi0nYICS_bMEyfcQ63Kl3YlAdAy9et6Q>
    <xmx:w3MjaCQFCgSnZGjZ_1xZAKct6nE_YJfGeqecvkKIdWQMhIgItQO3AQ>
    <xmx:w3MjaKYk-S6GRxCSc4jMZrS9MzeSJflh3dYO0QENX27MAmTDG4GRWA>
    <xmx:w3MjaDRQpwaoiQrEa_OcpCcHmR-McRrMB0jzboyVrjtgLVRX6LofZw>
    <xmx:xHMjaHupmXstde4nC2eWVVpE_G7BBIK_2dgp7kZ_whbQ9B8wqbLznvvB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 May 2025 12:30:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH v4 1/3] packed-backend: fsck should warn when
 "packed-refs" file is empty
In-Reply-To: <aCMn_Ktrg4GY8jHe@ArchLinux> (shejialuo@gmail.com's message of
	"Tue, 13 May 2025 19:07:40 +0800")
References: <aCMnrwkoJ2WyqGZT@ArchLinux> <aCMn_Ktrg4GY8jHe@ArchLinux>
Date: Tue, 13 May 2025 09:30:57 -0700
Message-ID: <xmqqplgch3r2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

shejialuo <shejialuo@gmail.com> writes:

> During fsck, an empty "packed-refs" gives an error; this is unwarranted.
> The runtime code paths would accept an empty "packed-refs" file, such as
> "create_snapshot" would simply return the "snapshot" without checking
> the content of "packed-refs".

Perhaps "unwarranted" is now too strong a word; we still want to
consider it an anomaly (that is why emptyPackedRefsFile warning is
introduced after all). I think the problem description you want to
here in the above pragraph is that fsck giving an error and runtime
completely silent is inconsistent.  

    Side note: and you'd probably want to say what "an error"
    reported here is.  The problem, if I understand correctly, is
    that the code assumes the file won't be empty and instead has at
    least one line in it (even when there are no refs packed, there
    is the file header line) and insists that all lines must be well
    terminated---if we tolerate an empty file, of course such a
    check will fail, as there is no terminating LF in a file with 0
    lines in it.

And because versions of Git that are not too ancient never wrote an
empty packed-refs file, and often having an empty file there is/was
a sign of a filesystem-level issue, the way we want resolve this
inconsistency is not make everybody totally silent but notice and
report the anomaly.

> But we need to consider the fsck message type carefully, it is not
> appropriate that we use "FSCK_ERROR". This is because we would
> definitely break the compatibility. Let's create a "FSCK_INFO" message
> id EMPTY_PACKED_REFS_FILE" to indicate that "packed-refs" is empty.

OK.

> Signed-off-by: shejialuo <shejialuo@gmail.com>
> ---
>  Documentation/fsck-msgids.adoc |  6 ++++++
>  fsck.h                         |  1 +
>  refs/packed-backend.c          |  9 +++++++++
>  t/t0602-reffiles-fsck.sh       | 17 +++++++++++++++++
>  4 files changed, 33 insertions(+)
>
> diff --git a/Documentation/fsck-msgids.adoc b/Documentation/fsck-msgids.adoc
> index 9601fff228..0ba4f9a27e 100644
> --- a/Documentation/fsck-msgids.adoc
> +++ b/Documentation/fsck-msgids.adoc
> @@ -59,6 +59,12 @@
>  `emptyName`::
>  	(WARN) A path contains an empty name.
>  
> +`emptyPackedRefsFile`::
> +	(INFO) "packed-refs" file is empty. Report to the
> +	git@vger.kernel.org mailing list if you see this error. As only
> +	very early versions of Git would create such an empty
> +	"packed_refs" file, we might tighten this rule in the future.

I am not too happy to see "Report to ..." and everything after that
here, primarily because it takes one extra step for the user to find
it out when they see such an informational message.  There are other
existing error classes, like refMissingNewline, etc., that have the
same problem.  One thing to make it easier for the users to report
is to put it in the error/info messages themselves, but I think it
is OK to make such a clean-up (including the existing offenders)
after the dust settles from this topic.

> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index 3ad1ed0787..fb91833e76 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -2103,6 +2103,15 @@ static int packed_fsck(struct ref_store *ref_store,
>  		goto cleanup;
>  	}
>  
> +	if (!st.st_size) {
> +		struct fsck_ref_report report = { 0 };
> +		report.path = "packed-refs";
> +		ret = fsck_report_ref(o, &report,
> +				      FSCK_MSG_EMPTY_PACKED_REFS_FILE,
> +				      "file is empty");
> +		goto cleanup;
> +	}

OK.

> diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
> index 9d1dc2144c..f671ac4d3a 100755
> --- a/t/t0602-reffiles-fsck.sh
> +++ b/t/t0602-reffiles-fsck.sh
> @@ -647,6 +647,23 @@ test_expect_success SYMLINKS 'the filetype of packed-refs should be checked' '
>  	)
>  '
>  
> +test_expect_success 'empty packed-refs should be reported' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit default &&
> +
> +		>.git/packed-refs &&
> +		git refs verify 2>err &&
> +		cat >expect <<-EOF &&
> +		warning: packed-refs: emptyPackedRefsFile: file is empty
> +		EOF
> +		rm .git/packed-refs &&
> +		test_cmp expect err
> +	)
> +'
> +
>  test_expect_success 'packed-refs header should be checked' '
>  	test_when_finished "rm -rf repo" &&
>  	git init repo &&
