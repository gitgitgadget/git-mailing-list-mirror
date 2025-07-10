Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D752274669
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 21:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752181960; cv=none; b=ZWzJ5g/WHaMt5hfdthv9axUu6e/QOJqinV5dd9d36oh3hCfVmTyjenSpV8LWoY4qkTNyc4QWwjXjOApOybbs9OSPmDjOwxQlnQy2h0bTicKikd70tU5EbCS8AK7m5ZwUvds/8AERI2vG7kQ5H7vTf8ngVMbVaThhibAEOCdgY8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752181960; c=relaxed/simple;
	bh=5JKF21U3ej9APO42gcwsm4szCYpe+1d2RYcQ1rmjeho=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ra2CPkfrqcBRjhr5ATw4KebYBxWpQKgGaMTkXInFaGEfntB9LSYmeeMz480S2dpj27izFwbYEWQwZTw0dy2w6Qoq6j+yAa160blzsZxODvIT/V0IqCbY3nhg1XNTVMc/ISADfnDvREmg6aps6WnnQNHHhFnbgdAClhfSrq4rRtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=S8LbKy05; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UWLiESjq; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="S8LbKy05";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UWLiESjq"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id A6D2A1D000FD;
	Thu, 10 Jul 2025 17:12:34 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 10 Jul 2025 17:12:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752181954; x=1752268354; bh=ubwqMq9QWo
	ThOrGiBnSkT83aGNygOHszTM0uvuE7owY=; b=S8LbKy05r7Ap7+5yxpLXfYLrtO
	0BgDc+/ERL/wsOrBL/Ffbp15N+/kFY35jHOkJmHHgzO7SDmJd/hMDM9aKy0odUDk
	oXf3d5k9Un7Vm4pX3k/yPNZiZorcM7myVpD2UjRAGuLDr7rE3a6y5G3SwaQKbHtw
	POZAoVPapOUh/bREqNS9VSAzB+pDp6i41wFFgYbi0462GrAy61egeKOHYJBthVbS
	vKc0WKZ5/IlQz+25qdFaBbKMjMl9/Ug7R/ecj9qvLJOUI8y+AuxWCpo/IIoRKjI4
	RMMxHNOiCOyUqX0baPhjBY3Hcd7dBSJnxNcTI9HJ0HRnOwo53d/fjgn74K1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752181954; x=1752268354; bh=ubwqMq9QWoThOrGiBnSkT83aGNygOHszTM0
	uvuE7owY=; b=UWLiESjq+KX7zjwgCtgdgexvGEeLIverUSaG5tnhCdagjPm+UtF
	NkmFAGowERxZeoaphm07Uc1Gzzb1eccYQb5Kc7Qao7ozc/pCXTNkW3hhry/NHH3M
	m/nnHWqXRE4gS99jR7ecRE4090iEz1v5HstjFX72PW9MMds4XnO8EdJXFwM2G/BM
	gigOLGK2K9c7V9ZoP07kwvQiUh+JP6sjlkI2nRDtIuzZ+Qef43txAWeBPy48ZOYp
	rMWp1WGdXshwJvMu+G3KUJanT79J1fs6iX/yPjbsmcdnExCgmKTH1W7L6RuGSIw3
	RYRj2zgtT89PBcA8XGbWJkOLZBxfgg9RRPw==
X-ME-Sender: <xms:wSxwaF5vDlkTDg3v53UOujIByv6uXcXjTc0MMoKvltOybfqg2Qtkiw>
    <xme:wSxwaMUUHb-ZCr1WZeXowjC4JXv2xBxu04Ziwr-743ywvlbEQexs9n-V1FxiB_EoX
    OT0z2zt_MqwW3kxcw>
X-ME-Received: <xmr:wSxwaMAjPco2uCK6vgJ3DNfMAhAhZKybhUaQNPuvKcAkG7UKvriv3CyAvBRktX7K94f40mFrl_mJ3aFBiIrErtK7YqYDARGLZ9RJ9YQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegudegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeijeejveevueehheevudehkedufffgffefffffvdfgueefteduffefteevheek
    jeenucffohhmrghinhepthhhrghnkhhsrdhpshenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhn
    sggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrrghmsh
    grhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepphhssehp
    khhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:wixwaD7MEQdyDzCBn-VJwEeoIw6FZBlgvn9U5fxoGBPiN-HdJg1QrA>
    <xmx:wixwaPyQaCjxKvT8s1PdjZVtUbDV9B8KiOu0dxhg76deJwrTe5cGHA>
    <xmx:wixwaCy2KvrF9FLg7_UOr4LQvU45OJ5De32l8IdrIqhpJH3zTiAVcg>
    <xmx:wixwaPxCDIJQFe7d6h8pGFbpQ_AV4A3Gil6f7t2czBBKyoKVqkE_gQ>
    <xmx:wixwaBL-84dpYaloeJbug6NrEKGM-TqhhVs9yVgIRuwkY0OdguUhYMPz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Jul 2025 17:12:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>,
    Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [-SPAM-] What's cooking in git.git (Jul 2025, #03; Wed, 9)
In-Reply-To: <f614e1c8-91a9-4430-9d60-5aca05170b4a@ramsayjones.plus.com>
	(Ramsay Jones's message of "Thu, 10 Jul 2025 20:32:13 +0100")
References: <xmqqv7o08ocn.fsf@gitster.g>
	<f614e1c8-91a9-4430-9d60-5aca05170b4a@ramsayjones.plus.com>
Date: Thu, 10 Jul 2025 14:12:32 -0700
Message-ID: <xmqqo6tr698f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

>
> How would you like to proceed? (yes, I haven't written the commit message
> yet).

... appears near the end of the message, and the way _I_ would like
to proceed is to make sure two parties involved in overlapping
solutions to the same problem talk to each other and come up with a
solution together.  The first step to get you going would be to CC
the other parties involved.

If the controversial step in Patrick's 8-patch series is relatively
independent from others (which was the impression I got from "more
or less random cleanups and improvements"), one approach with less
friction is to simply omit it and make it 7-patch series.  While you
and Patric work out what the best approach to solve the libexecdir
problem, the rest of the series can proceed without waiting,
hopefully?

The rest is quoted from your message (without anything commented on
by me) for Patrick's reference.

Thanks.


>> * ps/meson-cleanups (2025-07-08) 8 commits
>>  - ci: use Meson's new `--slice` option
>>  - meson: update subproject wrappers
>>  - meson: fix GIT_EXEC_PATH with overridden -Dlibexecdir=
>>  - meson: fix lookup of shell on MINGW64
>>  - meson: clean up unnecessary variables
>>  - meson: improve summary of auto-detected features
>>  - meson: stop printing 'https' option twice in our summaries
>>  - meson: stop discovering native version of Python
> ...
> The patch 'meson: fix GIT_EXEC_PATH with overridden -Dlibexecdir=' (6/8)
> which is part of this series, is essentially a revert of commit 837f637cf51
> (meson.build: correct setting of GIT_EXEC_PATH, 2025-05-19). That commit
> did introduce a regression, but I have a patch (see below) which I think
> would be an improvement.
>
> I had intended to test this patch some more before submitting it, and I
> think there are some additional problems, but it may be ready soon so that
> it could replace the patch in this series. (It seems silly to have to revert
> the revert before the next release ;) ).
>
> The 'additional problems' exist no matter which patch is applied, so it
> can be addressed by a later patch on top. (I *think* there are additional
> problems - I have yet to properly investigate; look at the setting for
> GITEXECDIR_REL).
>
> As a quick demonstration, no 'libexecdir' setting:
>
>   $ meson setup -Dprefix=/tmp/git build
>   ...
>     User defined options
>       prefix     : /tmp/git
>   
>   Found ninja-1.11.1 at /usr/bin/ninja
>   $ cd build
>   $ meson compile
>   INFO: autodetecting backend as ninja
>   INFO: calculating backend command to run: /usr/bin/ninja
>   [662/662] Copying file contrib/completion/git
>   $ meson install
>   ninja: Entering directory `/home/ramsay/git/build'
>   [1/28] Generating GIT-VERSION-FILE wit... command (wrapped by meson to set env)
>   Installing git to /tmp/git/libexec/git-core
>   ...
>   $ ls /tmp/git
>   bin/  libexec/  share/
>   $ ls -l /tmp/git/bin/git
>   lrwxrwxrwx 1 ramsay ramsay 23 Jul 10 18:44 /tmp/git/bin/git -> ../libexec/git-core/git*
>   $ /tmp/git/bin/git --exec-path
>   /tmp/git/libexec/git-core
>   $ /tmp/git/bin/git daemon -h
>   usage: git daemon [--verbose] [--syslog] [--export-all]
>   ...
>   $ 
>  
> Now with a relative path for 'libexecdir':
>  
>   $ cd ..
>   $ rm -rf build
>
>   $ meson setup -Dprefix=/tmp/git1 -Dlibexecdir=libexec-different build
>   ...
>     User defined options
>       libexecdir : libexec-different
>       prefix     : /tmp/git1
>   
>   Found ninja-1.11.1 at /usr/bin/ninja
>   $ cd build
>   $ meson compile
>   INFO: autodetecting backend as ninja
>   INFO: calculating backend command to run: /usr/bin/ninja
>   [662/662] Copying file contrib/completion/git
>   $ meson install
>   ninja: Entering directory `/home/ramsay/git/build'
>   [1/28] Generating GIT-VERSION-FILE wit... command (wrapped by meson to set env)
>   Installing git to /tmp/git1/libexec-different
>   ...
>   $ ls /tmp/git1
>   bin/  libexec-different/  share/
>   $ ls -l /tmp/git1/bin/git
>   lrwxrwxrwx 1 ramsay ramsay 24 Jul 10 18:54 /tmp/git1/bin/git -> ../libexec-different/git*
>   $ /tmp/git1/bin/git --exec-path
>   /tmp/git1/libexec-different
>   $ /tmp/git1/bin/git daemon -h
>   usage: git daemon [--verbose] [--syslog] [--export-all]
>   ...
>   $ 
>
> And finally, with an absolute path for 'libexecdir':  
>   
>   $ cd ..
>   $ rm -rf build
>
>   $ meson setup -Dprefix=/tmp/git2 -Dlibexecdir=/tmp/somewhere/else build
>   ...
>     User defined options
>       libexecdir : /tmp/somewhere/else
>       prefix     : /tmp/git2
>   
>   Found ninja-1.11.1 at /usr/bin/ninja
>   $ cd build
>   $ meson compile
>   INFO: autodetecting backend as ninja
>   INFO: calculating backend command to run: /usr/bin/ninja
>   [662/662] Copying file contrib/completion/git
>   $ meson install
>   ninja: Entering directory `/home/ramsay/git/build'
>   [1/28] Generating GIT-VERSION-FILE wit... command (wrapped by meson to set env)
>   Installing git to /tmp/somewhere/else
>   ...
>   $ ls /tmp/git2
>   bin/  share/
>   $ ls /tmp/somewhere
>   else/
>   $ ls /tmp/somewhere/else
>   git*                   git-merge-octopus*   git-send-email*
>   git-archimport*        git-merge-one-file*  git-shell*
>   git-cvsexportcommit*   git-merge-resolve*   git-sh-i18n
>   git-cvsimport*         git-mergetool*       git-sh-i18n--envsubst*
>   git-cvsserver*         git-mergetool--lib   git-sh-setup
>   git-daemon*            git-p4*              git-submodule*
>   git-difftool--helper*  git-quiltimport*     git-svn*
>   git-filter-branch*     git-receive-pack@    git-upload-archive@
>   git-http-backend*      git-remote-ftp@      git-upload-pack@
>   git-http-fetch*        git-remote-ftps@     git-web--browse*
>   git-http-push*         git-remote-http*     mergetools/
>   git-imap-send*         git-remote-https@    scalar*
>   git-instaweb*          git-request-pull*
>   $ ls -l /tmp/git2/bin/git
>   lrwxrwxrwx 1 ramsay ramsay 34 Jul 10 19:01 /tmp/git2/bin/git -> ../../../../tmp/somewhere/else/git*
>   $ /tmp/git2/bin/git --exec-path
>   /tmp/somewhere/else
>   $ /tmp/git2/bin/git daemon -h
>   usage: git daemon [--verbose] [--syslog] [--export-all]
>   ...
>   $ 
>
> I had intended to do the equivalent 'make' invocations and check with 'tree'
> (by diffing the output) or similar, that the installations are the same, but
> they seem to be correct (just eyeballing them).
>
> How would you like to proceed? (yes, I haven't written the commit message
> yet).
>
> ATB,
> Ramsay Jones
>
> ---- >8 ----  
> From: Ramsay Jones <ramsay@ramsayjones.plus.com>
> Subject: [PATCH] meson: fix installation when -Dlibexexdir is set
>
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>  meson.build | 42 +++++++++++++++++++++---------------------
>  1 file changed, 21 insertions(+), 21 deletions(-)
>
> diff --git a/meson.build b/meson.build
> index 7fea4a34d6..26b12c4592 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1744,7 +1744,7 @@ git_builtin = executable('git',
>    sources: builtin_sources + 'git.c',
>    dependencies: [libgit_commonmain],
>    install: true,
> -  install_dir: get_option('libexecdir') / 'git-core',
> +  install_dir: git_exec_path,
>  )
>  bin_wrappers += git_builtin
>  
> @@ -1752,35 +1752,35 @@ test_dependencies += executable('git-daemon',
>    sources: 'daemon.c',
>    dependencies: [libgit_commonmain],
>    install: true,
> -  install_dir: get_option('libexecdir') / 'git-core',
> +  install_dir: git_exec_path,
>  )
>  
>  test_dependencies += executable('git-sh-i18n--envsubst',
>    sources: 'sh-i18n--envsubst.c',
>    dependencies: [libgit_commonmain],
>    install: true,
> -  install_dir: get_option('libexecdir') / 'git-core',
> +  install_dir: git_exec_path,
>  )
>  
>  bin_wrappers += executable('git-shell',
>    sources: 'shell.c',
>    dependencies: [libgit_commonmain],
>    install: true,
> -  install_dir: get_option('libexecdir') / 'git-core',
> +  install_dir: git_exec_path,
>  )
>  
>  test_dependencies += executable('git-http-backend',
>    sources: 'http-backend.c',
>    dependencies: [libgit_commonmain],
>    install: true,
> -  install_dir: get_option('libexecdir') / 'git-core',
> +  install_dir: git_exec_path,
>  )
>  
>  bin_wrappers += executable('scalar',
>    sources: 'scalar.c',
>    dependencies: [libgit_commonmain],
>    install: true,
> -  install_dir: get_option('libexecdir') / 'git-core',
> +  install_dir: git_exec_path,
>  )
>  
>  if curl.found()
> @@ -1796,14 +1796,14 @@ if curl.found()
>      sources: 'remote-curl.c',
>      dependencies: [libgit_curl],
>      install: true,
> -    install_dir: get_option('libexecdir') / 'git-core',
> +    install_dir: git_exec_path,
>    )
>  
>    test_dependencies += executable('git-http-fetch',
>      sources: 'http-fetch.c',
>      dependencies: [libgit_curl],
>      install: true,
> -    install_dir: get_option('libexecdir') / 'git-core',
> +    install_dir: git_exec_path,
>    )
>  
>    if expat.found()
> @@ -1811,7 +1811,7 @@ if curl.found()
>        sources: 'http-push.c',
>        dependencies: [libgit_curl],
>        install: true,
> -      install_dir: get_option('libexecdir') / 'git-core',
> +      install_dir: git_exec_path,
>      )
>    endif
>  
> @@ -1822,7 +1822,7 @@ if curl.found()
>      )
>  
>      install_symlink(alias + executable_suffix,
> -      install_dir: get_option('libexecdir') / 'git-core',
> +      install_dir: git_exec_path,
>        pointing_to: 'git-remote-http',
>      )
>    endforeach
> @@ -1832,7 +1832,7 @@ test_dependencies += executable('git-imap-send',
>    sources: 'imap-send.c',
>    dependencies: [ use_curl_for_imap_send ? libgit_curl : libgit_commonmain ],
>    install: true,
> -  install_dir: get_option('libexecdir') / 'git-core',
> +  install_dir: git_exec_path,
>  )
>  
>  foreach alias : [ 'git-receive-pack', 'git-upload-archive', 'git-upload-pack' ]
> @@ -1842,7 +1842,7 @@ foreach alias : [ 'git-receive-pack', 'git-upload-archive', 'git-upload-pack' ]
>    )
>  
>    install_symlink(alias + executable_suffix,
> -    install_dir: get_option('libexecdir') / 'git-core',
> +    install_dir: git_exec_path,
>      pointing_to: 'git',
>    )
>  endforeach
> @@ -1856,9 +1856,9 @@ foreach symlink : [
>    'scalar',
>  ]
>    if meson.version().version_compare('>=1.3.0')
> -    pointing_to = fs.relative_to(get_option('libexecdir') / 'git-core' / symlink, get_option('bindir'))
> +    pointing_to = fs.relative_to(git_exec_path / symlink, get_option('bindir'))
>    else
> -    pointing_to = '../libexec/git-core' / symlink
> +    pointing_to = '..' / git_exec_path / symlink
>    endif
>  
>    install_symlink(symlink,
> @@ -1898,7 +1898,7 @@ foreach script : scripts_sh
>        meson.project_build_root() / 'GIT-BUILD-OPTIONS',
>      ],
>      install: true,
> -    install_dir: get_option('libexecdir') / 'git-core',
> +    install_dir: git_exec_path,
>    )
>  endforeach
>  
> @@ -1931,7 +1931,7 @@ if perl_features_enabled
>      input: perl_header_template,
>      output: 'GIT-PERL-HEADER',
>      configuration: {
> -      'GITEXECDIR_REL': get_option('libexecdir') / 'git-core',
> +      'GITEXECDIR_REL': git_exec_path,
>        'PERLLIBDIR_REL': perllibdir,
>        'LOCALEDIR_REL': get_option('datadir') / 'locale',
>        'INSTLIBDIR': perllibdir,
> @@ -1955,7 +1955,7 @@ if perl_features_enabled
>        output: fs.stem(script),
>        command: generate_perl_command,
>        install: true,
> -      install_dir: get_option('libexecdir') / 'git-core',
> +      install_dir: git_exec_path,
>        depends: [git_version_file],
>      )
>      test_dependencies += generated_script
> @@ -1964,9 +1964,9 @@ if perl_features_enabled
>        bin_wrappers += generated_script
>  
>        if meson.version().version_compare('>=1.3.0')
> -        pointing_to = fs.relative_to(get_option('libexecdir') / 'git-core' / fs.stem(script), get_option('bindir'))
> +        pointing_to = fs.relative_to(git_exec_path / fs.stem(script), get_option('bindir'))
>        else
> -        pointing_to = '../libexec/git-core' / fs.stem(script)
> +        pointing_to = '..' / git_exec_path / fs.stem(script)
>        endif
>  
>        install_symlink(fs.stem(script),
> @@ -1996,7 +1996,7 @@ if python.found()
>          '@OUTPUT@',
>        ],
>        install: true,
> -      install_dir: get_option('libexecdir') / 'git-core',
> +      install_dir: git_exec_path,
>      )
>      test_dependencies += generated_python
>    endforeach
> @@ -2030,7 +2030,7 @@ mergetools = [
>  ]
>  
>  foreach mergetool : mergetools
> -  install_data(mergetool, install_dir: get_option('libexecdir') / 'git-core' / 'mergetools')
> +  install_data(mergetool, install_dir: git_exec_path / 'mergetools')
>  endforeach
>  
>  if intl.found()
