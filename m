Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8742417C8B
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 15:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725894256; cv=none; b=otA8podDgcvpyInYUysKbM+P1SrQZyIM1MVFOWAwSnsSvsTSMnjjDPOUvlcKJLuLcA2l89smENv7Mz07FrFFt2z8xARG4wj4GNtNtoEt7hgQ6zRZHkJDG1WD9O4MWq1SErOU8333T8NdvUhKoV9RJpEH8eIXZYR2bXihnueF9Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725894256; c=relaxed/simple;
	bh=iE7uIalGhETTnWiNqZeXiNaIU+4GOuDMpKQ2gswZ3ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9DpRTSRPv3pjOEaK687I16EFxokVcEv8vfSZiKkeUxkUW84gXC+iII15MldZmwW+F1nUYiALmBe8B05dEUbCWHOmt64hPiQPh7Wq9uPRvulS2iDSDM753V7uUT+be+I5nW9MZ7i2g9TNyA8PxGZKYk9mQGWtWy6VtDNmIyJxdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=avn1hJPB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JFphVrcn; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="avn1hJPB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JFphVrcn"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 7745E1380238;
	Mon,  9 Sep 2024 11:04:13 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 09 Sep 2024 11:04:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725894253; x=1725980653; bh=CF22VDkaqR
	uU5Q+Tyxtim5giAlfifXUUc9VeCHKkRbU=; b=avn1hJPBxQLQsemKSf6URhxI+G
	Ql5ASSdX+J3ljxrR51RNlKWOwji/315hMBhDOuzML7zHEswTE8mx/8/9nuBTiBx6
	9sa7ImgozAY+2lfsPd50HH5NJvlYF8SPhG2koxNAGtPtkZmkcrHAt1xUNiaJ738V
	pw4OKdZZvmtxSaBxp8OolRkXElx8tKlS21RVTJrwPSMFiZfbg1CKM1LVJMjNFGHA
	d/C7eBMn2CJWFj9ueGeo/9lcI+5mDfTecf/XoGIHIrca/GxKhSKhyGVZ15Z8+Dxn
	lo2b1bfMan/TjXuhNkUK2JRtMWqwhPSsDLcB2LuLIjlU/MKtDfmC6kVc7rDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725894253; x=1725980653; bh=CF22VDkaqRuU5Q+Tyxtim5giAlfi
	fXUUc9VeCHKkRbU=; b=JFphVrcn3zvPXUb4/l8Rx4fJarCtfHXy0o9cuRAxdy4S
	T+uKoCm63kOkQSMdB598duZSARHxJsHlfCXc/wkCXwoCnju7DxXft+ISxfgl8ZXd
	+dkxFd0tU/xtp8dqMRsgiLlIE43Ap/tsjdmgZUKk4hlh0zl3ZpAsOy4X/NWKWhdn
	TiT1NT+534mMGXSqCb0znsoSAkveirtGybaMySjef31I8iOaBeGBwYW8YljtUOLQ
	Jg/DtjhY0KU1VI17CxjOxZkU/etJxooYLXtbZkWVFADEiymvNmOixSIENgk03low
	XxnomzFs1CvMTYxr08+g8dpZU44eqi+/gFLFDezOuA==
X-ME-Sender: <xms:bQ7fZg6LpbyVLZcpdoIQtZC_0veXnP3CBktbGo6gctHHBysF3nqTfw>
    <xme:bQ7fZh7lSKoNpyaQF2qw-zW-tD5J7gLxjkBICdVC2IEEDPcxI1YthQQ5nZGRqTmAA
    S2gBRtY8Q1A9Vkirg>
X-ME-Received: <xmr:bQ7fZvfZ6jE2VFmhnlPLFC0wQv2gGE7gH_v-LFHwq_iGbwq4Bu-ic5Ps-lofrSj6pg96eUnK_f0fnJs0MSrVRL1UGglMQ_9tgTGOY1TDVRE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeijedgieekucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:bQ7fZlIkaqeMvR3pfQCFs3i_KbpTgk1CXqG_Kv5Zth0Q_QuMdfKVVw>
    <xmx:bQ7fZkLnrni1sPGsWQXJlPH26FSbrS-iS0vyiSgfxNL77uMRpirO3Q>
    <xmx:bQ7fZmxf_HOwExBkBpkabPg_7N5SXz6wVjYOBw_Nr4yG8MLhv37Ytw>
    <xmx:bQ7fZoI6XTK84C8VyV9_MVxHusTaFqMWT6MS0XYPLbx0tpApUaBq-Q>
    <xmx:bQ7fZpHXFu1xcv7rP43SEKDQvnlwcGYdH1SnphiI6mXg3ibB7tfnbsBX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Sep 2024 11:04:12 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4302f9e5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 9 Sep 2024 15:04:09 +0000 (UTC)
Date: Mon, 9 Sep 2024 17:04:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/4] ref: add symref content check for files backend
Message-ID: <Zt8Oa4-N_8QMqUNJ@pks.im>
References: <Ztb-mgl50cwGVO8A@ArchLinux>
 <Ztb_JuMjaoAbIZXq@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ztb_JuMjaoAbIZXq@ArchLinux>

On Tue, Sep 03, 2024 at 08:20:54PM +0800, shejialuo wrote:
> We have already introduced the checks for regular refs. There is no need
> to check the consistency of the target which the symref points to.
> Instead, we just need to check the content of teh symref itself.

s/teh/the

> In order to check the content of the symref, create a function
> "files_fsck_symref_target". It will first check whether the "referent"
> is under the "refs/" directory and then we will check the symref
> contents.
> 
> A regular file is accepted as a textual symref if it begins with
> "ref:", followed by zero or more whitespaces, followed by the full
> refname, followed only by whitespace characters. We always write
> a single SP after "ref:" and a single LF after the refname, but
> third-party reimplementations of Git may have taken advantage of the
> looser syntax. Put it more specific, we accept the following contents
> of the symref:
> 
> 1. "ref: refs/heads/master   "
> 2. "ref: refs/heads/master   \n  \n"
> 3. "ref: refs/heads/master\n\n"
> 
> But we do not allow any other trailing garbage. The followings are bad
> symref contents which will be reported as fsck error by "git-fsck(1)".
> 
> 1. "ref: refs/heads/master garbage\n"
> 2. "ref: refs/heads/master \n\n\n garbage  "
> 
> In order to provide above checks, we will first check whether the symref
> content misses the newline by peeking the last byte of the "referent" to
> see whether it is '\n'.

I'd still argue that we should do the same retroactive tightening as we
introduce for normal references, also with an INFO level at first.
Otherwise we're being inconsistent across the ref types.

> And we will remember the untrimmed length of the "referent" and call
> "strbuf_rtrim()" on "referent". Then, we will call "check_refname_format"
> to chceck whether the trimmed referent format is valid. If not, we will
> report to the user that the symref points to referent which has invalid
> format. If it is valid, we will compare the untrimmed length and trimmed
> length, if they are not the same, we need to warn the user there is some
> trailing garbage in the symref content.
> 
> At last, we need to check whether the referent is the directory. We
> cannot distinguish whether the "refs/heads/a" is a directory or not by
> using "check_refname_format". We have already checked bad file type when
> iterating the "refs/" directory but we ignore the directory. Thus, we
> need to explicitly add check here.
> 
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Signed-off-by: shejialuo <shejialuo@gmail.com>
> ---
>  Documentation/fsck-msgids.txt |   4 ++
>  fsck.h                        |   1 +
>  refs/files-backend.c          |  81 +++++++++++++++++++++++
>  t/t0602-reffiles-fsck.sh      | 117 ++++++++++++++++++++++++++++++++++
>  4 files changed, 203 insertions(+)
> 
> diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
> index 06d045ac48..beb6c4e49e 100644
> --- a/Documentation/fsck-msgids.txt
> +++ b/Documentation/fsck-msgids.txt
> @@ -28,6 +28,10 @@
>  `badRefName`::
>  	(ERROR) A ref has an invalid format.
>  
> +`badSymrefTarget`::
> +	(ERROR) The symref target points outside the ref directory or
> +	the name of the symref target is invalid.

These are two separate error cases, and we even have different code
paths raising them. Shouldn't we thus also have two different diagnostic
codes for this?

>  `badTagName`::
>  	(INFO) A tag has an invalid format.
>  
> diff --git a/fsck.h b/fsck.h
> index b85072df57..5ea874916d 100644
> --- a/fsck.h
> +++ b/fsck.h
> @@ -34,6 +34,7 @@ enum fsck_msg_type {
>  	FUNC(BAD_REF_CONTENT, ERROR) \
>  	FUNC(BAD_REF_FILETYPE, ERROR) \
>  	FUNC(BAD_REF_NAME, ERROR) \
> +	FUNC(BAD_SYMREF_TARGET, ERROR) \
>  	FUNC(BAD_TIMEZONE, ERROR) \
>  	FUNC(BAD_TREE, ERROR) \
>  	FUNC(BAD_TREE_SHA1, ERROR) \
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 0187b85c5f..fef32e607f 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -3434,11 +3434,80 @@ typedef int (*files_fsck_refs_fn)(struct ref_store *ref_store,
>  				  const char *refs_check_dir,
>  				  struct dir_iterator *iter);
>  
> +/*
> + * Check the symref "referent" and "referent_path". For textual symref,
> + * "referent" would be the content after "refs:".
> + */
> +static int files_fsck_symref_target(struct fsck_options *o,
> +				    struct fsck_ref_report *report,
> +				    struct strbuf *referent,
> +				    struct strbuf *referent_path)
> +{
> +	size_t len = referent->len - 1;
> +	const char *p = NULL;
> +	struct stat st;
> +	int ret = 0;
> +
> +	if (!skip_prefix(referent->buf, "refs/", &p)) {
> +

There's a superfluous newline here.

Also, you never use the value of `p`, so you can instead use
`starts_with()`.

> +		ret = fsck_report_ref(o, report,
> +				      FSCK_MSG_BAD_SYMREF_TARGET,
> +				      "points to ref outside the refs directory");
> +		goto out;
> +	}
> +
> +	if (referent->buf[referent->len - 1] != '\n') {
> +		ret = fsck_report_ref(o, report,
> +				      FSCK_MSG_REF_MISSING_NEWLINE,
> +				      "missing newline");
> +		len++;
> +	}
> +
> +	strbuf_rtrim(referent);
> +	if (check_refname_format(referent->buf, 0)) {
> +		ret = fsck_report_ref(o, report,
> +				      FSCK_MSG_BAD_SYMREF_TARGET,
> +				      "points to refname with invalid format");
> +		goto out;
> +	}
> +
> +	if (len != referent->len) {
> +		ret = fsck_report_ref(o, report,
> +				      FSCK_MSG_TRAILING_REF_CONTENT,
> +				      "trailing garbage in ref");
> +	}
> +
> +	/*
> +	 * Missing target should not be treated as any error worthy event and
> +	 * not even warn. It is a common case that a symbolic ref points to a
> +	 * ref that does not exist yet. If the target ref does not exist, just
> +	 * skip the check for the file type.
> +	 */
> +	if (lstat(referent_path->buf, &st))
> +		goto out;

We may also want to verify that `errno == ENOENT` here.

Patrick
