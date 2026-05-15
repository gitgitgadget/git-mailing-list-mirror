Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E628340FDAC
	for <git@vger.kernel.org>; Fri, 15 May 2026 09:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778837738; cv=none; b=hTObNcF3H8Rwm70LIe5tctLeAyZoHOiKAnAAvtBYJqYHQIIz3ipygSJPROKJBsLYg0/6vzp3Z04i/QUTEEBtJVzx87n9ZTRX5moUSVSDp8KpKVnZonDAwnhDWhVm5UXcKHJKvLykU8JLfmcr9S0q/EMVeWVqM0OVhj4WB6oS6kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778837738; c=relaxed/simple;
	bh=+YlMd+1YzgE4HxQqPJHELiQPqrZn3lyAeH2sBruCiQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d3PgYOoTxbP2GptCn+muD5wDo7VFKFa29aMd0RHa+I5FS/CCmer2qq+eNZXuc9WJo/GbE2vxucp63R7833XlMSfYAVKI/sfP0HNdOi55DnmXtXVmYm990Ho+3FgoMaSlIfgB9Bw2iLDDfdiT/tGo3F9QSkndIbcdGovhSz46A9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BddLI7UF; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BddLI7UF"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-45297094718so7156775f8f.3
        for <git@vger.kernel.org>; Fri, 15 May 2026 02:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778837735; x=1779442535; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Sra3YWAFcxCDVfVdFwHwrSK3H81dDT7v9TZWfubqgfU=;
        b=BddLI7UFZkkROmsu22GC1vuO4EKK+hkLa43Kl/TIsZ+jbEqRv7dAuJ+6qFDclYyDsD
         GADWjEfDFM4aNqh+brHknydWQtzMbyuQSASWtpy+KqMt8xjF0m7sc6MJL1hmAwh5R2xK
         1FNM5Q9mRyisNJcsiNl1IppEn2ViYumM/xZVryXczZkwhocOwQyWRdYWikLMHdyBwaJz
         u5m4KLEPlR+TR2lyD20zqXaatwb7VhdpbquGqWR9qKBs+5oIGmLpZW3tozUwagTAH2NJ
         d62wS37wQjfc2teCToU0YevH0+Y+Vso3JE6Cl9SsWT+QDIKR0PU7X10TyaYG5qRt2bti
         OWYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778837735; x=1779442535;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sra3YWAFcxCDVfVdFwHwrSK3H81dDT7v9TZWfubqgfU=;
        b=HtjQmacnLqHWhwqQEoAqApnhtWiCjq/6daPdr9I2eHNYmGPxrzCU5BQifewDknL5sU
         FJPNhPtmhByANkj2ezlF3oqgCExHZaVP5593CFTMgUsm7IZk7iavQgTlKYhRGGGeMx1x
         fFFBpwPHLeWlHy9y+MvOCpqXggOsivOfkidFyy3GRwP8IMXmhyjtxQkoVqy+Rm3E3xgo
         FWdVi2WWvpJtAXAR/zZ1bLWRZf76IEg12Z4165k1IyNCGpnm/3hO2Bgzdq+PAYiAucJe
         giz61Yroq6EjWhiH5EzZhk/yaJ5jcChIL8XxjZqjjmcGyKBb1oURSxkffN+Bkzlry+fB
         sMDw==
X-Forwarded-Encrypted: i=1; AFNElJ/WHGWInrD8jwUreF3/uzp7KbFKII93nFIAWiDq4nNP6AcrSGFXT4EF+bvTogrj2W4+Zu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YycNY5yKgnEzYcwbpHJkmvNCjijRFgkCvWo9RdPEtLgdN0MHMDb
	2ayQB+LnYZtmEM3tk/SyTYxH1xZy4WXyBLCHm+W9fr4p46OxRjUa/nNF
X-Gm-Gg: Acq92OHzOEnzRDDyKAAFTFbw7eU99srUeG4pqSdiMQO1029LojKOJBx8E/Hzq4I0Q6D
	UsxoC9O9vQxm8eUbkyPRsBfdDSd6PIoJkdckNbYwGXrRKvfGUayARWZ4+yyydx2IlqZNJWP2dvc
	7JI6Px8s85nY3K0VP8EhBDRczkdSjrnY8t78bYeGYCGnK0thiViESy55hnCVgv8sJWDwgCJmTOc
	sD25IQ44A3svSBIYR7PnVeHX6E3c3S6T4MbHdllSXIPW55kSKH4mSvGXTr81OyN0f+WhJswF8sH
	Q2pFqZMJgvTKYqcqittrL8U/Wxtmp1HgQm8h6DA4oRAYJHQzbZq9V7aswWJAZm89cx+AGvYfho+
	2TYJH6NpGh4ftCdyd4r+CIxwJ6HMzBA/InjnYMdEBajJJYjS0FBCIB2O8NTiScMAI+HMjGX2dMt
	SRP6RSgqAthMnKUtwqg4gcNJCUM/YixJK9k08KUCWVx047ojVixN3PppaXyU1i/QCDS59F5zDUc
	spAAg==
X-Received: by 2002:a05:6000:1845:b0:43d:50c:6f33 with SMTP id ffacd0b85a97d-45e5c58d231mr4211029f8f.26.1778837735251;
        Fri, 15 May 2026 02:35:35 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17d3:2101:5ed:447d:e5d1:52d7? ([2a0a:ef40:17d3:2101:5ed:447d:e5d1:52d7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe1a41sm14088288f8f.31.2026.05.15.02.35.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 02:35:33 -0700 (PDT)
Message-ID: <e32f559e-0b28-40be-875b-956de2bb2fca@gmail.com>
Date: Fri, 15 May 2026 10:35:32 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3] generate-configlist: collapse depfile for older Ninja
To: Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
 Patrick Steinhardt <ps@pks.im>
References: <20260422-toon-fix-almalinux8-v2-1-45d8471ed0e9@iotcl.com>
 <20260515-toon-fix-almalinux8-v3-1-b545a0647f0f@iotcl.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20260515-toon-fix-almalinux8-v3-1-b545a0647f0f@iotcl.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Toon

Thanks for re-rolling, this version looks good to me

Phillip

On 15/05/2026 09:42, Toon Claes wrote:
> The tools/generate-configlist.sh script generates two files:
>    * config-list.h
>    * config-list.h.d
> 
> The former is included by the source code and the latter defines on
> which files the former depends.
> 
> The contents of `config-list.h.d` consists of two sections:
> 
>      config-list.h: Documentation/config.adoc
>      config-list.h: Documentation/git-config.adoc
>      config-list.h: Documentation/config/add.adoc
>      config-list.h: Documentation/config/advice.adoc
>      config-list.h: Documentation/config/alias.adoc
>      config-list.h: Documentation/config/am.adoc
>      config-list.h: Documentation/config/apply.adoc
>      ...
> 
> This first section actually defines on which individual files
> `config-list.h` depends and thus needs to be rebuild if one of those
> changes.
> 
> And the second section contains content like:
> 
>      Documentation/config.adoc:
>      Documentation/git-config.adoc:
>      Documentation/config/add.adoc:
>      Documentation/config/advice.adoc:
>      Documentation/config/alias.adoc:
>      Documentation/config/am.adoc:
>      Documentation/config/apply.adoc:
>      ...
> 
> These rules exist to ensure Make won't fail with the following error if
> one of the .adoc files is renamed or removed:
> 
>     make: *** No rule to make target 'Documentation/config.adoc', needed by 'config-list.h'.
> 
> With the no-op targets defined in `config-list.h.d`, Make knows there's
> no work to be done to generate these files, so it doesn't error out if
> it doesn't exist.
> 
> For the Makefile build system this works great. And since
> ebeea3c471 (build: regenerate config-list.h when Documentation changes,
> 2026-02-24) this script is also called from the Meson build system.
> Nevertheless, on AlmaLinux 8 the following build failure is seen:
> 
>      ninja: error: dependency cycle: config-list.h -> config-list.h
> 
> This version of this distro uses Ninja 1.8.2 and it seems to have some
> issues with the format of the `config-list.h.d` file.
> 
> Ninja versions before 1.10.0 do not reset the depfile parser state on
> newlines. This causes issues when the depfile has one dependency per
> line, like we have in `config-list.h.d`:
> 
>      config-list.h: Documentation/config.adoc
>      config-list.h: Documentation/config/add.adoc
> 
> The parser only recognizes the first "config-list.h:" as a target. On
> subsequent lines it is still in dependency-parsing mode, so the repeated
> output name is recorded as an input. This causes the error mentioned
> above.
> 
> The bug in Ninja is fixed in 1.10, with commit
> ninja-build/ninja@1daa7470ab7e (depfile_parser: remove restriction on
> multiple outputs, 2019-11-20).
> 
> To be compatible with older versions of Ninja, collapse the dependencies
> for `config-list.h` into a single line like:
> 
>      config-list.h: Documentation/config.adoc Documentation/config/add.adoc ...
> 
> This works around the bug in older versions of Ninja, and is fully
> compatible Make and with more recent versions of Ninja. And while the
> no-op targets are not needed for Ninja, they also don't do any harm.
> 
> Helped-by: Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Toon Claes <toon@iotcl.com>
> ---
> At GitLab we build images for various distros, including AlmaLinux 8.
> On this distro we got this error while compiling Git.
> 
>      ninja: error: dependency cycle: config-list.h -> config-list.h
> 
> It seems this is caused by a bug in older versions of Ninja. There are
> more details in the commit message, but here are a few simple steps to
> reproduce:
> 
> docker run --rm -it -v $(pwd):/git -w /git almalinux:8 bash
>      dnf -yq install epel-release
>      dnf -yq install shadow-utils sudo make pkg-config gcc findutils \
>          diffutils perl python3 gawk gettext zlib-devel expat-devel \
>          openssl-devel curl-devel pcre2-devel cargo
>      pip3 install --prefix=/usr meson ninja==1.8.2
>      meson setup build --warnlevel 2 --werror
>      ninja -C build config-list.h
>      ninja -C build config-list.h   # fails with dependency cycle
> ---
> Changes in v3:
> - Stop using \n in sed(1) replacement strings because it is not
>    portable.
> - Link to v2: https://patch.msgid.link/20260422-toon-fix-almalinux8-v2-1-45d8471ed0e9@iotcl.com
> 
> Changes in v2:
> - Simplify the changes *a lot* by doing the collapsing unconditionally.
> - Link to v1: https://patch.msgid.link/20260421-toon-fix-almalinux8-v1-1-aec1d54addde@iotcl.com
> ---
>   tools/generate-configlist.sh | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/generate-configlist.sh b/tools/generate-configlist.sh
> index e28054f9e0..d1d2ba4bb7 100755
> --- a/tools/generate-configlist.sh
> +++ b/tools/generate-configlist.sh
> @@ -42,9 +42,12 @@ if test -n "$DEPFILE"
>   then
>   	QUOTED_OUTPUT="$(printf '%s\n' "$OUTPUT" | sed 's,[&/\],\\&,g')"
>   	{
> +		printf '%s' "$QUOTED_OUTPUT: "
>   		printf '%s\n' "$SOURCE_DIR"/Documentation/*config.adoc \
>   			"$SOURCE_DIR"/Documentation/config/*.adoc |
> -			sed -e 's/[# ]/\\&/g' -e "s/^/$QUOTED_OUTPUT: /"
> +			sed -e 's/[# ]/\\&/g' |
> +			tr '\n' ' '
> +		printf '\n'
>   		printf '%s:\n' "$SOURCE_DIR"/Documentation/*config.adoc \
>   			"$SOURCE_DIR"/Documentation/config/*.adoc |
>   			sed -e 's/[# ]/\\&/g'
> 
> ---
> base-commit: 59ff4886a579f4bc91e976fe18590b9ae02c7a08
> change-id: 20260421-toon-fix-almalinux8-102de9138294
> 
> 

