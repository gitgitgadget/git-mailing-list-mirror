Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CDC283C97
	for <git@vger.kernel.org>; Fri, 11 Jul 2025 10:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752229555; cv=none; b=SpVsVwZ416E6BbxPSdyoYHuT9iI026JFifaQdSzRRy2NxYgDKUIYbf9DKjGmvalR8HbhH4DfUTf1kpv6OOpM1bwBS0jDi8cM1saBdZexdRZS4kiqyy9jjiiRW6riG4ilNbs7tWHBdNCfb7m9oLiH4qX0bqalyOehE8/uV2S6CAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752229555; c=relaxed/simple;
	bh=wgg89ZYx8W2hUVymT9EiGmszfZod47LnbhUcoSxT7pg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=q66DBsiW0nuxzSpZDEmOHngIaygnPfdIowVkF2cOqOb29SRXO7gu2yxIZWfgHDBkEtzD2sz09HMFgfzaBsoBnQqafeiYyId/1Tpv7gQQ70v+Qum2CNNy6st+2Fp6AKykAW12806h73rWGQbMPE5foTTK/XqtWE+2qcxZnNot51g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eX9l8J7X; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eX9l8J7X"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-88131f0badcso1992730241.2
        for <git@vger.kernel.org>; Fri, 11 Jul 2025 03:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752229553; x=1752834353; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hza+qBJYNoyQQDzSwDyW6gXSS/aGEDUlhRpkMZoiVTM=;
        b=eX9l8J7XxV1Q6qd7x6FQmP1Q3sR944Bu3vKxCPTKNf2JtFqHrWTdo3pNigoBqggplI
         XpVQauxz1g2kj7UQk2MUoygRjBRwEL+ZzQvYYM+kAuYvoyjRvtrkXRMEM0eNx/wmN907
         o/u268tCVUM+N1HUDJQ8YReQuszLw01mSEwPD/SFrzwcLaxGCW4FVJuxm8iFTq78NB1k
         Ynx0XCCEEzByjHLaCDtLYwQsgdk/zly8AEhdgi/6E8bPYGl6JeAzBMzWN0gCZxFPkqZs
         Mr9+8hcXdhfUpSeQL8QzxsxuA5PDTyA4Bf0D4QL0/YlqKWlIPW6NQiDMlePZzLBCcov3
         uTDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752229553; x=1752834353;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hza+qBJYNoyQQDzSwDyW6gXSS/aGEDUlhRpkMZoiVTM=;
        b=NBoElwLgY+e7oqB4RmZrdusoZ8j6e/o619JuLwKl3fn33q+8jEWEfiKA2KNfP0Rw8a
         dw1AE7To87wsrzLHmdioajg6vO5T+d/6wG67QIBaY38vF3AbfcQmp38Y4sbtPkh3SW56
         uTbU0/A24vhhsKEg8T8jTAHfuW93W/+VkYj9Lni9vYVQUwju89TaNvZN0dLwFJijOtqB
         J0ETX8OIBOwvN6WSohl/Wtlf8V2XBidkZJKSMIj5AQ/kmnSE6GlifxFtSAoQPilgtGK3
         +jhq1pXKrVBXT5WIGffQIyHc8+Xzw+fIYJRaoDOXCOZq9h1+N1xL+syHoB+HveAkSuan
         THgw==
X-Forwarded-Encrypted: i=1; AJvYcCWqJ0WUYtACd3226NzPJN1kHqW+U88cc1wivSjeBbIUlGewK1T/vsFf6ped4RCb0Hr3Pac=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGfwLHSGthJLoUxBrMKEEde4C+80K1YdLcBn3DhUY2fQrHEv81
	TalQ9igf5440HSJW/dt14prc0ahgwMvaUe8238m1jvIagdV0mUpgCKfqNrm/FEFzm5wxZp76m/l
	apnT8m5ySWPFBNvy2TN5SFicvY9CtUiI=
X-Gm-Gg: ASbGnctXt4v519wiN443hZ7YJ8DvZ3SMJVnBmMyHiGmgWoyTD67d5NCGO73AA2ksMhS
	LludkbgL1AUKkQpendWfvr8rBWMNOitr2BawkI83blKvwWNaHkwfxRySjw4UDz2shHLechItjWO
	5FaARxcWfKsVAl1C3iKwOojcIy2aIwkH7J6ojgnCUGRLhwH0BC0xlnhnJQ1dY+hmL/YgV1VkFF3
	z9kF9MAqFHG1YXbVcsGqIpESYUvyMzL/fWVcnhg
X-Google-Smtp-Source: AGHT+IGdc/roCykY4F+VNAmRye3pUdqx1VeGZKFJ0H/Ebx+5wry2iJ0WXJmqEFytvFSNMsiCJF2ShMaRo7fBjE+U86w=
X-Received: by 2002:a05:6102:2c0a:b0:4e5:c51b:ace4 with SMTP id
 ada2fe7eead31-4f6426a6685mr1607629137.20.1752229552782; Fri, 11 Jul 2025
 03:25:52 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 11 Jul 2025 05:25:51 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 11 Jul 2025 05:25:51 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250709-pks-object-file-wo-the-repository-v1-8-62627b55707f@pks.im>
References: <20250709-pks-object-file-wo-the-repository-v1-0-62627b55707f@pks.im>
 <20250709-pks-object-file-wo-the-repository-v1-8-62627b55707f@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 11 Jul 2025 05:25:51 -0500
X-Gm-Features: Ac12FXyY1zNJEhTYaWFFoxcOwWGvi6bjGsBoq6pQvv-H4xwxQ6UUqNmKZB6RMeg
Message-ID: <CAOLa=ZQhWh9OKapT2=BB1kJNghYYPF+_133Qs_q8ZkyU1ONzew@mail.gmail.com>
Subject: Re: [PATCH 08/19] loose: write loose objects map via their source
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000000f1e050639a4bc69"

--0000000000000f1e050639a4bc69
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> When a repository is configured to have a compatibility hash algorithm
> we keep track of object ID mappings for loose objects via the loose
> object map. This map simply maps an object ID of the actual hash to the
> object ID of the compatibility hash. This loose object map is an
> inherent property of the loose files backend and thus of one specific
> object source.
>
> Refactor the interfaces to reflect this by requiring a `struct
> odb_source` as input instead of a repository. This prepares for
> subsequent commits where we will refactor writing of loose objects to
> work on a `struct odb_source`, as well.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  loose.c       | 16 +++++++++-------
>  loose.h       |  4 +++-
>  object-file.c |  6 +++---
>  3 files changed, 15 insertions(+), 11 deletions(-)
>
> diff --git a/loose.c b/loose.c
> index 519f5db7935..e8ea6e7e24b 100644
> --- a/loose.c
> +++ b/loose.c
> @@ -166,7 +166,8 @@ int repo_write_loose_object_map(struct repository *repo)
>  	return -1;
>  }
>
> -static int write_one_object(struct repository *repo, const struct object_id *oid,
> +static int write_one_object(struct odb_source *source,

Nit: In one of the earlier commits, we renamed a function working on a
particular source to have the '_source' suffix. Should we do the same
here?

I understand that this is related to a specific source (loose files) and
probably would move into its own file under the objects namespace. But
perhaps something to think about.

[snip]

--0000000000000f1e050639a4bc69
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 25e4820fde49177e_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1odzVxMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOXZOQy8wZWsycTQyZGdNdk9TMlJuRGlsQlpnMktpMApDSHFpWnNCMkMw
R0xSbGNsMGRJVFVYbCs0UStqVzg3UDRwR3V5enFEOVFOSFNMNVk1TWRWa1piWmltYVVkOWdJCnlT
YUNrVDE4emkxOW4veHFCdXNreEZpQTkzcU5vWWdDMWgyOEJEVFRnNmdMVlVnb3dCd0dhcElIN2FC
UUdQRjIKSXpvbk8yanFPZ2J2Zlp3SG1SV2lpRFE4RjZzNmNFWlhQSldlWGh2K1htVHQwZ1BJTm9R
S0ZDUE9jNU4xcEJKWgpzcmtjQmgwdFFoeHVqWTZCYlJnTjZLRDBQQkcwYWRMNnJHbWM4WGpJRjIw
bTVRTzJBTTRVbTVUdlJ2SG9aR3k4Ck1yNGU5WU9XaVJmbFh0dm9Pdm83ZlpKREtCdm1zZzdnU2lZ
b1RzVHNEa2tUS2J6dEx4a1dwc24xbkVGeWt2SXcKRXdRVE14bkRHVm4zTWQrbDJyL09zTjNKUllP
bTZCOGNYVVhKYVJIVU11NFZxSnFrc1NrdXJEOUlKcGlNTUs4ZwpKQlhHV1oxOXdZUVpmZ2hGMGVT
MFFwQk9oVk50dWdzZ0JJVVArU0VuWE52WUVSZkxFeGxNajMxK0tWY1FTSlRQCkx5cnVJdVVDM3Vs
cWYxcW5lOTUrSG1ZZ2hXaEFnVDI4bUUvNzI3dz0KPUZZcXAKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000000f1e050639a4bc69--
