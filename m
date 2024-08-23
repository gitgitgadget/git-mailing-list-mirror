Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE42C16DEA7
	for <git@vger.kernel.org>; Fri, 23 Aug 2024 10:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724408055; cv=none; b=TKUKZ+ZACQCColhV2y17A6vcW7mGNzE2PKR1wcypr0BkL7oAcRo7NVU7ZYf6W9owgljUWzXT5Hd8UmOnsbORuIIa/Tw3cqB/27ozmoLF56ZnnQVgQo0MgXmKLTNnA5fA3QLv2CmUM5SFxCl3ahGdgcusmj4hbZCwxOV8hHS3zug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724408055; c=relaxed/simple;
	bh=TZjzJTl7gwgBglffUrRGfGlmj8+ltsHs3TuPC9DxM6k=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b8gIMjfcFXTLi8wYJVur2TgUEJxBlmrafJ/52rBIlCseQ15PatzN+Jw2ZNzGYz/Vb6Fz7mLIObeprKKGPC7jcdCIcRSC2rI0aM5QnxdsyOdrtTamDQ/rNTqrZzvjr3lEd6+hL+DvnHhZgSAoS/2DOEU3tpW/VQpWlZQiUwrIjDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JqWbmSOR; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JqWbmSOR"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-70b3b62025dso1418707a34.0
        for <git@vger.kernel.org>; Fri, 23 Aug 2024 03:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724408053; x=1725012853; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6zvwsqZ6FSYXXYIbLiFzg8ijzkuHzIkeL6evsgpLWiw=;
        b=JqWbmSOR2SU+cyapwPi95nH1VRKJ7qxR2sfXzu4R5afAOn1LXu/TVxM2jn0evB9Z1X
         wjcz/XobvplyBpNpMGY998KybbCSyWpTT3X71HKEWxpfXN7ap/y/IOgM+G1AaNmXHJDb
         Q6xVOt4lZa1S87Xp6GmHowCYIwzRiQui2h7uvmFFXYdBsxSxyMS8/cRwUg8QejSnZCl9
         0P3mGpKUEXR1rqai7QVTXfIQnALVHaMPGlwBtjBEjJfzV0m0Jg81vf+Dz9B9nPBD5geB
         u3Z7mlBF+devJevhbXTYc9cl0jGJPv+oSvSpXMBUns6G6T5NFpJ/8n2S24E+79baSvWb
         crsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724408053; x=1725012853;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6zvwsqZ6FSYXXYIbLiFzg8ijzkuHzIkeL6evsgpLWiw=;
        b=GyMV88Y6TZhOOfLl3i4Miw+iAkOW5PF1gxnGLZmWmq8agtzX8mGKiM1NFUUZyyQE1b
         eprOU4amg2pfVp+HSwjyw141RMraBj1+ziTvs3w8MsApaTpTOnFoM208fctzSPGFbPXu
         /dMEiokOj8N9JO9pDDiD0C+o9V7abuyGY+q5B2XXgDKmnLU3bZUWf6U3L079Ty9VxxJX
         zyIcRf8SIwglIaHNxr2fkHUb7LwapBBMfNmJP8SMefNCeiMVgB+gi/NfjvDgRAI5Ozvx
         4bqqpj5Wkfu34lZLSzLONVzTEY474H/zkz0O5GUgFpNQpI2f1ie5h2ih07CHHqJv0GFx
         BBTQ==
X-Gm-Message-State: AOJu0YwWHBOZDdSlYER1Jftta4kt60Nx+bhS3gDkxQNpO5unTVNpSXIx
	44T9zTpIiLGaAYuF01c5eoxiDA48WzQlb2HYJ0J/hKmq5EBbN/7KoIyOHDHlSGTfPmsFZHuYioh
	ACkTTqiFYhO7wAbfKXyXO2nHqINnihA==
X-Google-Smtp-Source: AGHT+IFKRFIIpYDWZK72UUZpypjdvQS9x7KQwzu70oLGTv3mZm/jdbsknkiPno0pJlhdoTLkMH9tGYUnmHWJ71y7fXA=
X-Received: by 2002:a05:6808:1490:b0:3d9:385d:8747 with SMTP id
 5614622812f47-3de2a8e2734mr1642884b6e.32.1724408052641; Fri, 23 Aug 2024
 03:14:12 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Aug 2024 03:14:11 -0700
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <ZscilS_kLcJyHThx@framework>
References: <cover.1724080006.git.ps@pks.im> <fc0ed68d4675bcd4c89bf63419ec6e8b6b7f5fca.1724080006.git.ps@pks.im>
 <CAOLa=ZThdm98qrcQVu2uXkHJ2meEnJJCsBSPSLMQeSwsojQ-Fg@mail.gmail.com> <ZscilS_kLcJyHThx@framework>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 23 Aug 2024 03:14:11 -0700
Message-ID: <CAOLa=ZRf9cGyB23EUn_Mb1inJuqNVA85tGGN6SWxcVjbc98QQg@mail.gmail.com>
Subject: Re: [PATCH 07/10] reftable/reader: introduce refcounting
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Content-Type: multipart/mixed; boundary="0000000000006d16f50620570950"

--0000000000006d16f50620570950
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Aug 22, 2024 at 02:47:43AM -0700, karthik nayak wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>>
>> > It was recently reported that concurrent reads and writes may cause the
>> > reftable backend to segfault. The root cause of this is that we do not
>> > properly keep track of reftable readers across reloads.
>> >
>> > Suppose that you have a reftable iterator and then decide to reload the
>> > stack while iterating through the iterator. When the stack has been
>> > rewritten since we have created the iterator, then we would end up
>> > discarding a subset of readers that may still be in use by the iterator.
>> > The consequence is that we now try to reference deallocated memory,
>> > which of course segfaults.
>> >
>> > One way to trigger this is in t5616, where some background maintenance
>> > jobs have been leaking from one test into another. This leads to stack
>> > traces like the following one:
>> >
>> >   + git -c protocol.version=0 -C pc1 fetch --filter=blob:limit=29999 --refetch origin
>> >   AddressSanitizer:DEADLYSIGNAL
>> >   =================================================================
>> >   ==657994==ERROR: AddressSanitizer: SEGV on unknown address 0x7fa0f0ec6089 (pc 0x55f23e52ddf9 bp
>> > 0x7ffe7bfa1700 sp 0x7ffe7bfa1700 T0)
>> >   ==657994==The signal is caused by a READ memory access.
>> >       #0 0x55f23e52ddf9 in get_var_int reftable/record.c:29
>> >       #1 0x55f23e53295e in reftable_decode_keylen reftable/record.c:170
>> >       #2 0x55f23e532cc0 in reftable_decode_key reftable/record.c:194
>> >       #3 0x55f23e54e72e in block_iter_next reftable/block.c:398
>> >       #4 0x55f23e5573dc in table_iter_next_in_block reftable/reader.c:240
>> >       #5 0x55f23e5573dc in table_iter_next reftable/reader.c:355
>> >       #6 0x55f23e5573dc in table_iter_next reftable/reader.c:339
>> >       #7 0x55f23e551283 in merged_iter_advance_subiter reftable/merged.c:69
>> >       #8 0x55f23e55169e in merged_iter_next_entry reftable/merged.c:123
>> >       #9 0x55f23e55169e in merged_iter_next_void reftable/merged.c:172
>> >       #10 0x55f23e537625 in reftable_iterator_next_ref reftable/generic.c:175
>> >       #11 0x55f23e2cf9c6 in reftable_ref_iterator_advance refs/reftable-backend.c:464
>> >       #12 0x55f23e2d996e in ref_iterator_advance refs/iterator.c:13
>> >       #13 0x55f23e2d996e in do_for_each_ref_iterator refs/iterator.c:452
>> >       #14 0x55f23dca6767 in get_ref_map builtin/fetch.c:623
>> >       #15 0x55f23dca6767 in do_fetch builtin/fetch.c:1659
>> >       #16 0x55f23dca6767 in fetch_one builtin/fetch.c:2133
>> >       #17 0x55f23dca6767 in cmd_fetch builtin/fetch.c:2432
>> >       #18 0x55f23dba7764 in run_builtin git.c:484
>> >       #19 0x55f23dba7764 in handle_builtin git.c:741
>> >       #20 0x55f23dbab61e in run_argv git.c:805
>> >       #21 0x55f23dbab61e in cmd_main git.c:1000
>> >       #22 0x55f23dba4781 in main common-main.c:64
>> >       #23 0x7fa0f063fc89 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58
>> >       #24 0x7fa0f063fd44 in __libc_start_main_impl ../csu/libc-start.c:360
>> >       #25 0x55f23dba6ad0 in _start (git+0xadfad0) (BuildId: 803b2b7f59beb03d7849fb8294a8e2145dd4aa27)
>> >
>>
>> The stacktrace is for iterating over refs, what I don't understand is
>> where in this flow do we actually reload the stack.
>
> Basically, whenever you call into the reftable backend we check whether
> we need to reload the stack. So, when creating a reftable iterator,
> reading a single ref, writing refs and so on. So in the above code flow
> we had a ref iterator, but during iteration we ended up reading other
> refs, as well.
>

Yes, makes sense. Thanks for clarifying.

>> > While it is somewhat awkward that the maintenance processes survive
>> > tests in the first place, it is totally expected that reftables should
>> > work alright with concurrent writers. Seemingly they don't.
>> >
>> > The only underlying resource that we need to care about in this context
>> > is the reftable reader, which is responsible for reading a single table
>> > from disk. These readers get discarded immediately (unless reused) when
>> > calling `reftable_stack_reload()`, which is wrong. We can only close
>> > them once we know that there are no iterators using them anymore.
>> >
>> > Prepare for a fix by converting the reftable readers to be refcounted.
>> >
>>
>> Okay so my understanding is that `refcounted` refers to a reference
>> count which keeps tracks of the stacks which are referring to the
>> reader. The name is also used in `struct blame_origin` in blame.{c,h}.
>> Makes a lot more sense now :)
>
> Yup.
>
>> > diff --git a/reftable/reader.h b/reftable/reader.h
>> > index 88b4f3b421..3710ee09b4 100644
>> > --- a/reftable/reader.h
>> > +++ b/reftable/reader.h
>> > @@ -50,6 +50,8 @@ struct reftable_reader {
>> >  	struct reftable_reader_offsets ref_offsets;
>> >  	struct reftable_reader_offsets obj_offsets;
>> >  	struct reftable_reader_offsets log_offsets;
>> > +
>> > +	uint64_t refcount;
>>
>> Wonder if there is a chance that we decrement refcount from 0 and hence
>> cause a wraparound.
>
> This should never happen in practice. And if it does, we would hit a
> BUG():
>
>     void reftable_reader_decref(struct reftable_reader *r)
>     {
>     	if (!r)
>     		return;
>     	if (!r->refcount)
>     		BUG("cannot decrement ref counter of dead reader");
>     	if (--r->refcount)
>     		return;
>     	block_source_close(&r->source);
>     	FREE_AND_NULL(r->name);
>     	reftable_free(r);
>     }
>
> If the refcount is at zero already, we hit the bug.
>
> Patrick

Yup, this seems correct. Thanks.

--0000000000006d16f50620570950
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: f7c4a5923e7b120c_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1iSVlQQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meEgzQy85aDJTY3RRdkJWcm93REdrQXlxSGlxTWw0Nwo1RFlTa0p0S296
dGJWbm1PN2VFbTZEbjVRRGJORjJSME0wZ0xSTFBOUlFzQ0s1YjM2WTEyOGtlVTQ0WWNkZFluCm9q
SlZFeHZmVUd5U1QyUlRYZ2tMUGsyMkc0aHoxaTNmTVg3aFJmS0J0dXhDNjhNTVBQeEkvMmZGVytE
SGpJaG0KRVArTU5RSlN1NWFCV1M1ckk3Z3RzMm0xS2ZmMTRadnpiV0dFVW5VVWQvdjBxMXZjaGls
TWxDWHpySXZNQVpUZwpYN20yOXkrd3NNK1BSMmpkd2c3elRSZWY4SjhVQy90Skc2NVZ3K3RHQjRj
NkErZ1BOdXRaK0xYUTg0OENjR0xsCjd0MU9mTks1YllBdUw3ZWwvMkkvNjdVQVM3dUR5YUdLWGov
TWhMbzcwazh3M0xpdWVFcmo1MUNzL0YwTFFuWDYKRWNNTHFEeXBWZ0lpNUtlMTZsbmNnaTlKanJu
QjBscFRhMUw3bUxSVzM5UjFZZk16K0I3NDRibnJ5Vk40OXc5ZgpKTEUwTkFCSDRiT1B5K2VZL043
UjhPbXFvcW8wQURmajZwcy9rd3JRdnZkbWFzNWxIa1J6VklFZXJLODlFMHZDCmZDQWZVRVc3U1da
bW5Na3lmSXhKN2hOam9VVTFRWW9jMjFya1hLYz0KPVJPd1IKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000006d16f50620570950--
