Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C8623D7D4
	for <git@vger.kernel.org>; Fri, 22 Aug 2025 16:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755880674; cv=none; b=XfMcRrZ3cVMNOeOuwpDhYC8SK+q4AmKF/tJS333LC6Q2serln1dH636ASa83H90uymACY3VAvXO3h3mX0e8eupRrlQp+3lGQlicFY5VG8F3wTichUGvrw5jdXdwlH5SgqurSjZfsDmc5UnLsdBWaSdgp2jVY9VLIWycpj81ECSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755880674; c=relaxed/simple;
	bh=e7CC788Bw6hPwmyx9OvWJLLknsYQnGLsv1tKxhXRj68=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rqbf21yQ1zqakmeGbEseZeMGS2sgLfEsKPVxbDwxwmjLMZytkS0Tf8RrDlmS0AyiAiBbjWgv4OgvtjcF04giP7pyCgGFx/TEXZIHS0EASNF1aMWBVFbdcOYHN9xZda0+JSPIuU5dX3gQytLtdAB5pYKmYZN1SIrJO09l4+aZgQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Y8gQ3/6/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ELo+DfCL; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y8gQ3/6/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ELo+DfCL"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A62B914006B2;
	Fri, 22 Aug 2025 12:37:51 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 22 Aug 2025 12:37:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755880671; x=1755967071; bh=TVnrgUMnF+
	2FgON4koTlIIf/R6ybxyr+Olnm21p20lM=; b=Y8gQ3/6/Lk3yiQuXCQ9vYcxfkw
	vTdEoY8xJyqCpXqQiT+LWN04SoxgYF4QUbxDbcTArjHASYwEwMWClIhf1GKZGxtE
	A6LmI3fALiI+rjyMa2X/MR5mC0M0CgS1Dj+otVOnzMhSvDeZB2in8e2GmQ8e5XAG
	He2hGeMEN3wGQKoZh/O7v+yw+3hWJlhyNbkaf3siogXL/n7jxSZazMneCCl6jf8n
	mHqwUtf/DdKCCRm7MlucbyBjhbwSRFfOZoXLbvOiPfANoqTdAqEyTRXle+avVCDn
	V9Xp5GOr6RZwC4Nn8pUMRuN4u6iajcjvzFMVd7IsYuL516SOegKRmWD7BlHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755880671; x=1755967071; bh=TVnrgUMnF+2FgON4koTlIIf/R6ybxyr+Oln
	m21p20lM=; b=ELo+DfCLNSJ5rG6P8k2dPgZfj2qYS2k0UT52usbqFlbMSkDm0yf
	ArJyOTh6fw4OuqMuJKH4Z/xyEAHyJhAMsLM/Knznao8r8wBjYl+12q5zQpKrhDU+
	Zw2EQHC0oZVGnwtYVLmU1QiF+ajgxYHaCN1u+0owsNo3u8lGlwiifjGi+7b8OOfk
	NjK3aK/S7VWKrbXlyZ9NjdtJnhoPmFfdN4fPCiMI5/qqcq8cQlN8ksEWyscg8awD
	IMe5d4E6yfZRiPYgZSqHCIObAqLShuEC22qOwGRMOeQfxBtLiiHp55XOM6ibmktC
	AzL1IZCjTX66qrFH2yd4581CaRVlDrLYwkg==
X-ME-Sender: <xms:35yoaBYk5SX_PGsgNzYDWDuFCCL_fdsk27D1ghpkIrJHJ-mOnGIm8A>
    <xme:35yoaC8vLsdVFkkAWWYSvfRg13z5-L7IseIbXfx6N0Axg8ITpMoT2qDBa8YnI0T8u
    8pZHTYo9g3R6gcUnw>
X-ME-Received: <xmr:35yoaAhfgmcQf1Npr8VpvtSTTUyEfnd_i0aZ5mVlojn6cN7ptoaZyZmW3Pp4dFKcc47t8eRFI15pmsW-FH6zzVPrCjKkMZSeJBXLFqY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieegvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshes
    phhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:35yoaCfchGzzz5XEEA-cWU7-ndK44s9dVUBcZ7ANc_v1_MYt75qWsQ>
    <xmx:35yoaHoU56bzzK7uX-4mxT-KQ1lOoG41094lPrI-KJAj-217ShZwFQ>
    <xmx:35yoaHBnLOF_DljCxNFtP9HUTryJ-9SU1i6E_6Ec1yT4j8k9NUSNUw>
    <xmx:35yoaEaRQ1ue52U-QyAfeEgqkSJJlozycPawgw4EYPfShvs68Rhwqg>
    <xmx:35yoaD25Q7JVZZZyFIL4tzTpejY-Z8TBRRJVmugX-MWJcNbIjci-PSmd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Aug 2025 12:37:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v2 2/4] bulk-checkin: remove global transaction state
In-Reply-To: <20250821232249.319427-3-jltobler@gmail.com> (Justin Tobler's
	message of "Thu, 21 Aug 2025 18:22:47 -0500")
References: <20250820225531.1212935-1-jltobler@gmail.com>
	<20250821232249.319427-1-jltobler@gmail.com>
	<20250821232249.319427-3-jltobler@gmail.com>
Date: Fri, 22 Aug 2025 09:37:49 -0700
Message-ID: <xmqqv7mfxqg2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> diff --git a/bulk-checkin.c b/bulk-checkin.c
> index 82a73da79e8..53a20a2d92f 100644
> --- a/bulk-checkin.c
> +++ b/bulk-checkin.c
> @@ -30,11 +30,13 @@ struct bulk_checkin_packfile {
>  	uint32_t nr_written;
>  };
>  
> -static struct odb_transaction {
> +struct odb_transaction {
> +	struct object_database *odb;
> +
>  	int nesting;
>  	struct tmp_objdir *objdir;
>  	struct bulk_checkin_packfile packfile;
> -} transaction;
> +};

Very nice to see that this singleton instance is now gone.  

The singleton was really handy way to allow calls into this
subsystem to lazily initialize bulk_checkin_packfile in the call
chain starting from deflate_blob_to_pack() -> prepare_to_stream().

We now need to be a lot more careful to make sure that everybody has
access to a valid bulk_checkin_packfile struct, which makes the
implementation of index_blob_bulk_checkin() a bit awkward and we
need to invent one bulk_checkin_packfile instance right there.
Luckily it goes away in the next step, I guess?

> +int index_blob_bulk_checkin(struct odb_transaction *transaction,
> +			    struct object_id *oid, int fd, size_t size,
>  			    const char *path, unsigned flags)
>  {
> -	int status = deflate_blob_to_pack(&transaction.packfile, oid, fd, size,
> -					  path, flags);
> -	if (!transaction.nesting)
> -		flush_bulk_checkin_packfile(&transaction.packfile);
> +	int status;
> +
> +	if (transaction) {
> +		status = deflate_blob_to_pack(&transaction->packfile, oid, fd,
> +					      size, path, flags);
> +	} else {
> +		struct bulk_checkin_packfile state = { 0 };
> +
> +		status = deflate_blob_to_pack(&state, oid, fd, size, path, flags);
> +		flush_bulk_checkin_packfile(&state);
> +	}
> +
>  	return status;
>  }

OK.  If we do not have a transaction (i.e. if nobody called 
begin_odb_transaction() more times than end_odb_transaction()
got called), we let the underlying machinery do the right thing on
an empty state and clean up after ourselves; otherwise we follow
exactly the same code path as we used to.

> diff --git a/cache-tree.c b/cache-tree.c
> index 66ef2becbe0..d225554eedd 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -474,6 +474,7 @@ static int update_one(struct cache_tree *it,
>  
>  int cache_tree_update(struct index_state *istate, int flags)
>  {
> +	struct odb_transaction *transaction;
>  	int skip, i;

OK, doing the odb-transaction here would cover both this one and
write_index_as_tree and its friends, that are public interfaces into
the cache-tree subsystem.  

> diff --git a/odb.h b/odb.h
> index 3dfc66d75a3..a89b2143909 100644
> --- a/odb.h
> +++ b/odb.h
> @@ -84,6 +84,7 @@ struct odb_source {
>  
>  struct packed_git;
>  struct cached_object_entry;
> +struct odb_transaction;
>  
>  /*
>   * The object database encapsulates access to objects in a repository. It
> @@ -94,6 +95,13 @@ struct object_database {
>  	/* Repository that owns this database. */
>  	struct repository *repo;
>  
> +	/*
> +	 * State of current current object database transaction. Only one
> +	 * transaction may be pending at a time. Is NULL when no transaction is
> +	 * configured.
> +	 */
> +	struct odb_transaction *transaction;

Once dust from this topic settles, we may want to rename the
bulk-checkin.[ch] to have "odb" somewhere in its name, perhaps?  I
usually do not like renaming file for the sake of renaming to make
the result look "pretty" (people may use "consistent naming" ),
though.  I dunno.
