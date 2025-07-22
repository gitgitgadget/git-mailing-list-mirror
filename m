Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6604CE08
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 09:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753175010; cv=none; b=RAyon5O4456+1VkETefc5GkxcsZ1NDH2txb9MaZM70VMF67WPN0ZcmYy33ZHZRpP5LvsGHhsrppqyWIYVloThZx77E6JqtpnP8991JolgJrSHcmHAwtKwoht2Ldbmy45+ERAgotnYg2wCAFH229nB+e/7OVkiq7F2DGcb41Ps8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753175010; c=relaxed/simple;
	bh=OsOn/I+7C/uKPminQFqvhopszfhf9DdgiCqC3Cj6Bq0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i6rsv+v1HJKlrJgWtrT3SCEzcvTW67qkUDfmZotMeuopz/ITzVIHoOwpBwZGQ4axWNERjlxB0vBU46lpxqO2BdTEJQJQggYk7oHwBEoMSm6T4iJJV+rbc0pbQQJNn2XssRcn8HmmeoYuWsaC6Ev9MWJSY5eoPfVU8i3rzke2B2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qned7QCj; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qned7QCj"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-531b4da8189so1318929e0c.1
        for <git@vger.kernel.org>; Tue, 22 Jul 2025 02:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753175008; x=1753779808; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wz3StMfFV0rzodWjuHiVoSYyB0LRa9ni3/rySfDWthQ=;
        b=Qned7QCjmBy9IHuXvhMCWMBjL4QDOMOUKELaYcsRROMdwYg35G0F0P8FYf422G9Ah/
         IEOLqqDb6UMYNiRndOQ4ILJir37LIj3zPhK6fCYyljloGG4hkZHl3oufWajD0hM9BwIJ
         y8TaYLOpMFEnRpbPy0qGnYIeVPPYVHPSunpb/TMBtvClVVYfxNye59H/RcJXgsbQqkLc
         FT3CoGnvIpeS2ZpqCEcyR2NN2tngtnDt1mmTp2njMNp6kCIBlue7YM9GAWIdu6V4u3Zr
         rqsJY511ywmascaTO3VrlslIl+WNuCYMaXU0HPfkABJx6WK5ceGBEm4BGpYT1L4GFd99
         kBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753175008; x=1753779808;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wz3StMfFV0rzodWjuHiVoSYyB0LRa9ni3/rySfDWthQ=;
        b=fseAGXX43n2pcGCw0LPS4S4nrd2J1CoHMvITwGV/AKa/zNKCQyIOOcJV9Et4Ft9irL
         8OzpHVelSeGXb2gM3Ymbq4WRH9NfDfvgHJTpQCHo1fvBL9TpaoDXqjaeRccp0Ptbl/Bz
         INBaQTR5kwyrW7Kjif0y2SCoUAkWriJsIuG0BFWwugvEv0MhIX/c3zw4LCjM+H+MPyKs
         tu9P4g7BQfqI/DIAIeam2qdIROikRywvvFr0Z2m2Xi+g/dSxFTKFDyFAobApxtwvh+H7
         Jf5162Y7fYne+qEXQbswB6CNL+ZND5OJ75W8YgJ0652oAsLPIWRoVPdx9lK/yi4hmnse
         sTMg==
X-Forwarded-Encrypted: i=1; AJvYcCW9zvet93jei450gaq2PHICuBmauYBBwrLwUV/Bk3wJ0mvPGJc+7smxGs8EMAkdadUHMIY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz26LdAw0zyNrcDSuYxWCBbcqpFKW6JdlnEmy95r0KnTLgUrZMj
	Z/mO3y3NNqImFT55+MODUF/vF9bvgvSPXNYVFbaIMHFsDURGdX4npKB5BVAPfZYbA2Lu/ZepyPg
	TCMaJQEuvQeGnQ3oALmpEJYWDRVdH7Wk=
X-Gm-Gg: ASbGncvkskcPevzdjAUcvFLxMiBUYVPoiPu/aDE5YCbmUPQH4MBcdLRvK24ERHfEMbR
	Cf4ejNj4WBYOrXNlHVVcYDiFDquv/EbkgFodOv6B/VEi2nAW+fslqkaaZZu26XUaqmCUYYjQg/X
	Mc7jk230PBphQCWfCys0sVcVJyIrgOIoJWd2N98hI4co7n4mS4nw1cRSncp0nzn0aBA5INgLiFH
	kSWLQ==
X-Google-Smtp-Source: AGHT+IEksc/YKPllx/sjYuZnGQF/3eEyCpB94wu/GKIwSoOXdlAnX9Xa5dcAT/skqX7hoSBGMieVaJnpl7B62ytaQ7g=
X-Received: by 2002:a05:6102:38cd:b0:4e6:d995:94f9 with SMTP id
 ada2fe7eead31-4f95f3bf235mr12415434137.12.1753175007896; Tue, 22 Jul 2025
 02:03:27 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Jul 2025 09:03:25 +0000
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Jul 2025 09:03:25 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250722002835.33428-2-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250722002835.33428-1-lucasseikioshiro@gmail.com> <20250722002835.33428-2-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 22 Jul 2025 09:03:25 +0000
X-Gm-Features: Ac12FXxfx3xJ67tMba5mhoHu2xXfmlVK0JWlGJdgD-0FDcBo7yrXwTACkb9mLOQ
Message-ID: <CAOLa=ZREo19jCj3i+XkRM15AzaAV9ZLOvt42pTiUFmcZpCyS5g@mail.gmail.com>
Subject: Re: [GSoC PATCH v5 1/5] repo: declare the repo command
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org
Cc: oswald.buddenhagen@gmx.de, ps@pks.im, ben.knoble@gmail.com, 
	gitster@pobox.com, phillip.wood@dunelm.org.uk, jltobler@gmail.com
Content-Type: multipart/mixed; boundary="000000000000935ac2063a80dd05"

--000000000000935ac2063a80dd05
Content-Type: text/plain; charset="UTF-8"

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

> Currently, `git rev-parse` covers a wide range of functionality not
> directly related to parsing revisions, as its name suggests. Over time,
> many features like parsing datestrings, options, paths, and others
> were added to it because there wasn't a more appropriate command
> to place them.
>
> Create a new Git command called `repo`. `git repo` will be the main
> command for obtaining the information about a repository (such as
> metadata and metrics), returning them in a machine readable format
> following the syntax "field<LF>value<NUL>".
>

Doesn't the latter sentence only apply to 'git repo info'? Other
sub-commands may not follow the field<LF>value<NUL> syntax, no?

> Also declare a subcommand for `repo` called `info`. `git repo info`
> will bring the functionality of retrieving repository-related
> information currently returned by `rev-parse`.
>
> Add the required tests, documentation and build changes to enable
> usage of this subcommand.
>
> Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Justin Tobler <jltobler@gmail.com>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> ---
>  .gitignore                  |  1 +
>  Documentation/git-repo.adoc | 38 +++++++++++++++++++++++++++++++++++++
>  Documentation/meson.build   |  1 +
>  Makefile                    |  1 +
>  builtin.h                   |  1 +
>  builtin/repo.c              | 26 +++++++++++++++++++++++++
>  command-list.txt            |  1 +
>  git.c                       |  1 +
>  meson.build                 |  1 +
>  9 files changed, 71 insertions(+)
>  create mode 100644 Documentation/git-repo.adoc
>  create mode 100644 builtin/repo.c
>
> diff --git a/.gitignore b/.gitignore
> index 04c444404e..1803023427 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -139,6 +139,7 @@
>  /git-repack
>  /git-replace
>  /git-replay
> +/git-repo
>  /git-request-pull
>  /git-rerere
>  /git-reset
> diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
> new file mode 100644
> index 0000000000..caee7d8aef
> --- /dev/null
> +++ b/Documentation/git-repo.adoc
> @@ -0,0 +1,38 @@
> +git-repo(1)
> +===========
> +
> +NAME
> +----
> +git-repo - Retrieve information about a repository
> +
> +SYNOPSIS
> +--------
> +[synopsis]
> +git repo info [<key>...]
> +
> +DESCRIPTION
> +-----------
> +This command retrieve repository level information.
> +

s/retrieve/retrieves

[snip]

--000000000000935ac2063a80dd05
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 580bb83f9316d1ec_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1oL1U5VVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNmZVQy80N0dweEFCYksvZE1qc1RRTWpXbVBlOGtGdwpidUZkOUlEbzRQ
SVI1Nm1EdWlZanE1Uk1VamNtNUVyVFg1bkI1aWU3dmFwYjJaaVBtSDRGMG5MYlFDT3lodlZNCnBz
QkpBK25WUlVIbFF6YkJnS28wQ1ZSdHJCczV4T0JUQWpucXFESE5TTWdIbmN4Mmw1NDNud1RFZzhm
OXdseXUKcXc5alM5Z1l3QTR5bWRpSER4bml1Z25PQTFqbER4WlJ1SnFjdDd2aVYxVEliN0VKV0hK
SUo5UERMZld1Sks2YgpGVG5hWldTaXhidjgwb0RUV0JOcFFLTXFSMHJFRXR3OFkxN2Zpd2d2dExB
MUlrWGp0Z0dtWFNDZmQ5RmYzemZWCk5OYStDZjRNcXJ1SXR6d1NUcXRBTENXR2xOMzh5ZTlQUUw4
ZHcrVThFQXlPTmN6eVdybVdmajh1OTBaVDU1TGEKY3pNZE0xNFdXZnNsZVNRWExxWDhJQUh0SjZ3
OGIwWEdpNncwQ2MrY2xrckd5dklGVXVxMTVrc2kva0ptaXlZRApjNjk2MFk3TWgrYy9vN2JMOWVD
R1QyVVNKdEFxQ25udEs1VWtSdTlSVmlVeEJaNFNvWVAwTURjVUoydlBwSE9TClY0MGlqSjNISEZQ
US9TRkJPMm9ORTlOMm9jUmlVU0dpdmVGZTc1ND0KPTBmV1MKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000935ac2063a80dd05--
