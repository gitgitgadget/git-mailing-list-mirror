Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8208F38238B
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 07:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774943334; cv=none; b=sgGgG2CLMtOunDa3xQv32sSHtzNHwlcGXRuA1iMOPpLwzkEDJEDvTn8cJamGj/nbTNUye4yeMytYAScde/QiWWPjEKbjrjODIg/yq6v7/l1sV8YieD4WtLaYCTdctEe7X4tCe7zTpxdo5RQquozvPPwUzCQr841neYhvow20Vno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774943334; c=relaxed/simple;
	bh=zd0VXA5Tw7WvdCXRqY8/QcijAU8Qpbs8gOVJc8XuvI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WSVbh/uztH8RV3rQ6FoQkGSm3E9wkb2gMDaLb7AMQm+w3kdhJoPSPxpwzvHuHrbh8pFaHUTllGQi4XN/u671ndXLRJ4OmI7hF8wWtSNQOF0kqUL95zF06wkLaUFgSWCm9f7+uPhvge8Lw+Hn1rccmWnT8HfMqbJhhXT+Y0bkMF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aibSpkJo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kOHFs5if; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aibSpkJo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kOHFs5if"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id BA787EC01E2;
	Tue, 31 Mar 2026 03:48:52 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 31 Mar 2026 03:48:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1774943332; x=1775029732; bh=IWviIrCtOf
	LQ8q5fav13yg6bEMuqI4m5/RyeM6WX91Y=; b=aibSpkJop+e5MmC4jzO3pJCgmL
	+gTwxd+bpdOe6aKvVmtCEX+8kvxAhnkiL/ig1PleK+dsWYQlwGv9WuyZYHLZZUz7
	+dCm740GIwkRGCbHgbT+JE14TeI+lTrJua1bJfDiruBERNVU5MvaAQIf+U7YXxUd
	PilpBoPDs24FbxzJT7EHAs01pu84ihP1VqmrArX5VbQk6DDbu4CrdHmghRCgF2Wq
	/Nna7Ba6sYaClL97gUTz7nP2Yx0i1RPfRxUOThzZF8HYXSgNB6VGX1bMITlwvD89
	ArEEwBPCiBVwBtT8QZaEcsbQdWL6fujip1hlHw+Ag6Kl3Tade6s0fB50G5TQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1774943332; x=1775029732; bh=IWviIrCtOfLQ8q5fav13yg6bEMuqI4m5/Ry
	eM6WX91Y=; b=kOHFs5ifJlldfQ0pNpMmDRfhOsbwilIctS/oJcnKIr0sgRJkovt
	Wv0+HDGZvkuh/mDq7bkmxZNOgykzM7qdkrh6UtEnfX67PBhj+tigv3cuQiVIoTUv
	CWj38NbIVz1dxj9cE8xtc2U4Vv2E61JnokoH+ejxmhFQaIU+/N4zoCncxA6La/qK
	qVfktRjPrREXod9ZU7AuMmMEzpfxxZm/N2ERGdOXdilWHN9O3nD1yCvVHfkc/Fjx
	VA0E1QhdkeY7TGZ3rmG1G/uTDnNTVUi+SOuBg/5uv2F0QeWnIIzZP/MBiTyxT/tW
	Gi/yyD1AfqBv58JzgKAJY+F719X59wnv/MA==
X-ME-Sender: <xms:ZHzLaYjCwRtaJ8CmyoNgsqtsTI6xblu5lQKTdLYs5aditiP-yi3GsQ>
    <xme:ZHzLaXCjOQSU6BHwvrzbLnAfG6C_itG6dxcUMO_I_H26zwvCeTjuSAJKXjoowLqDd
    6UPcWJxi9S7XQNXbDZqYDB0DRloF6eAbSGlwK-T_3VjNekQ8aF7lZw>
X-ME-Received: <xmr:ZHzLadss6pQOWczwOH_sY6RwqQwyEmRao_79Kp71uxL5Q5Fz9dSL4wDETOoD5X4I3ZIFJd2JLiMXjau9dLDBaw2ai895oZOvyxvhi4WrO-I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefgedufedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ZHzLaUYkwDcflHeEZdmM9wOomJfrMBDK7WFYddS8QkOpOC24dzM72A>
    <xmx:ZHzLaYXTtGuQBYIL0yS_9icdMHDN0FuJ_Th76j90C8mAPmTUYv8-jw>
    <xmx:ZHzLaQ55O0QJdtiaw1udGnY6LsOMCFV-hjL8pV4vEP6eeETyj2srlg>
    <xmx:ZHzLabjRkRQ8c3Z9EtvBTjdfvJKQMPFwhup1YbNoITWzODKLBK623A>
    <xmx:ZHzLaQSmE9bChnPZc3dS2AmfS-TKW9K2AT6cUl_pOm_neEUH4MuBUvHj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 03:48:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ce81132b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 31 Mar 2026 07:48:51 +0000 (UTC)
Date: Tue, 31 Mar 2026 09:48:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/6] object-file: generalize packfile writes to use
 odb_write_stream
Message-ID: <act8YM8tMeUr3cJe@pks.im>
References: <20260331033835.2863514-1-jltobler@gmail.com>
 <20260331033835.2863514-6-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331033835.2863514-6-jltobler@gmail.com>

On Mon, Mar 30, 2026 at 10:38:34PM -0500, Justin Tobler wrote:
> diff --git a/object-file.c b/object-file.c
> index 1de2244ac5..4c797d6498 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1453,24 +1453,19 @@ static void stream_blob_to_pack(struct transaction_packfile *state,
>  	s.avail_out = sizeof(obuf) - hdrlen;
>  
>  	while (status != Z_STREAM_END) {
> -		if (size && !s.avail_in) {
> -			size_t rsize = size < sizeof(ibuf) ? size : sizeof(ibuf);
> -			ssize_t read_result = read_in_full(fd, ibuf, rsize);
> -			if (read_result < 0)
> -				die_errno("failed to read from '%s'", path);
> -			if ((size_t)read_result != rsize)
> -				die("failed to read %u bytes from '%s'",
> -				    (unsigned)rsize, path);
> +		if (!stream->is_finished && !s.avail_in) {
> +			unsigned long rsize;
> +			unsigned const char *buf = stream->read(stream, &rsize);
>  
>  			if (rsize)
> -				git_hash_update(ctx, ibuf, rsize);
> +				git_hash_update(ctx, buf, rsize);
>  
> -			s.next_in = ibuf;
> +			s.next_in = (unsigned char *)buf;

A bit ugly that we have to cast away the constness, but oh, well.

> @@ -1490,6 +1485,10 @@ static void stream_blob_to_pack(struct transaction_packfile *state,
>  			die("unexpected deflate failure: %d", status);
>  		}
>  	}
> +
> +	if (total != size)
> +		die("unexpected number of bytes read");

Do we want to mention the expected and actual number of bytes?

> @@ -1543,6 +1542,40 @@ static void flush_packfile_transaction(struct odb_transaction_files *transaction
>  	odb_reprepare(repo->objects);
>  }
>  
> +struct read_object_fd_data {
> +	int fd;
> +	size_t size;
> +	unsigned char buf[16384];
> +};

This interface feels generally useful to me, not just in this subsystem
here. Would it make sense to instead expose it in "odb/transaction.h"
as a new `odb_write_stream_from_fd()` function? No need to expose the
structure itself, I guess.

> +static const void *read_object_fd(struct odb_write_stream *stream,
> +				  unsigned long *len)
> +{
> +	struct read_object_fd_data *data = stream->data;
> +	ssize_t read_result;
> +	size_t rsize;
> +
> +	if (stream->is_finished) {
> +		*len = 0;
> +		return NULL;
> +	}
> +
> +	rsize = data->size < sizeof(data->buf) ? data->size : sizeof(data->buf);
> +	read_result = read_in_full(data->fd, data->buf, rsize);
> +	if (read_result < 0)
> +		die_errno("failed to read blob data");

It's a bit unfortunate that we die here, but we don't have an easy way
to return errors. I wonder whether we should refactor the interface a
bit to maybe take a pointer to a buffer as well as the buffer's length
and then return an `ssize_t`.

    static ssize_t *read_object_fd(struct odb_write_stream *stream,
                                   unsigned char *buf,
                                   size_t buf_len);

That'd also avoid having to cast away the const-ness, and it allows the
caller to control how many bytes they want to read at once.

> +	if ((size_t)read_result != rsize)
> +		die("failed to read %u bytes of blob data", (unsigned)rsize);
> +
> +	data->size -= rsize;

I feel like `data->size` is misleadingly named now, as it doesn't
reflect the overall size but rather the number of remaining bytes that
we expect.

Patrick
