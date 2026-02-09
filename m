Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860243019CB
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 11:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770635755; cv=none; b=pVxCDw6anH17zhbx8I2HStOgLXgGg/OdG7Bmu6NHTU20RrsqCIJPoLCZKx4ufKSYfvznTYL4l0ui9RMFNvcVtY1WRMVFWzxY6wcthZ5NYJMr2GLRcAH4/9ueNQnvVXLGkY51IpZpks1JDeSX3QlhO/qfnPt33jrd5qewVxsQsh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770635755; c=relaxed/simple;
	bh=uwTmR4HgSU9zT7iJcjirYh52MukxD7e90NlJ6KH98Mk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N9gtaFopV3TIeBKuWlGcklE/lH4QKqxPbpSaUdvUPbXiyhHJ1LNyeGzTWYAe9lpxSy5m4rlsgHTnvKJX1qmZVPhYTIqIV27CLtPmHmG4UxpSa4QUvfov1sazYgB1ehnqc566fICyO0PB32yQlFC2JHqiZtkmMjZv8CJ5GTn1DlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UHV7nmgy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NKgyW5HO; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UHV7nmgy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NKgyW5HO"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id D078B1D00198;
	Mon,  9 Feb 2026 06:15:53 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 09 Feb 2026 06:15:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1770635753;
	 x=1770722153; bh=7O0Xc3P7yOhb6q4rVC8OG+U3h2rzu/DRRagFF0S9KSA=; b=
	UHV7nmgykpSmo6XNGsA5MhdkWrdKCI0IO8ufukOZkJSXcCZq2+lZjDfx4pNTTObK
	Ic8WFQP/QNw5HTDp8n/HDmxGpzmBuOmonDqJ/QzWUXa7WR3p49f6pn5YtbXm1QnB
	laVsd46dsrUxkpgu/sQrxa4O5APT72P6vyd6L7mBeDlq8uPvM7SyKTxy3AbRMNks
	uS1vUSq6Z6fKLLU1Z3QnTJ3yRiYHP03acHBJnhaywN2B0r5hBFq2E3de5EkS9NLF
	7cFRYzosNfNmFFGyItjlAVeLH2PvqpwHrR9OB8EWsSc7XJmT+BPhQtT3rlVExXk5
	rk1ax826F+vkWpLWSJ9BYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770635753; x=
	1770722153; bh=7O0Xc3P7yOhb6q4rVC8OG+U3h2rzu/DRRagFF0S9KSA=; b=N
	KgyW5HO5exaNQUDAKmRsLze1Qlg7UhOquyrNx7qf/YWBxKbgyaRCVfAMjAjdkceq
	aqhiF5iYQj6Eao0EDe/EovA8YqUgefxDuXHRAe/ishnj+11yuMd+rA0yEu6bKCGE
	a8owf+rYE5dOmphQUHKJr40eGw/I+UzyaMVBGzNUgFRMonXykVORXu6UvXzgArU9
	6oIVg6qA7P+1F4F9JVfHqW+iQe2SOt3xgbzs86zDuk3INteIGI3fc9mR73npTAMQ
	sLB71qWM6eYrdJ4Pn8pOHg9pGF9uOzhpdPk/AthP5CHY92PZ5BITm1ix4qkI0cjT
	mE5VR1gFZ4buerLuMufCg==
X-ME-Sender: <xms:6cGJaTuu3vYv46f21EICcltLbpJgld5Irm3OHYUPCh1ZU0tm31bDQg>
    <xme:6cGJab4oj6d70hkgFKUa_VoqX2IcauH_cbriE91bygZMIRX7u7AKBuPuWLfVMpP6L
    eG-kcJlQbITOuj_8PobeXI6iV_xYABSmR85_b7IyYS2vEEV8lSTz-I>
X-ME-Received: <xmr:6cGJaUIVNX6JGaM8JoIrVN7Zz4E_9Z0ruo7M5vh2y4J4MB8uID4IJ4HRIdLvgDHxLwYqrNF9c5zD9A5_7oWgM00H01JHKBnQRA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleeiieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekre
    dttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhes
    phhosghogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuve
    elgfekfeehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhdrshdr
    rhesfigvsgdruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:6cGJab7cVSvEdEi0BCXVR-OzheAAO3oqZAU3-T4kOwnfA3zWh3hqmg>
    <xmx:6cGJaXwsa0V2rK-sjCx6z775P0TA_2YPGx_ZJQdt26XE0HwPOVpTRQ>
    <xmx:6cGJafbZem0MFqjNA1t4jqltc7su4TlKE5PmCukfmxd_H4_qLfs2Nw>
    <xmx:6cGJaZTbvK3O8sM4pd7F0aVoPrJuz3OKWIIbGTQG137whQ8ZH-fVhw>
    <xmx:6cGJaTgZMtlqjVf5Q4glBeo0qMdC_cf8-7056u0cr9L_clVDHN30rf8y>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Feb 2026 06:15:53 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] xdiff-interface: stop using the_repository
In-Reply-To: <f58fa33d-b015-4339-819a-9d91be60cd0c@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Sun, 8 Feb 2026 14:47:40 +0100")
References: <f58fa33d-b015-4339-819a-9d91be60cd0c@web.de>
Date: Mon, 09 Feb 2026 03:15:51 -0800
Message-ID: <xmqqms1i6uc8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> Use the algorithm-agnostic is_null_oid() and push the dependency of
> read_mmblob() on the_repository->objects to its callers.  This allows it
> to be used with arbitrary object databases.

> diff --git a/xdiff-interface.c b/xdiff-interface.c
> index 1a35556380..cd7493730b 100644
> --- a/xdiff-interface.c
> +++ b/xdiff-interface.c
> ...
> -void read_mmblob(mmfile_t *ptr, const struct object_id *oid)
> +void read_mmblob(mmfile_t *ptr, struct object_database *odb,
> +		 const struct object_id *oid)

A possible alternative may be to pass "struct repository *" here,
but this passes the (current) smallest piece of data necessary to
drive the helper function odb_read_object(), so it would be fine.

>  {
>  	unsigned long size;
>  	enum object_type type;
>  
> -	if (oideq(oid, null_oid(the_hash_algo))) {
> +	if (is_null_oid(oid)) {
>  		ptr->ptr = xstrdup("");
>  		ptr->size = 0;
>  		return;
>  	}
>  
> -	ptr->ptr = odb_read_object(the_repository->objects, oid, &type, &size);
> +	ptr->ptr = odb_read_object(odb, oid, &type, &size);
>  	if (!ptr->ptr || type != OBJ_BLOB)
>  		die("unable to read blob object %s", oid_to_hex(oid));
>  	ptr->size = size;

