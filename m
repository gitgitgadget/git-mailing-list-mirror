Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEDD36C9FC
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 14:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773239555; cv=none; b=h6jW966QFKsyYSgF+TNJt3zCb9nEG/hYVXKH9I+D1jPHuoznXYq+Ca7ddxtrSkTapK5xy2QJpuzhNVRKWl0vOU1f3piATQ6y3z3JHviz/MW2LnapeT9xZp2v0peLmyq/nBP4UIg4758zn9aDxxKeqpEVEC9FcrQmbYajwRKbPmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773239555; c=relaxed/simple;
	bh=gf5jicafZFOHMX3xPeAYE1ZFdE+3V/d45NGZJa0BUOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UgstpXek6SJnY+et8AyhXakh60HHbJ4l1XGK5wxtG4MtQeWAzwo6iT4KzQYU9yw028I/SAOr7i1tKrN6fcrvGaoubtuvNcCxCicVg+3DQeUnm194ReN+W1CQIivUabolxkAYOSC6yiy+9IyKZ+DiK1pF20FNW7lzpR79ODoxJiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jo1RZJnF; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jo1RZJnF"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6630858b4ceso1649470a12.3
        for <git@vger.kernel.org>; Wed, 11 Mar 2026 07:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773239552; x=1773844352; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1OPLYjjBJreFOAxI9JQLnLdycPkIVrbC53ziF7OY8MU=;
        b=jo1RZJnF6L1NODJmkX2r6jifgTwG9BPuK2ha1Ztg7r74Eqf3wTEXXYkWZ8u40vdM1b
         NuFVDhew3M2RGAs8j6BMziOFHuUOV3/h72L38zLIsyI9iuoPMEAEv0jRhEh39j7gCz4B
         oHIBlEpmS//FQtHj+RRVLYOxcQD+zlp4/klokC4IEJi9GsdVTRomZAJagNtpaRb3Io7L
         TLIOLzD1jaAJvCKyn4zaOv1qkQiMCRSh4Om5YmFBP+HQVQwgWVf6Be+o87FDj8y3cbyT
         wqkgQUQMciIWLL1ucDeJzVYmd4od0dq7F4kCA4gyCJ4SQzWR7d7yaJ8goTxrbtv8k69z
         IkKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773239552; x=1773844352;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1OPLYjjBJreFOAxI9JQLnLdycPkIVrbC53ziF7OY8MU=;
        b=GrBhCzJoRLwqW73FQnAiRY+w8CWJ9F9nzSQgWtd0h9hQSgtngSVQ7T1POAl356hgQ/
         w77e2AkGo5p3Id3laHD+kYPEcNrJMsCBCQzdmqvbJoJwm+da5X9DEoCnlldCRiy615z9
         MxG+ag1FJxw+QpxILR64mWTQuseKwa39VXoy8Hc3wWLO5RLn6Z0d0zr4RQCvkPb8gzdp
         5JjJYniYpEohl3Wp3raPmJTRAzLDIVC/5qNvF59t40w3Dv2ag1ma5focbpvt9sjZ1DEH
         LvX6inFjZkTS2iwbAVLyPQTj+SkI4j690SGCk1b4in3MVhQJffbrzMKqVPj8+SpAR5We
         u7EA==
X-Forwarded-Encrypted: i=1; AJvYcCXgcxJZ1TJT8XBR/MJMhgA37erSOCAJT0dgKH1PT5hV5SAGUiwzRYNh6QGxgOLybdWgRtE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC9ordvq+BTXTKMXFG8pA9FdLI+s6g+qsU46ThbrC6ntE+kvr9
	gL83MfYYnSRdzdfnXMZyPil37Rp3il9HRKpWU3x6XC2sz2dbdOfGQxGW
X-Gm-Gg: ATEYQzyZf+QaRz9ISAYJh4BvNh3iNaf0ZScs3Iteep4frBBA3HVJTpXYfqM3gIWeCDb
	ryo9pRmyW341UieIjaLkV5Z4QNPpDq+VQx5KzWYgDDCZUmP+dFVC23tS7V88l3zk/uhjQSG9L8l
	NgY5c05lmQQ0BTbK9zZINAYr+Fqq10dDHtzvQaKD4nxQdTiwAIuFKC6vVL52kjfnRU2+IG5RIry
	heNO/RR/uLOUl7RAv7auHFYCCa5Hl/7zzjKYcB/cSZOMfQZaKEJ0a2GO+YSPOe0yv1DNbelmPIh
	vBCPt2v87vWfPwZKLQV6Ud7pzQq7E3axXJh7lqXZeW3tkxRIF45RhvjfwMQUwRmsVx3KLah89DQ
	N5pCODRAQX2/IEmOCJcXDtafTso7G+186VVtDrkmZd6rIMpiKpCnVPSXKdu3iEysS9bwGh+wMG6
	jZomcrEkPxyn38c8ZBbIvO2fX1PQyoX3lZZ5oVtNkjGIh3RGKVN7Sy/w1Tj5riEnJzTvR7vIhiK
	H9RAQ==
X-Received: by 2002:a05:6402:5206:b0:65c:cf5:193b with SMTP id 4fb4d7f45d1cf-66319ddbffdmr1427189a12.24.1773239551548;
        Wed, 11 Mar 2026 07:32:31 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6631503c5b2sm607638a12.16.2026.03.11.07.32.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 07:32:31 -0700 (PDT)
Message-ID: <a5d1ea70-12dd-461d-b5c5-a1127e017d01@gmail.com>
Date: Wed, 11 Mar 2026 14:32:30 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 7/8] meson: compile compatibility sources separately
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <20260310-b4-pks-build-infra-improvements-v1-0-ec75d0710d6a@pks.im>
 <20260310-b4-pks-build-infra-improvements-v1-7-ec75d0710d6a@pks.im>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20260310-b4-pks-build-infra-improvements-v1-7-ec75d0710d6a@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/03/2026 17:52, Patrick Steinhardt wrote:
> In the next commit we're about to introduce a precompiled header for
> "git-compat-util.h". The consequence of this change is that we'll
> implicitly include that header for every compilation unit that uses the
> precompiled headers.

Is that a meson thing? I know it defines precompiled headers on a 
per-target basis but does it somehow force each source file to include 
the precompiled header? Looking at the gcc documentation it seems like 
the precompiled header is only included where the original header is 
included. Splitting out the sources that do not depend on 
"git-compat-util.h" does mean we get some additional parallelism while 
we're precompiling the header which is probably a good thing.

Thanks

Phillip

> This is okay for our "normal" library sources and our builtins. But some
> of our compatibility sources do not include the header on purpose, and
> doing so would cause compileir errors.
> 
> Prepare for this change by splitting out compatibility sources into
> their static library. Like this we can selectively enable precompiled
> headers for the library sources.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>   meson.build | 79 +++++++++++++++++++++++++++++++++++--------------------------
>   1 file changed, 45 insertions(+), 34 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index 604fe89d2d..cd00be1c23 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -271,6 +271,13 @@ version_gen_environment.set('GIT_VERSION', get_option('version'))
>   
>   compiler = meson.get_compiler('c')
>   
> +compat_sources = [
> +  'compat/nonblock.c',
> +  'compat/obstack.c',
> +  'compat/open.c',
> +  'compat/terminal.c',
> +]
> +
>   libgit_sources = [
>     'abspath.c',
>     'add-interactive.c',
> @@ -304,10 +311,6 @@ libgit_sources = [
>     'commit.c',
>     'common-exit.c',
>     'common-init.c',
> -  'compat/nonblock.c',
> -  'compat/obstack.c',
> -  'compat/open.c',
> -  'compat/terminal.c',
>     'compiler-tricks/not-constant.c',
>     'config.c',
>     'connect.c',
> @@ -1163,7 +1166,7 @@ endif
>   
>   if not has_poll_h and not has_sys_poll_h
>     libgit_c_args += '-DNO_POLL'
> -  libgit_sources += 'compat/poll/poll.c'
> +  compat_sources += 'compat/poll/poll.c'
>     libgit_include_directories += 'compat/poll'
>   endif
>   
> @@ -1179,7 +1182,7 @@ endif
>   # implementation to threat things like drive prefixes specially.
>   if host_machine.system() == 'windows' or not compiler.has_header('libgen.h')
>     libgit_c_args += '-DNO_LIBGEN_H'
> -  libgit_sources += 'compat/basename.c'
> +  compat_sources += 'compat/basename.c'
>   endif
>   
>   if compiler.has_header('paths.h')
> @@ -1209,7 +1212,7 @@ if host_machine.system() != 'windows'
>     foreach symbol : ['inet_ntop', 'inet_pton', 'hstrerror']
>       if not compiler.has_function(symbol, dependencies: networking_dependencies)
>         libgit_c_args += '-DNO_' + symbol.to_upper()
> -      libgit_sources += 'compat/' + symbol + '.c'
> +      compat_sources += 'compat/' + symbol + '.c'
>       endif
>     endforeach
>   endif
> @@ -1251,18 +1254,18 @@ else
>   endif
>   
>   if host_machine.system() == 'darwin'
> -  libgit_sources += 'compat/precompose_utf8.c'
> +  compat_sources += 'compat/precompose_utf8.c'
>     libgit_c_args += '-DPRECOMPOSE_UNICODE'
>     libgit_c_args += '-DPROTECT_HFS_DEFAULT'
>   endif
>   
>   # Configure general compatibility wrappers.
>   if host_machine.system() == 'cygwin'
> -  libgit_sources += [
> +  compat_sources += [
>       'compat/win32/path-utils.c',
>     ]
>   elif host_machine.system() == 'windows'
> -  libgit_sources += [
> +  compat_sources += [
>       'compat/winansi.c',
>       'compat/win32/dirent.c',
>       'compat/win32/flush.c',
> @@ -1289,20 +1292,20 @@ elif host_machine.system() == 'windows'
>     libgit_include_directories += 'compat/win32'
>     if compiler.get_id() == 'msvc'
>       libgit_include_directories += 'compat/vcbuild/include'
> -    libgit_sources += 'compat/msvc.c'
> +    compat_sources += 'compat/msvc.c'
>     else
> -    libgit_sources += 'compat/mingw.c'
> +    compat_sources += 'compat/mingw.c'
>     endif
>   endif
>   
>   if host_machine.system() == 'linux'
> -  libgit_sources += 'compat/linux/procinfo.c'
> +  compat_sources += 'compat/linux/procinfo.c'
>   elif host_machine.system() == 'windows'
> -  libgit_sources += 'compat/win32/trace2_win32_process_info.c'
> +  compat_sources += 'compat/win32/trace2_win32_process_info.c'
>   elif host_machine.system() == 'darwin'
> -  libgit_sources += 'compat/darwin/procinfo.c'
> +  compat_sources += 'compat/darwin/procinfo.c'
>   else
> -  libgit_sources += 'compat/stub/procinfo.c'
> +  compat_sources += 'compat/stub/procinfo.c'
>   endif
>   
>   if host_machine.system() == 'cygwin' or host_machine.system() == 'windows'
> @@ -1315,13 +1318,13 @@ endif
>   
>   # Configure the simple-ipc subsystem required fro the fsmonitor.
>   if host_machine.system() == 'windows'
> -  libgit_sources += [
> +  compat_sources += [
>       'compat/simple-ipc/ipc-shared.c',
>       'compat/simple-ipc/ipc-win32.c',
>     ]
>     libgit_c_args += '-DSUPPORTS_SIMPLE_IPC'
>   else
> -  libgit_sources += [
> +  compat_sources += [
>       'compat/simple-ipc/ipc-shared.c',
>       'compat/simple-ipc/ipc-unix-socket.c',
>     ]
> @@ -1339,7 +1342,7 @@ if fsmonitor_backend != ''
>     libgit_c_args += '-DHAVE_FSMONITOR_DAEMON_BACKEND'
>     libgit_c_args += '-DHAVE_FSMONITOR_OS_SETTINGS'
>   
> -  libgit_sources += [
> +  compat_sources += [
>       'compat/fsmonitor/fsm-health-' + fsmonitor_backend + '.c',
>       'compat/fsmonitor/fsm-ipc-' + fsmonitor_backend + '.c',
>       'compat/fsmonitor/fsm-listen-' + fsmonitor_backend + '.c',
> @@ -1355,7 +1358,7 @@ if not get_option('b_sanitize').contains('address') and get_option('regex').allo
>   
>     if compiler.get_define('REG_ENHANCED', prefix: '#include <regex.h>') != ''
>       libgit_c_args += '-DUSE_ENHANCED_BASIC_REGULAR_EXPRESSIONS'
> -    libgit_sources += 'compat/regcomp_enhanced.c'
> +    compat_sources += 'compat/regcomp_enhanced.c'
>     endif
>   elif not get_option('regex').enabled()
>     libgit_c_args += [
> @@ -1364,7 +1367,7 @@ elif not get_option('regex').enabled()
>       '-DNO_MBSUPPORT',
>     ]
>     build_options_config.set('NO_REGEX', '1')
> -  libgit_sources += 'compat/regex/regex.c'
> +  compat_sources += 'compat/regex/regex.c'
>     libgit_include_directories += 'compat/regex'
>   else
>       error('Native regex support requested but not found')
> @@ -1428,7 +1431,7 @@ else
>   
>     if get_option('b_sanitize').contains('address')
>       libgit_c_args += '-DNO_MMAP'
> -    libgit_sources += 'compat/mmap.c'
> +    compat_sources += 'compat/mmap.c'
>     else
>       checkfuncs += { 'mmap': ['mmap.c'] }
>     endif
> @@ -1438,7 +1441,7 @@ foreach func, impls : checkfuncs
>     if not compiler.has_function(func)
>       libgit_c_args += '-DNO_' + func.to_upper()
>       foreach impl : impls
> -      libgit_sources += 'compat/' + impl
> +      compat_sources += 'compat/' + impl
>       endforeach
>     endif
>   endforeach
> @@ -1449,13 +1452,13 @@ endif
>   
>   if not compiler.has_function('strdup')
>     libgit_c_args += '-DOVERRIDE_STRDUP'
> -  libgit_sources += 'compat/strdup.c'
> +  compat_sources += 'compat/strdup.c'
>   endif
>   
>   if not compiler.has_function('qsort')
>     libgit_c_args += '-DINTERNAL_QSORT'
>   endif
> -libgit_sources += 'compat/qsort_s.c'
> +compat_sources += 'compat/qsort_s.c'
>   
>   if compiler.has_function('getdelim')
>     libgit_c_args += '-DHAVE_GETDELIM'
> @@ -1511,7 +1514,7 @@ if meson.can_run_host_binaries() and compiler.run('''
>     }
>   ''', name: 'fread reads directories').returncode() == 0
>     libgit_c_args += '-DFREAD_READS_DIRECTORIES'
> -  libgit_sources += 'compat/fopen.c'
> +  compat_sources += 'compat/fopen.c'
>   endif
>   
>   if not meson.is_cross_build() and fs.exists('/dev/tty')
> @@ -1745,14 +1748,22 @@ else
>   endif
>   
>   libgit = declare_dependency(
> -  link_with: static_library('git',
> -    sources: libgit_sources,
> -    c_args: libgit_c_args + [
> -      '-DGIT_VERSION_H="' + version_def_h.full_path() + '"',
> -    ],
> -    dependencies: libgit_dependencies,
> -    include_directories: libgit_include_directories,
> -  ),
> +  link_with: [
> +    static_library('compat',
> +      sources: compat_sources,
> +      c_args: libgit_c_args,
> +      dependencies: libgit_dependencies,
> +      include_directories: libgit_include_directories,
> +    ),
> +    static_library('git',
> +      sources: libgit_sources,
> +      c_args: libgit_c_args + [
> +        '-DGIT_VERSION_H="' + version_def_h.full_path() + '"',
> +      ],
> +      dependencies: libgit_dependencies,
> +      include_directories: libgit_include_directories,
> +    ),
> +  ],
>     compile_args: libgit_c_args,
>     dependencies: libgit_dependencies,
>     include_directories: libgit_include_directories,
> 

