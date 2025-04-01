Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04A51EC01F
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 12:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743510157; cv=none; b=C1FI7eWZE49qS2PakrNHWMQp7841NS4+QLrFOXder3fLBv6uJQpi3Z0lXqawB6U9xDoaAp4ldSIGU9g3MTqz3ZN/HPgPItFdJGiHnLPEMZKOdMwsVmM1YrB5teh9LEd1y66FRvBWgn//1ny5kCgd9I34FSZvxfsH7WkmKzl5xWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743510157; c=relaxed/simple;
	bh=cbaXnQ9UxdRLxf3vf2XgP3YnpoPtp7/IOS9M+q6rjNk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RmdAkCqHG69zQsKwS6SEf1G8ctbikrPJAU7RkSLyqrzxxBCuHqINdExDrf8GPXyh/UZmu+i5hpLRS/ID6VdZMtFqI6xeP7jRsibkmIGrvkS8AYNCzs11nX0UuzVef4e/wJH46RmvQmkIhB1xpv8whi439Up2+9qVYDEBjpL5SO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FSD8J/5X; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSD8J/5X"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-523f670ca99so2509209e0c.1
        for <git@vger.kernel.org>; Tue, 01 Apr 2025 05:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743510155; x=1744114955; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=EEIdIqpn9gy5xzKPbJ3guCegWVxxMRpOAPI1EaiZPTA=;
        b=FSD8J/5XDxb4oEoJIDpwnU90yAyX3k2KN8+/lCgeCpxLfoiesvjmagPJYf4Q0vN/iq
         ww+icqB0GCe2L5iWZnoB/3ans/z/pAOQu3xGWINFi9mDS6Zk2AhNM/CZCNrZ7KeMVgVL
         m8Jt3+u7CdgKbD4KQ2UeF/12U6IHbxDUcGdGP+jTh+UTw32rjOONGt8FjvQYWtoY5urp
         0ty/Z6bLwjwv+iKgMNxJeQA9mi4fb5P0sc6ATydT1tQFhcfTInkkee8uEK0Ng+CVJPiv
         zn4S/Apnt1M7H2Q91EP1kql3rPwcE2i1nbm/nCaJ9A3NmRR9Upql4/neeZnqEajcN1Bq
         fBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743510155; x=1744114955;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EEIdIqpn9gy5xzKPbJ3guCegWVxxMRpOAPI1EaiZPTA=;
        b=iy5XLA0Mh77CLcGMsh0wvQ20qRlejQp8zyNO27jjpMtJffk+DNWwYbInKTwDlWz2GO
         85NxR4elJJZt71CrlN0FnA8jNMtaecSgp34ArlifNnjJB2w/hHqW2pS2L7UHyOsKfFSH
         QnkwtaVRnIlIP3TnYNVL5MsV7m0/hk3NUzoVa7cTjEfZJKZgDupycpvhj7OxcZ+vp2sv
         PENyAry3ZoXNsMxmNNg3Jai2Af4xDiq0EOt/4b6lB0aHUrVg9CI/36zev48GVcGT4R8e
         QgqQKETDEhzx8crigEBFpvoBgC4mIozcfhNfmSa3Tx+GwMfaTaSBSWPveU2ZLmpDBOBQ
         Z0lA==
X-Forwarded-Encrypted: i=1; AJvYcCV35iCOMHqsPLCAXIO0W5lBmm9BTvugqvpnFl055fqM43Stts5tQ/wviACCLWONgHSfDvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzSTJrps8RoelkiuruQ2VuxL/7fhmodD7/HyWJKvfVRbDcqwiQ
	yWezxkChb3MaVA7lrj8njZx8V3CkA2Lgcolg20WZUQa49z2LEPQ3+QX6ArSNqYdm7AWIjQvCWn4
	Gn1xo9aiHw0LUPwpCaX/sZkhXzYl+zlGk
X-Gm-Gg: ASbGncuQe5NWlcAUHKrjUf22zSUJJBY6AHe2KPgKMcXy5dcFip4NnN7gKPFUHtnsmdW
	zpfii1VqitRqIMqYj6vPa48Y/AV4FCGpWA9u0/hjZduiT3yJpj6y6ee7qecXSGEkrhbBqOh9GxV
	5h1a2Jh3iZKO1+EqBB9JnUg9nBUqkKYDyC2v3JXTupuLZ+Cig+/bSuum4xKpEc
X-Google-Smtp-Source: AGHT+IGWxFVA/3TmF8/Gyul//Fof7YC0wLwstyD3UOmqQ3KKa0dQicGHiG04xz2DcaCr0OGAg+OL0OInPzEJSZj/78E=
X-Received: by 2002:a05:6122:249a:b0:526:42c2:8453 with SMTP id
 71dfb90a1353d-52642c2849fmr1135767e0c.7.1743510154716; Tue, 01 Apr 2025
 05:22:34 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 1 Apr 2025 05:22:34 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250327-pks-cat-file-object-type-filter-v2-3-4bbc7085d7c5@pks.im>
References: <20250327-pks-cat-file-object-type-filter-v2-0-4bbc7085d7c5@pks.im>
 <20250327-pks-cat-file-object-type-filter-v2-3-4bbc7085d7c5@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 1 Apr 2025 05:22:34 -0700
X-Gm-Features: AQ5f1JpdnM4eM_pQeZR0USmGLNa6yJtCRrwv9jsfhfaoy52H4lniabTZdwWazoI
Message-ID: <CAOLa=ZR4YmfHvQGvs1mzdtRu5z+8XW-xY+t_wBAoTs1m+rrO9A@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] builtin/cat-file: support "blob:none" objects filter
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="0000000000006fc3980631b697c6"

--0000000000006fc3980631b697c6
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
> index f7f57b7f538..bb32f715944 100644
> --- a/Documentation/git-cat-file.adoc
> +++ b/Documentation/git-cat-file.adoc
> @@ -86,6 +86,8 @@ OPTIONS
>  	Omit objects from the list of printed objects. This can only be used in
>  	combination with one of the batched modes. The '<filter-spec>' may be
>  	one of the following:
> ++
> +The form '--filter=blob:none' omits all blobs.
>
>  --path=<path>::
>  	For use with `--textconv` or `--filters`, to allow specifying an object
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 940900d92ad..e783dbbad58 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -472,7 +472,8 @@ static void batch_object_write(const char *obj_name,
>  	if (!data->skip_object_info) {
>  		int ret;
>
> -		if (use_mailmap)
> +		if (use_mailmap ||
> +		    opt->objects_filter.choice == LOFC_BLOB_NONE)
>  			data->info.typep = &data->type;
>

I didn't understand why we need to do this, below we only check for
`data->type`. The only other place we use `data->info.typep` going
forward seems to be `print_object_or_die()`, but that flow is only
followed for `opt->batch_mode == BATCH_MODE_CONTENTS`. We already have

    if (opt->batch_mode == BATCH_MODE_CONTENTS)
		data.info.typep = &data.type;

in `batch_objects()` before this, shouldn't that cover this scenario
too? Maybe we can add a comment with the reasoning

[snip]

--0000000000006fc3980631b697c6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 9935c73d957f7a55_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mcjJvZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md08yQy85emtrVTZLWlpSdHgwaE16UlBDd1M4WXdyTApaR3ZJYXQ5OHF6
UXM3RTlHeG00ZFZjMUFzaHJsZVpqcnN2RzYxVEYxVXYrandyQU1LNWJET3BVNUV2ZHg0Z24wCitZ
RzRIVjVDcXhmUkc3NkQvdTlLS0ZnWERsS2ZIL210NDVtZDk2RncyTktWb0I3L3IyT0ovclAwWXdJ
U0NzVlcKTENhYXJDSmVjdjR6dEF2K2haK0c0enBQNFBDT1ArSlg5cnhKMytEeGt4V1MzcHRzRnNY
ZERGbG1DUk0walI3SQp0WGhCRFY3RDI5ak5pYzAwVUtzV3JUcjBYQXliT3Y2dUZ2S1lrRURXaEsw
Wkgyc3NoYXN4MTFTbXg4ckc5OFlBCk51d2NXenZjSjdrd3FqM1ZDZHgrblNPcUxXK3NWdkdEV1BN
TFFFVExGMTBYN2k5SnhNcCtwczBGNDE4MGFVbWUKTG0vNDEwbVBXVExPVE5MRUxERzY4c1dqUnV1
anV5NXBTWk5mV1RHcTFKc1NCTTFrRXZoYjErZHQxQkFlS3ozZwpDTHZsNmtsMm51TWNTSDBCK1RF
ZHE4N3BlVU5jVEJiVmlGRW8rNG9XTzVIM2xkQ2RpcDlHc2JrTVFleHA0cGxSCkd5aVZVSWdBTVUy
azRxdE94eDQ0aE0vVk15YWxZRGhIWk1LZ2VmMD0KPUQ3bkIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000006fc3980631b697c6--
