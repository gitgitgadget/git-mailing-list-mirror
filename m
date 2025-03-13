Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C64E2661BB
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 11:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741864032; cv=none; b=odGvv0f2Wi13hTERwRgjd6KUQAGJ6J5sHYcnNpkNrqJ4HVP4Q64qnVaYMDhI1v6fLJo0MRJeOpQaoTVoDQjLWRQ4DN2DFVqifZnMdfSlvhPT12HBgyvT2nlCvu1f3weoJHXdR17R2UF+L4dTTv1woGw4bg2KvBdcoe8eUG1wctA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741864032; c=relaxed/simple;
	bh=VmCuOl8/bgMNMb1I03bQrAHAVqExQ71pQRB5Dtdv0l0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WxbliqVFT4uZ06YWCyIQh9xAB73GvgmYkKfjkKR9Pe02ndLVtuRJMH3rTEWUZNw2IK9RhTpeXA12qMdRoAjSuv2ZJNqoa8efiCGy74yvZvSdYGq7onQaQIlQc9be2a4bnyAQX6B+7OjCZdzWPX37eb30cZjqet601DPdLyqqTaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bUrNVXZ2; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUrNVXZ2"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-86d6fd581f4so1517836241.1
        for <git@vger.kernel.org>; Thu, 13 Mar 2025 04:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741864029; x=1742468829; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=nYER7j+nzpA5u7KGbUFCyV76EvnPGPTyfXDLoYWwlxo=;
        b=bUrNVXZ2Ef+TPhY5WDi/tKvXGKn9KgxymAsOM1HMIF8kqRKHDbj4mkSYfVbhbPLwJA
         q0UugtZEMMTUcFwrattLmibyV0hVNAbeUOF/hEF4Uq2SvciuI/ohmWcCzb7o+hf3chhc
         3GuOPWNcK/cAZbIY8fj1qdIbkabJfdX0y8PYWlWxxyiGqhW/101iID70QOvFz/iewbh0
         QApuBRFNoXHnKy4q4oqAY7kcMiFyrgQFU9RSMd5VL1L9DpeGF/CT9Rnsmp7UbrnQRKjx
         Q0ij1tXhmunkiHmhM/LnKNHUsEliSpkh8hmDYCnCyeWCcBD18BeDiHKsh3gZXIM4gHT1
         Tbew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741864029; x=1742468829;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nYER7j+nzpA5u7KGbUFCyV76EvnPGPTyfXDLoYWwlxo=;
        b=cyf2oU672PGkS7+7e8V4Dz814r6mseZq0sA7kNNWjZTFbUQSh6mJ3p/yjtz+t9euAA
         wMG2IWopT5nmYQ0TqPIPO4/DB1sq3nJP5hu+sc83CC+p8hpIZPKPH5l4ZP9tx2cbitz+
         KlSiuL2J9zY+onMQmUmmLKzlnJZmZwkM9/c0k48g8z+lA59JYoCDaslB2ZygQctP5brm
         9SlZnHXyMNac9MMakEvpDbN8PWTSE1JTQmcGzO+rUVslXvflSxZnHQxgXAquGRuqHCsg
         o5WPODqh+iZBL3FgaNUcxVJNKISdZuxTqQ6dUBCk9uzcnRrZNdUfKJzNSfPLPgXVxHqt
         c3qQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1au2bbpC66HfHFjfPtQjparkbSAtdGHFkd1mVM9hlhd/2som4mfDhPxBTN8SJeED9Ayk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBCh6nFZOoh3LYR+OMraeTkYCaWrjKNCYse8MzYUu5Ri1T+jTS
	wFWrzLS50j0MoShwX8SRehpcNgRzsBQAqokXn9RravC3gh+IFGjaGO1PYNM3bPvmGPeIk0aDzE/
	8Kj3/YuWuxxoCXU8eD88qu6bM7KY=
X-Gm-Gg: ASbGncsB99lQltPRDkWRBc9/tTI2dHROyzCn2tuAv2GpJLlksfV9dxjDQiqueeyCrre
	0WXe5JbJCg2t038cdMacZzaRVJMAJYe22YAitka+HFll3WmQGOts8q0pMtGUfTuiPqyjLeHIhr3
	qnAEE2Oyetfv9IgavKYApOsJ2NdMk=
X-Google-Smtp-Source: AGHT+IESPwG/tcoWEhJbdl88jEwQGDOc7VToEN1PSTJZlVHEZZ+K4zib987l33og43U43ZIxrWLGcOmGsvPR20s6US8=
X-Received: by 2002:a05:6122:90b:b0:51f:a02b:45d4 with SMTP id
 71dfb90a1353d-5243a30438dmr1290639e0c.1.1741864029341; Thu, 13 Mar 2025
 04:07:09 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 13 Mar 2025 06:07:08 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250312-b4-pks-meson-breaking-changes-v1-3-b89e9a59d228@pks.im>
References: <20250312-b4-pks-meson-breaking-changes-v1-0-b89e9a59d228@pks.im> <20250312-b4-pks-meson-breaking-changes-v1-3-b89e9a59d228@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 13 Mar 2025 06:07:08 -0500
X-Gm-Features: AQ5f1JoSgbppGbAUOcRZcb1B8oynpbdwDK6sPQNMkllEBmRcwrBO75rfnOfKkjE
Message-ID: <CAOLa=ZS9FOdqrcg1eYLvKf_vwR4Ag2T+O-RCoGiKdC1i-DTFuw@mail.gmail.com>
Subject: Re: [PATCH 3/3] meson: don't install git-pack-redundant(1) docs with
 breaking changes
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="000000000000b777ed06303752b4"

--000000000000b777ed06303752b4
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> When breaking changes are enabled we continue to install documentation
> of the git-pack-redundant(1) command even though it is completely
> disabled and thus inaccessible. Improve this by only installing the
> documentation in case breaking changes aren't enabled.
>
> Based-on-patch-by: Karthik Nayak <karthik.188@gmail.com>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/Makefile    |  2 +-
>  Documentation/meson.build | 13 +++++++++++--
>  2 files changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 671267a8ac7..e6b20c021fd 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -509,7 +509,7 @@ lint-docs-meson:
>  	awk "/^manpages = {$$/ {flag=1 ; next } /^}$$/ { flag=0 } flag { gsub(/^  \047/, \"\"); gsub(/\047 : [157],\$$/, \"\"); print }" meson.build | \
>  		grep -v -e '#' -e '^$$' | \
>  		sort >tmp-meson-diff/meson.adoc && \
> -	ls git*.adoc scalar.adoc | grep -v -e git-bisect-lk2009.adoc -e git-tools.adoc >tmp-meson-diff/actual.adoc && \
> +	ls git*.adoc scalar.adoc | grep -v -e git-bisect-lk2009.adoc -e git-pack-redundant.adoc -e git-tools.adoc >tmp-meson-diff/actual.adoc && \
>  	if ! cmp tmp-meson-diff/meson.adoc tmp-meson-diff/actual.adoc; then \
>  		echo "Meson man pages differ from actual man pages:"; \
>  		diff -u tmp-meson-diff/meson.adoc tmp-meson-diff/actual.adoc; \

Nice, I totally missed then when I was tinkering with this issue.

> diff --git a/Documentation/meson.build b/Documentation/meson.build
> index 594546d68b1..a2de85f5aad 100644
> --- a/Documentation/meson.build
> +++ b/Documentation/meson.build
> @@ -96,7 +96,6 @@ manpages = {
>    'git-notes.adoc' : 1,
>    'git-p4.adoc' : 1,
>    'git-pack-objects.adoc' : 1,
> -  'git-pack-redundant.adoc' : 1,
>    'git-pack-refs.adoc' : 1,
>    'git-patch-id.adoc' : 1,
>    'git-prune-packed.adoc' : 1,
> @@ -205,6 +204,14 @@ manpages = {
>    'gitworkflows.adoc' : 7,
>  }
>
> +manpages_breaking_changes = {
> +  'git-pack-redundant.adoc' : 1,
> +}
> +
> +if not get_option('breaking_changes')
> +  manpages += manpages_breaking_changes
> +endif
> +
>  docs_backend = get_option('docs_backend')
>  if docs_backend == 'auto'
>    if find_program('asciidoc', dirs: program_path, required: false).found()
> @@ -479,7 +486,9 @@ endif
>  # Sanity check that we are not missing any tests present in 't/'. This check
>  # only runs once at configure time and is thus best-effort, only. Furthermore,
>  # it only verifies man pages for the sake of simplicity.
> -configured_manpages = manpages.keys() + [ 'git-bisect-lk2009.adoc', 'git-tools.adoc' ]
> +configured_manpages = manpages.keys()
> +configured_manpages += manpages_breaking_changes.keys()
> +configured_manpages += [ 'git-bisect-lk2009.adoc', 'git-tools.adoc' ]
>  actual_manpages = run_command(shell, '-c', 'ls git*.adoc scalar.adoc',
>    check: true,
>    env: script_environment,
>
> --
> 2.49.0.rc2.394.gf6994c5077.dirty

The rest looks good to me. Thanks!

--000000000000b777ed06303752b4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 8f7e9fabda0b52ee_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mU3ZGb1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMlhHQy93S2dIQzhUbkpqQ01nVEpuczF4dk5FMW45UAp5UFNZMDJnL0Vk
WmlFVG9qODhIWWdCQU8zby96UmdDbXBKdVUwVnB5bExIMlhjLzl4c1VjcWFPLzg3L0l1ZWxsCnVv
cURsZVIzeHVkOVFkNVhWM3FJbkJKWTdQSTNZMzVDeWFESGhlZDkwYVZiK0h1bG9qbmlwU3NtaVhO
ZS9ESzQKMDhyV2pXZ0ZQWjU0ajMzc0FDbVlpZFhPVWpmMHZFdk05UmRDdXVWR1RNRHhIOHl2U21m
cldENWpVR3YrektNNAo4T0VmNjl1UE4yZmVYdTk1a2RMVXdqMk9WQnRsRWpSaU1ZcFcwWFl0RE9h
SGlnUzQ4TkhWcGNIYU5GdlV3R296CmkzaG5DTTI0c0U0UkJ1NGNmMVBML0VVSXF1RUNMVG04b1BL
Z0lGWWplaVRiQXphLzJFdTUwOUVPQXlOanRQSEIKdVdNdDA5djF6SEVRdUN6VjhmYk43dDE4ejVn
WmhjNkw4cy8xVURzUkU3bDNVbVVNK2FacU9pSEFmS0w0ZElxbwpXVE8zOFh6U0Zhcy9Wa1FJZFNm
akNDRi8yaWNFVEN0SkNSNlg1WlNoSkRNT3FOT2ZtOUxXNXkyNnF6L3RZb1BQCnhNVFNwSE5XaUxm
M2JudUswRHkzZ1VKZnlYdmVnRVV4b1EzaG1Oaz0KPXJMWU0KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000b777ed06303752b4--
