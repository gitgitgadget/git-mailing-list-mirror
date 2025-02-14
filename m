Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7ECF245AFE
	for <git@vger.kernel.org>; Fri, 14 Feb 2025 09:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739526631; cv=none; b=tLNeZI4GWiUh5QBccXY3L2paYbE54T6eLxTWQW86mkGSAAQyqygdNEflKLcaD3mU3PQtg2amlGsMf+3Fqv9WTNvTQf1q7qXfK8PHtYB/BHYLJLsYeKeh5nXCkCc0sQJEQ6w5YydPVSs6uOWLmXtdTdGRWMYHm3Hc4w/l8JGW/Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739526631; c=relaxed/simple;
	bh=uoAMPg+RvJ5fq85tV4hvV1ofjrDUKu9gCnCU6LtxZcs=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tl7XlsXZeTwz+7nroW+erQ43SoJTFEuhsDjzlpPVuYV5So9Uk9KsyArY15cD0qyDo/ROvMdOTed68DWXSqNywlxfcndDSac6IhIyMgPE5Gxtj8ltLByu8FpPMvcGHGZeLD4d/SSio9+nIs+PklxlFKG6U9AWnvvjeGM55eOgQag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fc/oIWmA; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fc/oIWmA"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-868ddc4c6b6so618923241.2
        for <git@vger.kernel.org>; Fri, 14 Feb 2025 01:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739526628; x=1740131428; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=GoOqmocpvqfPvgm6idQ1BcJP5q0TCuTH8GcH5ZZlUIg=;
        b=fc/oIWmABLoGt8f/echa2NYnOdkffbdeDAs/Q9349cMFzQSTh6IMVWDjfGlFXjaM15
         aaLjIbWAdk9QPqkIBYwgAGHWOo4ATaM3Jm5yO7zvgAIBaAapKKiiACvifnp3ugdGZae3
         hdHJII8jI3GkcH5HHXgo4i4w0Y6oaFbRtl68FFmhGrlwX1LfLItDRA3cNB1CM33AumTL
         GVXRPW/e/KJcCsvJh63yXLOqxbl999THurFKoO7/AHegfW78kNxin0pMbjswmDSehhjT
         PaXVEBlYdk6h56HFepF8KTPlR/SjY+10NJE6huM2NcLeDWqcO0KvzIvXZbypPNRdNJxU
         9myg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739526628; x=1740131428;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GoOqmocpvqfPvgm6idQ1BcJP5q0TCuTH8GcH5ZZlUIg=;
        b=GpycJjYCJUCz1wQNEr9Jyjcm4afIqdj2yFc/A7D3tAtW7nmMldd86KGyCqdcdHqccE
         ERRMoopl2zORZatjpbNJVQjO3sRFrt/RXkswHJ51xrnOqS02WlY6jPMVY720M4bovV3D
         yUl3ozGou1SpKKSI5ru8JycC4Wk9S2FCSy3EskOH6Q3z6VwIX5Fpzc2TBwK1v6rmurNs
         lzVxKs3x/WSmZ1Zn77281mmvEQFmdLryE6k2+XFRlUA34hMxFdGqYY6+W3g4GbKDinOM
         QPa2UyiWUpfM/e6j8YvDr3bPmymuNBio2GqsmVohUFxx6jv0977Jj3WOijAFW02U3Msj
         q4mw==
X-Forwarded-Encrypted: i=1; AJvYcCXpRRXenzBn3YjVjEVGXXxxmFMgBDOONjaezpaZZa5FrZzi1NaEGfRsbNNPiI1lZhMgeqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YypdchoMcWp7riXssNTGEBEuZYseYLWItWGBtLCWQTWRIDENr2J
	HLaB0RvX+kyX/cLmCe8NwR76V/WuNeE3MkfjGUn7MSc6SDoNIW1NzcvsWVAMYonHRDWOFu4cVY0
	VtWwM759DvSRC/1SsBVY4t67tMYmhv0as
X-Gm-Gg: ASbGnctHuSFbgZoCx7bF5WJ4o2Lb0bGDCszitCYy5n8F+wqzycJ1fwmM1NVjQO5OhVI
	WywmLYbGvzTo8io8smU5FTERQDoikrGltTh6DdvDRyqraM1CbuPQXoXKRq2tWKhIjiPY6U4dH1w
	==
X-Google-Smtp-Source: AGHT+IGfPdk3/cFrKbXj+Qr69Dm6b4xOvPE8Z6js/FhTpzDHkYMLsFqvBNK3APVq1M+CnqFBcPLqiZ+AzHgy6mPLt/4=
X-Received: by 2002:a05:6102:c8b:b0:4bb:9b46:3f8a with SMTP id
 ada2fe7eead31-4bc034e99d5mr5290072137.2.1739526628468; Fri, 14 Feb 2025
 01:50:28 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 14 Feb 2025 01:50:26 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <Z67MDPtjoXQB2sGB@ArchLinux>
References: <Z67LkxAFIAeaYr0U@ArchLinux> <Z67MDPtjoXQB2sGB@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 14 Feb 2025 01:50:26 -0800
X-Gm-Features: AWEUYZlrZAJK-P8p6E3HwF6zr-ClntulGl_RJG60msCOc1N3fZCHD3O1xIWokpw
Message-ID: <CAOLa=ZQ7CAXP-bYzTv3GJhauwtaL+pFj-2_QPWBh7SMiMsa6bQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/8] packed-backend: check whether the "packed-refs" is
 regular file
To: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
	Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: multipart/mixed; boundary="000000000000c48ad3062e171acd"

--000000000000c48ad3062e171acd
Content-Type: text/plain; charset="UTF-8"

shejialuo <shejialuo@gmail.com> writes:

> Although "git-fsck(1)" and "packed-backend.c" will check some
> consistency and correctness of "packed-refs" file, they never check the

Because you say 'some' here, it made me more curious. Could you state
exactly what checks are being done here?

> filetype of the "packed-refs". The user should always use "git
> pack-refs" command to create the raw regular "packed-refs" file, so we
> need to explicitly check this in "git refs verify".
>

Not sure I understand how the start of this last sentence correlates to
the end of it. Is the intention to say that we want to explicitly check
the filetype to ensure that the 'packed-refs' file was only created via
'git pack-refs'? If so, perhaps:

    Verify that the 'packed-refs' file has the expected filetype,
    confirming it was created by 'git pack-refs'.

> We could use "open_nofollow" wrapper to open the raw "packed-refs" file.
> If the returned "fd" value is less than 0, we could check whether the
> "errno" is "ELOOP" to report an error to the user.
>
> Reuse "FSCK_MSG_BAD_REF_FILETYPE" fsck message id to report the error to
> the user if "packed-refs" is not a regular file.
>
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Signed-off-by: shejialuo <shejialuo@gmail.com>
> ---
>  refs/packed-backend.c    | 39 +++++++++++++++++++++++++++++++++++----
>  t/t0602-reffiles-fsck.sh | 22 ++++++++++++++++++++++
>  2 files changed, 57 insertions(+), 4 deletions(-)
>
> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index a7b6f74b6e..6401cecd5f 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -4,6 +4,7 @@
>  #include "../git-compat-util.h"
>  #include "../config.h"
>  #include "../dir.h"
> +#include "../fsck.h"
>  #include "../gettext.h"
>  #include "../hash.h"
>  #include "../hex.h"
> @@ -1748,15 +1749,45 @@ static struct ref_iterator *packed_reflog_iterator_begin(struct ref_store *ref_s
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
> +	int ret = 0;
> +	int fd;
>
>  	if (!is_main_worktree(wt))
> -		return 0;
> +		goto cleanup;
>
> -	return 0;
> +	if (o->verbose)
> +		fprintf_ln(stderr, "Checking packed-refs file %s", refs->path);
> +
> +	fd = open_nofollow(refs->path, O_RDONLY);
> +	if (fd < 0) {
> +		/*
> +		 * If the packed-refs file doesn't exist, there's nothing
> +		 * to check.
> +		 */
> +		if (errno == ENOENT)
> +			goto cleanup;
> +
> +		if (errno == ELOOP) {
> +			struct fsck_ref_report report = { 0 };
> +			report.path = "packed-refs";
> +			ret = fsck_report_ref(o, &report,
> +					      FSCK_MSG_BAD_REF_FILETYPE,
> +					      "not a regular file");
> +			goto cleanup;
> +		}
> +
> +		ret = error_errno(_("unable to open %s"), refs->path);
> +		goto cleanup;

The paragraph in the commit message:

    Reuse "FSCK_MSG_BAD_REF_FILETYPE" fsck message id to report the error to
    the user if "packed-refs" is not a regular file.

Gave me the indication that any error would be reported via
'fsck_report_ref()', but it seems like we are only reporting for
symbolic links. Why is that being singled out?

> +	}
> +
> +cleanup:
> +	return ret;
>  }
>
>  struct ref_storage_be refs_be_packed = {
> diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
> index cf7a202d0d..42c8d4ca1e 100755
> --- a/t/t0602-reffiles-fsck.sh
> +++ b/t/t0602-reffiles-fsck.sh
> @@ -617,4 +617,26 @@ test_expect_success 'ref content checks should work with worktrees' '
>  	)
>  '
>
> +test_expect_success SYMLINKS 'the filetype of packed-refs should be checked' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit default &&
> +		git branch branch-1 &&
> +		git branch branch-2 &&
> +		git branch branch-3 &&
> +		git pack-refs --all &&
> +
> +		mv .git/packed-refs .git/packed-refs-back &&
> +		ln -sf packed-refs-bak .git/packed-refs &&

This still doesn't make sense to me. 'packed-refs-bak' doesn't exist, is
the intention to symlink '.git/packed-refs' -> something which doesn't
exist?

In that case why even make the effort to build a packed-refs file, could
we simply do 'ln -sf packed-refs-bak .git/packed-refs' in an empty repo?

If not, then 'packed-refs-bak' is definitely a typo and needs to be made
'packed-refs-back' which would go in hand with how we setup the test...

> +		test_must_fail git refs verify 2>err &&
> +		cat >expect <<-EOF &&
> +		error: packed-refs: badRefFiletype: not a regular file
> +		EOF
> +		rm .git/packed-refs &&
> +		test_cmp expect err
> +	)
> +'
> +
>  test_done
> --
> 2.48.1

--000000000000c48ad3062e171acd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 9a9a752b00217614_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ldkVlRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM3k0Qy80cG9QVlo5NG5YalFlZjk4cEpZMUVZaUZ5Rwp1eDlHaWVLeEI0
b2wxVXhqRmcwNUl0SVZtZEV3TWFWZ1hOeTViNzhiMFB1bkcwd0RESlFSbzJGRHdRY2c2azJCCm5I
cWFUNTVpdHNnUjVudXJ2UDV4Z1hCbnpnUEZsZkNMQTBFeHdFb3B6T2dJSVpvb09tV1FuemlMSlEr
aTdTNW4KY3F5alpjNDVRWERTTU9wKzloWDFKeEZkMUxvOXFXWm9OOFhjYVovQjZWY3Fpa3UxKzNN
b2swbnIrSGF2RmZmKwpkZnpxYTdVc21xSUpvTGZxRUlvN1BEeGhZazRzd1dXazM3YXpWdW4wSjhl
cko1eUpoVUJTVHRzYStpV0xjTG5mCjEwTnZtQXpFR0d4NXBGVjF3dW1YVGs4K2p3OVJUL3NyQTVI
MUc4bllUTi81bFlDZENMU1hod3h6dWR2NDJ0NTYKdFpoVjVKeHU0YThBbnM4S1hDdzFtSmtqZFBN
WkZCeE5BV25MdXowRDl1NlRKQkRqYkhvejBvU1NHOERxZHRsSQpiT2dVRzhQTG9ybVdFcnNLVU5r
NnZqZG5CZzlwK1pYQUJOZW8yM3EyaWwvZkd0OUhpanFyUXZhbk93RkFSL2t6CjdNWVJha1BNM1JG
ZDdZR3JFbThuQk1sZUZ5ZGZ1VHdTOUxKUGQxQT0KPUR4WmMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000c48ad3062e171acd--
