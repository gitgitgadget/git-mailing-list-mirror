Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8952ECAAD3
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 18:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiISSeC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 14:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiISSd7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 14:33:59 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFEC36DC8
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 11:33:58 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id k12so50034qkj.8
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 11:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=C6EcGMY3SZdnRUet+q22V6cmPjXV/er2Njr9qxMxx+w=;
        b=faO96ik5v61gobk+VcKHwVmLiWrQSoKMOmtspMOOlpv2j929vrqRjrFN8sd7Ziv8vE
         NWPlGKVWv76+KTx24tane8RrX2Quz3sdZWvbciARTAsIoarGzZKhXJjQwfzIe6+lTIPa
         a7T2s6Mo8HBPrdkHZRLUIPEFkSTjcShWbWPDc6l9Jn7XEG+EVt6M0/mTVrM2oQqIIUE5
         4ouLm1mE1SSGO5K8kdkKCYheSe5hidOht9pLBxkwPj6yAWUgVlEg1E/EnRTVq0tOILg7
         PHjaAy8aHb9dFYzibMYRKo70WoBSpi7OI/A66aX9pig8QHn7LtQ9J2t2oqX2+5rN/kJM
         u/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=C6EcGMY3SZdnRUet+q22V6cmPjXV/er2Njr9qxMxx+w=;
        b=4fR32WjssVBh+MLXPKkZb7a2P13524L1OXqf0a5jN/muOC9c7LjiIn6KyHnOwUvJeJ
         6njbx9btj/rat5js1+2eQ9lsfzTRZzwwiMSQNvbgn6GYWSuSU2Fh4rr7rQvpztrF4g/m
         sRpqIRlBeEsVCARo4pGCwLheBQh/syMTzY5GynlWhvP/i+adNSVywiIawHsXmC595cEq
         2KZQzV5TmrjQhdVgptPeVJmTgh1AgydthS1CvuuCaMOCF+AEKeXdR+iyjyTdqYd+bex6
         ZOTGi3aTRE+LM1dPQ0EUAq8pdv1xA5o7fRby27t0b36+7p1mqLq5VvsQGwZhj53/z+d5
         Ir2Q==
X-Gm-Message-State: ACrzQf3ZrkBxcCHXgGGS8QPqZZYEFMbHZK3rlpEu5+ao8ceuR7YteT2g
        09QGbbLaP8Oah/lcN1alsHR6
X-Google-Smtp-Source: AMsMyM78gHEz1+3u5MCuXNNJg2gNOi0JojCMuw5r99xHJoHCILm3jYftiVJNlWwnvV6DungLKpJVgw==
X-Received: by 2002:a05:620a:10af:b0:6ce:40f7:3dc4 with SMTP id h15-20020a05620a10af00b006ce40f73dc4mr13551927qkk.345.1663612437581;
        Mon, 19 Sep 2022 11:33:57 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:fd97:43ff:6c00:2cf8? ([2600:1700:e72:80a0:fd97:43ff:6c00:2cf8])
        by smtp.gmail.com with ESMTPSA id v4-20020a05620a090400b006bbf85cad0fsm12723854qkv.20.2022.09.19.11.33.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 11:33:57 -0700 (PDT)
Message-ID: <b727c25c-469f-ca56-bbd6-82f82c762523@github.com>
Date:   Mon, 19 Sep 2022 14:33:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 2/5] roaring.[ch]: apply Git specific changes to the
 roaring API
Content-Language: en-US
To:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
References: <pull.1357.git.1663609659.gitgitgadget@gmail.com>
 <38ec2360f4fbfe65fa2d9f1e9cfb7d4944d1714f.1663609659.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <38ec2360f4fbfe65fa2d9f1e9cfb7d4944d1714f.1663609659.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/19/2022 1:47 PM, Abhradeep Chakraborty via GitGitGadget wrote:
> From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
> 
> Though the Roaring library is introduced in previous commit, the library
> cannot be used as is. One reason is that the library doesn't support Big
> endian machines. Besides, Git specific file related functions does use
> `hashwrite()` (or similar). So there is a need to modify the library.

There are a few refactorings happening in this single patch, so it
might be good to split them out for easier spot-checking from the
reviewer's perspective. I'll try to list the ones I see.
 

>  int32_t array_container_write(const array_container_t *container, char *buf);
> +
> +int array_container_network_write(const array_container_t *container,
> +				  int (*write_fn) (void *, const void *, size_t),
> +				  void *data);

Should we make write_fn a defined type? I'm not sure I've seen this
implicit type within a function declaration before.

>  /**
>   * Reads the instance from buf, outputs how many bytes were read.
>   * This is meant to be byte-by-byte compatible with the Java and Go versions of
> @@ -1801,6 +1805,9 @@ int32_t array_container_write(const array_container_t *container, char *buf);
>  int32_t array_container_read(int32_t cardinality, array_container_t *container,
>                               const char *buf);
>  
> +int32_t array_container_network_read(int32_t cardinality, array_container_t *container,
> +                        	     const char *buf);
> +

Both of these functions are creating new implementations instead
of modifying the existing implementations. Is there any reason
why we should keep both of these in perpetuity? They are likely
to drift if we do that.

> +static int container_network_write(const container_t *c, uint8_t typecode,
> +				   int (*write_fn) (void *, const void *, size_t),
> +				   void *data)
> +{
> +	c = container_unwrap_shared(c, &typecode);
> +	switch (typecode) {
> +		case BITSET_CONTAINER_TYPE:
> +			return bitset_container_network_write(const_CAST_bitset(c), write_fn, data);
> +		case ARRAY_CONTAINER_TYPE:
> +			return array_container_network_write(const_CAST_array(c), write_fn, data);
> +		case RUN_CONTAINER_TYPE:
> +			return run_container_network_write(const_CAST_run(c), write_fn, data);
> +	}
> +	assert(false);
> +	__builtin_unreachable();
> +	return 0;
> +}
> +

This similarly is a copy of an existing function. Instead we
should probably make all writers/readers expect network byte
order (for all multi-word integers).

> +static size_t ra_portable_network_size_in_bytes(const roaring_array_t *ra)
> +{
> +	size_t count = ra_portable_network_header_size(ra);
> +
> +	for (int32_t k = 0; k < ra->size; ++k)

We have not loosened the restriction on defining iterator variables
within the for and instead would need this in the outer block. One
possible refactoring would be to move these definitions everywhere
within roaring.c.

> @@ -8603,16 +8981,16 @@ extern inline void roaring_bitmap_remove_range(roaring_bitmap_t *r, uint64_t min
>  void roaring_bitmap_printf(const roaring_bitmap_t *r) {
>      const roaring_array_t *ra = &r->high_low_container;
>  
> -    printf("{");
> +    fprintf(stderr, "{");
>      for (int i = 0; i < ra->size; ++i) {
>          container_printf_as_uint32_array(ra->containers[i], ra->typecodes[i],
>                                           ((uint32_t)ra->keys[i]) << 16);
>  
>          if (i + 1 < ra->size) {
> -            printf(",");
> +            fprintf(stderr, ",");
>          }
>      }
> -    printf("}");
> +    fprintf(stderr, "}");
>  }

This change is confusing to me. I epxect the printf() to print to
stdout, and this might be used in a test helper or something. If
you really want this to go somewhere other than stdout, then the
method should be changed to take an arbitrary FILE*.

> +void roaring_bitmap_free_safe(roaring_bitmap_t **r)
> +{
> +	if (*r) {
> +		roaring_bitmap_free((const roaring_bitmap_t *)*r);
> +		r = NULL;

I think you want "*r = NULL" here, if you are intending to free
and NULL the given address.

This method seems separate from the network-byte-order changes.

> +	}
> +}
> +
  
> +size_t roaring_bitmap_network_portable_size_in_bytes(const roaring_bitmap_t *r)
> +{
> +	return ra_portable_network_size_in_bytes(&r->high_low_container);
> +}

Does network order change the potential size of the bitmap?

> +roaring_bitmap_t *roaring_bitmap_portable_network_deserialize_safe(const char *buf, size_t maxbytes)
> +{
> +	roaring_bitmap_t *ans =
> +		(roaring_bitmap_t *)roaring_malloc(sizeof(roaring_bitmap_t));
> +	if (ans == NULL) {
> +		return NULL;
> +	}

nit: Lose braces around single-line blocks.

> +	size_t bytesread;
> +	bool is_ok = ra_portable_network_deserialize(&ans->high_low_container, buf, maxbytes, &bytesread);

Declare all variables before your logic. I think this will fail if
you run "make DEVELOPER=1".

> +	if(is_ok) assert(bytesread <= maxbytes);

nit: break lines for if bodies.

> +	roaring_bitmap_set_copy_on_write(ans, false);
> +	if (!is_ok) {
> +		roaring_free(ans);
> +		return NULL;
> +	}
> +	return ans;
> +}
> +

>  size_t roaring_bitmap_portable_serialize(const roaring_bitmap_t *r,
>                                           char *buf) {
>      return ra_portable_serialize(&r->high_low_container, buf);
>  }
>  
> +int roaring_bitmap_portable_network_serialize(roaring_bitmap_t *rb,
> +				     int (*write_fn) (void *, const void *, size_t),
> +				     void *data)
> +{
> +	return ra_portable_network_serialize(&rb->high_low_container, write_fn, data);
> +}

I'm not sure why these methods are created as wrappers instead of
renaming the base methods.


>  roaring_bitmap_t *roaring_bitmap_deserialize(const void *buf) {
>      const char *bufaschar = (const char *)buf;
>      if (*(const unsigned char *)buf == CROARING_SERIALIZATION_ARRAY_UINT32) {
> @@ -13827,9 +14247,9 @@ void array_container_printf_as_uint32_array(const array_container_t *v,
>      if (v->cardinality == 0) {
>          return;
>      }
> -    printf("%u", v->array[0] + base);
> +    fprintf(stderr, "%u", v->array[0] + base);
>      for (int i = 1; i < v->cardinality; ++i) {
> -        printf(",%u", v->array[i] + base);
> +        fprintf(stderr, ",%u", v->array[i] + base);

Here's another printf to fprintf situation that is unclear to me.

> @@ -15208,13 +15659,13 @@ void run_container_printf_as_uint32_array(const run_container_t *cont,
>      {
>          uint32_t run_start = base + cont->runs[0].value;
>          uint16_t le = cont->runs[0].length;
> -        printf("%u", run_start);
> -        for (uint32_t j = 1; j <= le; ++j) printf(",%u", run_start + j);
> +        fprintf(stderr, "%u", run_start);
> +        for (uint32_t j = 1; j <= le; ++j) fprintf(stderr, ",%u", run_start + j);

Ditto here. I see we are inheriting off-style code from the original.

> +/**
> + * Frees the memory if exists
> + */
> +void roaring_bitmap_free_safe(roaring_bitmap_t **r);

And nullifies the pointer, don't forget!

In general, I think this change would be a lot smaller if you took
the existing implementation and inserted the proper ntohl() and
htonl() conversions. Git will never call the other versions, so
why keep them in the tree? Why require re-checking all of the format
logic here instead of only the places where we write multi-byte
words?

Thanks,
-Stolee
