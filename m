Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DA01F37C5
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 16:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736267641; cv=none; b=MyAqj382VA83nFF8/82u0fjinT8JPGNgs9QhPJEyQ9oyR6kiiIotdAtrTTxBA0gO3177yq51U1vqxihRbdsDFTs1xZziwtET0ZjojayydotNpW7uL8fLqPvZ0mE/rpdFPL5X21++021jn2jRpoaxV46kjbwfbIMb4jYOAJGbieY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736267641; c=relaxed/simple;
	bh=74vCNAAIna48kKbD4qnaB8Xyo1OcokQWG+6pdKnh0Rc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cv9EOB9vP6q786ds16J2CxHzVGQdMl/aqfTb/IKlmPFNwajAoRNJFTPFGrObzaCHMr0UJAQsA49xqDDGAIqDHzwR8nsz+FlluQTV57gnzvbSWx2eucn7U8ey0SDx2G8R/qhuI9X4X/a4JOshhtkC+0KvI8+sTLsMbFTI518EPoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JfpUurgf; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfpUurgf"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-85c5a91374cso6825192241.3
        for <git@vger.kernel.org>; Tue, 07 Jan 2025 08:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736267637; x=1736872437; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0k4/bjNs4a7xlZtmsuEI1QcOcCEvGl9RLrH9S+RhfU=;
        b=JfpUurgf4pTrnPnOB010k2TOUx9aWxhZqzGg9gbcJ8pjnIwi87I5XFhcc5pG7nmiGG
         8gt6ODissgMeJ7n/c/me6BZIaHb+CJqzTzAdifdSHjliU87HFfTVkB4NVO2snGZDYLiw
         vRe4s+kqCz3VpfCn6lpO3vaK87okgjfTFEqAplQnjDYmVf8IvyLvpcnYy2wxe/nBMJDf
         2WJVoRs4AVXEuzFNLPkUskrulFGArMEod4bYS3hg++g74hjx0a1Xo78NHjDIUcZ2vEUJ
         9vvDqETwlvBQ7/mfaZtTHN3bimzunZb4sA0NwfsvQlMKGt04Fu3OM3lQ1QBmeT/dgyXu
         LxTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736267637; x=1736872437;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0k4/bjNs4a7xlZtmsuEI1QcOcCEvGl9RLrH9S+RhfU=;
        b=Zv1OiEhowWak4yHTfELnxc++RbBXDS2DTQnYVLvCuF+qAE3x6ibWTO5C/K1NbGoGtW
         x5y3aFMtW0p5ymAQKIsZjIZy1ODfl3/GjJqRLbeQ6cZX0UjzLhiIDu7snp7v40NyosL5
         smbMHtrUQgsGCDLN23pbk1AnvtDTsh2KIAlnjbB8XrvMhdb0rRajQpnhmqyL/Xf5A4P4
         2/nSqIl5/Fjfx1vj1BJBhmomfotw0nvZ71nc4fvy7QhEfnvpRLFQtUajslROixrgHiAd
         I9QvEOoejeu7uNzlYakKq2/l+F11RZxPkYH5fPrt6XZNDc/jBGVSG5XWBbngyAf1yY+a
         oXfg==
X-Forwarded-Encrypted: i=1; AJvYcCWnjgCPvp4CPtNn5HlMK2R84yIFuzgiW3O+9/CHLGvfJtyapcfJf1LIa21Yw+J/SOVRUf4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytgc7M3/piGzDs58lqpd/P+Aav4cV9ghuBzJ7WyVTVzcNpEhXl
	nJRA9gZqmFtR8wwjZPrtV9vf3iSYaKJyx1Rem+wvlVhZ2AATf4wdRUedddob0pY+oI8fxdI9Fi9
	wpXENzvubAYSAbTZODvaHV4yFPaj1qYpx
X-Gm-Gg: ASbGncvImRFoQDzt8KoFulRcKJoFepPkR6ICJwoDYaoJUUgcST8f4ObjGYg5NouHTD/
	jlEdLvAGdxBXmPCAK3t/Ge39B71bw4XhzWOr/QKg=
X-Google-Smtp-Source: AGHT+IF/iQmyLQA+2ABq21uLuZXHYkQMydPqG1pWtbuqto3A/UcXFS0sQ6Exy4BPPKcRVPtF93w396Hm0tKD6BChPoM=
X-Received: by 2002:a05:6122:8cb:b0:518:91b3:5e37 with SMTP id
 71dfb90a1353d-51b75c56277mr50190134e0c.5.1736267636880; Tue, 07 Jan 2025
 08:33:56 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 7 Jan 2025 08:33:56 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <Z3qN6C2IpQTdVn_S@ArchLinux>
References: <Z3qNUizvHJLgMx1y@ArchLinux> <Z3qN6C2IpQTdVn_S@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 7 Jan 2025 08:33:56 -0800
X-Gm-Features: AbW1kvap1Eseh4cyefetwykYn5lee1eWe4gH7P_QOLWrG2Bx2YgKeBjJk7rKE80
Message-ID: <CAOLa=ZQ-cRJeWjP-_6N2v4GS5P7oYVUyb9_tbY26W7MAJfJ6ZQ@mail.gmail.com>
Subject: Re: [PATCH 03/10] packed-backend: check whether the "packed-refs" is regular
To: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
	Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: multipart/mixed; boundary="000000000000bb5957062b204f76"

--000000000000bb5957062b204f76
Content-Type: text/plain; charset="UTF-8"

shejialuo <shejialuo@gmail.com> writes:

> Although "git-fsck(1)" and "packed-backend.c" will check some
> consistency and correctness of "packed-refs" file, they never check the
> filetype of the "packed-refs". The user should always use "git
> packed-refs" command to create the raw regular "packed-refs" file, so we
> need to explicitly check this in "git refs verify".
>
> Use "lstat" to check the file mode. If we cannot check the file status,
> this is OK because there is a chance that there is no "packed-refs" in
> the repo.
>
> Reuse "FSCK_MSG_BAD_REF_FILETYPE" fsck message id to report the error to
> the user if "packed-refs" is not a regular file.
>
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Signed-off-by: shejialuo <shejialuo@gmail.com>
> ---
>  refs/packed-backend.c    | 33 +++++++++++++++++++++++++++++----
>  t/t0602-reffiles-fsck.sh | 20 ++++++++++++++++++++
>  2 files changed, 49 insertions(+), 4 deletions(-)
>
> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index 3406f1e71d..d9eb2f8b71 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -4,6 +4,7 @@
>  #include "../config.h"
>  #include "../dir.h"
>  #include "../gettext.h"
> +#include "../fsck.h"
>  #include "../hash.h"
>  #include "../hex.h"
>  #include "../refs.h"
> @@ -1747,15 +1748,39 @@ static struct ref_iterator *packed_reflog_iterator_begin(struct ref_store *ref_s
>  	return empty_ref_iterator_begin();
>  }
>
> -static int packed_fsck(struct ref_store *ref_store UNUSED,
> -		       struct fsck_options *o UNUSED,
> +static int packed_fsck(struct ref_store *ref_store,
> +		       struct fsck_options *o,
>  		       struct worktree *wt)
>  {
> +	struct packed_ref_store *refs = packed_downcast(ref_store,
> +							REF_STORE_READ, "fsck");
> +	struct stat st;
> +	int ret = 0;
>
>  	if (!is_main_worktree(wt))
> -		return 0;
> +		goto cleanup;
>
> -	return 0;
> +	/*
> +	 * If the packed-refs file doesn't exist, there's nothing to
> +	 * check.
> +	 */
> +	if (lstat(refs->path, &st) < 0)
> +		goto cleanup;

Since `lstat` return '-1' for all errors, we should check that the
`errno == ENOENT`.

> +	if (o->verbose)
> +		fprintf_ln(stderr, "Checking packed-refs file %s", refs->path);
> +
> +	if (!S_ISREG(st.st_mode)) {
> +		struct fsck_ref_report report = { 0 };
> +		report.path = "packed-refs";
> +
> +		ret = fsck_report_ref(o, &report, FSCK_MSG_BAD_REF_FILETYPE,
> +				      "not a regular file");
> +		goto cleanup;
> +	}
> +
> +cleanup:
> +	return ret;
>  }
>
>  struct ref_storage_be refs_be_packed = {
> diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
> index 75f234a94a..307f94a3ca 100755
> --- a/t/t0602-reffiles-fsck.sh
> +++ b/t/t0602-reffiles-fsck.sh
> @@ -626,4 +626,24 @@ test_expect_success 'ref content checks should work with worktrees' '
>  	test_cmp expect err
>  '
>
> +test_expect_success SYMLINKS 'the filetype of packed-refs should be checked' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	cd repo &&

This should be in a subshell, so that at the end we can actually remove
the repo. This seems to be applicable to most of the other tests in this
file too. Perhaps, we should clean it up as a precursor commit to this
series?

> +	test_commit default &&
> +	git branch branch-1 &&
> +	git branch branch-2 &&
> +	git branch branch-3 &&
> +	git pack-refs --all &&
> +
> +	mv .git/packed-refs .git/packed-refs-back &&
> +	ln -sf packed-refs-bak .git/packed-refs &&

This should be `ln -sf .git/packed-refs-back .git/packed-refs` no?

> +	test_must_fail git refs verify 2>err &&
> +	cat >expect <<-EOF &&
> +	error: packed-refs: badRefFiletype: not a regular file
> +	EOF
> +	rm .git/packed-refs &&
> +	test_cmp expect err
> +'
> +
>  test_done
> --
> 2.47.1

--000000000000bb5957062b204f76
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 24019174db6a11eb_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kOVYzSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mKzhMREFDR1dNbW5HQWVvanVFd1JCS0VxU01lK0xTNgpZelBSaXYrMWJ0
bGpjalg3bzJTY2srdnBuS1JqZXNHMXlRSkNiY1VxZ0R5cUFiWFRnaTlBRU1pbDNPOElNZDNSCnZG
NGRudW9wYVBJMTgvTTlCQWFaMVpWRjhVa0x3TXJZY1B4dU9KTU8xa2VObkNZdCtaSTg5bnJIYWlx
azkxWksKbUJ4UVpvTGUvNkxJTTVxaFpjR0MwK3R1ZDhpT2kySDRNeFJYdUZ4d2JzekRaSmU2cGp2
cGhqblZlbk9rMVY4NAo0NEhrLzQ5d1Q0b1VjTzRZN2pDTC9KWlB6YzBTalpyTmVSQVo3Qit1a0dy
WnVwS0I1YmlabHlzdFlRUjlDVGp1CjBMajd2QXZvUGw1c3Y2RkRxVkg0SjVFdUZSeUpTVHI0cUhO
VGNmM0x5WkdybFFnQlBtdkRWU1l6OHZvVnI2NGgKL3VPbld3VUV5YnY0Tk15RldNZjNJN21GWFNj
bWhNaTBLVkJKeFpWcFJNYVAyUzZLZmtsWlJnN3hxTVZmRStqawpudWNCeUxvTHJYYTIwRFowWU9H
RTZMYWw4MzdESHE3UGtxNHpmRVREQUZPenpkNjM2SWRRQ2Nyai9Xa3FTdmcwCnVHbjRsQlBXcU1p
d3laTURQc21yRFRUNTVxNkErQ1EvbjJ6WmQycz0KPWJTR0wKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000bb5957062b204f76--
