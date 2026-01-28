Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094352D5410
	for <git@vger.kernel.org>; Wed, 28 Jan 2026 10:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769596682; cv=pass; b=GRPdxASsqvHJdfpjS74IO9tq+3TJo+5lusCFYnEXIPoS75V0gCrfs1dgYzNmRSb7YFv5cJfl04SozTzc5Qj/oi5PG8plRJDpqpap3TmfdDeCX9seULg+DG/sEEF6rxLSLubWNmO4KTCWl5masMj2915YMaTpJGt2qRKcRxX2Gy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769596682; c=relaxed/simple;
	bh=0rbW2Q+/6Unifc8YtVKpkDtLHBwpHRyYKGaKsNxnFIw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XeNbBBWfWOLA5OlNrxKpdT8/PNajVKbJMkao5OJ8bwWq4toH+946FgLryBhL8HCaRrX3mYTOjRrNP2noM/T6TZC26qVeKbGvIP9rWVRIhR5URsWkyfuMtDqMamIlzERYuJCHMvQwWu19vj7fshZFQDY8DW2lYfdrNRd6RmZaBDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQeBKIme; arc=pass smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQeBKIme"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-5f535ff78abso5223259137.1
        for <git@vger.kernel.org>; Wed, 28 Jan 2026 02:37:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769596677; cv=none;
        d=google.com; s=arc-20240605;
        b=FXtdVp12JvowwxEtEiQhoVnlCreeMqz26GDZmqGrvbpjbzamtdxzMXQzIlskMwn5+O
         d+HBLsrgxX37p8Lu9bAXt0YURQ2cbs0pOjHuivfmKTnla9Yr36Kg+1SsBDBBwFdbXTDc
         7iwtd+ggDzlS5Gv0zjlStt9E9fhE0T+siVMzfAE1s0hcCPxc4vX8dVFnoHXnI2GavvYF
         INB/gBwgOpzggDTGufxYU4YwZT4+8jnuXwJayKk5vNqBBsuPwgg9/O80X9qohIiDZlg9
         jXrTGeWYtY86Qwh6w5yUaxx/mqUTAZx7IHKyUfoMwEI4UA8gbBn7dj4jutJDRBd+K0cz
         Aitw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=61SWqkrBcyiTFNzIkITFw+QQPeiskdxJCMByrRAbESo=;
        fh=l99NfpQSC0mbyedkkA0shGKzN4QNsvyNMWSf3HAqkn0=;
        b=irjW/nIK7V6kvcwuDvDrY0ADxLDIWzupKGKgbmymGQa5XJ7xWov9mpq+wuvox2IUCX
         FwwUrdcBHlhsQ8aQv8lsEpCRLi5WopadE+SZcoTu2MseFjdZ65PHXBvoUGokqV1cc2BI
         7CX9FAbGJPSWICMsADsIjC/pzDZw5RxRCCUa6E0s+0rtMyLbi1Pz8eVR+6GkbwHjVTUO
         5Pzx4d1irx+n6RrfancPJQxyodIsFRs9AhatSyFVvG1J7sPmI1Lc9PZo0i3IdOmIP2Ib
         mxnYgCTKMsPlxgZU4fUoABp55auspjGVn0ngsQgDEhz2X/Li5oqFCXWBEXqUAzPBGvuX
         KNKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769596677; x=1770201477; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=61SWqkrBcyiTFNzIkITFw+QQPeiskdxJCMByrRAbESo=;
        b=DQeBKImewc2h4fX/v9R3AY7hWrjNTPmmzHoUqadC4XqP8FLkKJt5q+5mZ2/xR+QGXv
         gAMeLLSRuFfRxrb+kZOdL/iYrLnTkThn9USzl7VJtR93Ieb/WFJ+tS/cUdOm37tHLRA7
         lLhTyvH7chW/IIE/DEiVJEx1xPTIBi2uhbYccrd9gaVDrALui74gwJ1y+Qa1UVmqeQkM
         q2sclf/BAmNcjfKa82mbcmY2Pq47cvB3uM4XwmRiIcURBEV7jDTjCKg6fIQLjm7i3tko
         EmuVUIhzw2Bd2t+Ar9HarQONsev9KJeyUTxXsthufLMzJ7SLffQ3IcGCNDoh7hMoph5i
         s6EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769596677; x=1770201477;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=61SWqkrBcyiTFNzIkITFw+QQPeiskdxJCMByrRAbESo=;
        b=Fr8Dz88UH0yAfMbTYvqD5dRisJluXN+Np3oa0P/qQkYXPC4D7r+Oxgg3yuv/S5/8NF
         r/KxpZrvsoV32MyqQ1XLCujU5//SkzaCd3bG6QUMPJa5VN6hXyOZh9VNKIH5nnaFKrbe
         Ot0UXkBT1ZMiMFLoy9usZR23dV5h40SYOMgBnvUkt1lrTb+zIk6efFKCv2b2jaCD6x6z
         KRrXivQBszwVtn8budsLrrZfbRj5gUvXUM5Gp/TVpz5ay32GXcG8whwMBz9AIc/4a9YT
         NPg/r9TB65IVeVp6JmvezA0il3lcW16KVLLKDZv3sgq0aJeebXWhGA6cZcezcFwcfhHj
         SNzw==
X-Forwarded-Encrypted: i=1; AJvYcCVEPsemQFL4V+gsrKGaGkCsDuHbVAaozIYezNsGAsLZL6g+wWUhpZXICHI4Q8ZMvJQ+HH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQYDqcCh2qnv8O1XTp9CrwxBJWD7kaaELsCYHnqgSGtvFUQWsO
	AhCdXhUiDo4pXkcSotwbXI3RFhmECyIeEt0elLwN2N/tiovEttmpr0Rtfu//7CcRFH6DZ8sgryT
	TkeF3gXZSyg6kZZUOkxETpWd43J2OqHUmxUl0
X-Gm-Gg: AZuq6aKWfsIoBDt+PztdzSEXVWVpcfrSwaj2BxCw6q9TiTp1qzH9sn588uucyaECGcj
	rZTSzfNJfdBaYUPHshA7kdChGiGsIV1rVJfoyh5h9yTpozfRJcjD1KM5vl69xA8Y8EF/s030ukB
	w/p5SUdcLVuHNt+iG66u58mpu+nSa2BtIsOszRu/O3pmsC8zcXDWoAFzW8wRt957BjK213+uEup
	9s1JDZSNOYXvHX7Voybb4gHDNM+3+Aok+NAg3NO2oqh1M8j3dsW/jL9S1itvm/eCcm5FatSHxhh
	pht3JXBdH5r2vMYFozOxF5S5ymNQAQ==
X-Received: by 2002:a05:6102:3a0a:b0:5ee:a590:6b11 with SMTP id
 ada2fe7eead31-5f7237ba947mr1727437137.36.1769596677027; Wed, 28 Jan 2026
 02:37:57 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Jan 2026 04:37:55 -0600
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Jan 2026 04:37:55 -0600
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260128-b4-pks-fix-for-each-ref-in-misuse-v1-1-deccae3ea725@pks.im>
References: <20260128-b4-pks-fix-for-each-ref-in-misuse-v1-0-deccae3ea725@pks.im>
 <20260128-b4-pks-fix-for-each-ref-in-misuse-v1-1-deccae3ea725@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 28 Jan 2026 04:37:55 -0600
X-Gm-Features: AZwV_QhkWyud70r2-SpOZZ9KvniT6pn0s59GNQ7OZEnkqHpy6HrrLvSKDdm3lRA
Message-ID: <CAOLa=ZQ5FGoarzZFe8jg51rpL4-s9H8i-z+3XV6T0A86YevLKA@mail.gmail.com>
Subject: Re: [PATCH 1/3] pack-bitmap: deduplicate logic to iterate over
 preferred bitmap tips
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Content-Type: multipart/mixed; boundary="00000000000055458406497055e6"

--00000000000055458406497055e6
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> We have two locations that iterate over the preferred bitmap tips as
> configured by the user via "pack.preferBitmapTips". Both of these
> callsites are subtly wrong and can lead to a `BUG()`, which we'll fix in
> a subsequent commit.
>
> Prepare for this fix by unifying the two callsites into a new
> `for_each_preferred_bitmap_tip()` function.
>
> This removes the last callsite of `bitmap_preferred_tips()` outside of
> "pack-bitmap.c". As such, convert the function to be local to that file
> only.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/pack-objects.c | 19 ++-----------------
>  pack-bitmap.c          | 18 +++++++++++++++++-
>  pack-bitmap.h          |  9 ++++++++-
>  repack-midx.c          | 14 +++-----------
>  4 files changed, 30 insertions(+), 30 deletions(-)
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 5846b6a293..979470e402 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -4554,22 +4554,6 @@ static int mark_bitmap_preferred_tip(const struct reference *ref, void *data UNU
>  	return 0;
>  }
>
> -static void mark_bitmap_preferred_tips(void)
> -{
> -	struct string_list_item *item;
> -	const struct string_list *preferred_tips;
> -
> -	preferred_tips = bitmap_preferred_tips(the_repository);
> -	if (!preferred_tips)
> -		return;
> -
> -	for_each_string_list_item(item, preferred_tips) {
> -		refs_for_each_ref_in(get_main_ref_store(the_repository),
> -				     item->string, mark_bitmap_preferred_tip,
> -				     NULL);
> -	}
> -}
> -
>  static inline int is_oid_uninteresting(struct repository *repo,
>  				       struct object_id *oid)
>  {
> @@ -4710,7 +4694,8 @@ static void get_object_list(struct rev_info *revs, struct strvec *argv)
>  		load_delta_islands(the_repository, progress);
>
>  	if (write_bitmap_index)
> -		mark_bitmap_preferred_tips();
> +		for_each_preferred_bitmap_tip(the_repository, mark_bitmap_preferred_tip,
> +					      NULL);
>
>  	if (!fn_show_object)
>  		fn_show_object = show_object;
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index 972203f12b..2f5cb34009 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -3314,7 +3314,7 @@ int bitmap_is_midx(struct bitmap_index *bitmap_git)
>  	return !!bitmap_git->midx;
>  }
>
> -const struct string_list *bitmap_preferred_tips(struct repository *r)
> +static const struct string_list *bitmap_preferred_tips(struct repository *r)
>  {
>  	const struct string_list *dest;
>
> @@ -3323,6 +3323,22 @@ const struct string_list *bitmap_preferred_tips(struct repository *r)
>  	return NULL;
>  }
>
> +void for_each_preferred_bitmap_tip(struct repository *repo,
> +				   each_ref_fn cb, void *cb_data)
> +{
> +	struct string_list_item *item;
> +	const struct string_list *preferred_tips;
> +
> +	preferred_tips = bitmap_preferred_tips(repo);
> +	if (!preferred_tips)
> +		return;
> +

So we move the config check here. Instead of individually checking it.
Makes sense.

> +	for_each_string_list_item(item, preferred_tips) {
> +		refs_for_each_ref_in(get_main_ref_store(repo),
> +				     item->string, cb, cb_data);
> +	}
> +}
> +
>  int bitmap_is_preferred_refname(struct repository *r, const char *refname)
>  {
>  	const struct string_list *preferred_tips = bitmap_preferred_tips(r);
> diff --git a/pack-bitmap.h b/pack-bitmap.h
> index 1bd7a791e2..d0611d0481 100644
> --- a/pack-bitmap.h
> +++ b/pack-bitmap.h
> @@ -5,6 +5,7 @@
>  #include "khash.h"
>  #include "pack.h"
>  #include "pack-objects.h"
> +#include "refs.h"
>  #include "string-list.h"
>
>  struct commit;
> @@ -99,6 +100,13 @@ int for_each_bitmapped_object(struct bitmap_index *bitmap_git,
>  			      show_reachable_fn show_reach,
>  			      void *payload);
>
> +/*
> + * Iterate over all references that are configured as preferred bitmap tips via
> + * "pack.preferBitmapTips" and invoke the callback on each function.
> + */
> +void for_each_preferred_bitmap_tip(struct repository *repo,
> +				   each_ref_fn cb, void *cb_data);
> +
>  #define GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL \
>  	"GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL"
>
> @@ -182,7 +190,6 @@ char *pack_bitmap_filename(struct packed_git *p);
>
>  int bitmap_is_midx(struct bitmap_index *bitmap_git);
>
> -const struct string_list *bitmap_preferred_tips(struct repository *r);
>  int bitmap_is_preferred_refname(struct repository *r, const char *refname);
>
>  int verify_bitmap_files(struct repository *r);
> diff --git a/repack-midx.c b/repack-midx.c
> index 74bdfa3a6e..0682b80c42 100644
> --- a/repack-midx.c
> +++ b/repack-midx.c
> @@ -40,7 +40,6 @@ static int midx_snapshot_ref_one(const struct reference *ref, void *_data)
>  void midx_snapshot_refs(struct repository *repo, struct tempfile *f)
>  {
>  	struct midx_snapshot_ref_data data;
> -	const struct string_list *preferred = bitmap_preferred_tips(repo);
>
>  	data.repo = repo;
>  	data.f = f;
> @@ -51,16 +50,9 @@ void midx_snapshot_refs(struct repository *repo, struct tempfile *f)
>  		 die(_("could not open tempfile %s for writing"),
>  		     get_tempfile_path(f));
>
> -	if (preferred) {
> -		struct string_list_item *item;
> -
> -		data.preferred = 1;
> -		for_each_string_list_item(item, preferred)
> -			refs_for_each_ref_in(get_main_ref_store(repo),
> -					     item->string,
> -					     midx_snapshot_ref_one, &data);
> -		data.preferred = 0;
> -	}
> +	data.preferred = 1;
> +	for_each_preferred_bitmap_tip(repo, midx_snapshot_ref_one, &data);
> +	data.preferred = 0;
>

So we no longer need to check for the config, since
`for_each_preferred_bitmap_tip()` does that. Looks good.

>  	refs_for_each_ref(get_main_ref_store(repo),
>  			  midx_snapshot_ref_one, &data);
>
> --
> 2.53.0.rc2.206.g60c1bca835.dirty

--00000000000055458406497055e6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 442b38437664626b_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1sNTV2d1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNVVQQy85OU1yajhVTEtFd3FBaFJtV09YQW9WTnAvcgo5LzhSbjJHVm9m
TDNFTU9vb051NGdJeXpheHNBcEFTbXVSQWNBZStuc0JzVVBzOUQra3VMa3pwOVhLdFdST1BqClBq
cGJseVMzb0pPd0V6cE8xQTlYMHRHSURqeTM2cGlsUGd0TVYraFJ3MkpRdmltemcrMVpuNVViZ0do
UDU5YmoKd2JaTlJ4eE42dGk3QTdIejErb21WdVliODkxdmF0eFpxZ1l2N1pXdFpRK2laNjZ4SU9P
bWRQaStyVUVWYkpOaApucStscTVOd0t0VEZTNTM5V2R3ZWR5LzJwRDBMbDZaaFg1WGZ2bVZxQkhU
anhXMFJ6LzA1cTZDSTR6S0VDNUVNClBUSGdveVdYVlBOQWIrZERSenAvak8vRnhFU1ZidkNKVytu
eVUwK3NlMFdZdno3WFc0T1dkcXBpQ0JJbWkxaXMKYWNoY3JvU0I2NWc3QlliVFNJYk14OG5Ia01L
MDlWc1E1RjA3R2d4Nndmby93OFh6WUw0dUZTMkpObEtSMmlybwp2dWdWaFBRZDNCOE5GRFhGWVN3
cWlCem9DSlg4K3BDbUdZWE43YkRGMTgzNklqcWVZMUgxeUc0UlNBUjN6S3c3CkhXSDVVbE8xQ0pF
U1U3VVBvUng3N0Uza0pzTHpDMnE4N25IRnZ3OD0KPXdrWnEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000055458406497055e6--
