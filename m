Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F3676025
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 19:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724353780; cv=none; b=kOmP5frV+8bVYvJ1EIdbFLlcWSRM6YWK3llNDxrFv3szzImSTK3aZjFJGD2XzJarnyNUPNt4jPKpUzZ40oIWkKH98ZJf9SrSfO5Z/LneFOLQciMW1a4p48YprD3BEu5gF0xvf9D42hahkBE0pCUfgKu/W3O4n5DtoCVJGEXk0K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724353780; c=relaxed/simple;
	bh=9humDc5i9/1wN1d1Bwbp/4FRN2maRCWTRZ7UdulqIJ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iLQ5zpWySseND/zF67CwVl0yWRj5StYiXOsiBZlhR+TsGrp1JQV7cB2++oMMyqzJIZh5uSj9ca4TvbGziLc8oT9XNgatWY1Flz4GJC5/aYsrHpeA45MPAYnliNxhpQS+/yHVx+xExXGrdU60gDitlLBQUPiJSHkp9AUjQIGcjI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=hVbflEPY; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hVbflEPY"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id F2F6D1AFB7;
	Thu, 22 Aug 2024 15:09:38 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=9humDc5i9/1wN1d1Bwbp/4FRN2maRCWTRZ7Udu
	lqIJ8=; b=hVbflEPYIkjmG9hOhz0IjHPA+NZPXgy6n0ASa+S5Rcnw0WOcNAgzBT
	vXHmASGeJnTSZG4EuSXI7zVW3B/up5o6+vvs1WwVpyBHodvvzUtlSgj5WxAibQRO
	C7OyqLmmlkQh581F8bRwtNTR4XO1DbeieeziXe3E/r4LO2MD/b3Z0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id ED3FD1AFB6;
	Thu, 22 Aug 2024 15:09:38 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7749D1AFB5;
	Thu, 22 Aug 2024 15:09:35 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH 03/10] reftable/reader: rename `reftable_new_reader()`
In-Reply-To: <7qfrzzhsplzmmjdygglfyum7d6qroiggeqonqptkzltgtcrdw5@wlukk42x6thn>
	(Justin Tobler's message of "Thu, 22 Aug 2024 13:51:08 -0500")
References: <cover.1724080006.git.ps@pks.im>
	<e658b372f046616779cf49c6c9346a49c2ce1485.1724080006.git.ps@pks.im>
	<7qfrzzhsplzmmjdygglfyum7d6qroiggeqonqptkzltgtcrdw5@wlukk42x6thn>
Date: Thu, 22 Aug 2024 12:09:33 -0700
Message-ID: <xmqqbk1kqsr6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1210A9B4-60BA-11EF-BBC8-E92ED1CD468F-77302942!pb-smtp21.pobox.com

Justin Tobler <jltobler@gmail.com> writes:

> On 24/08/19 05:39PM, Patrick Steinhardt wrote:
>> Rename the `reftable_new_reader()` function to `reftable_reader_new()`
>> to match our coding guidelines.
>> 
>> Signed-off-by: Patrick Steinhardt <ps@pks.im>
>> ---
> [snip]  
>> -int init_reader(struct reftable_reader *r, struct reftable_block_source *source,
>> +int reader_init(struct reftable_reader *r, struct reftable_block_source *source,
>>  		const char *name);
>
> Here we also rename `init_reader()` to `reader_init()`, but do not
> update its call sites resulting in build errors. Since we remove this in
> the next patch anyway, let's drop this change.

True.  The actual definition of the function is also left
unmodified.  Let me locally edit the hunk out.  As you pointed out,
the next step does mention the "new" name in order to remove it, so
there needs a cascading adjustment there, but the fallout is fairly
small (see the attached range-diff).

Thanks.

 1:  348438a69e =  1:  348438a69e reftable/blocksource: drop malloc block source
 2:  ed8bb0e345 =  2:  ed8bb0e345 reftable/stack: inline `stack_compact_range_stats()`
 3:  80cf24d54f !  3:  6b5466771c reftable/reader: rename `reftable_new_reader()`
    @@ reftable/reader.c: int reftable_reader_print_blocks(const char *tablename)
      		goto done;
      
     
    - ## reftable/reader.h ##
    -@@ reftable/reader.h: struct reftable_reader {
    - 	struct reftable_reader_offsets log_offsets;
    - };
    - 
    --int init_reader(struct reftable_reader *r, struct reftable_block_source *source,
    -+int reader_init(struct reftable_reader *r, struct reftable_block_source *source,
    - 		const char *name);
    - void reader_close(struct reftable_reader *r);
    - const char *reader_name(struct reftable_reader *r);
    -
      ## reftable/readwrite_test.c ##
     @@ reftable/readwrite_test.c: static void test_write_empty_table(void)
      
 4:  ce93c128f5 !  4:  bc1eeb32ef reftable/reader: inline `init_reader()`
    @@ reftable/reader.h: struct reftable_reader {
      	struct reftable_reader_offsets log_offsets;
      };
      
    --int reader_init(struct reftable_reader *r, struct reftable_block_source *source,
    +-int init_reader(struct reftable_reader *r, struct reftable_block_source *source,
     -		const char *name);
      void reader_close(struct reftable_reader *r);
      const char *reader_name(struct reftable_reader *r);
 5:  079a3d365e =  5:  3e244b036a reftable/reader: inline `reader_close()`
 6:  7e951256c6 =  6:  41c537e44b reftable/stack: fix broken refnames in `write_n_ref_tables()`
 7:  8e99330cff =  7:  b7596c4c32 reftable/reader: introduce refcounting
 8:  2383c196a6 =  8:  9f28628ecc reftable/reader: keep readers alive during iteration
 9:  8af7c4485f =  9:  51df76889c reftable/stack: reorder swapping in the reloaded stack contents
10:  1ccdac05ab = 10:  32bbcc46b9 reftable/stack: fix segfault when reload with reused readers fails
