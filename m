Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98655187849
	for <git@vger.kernel.org>; Fri, 13 Sep 2024 12:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726231630; cv=none; b=k9KVT/onk83zwzT9B4sv8dnpCS8l8EWCxqPJ6HwdTpm4SqT3m7pocpEXW7QUSqw6XsPNqL4tf/BZfX7zRCBB1hOkcxSvL8ARR1uGOGE0N63DODtgLHPV4/S1jAau09xg68f9T18TyuBsfqRCJlt/Qs3Mrw3vtBFT/ZPKQF31ezs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726231630; c=relaxed/simple;
	bh=VtRjtJyXqAqCgrBDKvkY5nS0st71sAzpobNVVTE4MBo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JPPz3NwLwadV6I168FhPNvztS3LZRheCxmZRrhSPKhprtVgT5Hr8pIZUeY2YaYjBq0CljD3Bgrfenag1sBBVT988EGXRk0W3gF4LmWHUoRaP29EMmekcvlTuD2Y8IpLIoDgHMcqLX1MfJSYycSTY9aWEjxx2OtSf8GnbUp4qIXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PoxfBihH; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PoxfBihH"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-49be2ef28aaso597536137.3
        for <git@vger.kernel.org>; Fri, 13 Sep 2024 05:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726231627; x=1726836427; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/yxjA7k5jU4GpzWi3J8P20YZ1PEO3roJCnmYEiyxAEw=;
        b=PoxfBihHaSVSP2HCOa5toHvoAGHUtrRscFY9l8Bybm6QPfWUbAGg9iXcG+wm375Ae4
         CgsMDvFrW+FauX+k0aI61Q3S+ZLsFEGVSrozFNnVAs7GG1uAcQ1l1zSEbQRn0bo2xlTR
         EI7N5aDxEGnIYT4bYQWvo7WA5EiCcKuBPkULxln4KfSXx4WhvYJOk8ctZo0DtESsPzVj
         Q5HgjXtQgjdalwwnYM0pCyHUqCFLWXJa73a7RkSWqpOwp/KTy5/sFD1HRjEqI5/lK5xU
         kaO8M12hfb6Tn4RWFfpDdQliFYUqgpJNgaGeUAH7NwwXMHZ942gqqg2hfA+DlJfQ83pC
         kK2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726231627; x=1726836427;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/yxjA7k5jU4GpzWi3J8P20YZ1PEO3roJCnmYEiyxAEw=;
        b=MxEKOYIfnLL9tWt3iXds4/d2HUXR3IsOC3Bck4oBBnPbz7Gm+yIdUwK6uOZBj96Dhj
         sN2+OiiAVFGNiRVcdhJAB/XRDI/KlvDiHs8bX4duKPW2LLlo6CralM4/Cjad3Z9DmNUl
         eeml/EKVuv2N/CnQ1DEzsjVula44Bw5Yg5FRyBjQda+1rqQmGqrh6LQ6M250pmphGCtr
         cQFU8S2kU8fqOtsgWYavbs+RKOaW8JNNyeT+PxiLZ+3wQGLgdL4wINK8swj08VlasnNa
         RZAX+KggIcnrzqi4/rdSxpcZSz1Kb6KuAVt00efO0eYUVFBj8NjUjCp3djBW0YlWFtDg
         bRKA==
X-Forwarded-Encrypted: i=1; AJvYcCVxKfxi83OYdLUQ1u3J9i+76yAtIn7bvyz2zc+R9cb2z8fjmTosoq3CuWn5PvK0Cga8BCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFMiI2S44SdtQYjIs2ccXXgkZU/qVjNHqeSjhmJlhMro/YhaQt
	Kz2QCLh2eqEEvkuowsnwCUbvLxhFqUQ7AQHRl+7ldvSBQBGoiQ/niam8mMlypZIPnZMTP6VbkjD
	k90vhTHJST2NnlMi9Rd75C4nc17ltm5S/
X-Google-Smtp-Source: AGHT+IETvJspHab42pDsIkxVGj5vVhvvMuaCCCQkKhOmznN8zEjnORsaw5RK1mnJP2MrKH4aOGsvOTDYyo5xNM1pAbo=
X-Received: by 2002:a05:6102:304d:b0:498:9a94:d797 with SMTP id
 ada2fe7eead31-49d4155e95cmr4637115137.20.1726231627318; Fri, 13 Sep 2024
 05:47:07 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 13 Sep 2024 07:47:06 -0500
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <f3922b81db69cd3bbdddcfbe02c99613448fd9ed.1725881266.git.ps@pks.im>
References: <cover.1725881266.git.ps@pks.im> <f3922b81db69cd3bbdddcfbe02c99613448fd9ed.1725881266.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 13 Sep 2024 07:47:06 -0500
Message-ID: <CAOLa=ZQikyvJCRZ=mCfve+VWZfrvPL1bg55txB1q0Nh3SW_JJQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] refs/reftable: wire up support for exclude patterns
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Content-Type: multipart/mixed; boundary="000000000000f26c420621ff9e17"

--000000000000f26c420621ff9e17
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Patrick Steinhardt <ps@pks.im> writes:

[snip]

> hidden refs. The following benchmark prints one reference with 1 million
> hidden references:
>
>     Benchmark 1: HEAD~
>       Time (mean =C2=B1 =CF=83):      93.3 ms =C2=B1   2.1 ms    [User: 9=
0.3 ms, System: 2.5 ms]
>       Range (min =E2=80=A6 max):    89.8 ms =E2=80=A6  97.2 ms    33 runs
>
>     Benchmark 2: HEAD
>       Time (mean =C2=B1 =CF=83):       4.2 ms =C2=B1   0.6 ms    [User: 2=
.2 ms, System: 1.8 ms]
>       Range (min =E2=80=A6 max):     3.1 ms =E2=80=A6   8.1 ms    765 run=
s
>
>     Summary
>       HEAD ran
>        22.15 =C2=B1 3.19 times faster than HEAD~
>

Nice.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs/reftable-backend.c | 125 +++++++++++++++++++++++++++++++++++++++-
>  t/t1419-exclude-refs.sh |  33 ++++++++---
>  trace2.h                |   1 +
>  trace2/tr2_ctr.c        |   5 ++
>  4 files changed, 152 insertions(+), 12 deletions(-)
>
> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index 1c4b19e737f..5c241097a4e 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -21,6 +21,7 @@
>  #include "../reftable/reftable-iterator.h"
>  #include "../setup.h"
>  #include "../strmap.h"
> +#include "../trace2.h"
>  #include "parse.h"
>  #include "refs-internal.h"
>
> @@ -447,10 +448,81 @@ struct reftable_ref_iterator {
>
>  	const char *prefix;
>  	size_t prefix_len;
> +	char **exclude_patterns;
> +	size_t exclude_patterns_index;
> +	size_t exclude_patterns_strlen;
>  	unsigned int flags;
>  	int err;
>  };
>
> +/*
> + * Handle exclude patterns. Returns either `1`, which tells the caller t=
hat the
> + * current reference shall not be shown. Or `0`, which indicates that it=
 should
> + * be shown.
> + */
> +static int should_exclude_current_ref(struct reftable_ref_iterator *iter=
)
> +{
> +	while (iter->exclude_patterns[iter->exclude_patterns_index]) {
> +		const char *pattern =3D iter->exclude_patterns[iter->exclude_patterns_=
index];
> +		char *ref_after_pattern;
> +		int cmp;
> +
> +		/*
> +		 * Lazily cache the pattern length so that we don't have to
> +		 * recompute it every time this function is called.
> +		 */
> +		if (!iter->exclude_patterns_strlen)
> +			iter->exclude_patterns_strlen =3D strlen(pattern);
> +
> +		/*
> +		 * When the reference name is lexicographically bigger than the
> +		 * current exclude pattern we know that it won't ever match any
> +		 * of the following references, either. We thus advance to the
> +		 * next pattern and re-check whether it matches.

So this means that the exclude patterns were lexicographically sorted.
Otherwise this would work.

> +		 * Otherwise, if it's smaller, then we do not have a match and
> +		 * thus want to show the current reference.
> +		 */
> +		cmp =3D strncmp(iter->ref.refname, pattern,
> +			      iter->exclude_patterns_strlen);
> +		if (cmp > 0) {
> +			iter->exclude_patterns_index++;
> +			iter->exclude_patterns_strlen =3D 0;
> +			continue;
> +		}
> +		if (cmp < 0)
> +			return 0;
> +
> +		/*
> +		 * The reference shares a prefix with the exclude pattern and
> +		 * shall thus be omitted. We skip all references that match the
> +		 * pattern by seeking to the first reference after the block of
> +		 * matches.
> +		 *
> +		 * This is done by appending the highest possible character to
> +		 * the pattern. Consequently, all references that have the
> +		 * pattern as prefix and whose suffix starts with anything in
> +		 * the range [0x00, 0xfe] are skipped. And given that 0xff is a
> +		 * non-printable character that shouldn't ever be in a ref name,
> +		 * we'd not yield any such record, either.
> +		 *

This is simple yet clever.

> +		 * Note that the seeked-to reference may also be excluded. This
> +		 * is not handled here though, but the caller is expected to
> +		 * loop and re-verify the next reference for us.
> +		 */

The seeked-to reference here being the one with 0xff. We could get rid
of this by doing something like this:

    int last_char_idx =3D iter->exclude_patterns_strlen - 1
    ref_after_pattern =3D xstrfmt("%s", pattern);
    ref_after_pattern[last_char_idx] =3D ref_after_pattern[last_char_idx] +=
 1;

instead no?

> +		ref_after_pattern =3D xstrfmt("%s%c", pattern, 0xff);
> +		iter->err =3D reftable_iterator_seek_ref(&iter->iter, ref_after_patter=
n);
> +		iter->exclude_patterns_index++;
> +		iter->exclude_patterns_strlen =3D 0;
> +		trace2_counter_add(TRACE2_COUNTER_ID_REFTABLE_RESEEKS, 1);
> +
> +		free(ref_after_pattern);
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
>  static int reftable_ref_iterator_advance(struct ref_iterator *ref_iterat=
or)
>  {
>  	struct reftable_ref_iterator *iter =3D
> @@ -481,6 +553,9 @@ static int reftable_ref_iterator_advance(struct ref_i=
terator *ref_iterator)
>  			break;
>  		}
>
> +		if (iter->exclude_patterns && should_exclude_current_ref(iter))
> +			continue;
> +
>  		if (iter->flags & DO_FOR_EACH_PER_WORKTREE_ONLY &&
>  		    parse_worktree_ref(iter->ref.refname, NULL, NULL, NULL) !=3D
>  			    REF_WORKTREE_CURRENT)
> @@ -570,6 +645,11 @@ static int reftable_ref_iterator_abort(struct ref_it=
erator *ref_iterator)
>  		(struct reftable_ref_iterator *)ref_iterator;
>  	reftable_ref_record_release(&iter->ref);
>  	reftable_iterator_destroy(&iter->iter);
> +	if (iter->exclude_patterns) {
> +		for (size_t i =3D 0; iter->exclude_patterns[i]; i++)
> +			free(iter->exclude_patterns[i]);
> +		free(iter->exclude_patterns);
> +	}
>  	free(iter);
>  	return ITER_DONE;
>  }
> @@ -580,9 +660,45 @@ static struct ref_iterator_vtable reftable_ref_itera=
tor_vtable =3D {
>  	.abort =3D reftable_ref_iterator_abort
>  };
>
> +static char **filter_exclude_patterns(const char **exclude_patterns)
> +{
> +	size_t filtered_size =3D 0, filtered_alloc =3D 0;
> +	char **filtered =3D NULL;
> +
> +	if (!exclude_patterns)
> +		return NULL;
> +
> +	for (size_t i =3D 0; ; i++) {
> +		const char *exclude_pattern =3D exclude_patterns[i];
> +		int has_glob =3D 0;
> +
> +		if (!exclude_pattern)
> +			break;
> +
> +		for (const char *p =3D exclude_pattern; *p; p++) {
> +			has_glob =3D is_glob_special(*p);
> +			if (has_glob)
> +				break;
> +		}

Why do we need to filter excludes here? Don't the callee's already do
something like this?

[snip]

--000000000000f26c420621ff9e17
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 290ee458818d204a_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ia05FY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meVgzQy8wYVJZczFIOCtxekIzbmRwTjZFZkMrazRlcwppeG9ubTdlMG9G
UVR2bmRZWC9OaTlNcGljTVhUOUJub2ZOY2J4cTFrNkprU21ETmpvc1h2SjlxTWgyWFNZc29hCjJJ
Q2dMSHNtR1VpaGJLM2Nxc1FlR1U3MXNUWFM5bkI3aTNkV0NWa2wxSFlHRDZRS2ZaSGhROHpWdS9t
YXI1NzEKVzA3NDNXOFFxVkRKQkJrNWNwcVlwT1NQTFNLVTFkY2lnRHUyajlxenJTVEl0V3ppMGpB
eGM1T3Rkakp3VExhQgptQ3lvWDNQb2E1V1gveGUrdElKVjVHM2hOSlVKRVRGc3ZVSFpZZDc3cUJI
cjMrRVZMRlQwR3lOS2R1N3RIVzl2CmF0OUNGSEJXNGh3Q3pLSmFTcFV2dzV6dldjZXkwQkJDaThO
bko4QnduOG1zWXN2OUJQWnhzQUUvNGp3QmorcU8KWVZXbG5OZFNhaHYwQ3ByY21FSDB1czNvaTJn
RzhuamFMbG1TekJKVUQ4dDhua3hrc1ZKSWlNUVd2aEFwbWUzNwpRNy9qKzJ5RHFnWHptYnBsd0dw
cjVXaVB1UHg4aW5HQ2VUeWwyVUdHUG8wTmh4NTRJOU14WndFbkJTN3BTZUhaCjYvL1FyY2dxZ0F2
dkRTQjZzYzFOcVhyQnpuQlE5alY2ak1GY1ZXMD0KPVE2SkkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000f26c420621ff9e17--
