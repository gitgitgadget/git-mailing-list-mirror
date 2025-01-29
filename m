Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBDEB641
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 20:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738181731; cv=none; b=E14xnu6JlOJVEet1As2+zlo8OpnFGhC26RS9LEp1chAbm3N+X/a5IQhiJoFjKB2+M805ISnwUEVYfQ3jS1Cr8JnpmCkCTa4kDz5iqFQ1hIAeq/u7pRK773w5SQZNcQ9GaE+8gpeaqVknmd47AfehCJ3zxCFaC4pZ3TXYuvXOhR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738181731; c=relaxed/simple;
	bh=HMtnay631fe+GqC/lwV3wBf39ROkz9yca29lxTVXONw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EjACwyAjTfuvZx85kxdPO96Ta0DxVwHSm2c7Kn1ijlFyl/wFe51fgXqY/bBAp2VxLzCBzkwwx/PwKmCqkIQoczFLZSAD43ub8M1BoC8nT9X0UDyzpp96hFkizv+xk/u0c2nZbRtU8NAMhdSiOcvYzkwUghdH8wt3EOe9ZxWTGVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cDCpGq74; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDCpGq74"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-71e173ed85bso33967a34.3
        for <git@vger.kernel.org>; Wed, 29 Jan 2025 12:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738181729; x=1738786529; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eTpHGafIUv6Ygn+Sihvkdic2z/dx5rJI5u2hxZbqmKQ=;
        b=cDCpGq74PYBvNI6Fajtp3lIPYG5ku3/IMZ4kXZ8jsUNqWw/lKjJR/1sm6tbPL4MngU
         qP8P+17+64wYvKIuB5mAzVKscwwb5xAc8dQBYELDkaUu7IfJOyG2YGJVfqzE31dvjuoq
         o3Pm4nVKzZCMsHRD1ouI8RNtkEYlsTulwjQtJTVtVMRDKG+XqkdWA5NMTb6wcixMcsim
         QgVLV7vUUDxHDgE/eBpBrxG4/+/ivlumX75/tpwc9lFKggK1xhGay3OxN2GljlPAxN+0
         5l5FIRT6TJ5m6D5cl2lPwh0CHB71NcWdodGEihKDmrPcxNVhc478B7ixY/Nzx5eYh1Qj
         VXgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738181729; x=1738786529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eTpHGafIUv6Ygn+Sihvkdic2z/dx5rJI5u2hxZbqmKQ=;
        b=R7fUaiQW6lgnVFgRQ2ZC+t5iCmzMjioY5Mxvt32MSZRNwCtASa/x7WH74MeQGiqWN2
         uCpVBxy0YUlMeF9cyZGndeQhRzZQJVfJlrpiIVuvlRKdTtYsRC48Ai3bmqN2U5iqWQBe
         /vSPblKiUAd409OkF+LHrBvRTiWteme6k6/MMsEsggAGJh91Z5yYFfjNR6BgUZpk/eTr
         meh5vTc05Na452b/VG4UQFugri75hZGXgNfTAlav3vNtg4ipWORnEs2l5vnD7G7ce8FG
         RPLAjF+/S3Fq9XPY7IAaudrEmGxcZ5YgYp3oq1V6cAecwwgq9GNWTin6pDNVUtHRyUv5
         /u7Q==
X-Gm-Message-State: AOJu0YyHrzDNP/dbgJygyUFEDzu5FKN2qJjV/+iMtCCwZZ8jsLt733Ek
	JC8R9sX/q8USI31XlDa6dbV+KNwY7z1jvqlAIDQ26J/487mAI0pAbekyiQ==
X-Gm-Gg: ASbGncum/n487uBnsZKsSVuXkyI4schp2+EEE9PtKRqMnLaDo1ztb/QKNjzbHiHulDX
	SVXFpkJWNNam4n9rYodHj3uysw43GV+bPtOr+lLG7ICV95IC4G9Fr30ybPMFkUY7M8l2bdYilNp
	ZegL/cOEhB5ZgXikxtQY/yikGnSIvJsDyoklJ0g9kTOVa4ExAnSDz3mcaBp0uiamP7BgfanqAsj
	AWJARNWch60esMkIH16p36JKXS2DvqbgtFlyLGN7pUWDJpRtLbK+MRzr4ROV6BOdijxV/G51c7X
	PL8P9JN+
X-Google-Smtp-Source: AGHT+IFmTZ9d58aIv+QckUyICGe5zfBwAsnvIRYksjVq6EvaJIOufKZkzSMoQYiIImFq7jGVW2dwsQ==
X-Received: by 2002:a05:6870:638d:b0:29e:6bcd:3ba7 with SMTP id 586e51a60fabf-2b32f27c5dfmr2480040fac.28.1738181728977;
        Wed, 29 Jan 2025 12:15:28 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b28f16c1dasm4550060fac.20.2025.01.29.12.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 12:15:28 -0800 (PST)
Date: Wed, 29 Jan 2025 14:12:35 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/11] meson: fix exec path with enabled runtime prefix
Message-ID: <7rnnfxsi4taxtyqek5udyplp767w6jdbw3zshvbbsbc5qxmjs6@ftjofkjsnzyb>
References: <20250129-b4-pks-meson-improvements-v1-0-ab709f0be12c@pks.im>
 <20250129-b4-pks-meson-improvements-v1-1-ab709f0be12c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129-b4-pks-meson-improvements-v1-1-ab709f0be12c@pks.im>

On 25/01/29 08:11AM, Patrick Steinhardt wrote:
> When the runtime prefix option is enabled, Git is built such that it
> knows to locate its binaries relative to the directory a binary is being
> executed from. This requires us to figure out relative paths, which is
> handled in `system_prefix()` by trying to strip a couple of well-known
> paths.

Ok if I understand this correctly, when the runtime prefix option is
enabled, the prefix that gets setup by `system_prefix()` is expected to
be relative from the directory the binary is being executed at.

> One of these paths, GIT_EXEC_PATH, is expected to be absolute when
> runtime prefixes are enabled, but relative otherwise. And while our
> Makefile gets this correcty, in Meson we always wire up the absolute

s/correcty/correctly/

> path, which may result in us not being able to find binaries.

So the problem is that since GIT_EXEC_PATH is always defined as
absolute, when the runtime prefix option is enabled, the relative prefix
is not able to be correctly set and thus always uses the
`FALLBACK_RUNTIME_PREFIX`.

> Fix this by conditionally injecting the paths depending on whether or
> not the `runtime_prefix` option is enabled.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  meson.build | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/meson.build b/meson.build
> index c54ccd2162..fd83df8c42 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -675,7 +675,6 @@ libgit_c_args = [
>    '-DETC_GITATTRIBUTES="' + get_option('gitattributes') + '"',
>    '-DETC_GITCONFIG="' + get_option('gitconfig') + '"',
>    '-DFALLBACK_RUNTIME_PREFIX="' + get_option('prefix') + '"',
> -  '-DGIT_EXEC_PATH="' + get_option('prefix') / get_option('libexecdir') / 'git-core"',
>    '-DGIT_HOST_CPU="' + host_machine.cpu_family() + '"',
>    '-DGIT_HTML_PATH="' + get_option('datadir') / 'doc/git-doc"',
>    '-DGIT_INFO_PATH="' + get_option('infodir') + '"',
> @@ -1437,6 +1436,7 @@ endif
>  if get_option('runtime_prefix')
>    libgit_c_args += '-DRUNTIME_PREFIX'
>    build_options_config.set('RUNTIME_PREFIX', 'true')
> +  git_exec_path = get_option('libexecdir') / 'git-core'
>  
>    if compiler.has_header('mach-o/dyld.h')
>      libgit_c_args += '-DHAVE_NS_GET_EXECUTABLE_PATH'
> @@ -1473,7 +1473,9 @@ if get_option('runtime_prefix')
>    endif
>  else
>    build_options_config.set('RUNTIME_PREFIX', 'false')
> +  git_exec_path = get_option('prefix') / get_option('libexecdir') / 'git-core'
>  endif
> +libgit_c_args += '-DGIT_EXEC_PATH="' + git_exec_path + '"'

Ok, so now we conditionally set `GIT_EXEC_PATH` depending on whether the
runtime prefix option is enabled. Makes sense

>  
>  git_version_file = custom_target(
>    command: [
> 
> -- 
> 2.48.1.362.g079036d154.dirty
> 
> 
