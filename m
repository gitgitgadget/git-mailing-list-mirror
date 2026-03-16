Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2929E18AFE
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 10:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773658483; cv=none; b=Us2hgaWbYQAtBE/wkouV7VgZOV1m+gjPHNL1Qe109ksyhhAusBnDh90ZB9JSePKXlA+1ZpU5/+ERuh2PLKDi6y7jgGueM/RFmhmQJJnpjGTJ4VlSG9txpnLvvUBoxsGwc4PpiU9+JZOOvRkXmibRal0Vm0ibPWC/VfZ8XvYQbNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773658483; c=relaxed/simple;
	bh=E2pkc2qXl14uo1c/Z2LjhmECAtxLK69vN/nN/L+zRm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QaU4aI3vA5OpjdoPSm8/dzxNlQTarWyBN0Nqo0qvyCjg3ca9t5JBLjFI4UjiaCsNJbAfvD/0InwZqWA2QqezAbCY/1qlMWgKRKUSDVLdmurAy+kLMYvKmGm8X3fecO1fHYZwj2AMA1QIhlX2PbHdhBOEj5QTvAWniBPh0AdhAt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kt4uO5+c; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kt4uO5+c"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-439b94a19fdso4058765f8f.0
        for <git@vger.kernel.org>; Mon, 16 Mar 2026 03:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773658480; x=1774263280; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7joeUXEo0ZudSJ99K3I0n6waeJTPrXBIgl63hbda0hk=;
        b=Kt4uO5+cfcS+SxEZQ/equLYoW0Hd743joj5NIVX+qAhAxQin9PCuAJ3zPLUnwgT6iG
         ly+/VTdDAcb5CCPE4+mLTVb7HUooQZtvzz9b4LiNop0URggz7X2zmGDWK/caiKuEk+rp
         OYUz4WUN5yth8zIyAZSq1mnOGtxUvWJFcPHuo/qIb87j16TH2/1rL7VebBnsbRybBFF5
         Ezv1s1I0oNZ0tYDoECDH+q72yvbeD7bA4qkJpEraD9MpDDHK157UHktU/Y7CH8NmDHKF
         INDdzftsWe36mpEMVlMt0kdk7rT/4oM8JqIQc+1WGyPz1CybJRUlDR7ox94ogrMta02o
         cp4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773658480; x=1774263280;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7joeUXEo0ZudSJ99K3I0n6waeJTPrXBIgl63hbda0hk=;
        b=os1GLpiGlGfIbxIuz01+d/OhO8Pe1yxsFGiRTjA60XPppuvbTHS9PR9LehaeOLC/1y
         GLVQTF6x3pJp32tMSv+KvQVcyeyjQZRhq89GHkGr9CB1tLFmgUai7aOWJDZ9IRgMYkDo
         IIlzVYjjOb6qhsBsidDJ3QxdSZCIIsultsTgva1gZqFynBIA1udcVi/TZR9GWdCXs+VY
         cUza/gOg208JNN0tRg2vECBp/ANOrALHduj2eKtuIjoBCxubWAn/ovhsebHBKTi1tztm
         RHKUtoXClCfs2R+jHOQJQ6V39BWB+cY1YBQHKrC8wraj0fPAtwRXh79tzYqrXUrGxCOr
         fC2A==
X-Forwarded-Encrypted: i=1; AJvYcCV7rsUbDFVSstdn3SS1ITq9TT/dp7RQjiDc3IMgVeBqsPNkyE12WZ6v9So82MXeI/9YCrk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy10KnLE3p0fdnYPLQpWT+OLaeWDxZgb6HN1OnlZoMrsqXsckIS
	QyFqpEBZf0qO22UFnGR7jWrQPw5DSk/HXgBV+QYbVWC2G7e/ul5v8Y37
X-Gm-Gg: ATEYQzwM5CiqFVN+s8TnDyQhgM2gD5UtL9ZiIyr4dZwANIDRMJHH6fXk4ABIKZ0x2bx
	XQ3PS+wZdonUowsR6hFvaukKkdO5+qMiyk8nglGMt4DcLSaB/yXsS/rzpvurRpxj5H9Dvasj/FF
	om7RjQ9vQxOB2sIZDMGarpKkpjFYoPhpY09IxUHFYYqCmLGdJoWzBb2BHc0mw2aDsLa3dbclu6F
	VXeWVscXUZ5zzqFLZ8GN066IJzoUPagoXEwwMi24GCsvgm2Cr6yowuq+EiI2g2plHdTN6ya/0Rz
	iwQF5HTYhcqjM/hqW2RxxqFyOWrMp+qbxNIcMOGYF9EuQmjNJ/qrnUJYJonZSKj5c2Vm3YMWEYd
	gUMcuyl122d0Wq1RlKviJxO9h2sSDmrAetmuHNkb7cP/S0Ro67rolJshUmUwf/YJsJqS8SvEF2y
	6h/FIebCbrS03vv0xTo50wTKbDXaUsxpSFpvwnur5HkbbyRA2whz5eVtf6CVsq5t8AO1Mulf10M
	fv6Zui8pnSzSxGN
X-Received: by 2002:a05:600c:1f8d:b0:485:4278:24fb with SMTP id 5b1f17b1804b1-48556711dfcmr209920425e9.32.1773658480186;
        Mon, 16 Mar 2026 03:54:40 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b65fd3dsm396999445e9.10.2026.03.16.03.54.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 03:54:39 -0700 (PDT)
Message-ID: <7ff11efb-a44c-4c78-b8b2-d38f8a6beb9f@gmail.com>
Date: Mon, 16 Mar 2026 10:54:37 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/8] Some build system improvements
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
 Junio C Hamano <gitster@pobox.com>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20260310-b4-pks-build-infra-improvements-v1-0-ec75d0710d6a@pks.im>
 <20260316-b4-pks-build-infra-improvements-v2-0-4b2c2c0c0425@pks.im>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20260316-b4-pks-build-infra-improvements-v2-0-4b2c2c0c0425@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16/03/2026 10:07, Patrick Steinhardt wrote:
> 
> Changes in v2:
>    - Turn array of precompiled headers into a simple string.
>    - Point out in the commit message that the precompiled header is
>      included implicitly.
>    - Link to v1: https://lore.kernel.org/r/20260310-b4-pks-build-infra-improvements-v1-0-ec75d0710d6a@pks.im

Thanks for expanding the commit message in patch 8, the range-diff looks 
good.

Phillip

> Thanks!
> 
> Patrick
> 
> [1]: https://lore.kernel.org/git/20250506-pks-contrib-spring-cleanup-v1-0-e6d5ddd79a72@pks.im/
> 
> ---
> Patrick Steinhardt (8):
>        Introduce new "tools/" directory
>        contrib: move "coccinelle/" directory into "tools/"
>        contrib: move "coverage-diff.sh" script into "tools/"
>        contrib: move "update-unicode.sh" script into "tools/"
>        builds: move build scripts into "tools/"
>        git-compat-util.h: move warning infra to prepare for PCHs
>        meson: compile compatibility sources separately
>        meson: precompile "git-compat-util.h"
> 
>   Makefile                                           | 76 ++++++++---------
>   ci/run-static-analysis.sh                          |  2 +-
>   config.mak.dev                                     |  2 +-
>   contrib/buildsystems/CMakeLists.txt                | 18 ++--
>   contrib/meson.build                                |  1 -
>   contrib/subtree/meson.build                        |  2 +-
>   git-compat-util.h                                  |  8 +-
>   meson.build                                        | 96 +++++++++++++---------
>   tools/README.md                                    |  7 ++
>   check-builtins.sh => tools/check-builtins.sh       |  0
>   {contrib => tools}/coccinelle/.gitignore           |  0
>   {contrib => tools}/coccinelle/README               |  2 +-
>   {contrib => tools}/coccinelle/array.cocci          |  0
>   {contrib => tools}/coccinelle/commit.cocci         |  0
>   .../coccinelle/config_fn_ctx.pending.cocci         |  0
>   {contrib => tools}/coccinelle/equals-null.cocci    |  0
>   {contrib => tools}/coccinelle/flex_alloc.cocci     |  0
>   {contrib => tools}/coccinelle/free.cocci           |  0
>   .../coccinelle/git_config_number.cocci             |  0
>   {contrib => tools}/coccinelle/hashmap.cocci        |  0
>   .../coccinelle/index-compatibility.cocci           |  0
>   {contrib => tools}/coccinelle/meson.build          |  0
>   {contrib => tools}/coccinelle/object_id.cocci      |  0
>   {contrib => tools}/coccinelle/preincr.cocci        |  0
>   {contrib => tools}/coccinelle/qsort.cocci          |  0
>   {contrib => tools}/coccinelle/refs.cocci           |  0
>   {contrib => tools}/coccinelle/spatchcache          |  6 +-
>   {contrib => tools}/coccinelle/strbuf.cocci         |  0
>   {contrib => tools}/coccinelle/swap.cocci           |  0
>   {contrib => tools}/coccinelle/tests/free.c         |  0
>   {contrib => tools}/coccinelle/tests/free.res       |  0
>   {contrib => tools}/coccinelle/the_repository.cocci |  0
>   {contrib => tools}/coccinelle/xcalloc.cocci        |  0
>   {contrib => tools}/coccinelle/xopen.cocci          |  0
>   .../coccinelle/xstrdup_or_null.cocci               |  0
>   {contrib => tools}/coccinelle/xstrncmpz.cocci      |  0
>   {contrib => tools}/coverage-diff.sh                |  0
>   detect-compiler => tools/detect-compiler           |  0
>   generate-cmdlist.sh => tools/generate-cmdlist.sh   |  0
>   .../generate-configlist.sh                         |  0
>   generate-hooklist.sh => tools/generate-hooklist.sh |  0
>   generate-perl.sh => tools/generate-perl.sh         |  0
>   generate-python.sh => tools/generate-python.sh     |  0
>   generate-script.sh => tools/generate-script.sh     |  0
>   tools/meson.build                                  |  1 +
>   tools/precompiled.h                                |  1 +
>   {contrib => tools}/update-unicode/.gitignore       |  0
>   {contrib => tools}/update-unicode/README           |  0
>   .../update-unicode/update_unicode.sh               |  0
>   49 files changed, 123 insertions(+), 99 deletions(-)
> 
> Range-diff versus v1:
> 
> 1:  224e28be31 = 1:  9d09d2c39a Introduce new "tools/" directory
> 2:  b217df51e5 = 2:  1b96bfe0f4 contrib: move "coccinelle/" directory into "tools/"
> 3:  e371b6c221 = 3:  ed6e90bd36 contrib: move "coverage-diff.sh" script into "tools/"
> 4:  3efeda9fa0 = 4:  48d8275ed1 contrib: move "update-unicode.sh" script into "tools/"
> 5:  ee074c1396 = 5:  daafeb3462 builds: move build scripts into "tools/"
> 6:  d30d4a3119 = 6:  947fc0f7b4 git-compat-util.h: move warning infra to prepare for PCHs
> 7:  ca118197a9 = 7:  6a2fb99aae meson: compile compatibility sources separately
> 8:  a865a8650b ! 8:  857b478896 meson: precompile "git-compat-util.h"
>      @@ Commit message
>           set up properly it means that the file won't need to be reprocessed.
>       
>           Set up such a precompiled header for "git-compat-util.h" and wire it up
>      -    via Meson. This leads to a significant speedup when performing full
>      -    builds:
>      +    via Meson. This causes Meson to implicitly include the precompiled
>      +    header in all compilation units. With GCC and Clang for example this is
>      +    done via the "-include" statement [1].
>      +
>      +    This leads to a significant speedup when performing full builds:
>       
>             Benchmark 1: ninja (rev = HEAD~)
>             Time (mean ± σ):     14.467 s ±  0.126 s    [User: 248.133 s, System: 31.298 s]
>      @@ Commit message
>               ninja (rev = HEAD) ran
>                 1.40 ± 0.02 times faster than ninja (rev = HEAD~)
>       
>      +    [1]: https://gcc.gnu.org/onlinedocs/gcc/Precompiled-Headers.html
>      +
>           Signed-off-by: Patrick Steinhardt <ps@pks.im>
>       
>        ## meson.build ##
>      @@ meson.build: libgit = declare_dependency(
>              c_args: libgit_c_args + [
>                '-DGIT_VERSION_H="' + version_def_h.full_path() + '"',
>              ],
>      -+      c_pch: [ 'tools/precompiled.h' ],
>      ++      c_pch: 'tools/precompiled.h',
>              dependencies: libgit_dependencies,
>              include_directories: libgit_include_directories,
>            ),
>      @@ meson.build: test_dependencies = [ ]
>        
>        git_builtin = executable('git',
>          sources: builtin_sources + 'git.c',
>      -+  c_pch: [ 'tools/precompiled.h' ],
>      ++  c_pch: 'tools/precompiled.h',
>          dependencies: [libgit_commonmain],
>          install: true,
>          install_dir: git_exec_path,
> 
> ---
> base-commit: af2c8a61818d773325ef2324dd135786a03ebca0
> change-id: 20260304-b4-pks-build-infra-improvements-cc4012c5364e
> 
> 

