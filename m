Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72FE2F39AB
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 10:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771496346; cv=none; b=T401jLfrXfNEXuk+XTmv0lQCN264u1g+8ePPTInrFAJNPh8OAo8LkRXbPRJKWTYqvDqRK4fWCy/k6Ca/bVhXzyLNMpm2VOX1VumFgz+S4C3FZ6hadLsrK/xwAER0HPQElD72BfnK0USK7rypRyKqwTaHXCrx3XjfqJQpZeM9DlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771496346; c=relaxed/simple;
	bh=zJ/ckZRUxmaVgQigDZ/wBD/J5rjVN97qS70b8CUnv54=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=VXZb+vNdZ+rGMB6Q7fjdqhyNK/FZvBgCv7o5z5+0/Ph1pB9LHINPp0wq8UZWHp1dcrzaju5ehnrOBfuUmNxELyAuIsk5qe24ZtjuKzoaFEmb/CywzXmFc6Rp9S+q6wGtkLiSN8h5C6B0cYNtbtOQVu7h5+YszTlfbDn+J1fxTDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YgLl+kiS; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgLl+kiS"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-48370174e18so4803715e9.2
        for <git@vger.kernel.org>; Thu, 19 Feb 2026 02:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771496343; x=1772101143; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=usGeFUsN3x/lUoxwmk5EObuAXhhdzaeFDoHwgVs7/no=;
        b=YgLl+kiS6xNdBypF2tzoNYJNKk62wETZ6M9Ekkkn79aG0zfvtbpHbBbkSSxmAmWAog
         7/26nTIAKydVX3TiNdDRee2KHT846E6QhZsViIzdXt5MnJ3Mn6YkWoaZA7UgQIIxxWi4
         QaDnCW/DSEUo/ZONjddBol3mRh+muOsdYsDlPsLXs+gWQJ+LKTcUaWsxPF/3Eu+sO9wG
         QiD+l/bo9vuzoRI6VJ3xTpHYIE5DfpT0HW77Cclxf4Is+VBm4dcb71HuOSJN+CMcH+0M
         DGwuBhSAbwBqVVTQhf4XwvKUvgu2vu7ZEvzx2HfhtjBJZZrINkX7hzk58z6kOXqNADex
         Z2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771496343; x=1772101143;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=usGeFUsN3x/lUoxwmk5EObuAXhhdzaeFDoHwgVs7/no=;
        b=nXSuoxq5R1S4sOWv6fMaBPGfJXM44z0DOHZnR/zBBMJ4M15nc5rGGK/OZFlcGyCFWe
         +G0JqABng8bdUePHSITiN1EslZWNLqLeAyd1M6cJ+LyCYEdviu9uvaaXIIEtgC3DGWvi
         p5axAfdmAV/IonTgP1rT8CcNJG3jFd39QPYulty4KQ2sO8n9inihxxzKLf3QcOiBOivu
         MRiVQMCpmP6zUXul/P+xwXWkdaI2lguBbTcMmz6lnqc4uqD5fVaSrfN58DkpxFxBWmw7
         n6FVn/534VNX1y3uUOpdsAuaOXueWjTrk7SJKJnKsr49NIBy4G6nfD0/r0vfYb0Vilw8
         R20A==
X-Forwarded-Encrypted: i=1; AJvYcCUrg0U/p4EZIUoyVOeH+gIHOc6OErAfCefDydapTQkD+RvR8MQrtkSJpBlySOZqE8zTthI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNTW+ACcn/DII3ZdAW7hg2ovk/sNDo5n1yb6yaUVMPnW5WIkNV
	Pzx6pybi+HFioxqvoOT799DLj3Y5rCYIdAo2i8Cc4aIQMTlS9bjezBn/
X-Gm-Gg: AZuq6aLgqXQhctL1BQlYukZ3dUsigDAUAESfofxMyvlJtXipP4L5vY2j8YpuXezyAXO
	68AwDSYiLKTBI/mFTZXe0BQKZFIlhGBHdpN2cmWJE/TSQ3vypBgA3jmgxnodfKLA9OJWI3pvncF
	PA3vLqfHFxUR2FcRGQ9DgpHOJ2bocZgwAP7I92EiWuJBoCeZM8LyZXSbNUTC6tTKj0NZxIrYV+v
	ErAo2bYpTMbJdz9wL/VVDrkxHC5ELlsMGckYrefnDzw0vt/xF0NdOyhcDqbGhLN/IayCdCY3ktI
	C/MkRC2o8Z01xEA7Hqovy4eT0Xtb+O/crii7mBERPn5KRZe3/BqUMHmdIGEVlVBL9OpZO5sROZD
	26uCfv2P7pHsLxOfZ/5OO4kSRdHdTtXYIipe8d+trimQ7cPx/hPK4H6ko8kBMgtKHj3IZ4c3XUN
	8365HcMEUXAp8Xvcm98JzI4PCAzDRFYrPe5OXlHwjtQt1z+v/Wmu2Vp2bUaCcZWFPzV+Znqegrr
	XhrVw==
X-Received: by 2002:a05:600c:154a:b0:47a:814c:eea1 with SMTP id 5b1f17b1804b1-48379bfc005mr317709415e9.35.1771496342727;
        Thu, 19 Feb 2026 02:19:02 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:68d:f601:6840:9d65:3109:8533? ([2a0a:ef40:68d:f601:6840:9d65:3109:8533])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796ad009bsm46844459f8f.39.2026.02.19.02.19.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 02:19:02 -0800 (PST)
Message-ID: <fe5bb243-6205-41d1-9dad-7a1e2e42fbec@gmail.com>
Date: Thu, 19 Feb 2026 10:19:01 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5] build: regenerate config-list.h when Documentation
 changes
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>, git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>, Patrick Steinhardt
 <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 Evan Martin <evan.martin@gmail.com>
References: <9cdcc9de04f0f8fff657f0474b31c063466ed808.1771280837.git.ben.knoble+github@gmail.com>
 <611a94cd988e3795bc63dba2f1b270aa0d058bd2.1771425395.git.ben.knoble+github@gmail.com>
Content-Language: en-US
In-Reply-To: <611a94cd988e3795bc63dba2f1b270aa0d058bd2.1771425395.git.ben.knoble+github@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ben

I tested the meson changes by setting up source and build directories 
with daft names to test the quoting.

$ git worktree add --detach '/dev/shm/s#r#c dir'
$ cd '/dev/shm/s#r#c dir'
$ meson setup '/dev/shm/b#u&i ld'

If I build git and then remove Documentation/config/add.adoc 
config-list.h is regenerated, it is not regenerated if I do not change 
any of the config documentation files so it looks to be working 
correctly. I've not tested the Makefile changes.

Thanks for working on it

Phillip

On 18/02/2026 14:37, D. Ben Knoble wrote:
> The Meson-based build doesn't know when to rebuild config-list.h, so the
> header is sometimes stale.
> 
> For example, an old build directory might have config-list.h from before
> 4173df5187 (submodule: introduce extensions.submodulePathConfig,
> 2026-01-12), which added submodule.<name>.gitdir to the list. Without
> it, t9902-completion.sh fails. Regenerating the config-list.h artifact
> from sources fixes the artifact and the test.
> 
> Teach the meson build to depend on the Documentation files that
> generate-configlist.sh reads by having it an additional output as a list
> of dependency files, since Meson does not have (or want) builtin support
> for globbing like Make. We assume that if a user adds a new file under
> Documentation/config then they will also edit one of the existing files
> to include that new file, and that will trigger a rebuild. Also mark the
> generator script as a dependency.
> 
> While we're at it, teach the Makefile to use the same "the script knows
> it's dependencies" logic.
> 
> For Meson, combining the following commands helps debug dependencies:
> 
>      ninja -C <builddir> -t deps config-list.h
>      ninja -C <builddir> -t browse config-list.h
> 
> The former lists all the dependencies discovered from our output ".d"
> file (the config documentation) and the latter shows the dependency on
> the script itself, among other useful edges in the dependency graph.
> 
> Helped-by: Patrick Steinhardt <ps@pks.im>
> Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
> ---
> 
> Notes (benknoble/commits):
>      Changes from v4 (<9cdcc9de04f0f8fff657f0474b31c063466ed808.1771280837.git.ben.knoble+github@gmail.com>):
>      
>      • Include Patrick's suggested Makefile changes. Note there's no quiet
>        equivalent for mdkir that isn't for the current target's containing
>        directory…
>      • Make depfile output efficient again, thanks to Phillip.
>      
>      I've kept printf instead of echo (from Patrick/Junio) because I think it
>      is easier to reason about ("it works" vs. "did I use this in a way that
>      might cause problems").
>      
>      Junio asked about other problematic bytes: the other one I could think
>      of (since all the inputs should be paths, anyway) is newlines. I gave
>      meson's depfile.py a glance [1], and it looks like they don't handle
>      newlines in paths. Other whitespace doesn't appear to be an issue (see
>      "elif c in {' ', '\n'}"); I think _most_ characters are just added to
>      the filename.
>      
>      [1]: https://github.com/mesonbuild/meson/blob/master/mesonbuild/depfile.py
> 
>   Makefile               |  5 +++--
>   generate-configlist.sh | 11 ++++++++++-
>   meson.build            |  5 ++++-
>   3 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 7f37ad8f58..6f926ffb1f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2688,9 +2688,10 @@ $(BUILT_INS): git$X
>   	cp $< $@
>   
>   config-list.h: generate-configlist.sh
> +	@mkdir -p .depend
> +	$(QUIET_GEN)$(SHELL_PATH) ./generate-configlist.sh . $@ .depend/config-list.h.d
>   
> -config-list.h: Documentation/*config.adoc Documentation/config/*.adoc
> -	$(QUIET_GEN)$(SHELL_PATH) ./generate-configlist.sh . $@
> +-include .depend/config-list.h.d
>   
>   command-list.h: generate-cmdlist.sh command-list.txt
>   
> diff --git a/generate-configlist.sh b/generate-configlist.sh
> index 75c39ade20..39ac8845ab 100755
> --- a/generate-configlist.sh
> +++ b/generate-configlist.sh
> @@ -2,10 +2,11 @@
>   
>   SOURCE_DIR="$1"
>   OUTPUT="$2"
> +DEPFILE="$3"
>   
>   if test -z "$SOURCE_DIR" || ! test -d "$SOURCE_DIR" || test -z "$OUTPUT"
>   then
> -	echo >&2 "USAGE: $0 <SOURCE_DIR> <OUTPUT>"
> +	echo >&2 "USAGE: $0 <SOURCE_DIR> <OUTPUT> [<DEPFILE>]"
>   	exit 1
>   fi
>   
> @@ -36,3 +37,11 @@ print_config_list () {
>   	echo
>   	print_config_list
>   } >"$OUTPUT"
> +
> +if test -n "$DEPFILE"
> +then
> +	QUOTED_OUTPUT="$(printf '%s\n' "$OUTPUT" | sed 's,[&/\],\\&,g')"
> +	printf '%s\n' "$SOURCE_DIR"/Documentation/*config.adoc \
> +		"$SOURCE_DIR"/Documentation/config/*.adoc |
> +		sed -e 's/[# ]/\\&/g' -e "s/^/$QUOTED_OUTPUT: /" >"$DEPFILE"
> +fi
> diff --git a/meson.build b/meson.build
> index 762e2d0fc0..74b459b004 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -720,11 +720,14 @@ endif
>   
>   builtin_sources += custom_target(
>     output: 'config-list.h',
> +  depfile: 'config-list.h.d',
> +  depend_files: [ 'generate-configlist.sh' ],
>     command: [
>       shell,
> -    meson.current_source_dir() + '/generate-configlist.sh',
> +    meson.current_source_dir() / 'generate-configlist.sh',
>       meson.current_source_dir(),
>       '@OUTPUT@',
> +    '@DEPFILE@',
>     ],
>     env: script_environment,
>   )
> 
> Diff-intervalle contre v4 :
> 1:  e2f4e1f9ba < -:  ---------- completion: add stash import, export
> 2:  9cdcc9de04 ! 1:  611a94cd98 meson: regenerate config-list.h when Documentation changes
>      @@ Metadata
>       Author: D. Ben Knoble <ben.knoble+github@gmail.com>
>       
>        ## Commit message ##
>      -    meson: regenerate config-list.h when Documentation changes
>      +    build: regenerate config-list.h when Documentation changes
>       
>           The Meson-based build doesn't know when to rebuild config-list.h, so the
>           header is sometimes stale.
>      @@ Commit message
>           of dependency files, since Meson does not have (or want) builtin support
>           for globbing like Make. We assume that if a user adds a new file under
>           Documentation/config then they will also edit one of the existing files
>      -    to include that new file, and that will trigger a rebuild.
>      +    to include that new file, and that will trigger a rebuild. Also mark the
>      +    generator script as a dependency.
>       
>      -    Also mark the generator script as a dependency.
>      +    While we're at it, teach the Makefile to use the same "the script knows
>      +    it's dependencies" logic.
>       
>      -    Combining the following commands helps debug dependencies:
>      +    For Meson, combining the following commands helps debug dependencies:
>       
>               ninja -C <builddir> -t deps config-list.h
>               ninja -C <builddir> -t browse config-list.h
>      @@ Commit message
>       
>       
>        ## Notes (benknoble/commits) ##
>      -    Changes from v3 (<0a344f1f3ee4a5d95c6f46df030b9936db4354a1.1770853297.git.ben.knoble+github@gmail.com>):
>      +    Changes from v4 (<9cdcc9de04f0f8fff657f0474b31c063466ed808.1771280837.git.ben.knoble+github@gmail.com>):
>       
>      -    • Include the script itself as a dependency via depfile
>      -    • Fix output path escaping (spaces, octothorpes; drop backslashes) for
>      -      Ninja (I've used a loop because I couldn't find a portable construct
>      -      that could escape only the remainder of the lines in the way I
>      -      wanted).
>      -    • Mention our assumptions about Documentation updates triggering
>      -      rebuilds
>      -    • Also include some debugging information in the commit message
>      +    • Include Patrick's suggested Makefile changes. Note there's no quiet
>      +      equivalent for mdkir that isn't for the current target's containing
>      +      directory…
>      +    • Make depfile output efficient again, thanks to Phillip.
>      +
>      +    I've kept printf instead of echo (from Patrick/Junio) because I think it
>      +    is easier to reason about ("it works" vs. "did I use this in a way that
>      +    might cause problems").
>      +
>      +    Junio asked about other problematic bytes: the other one I could think
>      +    of (since all the inputs should be paths, anyway) is newlines. I gave
>      +    meson's depfile.py a glance [1], and it looks like they don't handle
>      +    newlines in paths. Other whitespace doesn't appear to be an issue (see
>      +    "elif c in {' ', '\n'}"); I think _most_ characters are just added to
>      +    the filename.
>      +
>      +    [1]: https://github.com/mesonbuild/meson/blob/master/mesonbuild/depfile.py
>      +
>      + ## Makefile ##
>      +@@ Makefile: $(BUILT_INS): git$X
>      + 	cp $< $@
>      +
>      + config-list.h: generate-configlist.sh
>      ++	@mkdir -p .depend
>      ++	$(QUIET_GEN)$(SHELL_PATH) ./generate-configlist.sh . $@ .depend/config-list.h.d
>      +
>      +-config-list.h: Documentation/*config.adoc Documentation/config/*.adoc
>      +-	$(QUIET_GEN)$(SHELL_PATH) ./generate-configlist.sh . $@
>      ++-include .depend/config-list.h.d
>      +
>      + command-list.h: generate-cmdlist.sh command-list.txt
>      +
>       
>        ## generate-configlist.sh ##
>       @@
>      @@ generate-configlist.sh: print_config_list () {
>       +
>       +if test -n "$DEPFILE"
>       +then
>      -+	for doc in "$SOURCE_DIR"/Documentation/*config.adoc \
>      -+		"$SOURCE_DIR"/Documentation/config/*.adoc
>      -+	do
>      -+		printf "$OUTPUT: %s\n" "$(printf '%s\n' "$doc" | sed 's/[# ]/\\&/g')"
>      -+	done >"$DEPFILE"
>      ++	QUOTED_OUTPUT="$(printf '%s\n' "$OUTPUT" | sed 's,[&/\],\\&,g')"
>      ++	printf '%s\n' "$SOURCE_DIR"/Documentation/*config.adoc \
>      ++		"$SOURCE_DIR"/Documentation/config/*.adoc |
>      ++		sed -e 's/[# ]/\\&/g' -e "s/^/$QUOTED_OUTPUT: /" >"$DEPFILE"
>       +fi
>       
>        ## meson.build ##
> 
> base-commit: f7e9f6c205466443107228e036b20acb7baa8c50

