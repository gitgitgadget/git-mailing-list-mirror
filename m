Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9308120B04
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 15:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725894262; cv=none; b=WX9PN0OS701eQWqGj9+WvWnhbUaDDUQwQifanjUHIhMkMyV/BIna5sPSD9fmzm7YLMfhsbrPjme+FsPziCTkxkaShBu/GaydrOb3G7uwLuMqi1gsSKM2ZI6GGRv7MRcSvFgXQX/akY8KPIBCyd+ISLIHEhIpTZ+cNLDkQYgKlZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725894262; c=relaxed/simple;
	bh=/vPhQJG6YfVsRecylZNwOyuD7Pgxc12HjILpSovbGYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lB0d+OpOq+vyslA3kq0HVVmMZoVAQu9usMx0OCRREBqkZblt3w6nJhSTfOMJMb6nuELo7fSHCA6cqyTezYOePBtzvUyZo/dGNjrtSLuWAvkp1dMZ2dv6nbExQ4XL4encaSJFVDSqoKQeEgNBVszImYpBvvKe/sj7NHWkHdk+beM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cqAtrQva; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i5ftWk64; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cqAtrQva";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i5ftWk64"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id B8709138024E;
	Mon,  9 Sep 2024 11:04:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 09 Sep 2024 11:04:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725894259; x=1725980659; bh=jJa6edKC+S
	QpuTPgylN+MtqYT1Jiqkw/c7KQmydlpAk=; b=cqAtrQvav7NKRElMkFhzMZMJeW
	OzygO7jAEiUDonFVox59qCAE1imMUDf7plQxG9zIT9cpevF5uO6RzvLLyDKsGsyY
	Oi1RwO/Oxo4ofQ4Ew3NtfBx2Kqtt7RMb8ribYoXcKtUEveFE6afq21NfXR07GXL+
	2+L5yLIBrlvZG7txr5vsx+Rn68K7ykbVWX3qgXFw3yGVfYNQTC43sxpGxpo6jS31
	D86GCwwy3280nE/rKvpb6JVDMOjosr7T3HSPBjleifoykceOR1VMa9YNXzUoExsN
	Nd93y1wCmtOkRzyMVnPAysZOi14nr8o8P87dW8jz2Zh1U2tMMjTN44mDhdmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725894259; x=1725980659; bh=jJa6edKC+SQpuTPgylN+MtqYT1Ji
	qkw/c7KQmydlpAk=; b=i5ftWk64paz4cM04b5BTYDqEj4YcuB0108GEdzwOLK/n
	9k7KTUFOJuzmgYTO/j8De3s407Jz1Z9aYsQyiiE+L1925DSWmIiPr9I0Gbk7Luzt
	6BchicAeRY3rERNrrnDdlkfZ3PfUSwOaIg9THvoy/eodNZ1Ft5gGr7DW5AMzRVt+
	xHCO2/hvmm/PO/0lwiBbTAk0J5/eOWv65LJw/iEz4hFNLlQfsUIfzTHo8ac7eU1M
	oA6TdUCa8U/pfWmT9REmX1R+KIVLj6HEc5Hrv68IN1ymZSh+oqa0mijxV2z85rAn
	5+1S3I4pPclxx5Zfrn99bmUs/ZQAj2KhvFC0wtZaig==
X-ME-Sender: <xms:cw7fZvys8ggOAhWxAhQUxikmsYmwSLPolyuUpTlyCB0_crhdBfGSCw>
    <xme:cw7fZnQrBB8ZyTWc36KZX5pbTwFG2_IHdI4BkqUHbvBJvhqTto6Fl_uEmKlL_iOq3
    PX_8Pwx56KjzJGhSw>
X-ME-Received: <xmr:cw7fZpUQIZKvERqR7pkwrd5Lki-Gq45jXXGiA3kJYfSNqV5ALbzj349ji2iwQ4xA9A-4cBzl2WrO74n6ggadiKeEEWu7Twsoj-GpSl0QnB4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeijedgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhh
    vghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:cw7fZphZObHbKASLlp1j6xoehtSnNJjQ2XZLTmSQAh5d26ompXZjww>
    <xmx:cw7fZhB6TaBsjek2qGJNy6jpLSWLjl8gkYIciTQNmgBb9lSeJtkFLw>
    <xmx:cw7fZiL1TcScX8Mq8Uzpxya-Zg5d6e7NI8cb7BVPVFQjZHl2lK6p-Q>
    <xmx:cw7fZgB9Y4n2XSQ1skSMV-hhJwpxnWoKHmNRBFdeBekn5vDJqCTinA>
    <xmx:cw7fZs-rZ-al9dto_36-73RBL3YyVw4vMRUy64cUQmUqQf17iH4WVyZM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Sep 2024 11:04:18 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id de2ce643 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 9 Sep 2024 15:04:15 +0000 (UTC)
Date: Mon, 9 Sep 2024 17:04:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 4/4] ref: add symlink ref content check for files
 backend
Message-ID: <Zt8OcPTzYg3raQlN@pks.im>
References: <Ztb-mgl50cwGVO8A@ArchLinux>
 <Ztb_Lzxgla2FHICH@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ztb_Lzxgla2FHICH@ArchLinux>

On Tue, Sep 03, 2024 at 08:21:03PM +0800, shejialuo wrote:
> We have already introduced "files_fsck_symref_target". We should reuse
> this function to handle the symrefs which use legacy symbolic links. We
> should not check the trailing garbage for symbolic refs. Add a new
> parameter "symbolic_link" to disable some checks which should only be
> executed for textual symrefs.
> 
> We firstly use the "strbuf_add_real_path" to resolve the symlink and
> get the absolute path "referent_path" which the symlink ref points
> to. Then we can get the absolute path "abs_gitdir" of the "gitdir".
> By combining "referent_path" and "abs_gitdir", we can extract the
> "referent". Thus, we can reuse "files_fsck_symref_target" function to
> seamlessly check the symlink refs.
> 
> Because we are going to drop support for "core.prefersymlinkrefs", add a
> new fsck message "symlinkRef" to let the user be aware of this
> information.

I don't we fully decided to drop support for symrefs via symbolic links
yet, so this is a tad too strong of a statement. I'd rather say that we
consider deprecating it in the future, but first need to asses whether
they may still be used.

Also, didn't we say that we'd want to remove support for _writing_
symbolic links, but not for reading them? Not a 100% sure though.

> @@ -1961,13 +1965,12 @@ static int create_ref_symlink(struct ref_lock *lock, const char *target)
>  
>  	if (ret)
>  		fprintf(stderr, "no symlink - falling back to symbolic ref\n");
> -#endif
>  	return ret;
>  }
> +#endif
>  
> -static int create_symref_lock(struct files_ref_store *refs,
> -			      struct ref_lock *lock, const char *refname,
> -			      const char *target, struct strbuf *err)
> +static int create_symref_lock(struct ref_lock *lock, const char *target,
> +			      struct strbuf *err)
>  {
>  	if (!fdopen_lock_file(&lock->lk, "w")) {
>  		strbuf_addf(err, "unable to fdopen %s: %s",
> @@ -2583,8 +2586,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
>  	}
>  
>  	if (update->new_target && !(update->flags & REF_LOG_ONLY)) {
> -		if (create_symref_lock(refs, lock, update->refname,
> -				       update->new_target, err)) {
> +		if (create_symref_lock(lock, update->new_target, err)) {
>  			ret = TRANSACTION_GENERIC_ERROR;
>  			goto out;
>  		}

Why does the writing side need to change?

> @@ -3509,9 +3516,11 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
>  {
>  	struct strbuf referent_path = STRBUF_INIT;
>  	struct strbuf ref_content = STRBUF_INIT;
> +	struct strbuf abs_gitdir = STRBUF_INIT;
>  	struct strbuf referent = STRBUF_INIT;
>  	struct strbuf refname = STRBUF_INIT;
>  	struct fsck_ref_report report = {0};
> +	unsigned int symbolic_link = 0;

This variable isn't used, as both code paths that end up using it could
just statically set it to `1` or `0`.

>  	const char *trailing = NULL;
>  	unsigned int type = 0;
>  	int failure_errno = 0;
> @@ -3521,8 +3530,37 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
>  	strbuf_addf(&refname, "%s/%s", refs_check_dir, iter->relative_path);
>  	report.path = refname.buf;
>  
> -	if (S_ISLNK(iter->st.st_mode))
> +	if (S_ISLNK(iter->st.st_mode)) {
> +		const char* relative_referent_path;
> +
> +		symbolic_link = 1;
> +		ret = fsck_report_ref(o, &report,
> +				      FSCK_MSG_SYMLINK_REF,
> +				      "use deprecated symbolic link for symref");
> +
> +		strbuf_add_absolute_path(&abs_gitdir, ref_store->gitdir);
> +		strbuf_normalize_path(&abs_gitdir);
> +		if (!is_dir_sep(abs_gitdir.buf[abs_gitdir.len - 1]))
> +			strbuf_addch(&abs_gitdir, '/');
> +
> +		strbuf_add_real_path(&referent_path, iter->path.buf);
> +
> +		if (!skip_prefix(referent_path.buf,
> +				 abs_gitdir.buf,
> +				 &relative_referent_path)) {
> +			ret = fsck_report_ref(o, &report,
> +					      FSCK_MSG_BAD_SYMREF_TARGET,
> +					      "point to target outside gitdir");
> +			goto cleanup;
> +		}
> +
> +		strbuf_addstr(&referent, relative_referent_path);
> +		ret = files_fsck_symref_target(o, &report,
> +					       &referent, &referent_path,
> +					       symbolic_link);
> +
>  		goto cleanup;
> +	}
>  
>  	if (strbuf_read_file(&ref_content, iter->path.buf, 0) < 0) {
>  		ret = error_errno(_("%s/%s: unable to read the ref"),

Patrick
