Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F99176259
	for <git@vger.kernel.org>; Wed, 28 Aug 2024 12:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724849415; cv=none; b=O1VyshuFer3kI2T4JuSJ5KNNON6R0d0YmegNf3tWsS9ndNixRlTx3STz02Cb2HCYwiqEkWtqiWUxvjlJOUB6ABWByu5KVAKHDlG0RWxNM1AvYk5Nrpa0B6KBXGn338zCh5WVojddN2O5sI8+ovvnpgk5tm0hgdR01iUHSh3thcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724849415; c=relaxed/simple;
	bh=YOK7L51hQGjE2aMIQgllC9PRjQdmPWZULfA58uamFuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8NuCWc7qlFxxfKSTuCkhDL1Ize6NEROKhd++/zwKsuOl0qW09knVu19IBOJQuh2G18JXJR48HW5NudtpK/a/lZpLoKliys49uqa5iJzWDQjY80j5xrZ6fyxLbUy55SOz4XxuTIy6rwr7BfEpEnB/cTgZJ11qxPKmO8xzwLZsm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BXIMpjnh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i9i/+XyB; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BXIMpjnh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i9i/+XyB"
Received: from phl-compute-07.internal (phl-compute-07.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id B354013900B7;
	Wed, 28 Aug 2024 08:50:12 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 28 Aug 2024 08:50:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724849412; x=1724935812; bh=NrAG54M6E/
	g/lLkCAcE8dp5cVDD56RUswdrF5uTR9lw=; b=BXIMpjnh57Q9bqb2wtBD+KpOwu
	mawuJPDkk8KRI4zPrhw+LK+jkBgyHf1pPD5ZICh4Xu3+YhR3vMF0ZbKCLlzy1iE8
	cQywccwESuDjq5g8RGGRF8HzvxZMllpe+6oa65wvGiatojTEoNi9gB7W+Cd1G8AD
	TLuyNOEiiowbNmCIBbGd50X3Rpqm4H59NW40kNxMg4BOrhR5iOJrdgNZZiJhlC3t
	jk2wVeBKqp7Rf3e8Wa/Zfgb/qYZPbiPXqgwViWBfscaPhQ8KKHHPy+j0j3kuzNNb
	VQUQaX72/2rUd874+ryw3kl3XD9fm8ewlwYYrMELriXU4q0Jl9pRazlE1rbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724849412; x=1724935812; bh=NrAG54M6E/g/lLkCAcE8dp5cVDD5
	6RUswdrF5uTR9lw=; b=i9i/+XyB6snFxsgcApS8/K+WAy5fGXTNwD6LkpLUEV+h
	NGN0N7Ei5FWkUSUcCP2p8tAP2rN8HbtoymIhpThn9x5DWWkdkj1nPr6TOyXuVfWY
	OpuKH+r77v14htVqczXH8KY5yCl8XPrdGaBbEFBvDwT+VlkQ58Op7OjyT7YkW0IA
	J2IafsWrOARbFbsgT02BexlYTCRfDSLzG18fThZYRkQDQQVTxUng7xD1EQDrb9nb
	imDa8SVSnZ4eCZDGYa2CNzRmjhSTmnHDE4OeZTVhwpKuvvgCJQkxm0228innkMba
	FtCLMDN5JXP5G62BTFQf65PxUdo3r7FgIzD+iwx1Zw==
X-ME-Sender: <xms:BB3PZmFaWpTp3exo5lhsjFCuyVKQqE1HQuaCko4LHu83CxHi4h4qJQ>
    <xme:BB3PZnW9DQ9Brm7iiwljGJWlBfWQy2iKTdI1nCoplD_chX6VkcQHsZJcsNCocMXqQ
    IHzDEaBstzR0btqMA>
X-ME-Received: <xmr:BB3PZgIhTdZq5DiYJCX8KcwDuQDHlZi3LDCBB9jKvHqhdyHCBUjWFEF8ExpOrm6dgEhaL4ASv5irOx3SXCo0jCv3YEibxrrYY9mTGFnbo7ugs5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefvddgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprh
    gtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:BB3PZgFGOvnEraOtKw2HZ-NKMNgQMEvbr0W9vJgCgX_mE0w8zCIigA>
    <xmx:BB3PZsV45Btd-WLSuYIGntv01oKnrIfvCpuUC3q1rr3dHAQycldq0g>
    <xmx:BB3PZjMGS9G-ZzvMws_8GODSvrYSo2C3CjspoRngWKp0CzICEoK4jQ>
    <xmx:BB3PZj0HJeh6uEpiGpEj7l-Yz7ChMLmbgakq3d3tiho737Vax819FQ>
    <xmx:BB3PZqxgBzCvzljTPkRDaFJxTrTGS5FKITrRp-1r7_xG2DyIYv7grUIR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Aug 2024 08:50:11 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8982647c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 28 Aug 2024 12:50:04 +0000 (UTC)
Date: Wed, 28 Aug 2024 14:50:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/4] ref: add symbolic ref content check for files
 backend
Message-ID: <Zs8dAc0ss9KbwIDs@tanuki>
References: <Zs348uXMBdCuwF-2@ArchLinux>
 <Zs3558scHssaG_XS@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs3558scHssaG_XS@ArchLinux>

On Wed, Aug 28, 2024 at 12:08:07AM +0800, shejialuo wrote:
> We have already introduced the checks for regular refs. There is no need
> to check the consistency of the target which the symbolic ref points to.
> Instead, we just check the content of the symbolic ref itself.
> 
> In order to check the content of the symbolic ref, create a function
> "files_fsck_symref_target". It will first check whether the "pointee" is
> under the "refs/" directory and then we will check the "pointee" itself.
> 
> There is no specification about the content of the symbolic ref.
> Although we do write "ref: %s\n" to create a symbolic ref by using
> "git-symbolic-ref(1)" command. However, this is not mandatory. We still
> accept symbolic refs with null trailing garbage. Put it more specific,
> the following are correct:
> 
> 1. "ref: refs/heads/master   "
> 2. "ref: refs/heads/master   \n  \n"
> 3. "ref: refs/heads/master\n\n"

Now that we're talking about tightening the rules for direct refs, I
wonder whether we'd also want to apply the same rules to symrefs.
Namely, when there is trailing whitespace we should generate an
INFO-level message about that, too. This is mostly for the sake of
consistency.

[snip]
> diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
> index fc074fc571..85fd058c81 100644
> --- a/Documentation/fsck-msgids.txt
> +++ b/Documentation/fsck-msgids.txt
> @@ -28,6 +28,9 @@
>  `badRefName`::
>  	(ERROR) A ref has an invalid format.
>  
> +`badSymrefPointee`::
> +	(ERROR) The pointee of a symref is bad.

I think we'd want to clarify what "bad" is supposed to mean. Like, is a
missing symref pointee bad? If this is about the format of the pointee's
name, we might want to call this "badSymrefPointeeName".

Also, I think we don't typically call the value of a symbolic ref
"pointee", but "target". Searching for "pointee" in our codebase only
gives a single hit, and that one is not related to symbolic refs.

> diff --git a/fsck.h b/fsck.h
> index b85072df57..cbe837f84c 100644
> --- a/fsck.h
> +++ b/fsck.h
> @@ -34,6 +34,7 @@ enum fsck_msg_type {
>  	FUNC(BAD_REF_CONTENT, ERROR) \
>  	FUNC(BAD_REF_FILETYPE, ERROR) \
>  	FUNC(BAD_REF_NAME, ERROR) \
> +	FUNC(BAD_SYMREF_POINTEE, ERROR) \
>  	FUNC(BAD_TIMEZONE, ERROR) \
>  	FUNC(BAD_TREE, ERROR) \
>  	FUNC(BAD_TREE_SHA1, ERROR) \
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 69c00073eb..382c73fcf7 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -3434,11 +3434,81 @@ typedef int (*files_fsck_refs_fn)(struct ref_store *ref_store,
>  				  const char *refs_check_dir,
>  				  struct dir_iterator *iter);
>  
> +/*
> + * Check the symref "pointee_name" and "pointee_path". The caller should
> + * make sure that "pointee_path" is absolute. For symbolic ref, "pointee_name"
> + * would be the content after "refs:".
> + */
> +static int files_fsck_symref_target(struct fsck_options *o,
> +				    struct fsck_ref_report *report,
> +				    const char *refname,
> +				    struct strbuf *pointee_name,
> +				    struct strbuf *pointee_path)
> +{
> +	const char *newline_pos = NULL;
> +	const char *p = NULL;
> +	struct stat st;
> +	int ret = 0;
> +
> +	if (!skip_prefix(pointee_name->buf, "refs/", &p)) {
> +
> +		ret = fsck_report_ref(o, report,
> +				      FSCK_MSG_BAD_SYMREF_POINTEE,
> +				      "points to ref outside the refs directory");
> +		goto out;
> +	}
> +
> +	newline_pos = strrchr(p, '\n');
> +	if (!newline_pos || *(newline_pos + 1)) {
> +		ret = fsck_report_ref(o, report,
> +				      FSCK_MSG_REF_MISSING_NEWLINE,
> +				      "missing newline");
> +	}

The second condition `*(newline_pos + 1)` checks whether there is any
data after the newline, doesn't it? That indicates a different kind of
error than "missing newline", namely that there is trailing garbage. I
guess we'd want to report a separate info-level message for this.

Also, shouldn't we use `strchr` instead of `strrchr()`? Otherwise, we're
only checking for trailing garbage after the _last_ newline, not after
the first one.

> +	if (check_refname_format(pointee_name->buf, 0)) {
> +		/*
> +		 * When containing null-garbage, "check_refname_format" will
> +		 * fail, we should trim the "pointee" to check again.
> +		 */
> +		strbuf_rtrim(pointee_name);
> +		if (!check_refname_format(pointee_name->buf, 0)) {
> +			ret = fsck_report_ref(o, report,
> +					      FSCK_MSG_TRAILING_REF_CONTENT,
> +					      "trailing null-garbage");
> +			goto out;
> +		}

Ah, I didn't get at first that we're doing the check a second time here.
As mentioned above, I think we should check for trailing garbage further
up already and more explicitly.

> diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
> index 7c1910d784..69280795ca 100755
> --- a/t/t0602-reffiles-fsck.sh
> +++ b/t/t0602-reffiles-fsck.sh
> @@ -176,4 +176,58 @@ test_expect_success 'regular ref content should be checked' '
>  	test_cmp expect err
>  '
>  
> +test_expect_success 'symbolic ref content should be checked' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	branch_dir_prefix=.git/refs/heads &&
> +	tag_dir_prefix=.git/refs/tags &&
> +	cd repo &&
> +	git commit --allow-empty -m initial &&
> +	git checkout -b branch-1 &&
> +	git tag tag-1 &&
> +	git checkout -b a/b/branch-2 &&
> +
> +	printf "ref: refs/heads/branch" > $branch_dir_prefix/branch-1-no-newline &&
> +	git refs verify 2>err &&
> +	cat >expect <<-EOF &&
> +	warning: refs/heads/branch-1-no-newline: refMissingNewline: missing newline
> +	EOF
> +	rm $branch_dir_prefix/branch-1-no-newline &&
> +	test_cmp expect err &&

Same comments here as in the preceding patch for the tests.

Patrick
