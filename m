Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B63CECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 08:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiHaIl4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 04:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiHaIlz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 04:41:55 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C4CB654D
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 01:41:53 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id h1so6968823wmd.3
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 01:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=qtoWOep2rRjiA5fEOhnOBYhT7ze3PhMmb3q5ovQhaCI=;
        b=GT1YBlMpf9BTOzUkSDp5Y+66ZFHiwIKgGpQL6e9vjYaL2IOoe8C5rmvchvpES23DGn
         I5rjwbFJK9NHi5MOA1EuFXxMo6frS9GpAdjks2KuDyDyyTgTF+qeSEuTCaSzoEGmlZKk
         oQvfYBXhVFQX/YFmu/3Y7TIjQioEN9QJRYZRXkOC4og8cqCVj+ieDhmJ84ksycVFOSWU
         +w4EVMdYxC4PlEThssmN9gSWLAa6Px0o6hyB5BNsCZEO66g3Wy9bIb/GkNPMKTWPcdbL
         xSzwy1z/TUsmjA5IAfIXHo2d95/UP0dsTaXNimpF8LSxk+LjsdlCFIE70P7DQ1Am7wne
         /RZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=qtoWOep2rRjiA5fEOhnOBYhT7ze3PhMmb3q5ovQhaCI=;
        b=lRzu4AQ4udSVn2ZQcbInWiw8KS2tlvk1GkcHIU7HncPmL3b++hZJuU2ju1GJ1pVl9j
         uPS2mBD+Gc2mCIh89tDnDPYQ/39KfG6TpsbWAMcOqUGhQRG15w6HlY92CxG3F2iNf9Ql
         +KaH37UuZv57iEeh4rcrl5yQM9KEjulEVBXUVjZv7IF1OQkkVMLMk1hIQlk6pG3l3aT+
         rNVdtAEWOTwchGH9OvTzxMM+B8sExOrjT2lfFDa4uq9NQp+7JDrOmE1jzjVxw2lhbVKJ
         D5QxT4i1utfKF9QybUX/oT/Pu5Pi3bYFGlXXEpYoytvJcMzDRfOTDIGCtc0zq0qiZAiK
         YwPQ==
X-Gm-Message-State: ACgBeo15frDJ/VhMEIUNOrxXdtNM88vsV4ocIttURixwyxkob6AjEB6I
        2pMirf0ATBPw+Uvcwc7byxSyv27GEX4=
X-Google-Smtp-Source: AA6agR4noTLAL30uTxmZ3i1192PzTmtVmbi7MlB/nASbzLeqeRfjutjVYIENP5dky63VV8LWZzcWzg==
X-Received: by 2002:a7b:c38e:0:b0:3a5:c383:c68 with SMTP id s14-20020a7bc38e000000b003a5c3830c68mr1228230wmj.163.1661935311365;
        Wed, 31 Aug 2022 01:41:51 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n2-20020a7bc5c2000000b003a5c064717csm1439036wmk.22.2022.08.31.01.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 01:41:50 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/9] docs: de-duplicate sections, add more CONFIGURATION sections
Date:   Wed, 31 Aug 2022 10:41:31 +0200
Message-Id: <cover-v3-0.9-00000000000-20220831T083759Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1406.g184357183a6
In-Reply-To: <cover-v2-0.9-00000000000-20220729T081959Z-avarab@gmail.com>
References: <cover-v2-0.9-00000000000-20220729T081959Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series:

 * De-duplicates and combines configuration discussion that was split
   or spread across Documentation/config/*.txt and
   Documentation/git-*.txt, moving it to Documentation/config/*.txt.

 * Includes that relevant Documentation/config/*.txt in the
   Documentation/git-*.txt files.

 * Introduces and uses included prose for those "CONFIGURATION"
   sections in various Documentation/git-*.txt files, informing the
   reader that what they see there is included from "git-config(1)".

This v3 attempts to address all the feedback on v2. I think this
should be good for merging down at this point. Sorry about the late
re-roll.

Ævar Arnfjörð Bjarmason (9):
  docs: add and use include template for config/* includes
  grep docs: de-duplicate configuration sections
  send-email docs: de-duplicate configuration sections
  apply docs: de-duplicate configuration sections
  notes docs: de-duplicate and combine configuration sections
  difftool docs: de-duplicate configuration sections
  log docs: de-duplicate configuration sections
  docs: add CONFIGURATION sections that map to a built-in
  docs: add CONFIGURATION sections that fuzzy map to built-ins

 Documentation/Makefile                        |  1 +
 Documentation/config/diff.txt                 | 15 -----
 Documentation/config/difftool.txt             | 28 +++++++++-
 Documentation/config/grep.txt                 |  7 ++-
 Documentation/config/log.txt                  |  4 ++
 Documentation/config/notes.txt                | 43 +++++++++------
 Documentation/config/sendemail.txt            | 40 +++++++++++++-
 Documentation/git-add.txt                     |  7 +++
 Documentation/git-am.txt                      |  7 +++
 Documentation/git-apply.txt                   | 10 +---
 Documentation/git-blame.txt                   |  6 ++
 Documentation/git-branch.txt                  |  4 ++
 Documentation/git-checkout.txt                |  7 +++
 Documentation/git-clean.txt                   |  7 +++
 Documentation/git-clone.txt                   |  9 +++
 Documentation/git-column.txt                  |  7 +++
 Documentation/git-commit-graph.txt            |  7 +++
 Documentation/git-commit.txt                  |  4 ++
 Documentation/git-diff.txt                    |  7 +++
 Documentation/git-difftool.txt                | 27 ++-------
 Documentation/git-fast-import.txt             |  7 +++
 Documentation/git-fetch.txt                   |  7 +++
 Documentation/git-fsck.txt                    |  2 +
 Documentation/git-gc.txt                      |  3 +-
 Documentation/git-grep.txt                    | 29 +---------
 Documentation/git-imap-send.txt               |  2 +
 Documentation/git-init.txt                    |  7 +++
 Documentation/git-log.txt                     | 46 ++--------------
 Documentation/git-mailinfo.txt                |  7 +++
 Documentation/git-maintenance.txt             |  7 +++
 Documentation/git-merge.txt                   |  5 +-
 Documentation/git-mergetool.txt               |  3 +
 Documentation/git-notes.txt                   | 55 ++-----------------
 Documentation/git-push.txt                    |  7 +++
 Documentation/git-rebase.txt                  |  2 +
 Documentation/git-revert.txt                  |  7 +++
 Documentation/git-send-email.txt              | 36 +-----------
 Documentation/git-show-branch.txt             |  7 +++
 Documentation/git-stash.txt                   |  7 +++
 Documentation/git-switch.txt                  |  7 +++
 .../includes/cmd-config-section-all.txt       |  3 +
 .../includes/cmd-config-section-rest.txt      |  3 +
 42 files changed, 280 insertions(+), 226 deletions(-)
 create mode 100644 Documentation/includes/cmd-config-section-all.txt
 create mode 100644 Documentation/includes/cmd-config-section-rest.txt

Range-diff against v2:
 1:  ef6fa5450e7 !  1:  da21c19978c docs: add and use include template for config/* includes
    @@ Documentation/includes/cmd-config-section-all.txt (new)
     
      ## Documentation/includes/cmd-config-section-rest.txt (new) ##
     @@
    -+The discussion above this line is unique to this documentation, but
    -+everything below is included from section(s) in linkgit:git-config[1]
    -+aplicable to this command:
    ++Everything above this line in this section isn't included from the
    ++linkgit:git-config[1] documentation. The content that follows is the
    ++same as what's found there:
 2:  5f07f87710c =  2:  d16e927caa2 grep docs: de-duplicate configuration sections
 3:  8138dc54e3e =  3:  c36feb6f35a send-email docs: de-duplicate configuration sections
 4:  b9750ae43e1 =  4:  5707c9dd635 apply docs: de-duplicate configuration sections
 5:  1b6c8c75df7 !  5:  5b0ea00aa33 notes docs: de-duplicate configuration sections
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    notes docs: de-duplicate configuration sections
    +    notes docs: de-duplicate and combine configuration sections
     
    -    Let's also fix the "git-notes(1)" docs so that we link to
    -    "git-config(1)", not "git-log(1)" as a reference for the "notes" docs.
    +    Combine the various "notes" configuration sections spread across
    +    Documentation/config/notes.txt and Documentation/git-notes.txt to live
    +    in the former, and to be included in the latter.
    +
    +    We'll now forward link from "git notes" to the "CONFIGURATION" section
    +    below, rather than to "git-config(1)" when discussing configuration
    +    variables that are (also) discussed in that section.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ Documentation/git-notes.txt: using the `--notes` option. Such notes are added as
      
      To change which notes are shown by 'git log', see the
     -"notes.displayRef" configuration in linkgit:git-log[1].
    -+"notes.displayRef" configuration in linkgit:git-config[1].
    ++"notes.displayRef" discussion in <<CONFIGURATION>>.
      
      See the "notes.rewrite.<command>" configuration for a way to carry
      notes across commands that rewrite commits.
    +@@ Documentation/git-notes.txt: with 'git log', so if you use such notes, you'll probably need to write
    + some special-purpose tools to do something useful with them.
    + 
    + 
    ++[[CONFIGURATION]]
    + CONFIGURATION
    + -------------
    + 
     @@ Documentation/git-notes.txt: core.notesRef::
      	This setting can be overridden through the environment and
      	command line.
 6:  b3a5ea46bb5 =  6:  c4c3fa14190 difftool docs: de-duplicate configuration sections
 7:  08d98767384 !  7:  e07585ba085 log docs: de-duplicate configuration sections
    @@ Commit message
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Documentation/config/log.txt ##
    -@@
    --log.abbrevCommit::
    --	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
    --	linkgit:git-whatchanged[1] assume `--abbrev-commit`. You may
    --	override this option with `--no-abbrev-commit`.
    --
    - log.date::
    +@@ Documentation/config/log.txt: log.date::
      	Set the default date-time mode for the 'log' command.
      	Setting a value for log.date is similar to using 'git log''s
      	`--date` option.  See linkgit:git-log[1] for details.
    @@ Documentation/config/log.txt
      
      log.decorate::
      	Print out the ref names of any commits that are shown by the log
    -@@ Documentation/config/log.txt: log.showRoot::
    - 	Tools like linkgit:git-log[1] or linkgit:git-whatchanged[1], which
    - 	normally hide the root commit will now show it. True by default.
    - 
    -+log.abbrevCommit::
    -+	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
    -+	linkgit:git-whatchanged[1] assume `--abbrev-commit`. You may
    -+	override this option with `--no-abbrev-commit`.
    -+
    - log.showSignature::
    - 	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
    - 	linkgit:git-whatchanged[1] assume `--show-signature`.
    -@@ Documentation/config/log.txt: log.mailmap::
    - 	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
    - 	linkgit:git-whatchanged[1] assume `--use-mailmap`, otherwise
    - 	assume `--no-use-mailmap`. True by default.
    -++
    -+The behavior of `log.mailmap` is impacted by the setting of the more
    -+general 'mailmap.*' configuration variables, i.e. `mailmap.file` and
    -+`mailmap.blob`.
     
      ## Documentation/git-log.txt ##
    -@@ Documentation/git-log.txt: OPTIONS
    - 	shown. The option `--decorate` is short-hand for `--decorate=short`.
    - 	Default to configuration value of `log.decorate` if configured,
    - 	otherwise, `auto`.
    -++
    -+This output may be colored. See `color.ui` in linkgit:git-config[1]
    -+and `color.decorate` there and in the "CONFIGURATION" section below.
    - 
    - --decorate-refs=<pattern>::
    - --decorate-refs-exclude=<pattern>::
     @@ Documentation/git-log.txt: i18n.logOutputEncoding::
      	Defaults to the value of `i18n.commitEncoding` if set, and UTF-8
      	otherwise.
 8:  5c379ab1476 !  8:  af912e9ca65 docs: add CONFIGURATION sections that map to a built-in
    @@ Documentation/git-commit-graph.txt: $ git show-ref -s | git commit-graph write -
     +include::config/commitgraph.txt[]
     +
      
    - GIT
    - ---
    + FILE FORMAT
    + -----------
     
      ## Documentation/git-commit.txt ##
     @@ Documentation/git-commit.txt: The editor used to edit the commit log message will be chosen from the
    @@ Documentation/git-fast-import.txt: operator can use this facility to peek at the
      --------
      linkgit:git-fast-export[1]
     
    + ## Documentation/git-init.txt ##
    +@@ Documentation/git-init.txt: $ git commit    <3>
    + <2> Add all existing files to the index.
    + <3> Record the pristine state as the first commit in the history.
    + 
    ++CONFIGURATION
    ++-------------
    ++
    ++include::includes/cmd-config-section-all.txt[]
    ++
    ++include::config/init.txt[]
    ++
    + GIT
    + ---
    + Part of the linkgit:git[1] suite
    +
      ## Documentation/git-mailinfo.txt ##
     @@ Documentation/git-mailinfo.txt: If no such configuration option has been set, `warn` will be used.
      <patch>::
 9:  91689154926 !  9:  5ef36654bba docs: add CONFIGURATION sections that fuzzy map to built-ins
    @@ Commit message
     
          * config/blame.txt: used by git-{blame,annotate}.txt. Since the
            git-annotate(1) documentation refers to git-blame(1) don't add a
    -       "CONFIGURATION" section to git-annotate(1), only to git-blame(1)>
    +       "CONFIGURATION" section to git-annotate(1), only to git-blame(1).
     
    -     * config/branch.txt: maps to both git-checkout.txt and
    +     * config/checkout.txt: maps to both git-checkout.txt and
            git-switch.txt (but nothing else).
     
          * config/init.txt: should be included in git-init(1) and
    @@ Commit message
     
         Things that are being left out, and why:
     
    -     * config/remote.txt: let's not include this in
    -       git-{fetch,remote,push}.txt etc. for now, various options there
    -       change their behavior.
    -
    -     * config/remotes.txt: As we're not including config/remote.txt for
    -       now, let's not include this one either.
    -
    -     * config/credential.txt: let's not include this in
    -       git-credential.txt, it talks more generally about how the
    -       credential facility is used by various other commands, not that
    -       command in particular.
    +     * config/{remote,remotes,credential}.txt: Configuration that affects
    +       how we talk to remote repositories is harder to untangle. We'll need
    +       to include some of this in git-{fetch,remote,push,ls-remote}.txt
    +       etc., but some of those only use a small subset of these
    +       options. Let's leave this for now.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
-- 
2.37.3.1406.g184357183a6

