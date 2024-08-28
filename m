Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A4E15ADBC
	for <git@vger.kernel.org>; Wed, 28 Aug 2024 12:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724849409; cv=none; b=GSt/vejKmhaoQtB/V85gyByNxIskDG/PQpIusF1ZmpjRzJvBQTMx9fOv37XiT/l9ISAQXJ0rkTdUrciA7wKyo0iUYYG6INNDRiHU+e5T9AA+/21v4z/pgdJjfkfoq0aTsKd7kMTsyNbfLhTbDCh9gRsE5MQH7HpsKDvGseiGmxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724849409; c=relaxed/simple;
	bh=+3J4zfaadynbAlgB4MesTOmIUw1rLMmdPcGrCquclR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXLyU05jTQITDQwD2XKESFD91sGRhpgI4s9Fflbo1Q1pPkrbIJ5+0ZPS3UuNsenZe6FJaSfom8L+uDtlpnnBIbCmP6maKDSW90GOuH1nygPwd3FOL8RAeP9JCY63RQQYDim5Eo9DlglVsbzGgqBA+EqfVsdmz4ehZSrRQIxYgm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Yh57SsW7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fI1fS2IR; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Yh57SsW7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fI1fS2IR"
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 18EC0138FF84;
	Wed, 28 Aug 2024 08:50:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 28 Aug 2024 08:50:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724849406; x=1724935806; bh=x5JK8igfMy
	xoWMjwkYHV7nGy6l2gVXj5xX/S3Va0SQQ=; b=Yh57SsW7ecdnd7j2bUsc/Zhytf
	rKC649HyhR/pr+UvTQb7mxlTi4EwqSNfMNRT221L0GQBc+Jhzd1h4IBRBHJvGrRH
	IKNSMpnDEO8oIeG8E4WjLTgg8QciacPJmpvxIDoW/Q/tABkN/rAOp9YsuZoq6k1M
	Mos3aOcRcFt4EvU3suJHFiy739mr+/lDxqTGr+B/Vr+CorCifHCiJuxrXcWoTW6W
	w+qPgMT36PN5kjW/1wLLNHjz/m2Cs2SZeCXXp3WNdRKPsED468jrHG0GtMbLoXF0
	ZsJIafrmwo84UTcqwBEMDLwp+GcUWGBxRIV2e4f2VGKnK/RnA7rI7k93ZA5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724849406; x=1724935806; bh=x5JK8igfMyxoWMjwkYHV7nGy6l2g
	VXj5xX/S3Va0SQQ=; b=fI1fS2IRpDo+wkmbmV6rqhU67+l4sF9WP3fUJefRyoaT
	pZ2SyRiD3dmYOdb9h4QuJLOvA2WLDMIJ/o98E/mruQK5yaakkQffbiZ8Pd+0fAiC
	52SAQDqHbB5ZIlntg+u3RS0p43rAVhkov1ZH3gEEs3i0LhCE4X2YecSvOIu/GjZv
	r1mvAXpwQg6N4UH5TYlClO5f7MrTk+HTvuQ5ZzfR6x2/XYfRfWK3grQ01Hcu3Ap6
	HLZRm+N6BZXD3034rlWshUT2NvVx/IRCERqRAQ0g2/6jo43Fa1CthTHFy+AER2to
	JWgA5z876jccqWhMRqfcF8zk4aj7s2iG62py9uCQ1w==
X-ME-Sender: <xms:_RzPZjRRCCATFET4B8pYH1xP5AZDJ70oE_9jyhKnAOcyUElHgK-gzQ>
    <xme:_RzPZkxnZVhLWC60pVJ4-YQ9Bp6GUrOhddQNvkssSIQ0LSb0QUXU2OUxdux9Ra4MY
    BmD01gMX3onBAPd6A>
X-ME-Received: <xmr:_RzPZo2ba9cn_fDJU17c6mjWkV7tGdh2DSbwHcPhlqd1SBhaOejoaXLFW6Gpn9mDvVwkH48M-d2w0RrlfW4LvJVm-yiWbJl3cPmX8Sg-g5Gd2dQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefvddgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprh
    gtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:_RzPZjBVcVdXFRZ-h_u7XzNoAvPv4kIFmR-vCmuDpjPiuOA7avi9SA>
    <xmx:_RzPZsgpTnL4MPtDcdNj9Qd0I_el_30R0T5DBf_z9YnOoxEH9Hz10g>
    <xmx:_RzPZnoWGFrDuGRANaj2DcVn035RqllhT-aSC5CDPq5ggXBMp2kf2Q>
    <xmx:_RzPZni_iPfcUahI77FUG-2e9W0barlm40SuvwdFOjfkqmDwZXI4bg>
    <xmx:_hzPZkfF1WDm8VycYgqQMq2xokv9NK4EBA5FX85-GyqnYgoaAN_TFq5P>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Aug 2024 08:50:04 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6ac5956b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 28 Aug 2024 12:49:56 +0000 (UTC)
Date: Wed, 28 Aug 2024 14:50:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/4] ref: add regular ref content check for files
 backend
Message-ID: <Zs8c81Z-zb4uQpp6@tanuki>
References: <Zs348uXMBdCuwF-2@ArchLinux>
 <Zs353oLDaw2SbNQs@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs353oLDaw2SbNQs@ArchLinux>

On Wed, Aug 28, 2024 at 12:07:58AM +0800, shejialuo wrote:
> @@ -170,6 +173,12 @@
>  `nullSha1`::
>  	(WARN) Tree contains entries pointing to a null sha1.
>  
> +`refMissingNewline`::
> +	(INFO) A valid ref does not end with newline.

This reads a bit funny to me. If the ref is valid, why do we complain?

Maybe this would read better if you said "An otherwise valid ref does
not end with a newline".

> @@ -3430,6 +3434,65 @@ typedef int (*files_fsck_refs_fn)(struct ref_store *ref_store,
>  				  const char *refs_check_dir,
>  				  struct dir_iterator *iter);
>  
> +static int files_fsck_refs_content(struct ref_store *ref_store,
> +				   struct fsck_options *o,
> +				   const char *refs_check_dir,
> +				   struct dir_iterator *iter)
> +{
> +	struct strbuf ref_content = STRBUF_INIT;
> +	struct strbuf referent = STRBUF_INIT;
> +	struct strbuf refname = STRBUF_INIT;
> +	struct fsck_ref_report report = {0};
> +	const char *trailing = NULL;
> +	unsigned int type = 0;
> +	int failure_errno = 0;
> +	struct object_id oid;
> +	int ret = 0;
> +
> +	strbuf_addf(&refname, "%s/%s", refs_check_dir, iter->relative_path);
> +	report.path = refname.buf;
> +
> +	if (S_ISREG(iter->st.st_mode)) {

This is still indenting the whole body. You mentioned that you don't
want to use `goto`, but in our codebase it's actually quite idiomatic.
And you already use it anyway.

> diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
> index 71a4d1a5ae..7c1910d784 100755
> --- a/t/t0602-reffiles-fsck.sh
> +++ b/t/t0602-reffiles-fsck.sh
> @@ -89,4 +89,91 @@ test_expect_success 'ref name check should be adapted into fsck messages' '
>  	test_must_be_empty err
>  '
>  
> +test_expect_success 'regular ref content should be checked' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	branch_dir_prefix=.git/refs/heads &&
> +	tag_dir_prefix=.git/refs/tags &&
> +	cd repo &&
> +	git commit --allow-empty -m initial &&
> +	git checkout -b branch-1 &&
> +	git tag tag-1 &&
> +	git commit --allow-empty -m second &&
> +	git checkout -b branch-2 &&
> +	git tag tag-2 &&
> +	git checkout -b a/b/tag-2 &&

Wouldn't it be sufficient to only create a single commit, e.g. via
`test_commit`? From all I can see all you need is some object ID, so
creating the tags and second commit doesn't seem to be necessary.

> +	printf "%s" "$(git rev-parse branch-1)" > $branch_dir_prefix/branch-1-no-newline &&

We don't typically have spaces after the redirect. So you should remove
them here and in all the subsequent instances.

> +	git refs verify 2>err &&
> +	cat >expect <<-EOF &&
> +	warning: refs/heads/branch-1-no-newline: refMissingNewline: missing newline
> +	EOF
> +	rm $branch_dir_prefix/branch-1-no-newline &&
> +	test_cmp expect err &&

I was wondering whether each of these cases should be a separate test,
but that may be a bit wasteful. Alternatively, can we maybe set up a
single repository with all the garbage that we want to verify and then
double check that executing `git refs verify` surfaces them all in a
single invocation?

Patrick
