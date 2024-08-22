Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1531313C9CB
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 09:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724320066; cv=none; b=UdEQC9H0IMYa034qYylObgRVEAqARtzhsTro5AcnpPu/ZFoOxXlmePoxnZV/4Li+vpO9Gdj6weZHo+zHf0bZCgvuFQihwtwwvFBg1Ad8IbzbeXl7ljd5+v5zh4/DzKmQCWAcuWR5IHlhsR8XPD4kFtuTycfvsSOYUivQHjuMGG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724320066; c=relaxed/simple;
	bh=OqMXwmP9ssYGB3Igq2qUL1CQdR5PbBTAT4k58w3XsH4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gHA0mpI4BAjI9WrLkfO4GNYLBaq3WWRwARjahhGbtjtNuOOjRnrjorpiyBrYbbUMgxYYk6K3iC2HUlvhjmYZrnpCPX9OksaETHTa2+785FwFJKrMFS5hZs/91o5eZeOAsh34pxHEBAZdEnxOq9Vk+iU5QMF9XtcsxXKj1vxeyWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mANV41ni; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mANV41ni"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-70cb1b959a6so291475a34.3
        for <git@vger.kernel.org>; Thu, 22 Aug 2024 02:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724320064; x=1724924864; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=UJJoENJXz+Iwrqrc4YkWUM96Glp6Dcbj12gwzELpx5M=;
        b=mANV41nieCXhvXNf/4u/J9f3HrsNOY6vy29hQlO8wS4EZ1GM6FeYOv4+1AT5Zi+hd/
         XcB2ca6FXmvKvBP7qnCSr6q03t7HVdjrfWcGF3QDCVfqEw6ypVfqR6C0zcTmVNlcW+dh
         Vk1Nj3nimD3mIoD+a6u8wuiv9HDgTnOr8IRAR2hYu213aLavQajXg6GAok+PwJQFOWy5
         7POfhN+Tnnzf51MAMUO1zGzSTPveCAZY64LproIFsYTtUBodZyN0XUNuweTGa0rBikrt
         KQ6vpGu/DVEUcIIJAYXOu1ZkwUw7gIwap635rudu+jtHLj5U/qJU8kF6nnEMqmCF5U+n
         GNng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724320064; x=1724924864;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UJJoENJXz+Iwrqrc4YkWUM96Glp6Dcbj12gwzELpx5M=;
        b=ualkqe9/qV6Jq98fpQExnsfiJQ5c8tB2ldJkF+GIi0Mw+qtYlA0XRCQJ516o1P7dSp
         aklEA2Fpovf0K2w8xCKSyv0o+ogPQIgM2LMkOtlMWLUhtiCO6l0uf7vpuUem34jrJomf
         D1bPGl3vH3+l19rNsdt7qqQ+do4mATmoJLwCU5WAV8Qb2SSAbKFwOdfdnPaodcbbvWMN
         +OKtAvv3ZIy2EV2agHCn53Vp4AdR8zsTM9JFi9NCWOZi7Lx9X1/xn0bDdZ8sJU57+qBb
         C61Ka6H4H7Y0AzzJ3qjfC3kvnaGF3EqTQnXFtn2l2uHUmhgZvf7FOOydoshGsmqckqsr
         OFlA==
X-Forwarded-Encrypted: i=1; AJvYcCWRr2ggW1V89TwZj9nS73XhOP1kgQ//tEm54uGx6XMH9jqN7q3Mqg5EJ/lUBatRoUTOwBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc6k5l5cNX3QpAOp1O6YKedJ2IiJrqxD7xbfyHEXHIhqwRROlO
	RxgJltCSAAFHYdAIV/zMRQdHBG+nlY5wbDM6g3plUfooDWYJKzYlZPfmNH9VUAO16rbvSs7B+FL
	6kXfmh5rZT8AWnX3i6ICIap/YrMI=
X-Google-Smtp-Source: AGHT+IFOspABgmZtS+Dgg5c5rKxtn2IiW5xr1bBhlT+rkMU0o+/YoTh2CYqgdARmS94ELDSbGE7iDS2dZepRBQ55ybI=
X-Received: by 2002:a05:6808:221e:b0:3db:2afc:b19 with SMTP id
 5614622812f47-3de194f7588mr5901992b6e.12.1724320064023; Thu, 22 Aug 2024
 02:47:44 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Aug 2024 02:47:43 -0700
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <fc0ed68d4675bcd4c89bf63419ec6e8b6b7f5fca.1724080006.git.ps@pks.im>
References: <cover.1724080006.git.ps@pks.im> <fc0ed68d4675bcd4c89bf63419ec6e8b6b7f5fca.1724080006.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 22 Aug 2024 02:47:43 -0700
Message-ID: <CAOLa=ZThdm98qrcQVu2uXkHJ2meEnJJCsBSPSLMQeSwsojQ-Fg@mail.gmail.com>
Subject: Re: [PATCH 07/10] reftable/reader: introduce refcounting
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Content-Type: multipart/mixed; boundary="000000000000e55a740620428c47"

--000000000000e55a740620428c47
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> It was recently reported that concurrent reads and writes may cause the
> reftable backend to segfault. The root cause of this is that we do not
> properly keep track of reftable readers across reloads.
>
> Suppose that you have a reftable iterator and then decide to reload the
> stack while iterating through the iterator. When the stack has been
> rewritten since we have created the iterator, then we would end up
> discarding a subset of readers that may still be in use by the iterator.
> The consequence is that we now try to reference deallocated memory,
> which of course segfaults.
>
> One way to trigger this is in t5616, where some background maintenance
> jobs have been leaking from one test into another. This leads to stack
> traces like the following one:
>
>   + git -c protocol.version=0 -C pc1 fetch --filter=blob:limit=29999 --refetch origin
>   AddressSanitizer:DEADLYSIGNAL
>   =================================================================
>   ==657994==ERROR: AddressSanitizer: SEGV on unknown address 0x7fa0f0ec6089 (pc 0x55f23e52ddf9 bp
> 0x7ffe7bfa1700 sp 0x7ffe7bfa1700 T0)
>   ==657994==The signal is caused by a READ memory access.
>       #0 0x55f23e52ddf9 in get_var_int reftable/record.c:29
>       #1 0x55f23e53295e in reftable_decode_keylen reftable/record.c:170
>       #2 0x55f23e532cc0 in reftable_decode_key reftable/record.c:194
>       #3 0x55f23e54e72e in block_iter_next reftable/block.c:398
>       #4 0x55f23e5573dc in table_iter_next_in_block reftable/reader.c:240
>       #5 0x55f23e5573dc in table_iter_next reftable/reader.c:355
>       #6 0x55f23e5573dc in table_iter_next reftable/reader.c:339
>       #7 0x55f23e551283 in merged_iter_advance_subiter reftable/merged.c:69
>       #8 0x55f23e55169e in merged_iter_next_entry reftable/merged.c:123
>       #9 0x55f23e55169e in merged_iter_next_void reftable/merged.c:172
>       #10 0x55f23e537625 in reftable_iterator_next_ref reftable/generic.c:175
>       #11 0x55f23e2cf9c6 in reftable_ref_iterator_advance refs/reftable-backend.c:464
>       #12 0x55f23e2d996e in ref_iterator_advance refs/iterator.c:13
>       #13 0x55f23e2d996e in do_for_each_ref_iterator refs/iterator.c:452
>       #14 0x55f23dca6767 in get_ref_map builtin/fetch.c:623
>       #15 0x55f23dca6767 in do_fetch builtin/fetch.c:1659
>       #16 0x55f23dca6767 in fetch_one builtin/fetch.c:2133
>       #17 0x55f23dca6767 in cmd_fetch builtin/fetch.c:2432
>       #18 0x55f23dba7764 in run_builtin git.c:484
>       #19 0x55f23dba7764 in handle_builtin git.c:741
>       #20 0x55f23dbab61e in run_argv git.c:805
>       #21 0x55f23dbab61e in cmd_main git.c:1000
>       #22 0x55f23dba4781 in main common-main.c:64
>       #23 0x7fa0f063fc89 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58
>       #24 0x7fa0f063fd44 in __libc_start_main_impl ../csu/libc-start.c:360
>       #25 0x55f23dba6ad0 in _start (git+0xadfad0) (BuildId: 803b2b7f59beb03d7849fb8294a8e2145dd4aa27)
>

The stacktrace is for iterating over refs, what I don't understand is
where in this flow do we actually reload the stack.

> While it is somewhat awkward that the maintenance processes survive
> tests in the first place, it is totally expected that reftables should
> work alright with concurrent writers. Seemingly they don't.
>
> The only underlying resource that we need to care about in this context
> is the reftable reader, which is responsible for reading a single table
> from disk. These readers get discarded immediately (unless reused) when
> calling `reftable_stack_reload()`, which is wrong. We can only close
> them once we know that there are no iterators using them anymore.
>
> Prepare for a fix by converting the reftable readers to be refcounted.
>

Okay so my understanding is that `refcounted` refers to a reference
count which keeps tracks of the stacks which are referring to the
reader. The name is also used in `struct blame_origin` in blame.{c,h}.
Makes a lot more sense now :)

> Reported-by: Jeff King <peff@peff.net>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  reftable/reader.c                | 16 ++++++++++++++--
>  reftable/reader.h                |  2 ++
>  reftable/readwrite_test.c        | 18 +++++++++---------
>  reftable/reftable-reader.h       | 15 ++++++++++++---
>  reftable/stack.c                 |  8 ++++----
>  reftable/stack_test.c            |  6 ++----
>  t/helper/test-reftable.c         |  2 +-
>  t/unit-tests/t-reftable-merged.c |  4 ++--
>  8 files changed, 46 insertions(+), 25 deletions(-)
>
> diff --git a/reftable/reader.c b/reftable/reader.c
> index 037417fcf6..64a0953e68 100644
> --- a/reftable/reader.c
> +++ b/reftable/reader.c
> @@ -621,6 +621,7 @@ int reftable_reader_new(struct reftable_reader **out,
>  	r->source = *source;
>  	r->name = xstrdup(name);
>  	r->hash_id = 0;
> +	r->refcount = 1;
>

So when the reader is initialized by someone, this sets the counter to one.

>  	err = block_source_read_block(source, &footer, r->size,
>  				      footer_size(r->version));
> @@ -645,10 +646,21 @@ int reftable_reader_new(struct reftable_reader **out,
>  	return err;
>  }
>
> -void reftable_reader_free(struct reftable_reader *r)
> +void reftable_reader_incref(struct reftable_reader *r)
> +{
> +	if (!r->refcount)
> +		BUG("cannot increment ref counter of dead reader");
> +	r->refcount++;
> +}
> +
> +void reftable_reader_decref(struct reftable_reader *r)
>  {
>  	if (!r)
>  		return;
> +	if (!r->refcount)
> +		BUG("cannot decrement ref counter of dead reader");
> +	if (--r->refcount)
> +		return;
>  	block_source_close(&r->source);
>  	FREE_AND_NULL(r->name);
>  	reftable_free(r);
> @@ -812,7 +824,7 @@ int reftable_reader_print_blocks(const char *tablename)
>  	}
>
>  done:
> -	reftable_reader_free(r);
> +	reftable_reader_decref(r);
>  	table_iter_close(&ti);
>  	return err;
>  }
>

We remove the `_free()` function and instead introduce `_incref()` and
`_decref()` to increase and decrease the counter. The latter takes over
the functionality of `_free()` when counter hits 0.

> diff --git a/reftable/reader.h b/reftable/reader.h
> index 88b4f3b421..3710ee09b4 100644
> --- a/reftable/reader.h
> +++ b/reftable/reader.h
> @@ -50,6 +50,8 @@ struct reftable_reader {
>  	struct reftable_reader_offsets ref_offsets;
>  	struct reftable_reader_offsets obj_offsets;
>  	struct reftable_reader_offsets log_offsets;
> +
> +	uint64_t refcount;

Wonder if there is a chance that we decrement refcount from 0 and hence
cause a wraparound.

[snip]

I have some questions regarding my own understanding, but the patch
looks good to me.

--000000000000e55a740620428c47
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 790e1ffd1405a5fe_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1iSENUc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNGM0Qy85SDBsSmhFSnFkNkgrWFIyclg3RWlUR2FiYwpxYjF1YVVpUWJF
ZWlRV016MGZrU2l5aVh4VGRGRENsNFFtTmtabG1oRTg2bFhzcmFDeXVhTEkwSHJ4L1pyMDFBCjhl
YzZDSmx5Y2QzWVJYUHhSczBVYWFYNHFsc1lPZXlHbFFaSnhOVmFYMmdMNndjVlJmWTBDZk44MWdY
anRNNzMKdkcxQlNWRHAyczVkVSt1L3ppTWpUajRnbXVvcnFvSVBPVjl5K29aaUNPaUlDSnRET0FD
THQwQXVrU3QraEtKeApKNytkTHlUMjZZMW9rbkhnU2dNaW1hNkhMRXdSMVlHZVdvK3hrMGp5NFl5
a2EvVStGY3J4NWI4ekpsUEVnanFXCmFXdmRGTlBXUDhxSVJBMVhlQmcyZkMyUi94MlZGOHRJNWs4
NG5uT09wT1lib3JkV3BZYmtMTlNFS05uRWFzaGsKUFZ4SllmTHAxYzZwbHJVemczTm5EUzllL2xL
WXAxb0RFT29CQWpMYlJpQ0ZSanhiUlBIZ2hVaVBPUFkwNTRSNQpkcVU4b2Z5R091V3p0cXJOUFdN
ZGtOaHNnTGNTenZsbE5LVXdPNk43clo1c2s4MHluL1d0R2w0N01Td1JabWlYCnFTTkdaSmx3TU4r
eXVBa1pQRWpXSDNIbXJtNy82bjVvb3JIei9VTT0KPWlqencKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000e55a740620428c47--
