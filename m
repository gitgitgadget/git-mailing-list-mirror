Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15F8225768
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 11:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740656302; cv=none; b=Hcyw8CCezMb40Q8axAOZfBeB95KjFxhh97Y+WIGjLYPsSqSHDRkpc30Uwogh2S9kIgTLPZbFfm81lILXCXsll8GOANK/oYHJvcQ8zgNK131KGvaYgkGRvKusT+Dweq/wQD6byxdZvlyXeCCjUN6JjJHfwuam/WEhJwZCsBRAT0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740656302; c=relaxed/simple;
	bh=7neR6vUutXtvDccultKxdbgCRad6c1OiQg8OXgNOPGY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=tnEHKYEpeE0MTB6Jm8eFPrFTXGfOZ0UARsEUPLihLTp2df22tPayPvLrMOnt6CfIhA1kaqbA1yCXJW3tMJtsOEcS4SrOckT+Qm4pCi8O/33BAS5x6pv7GzjR/ueLHWjmK2Y2kG4U3R3e2Sf2TXAK9OHulG2ugIITdXQh+mUxU/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPqhdhwx; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPqhdhwx"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-869440f201eso688255241.3
        for <git@vger.kernel.org>; Thu, 27 Feb 2025 03:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740656299; x=1741261099; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nUbkiwF71GTghdqzm2mcA875Pz25JlOrjrmwlyCMcto=;
        b=jPqhdhwxoCb1gVQeeDeCQawgZc9PXnjZpauT890ir+iAMBOzeC+xzVIo2LN5OBXQnQ
         F/m5kQNX9b0umRVoKp6FTNJBzfr1qAVooDuXK5nAQxiJ3PGuc8xf5d6LqRI1Be8rOvnT
         cqVsQjMSB/Jiu/w061CSAMK6zICTDL3eZdnJ4ikAoYcobRUSrfBDc5Q+V1dlN9fUC+Iy
         3A3+LqyotUh1zTpjtwiySkdYaq0DWfDQDnWDCSaNXKk378rXtBNUj7LiLnOGqLD8iEOB
         ms+vFWIEbDWi0zwuK/f6EJnoZk678IocwN/URo805PDBLybLHSIapnwAvFsFgjVEimGH
         E7Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740656299; x=1741261099;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nUbkiwF71GTghdqzm2mcA875Pz25JlOrjrmwlyCMcto=;
        b=DtCov1vihzbbChdjGJPDorswYtaI6HwacOp2i9eh8pUk3XLnl6/mHYAIslg3ucUjlg
         CLBbh96+D7whi+7ZqIjfZGYyw3HHTJbRqSLqSqP9ehwBEoruhshv1Wz+0lS6ULgxy0zE
         4yM7f+bBcUQGUU2wbj7zaDgI44VwB/59aJBEbyTNIAJ4zQXFlkeqOoxqfFFpGv3pZf30
         hkb3WAJGVgS2GAvkqrKKgLgB6rbJo+Lsu+HUDnw7E4gfvBzXfHRrxyQ0T3paKQWIecRS
         92ooMI+fLaGhiGUzOCAJAZSztt25El4UJZOgb0RhCHg9r7/QjWOPw3f5GzqvuYkzybqA
         5BwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwIzSgwENkEf+WHDB70e3PZAAbRf89k3M/6yXuFAWAmy+C4osuSJg5YClOv5lJwuVCH6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVQL4e8bqmcCWzuazjlZaW4p9T/WLCCKT+eYtyGKaCzVme4S0Q
	NBGTKuSm0zTqZute4ToNGZXJsEn8ZGHW1gb+W6VWrL4gpu9980QViTUuwkrA011aEZ0/dt9jAiX
	huvgF44CSLDZzbDTlGm6jN9uB5kIxOrRH
X-Gm-Gg: ASbGncvdsgdWHZARp3czkIa3u7Lj07M5WsMqlDgm6c6oKoztJ50wdk233czej8kJGbf
	xujoEedfzW4gWyvhRuMlbK/UsSWcIb1yf6OcWOspfIVqkOOiFqxAKAmMwMkYeyPpckEiSDWEdlW
	WjsmiVZeBaRX2KxQS1d3QueamA8zMqiRs7wn+567mb
X-Google-Smtp-Source: AGHT+IFvXpp0d0m8SsWJh+ZuQetTri9L+ykoeWZCMy4o2BByiJA9JzKQOxIJxL8WHJWrjgbfBaAehbCPXhPFdGhC8BQ=
X-Received: by 2002:a05:6102:d91:b0:4bb:623:e1f7 with SMTP id
 ada2fe7eead31-4bfc28ed564mr12856948137.16.1740656299343; Thu, 27 Feb 2025
 03:38:19 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Feb 2025 03:38:18 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250221-pks-cat-file-object-type-filter-v1-9-0852530888e2@pks.im>
References: <20250221-pks-cat-file-object-type-filter-v1-0-0852530888e2@pks.im>
 <20250221-pks-cat-file-object-type-filter-v1-9-0852530888e2@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 27 Feb 2025 03:38:18 -0800
X-Gm-Features: AQ5f1JqdbpB0G3ymIqV9IPXJk6hS9xGE2GNGKgjs4MuitiYx45Qi1MRXGHg-ym0
Message-ID: <CAOLa=ZTbhar6Qyf9Q1r1cOHpVFCWmUySg57wNgoKgSCwgEtAKQ@mail.gmail.com>
Subject: Re: [PATCH 9/9] builtin/cat-file: use bitmaps to efficiently filter
 by object type
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000006629ca062f1e2014"

--0000000000006629ca062f1e2014
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Patrick Steinhardt <ps@pks.im> writes:

> While it is now possible to filter objects by type, this mechanism is
> for now mostly a convenience. Most importantly, we still have to iterate
> through the whole packfile to find all objects of a specific type. This
> can be prohibitively expensive depending on the size of the packfiles.
>
> It isn't really possible to do better than this when only considering a
> packfile itself, as the order of objects is not fixed. But when we have
> a packfile with a corresponding bitmap, either because the packfile
> itself has one or because the multi-pack index has a bitmap for it, then
> we can use these bitmaps to improve the runtime.
>
> While bitmaps are typically used to compute reachability of objects,
> they also contain one bitmap per object type encodes which object has

perhaps s/type encodes/type that encodes/

> what type. So instead of reading through the whole packfile(s), we can
> use the bitmaps and iterate through the type-specific bitmap. Typically,
> only a subset of packfiles will have a bitmap. But this isn't really
> much of a problem: we can use bitmaps when available, and then use the
> non-bitmap walk for every packfile that isn't covered by one.
>
> Overall, this leads to quite a significant speedup depending on how many
> objects of a certain type exist. The following benchmarks have been
> executed in the Chromium repository, which has a 50GB packfile with
> almost 25 million objects:
>
>     Benchmark 1: git cat-file --batch-check --batch-all-objects --unorder=
ed --buffer --no-objects-filter
>       Time (mean =C2=B1 =CF=83):     82.806 s =C2=B1  6.363 s    [User: 3=
0.956 s, System: 8.264 s]
>       Range (min =E2=80=A6 max):   73.936 s =E2=80=A6 89.690 s    10 runs
>
>     Benchmark 2: git cat-file --batch-check --batch-all-objects --unorder=
ed --buffer --objects-filter=3Dobject:type=3Dtag
>       Time (mean =C2=B1 =CF=83):      20.8 ms =C2=B1   1.3 ms    [User: 6=
.1 ms, System: 14.5 ms]
>       Range (min =E2=80=A6 max):    18.2 ms =E2=80=A6  23.6 ms    127 run=
s
>
>     Benchmark 3: git cat-file --batch-check --batch-all-objects --unorder=
ed --buffer --objects-filter=3Dobject:type=3Dcommit
>       Time (mean =C2=B1 =CF=83):      1.551 s =C2=B1  0.008 s    [User: 1=
.401 s, System: 0.147 s]
>       Range (min =E2=80=A6 max):    1.541 s =E2=80=A6  1.566 s    10 runs
>
>     Benchmark 4: git cat-file --batch-check --batch-all-objects --unorder=
ed --buffer --objects-filter=3Dobject:type=3Dtree
>       Time (mean =C2=B1 =CF=83):     11.169 s =C2=B1  0.046 s    [User: 1=
0.076 s, System: 1.063 s]
>       Range (min =E2=80=A6 max):   11.114 s =E2=80=A6 11.245 s    10 runs
>
>     Benchmark 5: git cat-file --batch-check --batch-all-objects --unorder=
ed --buffer --objects-filter=3Dobject:type=3Dblob
>       Time (mean =C2=B1 =CF=83):     67.342 s =C2=B1  3.368 s    [User: 2=
0.318 s, System: 7.787 s]
>       Range (min =E2=80=A6 max):   62.836 s =E2=80=A6 73.618 s    10 runs
>
>     Benchmark 6: git cat-file --batch-check --batch-all-objects --unorder=
ed --buffer --objects-filter=3Dblob:none
>       Time (mean =C2=B1 =CF=83):     13.032 s =C2=B1  0.072 s    [User: 1=
1.638 s, System: 1.368 s]
>       Range (min =E2=80=A6 max):   12.960 s =E2=80=A6 13.199 s    10 runs
>
>     Summary
>       git cat-file --batch-check --batch-all-objects --unordered --buffer=
 --objects-filter=3Dobject:type=3Dtag
>        74.75 =C2=B1 4.61 times faster than git cat-file --batch-check --b=
atch-all-objects --unordered --buffer --objects-filter=3Dobject:type=3Dcomm=
it
>       538.17 =C2=B1 33.17 times faster than git cat-file --batch-check --=
batch-all-objects --unordered --buffer --objects-filter=3Dobject:type=3Dtre=
e
>       627.98 =C2=B1 38.77 times faster than git cat-file --batch-check --=
batch-all-objects --unordered --buffer --objects-filter=3Dblob:none
>      3244.93 =C2=B1 257.23 times faster than git cat-file --batch-check -=
-batch-all-objects --unordered --buffer --objects-filter=3Dobject:type=3Dbl=
ob
>      3990.07 =C2=B1 392.72 times faster than git cat-file --batch-check -=
-batch-all-objects --unordered --buffer --no-objects-filter
>
> The first benchmark is mostly equivalent in runtime compared to all the
> others without the bitmap-optimization introduced in this commit. What
> is noticeable in the benchmarks is that we're I/O-bound, not CPU-bound,
> as can be seen from the user/system runtimes, which is often way lower
> than the overall benchmarked runtime.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/cat-file.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++=
+-----
>  1 file changed, 50 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 25d5429e391..9021fd52f30 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -21,6 +21,7 @@
>  #include "streaming.h"
>  #include "oid-array.h"
>  #include "packfile.h"
> +#include "pack-bitmap.h"
>  #include "object-file.h"
>  #include "object-name.h"
>  #include "object-store-ll.h"
> @@ -805,7 +806,20 @@ static int batch_one_object_packed(const struct obje=
ct_id *oid,
>  				 payload->payload);
>  }
>
> -static void batch_each_object(for_each_object_fn callback,
> +static int batch_one_object_bitmapped(const struct object_id *oid,
> +				      enum object_type type UNUSED,
> +				      int flags UNUSED,
> +				      uint32_t hash UNUSED,
> +				      struct packed_git *pack,
> +				      off_t offset,
> +				      void *_payload)
> +{
> +	struct for_each_object_payload *payload =3D _payload;
> +	return payload->callback(oid, pack, offset, payload->payload);
> +}
> +
> +static void batch_each_object(struct batch_options *opt,
> +			      for_each_object_fn callback,
>  			      unsigned flags,
>  			      void *_payload)
>  {
> @@ -813,9 +827,40 @@ static void batch_each_object(for_each_object_fn cal=
lback,
>  		.callback =3D callback,
>  		.payload =3D _payload,
>  	};
> +	struct bitmap_index *bitmap =3D prepare_bitmap_git(the_repository);
> +
>  	for_each_loose_object(batch_one_object_loose, &payload, 0);
> -	for_each_packed_object(the_repository, batch_one_object_packed,
> -			       &payload, flags);
> +
> +	if (bitmap &&
> +	    (opt->objects_filter.choice =3D=3D LOFC_OBJECT_TYPE ||
> +	     opt->objects_filter.choice =3D=3D LOFC_BLOB_NONE)) {
> +		struct packed_git *pack;
> +
> +		if (opt->objects_filter.choice =3D=3D LOFC_OBJECT_TYPE) {
> +			for_each_bitmapped_object(bitmap, opt->objects_filter.object_type,
> +						  batch_one_object_bitmapped, &payload);
> +		} else {

Nit: while this can be derived from the if statement above, it would be
more readable if this was `if else (opt->objects_filter.choice =3D=3D
LOFC_BLOB_NONE)`

> +			for_each_bitmapped_object(bitmap, OBJ_COMMIT,
> +						  batch_one_object_bitmapped, &payload);
> +			for_each_bitmapped_object(bitmap, OBJ_TAG,
> +						  batch_one_object_bitmapped, &payload);
> +			for_each_bitmapped_object(bitmap, OBJ_TREE,
> +						  batch_one_object_bitmapped, &payload);
> +		}
> +
> +		for (pack =3D get_all_packs(the_repository); pack; pack =3D pack->next=
) {
> +			if (bitmap_index_contains_pack(bitmap, pack) ||
> +			    open_pack_index(pack))
> +				continue;
> +			for_each_object_in_pack(pack, batch_one_object_packed,
> +						&payload, flags);
> +		}
> +	} else {
> +		for_each_packed_object(the_repository, batch_one_object_packed,
> +				       &payload, flags);
> +	}
> +
> +	free_bitmap_index(bitmap);
>  }
>
>  static int batch_objects(struct batch_options *opt)
> @@ -872,14 +917,14 @@ static int batch_objects(struct batch_options *opt)
>
>  			cb.seen =3D &seen;
>
> -			batch_each_object(batch_unordered_object,
> +			batch_each_object(opt, batch_unordered_object,
>  					  FOR_EACH_OBJECT_PACK_ORDER, &cb);
>
>  			oidset_clear(&seen);
>  		} else {
>  			struct oid_array sa =3D OID_ARRAY_INIT;
>
> -			batch_each_object(collect_object, 0, &sa);
> +			batch_each_object(opt, collect_object, 0, &sa);
>  			oid_array_for_each_unique(&sa, batch_object_cb, &cb);
>
>  			oid_array_clear(&sa);
>
> --
> 2.48.1.683.gf705b3209c.dirty

--0000000000006629ca062f1e2014
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 29269361d5975ac1_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mQVRxa1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNlV3Qy8wUy9PTG95NDYrQWpkUnlpeGNUNXNjQXRNRQpCcmR0cFhEZVJP
bVhvZjJ4YnJaVG95djY3OEFLbFROc3poOVlTK1dqUVZoV1ZUSmtJYm02QzdOVmNBNTJmb2MyCmph
UmRZZEJHR2Nsak9zM1ZYNDJtTGVna3ZiMUo5RmtRbzMrVk1QLzFzeVVZeW8rOXh1YS92MUd2bSta
bmFkemkKVUUrdHJFckdXclF0V3JjL2U1bnJ2RFNZVld6OFNsSk55aUNXNTZYaTRYV1VqeVpRdFp3
YXdnVjZOTTNWeTdrMQo4RUd0azJUQ3pkbDRESCtXZTNJeGNvNElUSVM3dWptZXE1ckFXSDhXNk8x
UFRsWVZYblB0b2k2cm80eWdNazNhCjg0cVRCRDFkdjRlU2dWZnFnVmd0dFNaZ0dibVV1blcreDNu
L3k0ek8vNEVTVDNDMDlZTHJoWGpUbUlxY1BFWjIKeGdrL0lsa0xXcm9pT0tiZk01cTJtcUJtUzFK
NEQ5THJvMjQ1NUs2RThZUWhNUyt1K0N6OG52Z0hHL0RFbWVESAphbnhtSjBZeHdQdGIxOTNLZzIx
Ym11TmwwbE1LZk9wbm1LY00rbG0ybmVmZEdEakc3bnlmbFpLb0hRQmRJYmJGCkhNaU9Nb3FhWTUw
d1VUNDg4OGdDMGtHZUJMSmVTOWFoZ3pPcjNzcz0KPXd3U3oKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000006629ca062f1e2014--
