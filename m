Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214A115098E
	for <git@vger.kernel.org>; Fri, 12 Jul 2024 13:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720792304; cv=none; b=oTHABxNV18VGEVXr7d8rWet6IA60yavQ5WHx/V+0UKnsYCgXj9VpFbcgF4Sa0HLtMvKZj+u+Id4tmGPC44Rx2gb41K+8ZE45uEAnuCEafW0dktS2OVHkJJRmj4chopDS3PMY+HawnJ9UH6vWbLVTarNPD1wcdwl3umrLj+Ye8d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720792304; c=relaxed/simple;
	bh=HPJLoJV+J6Jdl+RC+6zRxOT00qGzv8dSzJW9PhmO3t8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qeJd5cAaKaV8hKdq6sS/bpRRCtHpQEuHLHn7BBscPAvvIr++nwbb9pmaW9s6EsrnpbChI7VYElKwdGL/NH7VMPEbtDbRD1l0lrkM0WFpP9YnwMEg3LbCGryMqGG58Ng1DK40qnqL/k3QYYx1JCNk28b72sEYDEO/8UzQmRL3qy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eSwIrE8Y; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSwIrE8Y"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ee9505cd37so18655911fa.2
        for <git@vger.kernel.org>; Fri, 12 Jul 2024 06:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720792301; x=1721397101; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bz2NUeM7KwcmMgAqkqfXbBRDJhO4rNEo2sOAF/DuyCU=;
        b=eSwIrE8YMmAsYj+XYb9Z+jLg3jnjy2EutyQgkbiPjVKw0wFCp0JPCb/8nnXBna6FTe
         dR4HQmMGYlIB5jbQ3F1oJXhvutJuNI046ZeigZe2i3mtuAx6IgyddVD1JXVpln8M9GQk
         b2RSqYU3Zlw/+e3RExIUhFUJkGZGdSOF7B2YmmRdx4g1ePvHm32+UzpGrUvpg0ZkDfvM
         7q8RqYt1ugCkEMiDhuWRHyt4gIYKQnM8dKYjtHl48V3xvamIgmalz1CBtdxY0iFv2DuF
         +icNorzw2qzq55/7OGIzGqUykvHzSS//gtABqOe1H9xzK0SmiRboGnCHl8+Ri3kdA2CY
         0y3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720792301; x=1721397101;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bz2NUeM7KwcmMgAqkqfXbBRDJhO4rNEo2sOAF/DuyCU=;
        b=kM5aPeJW4WQU5CUynq8wDSHKJENkv2FTOIMBsmH0gxmTHZLXHgAxCeIj07ORcZ9eiu
         GKWTWZIVvhSXElyvN3dPw+A/banQC1D/XqbAsgKLhAwWf7fjhiw46OMC5z7BWjZefP3i
         WX99GqK/zFCWFSi/dC9OiXLBJFX4+61K9V4fRXJY9sf8CVWQWtty/HLqkoZrOk8p6Vd4
         c0pSzkqT4OWIB6KKN05y7ib/Gyfno1m7ZQVgjc3BDxtrWiCmXC1WSZ2FCnZmpcXkySOJ
         79rF1nK/nsk7W94rb/VDrU6M2LOuc1xOHG53OVXIBHCas2E/aHfqsLBxhv9mK1+SLe2H
         xzeg==
X-Forwarded-Encrypted: i=1; AJvYcCUuDKT2NDZiR3c/2yXkrg4ZN0dmM74qU3edVXi6+9LfKbJdv06x7Oc2Ra245A5P6falK3xvb5P4g+vs+bERRQt7sVAe
X-Gm-Message-State: AOJu0Yzzryjy0uLzZTpu1Zmjj57cEFZ9+Su1pZ9YgbbsODdp0bCponCD
	kF9TrHrM+QktNK8SVZHPItEn25T02qT46UtXVvvJtcBVFWF1xDIr
X-Google-Smtp-Source: AGHT+IHa59kLnnbi4hSPVPYh55ePK1kG1J1r+Y8wE3Oy7KxmCFjSibADfAN5gVxIvdlmETHNd6SXww==
X-Received: by 2002:a2e:780a:0:b0:2ee:daf3:88c3 with SMTP id 38308e7fff4ca-2eedaf388f4mr1841291fa.41.1720792300794;
        Fri, 12 Jul 2024 06:51:40 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:600:8501:575d:f6b:be83:bc74? ([2a0a:ef40:600:8501:575d:f6b:be83:bc74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f2d7489sm24359775e9.44.2024.07.12.06.51.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jul 2024 06:51:40 -0700 (PDT)
Message-ID: <3b687707-7aa7-4f4f-8043-0e31fb0c09ce@gmail.com>
Date: Fri, 12 Jul 2024 14:51:37 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/7] var(win32): do report the GIT_SHELL_PATH that is
 actually used
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
 Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1760.git.1720443778074.gitgitgadget@gmail.com>
 <pull.1760.v2.git.1720739496.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.1760.v2.git.1720739496.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Johannes

On 12/07/2024 00:11, Johannes Schindelin via GitGitGadget wrote:
> Changes since v1:
> 
>   * This patch series now shares the logic that determines the path of the
>     Unix shell that Git uses between prepare_shell_cmd() and git var
>     GIT_SHELL_PATH.

This was a pleasant read, each step was well described and easy to 
follow. I've left a couple of comments but I think this is good as it is.

Thanks

Phillip

> Johannes Schindelin (7):
>    run-command: refactor getting the Unix shell path into its own
>      function
>    strvec: declare the `strvec_push_nodup()` function globally
>    win32: override `fspathcmp()` with a directory separator-aware version
>    mingw(is_msys2_sh): handle forward slashes in the `sh.exe` path, too
>    run-command(win32): resolve the path to the Unix shell early
>    run-command: declare the `git_shell_path()` function globally
>    var(win32): do report the GIT_SHELL_PATH that is actually used
> 
>   builtin/var.c             |  3 ++-
>   compat/mingw.c            |  2 +-
>   compat/win32/path-utils.c | 25 +++++++++++++++++++++++++
>   compat/win32/path-utils.h |  2 ++
>   dir.c                     |  2 +-
>   dir.h                     |  2 +-
>   git-compat-util.h         |  5 +++++
>   run-command.c             | 17 ++++++++++++-----
>   run-command.h             |  5 +++++
>   strvec.c                  |  2 +-
>   strvec.h                  |  3 +++
>   t/t0007-git-var.sh        |  2 +-
>   12 files changed, 59 insertions(+), 11 deletions(-)
> 
> 
> base-commit: 06e570c0dfb2a2deb64d217db78e2ec21672f558
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1760%2Fdscho%2Fgit-var-on-windows-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1760/dscho/git-var-on-windows-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/1760
> 
> Range-diff vs v1:
> 
>   -:  ----------- > 1:  e0970381042 run-command: refactor getting the Unix shell path into its own function
>   -:  ----------- > 2:  91ebccbc39f strvec: declare the `strvec_push_nodup()` function globally
>   -:  ----------- > 3:  a718183bb3b win32: override `fspathcmp()` with a directory separator-aware version
>   -:  ----------- > 4:  f04cfd91bd9 mingw(is_msys2_sh): handle forward slashes in the `sh.exe` path, too
>   -:  ----------- > 5:  707daf246bd run-command(win32): resolve the path to the Unix shell early
>   -:  ----------- > 6:  a74a7b4bb11 run-command: declare the `git_shell_path()` function globally
>   1:  ef62c3fc122 ! 7:  8bfd23cfa00 var(win32): do report the GIT_SHELL_PATH that is actually used
>       @@ Commit message
>            associated with the current directory.
>        
>            To that end, Git does not actually use the path `/bin/sh` that is
>       -    recorded e.g. in Unix shell scripts' hash-bang lines. Instead, as of
>       -    776297548e (Do not use SHELL_PATH from build system in prepare_shell_cmd
>       -    on Windows, 2012-04-17), it re-interprets `/bin/sh` as "look up `sh` on
>       -    the `PATH` and use the result instead".
>       +    recorded e.g. when `run_command()` is called with a Unix shell
>       +    command-line. Instead, as of 776297548e (Do not use SHELL_PATH from
>       +    build system in prepare_shell_cmd on Windows, 2012-04-17), it
>       +    re-interprets `/bin/sh` as "look up `sh` on the `PATH` and use the
>       +    result instead".
>       +
>       +    This is the logic users expect to be followed when running `git var
>       +    GIT_SHELL_PATH`.
>        
>            However, when 1e65721227 (var: add support for listing the shell,
>            2023-06-27) introduced support for `git var GIT_SHELL_PATH`, Windows was
>            not special-cased as above, which is why it outputs `/bin/sh` even
>            though that disagrees with what Git actually uses.
>        
>       -    Let's fix this, and also adjust the corresponding test case to verify
>       -    that it actually finds a working executable.
>       +    Let's fix this by using the exact same logic as `prepare_shell_cmd()`,
>       +    adjusting the Windows-specific `git var GIT_SHELL_PATH` test case to
>       +    verify that it actually finds a working executable.
>        
>            Reported-by: Phillip Wood <phillip.wood123@gmail.com>
>            Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>        
>         ## builtin/var.c ##
>       +@@
>       + #include "refs.h"
>       + #include "path.h"
>       + #include "strbuf.h"
>       ++#include "run-command.h"
>       +
>       + static const char var_usage[] = "git var (-l | <variable>)";
>       +
>        @@ builtin/var.c: static char *default_branch(int ident_flag UNUSED)
>         
>         static char *shell_path(int ident_flag UNUSED)
>         {
>       -+#ifdef WIN32
>       -+	char *p = locate_in_PATH("sh");
>       -+	convert_slashes(p);
>       -+	return p;
>       -+#else
>       - 	return xstrdup(SHELL_PATH);
>       -+#endif
>       +-	return xstrdup(SHELL_PATH);
>       ++	return git_shell_path();
>         }
>         
>         static char *git_attr_val_system(int ident_flag UNUSED)
> 
