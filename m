Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C65ACCA47C
	for <git@archiver.kernel.org>; Thu, 23 Jun 2022 10:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiFWK0n (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jun 2022 06:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbiFWK0l (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jun 2022 06:26:41 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D69149CB9
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 03:26:37 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id s1so27261560wra.9
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 03:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8smguBGp4bQuq15qikHwtyR3GwiLlzshM6Mcn4zIzm0=;
        b=H06Z6rquTt21rLQo9A7Fwpdcffg74UtW/SwO0G3hvVAuJWIVGRNsy+OuKnsDnfxmkP
         8hwDp/cTllYSKEfukkoTAM8lKbSc4GwN9XfcEr+VofCEu3V25n5tI9y8ZwdkzQYEGwku
         GKT5UipT63sJs7xwQ2x8+Pr1BoYTFa8okCGyztPsZlzVnpCsDrJKZHJLA62iWLY/Nv4n
         UhRpys+911S2myQWnywHpF0VqkgUaDFbvaMMEOVNEU3SGDbxbQiruuVNOAzC25pdPxqU
         vyhldCZg5Thi2lbURoT1Y/n3d/6gmlK9ZIujyWQXYsuAsBkFtHMhSB968sdI8g38CTSH
         VFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8smguBGp4bQuq15qikHwtyR3GwiLlzshM6Mcn4zIzm0=;
        b=uh8SQbXIGiLxk5mb5Cj5tTtRluYt7RABf8zkPlB7Nfsf9o39YsX+Yr96vAVhxbPnK6
         f/uhN0ggWyD8dkovepWygTJ/4Oh+0y4U9Gr+xZNeR4l9dxub82064T/etW/eFUsk8xHX
         vtVgxZNcy6478s1b0yjZTvjc5j6R6uHP5j4K4Q/5Oai4sYDxh4sJ7zI+7j67Jm6Lb0xV
         aUSYQ6FXw/NQ62lHGCZ3LePfwr8KLr/v8rf944ooLMVU0YUT0JOTeg2BoXR1/VXhSFv1
         bbWwH78GGrxaVAtnGKIWj1xgQ5xQ7Qc2Msrg/Be6/Hx1BcZHUZgzgdRV2YInu1uot4Ry
         FszQ==
X-Gm-Message-State: AJIora9qF1IeOARZrHdYvDbVFVtu8jVyBRPzEHBdw1GlxBglqpJOCRBE
        aVEsoUUKGd6Tady9uOf0PhFQgq/MjOphhQ==
X-Google-Smtp-Source: AGRyM1s4JlJuEW0PFX6RID90Z2YFa3B7k6ADSRWwAD4sir5BQHAiO0veT2OcIAZ+0gV320W11CXdNw==
X-Received: by 2002:a05:6000:1789:b0:219:cb95:79a6 with SMTP id e9-20020a056000178900b00219cb9579a6mr7562035wrg.353.1655979994686;
        Thu, 23 Jun 2022 03:26:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h30-20020adfaa9e000000b0020c7ec0fdf4sm26778865wrc.117.2022.06.23.03.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 03:26:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/1] scalar: move to the top-level, test, CI and "install" support
Date:   Thu, 23 Jun 2022 12:26:22 +0200
Message-Id: <cover-v2-0.1-00000000000-20220623T100554Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1239.gfba91521d90
In-Reply-To: <patch-1.1-86fb8d56307-20211028T185016Z-avarab@gmail.com>
References: <patch-1.1-86fb8d56307-20211028T185016Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This one-patch series integrates the "scalar" command to the
top-level, meaning we build the "scalar" binary by default, and run
its tests on "make test" and in CI. We'll also build and test its
documentation. We now also have "install" support, both for the
program and its docs, but you'll need to:

    make <install-target> INSTALL_SCALAR=Y

I'm sending this out now to avoid needless duplicate work. A recent
series attempted to integrate scalar into the CI[1], but it's now been
retracted[2]. As I'd discovered when I submitted the v1 of this[3]
integrating something like scalar "halfway" is much harder to do (see
e.g. the problems with [1] that I pointed out in [4]).

I then saw that Victoria Dye pushed out a WIP topic [5] with a patch
that's basically a subset of this one, but doesn't handle various
tough edge cases handled here (and this one fully passes CI
[6]). namely:

 * This adjusts the the "cmake" build, so VS build passes
 * This integrates with the documentation build, and targets like
   "check-docs"
 * This implements the optional "make install" support (much of which
   is predicated on getting the Documentation/ integration right)
 * This adds "scalar" to the command-list.txt, which has various
   positive downstream effects.

As in the v1 [3] this change proposed to create an "optionalcontrib"
category in the command-list.txt. The "scalar" command is put into
that category, and in "man git" we say:

	Optional contrib commands
	-------------------------

	The following commands are included with the git sources, but may not
	be present in your installation.

	These should be considered "contrib"-level when it comes to
	maintenance and stability promises. They might not even be included in
	your installation, and may either drastically change in the future, or
	go away entirely.

	include::cmds-optionalcontrib.txt[]

So I think this change allows us to have our cake and eat it too as
far as the "contrib status" of a program like "scalar" is
concerned. I.e. we're merely changing the internal source organization
here to avoid duplicate work during git.git maintenance, but it will
be made clear to users that this isn't a normal command, and it's not
installed by default.

I think it would make sense as a follow-up to consider moving
contrib/{diff-highlight,mw-to-git,subtree} to a similar
structure. I.e. they also carry copy/pasted "Makefile" infrastructure
in various ways, resulting in buggy integration with the rest
(e.g. try to run "make coverage" in a way that includes "git
subtree").

If what we want is to e.g. not install those by default, or even not
to run their tests or have them in CI by default as this change (and
previous discussion on the scalar topic) shows that's much easier than
bridging the other gaps.

1. https://lore.kernel.org/git/pull.1129.git.1654160735.gitgitgadget@gmail.com/
2. https://lore.kernel.org/git/nycvar.QRO.7.76.6.2206132246010.353@tvgsbejvaqbjf.bet/
3. https://lore.kernel.org/git/patch-1.1-86fb8d56307-20211028T185016Z-avarab@gmail.com/
4. https://lore.kernel.org/git/220602.86ee07z6qb.gmgdl@evledraar.gmail.com/
5. https://github.com/vdye/git/tree/feature/scalar-toplevel
6. https://github.com/avar/git/actions/runs/2541684143

Ævar Arnfjörð Bjarmason (1):
  scalar: reorganize from contrib/, still keep it "a contrib command"

 .gitignore                                    |  1 +
 Documentation/Makefile                        |  4 +
 Documentation/cmd-list.perl                   |  2 +-
 Documentation/git.txt                         | 12 +++
 {contrib/scalar => Documentation}/scalar.txt  |  4 +-
 Makefile                                      | 57 +++++++++----
 command-list.txt                              |  2 +
 contrib/buildsystems/CMakeLists.txt           | 15 +++-
 contrib/scalar/.gitignore                     |  2 -
 contrib/scalar/Makefile                       | 35 --------
 contrib/scalar/t/Makefile                     | 81 -------------------
 contrib/scalar/scalar.c => scalar.c           |  0
 .../t/t9099-scalar.sh => t/t7990-scalar.sh    |  8 +-
 13 files changed, 79 insertions(+), 144 deletions(-)
 rename {contrib/scalar => Documentation}/scalar.txt (99%)
 delete mode 100644 contrib/scalar/.gitignore
 delete mode 100644 contrib/scalar/Makefile
 delete mode 100644 contrib/scalar/t/Makefile
 rename contrib/scalar/scalar.c => scalar.c (100%)
 rename contrib/scalar/t/t9099-scalar.sh => t/t7990-scalar.sh (96%)

Range-diff against v1:
1:  86fb8d56307 ! 1:  9743e2a1e6a contrib: build & test scalar by default, optionally install
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    contrib: build & test scalar by default, optionally install
    -
    -    Change how the newly proposed "scalar" command is handle, this builds
    -    on top of the proposed patches that add it along with documentation
    -    and tests to the "contrib/scalar/" directory[1].
    -
    -    With those patches we unconditionally build scalar.o and link it to
    -    libgit.a, but don't build the "scalar" binary itself, and don't run
    -    its tests as part of our normal test suite run or CI.
    -
    -    As the changes to "t/t9099-scalar.sh" here shows that sort of
    -    arrangement leads to breakages. I.e. the scalar tests would fail on
    -    OSX, which our OSX CI jobs will catch, but only if we run the
    -    tests. Let's add a prerequisite to test that, which requires moving
    -    around some of the setup code.
    -
    -    I think that for a libgit.a-using "scalar" in particular, and for
    -    "contrib" in general we're better off by not only compiling the object
    -    in question, but also linking it, and running its tests by
    -    default. What we won't do is install it by default, unless an
    -    "INSTALL_SCALAR=Y" is provided along with "make install".
    -
    -    For context: There's been ongoing discussion about how this command
    -    should be integrated in terms of the "closeness" of its integration,
    -    and how "contrib" sources within git.git should be organized.
    -
    -    That discussion started with my [2], was followed by a WIP patch[3] to
    -    implement the approach being finished up here, and has spawned the
    +    scalar: reorganize from contrib/, still keep it "a contrib command"
    +
    +    Change the optional scalar command added in 0a43fb22026 (scalar:
    +    create a rudimentary executable, 2021-12-03) so that it builds, tests
    +    and CI's with our usual build and testing process, but is still kept
    +    "a contrib command" in how we talk about it in our documentation.
    +
    +    Before this change we've been building scalar.o in CI as part of the
    +    "static-analysis" job, we'll now build the full binary, and run its
    +    tests. We won't install it unless "INSTALL_SCALAR=Y" is provided to
    +    the Makefile. Before this change there was no "make install" step for
    +    the "scalar" binary at all.
    +
    +    Before this we needed a significant amount of Makefile boilerplate to
    +    do something that the top-level Makefile could do with relatively
    +    little work, and by doing so we'll get the advantage of testing and
    +    CI-ing the scalar command along with our other commands.
    +
    +    The recent [1] shows a (now retracted, see [2]) series to integrate
    +    scalar with CI while it still lived in contrib/*. For context: There's
    +    been past discussion about how this command should be integrated in
    +    terms of the "closeness" of its integration, and how "contrib" sources
    +    within git.git should be organized.
    +
    +    That discussion started with my [3], was followed by a WIP patch[4] to
    +    implement the approach being finished up here, which prompted the
         "[Discussion] The architecture of Scalar (and others) within Git"
    -    thread[4]. See also the large earlier discussion hanging off [3].
    +    thread[4]. See also the large earlier discussion hanging off [4]. An
    +    earlier version of this change was proposed at [6].
     
    -    I really don't think it's important whether a given source file lives
    -    in-tree at "contrib/scalar/scalar.c" or the top-level "scalar.c", but
    -    as the diff below shows the latter approach is a smaller overall
    -    change in our build system, due to how it's organized, more details on
    -    that below under "Build changes".
    -
    -    I think that part of the reason for sticking the new command in
    -    "contrib/scalar/" was to implicitly make it clear from the paths that
    -    it was different. I do think that would be a worthwhile goal in the
    -    abstract.
    +    Part of the reason for sticking the new command in "contrib/scalar/"
    +    was to implicitly make it clear from the paths that it was
    +    different. I do think that would be a worthwhile goal in the abstract.
     
         But given the build simplifications we can attain by moving it to the
         top level that we should seek to resolve that ambiguity in the minds
    @@ Commit message
         git's own documentation, along with the full list of porcelain and
         plumbing utilities.
     
    -    = Build changes =
    -
    -    This fixes dependency bugs in the previous "contrib/scalar/Makefile", as
    -    well as implementing various missing bits of functionality, most
    -    notably "make install" will now install the "scalar" command, but only
    -    if INSTALL_SCALAR is defined.
    -
    -    Those and other changes and non-changes, categorized as "Same", "New"
    -    and "Fixed" below:
    -
    -    == Same ==
    -
    -    A.: We'll unconditionally build scalar.o, as before it's in the
    -        $(OBJECTS) list.
    -
    -    B.: "make contrib/scalar/scalar.o" has the same dependency graph as
    -        before, but is now spelled "make scalar.o", more on the rename below.
    +    Commentary on changes in specific sub-components:
     
    -    == New ==
    -
    -    C.: We'll now unconditionally build and test the scalar command.
    -    Before we'd only build scalar.o, but not link it.
    -
    -        Its test lives in "t/t9099-scalar.sh" now (and take <1s to
    -        run). We should have test coverage of this in-tree command that's
    -        linking to libgit.a.
    +    A.: The tests now live in "t/t7990-scalar.sh" (per the naming guide in
    +        t/README).
     
             Previously it had to be manually tested by cd-ing to
             contrib/scalar and running "make test", and it would not benefit
             from the combination of our various CI targets.
     
    +    B.: The "Documentation/cmd-list.perl" change is needed because that
    +        command wasn't capable of understanding commands in the
    +        command-list.txt whose name didn't start with "git".
    +
    +        If we don't make this change we won't cross-link to "scalar(1)"
    +        from "OPTIONAL CONTRIB COMMANDS" in "git(1)".
    +
    +    C. We'll always mention scalar in "OPTIONAL CONTRIB COMMANDS" in
    +       "git(1)", but the "scalar(1)" manpage itself depends on whether we
    +       build with "INSTALL_SCALAR=Y".
    +
         D.: We'll unconditionally build scalar's documentation, and it will be
             linted along with the rest, including checking for broken links to
             other documentation.
    @@ Commit message
             been fixable, but as shown in the rest of this patch it's easier
             just to have scalar built like any other program instead.
     
    -    == Discussion and motivation ==
    -
    -    I've been fixing various dependency issues in git's Makefile
    -    infrastructure recently, some of which has been integrated into
    -    "master", some of which is currently under review on-list, and some of
    -    which isn't submitted yet.
    -
    -    To the extent that we have build dependency issues and cases where we
    -    can't build something in parallel it's usually because we're invoking
    -    one Makefile from another. That's the case in most of our
    -    sub-Makefiles, which will usually need to invoke or depend on
    -    something created in the top-level Makefile.
    -
    -    None of {t,Documentation,template}/Makefile etc. are truly
    -    independent, as looking at $(git grep -F '../' '*Makefile') will
    -    reveal, and we'll sometimes need to duplicate logic between them
    -    purely to get around them not being driven by one top-level Makefile
    -    logic.
    -
    -    Much has been written on this topic, likely most notably the
    -    "Recursive Make Considered Harmful" paper (full PDF link at [5]), and
    -    to be fair, the there's also a well-known "Non-recursive Make
    -    Considered Harmful" retort at [6]).
    -
    -    Theoretical opinions on the topic clearly differ. From a purely
    -    practical perspective I ran into textual and semantic conflicts with
    -    the "contrib/scalar/" work.
    -
    -    I think the diffstat of this patch demonstrates that this is a much
    -    simpler approach, particularly considering that the code being
    -    replaced didn't perform much of the needed integrations that are "new"
    -    here. E.g. we now have "make install". The unsubmitted [7] (linked to
    -    by [8]) shows the boilerplate we'd need for that with the alternate
    -    approach.
    -
    -    It would be more pleasing to not have to hardcode "git" in the
    -    pre-image and now "git" and "scalar" in the post-image in several
    -    places. My initial WIP [3] looks better, but built on a set of
    -    Makefile reorganization patches.
    -
    -    I'd like to not make those patches a dependency of this change, but
    -    readers should rest assured that we're really not ending up with as
    -    many "scalar" special-cases in the long term as this diff indicates,
    -    most or all of those can all be generalized into Makefile refactoring
    -    that teaches our build system to build N number of differently named
    -    top-level commands.
    -
    -    1. https://lore.kernel.org/git/pull.1005.v6.git.1635323239.gitgitgadget@gmail.com/
    -    2. https://lore.kernel.org/git/87czpuxbwp.fsf@evledraar.gmail.com/
    -    3. https://lore.kernel.org/git/87ilz44kdk.fsf@evledraar.gmail.com/
    -    4. https://lore.kernel.org/git/b67bbef4-e4c3-b6a7-1c7f-7d405902ef8b@gmail.com/
    -    5. https://web.archive.org/web/20150330111905/http://miller.emu.id.au/pmiller/books/rmch/
    -    6. https://www.microsoft.com/en-us/research/wp-content/uploads/2016/03/hadrian.pdf
    -    7. https://github.com/dscho/git/commit/473ca8ae673
    -    8. https://lore.kernel.org/git/nycvar.QRO.7.76.6.2110210947590.56@tvgsbejvaqbjf.bet/
    +    1. https://lore.kernel.org/git/220602.86ee07z6qb.gmgdl@evledraar.gmail.com/
    +    2. https://lore.kernel.org/git/nycvar.QRO.7.76.6.2206132246010.353@tvgsbejvaqbjf.bet/
    +    3. https://lore.kernel.org/git/87czpuxbwp.fsf@evledraar.gmail.com/
    +    4. https://lore.kernel.org/git/87ilz44kdk.fsf@evledraar.gmail.com/
    +    5. https://lore.kernel.org/git/b67bbef4-e4c3-b6a7-1c7f-7d405902ef8b@gmail.com/
    +    6: https://lore.kernel.org/git/patch-1.1-86fb8d56307-20211028T185016Z-avarab@gmail.com/
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ Documentation/scalar.txt: SEE ALSO
     +Part of the linkgit:git[1] suite
     
      ## Makefile ##
    -@@ Makefile: all::
    +@@ Makefile: include shared.mak
      # INSTALL_STRIP can be set to "-s" to strip binaries during installation,
      # if your $(INSTALL) command supports the option.
      #
    @@ Makefile: GIT_OBJS =
     +OTHER_PROGRAMS =
      PROGRAMS =
      EXCLUDED_PROGRAMS =
    -+SCALAR_OBJS =
      SCRIPT_PERL =
    - SCRIPT_PYTHON =
    - SCRIPT_SH =
     @@ Makefile: BUILT_INS += git-switch$X
      BUILT_INS += git-whatchanged$X
      
    @@ Makefile: BINDIR_PROGRAMS_NEED_X += git-shell
      BINDIR_PROGRAMS_NO_X += git-cvsserver
      
      # Set paths to tools early so that they can be used for version tests.
    -@@ Makefile: git.sp git.s git.o: EXTRA_CPPFLAGS = \
    - 	'-DGIT_MAN_PATH="$(mandir_relative_SQ)"' \
    - 	'-DGIT_INFO_PATH="$(infodir_relative_SQ)"'
    - 
    --git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
    --	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
    --		$(filter %.o,$^) $(LIBS)
    -+define top-level-cmd-rule
    -+$(1)$X: $(1).o GIT-LDFLAGS $$(GITLIBS) $(2)
    -+	$$(QUIET_LINK)$$(CC) $$(ALL_CFLAGS) -o $$@ $$(ALL_LDFLAGS) \
    -+		$$(filter %.o,$$^) $(LIBS)
    -+endef
    -+$(eval $(call top-level-cmd-rule,git,$(BUILTIN_OBJS)))
    -+$(eval $(call top-level-cmd-rule,scalar,))
    - 
    - help.sp help.s help.o: command-list.h
    - hook.sp hook.s hook.o: hook-list.h
    -@@ Makefile: GIT_OBJS += git.o
    - .PHONY: git-objs
    - git-objs: $(GIT_OBJS)
    - 
    -+SCALAR_OBJS += scalar.o
    -+.PHONY: scalar-objs
    -+scalar-objs: $(SCALAR_OBJS)
    -+
    - OBJECTS += $(GIT_OBJS)
    -+OBJECTS += $(SCALAR_OBJS)
    - OBJECTS += $(PROGRAM_OBJS)
    - OBJECTS += $(TEST_OBJS)
    - OBJECTS += $(XDIFF_OBJS)
     @@ Makefile: ifndef NO_CURL
      	OBJECTS += http.o http-walker.o remote-curl.o
      endif
      
     -SCALAR_SOURCES := contrib/scalar/scalar.c
    --SCALAR_OBJECTS := $(SCALAR_SOURCES:c=o)
    --OBJECTS += $(SCALAR_OBJECTS)
    --
    - .PHONY: objects
    - objects: $(OBJECTS)
    ++SCALAR_SOURCES := scalar.c
    + SCALAR_OBJECTS := $(SCALAR_SOURCES:c=o)
    + OBJECTS += $(SCALAR_OBJECTS)
      
     @@ Makefile: $(REMOTE_CURL_PRIMARY): remote-curl.o http.o http-walker.o GIT-LDFLAGS $(GITLIBS
      	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
      		$(CURL_LIBCURL) $(EXPAT_LIBEXPAT) $(LIBS)
      
     -contrib/scalar/scalar$X: $(SCALAR_OBJECTS) GIT-LDFLAGS $(GITLIBS)
    --	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
    --		$(filter %.o,$^) $(LIBS)
    --
    - $(LIB_FILE): $(LIB_OBJS)
    - 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
    ++scalar$X: $(SCALAR_OBJECTS) GIT-LDFLAGS $(GITLIBS)
    + 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
    + 		$(filter %.o,$^) $(LIBS)
      
     @@ Makefile: GIT-PYTHON-VARS: FORCE
                  fi
    @@ Makefile: GIT-PYTHON-VARS: FORCE
     +# bin-wrappers/*
     +GIT_TEST_BINDIR_PROGRAMS_NEED_X = $(filter-out scalar,$(TEST_BINDIR_PROGRAMS_NEED_X))
      bin-wrappers/%: wrap-for-bin.sh
    - 	@mkdir -p bin-wrappers
    + 	$(call mkdir_p_parent_template)
      	$(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
      	     -e 's|@@BUILD_DIR@@|$(shell pwd)|' \
     -	     -e 's|@@PROG@@|$(patsubst test-%,t/helper/test-%$(X),$(@F))$(patsubst git%,$(X),$(filter $(@F),$(BINDIR_PROGRAMS_NEED_X)))|' < $< > $@ && \
    @@ Makefile: endif
      install-gitweb:
      	$(MAKE) -C gitweb install
      
    --install-doc: install-man-perl
    --	$(MAKE) -C Documentation install
    --
    --install-man: install-man-perl
    --	$(MAKE) -C Documentation install-man
    -+ifdef INSTALL_SCALAR
    ++# We must not "export" this as e.g. "check-docs" needs to know about
    ++# scalar.txt. We only exclude scalar.txt for the "install-*" targets.
     +NO_INSTALL_SCALAR_DOC =
    -+else
    ++ifndef INSTALL_SCALAR
     +NO_INSTALL_SCALAR_DOC = NoScalarPlease
     +endif
    ++
    + install-doc: install-man-perl
    +-	$(MAKE) -C Documentation install
    ++	$(MAKE) -C Documentation install NO_INSTALL_SCALAR_DOC='$(NO_INSTALL_SCALAR_DOC)'
    + 
    + install-man: install-man-perl
    +-	$(MAKE) -C Documentation install-man
    ++	$(MAKE) -C Documentation install-man NO_INSTALL_SCALAR_DOC='$(NO_INSTALL_SCALAR_DOC)'
      
      install-man-perl: man-perl
      	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(mandir_SQ)/man3'
    - 	(cd perl/build/man/man3 && $(TAR) cf - .) | \
    +@@ Makefile: install-man-perl: man-perl
      	(cd '$(DESTDIR_SQ)$(mandir_SQ)/man3' && umask 022 && $(TAR) xof -)
      
    --install-html:
    + install-html:
     -	$(MAKE) -C Documentation install-html
    --
    --install-info:
    ++	$(MAKE) -C Documentation install-html NO_INSTALL_SCALAR_DOC='$(NO_INSTALL_SCALAR_DOC)'
    + 
    + install-info:
     -	$(MAKE) -C Documentation install-info
    --
    --install-pdf:
    ++	$(MAKE) -C Documentation install-info NO_INSTALL_SCALAR_DOC='$(NO_INSTALL_SCALAR_DOC)'
    + 
    + install-pdf:
     -	$(MAKE) -C Documentation install-pdf
    -+define install-doc-rule
    -+$(1): $(3)
    -+	$$(MAKE) -C Documentation $(2) NO_INSTALL_SCALAR_DOC=$$(NO_INSTALL_SCALAR_DOC)
    -+endef
    -+$(eval $(call install-doc-rule,install-doc,install,install-man-perl))
    -+$(eval $(call install-doc-rule,install-man,install-man,install-man-perl))
    -+$(eval $(call install-doc-rule,install-html,install-html,))
    -+$(eval $(call install-doc-rule,install-info,install-info,))
    -+$(eval $(call install-doc-rule,install-pdf,install-pdf,))
    ++	$(MAKE) -C Documentation install-pdf NO_INSTALL_SCALAR_DOC='$(NO_INSTALL_SCALAR_DOC)'
      
      quick-install-doc:
    - 	$(MAKE) -C Documentation quick-install
    -@@ Makefile: ifneq ($(INCLUDE_DLLS_IN_ARTIFACTS),)
    - OTHER_PROGRAMS += $(shell echo *.dll t/helper/*.dll)
    - endif
    +-	$(MAKE) -C Documentation quick-install
    ++	$(MAKE) -C Documentation quick-install NO_INSTALL_SCALAR_DOC='$(NO_INSTALL_SCALAR_DOC)'
    + 
    + quick-install-man:
    +-	$(MAKE) -C Documentation quick-install-man
    ++	$(MAKE) -C Documentation quick-install-man NO_INSTALL_SCALAR_DOC='$(NO_INSTALL_SCALAR_DOC)'
    + 
    + quick-install-html:
    +-	$(MAKE) -C Documentation quick-install-html
    ++	$(MAKE) -C Documentation quick-install-html NO_INSTALL_SCALAR_DOC='$(NO_INSTALL_SCALAR_DOC)'
    + 
    + 
      
    --artifacts-tar:: $(ALL_COMMANDS_TO_INSTALL) $(SCRIPT_LIB) $(OTHER_PROGRAMS) \
    --		GIT-BUILD-OPTIONS $(TEST_PROGRAMS) $(test_bindir_programs) \
    -+# No scalar in "cmake" yet, and since 4c2c38e800f (ci: modification of
    -+# main.yml to use cmake for vs-build job, 2020-06-26) the "vs-build"
    -+# job has a hard dependency on it. Let's fail in the tests instead of
    -+# in the "vs-build" job itself.
    -+ifeq ($(wildcard scalar),scalar)
    -+ARCHIVE_OTHER_PROGRAMS = $(OTHER_PROGRAMS)
    -+ARCHIVE_TEST_BINDIR_PROGRAMS = $(test_bindir_programs)
    -+else
    -+ARCHIVE_OTHER_PROGRAMS = $(filter-out scalar%, $(OTHER_PROGRAMS))
    -+ARCHIVE_TEST_BINDIR_PROGRAMS = $(filter-out bin-wrappers/scalar,$(test_bindir_programs))
    -+endif
    -+artifacts-tar:: $(ALL_COMMANDS_TO_INSTALL) $(SCRIPT_LIB) $(ARCHIVE_OTHER_PROGRAMS) \
    -+		GIT-BUILD-OPTIONS $(TEST_PROGRAMS) $(ARCHIVE_TEST_BINDIR_PROGRAMS) \
    - 		$(MOFILES)
    - 	$(QUIET_SUBDIR0)templates $(QUIET_SUBDIR1) \
    - 		SHELL_PATH='$(SHELL_PATH_SQ)' PERL_PATH='$(PERL_PATH_SQ)'
     @@ Makefile: check-docs::
      		    -e 's/\.txt//'; \
      	) | while read how cmd; \
    @@ command-list.txt
      #
      # The type names are self explanatory. But if you want to see what
      # command belongs to what group to get a better picture, have a look
    -@@ command-list.txt: gitsubmodules                           guide
    +@@ command-list.txt: gittutorial                             guide
      gittutorial-2                           guide
    - gittutorial                             guide
    + gitweb                                  ancillaryinterrogators
      gitworkflows                            guide
     +scalar                                  optionalcontrib
     
    + ## contrib/buildsystems/CMakeLists.txt ##
    +@@ contrib/buildsystems/CMakeLists.txt: unset(CMAKE_REQUIRED_INCLUDES)
    + #programs
    + set(PROGRAMS_BUILT
    + 	git git-daemon git-http-backend git-sh-i18n--envsubst
    +-	git-shell)
    ++	git-shell
    ++	scalar)
    + 
    + if(NOT CURL_FOUND)
    + 	list(APPEND excluded_progs git-http-fetch git-http-push)
    +@@ contrib/buildsystems/CMakeLists.txt: list(TRANSFORM git_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
    + add_executable(git ${CMAKE_SOURCE_DIR}/git.c ${git_SOURCES})
    + target_link_libraries(git common-main)
    + 
    ++add_executable(scalar ${CMAKE_SOURCE_DIR}/scalar.c)
    ++target_link_libraries(scalar common-main)
    ++
    + add_executable(git-daemon ${CMAKE_SOURCE_DIR}/daemon.c)
    + target_link_libraries(git-daemon common-main)
    + 
    +@@ contrib/buildsystems/CMakeLists.txt: list(TRANSFORM git_shell_scripts PREPEND "${CMAKE_BINARY_DIR}/")
    + list(TRANSFORM git_perl_scripts PREPEND "${CMAKE_BINARY_DIR}/")
    + 
    + #install
    ++option(INSTALL_SCALAR "Install the optional 'scalar' contrib command")
    + foreach(program ${PROGRAMS_BUILT})
    + if(program STREQUAL "git" OR program STREQUAL "git-shell")
    + install(TARGETS ${program}
    + 	RUNTIME DESTINATION bin)
    ++elseif(program STREQUAL "scalar")
    ++if(INSTALL_SCALAR)
    ++install(TARGETS ${program}
    ++	RUNTIME DESTINATION bin)
    ++endif()
    + else()
    + install(TARGETS ${program}
    + 	RUNTIME DESTINATION libexec/git-core)
    +@@ contrib/buildsystems/CMakeLists.txt: endif()
    + 
    + #wrapper scripts
    + set(wrapper_scripts
    +-	git git-upload-pack git-receive-pack git-upload-archive git-shell git-remote-ext)
    ++	git git-upload-pack git-receive-pack git-upload-archive git-shell git-remote-ext
    ++	scalar)
    + 
    + set(wrapper_test_scripts
    + 	test-fake-ssh test-tool)
    +
      ## contrib/scalar/.gitignore (deleted) ##
     @@
    --/*.xml
    --/*.1
    --/*.html
     -/*.exe
     -/scalar
     
      ## contrib/scalar/Makefile (deleted) ##
     @@
    --QUIET_SUBDIR0  = +$(MAKE) -C # space to separate -C and subdir
    --QUIET_SUBDIR1  =
    --
    --ifneq ($(findstring s,$(MAKEFLAGS)),s)
    --ifndef V
    --	QUIET_GEN      = @echo '   ' GEN $@;
    --	QUIET_SUBDIR0  = +@subdir=
    --	QUIET_SUBDIR1  = ;$(NO_SUBDIR) echo '   ' SUBDIR $$subdir; \
    --			 $(MAKE) $(PRINT_DIR) -C $$subdir
    --	QUIET          = @
    --else
    --	export V
    --endif
    --endif
    +-# The default target of this Makefile is...
    +-all::
     -
    --all:
    +-# Import tree-wide shared Makefile behavior and libraries
    +-include ../../shared.mak
     -
     -include ../../config.mak.uname
     --include ../../config.mak.autogen
    @@ contrib/scalar/Makefile (deleted)
     -TARGETS = scalar$(X) scalar.o
     -GITLIBS = ../../common-main.o ../../libgit.a ../../xdiff/lib.a
     -
    --all: scalar$(X) ../../bin-wrappers/scalar
    +-all:: scalar$(X) ../../bin-wrappers/scalar
     -
     -$(GITLIBS):
     -	$(QUIET_SUBDIR0)../.. $(QUIET_SUBDIR1) $(subst ../../,,$@)
    @@ contrib/scalar/Makefile (deleted)
     -
     -clean:
     -	$(RM) $(TARGETS) ../../bin-wrappers/scalar
    --	$(RM) scalar.1 scalar.html scalar.xml
     -
     -../../bin-wrappers/scalar: ../../wrap-for-bin.sh Makefile
     -	@mkdir -p ../../bin-wrappers
    @@ contrib/scalar/Makefile (deleted)
     -test: all
     -	$(MAKE) -C t
     -
    --docs: scalar.html scalar.1
    --
    --scalar.html: | scalar.1 # prevent them from trying to build `doc.dep` in parallel
    --
    --scalar.html scalar.1: scalar.txt
    --	$(QUIET_SUBDIR0)../../Documentation$(QUIET_SUBDIR1) \
    --		MAN_TXT=../contrib/scalar/scalar.txt \
    --		../contrib/scalar/$@
    --	$(QUIET)test scalar.1 != "$@" || mv ../../Documentation/$@ .
    --
    --.PHONY: $(GITLIBS) all clean docs test FORCE
    +-.PHONY: $(GITLIBS) all clean test FORCE
     
      ## contrib/scalar/t/Makefile (deleted) ##
     @@
    +-# Import tree-wide shared Makefile behavior and libraries
    +-include ../../../shared.mak
    +-
     -# Run scalar tests
     -#
     -# Copyright (c) 2005,2021 Junio C Hamano, Johannes Schindelin
    @@ contrib/scalar/t/Makefile (deleted)
     
      ## contrib/scalar/scalar.c => scalar.c ##
     
    - ## contrib/scalar/t/t9099-scalar.sh => t/t9099-scalar.sh ##
    + ## contrib/scalar/t/t9099-scalar.sh => t/t7990-scalar.sh ##
     @@
      
      test_description='test the `scalar` command'
      
     -TEST_DIRECTORY=$PWD/../../../t
     -export TEST_DIRECTORY
    -+. ./test-lib.sh
    - 
    +-
     -# Make it work with --no-bin-wrappers
     -PATH=$PWD/..:$PATH
     -
     -. ../../../t/test-lib.sh
    -+if test_have_prereq WINDOWS && ! scalar list 2>/dev/null
    -+then
    -+	skip_all='the contrib cmake process does not build "scalar" yet'
    -+	test_done
    -+fi
    ++. ./test-lib.sh
      
    - GIT_TEST_MAINT_SCHEDULER="crontab:test-tool crontab ../cron.txt"
    + GIT_TEST_MAINT_SCHEDULER="crontab:test-tool crontab ../cron.txt,launchctl:true,schtasks:true"
      export GIT_TEST_MAINT_SCHEDULER
    -@@ t/t9099-scalar.sh: test_expect_success 'scalar shows a usage' '
    - 	test_expect_code 129 scalar -h
    - '
    - 
    --test_expect_success 'scalar unregister' '
    -+test_expect_success 'setup' '
    -+	test_commit first &&
    -+	test_commit second &&
    -+	test_commit third &&
    -+	git switch -c parallel first
    -+'
    -+
    -+test_lazy_prereq SCALAR_REGISTER '
    -+	git init test/src &&
    -+	scalar register test/src &&
    -+	scalar list >expect &&
    -+	scalar unregister test/src &&
    -+	(cd test/src && echo "$PWD") >actual &&
    -+	test_cmp expect actual
    -+'
    -+
    -+test_expect_success SCALAR_REGISTER 'scalar unregister' '
    - 	git init vanish/src &&
    - 	scalar register vanish/src &&
    - 	git config --get --global --fixed-value \
    -@@ t/t9099-scalar.sh: test_expect_success 'scalar unregister' '
    - 	! grep -F "$(pwd)/vanish/src" scalar.repos
    - '
    - 
    --test_expect_success 'set up repository to clone' '
    --	test_commit first &&
    --	test_commit second &&
    --	test_commit third &&
    --	git switch -c parallel first &&
    -+test_expect_success SCALAR_REGISTER 'set up repository to clone' '
    - 	mkdir -p 1/2 &&
    - 	test_commit 1/2/3 &&
    - 	git config uploadPack.allowFilter true &&
    - 	git config uploadPack.allowAnySHA1InWant true
    - '
    - 
    --test_expect_success 'scalar clone' '
    -+test_expect_success SCALAR_REGISTER 'scalar clone' '
    - 	second=$(git rev-parse --verify second:second.t) &&
    - 	scalar clone "file://$(pwd)" cloned --single-branch &&
    - 	(
    -@@ t/t9099-scalar.sh: test_expect_success 'scalar clone' '
    - 	)
    - '
    - 
    --test_expect_success 'scalar reconfigure' '
    -+test_expect_success SCALAR_REGISTER 'scalar reconfigure' '
    - 	git init one/src &&
    - 	scalar register one &&
    - 	git -C one/src config core.preloadIndex false &&
    -@@ t/t9099-scalar.sh: test_expect_success 'scalar delete without enlistment shows a usage' '
    - 	test_expect_code 129 scalar delete
    - '
    - 
    --test_expect_success 'scalar delete with enlistment' '
    -+test_expect_success SCALAR_REGISTER 'scalar delete with enlistment' '
    - 	scalar delete cloned &&
    - 	test_path_is_missing cloned
    - '
-- 
2.36.1.1239.gfba91521d90

