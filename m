Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B69E1DC997
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 11:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740655609; cv=none; b=JW/uYJ73mro/t2h8S/Kv5Y0tXBgKMTjhpI8wrtrDxM8GMjckvg+h/xuKYVAYKr/jI96NBe+dbb1CVjYwyFmlqtGDy0w1C8LZ2asaSXtzGR3jmTPhiVkkZwQhNOFNbh+RlHYwB/EhWC3/LuHh2jXhfkfCeZ151bwoCoZEnOMDWow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740655609; c=relaxed/simple;
	bh=t3fdqd1prU1alYvzuylwgfRlvcIhxtZKjfNKN047hus=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=G8+4xw6ecn/fFvLwffQ8r7QensPWxGckt9wtID3/wqlY+xmNqoViDpjuCrdpCBecP9peHGbZ4yGA4dx3vrBkf3+k96mABuvGTt7yMk/cuGtsChFb5ZoOzErQHR6IRiEvZZDqeJsx1mU1nxKIqvw09gqt7eTuDkYz9oNqJcGLUPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HtCFj+z8; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtCFj+z8"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-8671441a730so337021241.0
        for <git@vger.kernel.org>; Thu, 27 Feb 2025 03:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740655606; x=1741260406; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EWdudxjggZvMnCUL4ww2AhxByJwctIJ3r7JyJF1sTXE=;
        b=HtCFj+z89iGBFAl3z1u2iXeOVUEqlPRUCPZAxBK4riY6s0x6MKF5FBMjNZ9WxJ5sMN
         8Eskyi70Rs+GnHE+XPmXNKi7cdrRyayBArJbwUfSfADKr7BQhAVa9fojYvdLSLiw5Ngl
         gWBRaVT+V9/IdWmcRssExq6efPqq7rezxwqlnFXtzZGTP04sVJZMyePwNRqzXaVxbfvl
         LG1K4EMyWzOgIUJOSHCMvCmob3W1HM67vQpCMMzS+yI2fma40l3fm/6p4Ucnw7xBNxNN
         8FWzz/KxdhFJnnLkHOi1ZeLFsRmfMTcgqnit/3/WabjI1at+tyL3M+zfEatoayuR+8bm
         V6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740655606; x=1741260406;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EWdudxjggZvMnCUL4ww2AhxByJwctIJ3r7JyJF1sTXE=;
        b=v94n315tAD/cuuvrYkJzZP/usiXfPP6vPl5QZ1qZ4wyMoq2QExzd5a0ReSM02t4mx7
         9/+7x2n8Qm6xqznzzmSuy46SyPFPt1RiLhAb+Pu4jdV8cmyJNbYV7Vjwm2qasfBDOcaL
         pvDInBVLyNErehC0UVgVrwC8CMo6VX2i/a0g5ok+LZEL/6OnXycsRUPHmdOOAMluGPTA
         3qprkoyn0pF2rwz+ZfshmSdaLV14pCvrHmTMC2nfcxKk+uV3QUcMnLbC2cpn3JhbMFxB
         pPGp7l3d8LAvIDtav2IPZRbeo2XbB4MEiSOgqZ1gMHgjBstogzLNMBbgco4SNJtFOARV
         qDAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDQhgVpH+W6aMx4/9zCePmKV5snfVR9f2us1FB0O/43n8j+f6fcWTprDPnrq8FZc5o5cU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn7IAAK/JcqEEW7YMb1enQ2hWbRNBMXoTni7+Fleg0mhZZ9bg5
	KiWbl3bbSs1bCRiJxj19t1AN+i7OfWizO2Xu1fdPVEAFE13bF2X2REj8hKXk/DAF6g6uuTZ1+eI
	V2/76sf1AK1OWlp4Q2W2wqRwnONcKQQnN
X-Gm-Gg: ASbGncsvJwzBdusEzbig/tV6SfNlqHwC1JRmQAFinSDtRmroC35GtSHV9PaUe1yQMu7
	bHgj6/sb5sfQgihnCLlhd1ffkwjtCziVvcY126Dp84Loh25ENngZhxoW4uNSwR58/9JQpPxaeLv
	qX5UsqklIl/6q4Zb7RAvWDATSYc2N3YKVgFvaHaTWy
X-Google-Smtp-Source: AGHT+IFcAkSaDzq6Ev/G+ZOXjqegc2m7bdRMTZtm3xEKtOl5N18Ykdcr6cgT7bznI1buAYXFl4bA68Dthb2+SLat9Ig=
X-Received: by 2002:a05:6102:441d:b0:4bb:9b46:3f93 with SMTP id
 ada2fe7eead31-4c01e1cd429mr3289875137.8.1740655606146; Thu, 27 Feb 2025
 03:26:46 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Feb 2025 03:26:45 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250221-pks-cat-file-object-type-filter-v1-3-0852530888e2@pks.im>
References: <20250221-pks-cat-file-object-type-filter-v1-0-0852530888e2@pks.im>
 <20250221-pks-cat-file-object-type-filter-v1-3-0852530888e2@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 27 Feb 2025 03:26:45 -0800
X-Gm-Features: AQ5f1Jr8fCQ8cQbg3IbZWBRSAPx9CXGPp_D8axrWMbJVgHIaaUDHC6yvOG6O8ZY
Message-ID: <CAOLa=ZR9yJqvDwnJ2t9y0MRNQfZFpWPssgsE1QrpbhEzDBB3Og@mail.gmail.com>
Subject: Re: [PATCH 3/9] builtin/cat-file: support "blob:none" objects filter
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000014cc5b062f1df77c"

--00000000000014cc5b062f1df77c
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Implement support for the "blob:none" filter in git-cat-file(1), which
> causes us to omit all blobs.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/git-cat-file.adoc |  2 ++
>  builtin/cat-file.c              | 11 ++++++++++-
>  t/t1006-cat-file.sh             | 33 +++++++++++++++++++++++++++++++--
>  3 files changed, 43 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-cat-file.adoc b/Documentation/git-cat-file.adoc
> index 7c1c888079a..c11952d9eca 100644
> --- a/Documentation/git-cat-file.adoc
> +++ b/Documentation/git-cat-file.adoc
> @@ -86,6 +86,8 @@ OPTIONS
>  	Omit objects from the list of printed objects. This can only be used in
>  	combination with one of the batched modes. The '<filter-spec>' may be
>  	one of the following:
> ++
> +The form '--filter=blob:none' omits all blobs.
>

Shouldn't this be '--objects-filter' ?

>  --path=<path>::
>  	For use with `--textconv` or `--filters`, to allow specifying an object
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 723644fbba8..8e5572ba43e 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -472,7 +472,8 @@ static void batch_object_write(const char *obj_name,
>  	if (!data->skip_object_info) {
>  		int ret;
>
> -		if (use_mailmap)
> +		if (use_mailmap ||
> +		    opt->objects_filter.choice == LOFC_BLOB_NONE)

So since we support selective filters, we'd have to add this type only
for those filters. In other words, there is no generic way to do this.

>  			data->info.typep = &data->type;
>
>  		if (pack)
> @@ -492,6 +493,10 @@ static void batch_object_write(const char *obj_name,
>  		switch (opt->objects_filter.choice) {
>  		case LOFC_DISABLED:
>  			break;
> +		case LOFC_BLOB_NONE:
> +			if (data->type == OBJ_BLOB)
> +				return;
> +			break;
>  		default:
>  			BUG("unsupported objects filter");
>  		}
> @@ -1032,6 +1037,10 @@ int cmd_cat_file(int argc,
>  	switch (batch.objects_filter.choice) {
>  	case LOFC_DISABLED:
>  		break;
> +	case LOFC_BLOB_NONE:
> +		if (!batch.enabled)
> +			usage(_("objects filter only supported in batch mode"));
> +		break;
>  	default:
>  		usagef(_("objects filter not supported: '%s'"),
>  		       list_object_filter_config_name(batch.objects_filter.choice));
> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
> index 48840a13561..97533225982 100755
> --- a/t/t1006-cat-file.sh
> +++ b/t/t1006-cat-file.sh
> @@ -1354,7 +1354,22 @@ test_expect_success PERL '--batch-command info is unbuffered by default' '
>  '
>
>  test_expect_success 'setup for objects filter' '
> -	git init repo
> +	git init repo &&
> +	(
> +		# Seed the repository with three different sets of objects:
> +		#
> +		#   - The first set is fully packed and has a bitmap.
> +		#   - The second set is packed, but has no bitmap.
> +		#   - The third set is loose.
> +		#
> +		# This ensures that we cover all these types as expected.
> +		cd repo &&
> +		test_commit first &&
> +		git repack -Adb &&
> +		test_commit second &&
> +		git repack -d &&
> +		test_commit third
> +	)
>  '
>
>  test_expect_success 'objects filter with unknown option' '
> @@ -1365,7 +1380,7 @@ test_expect_success 'objects filter with unknown option' '
>  	test_cmp expect err
>  '
>
> -for option in blob:none blob:limit=1 object:type=tag sparse:oid=1234 tree:1 sparse:path=x
> +for option in blob:limit=1 object:type=tag sparse:oid=1234 tree:1 sparse:path=x
>  do
>  	test_expect_success "objects filter with unsupported option $option" '
>  		case "$option" in
> @@ -1385,4 +1400,18 @@ do
>  	'
>  done
>
> +test_objects_filter () {
> +	filter="$1"
> +
> +	test_expect_success "objects filter: $filter" '
> +		git -C repo cat-file --batch-check="%(objectname)" --batch-all-objects --objects-filter="$filter" >actual &&
> +		sort actual >actual.sorted &&
> +		git -C repo rev-list --objects --no-object-names --all --filter="$filter" --filter-provided-objects >expect &&
> +		sort expect >expect.sorted &&
> +		test_cmp expect.sorted actual.sorted
> +	'
> +}
> +
> +test_objects_filter "blob:none"
> +

Nice, this builds up for the upcoming commits too.

>  test_done
>
> --
> 2.48.1.683.gf705b3209c.dirty

--00000000000014cc5b062f1df77c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 4ec80d819925bef3_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mQVMvUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNFE4Qy85QnlkajRESUZITXNKUm1pTlVaZFlqRFM2RApzNE12K21FTDl5
RE5uclNxRytlblNPY2c4YVlRWUY1cm51dnJicnJlUThZNGdwS2dpUW0wdEpqUldQTWNFYzVOCk9O
aFhZZm9DcWtwVE9xMndzN1ZHWDZndGhUQmxyMmd5SXhZN2xtcWRNcnhvci9veXdQdUNEUm1VdjRK
QjVkWXkKOGdEbmVUVS9VcUZyYk5nTWRlTFY0WWZyNmNNUnQ2QThYSmozVDNFbkI1cHA3QmhiR0NM
dnBiSUx3UEhCNDdHdQpOQVJvQ29ORFg2UnQ4aXlvYy9RaGFjTUtKdjZOb21UY2N5bStnZDArekxi
RWpFQjFiKzM2NC9aS1NDVXZuOGp5CnQwZC8wTmh6VWxBcnRLczkwY3c0VHQ3MXJ1ZkFkei9UMG5Q
ejZuUHRnNDgzTFMvTjR1clU3Y3hOSjMwenNidjAKbldhRzN2TFBsd2N6amJTQTdmbldlcnF2RTc4
ZTlJRTgxSGJDV2lLM1J3dmk1aWZIZTZMTlIyNm44MkVGOG90aQpZdTNGMUptSi9GYTBFNUJXaTk5
dzhxSm90TmlGTlFjb0FjRm9QVFY2SXRzSi9pZVdBcTgvMnFwVXE1ZDV5b01OClgzWjFBdGQ4bGxC
N3I2M1U4eTJHeEcwd29Na1BhUjNvMU81Y1ZiST0KPS9FZGIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000014cc5b062f1df77c--
