Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20BC282F27
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 22:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775254280; cv=none; b=GFtRdi/kGjySjM5qSbOlV2daNSYpg9SA5pgGRa6/PV/QyiWfwyp/ujg7wTbu6wZSVks3CXr1xGTf9IBgITQ8hxtgJQxeC0c1ozdKk3BBmQnE1JDbckkuw95pd7PE3A1dOgAliGMwCvv9XrcSKUIiTCdIptSNvmQWfEP3BigTYMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775254280; c=relaxed/simple;
	bh=uTgz30D35j/KpE6z9TCXGPpv8wQqHs7EEqhdwzWwemg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iom5wigDOn7zb85Wvs1IkHBr9vKJixhXvwMM8ijcfsPHDpztnDJYRRXkldMCnbuqwRr68apsg+WiSTAC5be+DiT3W/bzy4Uwl0sz6tttDyVZ7/iONx7GT2GtKi9gU7QGfoYQ9AQ2Z0HQjm3QRWtkYdjpb0CHJjfdJCL0sbvQ+D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WW8R1a+E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=djMHmVe3; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WW8R1a+E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="djMHmVe3"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 08A38140014C;
	Fri,  3 Apr 2026 18:11:18 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 03 Apr 2026 18:11:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775254278; x=1775340678; bh=oy67YjbyMD
	IZa7Ik0wTIkcdY3VYKl/SfdI//yoU0erE=; b=WW8R1a+E79C4i8SYwLtFPoKOEE
	SwYBSbwYXU8GgPqiqpTUcL42E6wVgD2v2F8ZwaT3OzkEWxlgKnIM+AGcHHdMSA9S
	IwNlkyrGGjvp4LxD/U82S90tP4iZ4cTE5DZrYNBJ3Dfzgm2KxZYZrm4ylJbZhY3+
	exwSgWSt0JqryvT7JOCMxjV5R+7lGNyE/iauKSI/5mFXPCRMNrORCpm3mCFnixEn
	riOizc3vzP+X9FVPTBgY7rcUr9omhe6sW2H+B8gu1t0DtnC2pKkP9M+B4cVCRN0t
	APSwRJ9y7QSfh149cU8Z4OJJ/JI3bvQZEwIlwizBcqN5o0wTjMhH7iyUwTSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775254278; x=1775340678; bh=oy67YjbyMDIZa7Ik0wTIkcdY3VYKl/SfdI/
	/yoU0erE=; b=djMHmVe3E0R5LNT6FzXBKwirepDtt+Ho5mvqFKlz1n0FCJor6im
	NATmJWDvI5UjMlXBqxDnTkIjm2Zbi1i5Ochxk7PlGbsOo3M1rYonkTb4fapDPSzS
	jG7poqcbse7YaTyFinax01CS/2sz5zr0DBGziifPNk8IqrYjBAJHqSEsr6shFuyY
	QVQolf8YrVcepGBeEPwHNfNTlNpH+iQC0MhQxMDujAOUzAGgxdqC1fQv9DYFbGEo
	pX/5ewwf1i4uaAA9jhw7F8dR/Nmn2IvTe/o5b9Mwu9JFU+P1ca3lD2M/vC4wgSft
	2oMibaEoWih/ME4qKq5wB+embFR/R2aAZ0w==
X-ME-Sender: <xms:BTvQaTpjgFsOb5ElaryghnUhV5ZXJCGYCl9Rfk6Bk8I4wQ5YUWbDIA>
    <xme:BTvQaUocd3eex_Qh38zvi7NnOpyeQlytgtiJhtBkbCMEkTEXIOy-KwsqlfVs9FyVr
    6DxZ8dMsy1qwvG8gpXnPlAjDjzHWaO6aF9r7m-69Rcwl7x9ekcdaQ>
X-ME-Received: <xmr:BTvQaVOVQ49nS_mrlJt4Rj_7btuwtZdmpNd1SQGM3veoXCS7XySjJwc5p58GcBRkRhrYYYe5ZtyyzNfmg21Fw1ki2iH-J7EPVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeettddtveffueeiieelffeftdeigfefkeevteevveeutdelhfdtudfgledtjeel
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhsse
    hpkhhsrdhimhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:BTvQaVw0kzMSgHou08E7UuOTHFTADxPocNiyl2Sv65DoFvXPvM_Nug>
    <xmx:BTvQaesoyfCcd12H6RIIP3nMY5H2FG4Mjey7ABF5jLbsNsEG-kX9QA>
    <xmx:BTvQae7boxEoZgwkp9WPRtMcbuiA1bIEM-RUxHkJhm2sKEGR9rvZ3A>
    <xmx:BTvQadSLr2UekVZK9tpP9iBBTKnu_xJLjuQOEcf16DAq2GhL9eLaww>
    <xmx:BjvQaUuBBJuUhpeJbMcU2iMkD5h4wzYJPzO55cwyql60VWktAIdBXejv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Apr 2026 18:11:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>, Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 07/16] odb/source-inmemory: implement
 `write_object_stream()` callback
In-Reply-To: <20260403-b4-pks-odb-source-inmemory-v1-7-8b8d1abaa25e@pks.im>
	(Patrick Steinhardt's message of "Fri, 03 Apr 2026 08:01:54 +0200")
References: <20260403-b4-pks-odb-source-inmemory-v1-0-8b8d1abaa25e@pks.im>
	<20260403-b4-pks-odb-source-inmemory-v1-7-8b8d1abaa25e@pks.im>
Date: Fri, 03 Apr 2026 15:11:16 -0700
Message-ID: <xmqqzf3jlmnv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Implement the `write_object_stream()` callback function for the inmemory
> source.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  odb/source-inmemory.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)

As the signature of the .read() method drastically changes in
another topic in flight,

  https://lore.kernel.org/git/20260402213220.2651523-4-jltobler@gmail.com/

this needs a bit of inter-topic coordination.

> diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
> index d2fc4c4054..890e2a8c7c 100644
> --- a/odb/source-inmemory.c
> +++ b/odb/source-inmemory.c
> @@ -123,6 +123,45 @@ static int odb_source_inmemory_write_object(struct odb_source *source,
>  	return 0;
>  }
>  
> +static int odb_source_inmemory_write_object_stream(struct odb_source *source,
> +						   struct odb_write_stream *stream,
> +						   size_t len,
> +						   struct object_id *oid)
> +{
> +	size_t total_read = 0;
> +	char *data;
> +	int ret;
> +
> +	CALLOC_ARRAY(data, len);
> +	while (!stream->is_finished) {
> +		unsigned long bytes_read;
> +		const void *in;
> +
> +		in = stream->read(stream, &bytes_read);
> +		if (total_read + bytes_read > len) {
> +			ret = error("object stream yielded more bytes than expected");
> +			goto out;
> +		}
> +
> +		memcpy(data, in, bytes_read);
> +		total_read += bytes_read;
> +	}
> +
> +	if (total_read != len) {
> +		ret = error("object stream yielded less bytes than expected");
> +		goto out;
> +	}
> +
> +	ret = odb_source_inmemory_write_object(source, data, len, OBJ_BLOB, oid,
> +					       NULL, 0);
> +	if (ret < 0)
> +		goto out;
> +
> +out:
> +	free(data);
> +	return ret;
> +}
> +
>  static void odb_source_inmemory_free(struct odb_source *source)
>  {
>  	struct odb_source_inmemory *inmemory = odb_source_inmemory_downcast(source);
> @@ -144,6 +183,7 @@ struct odb_source_inmemory *odb_source_inmemory_new(struct object_database *odb)
>  	source->base.read_object_info = odb_source_inmemory_read_object_info;
>  	source->base.read_object_stream = odb_source_inmemory_read_object_stream;
>  	source->base.write_object = odb_source_inmemory_write_object;
> +	source->base.write_object_stream = odb_source_inmemory_write_object_stream;
>  
>  	return source;
>  }
