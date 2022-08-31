Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B42BECAAD3
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 17:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiHaRVm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 13:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbiHaRVV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 13:21:21 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810BBD275B
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 10:21:13 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id m1so19301609edb.7
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 10:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=Eg1QntpVnHMu/AFL20k4bkJvfye61waBaFbE8k2iakM=;
        b=BNoqB55FIpuKGC2fjIvTU0Pc2fSgqceSqXTPo7M3vIl2C7oHaAMk2JQaEUj+uW/WXr
         UlrGc+VPin4DusSteHUoORS/x06LLzBQI1NnCODqRmJD6bL6xlEKgbI9FKUsqSI2doQt
         Z+tQGcpjZwxWWfQurZXT4p53icP5tC9tYYZN0pmj4CLT4GG7lw54TG395DisCLOLzxHz
         8fKdjA324CAMf7nbutTQua3m3WHgoK6BHpG/zqFoeg9tCFnVONUifJY9j7tVkgl4qzdJ
         4Gtuc8BLNVndR67KC0KQa9ifFj0MsFpAw+guzm12vn/tn7UW5Uhu2UL/EsES3VKjoTOx
         MS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Eg1QntpVnHMu/AFL20k4bkJvfye61waBaFbE8k2iakM=;
        b=naa3YQptT5rbwh/8Jt+8ZDKSV6RfwNyYE5qccbtkyfGmtzxCXn4LcBVXdkR6vh5teB
         zircfG58DS9Z//IQkFfWnKZijktI6gVb71g+5gg9NIbYYp3DE1GawFA1sTFsv95/0VzS
         /FT159kjzfGwf/aHNNsYTOlBoJT5yxCDPkQygSlWPAZETA0AXSS6gk2AfMPDbQDKQ2FX
         WkAeFj9vm+ecFupKb61q7+5C6pQKzeeODFiLiTVIdScHEFoBsfmixYcEhzZ1hJOIuE93
         FaP9PzdIhFkROHGRuFBQgelMQ3LUGThxBkQIvrG8Paz9Gt/4Q6ibiHpQ/Kku00ybYzjq
         0raA==
X-Gm-Message-State: ACgBeo07zbbG8LSAFRjkMFUOhcH1LYGX2f+aKPcgmc6+5jvyDM9SKGIg
        LQhK32KIuUP9y5TJPi3vJQIWsUz4gu+eiA==
X-Google-Smtp-Source: AA6agR5hN44Xvq+0tkX2h8intqv1Fpo1WFkIKYQDzsrHciq4Py4B5dQuQ/cLtYWIXlB14NU8DII9mQ==
X-Received: by 2002:a05:6402:33c4:b0:448:e63e:4f40 with SMTP id a4-20020a05640233c400b00448e63e4f40mr5615051edc.203.1661966471676;
        Wed, 31 Aug 2022 10:21:11 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id b5-20020a17090630c500b0073dde7c1767sm7358486ejb.175.2022.08.31.10.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 10:21:11 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oTROo-000NDr-15;
        Wed, 31 Aug 2022 19:21:10 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com,
        johannes.schindelin@gmx.de, gitster@pobox.com,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 0/8] scalar: integrate into core Git
Date:   Wed, 31 Aug 2022 19:03:00 +0200
References: <pull.1341.git.1661961746.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <pull.1341.git.1661961746.gitgitgadget@gmail.com>
Message-ID: <220831.86y1v48h2x.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 31 2022, Victoria Dye via GitGitGadget wrote:

> This series completes the initial implementation of the Scalar command as a
> core component of Git. For readers new to the topic of Scalar, the
> roadmap/design doc [1] provides some background information including how
> the project started & evolved, as well as its current intent & high-level
> design.
>
> [...]
>
> Prior series
> ============
>
>  * Add 'scalar' command in 'contrib/':
>    https://lore.kernel.org/git/pull.1005.v10.git.1638538470.gitgitgadget@gmail.com/
>  * Introduce 'scalar diagnose':
>    https://lore.kernel.org/git/pull.1128.v6.git.1653145696.gitgitgadget@gmail.com/
>  * Add '-c/-C' compatibility:
>    https://lore.kernel.org/git/pull.1130.v2.git.1643380317358.gitgitgadget@gmail.com/
>  * [DROPPED] Integrate Scalar into CI builds:
>    https://lore.kernel.org/git/pull.1129.git.1654160735.gitgitgadget@gmail.com/
>  * Document Scalar's role in Git & plan remaining work:
>    https://lore.kernel.org/git/pull.1275.v2.git.1657584367.gitgitgadget@gmail.com/
>  * Generalize 'scalar diagnose' into 'git diagnose' builtin & 'git bugreport
>    --diagnose':
>    https://lore.kernel.org/git/pull.1310.v4.git.1660335019.gitgitgadget@gmail.com/
>  * Add FSMonitor support to Scalar, refactor enlistment search:
>    https://lore.kernel.org/git/pull.1324.v3.git.1660858853.gitgitgadget@gmail.com/
>
> Thanks!
>
>  * Victoria

I'm happy to see this finally coming. I can say I've thoroughly reviewed
it & tested it for the better part of a year now. Since most of it is
the same or functionally the same as previous patches I sent at [1] and
[2]. It's odd not to see any mention of that here:

	1. https://lore.kernel.org/git/cover-v2-0.1-00000000000-20220623T100554Z-avarab@gmail.com/
	2. https://lore.kernel.org/git/patch-1.1-86fb8d56307-20211028T185016Z-avarab@gmail.com/

In any case. I applied this & a rebased version I've kept of [1]
locally, and I'll be commenting below on the diff between the two, which
I produced with:

	git diff --stat -p avar/scalar-move-build-from-contrib-3 HEAD -- ':!t/t9211-scalar-clone.sh' ':!Documentation/technical/scalar.txt' ':!t/perf/'

I.e. you can get my version at
http://github.com/avar/git/tree/avar/scalar-move-build-from-contrib-3 if
you're interested, and I omitted the changes to paths unique to yours:
	
	 .gitignore                             |  2 +-
	 Documentation/Makefile                 |  4 +-
	 Documentation/cmd-list.perl            |  2 +-
	 Documentation/git.txt                  | 13 ------
	 Documentation/scalar.txt               |  2 +-
	 Makefile                               | 75 ++++++++++++----------------------
	 builtin/help.c                         |  2 +
	 command-list.txt                       |  2 -
	 contrib/buildsystems/CMakeLists.txt    | 20 +++------
	 scalar.c                               | 20 +++++++++
	 t/{t7990-scalar.sh => t9210-scalar.sh} |  2 +-
	 11 files changed, 60 insertions(+), 84 deletions(-)
	
	diff --git a/.gitignore b/.gitignore
	index b1db05a9207..3d1b880101e 100644
	--- a/.gitignore
	+++ b/.gitignore
	@@ -185,6 +185,7 @@
	 /git-whatchanged
	 /git-worktree
	 /git-write-tree
	+/scalar
	 /git-core-*/?*
	 /git.res
	 /gitweb/GITWEB-BUILD-OPTIONS
	@@ -220,7 +221,6 @@
	 /config.mak.append
	 /configure
	 /.vscode/
	-/scalar
	 /tags
	 /TAGS
	 /cscope*

Functionally the same.

	diff --git a/Documentation/Makefile b/Documentation/Makefile
	index 85b68ab3e9c..9ec53afdf18 100644
	--- a/Documentation/Makefile
	+++ b/Documentation/Makefile
	@@ -21,9 +21,7 @@ MAN1_TXT += $(filter-out \
	 MAN1_TXT += git.txt
	 MAN1_TXT += gitk.txt
	 MAN1_TXT += gitweb.txt
	-ifndef NO_INSTALL_SCALAR_DOC
	 MAN1_TXT += scalar.txt
	-endif

So, this series goes the full way and install scalar unconditionally. I
don't mind it, but all previous discussions on the matter were IIRC of
some initial optional installation. I think doing it unconditionally
makes sense, but that explains this difference.
	 
	 # man5 / man7 guides (note: new guides should also be added to command-list.txt)
	 MAN5_TXT += gitattributes.txt
	@@ -118,6 +116,7 @@ TECH_DOCS += technical/parallel-checkout
	 TECH_DOCS += technical/partial-clone
	 TECH_DOCS += technical/racy-git
	 TECH_DOCS += technical/reftable
	+TECH_DOCS += technical/scalar
	 TECH_DOCS += technical/send-pack-pipeline
	 TECH_DOCS += technical/shallow
	 TECH_DOCS += technical/trivial-merge

Makes sense.

	@@ -290,7 +289,6 @@ endif
	 cmds_txt = cmds-ancillaryinterrogators.txt \
	 	cmds-ancillarymanipulators.txt \
	 	cmds-mainporcelain.txt \
	-	cmds-optionalcontrib.txt \
	 	cmds-plumbinginterrogators.txt \
	 	cmds-plumbingmanipulators.txt \
	 	cmds-synchingrepositories.txt \

The "optional install" also explains this bit, i.e. this was the "scalar
still in the proverbial contrib", whatever "contrib" meant.

	diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
	index 0f4b1b23cfe..af5da45d287 100755
	--- a/Documentation/cmd-list.perl
	+++ b/Documentation/cmd-list.perl
	@@ -10,7 +10,7 @@ sub format_one {
	 	$state = 0;
	 	open I, '<', "$name.txt" or die "No such file $name.txt";
	 	while (<I>) {
	-		if (/^[a-z0-9-]*\(([0-9])\)$/) {
	+		if (/^git[a-z0-9-]*\(([0-9])\)$/) {
	 			$mansection = $1;
	 			next;
	 		}

This is an artifact of you not having added it to command-list.txt, more on that later.

	diff --git a/Documentation/git.txt b/Documentation/git.txt
	index 40ab70f1381..0ef7f5e4ece 100644
	--- a/Documentation/git.txt
	+++ b/Documentation/git.txt
	@@ -357,19 +357,6 @@ linkgit:git-help[1].
	 
	 include::cmds-developerinterfaces.txt[]
	 
	-Optional contrib commands
	--------------------------
	-
	-The following commands are included with the git sources, but may not
	-be present in your installation.
	-
	-These should be considered "contrib"-level when it comes to
	-maintenance and stability promises. They might not even be included in
	-your installation, and may either drastically change in the future, or
	-go away entirely.
	-
	-include::cmds-optionalcontrib.txt[]
	-
	 Configuration Mechanism
	 -----------------------

The "optional contrib".
	 
	diff --git a/Documentation/scalar.txt b/Documentation/scalar.txt
	index f33436c7f65..505a1cea0fd 100644
	--- a/Documentation/scalar.txt
	+++ b/Documentation/scalar.txt
	@@ -163,4 +163,4 @@ linkgit:git-clone[1], linkgit:git-maintenance[1].
	 
	 GIT
	 ---
	-Part of the linkgit:git[1] suite
	+Associated with the linkgit:git[1] suite

You just kept this, but it really should be the former. The target
audience of this bit of the documentation is some sysadmin that's
wondering what this "scalar" thing is, and does "man scalar".

Let's not be cute, we're shipping it as part of git, it's not
"associated" anymore, it's part of the git suite.

	diff --git a/Makefile b/Makefile
	index c8108ded394..66dd3321f57 100644
	--- a/Makefile
	+++ b/Makefile
	@@ -476,11 +476,6 @@ include shared.mak
	 # INSTALL_STRIP can be set to "-s" to strip binaries during installation,
	 # if your $(INSTALL) command supports the option.
	 #
	-# Define INSTALL_SCALAR if you would like to install the optional
	-# "scalar" command. This command is considered "contrib"-level, see
	-# 'Optional "contrib" commands' in the built (with "make man") git(1)
	-# manual page.
	-#
	 # Define GENERATE_COMPILATION_DATABASE to "yes" to generate JSON compilation
	 # database entries during compilation if your compiler supports it, using the
	 # `-MJ` flag. The JSON entries will be placed in the `compile_commands/`

More "optional install" etc.

	@@ -613,9 +608,10 @@ FUZZ_OBJS =
	 FUZZ_PROGRAMS =
	 GIT_OBJS =
	 LIB_OBJS =
	+SCALAR_OBJS =
	 OBJECTS =
	-PROGRAM_OBJS =
	 OTHER_PROGRAMS =
	+PROGRAM_OBJS =
	 PROGRAMS =
	 EXCLUDED_PROGRAMS =
	 SCRIPT_PERL =
	@@ -832,23 +828,12 @@ OTHER_PROGRAMS += scalar$X
	 
	 # what test wrappers are needed and 'install' will install, in bindir
	 BINDIR_PROGRAMS_NEED_X += git
	+BINDIR_PROGRAMS_NEED_X += scalar
	 BINDIR_PROGRAMS_NEED_X += git-receive-pack
	 BINDIR_PROGRAMS_NEED_X += git-shell
	 BINDIR_PROGRAMS_NEED_X += git-upload-archive
	 BINDIR_PROGRAMS_NEED_X += git-upload-pack
	 
	-# Sometimes we only have a test wrapper, but not a program to
	-# install. This isn't so pretty, and we could refactor the
	-# bin-wrappers/% and install code to make it unnecessary.
	-ifdef INSTALL_SCALAR
	-PROGRAMS += scalar$X
	-BINDIR_PROGRAMS_NEED_X += scalar
	-endif
	-TEST_BINDIR_PROGRAMS_NEED_X = $(BINDIR_PROGRAMS_NEED_X)
	-ifndef INSTALL_SCALAR
	-TEST_BINDIR_PROGRAMS_NEED_X += scalar
	-endif
	-
	 BINDIR_PROGRAMS_NO_X += git-cvsserver
	 
	 # Set paths to tools early so that they can be used for version tests.
	@@ -2241,7 +2226,7 @@ profile-fast: profile-clean
	 
	 all:: $(ALL_COMMANDS_TO_INSTALL) $(SCRIPT_LIB) $(OTHER_PROGRAMS) GIT-BUILD-OPTIONS
	 ifneq (,$X)
	-	$(QUIET_BUILT_IN)$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_COMMANDS_TO_INSTALL) git$X)), test -d '$p' -o '$p' -ef '$p$X' || $(RM) '$p';)
	+	$(QUIET_BUILT_IN)$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_COMMANDS_TO_INSTALL) $(OTHER_PROGRAMS))), test -d '$p' -o '$p' -ef '$p$X' || $(RM) '$p';)
	 endif
	 
	 all::
	@@ -2564,7 +2549,12 @@ GIT_OBJS += git.o
	 .PHONY: git-objs
	 git-objs: $(GIT_OBJS)

ditto.
	 
	+SCALAR_OBJS += scalar.o
	+.PHONY: scalar-objs
	+scalar-objs: $(SCALAR_OBJS)

This part looks missing from yours. I.e. we do this with the rest of our
"objects", just gravy of course...

	+
	 OBJECTS += $(GIT_OBJS)
	+OBJECTS += $(SCALAR_OBJS)
	 OBJECTS += $(PROGRAM_OBJS)
	 OBJECTS += $(TEST_OBJS)
	 OBJECTS += $(XDIFF_OBJS)
	@@ -2575,9 +2565,6 @@ ifndef NO_CURL
	 	OBJECTS += http.o http-walker.o remote-curl.o
	 endif
	 
	-SCALAR_OBJECTS := scalar.o
	-OBJECTS += $(SCALAR_OBJECTS)
	-
	 .PHONY: objects
	 objects: $(OBJECTS)
	 
	@@ -2709,7 +2696,7 @@ $(REMOTE_CURL_PRIMARY): remote-curl.o http.o http-walker.o GIT-LDFLAGS $(GITLIBS
	 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
	 		$(CURL_LIBCURL) $(EXPAT_LIBEXPAT) $(LIBS)
	 
	-scalar$X: $(SCALAR_OBJECTS) GIT-LDFLAGS $(GITLIBS)
	+scalar$X: scalar.o GIT-LDFLAGS $(GITLIBS)
	 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
	 		$(filter %.o,$^) $(LIBS)
	 
	@@ -2765,7 +2752,8 @@ XGETTEXT_FLAGS_SH = $(XGETTEXT_FLAGS) --language=Shell \
	 XGETTEXT_FLAGS_PERL = $(XGETTEXT_FLAGS) --language=Perl \
	 	--keyword=__ --keyword=N__ --keyword="__n:1,2"
	 MSGMERGE_FLAGS = --add-location --backup=off --update
	-LOCALIZED_C = $(sort $(FOUND_C_SOURCES) $(FOUND_H_SOURCES) $(GENERATED_H))
	+LOCALIZED_C = $(sort $(FOUND_C_SOURCES) $(FOUND_H_SOURCES) \
	+	        $(GENERATED_H))

Nit: we can avoid the line-wrap here. FWIW I moved it back to the
version pre-9f555783c0b, but obviously functionally the same...

	 LOCALIZED_SH = $(sort $(SCRIPT_SH) git-sh-setup.sh)
	 LOCALIZED_PERL = $(sort $(SCRIPT_PERL))
	 
	@@ -3071,18 +3059,15 @@ GIT-PYTHON-VARS: FORCE
	             fi
	 endif
	 
	-test_bindir_programs := $(patsubst %,bin-wrappers/%,$(TEST_BINDIR_PROGRAMS_NEED_X) $(BINDIR_PROGRAMS_NO_X) $(TEST_PROGRAMS_NEED_X))
	+test_bindir_programs := $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAMS_NEED_X) $(BINDIR_PROGRAMS_NO_X) $(TEST_PROGRAMS_NEED_X))
	 
	 all:: $(TEST_PROGRAMS) $(test_bindir_programs)
	 
	-# Substitution that's only done on programs named git-* in
	-# bin-wrappers/*
	-GIT_TEST_BINDIR_PROGRAMS_NEED_X = $(filter-out scalar,$(TEST_BINDIR_PROGRAMS_NEED_X))
	 bin-wrappers/%: wrap-for-bin.sh
	 	$(call mkdir_p_parent_template)
	 	$(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
	 	     -e 's|@@BUILD_DIR@@|$(shell pwd)|' \
	-	     -e 's|@@PROG@@|$(patsubst test-%,t/helper/test-%$(X),$(@F))$(patsubst git%,$(X),$(filter $(@F),$(GIT_TEST_BINDIR_PROGRAMS_NEED_X)))|' < $< > $@ && \
	+	     -e 's|@@PROG@@|$(patsubst test-%,t/helper/test-%,$(@F))$(if $(filter-out $(BINDIR_PROGRAMS_NO_X),$(@F)),$(X),)|' < $< > $@ && \
	 	chmod +x $@
	 
	 # GNU make supports exporting all variables by "export" without parameters.
	@@ -3296,14 +3281,14 @@ ifndef NO_TCLTK
	 	$(MAKE) -C git-gui gitexecdir='$(gitexec_instdir_SQ)' install
	 endif
	 ifneq (,$X)
	-	$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_COMMANDS_TO_INSTALL) git$X)), test '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p' -ef '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p$X' || $(RM) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p';)
	+	$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_COMMANDS_TO_INSTALL) $(OTHER_PROGRAMS))), test '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p' -ef '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p$X' || $(RM) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p';)
	 endif

Looks correct, just different.
	 
	 	bindir=$$(cd '$(DESTDIR_SQ)$(bindir_SQ)' && pwd) && \
	 	execdir=$$(cd '$(DESTDIR_SQ)$(gitexec_instdir_SQ)' && pwd) && \
	 	destdir_from_execdir_SQ=$$(echo '$(gitexecdir_relative_SQ)' | sed -e 's|[^/][^/]*|..|g') && \
	 	{ test "$$bindir/" = "$$execdir/" || \
	-	  for p in git$X $(filter $(install_bindir_programs),$(ALL_PROGRAMS)); do \
	+	  for p in $(OTHER_PROGRAMS) $(filter $(install_bindir_programs),$(ALL_PROGRAMS)); do \
	 		$(RM) "$$execdir/$$p" && \
	 		test -n "$(INSTALL_SYMLINKS)" && \
	 		ln -s "$$destdir_from_execdir_SQ/$(bindir_relative_SQ)/$$p" "$$execdir/$$p" || \

This part I missed, thanks!

	@@ -3347,18 +3332,11 @@ endif
	 .PHONY: install-doc install-man install-man-perl install-html install-info install-pdf
	 .PHONY: quick-install-doc quick-install-man quick-install-html
	 
	-# We must not "export" this as e.g. "check-docs" needs to know about
	-# scalar.txt. We only exclude scalar.txt for the "install-*" targets.
	-NO_INSTALL_SCALAR_DOC =
	-ifndef INSTALL_SCALAR
	-NO_INSTALL_SCALAR_DOC = NoScalarPlease
	-endif
	-
	 install-doc: install-man-perl
	-	$(MAKE) -C Documentation install NO_INSTALL_SCALAR_DOC='$(NO_INSTALL_SCALAR_DOC)'
	+	$(MAKE) -C Documentation install
	 
	 install-man: install-man-perl
	-	$(MAKE) -C Documentation install-man NO_INSTALL_SCALAR_DOC='$(NO_INSTALL_SCALAR_DOC)'
	+	$(MAKE) -C Documentation install-man
	 
	 install-man-perl: man-perl
	 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(mandir_SQ)/man3'
	@@ -3366,22 +3344,22 @@ install-man-perl: man-perl
	 	(cd '$(DESTDIR_SQ)$(mandir_SQ)/man3' && umask 022 && $(TAR) xof -)
	 
	 install-html:
	-	$(MAKE) -C Documentation install-html NO_INSTALL_SCALAR_DOC='$(NO_INSTALL_SCALAR_DOC)'
	+	$(MAKE) -C Documentation install-html
	 
	 install-info:
	-	$(MAKE) -C Documentation install-info NO_INSTALL_SCALAR_DOC='$(NO_INSTALL_SCALAR_DOC)'
	+	$(MAKE) -C Documentation install-info
	 
	 install-pdf:
	-	$(MAKE) -C Documentation install-pdf NO_INSTALL_SCALAR_DOC='$(NO_INSTALL_SCALAR_DOC)'
	+	$(MAKE) -C Documentation install-pdf
	 
	 quick-install-doc:
	-	$(MAKE) -C Documentation quick-install NO_INSTALL_SCALAR_DOC='$(NO_INSTALL_SCALAR_DOC)'
	+	$(MAKE) -C Documentation quick-install
	 
	 quick-install-man:
	-	$(MAKE) -C Documentation quick-install-man NO_INSTALL_SCALAR_DOC='$(NO_INSTALL_SCALAR_DOC)'
	+	$(MAKE) -C Documentation quick-install-man
	 
	 quick-install-html:
	-	$(MAKE) -C Documentation quick-install-html NO_INSTALL_SCALAR_DOC='$(NO_INSTALL_SCALAR_DOC)'
	+	$(MAKE) -C Documentation quick-install-html

This is to do with making the "scalar docs" optional, but if we're not doing that...
	 
	 
	 
	@@ -3485,7 +3463,7 @@ clean: profile-clean coverage-clean cocciclean
	 	$(RM) git.res
	 	$(RM) $(OBJECTS)
	 	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(REFTABLE_TEST_LIB)
	-	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) git$X
	+	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) $(OTHER_PROGRAMS)
	 	$(RM) $(TEST_PROGRAMS)
	 	$(RM) $(FUZZ_PROGRAMS)
	 	$(RM) $(SP_OBJ)

Makes sense.

	@@ -3536,6 +3514,7 @@ ALL_COMMANDS += git-citool
	 ALL_COMMANDS += git-gui
	 ALL_COMMANDS += gitk
	 ALL_COMMANDS += gitweb
	+ALL_COMMANDS += scalar
	 
	 .PHONY: check-docs
	 check-docs::
	@@ -3571,7 +3550,7 @@ check-docs::
	 		    -e 's/\.txt//'; \
	 	) | while read how cmd; \
	 	do \
	-		case " $(patsubst %$X,%,$(ALL_COMMANDS) $(BUILT_INS) $(EXCLUDED_PROGRAMS) scalar) " in \
	+		case " $(patsubst %$X,%,$(ALL_COMMANDS) $(BUILT_INS) $(EXCLUDED_PROGRAMS)) " in \
	 		*" $$cmd "*)	;; \
	 		*) echo "removed but $$how: $$cmd" ;; \
	 		esac; \
	diff --git a/builtin/help.c b/builtin/help.c
	index 09ac4289f13..6f2796f211e 100644
	--- a/builtin/help.c
	+++ b/builtin/help.c
	@@ -440,6 +440,8 @@ static const char *cmd_to_page(const char *git_cmd)
	 		return git_cmd;
	 	else if (is_git_command(git_cmd))
	 		return xstrfmt("git-%s", git_cmd);
	+	else if (!strcmp("scalar", git_cmd))
	+		return xstrdup(git_cmd);
	 	else
	 		return xstrfmt("git%s", git_cmd);
	 }

Works, but I wonder if 3/8 here in your series is what we really want,
i.e. isn't the point of "git" to be a holistic thing for git, and for
"scalar" to be set apart from that?

But OTOH much of the docs would need to cross-link anyway...

	diff --git a/command-list.txt b/command-list.txt
	index 27bd54af49c..f96bdabd7d9 100644
	--- a/command-list.txt
	+++ b/command-list.txt
	@@ -16,7 +16,6 @@
	 #   synchingrepositories
	 #   synchelpers
	 #   purehelpers
	-#   optionalcontrib
	 #
	 # The type names are self explanatory. But if you want to see what
	 # command belongs to what group to get a better picture, have a look
	@@ -236,4 +235,3 @@ gittutorial                             guide
	 gittutorial-2                           guide
	 gitweb                                  ancillaryinterrogators
	 gitworkflows                            guide
	-scalar                                  optionalcontrib

You don't have it in command-list at all, shouldn't you?

	diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
	index a5a1dedab4f..bae203c1fb9 100644
	--- a/contrib/buildsystems/CMakeLists.txt
	+++ b/contrib/buildsystems/CMakeLists.txt
	@@ -610,8 +610,7 @@ unset(CMAKE_REQUIRED_INCLUDES)
	 #programs
	 set(PROGRAMS_BUILT
	 	git git-daemon git-http-backend git-sh-i18n--envsubst
	-	git-shell
	-	scalar)
	+	git-shell scalar)

Just whitespace changes.
	 
	 if(NOT CURL_FOUND)
	 	list(APPEND excluded_progs git-http-fetch git-http-push)
	@@ -746,9 +745,6 @@ list(TRANSFORM git_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
	 add_executable(git ${CMAKE_SOURCE_DIR}/git.c ${git_SOURCES})
	 target_link_libraries(git common-main)
	 
	-add_executable(scalar ${CMAKE_SOURCE_DIR}/scalar.c)
	-target_link_libraries(scalar common-main)
	-
	 add_executable(git-daemon ${CMAKE_SOURCE_DIR}/daemon.c)
	 target_link_libraries(git-daemon common-main)
	 
	@@ -761,6 +757,9 @@ target_link_libraries(git-sh-i18n--envsubst common-main)
	 add_executable(git-shell ${CMAKE_SOURCE_DIR}/shell.c)
	 target_link_libraries(git-shell common-main)
	 
	+add_executable(scalar ${CMAKE_SOURCE_DIR}/scalar.c)
	+target_link_libraries(scalar common-main)
	+
	 if(CURL_FOUND)
	 	add_library(http_obj OBJECT ${CMAKE_SOURCE_DIR}/http.c)
	 
	@@ -906,16 +905,10 @@ list(TRANSFORM git_shell_scripts PREPEND "${CMAKE_BINARY_DIR}/")
	 list(TRANSFORM git_perl_scripts PREPEND "${CMAKE_BINARY_DIR}/")
	 
	 #install
	-option(INSTALL_SCALAR "Install the optional 'scalar' contrib command")
	 foreach(program ${PROGRAMS_BUILT})
	-if(program STREQUAL "git" OR program STREQUAL "git-shell")
	-install(TARGETS ${program}
	-	RUNTIME DESTINATION bin)
	-elseif(program STREQUAL "scalar")
	-if(INSTALL_SCALAR)
	+if(program MATCHES "^(git|git-shell|scalar)$")
	 install(TARGETS ${program}
	 	RUNTIME DESTINATION bin)
	-endif()
	 else()
	 install(TARGETS ${program}
	 	RUNTIME DESTINATION libexec/git-core)
	@@ -987,8 +980,7 @@ endif()
	 
	 #wrapper scripts
	 set(wrapper_scripts
	-	git git-upload-pack git-receive-pack git-upload-archive git-shell git-remote-ext
	-	scalar)
	+	git git-upload-pack git-receive-pack git-upload-archive git-shell git-remote-ext scalar)
	 
	 set(wrapper_test_scripts
	 	test-fake-ssh test-tool)
	diff --git a/scalar.c b/scalar.c
	index 642d16124eb..675d7a6b0a9 100644
	--- a/scalar.c
	+++ b/scalar.c
	@@ -819,6 +819,25 @@ static int cmd_delete(int argc, const char **argv)
	 	return res;
	 }
	 
	+static int cmd_help(int argc, const char **argv)
	+{
	+	struct option options[] = {
	+		OPT_END(),
	+	};
	+	const char * const usage[] = {
	+		N_("scalar help"),
	+		NULL
	+	};
	+
	+	argc = parse_options(argc, argv, NULL, options,
	+			     usage, 0);
	+
	+	if (argc != 0)
	+		usage_with_options(usage, options);
	+
	+	return run_git("help", "scalar", NULL);
	+}
	+
	 static int cmd_version(int argc, const char **argv)
	 {
	 	int verbose = 0, build_options = 0;
	@@ -858,6 +877,7 @@ static struct {
	 	{ "run", cmd_run },
	 	{ "reconfigure", cmd_reconfigure },
	 	{ "delete", cmd_delete },
	+	{ "help", cmd_help },
	 	{ "version", cmd_version },
	 	{ "diagnose", cmd_diagnose },
	 	{ NULL, NULL},
	diff --git a/t/t7990-scalar.sh b/t/t9210-scalar.sh
	similarity index 98%
	rename from t/t7990-scalar.sh
	rename to t/t9210-scalar.sh
	index 62b92d361e2..14ca575a214 100755
	--- a/t/t7990-scalar.sh
	+++ b/t/t9210-scalar.sh
	@@ -4,7 +4,7 @@ test_description='test the `scalar` command'
	 
	 . ./test-lib.sh
	 
	-GIT_TEST_MAINT_SCHEDULER="crontab:test-tool crontab ../cron.txt,launchctl:true,schtasks:true"
	+GIT_TEST_MAINT_SCHEDULER="crontab:test-tool crontab cron.txt,launchctl:true,schtasks:true"
	 export GIT_TEST_MAINT_SCHEDULER
	 
	 test_expect_success 'scalar shows a usage' '
	
Makes sense.

Thanks.
