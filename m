Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB3A38DD9
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 20:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720730294; cv=none; b=tizDfloOGLg/ml7Y210ZtV7/Vw+1AEQ61vLsdJj24ASA9W+z2hllZ91eetuA+GcnbIgpAYk9sDh5wDodNV7I/YBJXONLzA8JnOAdvzBBcU6EDBW3mcqewtvoB0OBVuuk/1L7O45xdWkyhO4O5nViqFza/FXI1ZQrnHlN9wDi2sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720730294; c=relaxed/simple;
	bh=KHBBekLaNWv80fi7/6Wv/dq9va9hKWbvP9BBCMOUL24=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EW2Z7IPURMeE5GkKUEZnl+s67/Nthm/JrmJWPqsrjaHJ4hgFEfDqpiUBeijAZy1ZW3Cb+vGmgOD5WS2PXkfNLioTK8kf/RyOaZM7GaUwh5nFo/KVEKowPlS4lZ+qiATCHpKS4fd5XjUVznBz7e+irofVG/Z+esJ1i4ec5NOlm9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=gHkhx/Mr; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gHkhx/Mr"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D8F693FA79;
	Thu, 11 Jul 2024 16:38:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=KHBBekLaNWv80fi7/6Wv/dq9va9hKWbvP9BBCM
	OUL24=; b=gHkhx/MrO2AIvD6SmICvRH+CIK2uOlSWRY0HDY5JJD1JT3PcWNipIY
	ZsxBNVSUvICV/3m5+jMJc1LgKId2/SXZ8jGK28E9EpQMMhT3dehT+UDaarsnm/ff
	9C1IyZJe4+JtQabsDmEmtZ7IowJK7+Cw44fchgByx6DA4ifY6ez6M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CE1833FA78;
	Thu, 11 Jul 2024 16:38:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3355E3FA76;
	Thu, 11 Jul 2024 16:38:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org,  karthik.188@gmail.com,  chriscool@tuxfamily.org
Subject: Re: [PATCH v3 2/7] t: harmonize t-reftable-merged.c with coding
 guidelines
In-Reply-To: <20240711040854.4602-3-chandrapratap3519@gmail.com> (Chandra
	Pratap's message of "Thu, 11 Jul 2024 09:28:31 +0530")
References: <20240709053847.4453-1-chandrapratap3519@gmail.com>
	<20240711040854.4602-1-chandrapratap3519@gmail.com>
	<20240711040854.4602-3-chandrapratap3519@gmail.com>
Date: Thu, 11 Jul 2024 13:38:09 -0700
Message-ID: <xmqq7cdrr7f2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7D22C446-3FC5-11EF-98AD-965B910A682E-77302942!pb-smtp2.pobox.com

Chandra Pratap <chandrapratap3519@gmail.com> writes:

It is very nice that the steps [1/7] and [2/7] are split this way.

> Harmonize the newly ported test unit-tests/t-reftable-merged.c
> with the following guidelines:
> - Single line control flow statements like 'for' and 'if'
>   must omit curly braces.

OK.

> - Structs must be 0-initialized with '= { 0 }' instead of '= { NULL }'.

Correct.

> - Array indices must be of type 'size_t', not 'int'.

OK, but "must be" is probably a bit too strong (see below).

> - It is fine to use C99 initial declaration in 'for' loop.

Yes, it is fine.  You do not have to, but you can.

> @@ -68,7 +66,6 @@ static void write_test_log_table(struct strbuf *buf,
>  				 struct reftable_log_record logs[], int n,
>  				 uint64_t update_index)
>  {
> -	int i = 0;
>  	int err;
>  
>  	struct reftable_write_options opts = {
> @@ -79,7 +76,7 @@ static void write_test_log_table(struct strbuf *buf,
>  	w = reftable_new_writer(&strbuf_add_void, &noop_flush, buf, &opts);
>  	reftable_writer_set_limits(w, update_index, update_index);
>  
> -	for (i = 0; i < n; i++) {
> +	for (int i = 0; i < n; i++) {
>  		int err = reftable_writer_add_log(w, &logs[i]);

Did you mean size_t instead of int here?  Probably not, because the
iteration goes up to "int n" that is supplied by the caller of this
test, so iterating with "int" is perfectly fine here.

So, "must be size_t" is already violated here.  You could update the
type of the incoming parameter "n", but given that this is a test
program that deals with a known logs[] array of a small bounded
size, that may be way overkill and "int" can be justified, too.
On the other hand, if it does not require too much investigation,
you may want to check the caller and if it can be updated to use
"size_t" instead of "int".

The general rule is probably "think twice before using 'int' as an
array index; otherwise use 'size_t'", which covers what I said in
the above paragraph.

> @@ -121,8 +118,7 @@ merged_table_from_records(struct reftable_ref_record **refs,
>  
>  static void readers_destroy(struct reftable_reader **readers, size_t n)
>  {
> -	int i = 0;
> -	for (; i < n; i++)
> +	for (size_t i = 0; i < n; i++)
>  		reftable_reader_free(readers[i]);
>  	reftable_free(readers);
>  }

Much better.

> @@ -148,9 +144,8 @@ static void t_merged_single_record(void)
>  	struct reftable_reader **readers = NULL;
>  	struct reftable_merged_table *mt =
>  		merged_table_from_records(refs, &bs, &readers, sizes, bufs, 2);
> -	int i;
> -	struct reftable_ref_record ref = { NULL };
> -	struct reftable_iterator it = { NULL };
> +	struct reftable_ref_record ref = { 0 };
> +	struct reftable_iterator it = { 0 };
>  	int err;
>  
>  	merged_table_init_iter(mt, &it, BLOCK_TYPE_REF);
> @@ -164,9 +159,8 @@ static void t_merged_single_record(void)
>  	reftable_iterator_destroy(&it);
>  	readers_destroy(readers, 2);
>  	reftable_merged_table_free(mt);
> -	for (i = 0; i < ARRAY_SIZE(bufs); i++) {
> +	for (size_t i = 0; i < ARRAY_SIZE(bufs); i++)
>  		strbuf_release(&bufs[i]);
> -	}

OK.  size_t is overkill here because bufs[] is a function local
array with only two elements in it, but once the patch to use
"size_t" (i.e., this one) is written, it is not worth to go in and
make it use "int" again.

> @@ -226,12 +220,12 @@ static void t_merged_refs(void)
>  	struct reftable_reader **readers = NULL;
>  	struct reftable_merged_table *mt =
>  		merged_table_from_records(refs, &bs, &readers, sizes, bufs, 3);
> -	struct reftable_iterator it = { NULL };
> +	struct reftable_iterator it = { 0 };
>  	int err;
>  	struct reftable_ref_record *out = NULL;
>  	size_t len = 0;
>  	size_t cap = 0;
> -	int i = 0;
> +	size_t i;

OK.  It is good that we got rid of useless initialization, as this
is used to drive more than one loops below.

> @@ -358,12 +349,12 @@ static void t_merged_logs(void)
>  	struct reftable_reader **readers = NULL;
>  	struct reftable_merged_table *mt = merged_table_from_log_records(
>  		logs, &bs, &readers, sizes, bufs, 3);
> -	struct reftable_iterator it = { NULL };
> +	struct reftable_iterator it = { 0 };
>  	int err;
>  	struct reftable_log_record *out = NULL;
>  	size_t len = 0;
>  	size_t cap = 0;
> -	int i = 0;
> +	size_t i = 0;

Lose the useless initialization here, too.
