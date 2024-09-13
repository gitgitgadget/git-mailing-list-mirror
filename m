Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412311D933A
	for <git@vger.kernel.org>; Fri, 13 Sep 2024 12:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726229518; cv=none; b=LVfSpTUt/3Fx9/80MW0ZA1iuLmsnfco+RkB2ilPRCzA4sfGDuA2KjmjFAIHtopt5q+s2G0n9SEpxkPoDCc7lmGjGck+cz5l0HU317Q5xmcATORnDOBO5kiGKPOPvoh1JriVhb5yLhN6At9PDfHa+4NdkVs/LywG0K65zQNEx5Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726229518; c=relaxed/simple;
	bh=OEks0HYSlrTeJOdDtgrRemRzNG2WgSYbzg2ogNDeEXM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IIN6EwjcjiBX2rKfteg3HRoZAaujluVK8kZOH/aSdknbOKIZav8PuDxhbYCLAldSI1EqDGWSb5uVHh3LgZJDhxxuk3JpHecpaFQdgKjlRk2kFgD6Bsm7w5SSKVfrs1Q1s29yQpNWn8pQLkP9R7Ij7UYTSQuPvPp5KLmuCBLLVwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KYs8AOTk; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYs8AOTk"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-710de2712eeso278252a34.3
        for <git@vger.kernel.org>; Fri, 13 Sep 2024 05:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726229516; x=1726834316; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=kAV0dtGNFEUPoapBXIvdHWolj0cdtHUd3iQicPJ5+cU=;
        b=KYs8AOTke4ffmkFD4LcMgi3nahGqctm1HCdLJppQUALe04OLayB/TKp4WpjBqhG5XH
         CRXp8YRbzxZNw8K4vep3psMCtQE0ALt7B2gw5aJP3NDqXQWZUA+4bpSDYghtMSoKTYm5
         XFX4MDRO/At89xXaU6vA750V+UmsJ5wVIgQdpyORAIxL103/hk75HyDe43fi2/KisGlk
         dPSWWMGPlXm6uejqICvIA0bZxar0aiawjhjCVmYJCrNEjKfoFx+2v2wviJa7RaLXp6UG
         znQ0cwaXZl6Gzx25v8B3CrE8BSUQhi64msGxuvGCr4d50SkfhBKFHAcr7hkhZKRZcjqh
         0B+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726229516; x=1726834316;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kAV0dtGNFEUPoapBXIvdHWolj0cdtHUd3iQicPJ5+cU=;
        b=Bt5Bzd5mb92Ohayp0YGiPBd06lD4zK99eBfgnY847a94XYXOR6y4FL8vurnkUV4xuz
         JdJL67IhFhE5O2KmN1cJAOfqIUVftokGDFQrNsQwrDM5cvnd35HbPv2q14LE6dMFox5Z
         dzjGpUKz2PCqnytRonOeAIDb67mwDo5wrHOedhaMfCMYopTxN7CEa3UoxC2Me3xKGYN9
         OgYLZ5qsNAV3bjCMFMzzMgis825g2MkcX3YxC794iXG/5KsFeUQU8Q3SXut9rJu39Iu8
         UJhJdiKZ2/aMwe2fpqwtbWO1axfv8qHr/r4SzPG/uUG4jyysCNiGmqAYJhsXn+63dN3O
         Ww1Q==
X-Forwarded-Encrypted: i=1; AJvYcCW82UYBaNamYAOaYFIKRSAjZ1ey3v/m9Z7PIG9/TPUQtrKgsFMiih7HIQhDXsyRL5DC4+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTtpTXRYFQ4gKG3iDfC9L9LHsvh/0pkFgkxWzORjVxMHkvGtVy
	MXA78/8yi7X4EN8UHePd9aTFA9TlL/55U+Kn92x58FYG/4PLQ6I8indGCkR651OTmkZnmrF+A2K
	0uPwOmAXV/yYBybBb6p04cD7ojtY=
X-Google-Smtp-Source: AGHT+IEiqN9FBptbAmk3pY2+qj+s512TeDuMjRqPt012odWnC5UgbPfA7xUNUdZjtRlkFps/3Bez8TPUmyKYAupIrws=
X-Received: by 2002:a05:6358:50c4:b0:1b8:2cf8:cf6 with SMTP id
 e5c5f4694b2df-1bc396772edmr42671755d.25.1726229516036; Fri, 13 Sep 2024
 05:11:56 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 13 Sep 2024 07:11:54 -0500
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <a281f936a2b3a697b32f57652a2120afd54f7e4f.1725881266.git.ps@pks.im>
References: <cover.1725881266.git.ps@pks.im> <a281f936a2b3a697b32f57652a2120afd54f7e4f.1725881266.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 13 Sep 2024 07:11:54 -0500
Message-ID: <CAOLa=ZRA=vFjnWZC7PQBAxOxDfD9X6767ddgBqwaen5n6JLt0w@mail.gmail.com>
Subject: Re: [PATCH 5/6] reftable/reader: make table iterator reseekable
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Content-Type: multipart/mixed; boundary="0000000000001b79ca0621ff219c"

--0000000000001b79ca0621ff219c
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

[snip]

> diff --git a/t/unit-tests/t-reftable-merged.c b/t/unit-tests/t-reftable-merged.c
> index b8c92fdb365..19e54bdfb8b 100644
> --- a/t/unit-tests/t-reftable-merged.c
> +++ b/t/unit-tests/t-reftable-merged.c
> @@ -194,6 +194,81 @@ static void t_merged_refs(void)
>  	reftable_free(bs);
>  }
>
> +static void t_merged_seek_multiple_times(void)
> +{
> +	struct reftable_ref_record r1[] = {
> +		{
> +			.refname = (char *) "a",
> +			.update_index = 1,
> +			.value_type = REFTABLE_REF_VAL1,
> +			.value.val1 = { 1 },
> +		},
> +		{
> +			.refname = (char *) "c",
> +			.update_index = 1,
> +			.value_type = REFTABLE_REF_VAL1,
> +			.value.val1 = { 2 },
> +		}
> +	};
> +	struct reftable_ref_record r2[] = {
> +		{
> +			.refname = (char *) "b",
> +			.update_index = 2,
> +			.value_type = REFTABLE_REF_VAL1,
> +			.value.val1 = { 3 },
> +		},
> +		{
> +			.refname = (char *) "d",
> +			.update_index = 2,
> +			.value_type = REFTABLE_REF_VAL1,
> +			.value.val1 = { 4 },
> +		},
> +	};
> +	struct reftable_ref_record *refs[] = {
> +		r1, r2,
> +	};
> +	size_t sizes[] = {
> +		ARRAY_SIZE(r1), ARRAY_SIZE(r2),
> +	};
> +	struct strbuf bufs[] = {
> +		STRBUF_INIT, STRBUF_INIT,
> +	};
> +	struct reftable_block_source *sources = NULL;
> +	struct reftable_reader **readers = NULL;
> +	struct reftable_ref_record rec = { 0 };
> +	struct reftable_iterator it = { 0 };
> +	struct reftable_merged_table *mt;
> +
> +	mt = merged_table_from_records(refs, &sources, &readers, sizes, bufs, 2);
> +	merged_table_init_iter(mt, &it, BLOCK_TYPE_REF);
> +
> +	for (size_t i = 0; i < 5; i++) {
> +		int err = reftable_iterator_seek_ref(&it, "c");
> +		check(!err);
> +
> +		err = reftable_iterator_next_ref(&it, &rec);
> +		check(!err);
> +		err = reftable_ref_record_equal(&rec, &r1[1], GIT_SHA1_RAWSZ);
> +		check(err == 1);
> +
> +		err = reftable_iterator_next_ref(&it, &rec);
> +		check(!err);
> +		err = reftable_ref_record_equal(&rec, &r2[1], GIT_SHA1_RAWSZ);
> +		check(err == 1);
> +

So this skips r2[0] because when we seek, we seek all sub-iterators. So
in r2 we seek to 'd' since that is the next alphabetical value.

[snip]

> diff --git a/t/unit-tests/t-reftable-reader.c b/t/unit-tests/t-reftable-reader.c
> new file mode 100644
> index 00000000000..7a46580b6f1
> --- /dev/null
> +++ b/t/unit-tests/t-reftable-reader.c
> @@ -0,0 +1,96 @@
> +#include "test-lib.h"
> +#include "lib-reftable.h"
> +#include "reftable/blocksource.h"
> +#include "reftable/reader.h"
> +
> +static int t_reader_seek_once(void)
> +{
> +	struct reftable_ref_record records[] = {
> +		{
> +			.refname = (char *) "refs/heads/main",
> +			.value_type = REFTABLE_REF_VAL1,
> +			.value.val1 = { 42 },
> +		},
> +	};
> +	struct reftable_block_source source = { 0 };
> +	struct reftable_ref_record ref = { 0 };
> +	struct reftable_iterator it = { 0 };
> +	struct reftable_reader *reader;
> +	struct strbuf buf = STRBUF_INIT;
> +	int ret;
> +
> +	t_reftable_write_to_buf(&buf, records, ARRAY_SIZE(records), NULL, 0, NULL);
> +	block_source_from_strbuf(&source, &buf);
> +
> +	ret = reftable_reader_new(&reader, &source, "name");
> +	check_int(ret, ==, 0);
> +
> +	reftable_reader_init_ref_iterator(reader, &it);
> +	ret = reftable_iterator_seek_ref(&it, "");
> +	check_int(ret, ==, 0);
> +	ret = reftable_iterator_next_ref(&it, &ref);
> +	check_int(ret, ==, 0);
> +
> +	ret = reftable_ref_record_equal(&ref, &records[0], 20);

s/20/GIT_SHA1_RAWSZ

Also here and elsewhere, shouldn't we just do
`check(reftable_ref_record_equal(...))` or even
`!check(reftable_iterator_seek_ref(...))` ?

[snip]

--0000000000001b79ca0621ff219c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 21ba941f52973133_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ia0xBVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMEtMREFDUnRiMElZTjJGQXN4VnZkcEpGSUU2VzV3SQpyS2tROFoyc0k3
QllBVHAwVHp5OEZpVFlHbkdQOGxNZjdlTjN3dWQ2VHhZcHJKeWRWc0hzdVdtN3dvN1NsQWhOCnNF
QjRmQjg1VnVZeGZnR2ptTHNMTFFRMFVuOWZ5aHN1bjhERnJBNk1NU2hNem5tM1lzaGdyRFhGQVVa
UHNCMkEKVndmN0JlMDZxZnJFZUluSC9NUnkyc0xjUW9uNVRUc25PaFN1SUlrREFNRXFSeHp6bmRo
S2FpWFViUEFWUmJVWQpSNU5WckpYdzg1dUhVK0VIQytDOFNkVzZObHNNMEg0ZU9qcUF5bHEvbkhL
NkVQc3I0ZTJRZXlrdXRYMW0zVDVhCmxZY0l1WEZPNUtGTFU5QUpOak12U010S25UempjWUxUcG9n
Yis4TThDTVhDMGNkNXZ4OGZuR2daUTJtYnZzeisKQTFOZWNoVVROaDJHaXB2eXozZS8rWU1jWU5Q
T1J1N0ZpWC9SZzhLRXJ3WUoyOThnbnB4YnBGcWtKUk1WempDYQpzY2lZcVZNb1QyU0E0V3ErWnNR
Y3NUSm5GcG11a2RIdWxLNG02MCsyTGdhRXRxNElPcHQ1NUt4bmVic3pETUJsCjc2NHh3VHk1RnIy
azh0c0dHZ2NCUjcwZSswb3ZhVHBscVgybkdjQT0KPUZQQXQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000001b79ca0621ff219c--
