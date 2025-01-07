Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54951F4280
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 14:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736259471; cv=none; b=XgC9rU077YtO2Ppg4u0KJSHj1Kh0OEinTcSdp78WepbY0RbvFTQ1yfsCcm1cIAslhBUxRt1XrMPVeu5BQujJJYBo7uZCNKhERYlD6GL9YyB9aG8Yr7aIjgLxoyuzeplkA5psa3F7VpHCEUEAW5UCRdi6nreKzrsYeHH+CBBou0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736259471; c=relaxed/simple;
	bh=OnucyBK9kO8JWDxfq3bHkauJRPG3vD18kW2s+jZJu/8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MEbYKecWWft1xASpLnR0TI9+hVEbouBp2exosTWj0u0a1LmS/e71u4aCwYcHOYpCJGIbq/HleYBlEZKsaqceL/W7ap/SI2A9YHjLLjR9GfY1iHdainQwkMBlTkUenA6rzNS8VnSxWZ7myVlTajg39nGlEpB2alWiA4ftc+UZtEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gxNwGb9f; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxNwGb9f"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4afe1009960so4565735137.0
        for <git@vger.kernel.org>; Tue, 07 Jan 2025 06:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736259464; x=1736864264; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=nPJwO0nP56IinrhESdlhk1eiGdEMQ5Y/eDrcmiOIm4Q=;
        b=gxNwGb9f4MG3k659MVLI4BoYNIn1f68wjRFb/j51THwR0MftQ8+xh6hh/GOGwgsXzJ
         BgjqLGKdgzfJ2LCZIV6MEQyk7zL1SRD4wkF63h4WALlGyXWkk+hcO52d5scN2FIpJ0It
         0a9XmPs9qUWPNsIFoYzrxpVGSPbNUeB6/k0eDK8fRu84E38iOsYNGr69gQvXv3UJ6Aqu
         5S42BLbNSlAg2G62LHZC4dQK4UoI4uiuOxIUG6ddnODcPtBVf8uAbPeiS2qpSLpEyssG
         c4mysmVwyesMfAkiP6AIS+wUl/1GseTiez7Rl0nxNgLRDs7XmWD1twCLcTTLpIy6RlEJ
         EsRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736259464; x=1736864264;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nPJwO0nP56IinrhESdlhk1eiGdEMQ5Y/eDrcmiOIm4Q=;
        b=mccNTd+f8MhliEulow1AdXnRBjks/H42jDriMK/GkVLsIQQGRQpAaI6uo2Geu9+uwf
         1V3NClwYyD8epeJRqDn1e6mzlyA/CtdkmUFXt5GE/Jl8DjdKrJc7S0E1Pg6Sd2qw2VHY
         SxrSLgHjfsGnMGbLtGxdgq9I9E5YQwD1naMqWA368RYKLMIUq9Zxdo2E7Q/Hgtjn4Q93
         afoFUmx3IrVyCEb7WCLz3QgZ7jwenWF5zhNWaPUUHB+AJ3AuGbDCJylSWv027cmpUhln
         BUyZjlFfltjXJAtU2HVQqAqjI2nmkdpX+ffgpmBIwobz5j8M712NcS5nQtbs0JO628Wy
         MASQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmCE5NyrJnPaGyWNYencldvyOXGGTK7FLiCHMUjT/il0RIpOjY71RlHnuZcZK3SUNofPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZOiX9f4AdnSOtSKT4JAzZX7Qeqr9rIMnza1qdDhlSltPx3mZG
	scriu27CHXphlKT77x4sqDH8VJ/LQnBxBdVZT+dMJhq2HPiVJg2TglQBBhiqjSNm+JXfW/DjIGg
	otSujt48lTwW2kOMlsIoGZvfPSUs=
X-Gm-Gg: ASbGncvAVCNZ/aIHaa+1U8My4SlyanW7gADunwfF19PU9UPClMJ3U+Xg0Uark8YGLpJ
	/1QfITGisRjegEqUMh2OTkIuQ4JlV2VF1bI76vZQ=
X-Google-Smtp-Source: AGHT+IFEEPX8A2V08if4wFpca+BiW/sEIysKVVzFugDJ3LPFAHSMY/WTgDmS/NQRviaFpvMYCl3pl+zhTsF5usaWNX4=
X-Received: by 2002:a05:6102:2c81:b0:4b2:bc6a:2e8b with SMTP id
 ada2fe7eead31-4b2cc31c381mr50345566137.3.1736259464523; Tue, 07 Jan 2025
 06:17:44 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 7 Jan 2025 08:17:43 -0600
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <Z3qN1T3lJoj82ckl@ArchLinux>
References: <Z3qNUizvHJLgMx1y@ArchLinux> <Z3qN1T3lJoj82ckl@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 7 Jan 2025 08:17:43 -0600
X-Gm-Features: AbW1kvbqyyMqd23bQa_684ju-VP54sWT1ZJvkOmukvSd08ns1gfjyrXQEuZGlrk
Message-ID: <CAOLa=ZRG_==uXF8RaTjOUzV932bg8xxEx8HfgqDLWQ1OMzd+3w@mail.gmail.com>
Subject: Re: [PATCH 01/10] files-backend: add object check for regular ref
To: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
	Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: multipart/mixed; boundary="0000000000009f0ddb062b1e6875"

--0000000000009f0ddb062b1e6875
Content-Type: text/plain; charset="UTF-8"

shejialuo <shejialuo@gmail.com> writes:

> Although we use "parse_loose_ref_content" to check whether the object id
> is correct, we never parse it into the "struct object" structure thus we
> ignore checking whether there is a real object existing in the repo and
> whether the object type is correct.
>
> Use "parse_object" to parse the oid for the regular ref content. If the
> object does not exist, report the error to the user by reusing the fsck
> message "BAD_REF_CONTENT".
>
> Then, we need to check the type of the object. Just like "git-fsck(1)",
> we only report "not a commit" error when the ref is a branch. Last,
> update the test to exercise the code.

I found this a bit confusing at first, the code does clear up the
confusion. Perhaps we can say something like:

  Branches that do not point to a commit type are explicitly called out,
  similar to 'git-fsck(1)'.

>
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Signed-off-by: shejialuo <shejialuo@gmail.com>
> ---
>  refs/files-backend.c     | 50 ++++++++++++++++++++++++++++++++--------
>  t/t0602-reffiles-fsck.sh | 30 ++++++++++++++++++++++++
>  2 files changed, 70 insertions(+), 10 deletions(-)
>
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 64f51f0da9..0a4912c009 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -20,6 +20,7 @@
>  #include "../lockfile.h"
>  #include "../object.h"
>  #include "../object-file.h"
> +#include "../packfile.h"
>  #include "../path.h"
>  #include "../dir.h"
>  #include "../chdir-notify.h"
> @@ -3589,6 +3590,34 @@ static int files_fsck_symref_target(struct fsck_options *o,
>  	return ret;
>  }
>
> +static int files_fsck_refs_oid(struct fsck_options *o,
> +			       struct ref_store *ref_store,
> +			       struct fsck_ref_report report,
> +			       const char *target_name,
> +			       struct object_id *oid)
> +{
> +	struct object *obj;
> +	int ret = 0;
> +
> +	if (is_promisor_object(ref_store->repo, oid))
> +		return 0;
> +
> +	obj = parse_object(ref_store->repo, oid);
> +	if (!obj) {
> +		ret |= fsck_report_ref(o, &report,
> +				       FSCK_MSG_BAD_REF_CONTENT,
> +				       "points to non-existing object %s",
> +				       oid_to_hex(oid));

Nit: The two conditionals here are mutually exclusive. So we don't have
to do `ret |=`, no? We don't even need `ret` here, we could simply do a
`return fsck_report_ref(...)`.

> +	} else if (obj->type != OBJ_COMMIT && is_branch(target_name)) {
> +		ret |= fsck_report_ref(o, &report,
> +				       FSCK_MSG_BAD_REF_CONTENT,
> +				       "points to non-commit object %s",
> +				       oid_to_hex(oid));
> +	}

Since this is a single lined if/else, we can skip the braces here.

> +	return ret;
> +}
> +
>  static int files_fsck_refs_content(struct ref_store *ref_store,
>  				   struct fsck_options *o,
>  				   const char *target_name,
> @@ -3654,18 +3683,19 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
>  	}
>
>  	if (!(type & REF_ISSYMREF)) {
> +		ret |= files_fsck_refs_oid(o, ref_store, report, target_name, &oid);
> +
>  		if (!*trailing) {
> -			ret = fsck_report_ref(o, &report,
> -					      FSCK_MSG_REF_MISSING_NEWLINE,
> -					      "misses LF at the end");
> -			goto cleanup;
> -		}
> -		if (*trailing != '\n' || *(trailing + 1)) {
> -			ret = fsck_report_ref(o, &report,
> -					      FSCK_MSG_TRAILING_REF_CONTENT,
> -					      "has trailing garbage: '%s'", trailing);
> -			goto cleanup;
> +			ret |= fsck_report_ref(o, &report,
> +					       FSCK_MSG_REF_MISSING_NEWLINE,
> +					       "misses LF at the end");
> +		} else if (*trailing != '\n' || *(trailing + 1)) {
> +			ret |= fsck_report_ref(o, &report,
> +					       FSCK_MSG_TRAILING_REF_CONTENT,
> +					       "has trailing garbage: '%s'", trailing);
>  		}
> +
> +		goto cleanup;
>  	} else {
>  		ret = files_fsck_symref_target(o, &report, &referent, 0);
>  		goto cleanup;
> diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
> index d4a08b823b..75f234a94a 100755
> --- a/t/t0602-reffiles-fsck.sh
> +++ b/t/t0602-reffiles-fsck.sh
> @@ -161,8 +161,10 @@ test_expect_success 'regular ref content should be checked (individual)' '
>  	test_when_finished "rm -rf repo" &&
>  	git init repo &&
>  	branch_dir_prefix=.git/refs/heads &&
> +	tag_dir_prefix=.git/refs/tags &&
>  	cd repo &&
>  	test_commit default &&
> +	git branch branch-1 &&
>  	mkdir -p "$branch_dir_prefix/a/b" &&
>
>  	git refs verify 2>err &&
> @@ -198,6 +200,28 @@ test_expect_success 'regular ref content should be checked (individual)' '
>  	rm $branch_dir_prefix/branch-no-newline &&
>  	test_cmp expect err &&
>
> +	for non_existing_oid in "$(test_oid 001)" "$(test_oid 002)"
> +	do
> +		printf "%s\n" $non_existing_oid >$branch_dir_prefix/invalid-commit &&
> +		test_must_fail git refs verify 2>err &&
> +		cat >expect <<-EOF &&
> +		error: refs/heads/invalid-commit: badRefContent: points to non-existing object $non_existing_oid
> +		EOF
> +		rm $branch_dir_prefix/invalid-commit &&
> +		test_cmp expect err || return 1
> +	done &&
> +
> +	for tree_oid in "$(git rev-parse main^{tree})" "$(git rev-parse branch-1^{tree})"
> +	do
> +		printf "%s\n" $tree_oid >$branch_dir_prefix/branch-tree &&
> +		test_must_fail git refs verify 2>err &&
> +		cat >expect <<-EOF &&
> +		error: refs/heads/branch-tree: badRefContent: points to non-commit object $tree_oid

Reading this error here, I think it would be nicer to say
'badRefContent: branch points to ....' so we know that the specified ref
is a branch.

> +		EOF
> +		rm $branch_dir_prefix/branch-tree &&
> +		test_cmp expect err || return 1
> +	done &&
> +
>  	for trailing_content in " garbage" "    more garbage"
>  	do
>  		printf "%s" "$(git rev-parse main)$trailing_content" >$branch_dir_prefix/branch-garbage &&
> @@ -244,15 +268,21 @@ test_expect_success 'regular ref content should be checked (aggregate)' '
>  	bad_content_1=$(git rev-parse main)x &&
>  	bad_content_2=xfsazqfxcadas &&
>  	bad_content_3=Xfsazqfxcadas &&
> +	non_existing_oid=$(test_oid 001) &&
> +	tree_oid=$(git rev-parse main^{tree}) &&
>  	printf "%s" $bad_content_1 >$tag_dir_prefix/tag-bad-1 &&
>  	printf "%s" $bad_content_2 >$tag_dir_prefix/tag-bad-2 &&
>  	printf "%s" $bad_content_3 >$branch_dir_prefix/a/b/branch-bad &&
>  	printf "%s" "$(git rev-parse main)" >$branch_dir_prefix/branch-no-newline &&
>  	printf "%s garbage" "$(git rev-parse main)" >$branch_dir_prefix/branch-garbage &&
> +	printf "%s\n" $non_existing_oid >$branch_dir_prefix/branch-non-existing-oid &&
> +	printf "%s\n" $tree_oid >$branch_dir_prefix/branch-tree &&
>
>  	test_must_fail git refs verify 2>err &&
>  	cat >expect <<-EOF &&
>  	error: refs/heads/a/b/branch-bad: badRefContent: $bad_content_3
> +	error: refs/heads/branch-non-existing-oid: badRefContent: points to non-existing object $non_existing_oid
> +	error: refs/heads/branch-tree: badRefContent: points to non-commit object $tree_oid
>  	error: refs/tags/tag-bad-1: badRefContent: $bad_content_1
>  	error: refs/tags/tag-bad-2: badRefContent: $bad_content_2
>  	warning: refs/heads/branch-garbage: trailingRefContent: has trailing garbage: '\'' garbage'\''
> --
> 2.47.1

--0000000000009f0ddb062b1e6875
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 959e3abffd0740ea_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kOU40VVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mLzhQQy85MXpMK09TWGIyRVpQVm1DRWVkdElEU2dtSApSN2pnZ1Y2OFZj
dC8zT1FRQlg2dU1aaUh1K1pGZmxObGFnb0gxY0FzbmpRY3BTdWVPTEo1bGpORThpMk9OMHBkCklm
TXpJRG1hejNxU2J3QWpXanNDQ21hMlhLMEdUSG94dkRjUDJ3RTAyVldDZUhLakJmbnhXVVRjMHkz
MjVpb0oKRDlpOTZMaHFSb2RuMXRBUjFpbEM3VWIyMXZmK1Y0VlFwaVpPOWxpeW1qbnRjTnYvK2x1
cFhja2o2ZEFlbHVwUQp2bFFiVnlocmZsRDNYMjRGMFNNRWxmMFZNZ24xMEVqOE8yR0pDN1BjTnpm
OElDeUlkWWIvVzRUL0hjSGtiVmZhCkY3czZoMTFUNml6WEZYVmZud1doRXlObkVkYmt5cDg5bStu
QS9VdGp1alBIRUt2eDEyYVM2QTN3SXFGdTJEMnYKUlNWaTN6M1BNalY4UU53bUxUdFN5S0lwU0Iy
TUROR1lOVWhyOE9oSnFmWkJKWmNza0I3OFBXcEJ2aFpyQlRsaQpFY2FCeEEzMFpnOW9kYUpxQ2lp
TFdHc1ZlbHl5V2c5Sm5iaktxa0lXWml3d3Y3OWN5RjlBS0UzbkNvNkJCd1NGCnZ1bDduN1ZpQmlz
NEYwK0U2cVc0TGRjK3hGVFU5RHFjcWNzMUVHWT0KPVlyR3oKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000009f0ddb062b1e6875--
