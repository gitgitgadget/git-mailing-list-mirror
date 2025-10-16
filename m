Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5221532A3E1
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 12:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760616913; cv=none; b=W8hOGauGHs4vgeWFRelSzN0V3//h88TLQJ8wLl7niUOL3hBTpy3TlK2T1RNdUPe1YvOW4/PaJ3Y51w/i/P4l36DxelxdjZl2wkoAPguZhD7+VaszbeBmgIP1kHMOjokcIozNCCLL1EzJmBeSv9eYTH21Z1J7ez1Z6czeHa6vqTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760616913; c=relaxed/simple;
	bh=MxOMVQXLTQpYYYlbL3SuDftwNdKO/a9Yu0G7YIv/piw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cwfAFHht9HKbq1k1Er8z58MzlrX4HOGf3Zz5gyGNHaSiqf6OrRXkBjTlL3rOofL8yYE2U0MWd3iTD7eGBjAGpMSUnQuD/lN0LDO8cB6MXeSGASzRUIIsP48mEEoet5l2P3y0AhiUBvP4TYGIxWbAp8yfa/VmtBAVBcDePpZW4Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k4DmQBMB; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4DmQBMB"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-54bbaca0ee5so237057e0c.3
        for <git@vger.kernel.org>; Thu, 16 Oct 2025 05:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760616910; x=1761221710; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=TSDSha/wnLMsFo3N2lmfflYQb87cDFGzpJwwSfSE5oc=;
        b=k4DmQBMB2AClz7/DqK0AKIqPdsBs180dxbf7PBx9XnMvQ8eeS7Nsb0K/dpVaCIfIjq
         4YLZb207/ZRE65l+UePowt1v1VGuLTuym1yRDaZH6emv1pX4G4f8owsbMCto99gn8wzs
         ePGQjLTVtpqnflSob1zejwqsxA5Oquwfm7tPXidUKEeA24e3bPbdAXjrhEN3gXS49EcQ
         73CR/zLslhft5h4e/MRsjrsSLuBmOJIG8HdggJsFAghQCPepkGW7K3cHeNiIX9af0l38
         j4kGtl899j3ZeVMxC0xcfCJWW73fSgOffz9RvnCeH1YWTsk0jM2uE6mUgJ/fnsFXtnzP
         nIsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760616910; x=1761221710;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TSDSha/wnLMsFo3N2lmfflYQb87cDFGzpJwwSfSE5oc=;
        b=lkUIiYVGFu7ybg8Z/HXYFwniyzVfCmgGXngchFK09wrqPt+dh74P6KM6PYkdhlNZCU
         mYr+KZdgKinOcmLXgKKu+zW+jgbKCL2TQMBrrhoCpmpGeewwCaP9IOVC+MDiB4cRGQyG
         wHd5++RA8Grr+6+JvQQhHFctHL0deeWWd7MuFc4QmFKi4jPzxUXdSayLRLTyfReYAyDX
         UCPCZp4Pww4P/y5cqySo0O6cvd55kGj+/OiZlRWwwePCBT46CHUk+9fBLazrp0xbswXV
         ujyDle5NhGZzsUSFqRyp8T0FJx+mQq4UIT1mRO9Y5ymuIvqA/363I8HhcXI83wmKjlsm
         bvaA==
X-Gm-Message-State: AOJu0YzAr3jqXzWVquSvdQzRS1srVpnaeIy2dMgtq1AZj3QMVOlkEj0o
	kJRVwNA4EuRXtA72P8M7jUYuxWsoqt47yrREMy/wT8VoEdf0w6V2mLRY7Fc7pwjMsK08sKDHNkb
	oA5A4h9sJ0S6Mtg9hRm0ZtoCql9iwLvQp4ezr
X-Gm-Gg: ASbGnctCHO/wiFN+GeOu+i0wpdUJcGEq1g41O+7T1wBqGU90Co2iYP5WpOJ7g7aYtFI
	qjkR1WG5K3cjTXeigE7Voj80fpqG4nuqsU4DK2p/jzv0S2Mx3uRiZOdhWZv9w3/KFuSEyvmVs0Q
	jsEvnB5RON1gce1Jp5delGsPwJi9nwnd9YlJLzNuklQ1aJt3/o1cNuKzUD2IpenGgDBlGheIRP0
	YTNzLFr7fZdmkflXvpRFGktt79I57apX4uuh8gFTtokawSeerahsdmj+o4ik+0Rr2KwJtjQhBvf
	H1CamApKf74kcUSbIZQbTf2hV6+fXg==
X-Google-Smtp-Source: AGHT+IFjJtPC4tkDj2qWZfSY92VnILvC1e+02rFH8o0kyAIux7tpP7wMD+C4z+4RbRQKCOB2JNUWCQk8ddWf6o/4qAE=
X-Received: by 2002:a05:6122:328b:b0:549:f04a:6ea8 with SMTP id
 71dfb90a1353d-554b8cb3837mr10793012e0c.9.1760616909868; Thu, 16 Oct 2025
 05:15:09 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 16 Oct 2025 07:15:08 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 16 Oct 2025 07:15:08 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <j4kd7andvwa77uf7yaxvfkrb5bpxyda4awhnyce5fypr3qijsp@sw4bzfd43byg>
References: <20251015-refs-code-cleanup-v1-0-550fdd8a3b41@gmail.com>
 <20251015-refs-code-cleanup-v1-3-550fdd8a3b41@gmail.com> <j4kd7andvwa77uf7yaxvfkrb5bpxyda4awhnyce5fypr3qijsp@sw4bzfd43byg>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 16 Oct 2025 07:15:08 -0500
X-Gm-Features: AS18NWC0A4lVOW6b4GCZkkHu-8lWjqJ5t_hpyi_GDWmUz4NXlu8SI6LZ4X9mv-c
Message-ID: <CAOLa=ZT1Ug-UckYZ6B8KrrmzBLxVqAGJPiQfre6otoanWCs9OQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] refs: rename 'pack_refs_opts' to 'refs_optimize_opts'
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im
Content-Type: multipart/mixed; boundary="0000000000007fb49e06414591ad"

--0000000000007fb49e06414591ad
Content-Type: text/plain; charset="UTF-8"

Justin Tobler <jltobler@gmail.com> writes:

> On 25/10/15 11:25PM, Karthik Nayak wrote:
>> The previous commit removed all references to 'pack_refs()' within
>> the refs subsystem. Continue this cleanup by also renaming
>> 'pack_refs_opts' to 'refs_optimize_opts' and the respective flags
>> accordingly. Keeping the naming consistent will make the code easier to
>> maintain.
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>  pack-refs.c             |  8 ++++----
>>  refs.c                  |  2 +-
>>  refs.h                  | 16 ++++++++--------
>>  refs/debug.c            |  2 +-
>>  refs/files-backend.c    | 10 +++++-----
>>  refs/packed-backend.c   |  2 +-
>>  refs/refs-internal.h    |  2 +-
>>  refs/reftable-backend.c |  4 ++--
>>  8 files changed, 23 insertions(+), 23 deletions(-)
>>
>> diff --git a/pack-refs.c b/pack-refs.c
>> index 1a5e07d8b8..d0ffed93c1 100644
>> --- a/pack-refs.c
>> +++ b/pack-refs.c
>> @@ -14,10 +14,10 @@ int pack_refs_core(int argc,
>>  {
>>  	struct ref_exclusions excludes = REF_EXCLUSIONS_INIT;
>>  	struct string_list included_refs = STRING_LIST_INIT_NODUP;
>> -	struct pack_refs_opts pack_refs_opts = {
>> +	struct refs_optimize_opts pack_refs_opts = {
>
> We could rename the variable name here to, but probably not a big deal
> either way.
>

Since I'm re-rolling, let me do that :)

>>  		.exclusions = &excludes,
>>  		.includes = &included_refs,
>> -		.flags = PACK_REFS_PRUNE,
>> +		.flags = REFS_OPTIMIZE_PRUNE,
>>  	};
>>  	struct string_list option_excluded_refs = STRING_LIST_INIT_NODUP;
>>  	struct string_list_item *item;
>> @@ -26,8 +26,8 @@ int pack_refs_core(int argc,
>>
>>  	struct option opts[] = {
>>  		OPT_BOOL(0, "all",   &pack_all, N_("pack everything")),
>> -		OPT_BIT(0, "prune", &pack_refs_opts.flags, N_("prune loose refs (default)"), PACK_REFS_PRUNE),
>> -		OPT_BIT(0, "auto", &pack_refs_opts.flags, N_("auto-pack refs as needed"), PACK_REFS_AUTO),
>> +		OPT_BIT(0, "prune", &pack_refs_opts.flags, N_("prune loose refs (default)"), REFS_OPTIMIZE_PRUNE),
>> +		OPT_BIT(0, "auto", &pack_refs_opts.flags, N_("auto-pack refs as needed"), REFS_OPTIMIZE_AUTO),
>>  		OPT_STRING_LIST(0, "include", pack_refs_opts.includes, N_("pattern"),
>>  			N_("references to include")),
>>  		OPT_STRING_LIST(0, "exclude", &option_excluded_refs, N_("pattern"),
>> diff --git a/refs.c b/refs.c
>> index b9a4a60646..0d0831f29b 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -2313,7 +2313,7 @@ void base_ref_store_init(struct ref_store *refs, struct repository *repo,
>>  	refs->gitdir = xstrdup(path);
>>  }
>>
>> -int refs_optimize(struct ref_store *refs, struct pack_refs_opts *opts)
>> +int refs_optimize(struct ref_store *refs, struct refs_optimize_opts *opts)
>>  {
>>  	return refs->be->optimize(refs, opts);
>>  }
>> diff --git a/refs.h b/refs.h
>> index 04e917fec0..d2630af97f 100644
>> --- a/refs.h
>> +++ b/refs.h
>> @@ -500,15 +500,15 @@ void refs_warn_dangling_symrefs(struct ref_store *refs, FILE *fp,
>>
>>  /*
>>   * Flags for controlling behaviour of refs_optimize()
>> - * PACK_REFS_PRUNE: Prune loose refs after packing
>> - * PACK_REFS_AUTO: Pack refs on a best effort basis. The heuristics and end
>> - *                 result are decided by the ref backend. Backends may ignore
>> - *                 this flag and fall back to a normal repack.
>> + * REFS_OPTIMIZE_PRUNE: Prune loose refs after packing
>> + * REFS_OPTIMIZE_AUTO: Pack refs on a best effort basis. The heuristics and end
>> + *                     result are decided by the ref backend. Backends may ignore
>> + *                     this flag and fall back to a normal repack.
>>   */
>> -#define PACK_REFS_PRUNE (1 << 0)
>> -#define PACK_REFS_AUTO  (1 << 1)
>> +#define REFS_OPTIMIZE_PRUNE (1 << 0)
>> +#define REFS_OPTIMIZE_AUTO  (1 << 1)
>>
>> -struct pack_refs_opts {
>> +struct refs_optimize_opts {
>>  	unsigned int flags;
>>  	struct ref_exclusions *exclusions;
>>  	struct string_list *includes;
>> @@ -518,7 +518,7 @@ struct pack_refs_opts {
>>   * Optimize the ref store. The exact behavior is up to the backend.
>>   * For the files backend, this is equivalent to packing refs.
>>   */
>> -int refs_optimize(struct ref_store *refs, struct pack_refs_opts *opts);
>> +int refs_optimize(struct ref_store *refs, struct refs_optimize_opts *opts);
>
> I noticed when poking around the code that the optimize callback was
> still using the `pack_refs_opts`. Nice to see this clean up. :)
>
>>  /*
>>   * Setup reflog before using. Fill in err and return -1 on failure.
> [snip]
>> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
>> index 20cf9fab18..0aa0ff6701 100644
>> --- a/refs/packed-backend.c
>> +++ b/refs/packed-backend.c
>> @@ -1774,7 +1774,7 @@ static int packed_transaction_finish(struct ref_store *ref_store,
>>  }
>>
>>  static int packed_optimize(struct ref_store *ref_store UNUSED,
>> -			   struct pack_refs_opts *pack_opts UNUSED)
>> +			   struct refs_optimize_opts *pack_opts UNUSED)
>
> Also not a big deal, but we could rename `pack_opts` here to just
> `opts`. It's not even used anyways.
>
> All the other trivial renames in this patch look good.
>
> -Justin
>

Will do,

Thanks for the review.

--0000000000007fb49e06414591ad
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d4341bca59b72e9_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qdzRjc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md0U3Qy85M3NqM3IzVENVNldLVjE5dHUzS0xPYzVrYwpEbGpXUHp4cG1F
SUlhMnd0SXlVZGhuSXNONFkwSSs3b3hKWFpyN3NNNkh2cjNBeHBtMTVOUTN1cllhOUF6NWhqClFw
Y0JTdFdOc25XOEZVZVNKVEg2Y1lnTkR3czgvQ0srVGdjY3lveVU0UFhlVlBKT3hId2dDUUtaQy9p
UnMrTXEKRU51OHQ3bHlEUlFxaXdPbUFpQkkvWnR0Qml5ckwxVWtYR3VHbmg0bmtKc0h4RUJVU28z
UXdHZFZnY2J1RW4rego1WkEzTGFNZjlKalZKZWpWOVJwZ3RaMU1yMGJKSGgySElvRHRIdVZIUWxi
SEFqd3NKOTAvTHgvR2laZUtKY2M4ClYxczdTOTlUQ0JuU0I1M3ZUc2Z3MzVrNXRWOExXMTdOZFMz
VkZnSlNlY2R6WSt4cnI2TjJpSkdLalJvR0gyZXkKWW1mSXY2OXhRaXhBaDF0VDJpUXRpc1VtUXRh
ekFwQ0UwRmlFZ2pPa0VMMkZIaXBZZ0h5MittUlY0UWRsYXNNSQpyZ0dKM0FaOGZCVTFlRDRLUUpu
NzBiVmx5TDBjNGtzY25nSUMrK3FMd0l6UXJoREtMc2ZlSTlhbVhnK3VUQVN6CnNHVkIybU1sY0lj
SzFmVElyQTlGTTRsUU0xTFJOV2ZKUUNoN05pcz0KPTBsazgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000007fb49e06414591ad--
