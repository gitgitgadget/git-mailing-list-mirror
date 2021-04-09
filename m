Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4EBC43460
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 15:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E8F961056
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 15:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234043AbhDIPDP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 11:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbhDIPDM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 11:03:12 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718B3C061760
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 08:02:57 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id w7-20020a1cdf070000b0290125f388fb34so2417573wmg.0
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 08:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j9JY/jgNQtWddEX0Jzv7g/sVch3YV0AUNVEPJhRm+hA=;
        b=h4n1sApSeiRy/d3jZyEjGZIrQwQqRsSF4jxb0fQFKHOJyny+5B+KDa9wUDBlqjFvuo
         q28nQvuDS940L850DJeUl1AnBcUXfWBzf5IElOeaBWPpIKao7K+pf6NgoE9jBr47YF4d
         tkL5rfxUXPkm1hXXVZygTTkJYmkAsC/P/QiJ1hcaR2zBPv3847aA21C8q2YghoMwGxv+
         L32Y+X+Cudlc2KdVoTn7jD9towMuBJFth2avvzWdLyeQDuybCS4/bVvnpz01gEb/PJBI
         s4E+G92XuUEr6CMf2TzazamLnhlYd7DizYNzSl+3VuqqGrTZGf/HJH8RvmFnCfhhlUfF
         hpkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j9JY/jgNQtWddEX0Jzv7g/sVch3YV0AUNVEPJhRm+hA=;
        b=bgXTjS/MJHeevHSLSFoBkZxPhUCBE+O9FsPkjYEWkspZqd3iTQmopwxT8idSIuBGSC
         s9J7Plo6OjZ8Fc29DGRiZ9C5lthiJZxMDLnQWNblQcYxtOQiC0IwGOM3DIVFCgsGL1SI
         kyDRyGEXPwGCSbvcfZSW3MgDSL86hoZevgoMcd3kCSIR5taK5h017jwcfmbeuGSY2m4F
         HNew0UEmll4r3nDWNc2pVuDsJJJ9GB/70EbDKy03dX1Dt5nfHvJc2p8APNiPM6nlNIzj
         FrkrTh0cxqC+Qkcf+WmDO53UmfIEi22tDzde0ak6zYh8FOMMVTF5GSlV8fGdTHK8eejT
         yQzw==
X-Gm-Message-State: AOAM532f2ET6w4+5QdKg1MRa/CR31L3VN/IIpcoLiXjx+tuanKFWOKK5
        rwq8C1Gb5NhPHMHEDQsYVxjLkZ2j+dCN9w==
X-Google-Smtp-Source: ABdhPJyZe7CuAD27GGbHCyNNQp9jOQhwypX3BHSd6oPpkTlBiDcS+hquCuQfqkPHVhG0l5e1tOJ73Q==
X-Received: by 2002:a7b:c312:: with SMTP id k18mr14508403wmj.89.1617980575305;
        Fri, 09 Apr 2021 08:02:55 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l4sm4334022wmh.8.2021.04.09.08.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 08:02:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/7] doc make and lint fixes
Date:   Fri,  9 Apr 2021 17:02:43 +0200
Message-Id: <cover-0.7-0000000000-20210409T145728Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.622.g1b8cc22e65
In-Reply-To: <cover-0.6-00000000000-20210326T103454Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210326T103454Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lint for and fix the three manual pages that were missing the standard
"Part of the linkgit:git[1] suite" end section.

Addresses the feedback on v1, in particular stylistic / variable
naming choices. I just went with all the suggestions.

I've added two new patches at the end to detect (and in 7/7 fix)
issues with "standard" sections like NAME, SYNOPSIS, OPTIONS etc. that
are out of order, e.g. git-mktag was one of two manual pages that
OPTIONS before DESCRIPTION. Those and a few other such oddities are
now fixed.

I've got a follow-up series to finish the work I started a while ago
of including the relevant git config variable descriptions in the
respective manual pages, e.g. now we have gc.* variables in git-gc(1),
but not in all manual pages. We'll hopefully consistently have that
everywhere soon, and this "sections in the right order" lint was very
useful to check those patches.

Ævar Arnfjörð Bjarmason (7):
  Documentation/Makefile: make $(wildcard howto/*.txt) a var
  Documentation/Makefile: make doc.dep dependencies a variable again
  doc lint: Perl "strict" and "warnings" in lint-gitlink.perl
  doc lint: fix bugs in, simplify and improve lint script
  doc lint: lint and fix missing "GIT" end sections
  doc lint: lint relative section order
  docs: fix linting issues due to incorrect relative section order

 Documentation/Makefile                    |  23 ++++-
 Documentation/git-credential.txt          |   4 +
 Documentation/git-cvsserver.txt           |  24 ++---
 Documentation/git-grep.txt                |  64 ++++++-------
 Documentation/git-mktag.txt               |  16 ++--
 Documentation/git-p4.txt                  |   4 +
 Documentation/git-rebase.txt              |  12 +--
 Documentation/git-svn.txt                 |  38 ++++----
 Documentation/gitnamespaces.txt           |   4 +
 Documentation/lint-gitlink.perl           | 108 +++++++++++-----------
 Documentation/lint-man-end-blurb.perl     |  24 +++++
 Documentation/lint-man-section-order.perl | 105 +++++++++++++++++++++
 12 files changed, 288 insertions(+), 138 deletions(-)
 create mode 100755 Documentation/lint-man-end-blurb.perl
 create mode 100755 Documentation/lint-man-section-order.perl

Range-diff against v1:
1:  a5ec5fe4bd = 1:  8efebc7a03 Documentation/Makefile: make $(wildcard howto/*.txt) a var
2:  fdc55a86cf ! 2:  8046e7941e Documentation/Makefile: make $(wildcard <doc deps>) a var
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    Documentation/Makefile: make $(wildcard <doc deps>) a var
    +    Documentation/Makefile: make doc.dep dependencies a variable again
     
    -    Refactor the wildcard we'll scan for "include" directives into a
    -    single INCLUDE_TARGETS_TXT variable for readability, consistency.
    +    Re-introduce a variable to declare what *.txt files need to be
    +    considered for the purposes of scouring files to generate a dependency
    +    graph of includes.
    +
    +    When doc.dep was introduced in a5ae8e64cf (Fix documentation
    +    dependency generation., 2005-11-07) we had such a variable called
    +    TEXTFILES, but it was refactored away just a few commits after that in
    +    fb612d54c1 (Documentation: fix dependency generation.,
    +    2005-11-07). I'm planning to add more wildcards here, so let's bring
    +    it back.
    +
    +    I'm not calling it TEXTFILES because we e.g. don't consider
    +    Documentation/technical/*.txt when generating the graph (they don't
    +    use includes). Let's instead call it DOC_DEP_TXT.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ Documentation/Makefile: MAN1_TXT =
      MAN5_TXT =
      MAN7_TXT =
      HOWTO_TXT =
    -+INCLUDE_TARGETS_TXT =
    ++DOC_DEP_TXT =
      TECH_DOCS =
      ARTICLES =
      SP_ARTICLES =
    @@ Documentation/Makefile: MAN7_TXT += gitworkflows.txt
      
      HOWTO_TXT += $(wildcard howto/*.txt)
      
    -+INCLUDE_TARGETS_TXT += $(wildcard *.txt)
    -+INCLUDE_TARGETS_TXT += $(wildcard config/*.txt)
    ++DOC_DEP_TXT += $(wildcard *.txt)
    ++DOC_DEP_TXT += $(wildcard config/*.txt)
     +
      ifdef MAN_FILTER
      MAN_TXT = $(filter $(MAN_FILTER),$(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT))
    @@ Documentation/Makefile: docdep_prereqs = \
      	cmd-list.made $(cmds_txt)
      
     -doc.dep : $(docdep_prereqs) $(wildcard *.txt) $(wildcard config/*.txt) build-docdep.perl
    -+doc.dep : $(docdep_prereqs) $(INCLUDE_TARGETS_TXT) build-docdep.perl
    ++doc.dep : $(docdep_prereqs) $(DOC_DEP_TXT) build-docdep.perl
      	$(QUIET_GEN)$(RM) $@+ $@ && \
      	$(PERL_PATH) ./build-docdep.perl >$@+ $(QUIET_STDERR) && \
      	mv $@+ $@
3:  12573d9028 = 3:  29545543bd doc lint: Perl "strict" and "warnings" in lint-gitlink.perl
4:  5c8e8f2149 ! 4:  5acb116fea doc lint: fix bugs in, simplify and improve lint script
    @@ Commit message
     
          - When the doc-diff script was added in beb188e22a (add a script to
            diff rendered documentation, 2018-08-06) we started sometimes having
    -       a "git worktree" under "documentation". This tree contains a full
    -       checkout of git.git, as a result the "lint" script would recurse into
    -       that, and lint any *.txt file found in that entire repository.
    +       a "git worktree" under Documentation/.
    +
    +       This tree contains a full checkout of git.git, as a result the
    +       "lint" script would recurse into that, and lint any *.txt file
    +       found in that entire repository.
     
            In practice the only in-tree "linkgit" outside of the
            Documentation/ tree is contrib/contacts/git-contacts.txt and
            contrib/subtree/git-subtree.txt, so this wouldn't emit any errors
     
    -    Now we instead simply trust the Makefile to give us *.txt files, and
    -    since the Makefile also knows what sections each page should be in we
    +    Now we instead simply trust the Makefile to give us *.txt files.
    +    Since the Makefile also knows what sections each page should be in we
         don't have to open the files ourselves and try to parse that out. As a
    -    bonus this will also catch bugs with the section line in the file
    -    being incorrect.
    +    bonus this will also catch bugs with the section line in the files
    +    themselves being incorrect.
     
         The structure of the new script is mostly based on
         t/check-non-portable-shell.pl. As an added bonus it will also use
    @@ Commit message
         We'll now emit:
     
             git-cherry.txt:20: error: git-cherry-pick[2]: wrong section (should be 1), shown with 'HERE' below:
    -        git-cherry.txt:20:      "copied" by means of linkgit:git-cherry-pick[2]' <-- HERE
    +        git-cherry.txt:20:      '"copied" by means of linkgit:git-cherry-pick[2]' <-- HERE
             git-cherry.txt:20: error: git-am[3]: wrong section (should be 1), shown with 'HERE' below:
    -        git-cherry.txt:20:      "copied" by means of linkgit:git-cherry-pick[2], linkgit:git-am[3]' <-- HERE
    +        git-cherry.txt:20:      '"copied" by means of linkgit:git-cherry-pick[2], linkgit:git-am[3]' <-- HERE
             git-cherry.txt:21: error: git-rebase[4]: wrong section (should be 1), shown with 'HERE' below:
    -        git-cherry.txt:21:      linkgit:git-rebase[4]' <-- HERE
    +        git-cherry.txt:21:      'linkgit:git-rebase[4]' <-- HERE
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Documentation/Makefile ##
    -@@ Documentation/Makefile: MAN5_TXT =
    - MAN7_TXT =
    - HOWTO_TXT =
    - INCLUDE_TARGETS_TXT =
    -+ALL_TXT =
    - TECH_DOCS =
    - ARTICLES =
    - SP_ARTICLES =
    -@@ Documentation/Makefile: HOWTO_TXT += $(wildcard howto/*.txt)
    - INCLUDE_TARGETS_TXT += $(wildcard *.txt)
    - INCLUDE_TARGETS_TXT += $(wildcard config/*.txt)
    - 
    -+# For linting
    -+ALL_TXT += $(MAN1_TXT)
    -+ALL_TXT += $(MAN5_TXT)
    -+ALL_TXT += $(MAN7_TXT)
    -+ALL_TXT += $(HOWTO_TXT)
    -+ALL_TXT += $(INCLUDE_TARGETS_TXT)
    -+
    - ifdef MAN_FILTER
    - MAN_TXT = $(filter $(MAN_FILTER),$(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT))
    - else
     @@ Documentation/Makefile: print-man1:
      	@for i in $(MAN1_TXT); do echo $$i; done
      
      lint-docs::
     -	$(QUIET_LINT)$(PERL_PATH) lint-gitlink.perl
     +	$(QUIET_LINT)$(PERL_PATH) lint-gitlink.perl \
    ++		$(HOWTO_TXT) $(DOC_DEP_TXT) \
     +		--section=1 $(MAN1_TXT) \
     +		--section=5 $(MAN5_TXT) \
    -+		--section=7 $(MAN7_TXT)	\
    -+		--to-lint $(ALL_TXT)
    ++		--section=7 $(MAN7_TXT)
      
      ifeq ($(wildcard po/Makefile),po/Makefile)
      doc-l10n install-l10n::
    @@ Documentation/lint-gitlink.perl
     -	or die("Cannot parse command line arguments\n");
     +# Parse arguments, a simple state machine for input like:
     +#
    -+# --section=1 git.txt git-add.txt [...] --to-lint git-add.txt a-file.txt [...]
    ++# howto/*.txt config/*.txt --section=1 git.txt git-add.txt [...] --to-lint git-add.txt a-file.txt [...]
     +my %TXT;
     +my %SECTION;
     +my $section;
    @@ Documentation/lint-gitlink.perl
     +	if (my ($sec) = $arg =~ /^--section=(\d+)$/s) {
     +		$section = $sec;
     +		next;
    -+	} elsif ($arg eq '--to-lint') {
    -+		$lint_these = 1;
    -+		next;
     +	}
      
     -my $found_errors = 0;
     +	my ($name) = $arg =~ /^(.*?)\.txt$/s;
    -+	if ($lint_these) {
    ++	unless (defined $section) {
     +		$TXT{$name} = $arg;
     +		next;
     +	}
    @@ Documentation/lint-gitlink.perl
     +	substr($line, $pos) = "' <-- HERE";
     +	$line =~ s/^\s+//;
     +	print "$ARGV:$.: error: $target: $msg, shown with 'HERE' below:\n";
    -+	print "$ARGV:$.:\t$line\n";
    ++	print "$ARGV:$.:\t'$line\n";
     +	$exit_code = 1;
      }
      
    @@ Documentation/lint-gitlink.perl
     -		while (s/linkgit:((.*?)\[(\d)\])//) {
     -			my ($target, $page, $section) = ($1, $2, $3);
     +@ARGV = sort values %TXT;
    ++die "BUG: Nothing to process!" unless @ARGV;
     +while (<>) {
     +	my $line = $_;
     +	while ($line =~ m/linkgit:((.*?)\[(\d)\])/g) {
5:  d4004b6a7c ! 5:  e3af1a9405 doc lint: lint and fix missing "GIT" end sections
    @@ Commit message
         anything outside those sections), not files to be included,
         howto *.txt files etc.
     
    +    We could also add this to the existing (and then renamed)
    +    lint-gitlink.perl, but I'm not doing that here.
    +
    +    Obviously all of that fits in one script, but I think for something
    +    like this that's a one-off script with global variables it's much
    +    harder to follow when a large part of your script is some if/else or
    +    keeping/resetting of state simply to work around the script doing two
    +    things instead of one.
    +
    +    Especially because in this case this script wants to process the file
    +    as one big string, but lint-gitlink.perl wants to look at it one line
    +    at a time. We could also consolidate this whole thing and
    +    t/check-non-portable-shell.pl, but that one likes to join lines as
    +    part of its shell parsing.
    +
    +    So let's just add another script, whole scaffolding is basically:
    +
    +        use strict;
    +        use warnings;
    +        sub report { ... }
    +        my $code = 0;
    +        while (<>) { ... }
    +        exit $code;
    +
    +    We'd spend more lines effort trying to consolidate them than just
    +    copying that around.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Documentation/Makefile ##
     @@ Documentation/Makefile: lint-docs::
    + 		$(HOWTO_TXT) $(DOC_DEP_TXT) \
    + 		--section=1 $(MAN1_TXT) \
      		--section=5 $(MAN5_TXT) \
    - 		--section=7 $(MAN7_TXT)	\
    - 		--to-lint $(ALL_TXT)
    -+	$(QUIET_LINT)$(PERL_PATH) lint-man-txt.perl \
    -+		$(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT)
    +-		--section=7 $(MAN7_TXT)
    ++		--section=7 $(MAN7_TXT); \
    ++	$(PERL_PATH) lint-man-end-blurb.perl $(MAN_TXT)
      
      ifeq ($(wildcard po/Makefile),po/Makefile)
      doc-l10n install-l10n::
    @@ Documentation/gitnamespaces.txt: git clone ext::'git --namespace=foo %s /tmp/pre
     +---
     +Part of the linkgit:git[1] suite
     
    - ## Documentation/lint-man-txt.perl (new) ##
    + ## Documentation/lint-man-end-blurb.perl (new) ##
     @@
     +#!/usr/bin/perl
     +
-:  ---------- > 6:  8c294afe2a doc lint: lint relative section order
-:  ---------- > 7:  9cb100826e docs: fix linting issues due to incorrect relative section order
-- 
2.31.1.622.g1b8cc22e65

