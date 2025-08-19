Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159143115A1
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 09:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755596458; cv=none; b=euJtr4hD8TwGuOoYbGc+E918cknaP9o4ADHAOTH7jSrTMpQc7z5pwnnbLd4WKW8v5vIHhHn2LXQUEjE++EDgr1O5Fu2OOMRktxAI8mSroEJAyjuYgjdPclBx0dbR77s5Cl5obE1W2YZB6Ta7Kq8I08x3QAZ5xfTvDFgTO+YswWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755596458; c=relaxed/simple;
	bh=iSszeMUmoGI0FcVRtftV62apivU9IrzKhu82/ayzGss=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CzJoyTlh413ZiLqJCpaBAfLgaOB3tWRNeDKixlHcgEEt38sRq5rbHqAqDkhhRe7PbnE85evTeWAmTUdgOq0G36gR59zh3SqjpXaaU09/xWQ5S61+MymO45XIh677L2N0UCmBFaGB+X1mztECVndo2YiwsePmCLngZJaPUCtn3MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FudkVG7l; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FudkVG7l"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-53b16f90e51so3634887e0c.0
        for <git@vger.kernel.org>; Tue, 19 Aug 2025 02:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755596456; x=1756201256; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=eKC8OJJOLvjJ0Hw9+SwgiaP9ulFGJSWBIV5Lm7d3syg=;
        b=FudkVG7l6qYYH+EYK0IXbSz/FTz4jRPzci+RSotIpW3ZmMjzGUJTLym33T8y6ZgSJN
         EFG/r1nLW3jBY02pvJGqHf7dVdl2rSgkfdAg7icXPiXTXqhRdPx4addONqf9wttKuGRI
         0IQGBAxp+HI2d+CNIr8ptrZrpFg/GuqY01IavbcL0CJzCfuFeTQ5ETCk58+JddOSyL5A
         7/SXpiEsrxz/iFKGEs+RF9gjF5nZaqw8cfFx6HCumu0DhFm7baSIEFdh+ej/jQjhJjDA
         MSgkYCyG5duhr8f7jur2zRph2SfinZfuPvV79JdRKDdyB7yyx9nTzvMuTw0s4WmpVwmf
         YJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755596456; x=1756201256;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eKC8OJJOLvjJ0Hw9+SwgiaP9ulFGJSWBIV5Lm7d3syg=;
        b=RuDq/HOjtxj12mxPj34l70AnizpMHPKwaIjZJFXQ79lqfmtvvt7gMF+/tFOyyCehM2
         J14CZ8ga7xLRC0d4lCOqTr0JXttHH95YKN2/3nlv8rk0yOAm8iqUwzRnx9XgpiQS2SED
         NiD9dNCGZem8gFNQSUOnFYC0ilfmXEoa24q4pqi7LR4DkCreVPNvi/U9F4cZzQUr8daQ
         lrZR/ufNMlua2JhkuZnsSpJFC8G0wyFSKOfaH5yVt4dj/aPqAD2knWWX48Mu1F1B5zEl
         FAXOqwjIP+5xg7GJmlcN/2SpdA6Zz3bmdcaWnM1xemvXnAYmVdJz51qdy6sPQGiCcdDe
         /BZw==
X-Forwarded-Encrypted: i=1; AJvYcCVAgjRaxnWZzq3aAXKw3TaM9tEZNFPiS2Nk5YL4fAMBDdrBFUuq3DDkMNXADCb7nuPjbCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH9gJRkR9NrCwoA4pM+P5OIkHFxS0xMZQfRUUOi3k3PDoFK0Vp
	rLWehzYpoCSZ0m66M06PLKJAAX+H+wzl0/gRmazDMjFuf1xAA8tJ3YLeDP1VxcuNLDkbygfPk5p
	NjQ9KVnVhW2g+Y1zBE5qGxJPVMe/NQoUVng==
X-Gm-Gg: ASbGncsFCOanH8p+U+YyiVMYu5N5knptOxcQK82SNwyAAOrLVpnSRwMSfpihE22lVNI
	zNhGkv89gV1gjAoj00lKWnCJOquhQcTxhlaITT1x3UJpI3V499O+Ek6FhWQWEZ9vpCgF7vqg4RD
	Wal++6YJSarsB5PaaoXpr9fThjwbBtPJ/mw18lkOvzzuVskpLsSwHWs1X+V/e7kKcc2d4j/SMYm
	ZgF5ErZ
X-Google-Smtp-Source: AGHT+IH+f4Po4WQ5dKieKtqZ9E/aLI4BSac3YGfWVXQjYZHCHGIUIaUx1Z36JF49ZeEXoXWLqIh+yJiSC35BMpAamWY=
X-Received: by 2002:a05:6122:921:b0:535:ed79:2aed with SMTP id
 71dfb90a1353d-53b5e5955b7mr590830e0c.2.1755596455575; Tue, 19 Aug 2025
 02:40:55 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 19 Aug 2025 02:40:55 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 19 Aug 2025 02:40:55 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250819-b4-pks-meson-tcl-tk-v1-3-6bcaff0bc0a0@pks.im>
References: <20250819-b4-pks-meson-tcl-tk-v1-0-6bcaff0bc0a0@pks.im> <20250819-b4-pks-meson-tcl-tk-v1-3-6bcaff0bc0a0@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 19 Aug 2025 02:40:55 -0700
X-Gm-Features: Ac12FXy7G91q8IfMRrUSzm4vEhlSZnizwb4vio7ymvq0Wdh-VmhM4hMk0SqDMTM
Message-ID: <CAOLa=ZTScBdh_JEvSez20+4cqnKaPaJmmmAGqGtdbzcTz703VQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] meson: wire up gitk and git-gui
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>
Content-Type: multipart/mixed; boundary="0000000000001aa9ac063cb4a7e7"

--0000000000001aa9ac063cb4a7e7
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Wire up both gitk and git-gui in Meson as subprojects. These two
> programs should be the last missing pieces for feature compatibility
> with our Makefile.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  meson.build       | 14 ++++++++++++++
>  meson_options.txt |  4 ++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/meson.build b/meson.build
> index 5dd299b496..edf7b69a00 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -239,7 +239,9 @@ git = find_program('git', dirs: program_path, native: true, required: false)
>  sed = find_program('sed', dirs: program_path, native: true)
>  shell = find_program('sh', dirs: program_path, native: true)
>  tar = find_program('tar', dirs: program_path, native: true)
> +tclsh = find_program('tclsh', required: get_option('git_gui'), native: false)
>  time = find_program('time', dirs: program_path, required: get_option('benchmarks'))
> +wish = find_program('wish', required: get_option('git_gui').enabled() or get_option('gitk').enabled(), native: false)
>
>  # Detect the target shell that is used by Git at runtime. Note that we prefer
>  # "/bin/sh" over a PATH-based lookup, which provides a working shell on most
> @@ -2207,6 +2209,16 @@ configure_file(
>    configuration: build_options_config,
>  )
>
> +gitk_option = get_option('gitk').disable_auto_if(not wish.found())

Since 'wish' is defined as required above when 'gitk' is enabled, would
it even come here if there is no 'wish'?

> +if gitk_option.allowed()
> +  subproject('gitk')
> +endif
> +
> +git_gui_option = get_option('git_gui').disable_auto_if(not tclsh.found() or not wish.found())
> +if git_gui_option.allowed()
> +  subproject('git-gui')
> +endif
> +
>  # Development environments can be used via `meson devenv -C <builddir>`. This
>  # allows you to execute test scripts directly with the built Git version and
>  # puts the built version of Git in your PATH.
> @@ -2233,6 +2245,8 @@ summary({
>    'curl': curl,
>    'expat': expat,
>    'gettext': intl,
> +  'gitk': gitk_option.allowed(),
> +  'git-gui': git_gui_option.allowed(),
>    'gitweb': gitweb_option.allowed(),
>    'iconv': iconv,
>    'pcre2': pcre2,
> diff --git a/meson_options.txt b/meson_options.txt
> index 1668f260a1..8fa330771b 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -41,6 +41,10 @@ option('expat', type: 'feature', value: 'enabled',
>    description: 'Build helpers used to push to remotes with the HTTP transport.')
>  option('gettext', type: 'feature', value: 'auto',
>    description: 'Build translation files.')
> +option('gitk', type: 'feature', value: 'auto',
> +  description: 'Build the Gitk graphical repository browser. Requires Tcl/Tk.')
> +option('git_gui', type: 'feature', value: 'auto',
> +  description: 'Build the git-gui graphical user interface for Git. Requires Tcl/Tk.')
>  option('gitweb', type: 'feature', value: 'auto',
>    description: 'Build Git web interface. Requires Perl.')
>  option('iconv', type: 'feature', value: 'auto',
>
> --
> 2.51.0.261.g7ce5a0a67e.dirty

The rest look good.

Thanks,
Karthik

--0000000000001aa9ac063cb4a7e7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 2628a935a54ddcec_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1pa1JxVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOXhlREFDa3RJYSs4eUV6bHR0emZCNEpnYThqbW9wUQpIS1pWT2lkaFVE
VmlGVjlTY1NTVjZwZmpxNjdUUHorN05oQUJ5ZkxUZ0I1VlVCUXRPQ0FNSGhCQXJqUVk1MUdLCm5C
OHoxb0lNRG9vMDU1eitLSDVlVzIzejJjdzI5azVnVGIxWmxaRUFFUnJlQ3pNcXZpcTNwNUYxVUQr
bURNVVEKS25nQ1FCRHh3RGRZZXNRNUFkTk5scTE1NEFIZVA0ZXpjK0wrZUp6NHY4SWh5OW9EZFMz
RHQxNDRTSmJVZS95SQpBZlVLeG03M3luU3JWU2pvZUh6VFlVOVFVSzFxVXVlYkxKRVhEVmkvWGJJ
N1o1bnRMNjlacWNEU0xzNVFTUmtCCkRhS2tKcFdmZ2lISjdSUjdaOFJBSVc1MnFzcGxsRzMyR2pJ
Um1CWWpyTjhvYkdNbXdnM2dBVDdIWVpqaGhrekoKbEZhWFU1VHBNZGlMbTFFTGNtNVpGQkUvWkNH
czlXaWxiUmhFY2xNSHVnRE1Ddk80NWFrWWdCTXA1QkJhUUVoagpvbWlLeEF5YlFJSjVFRjVBWldw
dThqU1FxNThqQW5UbEptajQvQXNvdXppQmNLZ2VvbVkxV2VxVUZ3NVQ4YWdtCm9tWTZ4QTN2dUY5
WEtHeDhDTGZOa2FxY0ppekVMa2VsTnNyNyszZz0KPVZGOXMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000001aa9ac063cb4a7e7--
