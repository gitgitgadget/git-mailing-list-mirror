Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66095C433F5
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 01:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C4B260F4A
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 01:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbhJGB7N (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 21:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbhJGB7M (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 21:59:12 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958A6C061746
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 18:57:19 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id z20so16763706edc.13
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 18:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=pwuTuq7/ATFQbO8YVOKyDWnB0fkOcUi/f42ZNxKitnQ=;
        b=GEy2aULbjare3rKXWfTHXrnkd36nIS7ys+7N6ZwVoGdTSs7/S4Ga5dgjJoAWjKmVBD
         uA1DNXBhyyyN6BMJo4F4LlXY574Jtl9ZpqXVwjxUBFFHO6anZmhQajK42b79SLsY4s+0
         KeOFP2CXsgkfDCK2Ou7JbiJ4EHQLAIwOUFGgD9Gf7nDqtVr+Ick2474nHBErSEEZ4NXo
         11AVOTVXlPIh9XDfwPRQj3LpwBXagq9s3/2YI+Fy9HZGBZlyOs2sYnZeSL93+ManxEVI
         HJagQlgQ9Dukn/Zof+YfA0N//fkvdbdzfhISAaqSybsVZ6DQZKgCpGHZFc5p6uLlCdEt
         rOKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=pwuTuq7/ATFQbO8YVOKyDWnB0fkOcUi/f42ZNxKitnQ=;
        b=cg8YYSGXblb3RMWnD+S8dl+2WGwNycif+182b+7N5wMapU3N1AaCs+v3TnRGcGfeCY
         S9EwnwJmhk1Dwg5OIhnruMcO/vnXxWMNxXEaOT3K8PbSwProyIGBViXCOw211cCX+oW8
         D9G959s/g3k48q2L+MkKj2NHBR35N3emVaRdhx8p89ThLK9Uu0oSYg6QN6i7Jns/vqpf
         OIT4Gu9M6O0cFF/4uHts6xMqHuSyO5G8biShQNArhEXf/AE/SwkZqfPkXbcMMv8JeHbQ
         9OxT05lED5h0dvuqweB4qxfF4bvzYcXyTw56YyU6FUP8AS1OhxUuul02xY/OTMPLxOCZ
         mrxg==
X-Gm-Message-State: AOAM531ToN+2RBiptJSOywdJsKioRBRwgKOxl6Wn9TLnbkS2WP4VJcuK
        ChdWGkU4fD3oKlFVXhYHtLw=
X-Google-Smtp-Source: ABdhPJzWj9mChNn+cL8NK8oNWA60vBT9bKOV1K7xTNFjGdQIduB48Xzj/gr1w6mPmjdgwHgS85j+Zw==
X-Received: by 2002:a17:907:3f27:: with SMTP id hq39mr2103182ejc.352.1633571837962;
        Wed, 06 Oct 2021 18:57:17 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id w15sm954083ejb.4.2021.10.06.18.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 18:57:17 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: Train station analogy, was Re: [PATCH v3 00/15] [RFC]
 Upstreaming the Scalar command
Date:   Thu, 07 Oct 2021 03:03:40 +0200
References: <pull.1005.v2.git.1630691688.gitgitgadget@gmail.com>
        <pull.1005.v3.git.1631129086.gitgitgadget@gmail.com>
        <87r1dydp4m.fsf@evledraar.gmail.com>
        <87ilz44kdk.fsf@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2109131914080.55@tvgsbejvaqbjf.bet>
        <87mtofnzv1.fsf@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2109141432520.59@tvgsbejvaqbjf.bet>
        <xmqqilz32hhr.fsf@gitster.g> <xmqq1r5qzv35.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2110062139040.395@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <nycvar.QRO.7.76.6.2110062139040.395@tvgsbejvaqbjf.bet>
Message-ID: <875yu9iolf.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 06 2021, Johannes Schindelin wrote:

> On Tue, 14 Sep 2021, Junio C Hamano wrote:
>
>> An alternative would be to bypass the contrib/ phase and start as a
>> new subcommand that is first-class citizen from day one and let it
>> spend as much time as it needs to mature.
>
> I don't think that there is a lot of sense in that. The main benefits of
> `scalar` are in the `register` and the `clone` part, and the most natural
> end game would hence be for `git init` and `git clone` to sprout new
> options to support Scalar's features, in a Git-native way.
>
> As I have explained earlier, the `scalar` command has existing users,
> and therefore its command-line interface is not up for discussion (for
> example, turning `scalar` into `git scalar` would be a usability
> disaster). Scalar's _functionality_, however, should make it into Git
> proper. Into existing built-ins, that is.

Given the sub-thread this seems like it's trying to be an indirect reply
to me, but I haven't been advocating changing the UX of "scalar" in any
way, or that we should have a "git scalar".

I have in fact been advocating exactly what you're advocating here. So
we're in violent agreement. Yes the CLI UI shouldn't change, that's the
whole point of having a "scalar" in git.git, not a "git scalar" or
whatever.

I've been suggesting we can simplify the *build system* git.git uses,
something no user will ever see.

> So I don't think that the contrib/ phase can be by-passed. It would not
> make sense to port Scalar to a new builtin. To the contrary,
> contrib/scalar/ should be the final destination for the `scalar` command.
> And you can't bypass a final destination. That simply makes no sense.

I'm right now using a "scalar" installed on my system based on the diff
at the end of this E-Mail that changes the *build system* without any
user-facing changes (see
https://lore.kernel.org/git/87k0jhn0p9.fsf@evledraar.gmail.com/) for a
previous reference.
    
    $ which scalar
    /home/avar/local/bin/scalar
    $ scalar -h 2>&1 | head -n 1
    usage: scalar [-C <directory>] [-c <key>=<value>] <command> [<options>]
    $ man scalar
    [...]
    NAME
           scalar - an opinionated repository management tool
    $ git help scalar
    No manual entry for gitscalar

Except that I think your patches as they stand (correct me if I'm wrong)
don't have any way to install it or its documentation, just to build it
in-place.

> So why bother with contrib/ at all? you may ask. The reason is that it
> makes it substantially easier for me to move the features into core Git,
> as I can incrementally implement those new options for Git's built-ins,
> use them in `contrib/scalar/` instead of duplicating the functionality,
> and then make use of Scalar's Functional Test suite for a much more
> comprehensive testing (which has served us already really well in the
> past). It also doesn't hurt that this way, my day job will be very happy
> because Scalar users directly benefit from that work.

I think all of that summarizes "why have this live in git.git", which I
100% agree with. It's not a counter-argument to a working solution for
simplifying your proposed build system integration.

> Of course, these suggestions to integrate Scalar more into the core part
> of Git (missing the point that the final destination for the functionality
> is not a new built-in, but rather new options for existing built-ins) made
> everything much more cumbersome for me instead, for no gain that would be
> apparent to me, impeding on aforementioned ease to move the features into
> core Git (which has not happened yet, as a consequence), but hopefully
> this will soon be a thing of the past.

The diff below doesn't make scalar a built-in.

> So I would like to request that we close the discussion about the question
> whether to integrate Scalar more into the top-level Makefile or into
> git.c, and instead go ahead with keeping the `scalar` command in
> contrib/scalar/. The freed-up time can then be used to focus on the much
> more rewarding project of upstreaming Scalar's functionality such as
> teaching `git clone` a short-and-sweet option that Just Makes Sense for
> large monorepos (i.e. that imitates at least a large part of what `scalar
> clone` does right now).

The reason I care about this is because duplicating this as a one-off
may be easier for you now, but it creates a lot of maintenance burden
for others down the line.

For example, I've been fixing memory leaks recently and have a
linux-leaks CI job that's now running on GitHub. Scalar would benefit
from having a t/t9099-scalar.sh run as part of that.

Yes you can special-case it somehow and teach ci/, or even "make test"
to do the same thing. But there's a lot of little things both current
and future that are going to be like that. Here's another one:

    $ make -C contrib/scalar scalar
    $ echo bad >cache.h
    $ make -C contrib/scalar scalar
    make: 'scalar' is up to date.

I.e. because it's using its own Makefile it's not getting the very
basics of the dependency graph right. My version?

    $ make scalar
    $ touch cache.h
    $ make scalar
    [... Works exactly as well as doing the same with "git"...]

Yes we could fix that and other things etc, but why not just get all
that for free in around 1/4 lines of Makefile boilerplate (and less than
that in complexity)?

 .gitignore                                   |  1 +
 Documentation/Makefile                       |  3 ++
 {contrib/scalar => Documentation}/scalar.txt |  4 +-
 Makefile                                     | 44 +++++++++++-----
 contrib/scalar/.gitignore                    |  5 --
 contrib/scalar/Makefile                      | 57 --------------------
 contrib/scalar/t/Makefile                    | 78 ----------------------------
 contrib/scalar/scalar.c => scalar.c          |  0
 {contrib/scalar/t => t}/t9099-scalar.sh      |  8 +--
 9 files changed, 37 insertions(+), 163 deletions(-)

[Note that this probably doesn't fully apply to your series/master, not
because of any great textual/semantic conflict, but just because I find
it convenient to stack my WIP/unsubmitted serieses in related areas on
top of one another. This is on top of other Makefile changes I've got
unsubmitted, but it would be easy/trivial to re-apply on master+your
series].

diff --git a/.gitignore b/.gitignore
index 68ecb7f7e9c..ec9771e3532 100644
--- a/.gitignore
+++ b/.gitignore
@@ -217,6 +217,7 @@
 /configure
 /.vscode/
 /tags
+/scalar
 /TAGS
 /cscope*
 /compile_commands.json
diff --git a/Documentation/Makefile b/Documentation/Makefile
index f5605b7767f..57b72e1999a 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -18,6 +18,9 @@ MAN1_TXT += $(filter-out \
 MAN1_TXT += git.txt
 MAN1_TXT += gitk.txt
 MAN1_TXT += gitweb.txt
+ifndef NO_INSTALL_SCALAR_DOC
+MAN1_TXT += scalar.txt
+endif
 
 # man5 / man7 guides (note: new guides should also be added to command-list.txt)
 MAN5_TXT += gitattributes.txt
diff --git a/contrib/scalar/scalar.txt b/Documentation/scalar.txt
similarity index 99%
rename from contrib/scalar/scalar.txt
rename to Documentation/scalar.txt
index 3a80f829edc..f287ab18c31 100644
--- a/contrib/scalar/scalar.txt
+++ b/Documentation/scalar.txt
@@ -149,6 +149,6 @@ SEE ALSO
 --------
 linkgit:git-clone[1], linkgit:git-maintenance[1].
 
-Scalar
+GIT
 ---
-Associated with the linkgit:git[1] suite
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index fd617f8c775..536028922e1 100644
--- a/Makefile
+++ b/Makefile
@@ -602,6 +602,7 @@ LIB_OBJS =
 LIB_OBJS_NO_COMPAT_OBJS =
 OBJECTS =
 PROGRAM_OBJS =
+SCALAR_OBJS =
 SCRIPT_LIB =
 SCRIPT_PERL =
 SCRIPT_PROGRAMS =
@@ -807,6 +808,7 @@ BUILT_INS += $(BUILT_INS_EXTRA)
 
 # what 'all' will build but not install in gitexecdir
 OTHER_PROGRAMS = git$X
+OTHER_PROGRAMS += scalar$X
 ARTIFACTS_TAR += $(OTHER_PROGRAMS)
 
 # what test wrappers are needed and 'install' will install, in bindir
@@ -818,12 +820,18 @@ BINDIR_PROGRAMS_NEED_X += git-upload-pack
 
 BINDIR_PROGRAMS_NO_X += git-cvsserver
 
+ifdef INSTALL_SCALAR
+BINDIR_PROGRAMS_NEED_X += scalar
+endif
 INSTALL_BINDIR_XPROGRAMS += $(patsubst %,%$X,$(BINDIR_PROGRAMS_NEED_X))
 INSTALL_BINDIR_PROGRAMS += $(INSTALL_BINDIR_XPROGRAMS) $(BINDIR_PROGRAMS_NO_X)
 
 # We have bin-wrappers for programs that we don't install
 TEST_BINDIR_PROGRAMS_NEED_X += $(BINDIR_PROGRAMS_NEED_X)
 TEST_BINDIR_PROGRAMS_NEED_X += $(TEST_PROGRAMS_NEED_X)
+ifndef INSTALL_SCALAR
+TEST_BINDIR_PROGRAMS_NEED_X += scalar$X
+endif
 
 TEST_BINDIR_PROGRAMS += $(TEST_BINDIR_PROGRAMS_NEED_X)
 TEST_BINDIR_PROGRAMS += $(BINDIR_PROGRAMS_NO_X)
@@ -2230,7 +2238,7 @@ please_set_SHELL_PATH_to_a_more_modern_shell:
 
 shell_compatibility_test: please_set_SHELL_PATH_to_a_more_modern_shell
 
-strip: $(BIN_PROGRAMS) git$X
+strip: $(BIN_PROGRAMS) git$X scalar$X
 	$(STRIP) $(STRIP_OPTS) $^
 
 ### Flags affecting all rules
@@ -2286,6 +2294,10 @@ git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
 		$(filter %.o,$^) $(LIBS)
 
+scalar$X: scalar.o GIT-LDFLAGS $(GITLIBS)
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
+		$(filter %.o,$^) $(LIBS)
+
 help.sp help.s help.o: command-list.h
 
 builtin/help.sp builtin/help.s builtin/help.o: config-list.h GIT-PREFIX
@@ -2557,7 +2569,12 @@ GIT_OBJS += git.o
 .PHONY: git-objs
 git-objs: $(GIT_OBJS)
 
+SCALAR_OBJS += scalar.o
+.PHONY: scalar-objs
+scalar-objs: $(SCALAR_OBJS)
+
 OBJECTS += $(GIT_OBJS)
+OBJECTS += $(SCALAR_OBJS)
 OBJECTS += $(PROGRAM_OBJS)
 OBJECTS += $(TEST_OBJS)
 OBJECTS += $(XDIFF_OBJS)
@@ -2565,13 +2582,10 @@ OBJECTS += $(FUZZ_OBJS)
 ifndef NO_CURL
 	OBJECTS += http.o http-walker.o remote-curl.o
 endif
+OBJECTS += $(SCALAR_OBJECTS)
 .PHONY: objects
 objects: $(OBJECTS)
 
-SCALAR_SOURCES := contrib/scalar/scalar.c
-SCALAR_OBJECTS := $(SCALAR_SOURCES:c=o)
-OBJECTS += $(SCALAR_OBJECTS)
-
 dep_files := $(foreach f,$(OBJECTS),$(dir $f).depend/$(notdir $f).d)
 dep_dirs := $(addsuffix .depend,$(sort $(dir $(OBJECTS))))
 
@@ -2710,10 +2724,6 @@ $(REMOTE_CURL_PRIMARY): remote-curl.o http.o http-walker.o GIT-LDFLAGS $(GITLIBS
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(CURL_LIBCURL) $(EXPAT_LIBEXPAT) $(LIBS)
 
-contrib/scalar/scalar$X: $(SCALAR_OBJECTS) GIT-LDFLAGS $(GITLIBS)
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
-		$(filter %.o,$^) $(LIBS)
-
 $(LIB_FILE): $(LIB_OBJS) $(LIB_COMPAT_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
 
@@ -3260,11 +3270,17 @@ endif
 install-gitweb:
 	$(MAKE) -C gitweb install
 
+ifdef INSTALL_SCALAR
+NO_INSTALL_SCALAR_DOC =
+else
+NO_INSTALL_SCALAR_DOC = NoScalarPlease
+endif
+
 install-doc: install-man-perl
-	$(MAKE) -C Documentation install
+	$(MAKE) -C Documentation install NO_INSTALL_SCALAR_DOC=$(NO_INSTALL_SCALAR_DOC)
 
 install-man: install-man-perl
-	$(MAKE) -C Documentation install-man
+	$(MAKE) -C Documentation install-man NO_INSTALL_SCALAR_DOC=$(NO_INSTALL_SCALAR_DOC)
 
 install-man-perl: man-perl
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(mandir_SQ)/man3'
@@ -3272,13 +3288,13 @@ install-man-perl: man-perl
 	(cd '$(DESTDIR_SQ)$(mandir_SQ)/man3' && umask 022 && $(TAR) xof -)
 
 install-html:
-	$(MAKE) -C Documentation install-html
+	$(MAKE) -C Documentation install-html NO_INSTALL_SCALAR_DOC=$(NO_INSTALL_SCALAR_DOC)
 
 install-info:
-	$(MAKE) -C Documentation install-info
+	$(MAKE) -C Documentation install-info NO_INSTALL_SCALAR_DOC=$(NO_INSTALL_SCALAR_DOC)
 
 install-pdf:
-	$(MAKE) -C Documentation install-pdf
+	$(MAKE) -C Documentation install-pdf NO_INSTALL_SCALAR_DOC=$(NO_INSTALL_SCALAR_DOC)
 
 quick-install-doc:
 	$(MAKE) -C Documentation quick-install
diff --git a/contrib/scalar/.gitignore b/contrib/scalar/.gitignore
deleted file mode 100644
index 00441073f59..00000000000
--- a/contrib/scalar/.gitignore
+++ /dev/null
@@ -1,5 +0,0 @@
-/*.xml
-/*.1
-/*.html
-/*.exe
-/scalar
diff --git a/contrib/scalar/Makefile b/contrib/scalar/Makefile
deleted file mode 100644
index 8620042f281..00000000000
--- a/contrib/scalar/Makefile
+++ /dev/null
@@ -1,57 +0,0 @@
-QUIET_SUBDIR0  = +$(MAKE) -C # space to separate -C and subdir
-QUIET_SUBDIR1  =
-
-ifneq ($(findstring s,$(MAKEFLAGS)),s)
-ifndef V
-	QUIET_GEN      = @echo '   ' GEN $@;
-	QUIET_SUBDIR0  = +@subdir=
-	QUIET_SUBDIR1  = ;$(NO_SUBDIR) echo '   ' SUBDIR $$subdir; \
-			 $(MAKE) $(PRINT_DIR) -C $$subdir
-	QUIET          = @
-else
-	export V
-endif
-endif
-
-all:
-
-include ../../config.mak.uname
--include ../../config.mak.autogen
--include ../../config.mak
-
-TARGETS = scalar$(X) scalar.o
-GITLIBS = ../../common-main.o ../../libgit.a ../../xdiff/lib.a
-
-all: scalar$X ../../bin-wrappers/scalar
-
-$(GITLIBS):
-	$(QUIET_SUBDIR0)../.. $(QUIET_SUBDIR1) $(subst ../../,,$@)
-
-$(TARGETS): $(GITLIBS) scalar.c
-	$(QUIET_SUBDIR0)../.. $(QUIET_SUBDIR1) $(patsubst %,contrib/scalar/%,$@)
-
-clean:
-	$(RM) $(TARGETS) ../../bin-wrappers/scalar
-	$(RM) scalar.1 scalar.html scalar.xml
-
-../../bin-wrappers/scalar: ../../wrap-for-bin.sh Makefile
-	@mkdir -p ../../bin-wrappers
-	$(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
-	     -e 's|@@BUILD_DIR@@|$(shell cd ../.. && pwd)|' \
-	     -e 's|@@PROG@@|contrib/scalar/scalar$(X)|' < $< > $@ && \
-	chmod +x $@
-
-test: all
-	$(MAKE) -C t
-
-docs: scalar.html scalar.1
-
-scalar.html: | scalar.1 # prevent them from trying to build `doc.dep` in parallel
-
-scalar.html scalar.1: scalar.txt
-	$(QUIET_SUBDIR0)../../Documentation$(QUIET_SUBDIR1) \
-		MAN_TXT=../contrib/scalar/scalar.txt \
-		../contrib/scalar/$@
-	$(QUIET)test scalar.1 != "$@" || mv ../../Documentation/$@ .
-
-.PHONY: all clean docs test FORCE
diff --git a/contrib/scalar/t/Makefile b/contrib/scalar/t/Makefile
deleted file mode 100644
index 6170672bb37..00000000000
--- a/contrib/scalar/t/Makefile
+++ /dev/null
@@ -1,78 +0,0 @@
-# Run scalar tests
-#
-# Copyright (c) 2005,2021 Junio C Hamano, Johannes Schindelin
-#
-
--include ../../../config.mak.autogen
--include ../../../config.mak
-
-SHELL_PATH ?= $(SHELL)
-PERL_PATH ?= /usr/bin/perl
-RM ?= rm -f
-PROVE ?= prove
-DEFAULT_TEST_TARGET ?= test
-TEST_LINT ?= test-lint
-
-ifdef TEST_OUTPUT_DIRECTORY
-TEST_RESULTS_DIRECTORY = $(TEST_OUTPUT_DIRECTORY)/test-results
-else
-TEST_RESULTS_DIRECTORY = ../../../t/test-results
-endif
-
-# Shell quote;
-SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
-PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
-TEST_RESULTS_DIRECTORY_SQ = $(subst ','\'',$(TEST_RESULTS_DIRECTORY))
-
-T = $(sort $(wildcard t[0-9][0-9][0-9][0-9]-*.sh))
-
-all: $(DEFAULT_TEST_TARGET)
-
-test: $(TEST_LINT)
-	$(MAKE) aggregate-results-and-cleanup
-
-prove: $(TEST_LINT)
-	@echo "*** prove ***"; GIT_CONFIG=.git/config $(PROVE) --exec '$(SHELL_PATH_SQ)' $(GIT_PROVE_OPTS) $(T) :: $(GIT_TEST_OPTS)
-	$(MAKE) clean-except-prove-cache
-
-$(T):
-	@echo "*** $@ ***"; GIT_CONFIG=.git/config '$(SHELL_PATH_SQ)' $@ $(GIT_TEST_OPTS)
-
-clean-except-prove-cache:
-	$(RM) -r 'trash directory'.* '$(TEST_RESULTS_DIRECTORY_SQ)'
-	$(RM) -r valgrind/bin
-
-clean: clean-except-prove-cache
-	$(RM) .prove
-
-test-lint: test-lint-duplicates test-lint-executable test-lint-shell-syntax
-
-test-lint-duplicates:
-	@dups=`echo $(T) | tr ' ' '\n' | sed 's/-.*//' | sort | uniq -d` && \
-		test -z "$$dups" || { \
-		echo >&2 "duplicate test numbers:" $$dups; exit 1; }
-
-test-lint-executable:
-	@bad=`for i in $(T); do test -x "$$i" || echo $$i; done` && \
-		test -z "$$bad" || { \
-		echo >&2 "non-executable tests:" $$bad; exit 1; }
-
-test-lint-shell-syntax:
-	@'$(PERL_PATH_SQ)' ../../../t/check-non-portable-shell.pl $(T)
-
-aggregate-results-and-cleanup: $(T)
-	$(MAKE) aggregate-results
-	$(MAKE) clean
-
-aggregate-results:
-	for f in '$(TEST_RESULTS_DIRECTORY_SQ)'/t*-*.counts; do \
-		echo "$$f"; \
-	done | '$(SHELL_PATH_SQ)' ../../../t/aggregate-results.sh
-
-valgrind:
-	$(MAKE) GIT_TEST_OPTS="$(GIT_TEST_OPTS) --valgrind"
-
-test-results:
-	mkdir -p test-results
-
-.PHONY: $(T) aggregate-results clean valgrind
diff --git a/contrib/scalar/scalar.c b/scalar.c
similarity index 100%
rename from contrib/scalar/scalar.c
rename to scalar.c
diff --git a/contrib/scalar/t/t9099-scalar.sh b/t/t9099-scalar.sh
similarity index 94%
rename from contrib/scalar/t/t9099-scalar.sh
rename to t/t9099-scalar.sh
index 7e8771d0eff..f686ba5d84c 100755
--- a/contrib/scalar/t/t9099-scalar.sh
+++ b/t/t9099-scalar.sh
@@ -2,13 +2,7 @@
 
 test_description='test the `scalar` command'
 
-TEST_DIRECTORY=$PWD/../../../t
-export TEST_DIRECTORY
-
-# Make it work with --no-bin-wrappers
-PATH=$PWD/..:$PATH
-
-. ../../../t/test-lib.sh
+. ./test-lib.sh
 
 GIT_TEST_MAINT_SCHEDULER="crontab:test-tool crontab ../cron.txt"
 export GIT_TEST_MAINT_SCHEDULER
