Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E951EE7C6
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 14:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773239561; cv=none; b=TqFIHULQFo4daMGj7wE9YhMnPB9Ju+fGQjZYcz8fGhdDZLApv1DsDug8UY97EQgdBSp3tg1wvPGJYSngLHFUxr2h37Y1IVFxUai280VzflwaZ9NF54Qj+5wBA9GjhvPO4E/cWoe25/NzPuvzBc1JAUgHwW625cQ2XZdAd/uitPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773239561; c=relaxed/simple;
	bh=OcLmlt5/xgmDuHip6d6zNX5p+QjLA6r1TfxaDrPUFyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fHyWqby9aYFIDYDx0GlPJxixSdHXTGavKDpDIY8oC1j82E4G8Csw1XI2ReVhJz2CTbWjpl/IoxoP183x/5C9NMILL0x2mCsiN6rn3U+o8yp7150AygAHuJS2k7eRkN4FVa1Z4SOjloKOqmLp/QWBt8s8r0EaL4b33CpxTckpYdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hyj/wG/H; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyj/wG/H"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6631e0edcf1so1111439a12.1
        for <git@vger.kernel.org>; Wed, 11 Mar 2026 07:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773239558; x=1773844358; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HY3sB24vOJeQ4nvlZi2qc/n3X2ThzMtFsKLrwoNkrP8=;
        b=hyj/wG/HnPOKDI8nLtUY8JOxDyBrvwW+roqppNaHvfjcMd3KdOIB4RDGkh9nXmjKN6
         DRH3J+tonZIVMEDb0rhbHql7JIw7LYb/ZKdUAcs/QgnNaube9Ok1ZptrviyzkLHW0W01
         YfqI48WdP7q+QT+d/uivv+GnhxAkUwOGataZub2JUJvNjptGWSPMK8v0GYj6uwAgetvY
         Jno7YBidUce6RMOXGTSJp7BuEgT/hfIOMILXKJnPLubgQWi6UUCKNtQv3gYCPU5mVk3v
         CDDDuysabpo2IfglcabEwN/QT+CYoYsWQWH73FUgGNSm/1jcxpgNiKtA6R+7ozypV1lR
         d/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773239558; x=1773844358;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HY3sB24vOJeQ4nvlZi2qc/n3X2ThzMtFsKLrwoNkrP8=;
        b=vL18asIbTXkd+I7l3XSrZ2LVEGAKtSS8hsKX5M/mrcYc2RvlBZtke1/41BZhZgrUmM
         qbKL7fvUJ/ADYzMUEU5qJ3XUAtD/zLTow2QWnmOgxs7W9m5s4vmT4ZkmlhjeiuQVeLRG
         kEZvSBz8Mlubk/uQK5Binj1KO5Ihmoy6vUnhFDGkgU6/hpwfyxZKf8sKi7zs6bs9YtQs
         DR8/q4nMdy3Bh6gKquJE0RBvt/OpoaCGKMJfZCQq2yLLpS2XuyfkVQ/mTpm4WozdG+48
         Cq+jQFMeUVx7wiLFePGiUbgCimvMvcVWmPsEcLze/ss3jtjTFOZcl6fPtON+PvWBtkz7
         Ee/A==
X-Forwarded-Encrypted: i=1; AJvYcCXgXtJJ25N3nmrZjvvAx4O31wv1ZqGjQ/4wXcuvGC+2MNgNassBBW87hyAIkU+ljZeY+sw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVsjG9Ao0jgeQq73lj1ALDgV3Lb+l46ECqy7eUbdIAAe1tUr5i
	48Te4Pn09ts1787l27w8WBOzBWhVRqUCKdAhKerakExUPZrOhG6vg/fr9SAzxw==
X-Gm-Gg: ATEYQzyoYuk4yRMI0MrtzW1jq9YgePkPFEWryN9+ENdskDNU3rT67Z9M1QBcQcJs9vo
	2Q2lo3vVZ/bjJYAlx01UdIlPU32568Nkp6SttxRt0Ekm/4vrvLYdB4NwhArQ94Hzf6szoHD+gXt
	42weSgBMvVxbujB86KxowRseOTHJCuVUbdQhBXHKAsVbMksf2NdFWlfo8Cc6TVembDOSD6NeHSy
	fSgMdsfSJcbvmeRzRT+stGydzV9jz06wOccI12nckT2jMOeWwyztK+TjtSn9/45g8QI709S4wD7
	8W9nGAu7ltaStp1sNSwjUPxrir+xS+eayQLIRYkVXskcejKZ8TPWmocPTcFxO6O/m2C6dYCIfcE
	NHMZ98mD2lpv3WCrNfb8ZDy+Su19sWgdicX6C01KY05uHHyjlwbDlLhE8ITBMZWSnjYoidaBd4D
	yFIG7f9MCijLVNOu33k22qY5j82RnJ6sWZuQgMcSrxrDryDtLQCFsUV3jYPgVjg/675jWXiPINW
	2mWQw==
X-Received: by 2002:a05:6402:3494:b0:65f:ade0:f8a5 with SMTP id 4fb4d7f45d1cf-66319ee1e39mr1496503a12.24.1773239557661;
        Wed, 11 Mar 2026 07:32:37 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6631503c5b2sm607638a12.16.2026.03.11.07.32.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 07:32:37 -0700 (PDT)
Message-ID: <040296b2-9a69-4603-9a2a-2001c98220b7@gmail.com>
Date: Wed, 11 Mar 2026 14:32:36 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 8/8] meson: precompile "git-compat-util.h"
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <20260310-b4-pks-build-infra-improvements-v1-0-ec75d0710d6a@pks.im>
 <20260310-b4-pks-build-infra-improvements-v1-8-ec75d0710d6a@pks.im>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20260310-b4-pks-build-infra-improvements-v1-8-ec75d0710d6a@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/03/2026 17:52, Patrick Steinhardt wrote:
> Every compilation unit in Git is expected to include "git-compat-util.h"
> first, either directly or indirectly via "builtin.h". This header papers
> over differences between platforms so that we can expect the typical
> POSIX functions to exist. Furthermore, it provides functionality that we
> end up using everywhere.
> 
> This header is thus quite heavy as a consequence. Preprocessing it as a
> standalone unit via `clang -E git-compat-util.h` yields over 23,000
> lines of code overall. Naturally, it takes quite some time to compile
> all of this.
> 
> Luckily, this is exactly the kind of use case that precompiled headers
> aim to solve: instead of recompiling it every single time, we compile it
> once and then link the result into the executable. If include guards are
> set up properly it means that the file won't need to be reprocessed.
> 
> Set up such a precompiled header for "git-compat-util.h" and wire it up
> via Meson. This leads to a significant speedup when performing full
> builds:
> 
>    Benchmark 1: ninja (rev = HEAD~)
>    Time (mean ± σ):     14.467 s ±  0.126 s    [User: 248.133 s, System: 31.298 s]
>    Range (min … max):   14.195 s … 14.633 s    10 runs
> 
>    Benchmark 2: ninja (rev = HEAD)
>      Time (mean ± σ):     10.307 s ±  0.111 s    [User: 173.290 s, System: 23.998 s]
>      Range (min … max):   10.030 s … 10.433 s    10 runs
> 
>    Summary
>      ninja (rev = HEAD) ran
>        1.40 ± 0.02 times faster than ninja (rev = HEAD~)

This is a nice speedup for a full build. I'm not sure about dumping the 
precompiled header in tools/ though, it seems like an odd location for a 
header file. It is a requirement of meson that the source for the 
precompiled header lives in a separate directory to the rest of the 
sources but it might be better to adopt the suggestion in the 
documentation of a "pch" (or maybe "precompiled"?) directory rather than 
mixing it in with our build scripts.

Thanks

Phillip


> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>   meson.build         | 2 ++
>   tools/precompiled.h | 1 +
>   2 files changed, 3 insertions(+)
> 
> diff --git a/meson.build b/meson.build
> index cd00be1c23..4b3fd47061 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1760,6 +1760,7 @@ libgit = declare_dependency(
>         c_args: libgit_c_args + [
>           '-DGIT_VERSION_H="' + version_def_h.full_path() + '"',
>         ],
> +      c_pch: [ 'tools/precompiled.h' ],
>         dependencies: libgit_dependencies,
>         include_directories: libgit_include_directories,
>       ),
> @@ -1820,6 +1821,7 @@ test_dependencies = [ ]
>   
>   git_builtin = executable('git',
>     sources: builtin_sources + 'git.c',
> +  c_pch: [ 'tools/precompiled.h' ],
>     dependencies: [libgit_commonmain],
>     install: true,
>     install_dir: git_exec_path,
> diff --git a/tools/precompiled.h b/tools/precompiled.h
> new file mode 100644
> index 0000000000..b2bec0d2b4
> --- /dev/null
> +++ b/tools/precompiled.h
> @@ -0,0 +1 @@
> +#include "git-compat-util.h"
> 

