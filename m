Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F15C433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 07:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiJUHl5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 03:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiJUHl4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 03:41:56 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA03022BCB8
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 00:41:53 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id bh7-20020a05600c3d0700b003c6fb3b2052so1434359wmb.2
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 00:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DxcOkvhWw8FFOSNAJcb+QMVLgtMg0cIQ2wGXcNxYwn0=;
        b=B9eaXx0ohgzaZTOjLh5ZyBaqZztDLBT296qNUSm2bBsNOf0ALfsh00FIh1PpacvXX3
         HAhpAbdjvSvGOazs3HgaSeryvaX5PCaD2Ezt8QhxKb2MpvVUrlPb9PnEt8l5O0lDUQC9
         ovQTFOLLwWAr5hrJADsFtZje4WVMtvDdyg6+XSN+jRAFiT/fnI/WbElA0ZxB3VB+ePKK
         t/qBMVsPHsnNnyKUQ2SZZE1MIwkD23QT6Eo2fkZGOVFjzJdcEs778zg8K/4qv8XWXWNb
         dP3xEcBfDDHMrzS7S/ArLFeC0n0YlOV70B9aDvW/Uw/sglSbgpJ4lruMB5X5sM2+w8cH
         JYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DxcOkvhWw8FFOSNAJcb+QMVLgtMg0cIQ2wGXcNxYwn0=;
        b=7ziv/iH5IMqWTVPhCSYrlic25OKS8PhqkVBva+MnX+/hRR7FCOCet7CF110IfLVTDv
         bqj8x7M4h8IiPdnHHmYHVUc3Tq5C1FVJp6s9Rj4/1bmDHFC89EDzXihmvOqM3WPpzlOh
         N7UoNMFpZJD5OSPHd/norwUWz1cxM7plfueejRDIDbl8Bp4ujLdZzprtc0fh4m8C+ouo
         ZiV41q0F1YSttukKezd4vy0E0qsNP3r+M1FmbeYhLPMYGiE0M4eu3rrzHcbmlTUyAEuN
         hDGVGgmeNAU1RDPVrgY/MJRi5GCG+N9/nUa1S+NZeU7Q9JjH+I+U86e+58Bm9hsXbPMo
         ckeg==
X-Gm-Message-State: ACrzQf083H2TYlUi8i9zLLcMQ3M7B4ci3ThIozOv2LqNxqmUnqIt4512
        FllcFXkKISlPXk779RoYFHm8wnj/QTE=
X-Google-Smtp-Source: AMsMyM5GQxCEJ+BhK3ccy1luxaYa1d9Ic3Mr6Lw0DzB/H79h2pRaoV7qE6EhRR/Gdr7l++9Rhf5j8A==
X-Received: by 2002:a7b:c4c1:0:b0:3bf:e351:4ba with SMTP id g1-20020a7bc4c1000000b003bfe35104bamr24460928wmk.152.1666338111591;
        Fri, 21 Oct 2022 00:41:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j18-20020adff012000000b00228fa832b7asm18197244wro.52.2022.10.21.00.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 00:41:51 -0700 (PDT)
Message-Id: <pull.1345.v3.git.1666338109778.gitgitgadget@gmail.com>
In-Reply-To: <pull.1345.v2.git.1666142160427.gitgitgadget@gmail.com>
References: <pull.1345.v2.git.1666142160427.gitgitgadget@gmail.com>
From:   "Julia Ramer via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Oct 2022 07:41:49 +0000
Subject: [PATCH v3] embargoed releases: also describe the git-security list
 and the process
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     git-security@googlegroups.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Julia Ramer <prplr@github.com>,
        Keanen Wold <keanenwold@github.com>,
        Veronica Giaudrone <veronica.Giaudrone@microsoft.com>,
        Bri Brothers <brbrot@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>,
        Julia Ramer <gitprplr@gmail.com>,
        Julia Ramer <gitprplr@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Julia Ramer <gitprplr@gmail.com>

With the recent turnover on the git-security list, questions came up how
things are usually run. Rather than answering questions individually,
extend Git's existing documentation about security vulnerabilities to
describe the git-security mailing list, how things are run on that list,
and what to expect throughout the process from the time a security bug
is reported all the way to the time when a fix is released.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Julia Ramer <gitprplr@gmail.com>
---
    embargoed releases: also describe the git-security list and the process
    
    Changes since v2:
    
     * squashed Junio's patch with very minor modifications
     * incorporated further feedback since v2
    
    Changes since v1:
    
     * Fixed the build
     * Changed the wording based on various feedback

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1345%2Fprplr%2Fupdate_embargo_doc-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1345/prplr/update_embargo_doc-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1345

Range-diff vs v2:

 1:  766c92e9031 ! 1:  96250f139a9 embargoed releases: also describe the git-security list and the process
     @@ Commit message
          and what to expect throughout the process from the time a security bug
          is reported all the way to the time when a fix is released.
      
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
     +    Helped-by: Taylor Blau <me@ttaylorr.com>
          Signed-off-by: Julia Ramer <gitprplr@gmail.com>
      
       ## Documentation/howto/coordinate-embargoed-releases.txt ##
     @@ Documentation/howto/coordinate-embargoed-releases.txt
      +Abstract: When a vulnerability is reported, we follow these guidelines to
      + assess the vulnerability, create and review a fix, and coordinate embargoed
      + security releases.
     -+
     + 
     + How we coordinate embargoed releases
     +-====================================
     ++------------------------------------
     + 
     + To protect Git users from critical vulnerabilities, we do not just release
     + fixed versions like regular maintenance releases. Instead, we coordinate
     +@@ Documentation/howto/coordinate-embargoed-releases.txt: releases with packagers, keeping the fixes under an embargo until the release
     + date. That way, users will have a chance to upgrade on that date, no matter
     + what Operating System or distribution they run.
     + 
     +-Open a Security Advisory draft
     +-------------------------------
     +-
     +-The first step is to https://github.com/git/git/security/advisories/new[open an
     +-advisory]. Technically, it is not necessary, but it is convenient and saves a
     +-bit of hassle. This advisory can also be used to obtain the CVE number and it
     +-will give us a private fork associated with it that can be used to collaborate
     +-on a fix.
     +-
     +-Release date of the embargoed version
     +--------------------------------------
     +-
     +-If the vulnerability affects Windows users, we want to have our friends over at
     +-Visual Studio on board. This means we need to target a "Patch Tuesday" (i.e. a
     +-second Tuesday of the month), at the minimum three weeks from heads-up to
     +-coordinated release.
     +-
     +-If the vulnerability affects the server side, or can benefit from scans on the
     +-server side (i.e. if `git fsck` can detect an attack), it is important to give
     +-all involved Git repository hosting sites enough time to scan all of those
     +-repositories.
      +The `git-security` mailing list
      +-------------------------------
      +
     @@ Documentation/howto/coordinate-embargoed-releases.txt
      +affected by security vulnerabilities in Git).
      +
      +Most of the discussions revolve around assessing the severity of the reported
     -+bugs (including the decision whether the report is security-relevant or can be
     -+redirected to the public mailing list), how to remediate the bug, determining
     ++issue (including the decision whether the report is security-relevant or can be
     ++redirected to the public mailing list), how to remediate the issue, determining
      +the timeline of the disclosure as well as aligning priorities and
      +requirements.
      +
     @@ Documentation/howto/coordinate-embargoed-releases.txt
      +mail threads are not usually structured specifically to communicate
      +agreements, assessments or timelines.
      +
     -+A bug's life: Typical timeline
     -+------------------------------
     -+
     -+- A bug is reported to the `git-security` mailing list.
     ++Typical timeline
     ++----------------
      +
     -+- Within a couple of days, someone from the core Git team responds with an
     -+  initial assessment of the bug’s severity.
     ++- A potential vulnerability is reported to the `git-security` mailing list.
      +
     -+- Other core developers - including the Git maintainer - chime in.
     ++- The security-list members start a discussion to give an initial
     ++  assessment of the severity of the reported potential vulnerability.
     ++  We aspire to do so within a few days.
      +
     -+- After discussion, if consensus is reached that the bug is not critical enough
     ++- After discussion, if consensus is reached that it is not critical enough
      +  to warrant any embargo, the reporter is redirected to the public Git mailing
      +  list. This ends the reporter's interaction with the `git-security` list.
      +
     -+- If the bug is critical enough for an embargo, ideas are presented on how to
     ++- If it is deemed critical enough for an embargo, ideas are presented on how to
      +  address the vulnerability.
      +
      +- Usually around that time, the Git maintainer or their delegate(s) open a draft
      +  security advisory in the `git/git` repository on GitHub (see below for more
      +  details).
      +
     -+- Depending on the preferences of the involved contributors and reviewers, code
     -+  review then happens either on the `git-security` mailing list or in a private
     -+  fork associated with the draft security advisory.
     ++- Code review can take place in a variety of different locations,
     ++  depending on context. These are: patches sent inline on the
     ++  git-security list, a private fork on GitHub associated with the
     ++  draft security advisory, or the git/cabal repository.
     ++
     ++  Contributors working on a fix should consider beginning by sending
     ++  patches to the git-security list (inline with the original thread),
     ++  since they are accessible to all subscribers, along with the original
     ++  reporter.
      +
      +- Once the review has settled and everyone involved in the review agrees that
      +  the patches are ready, the Git maintainer, and others determine a release date
      +  as well as the release trains that are serviced. The decision regarding which
      +  versions need a backported fix is based on input from the reporter, the
     -+  contributor who worked on the patches, and from stakeholders (e.g. operators
     -+  of hosting sites who may want to analyze whether the given bug is exploited
     -+  via any of the repositories they host).
     ++  contributor who worked on the patches, and from stakeholders.   Operators
     ++  of hosting sites who may want to analyze whether the given issue is exploited
     ++  via any of the repositories they host, and binary packagers who want to
     ++  make sure their product gets patched adequately against the vulnerability,
     ++  for example, may want to give their input at this stage.
      +
      +- While the Git community does its best to accommodate the specific timeline
      +  requests of the various binary packagers, the nature of the issue may preclude
     @@ Documentation/howto/coordinate-embargoed-releases.txt
      +- The tags are created by the Git maintainer and pushed to the same
      +  repositories.
      +
     -+- The Git for Windows, Git for macOS, BSD, Debian, etc maintainers prepares the
     ++- The Git for Windows, Git for macOS, BSD, Debian, etc. maintainers prepare the
      +  corresponding release artifacts, based on the tags created that have been
      +  prepared by the Git maintainer.
      +
     -+- Git for Windows release artifacts are made available under embargo to
     -+  stakeholders via a mail to the `git-security` list.
     ++- The release artifacts prepared by various binary packagers can be
     ++  made available to stakeholders under embargo via a mail to the
     ++  `git-security` list.
      +
      +- Less than a week before the release, a mail with the relevant information is
      +  sent to <distros@vs.openwall.org> (see below), a list used to pre-announce
      +  embargoed releases of open source projects to the stakeholders of all major
     -+  Linux distributions. This includes a Git bundle of the tagged version(s), but
     -+  no further specifics of the vulnerability.
     ++  distributions of Linux as well as other OSes. This includes a Git bundle
     ++  of the tagged version(s), but no further specifics of the vulnerability.
      +
      +- Public communication is then prepared in advance of the release date. This
      +  includes blog posts and mails to the Git and Git for Windows mailing lists.
     @@ Documentation/howto/coordinate-embargoed-releases.txt
      +- Git for Windows release is then announced via a mail to the public Git and
      +  Git for Windows mailing lists as well as via a tweet.
      +
     -+- Ditto for Linux distribution packagers: their releases are announced via
     -+  their preferred channels.
     ++- Ditto for distribution packagers for Linux and other platforms:
     ++  their releases are announced via their preferred channels.
      +
      +- A mail to <oss-security@lists.openwall.org> (see below for details) is sent
      +  as a follow-up to the <distros@vs.openwall.org> one, describing the
     @@ Documentation/howto/coordinate-embargoed-releases.txt
      +
      +Note: The Git project makes no guarantees about timelines, but aims to keep
      +embargoes reasonably short in the interest of keeping Git's users safe.
     - 
     - How we coordinate embargoed releases
     --====================================
     -+------------------------------------
     - 
     - To protect Git users from critical vulnerabilities, we do not just release
     - fixed versions like regular maintenance releases. Instead, we coordinate
     -@@ Documentation/howto/coordinate-embargoed-releases.txt: date. That way, users will have a chance to upgrade on that date, no matter
     - what Operating System or distribution they run.
     - 
     - Open a Security Advisory draft
     --------------------------------
     --
     --The first step is to https://github.com/git/git/security/advisories/new[open an
     --advisory]. Technically, it is not necessary, but it is convenient and saves a
     --bit of hassle. This advisory can also be used to obtain the CVE number and it
     --will give us a private fork associated with it that can be used to collaborate
     --on a fix.
     -+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     - 
     --Release date of the embargoed version
     ---------------------------------------
     --
     --If the vulnerability affects Windows users, we want to have our friends over at
     --Visual Studio on board. This means we need to target a "Patch Tuesday" (i.e. a
     --second Tuesday of the month), at the minimum three weeks from heads-up to
     --coordinated release.
     --
     --If the vulnerability affects the server side, or can benefit from scans on the
     --server side (i.e. if `git fsck` can detect an attack), it is important to give
     --all involved Git repository hosting sites enough time to scan all of those
     --repositories.
     ++
     ++Opening a Security Advisory draft
     ++~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     ++
      +The first step is to https://github.com/git/git/security/advisories/new[open
      +an advisory]. Technically, this is not necessary. However, it is the most
      +convenient way to obtain the CVE number and it give us a private repository
     @@ Documentation/howto/coordinate-embargoed-releases.txt: Thanks,
       
       ....
       To: oss-security@lists.openwall.com
     -@@ Documentation/howto/coordinate-embargoed-releases.txt: it goes to <developer>.
     - 
     - Thanks,
     - <name>
     --....
     -+....
     - \ No newline at end of file


 .../howto/coordinate-embargoed-releases.txt   | 175 +++++++++++++++---
 1 file changed, 147 insertions(+), 28 deletions(-)

diff --git a/Documentation/howto/coordinate-embargoed-releases.txt b/Documentation/howto/coordinate-embargoed-releases.txt
index 601aae88e9a..7cd8f6241c2 100644
--- a/Documentation/howto/coordinate-embargoed-releases.txt
+++ b/Documentation/howto/coordinate-embargoed-releases.txt
@@ -1,9 +1,10 @@
 Content-type: text/asciidoc
-Abstract: When a critical vulnerability is discovered and fixed, we follow this
- script to coordinate a public release.
+Abstract: When a vulnerability is reported, we follow these guidelines to
+ assess the vulnerability, create and review a fix, and coordinate embargoed
+ security releases.
 
 How we coordinate embargoed releases
-====================================
+------------------------------------
 
 To protect Git users from critical vulnerabilities, we do not just release
 fixed versions like regular maintenance releases. Instead, we coordinate
@@ -11,33 +12,151 @@ releases with packagers, keeping the fixes under an embargo until the release
 date. That way, users will have a chance to upgrade on that date, no matter
 what Operating System or distribution they run.
 
-Open a Security Advisory draft
-------------------------------
-
-The first step is to https://github.com/git/git/security/advisories/new[open an
-advisory]. Technically, it is not necessary, but it is convenient and saves a
-bit of hassle. This advisory can also be used to obtain the CVE number and it
-will give us a private fork associated with it that can be used to collaborate
-on a fix.
-
-Release date of the embargoed version
--------------------------------------
-
-If the vulnerability affects Windows users, we want to have our friends over at
-Visual Studio on board. This means we need to target a "Patch Tuesday" (i.e. a
-second Tuesday of the month), at the minimum three weeks from heads-up to
-coordinated release.
-
-If the vulnerability affects the server side, or can benefit from scans on the
-server side (i.e. if `git fsck` can detect an attack), it is important to give
-all involved Git repository hosting sites enough time to scan all of those
-repositories.
+The `git-security` mailing list
+-------------------------------
+
+Responsible disclosures of vulnerabilities, analysis, proposed fixes as
+well as the orchestration of coordinated embargoed releases all happen on the
+`git-security` mailing list at <git-security@googlegroups.com>.
+
+In this context, the term "embargo" refers to the time period that information
+about a vulnerability is kept under wraps and only shared on a need-to-know
+basis. This is necessary to protect Git's users from bad actors who would
+otherwise be made aware of attack vectors that could be exploited. "Lifting the
+embargo" refers to publishing the version that fixes the vulnerabilities.
+
+Audience of the `git-security` mailing list
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Anybody may contact the `git-security` mailing list by sending an email
+to <git-security@googlegroups.com>, though the archive is closed to the
+public and only accessible to subscribed members.
+
+There are a few dozen subscribed members: core Git developers who are trusted
+with addressing vulnerabilities, and stakeholders (i.e. owners of products
+affected by security vulnerabilities in Git).
+
+Most of the discussions revolve around assessing the severity of the reported
+issue (including the decision whether the report is security-relevant or can be
+redirected to the public mailing list), how to remediate the issue, determining
+the timeline of the disclosure as well as aligning priorities and
+requirements.
+
+Communications
+~~~~~~~~~~~~~~
+
+If you are a stakeholder, it is a good idea to pay close attention to the
+discussions, as pertinent information may be buried in the middle of a lively
+conversation that might not look relevant to your interests. For example, the
+tentative timeline might be agreed upon in the middle of discussing code
+comment formatting in one of the patches and whether or not to combine fixes
+for multiple, separate vulnerabilities into the same embargoed release. Most
+mail threads are not usually structured specifically to communicate
+agreements, assessments or timelines.
+
+Typical timeline
+----------------
+
+- A potential vulnerability is reported to the `git-security` mailing list.
+
+- The security-list members start a discussion to give an initial
+  assessment of the severity of the reported potential vulnerability.
+  We aspire to do so within a few days.
+
+- After discussion, if consensus is reached that it is not critical enough
+  to warrant any embargo, the reporter is redirected to the public Git mailing
+  list. This ends the reporter's interaction with the `git-security` list.
+
+- If it is deemed critical enough for an embargo, ideas are presented on how to
+  address the vulnerability.
+
+- Usually around that time, the Git maintainer or their delegate(s) open a draft
+  security advisory in the `git/git` repository on GitHub (see below for more
+  details).
+
+- Code review can take place in a variety of different locations,
+  depending on context. These are: patches sent inline on the
+  git-security list, a private fork on GitHub associated with the
+  draft security advisory, or the git/cabal repository.
+
+  Contributors working on a fix should consider beginning by sending
+  patches to the git-security list (inline with the original thread),
+  since they are accessible to all subscribers, along with the original
+  reporter.
+
+- Once the review has settled and everyone involved in the review agrees that
+  the patches are ready, the Git maintainer, and others determine a release date
+  as well as the release trains that are serviced. The decision regarding which
+  versions need a backported fix is based on input from the reporter, the
+  contributor who worked on the patches, and from stakeholders.   Operators
+  of hosting sites who may want to analyze whether the given issue is exploited
+  via any of the repositories they host, and binary packagers who want to
+  make sure their product gets patched adequately against the vulnerability,
+  for example, may want to give their input at this stage.
+
+- While the Git community does its best to accommodate the specific timeline
+  requests of the various binary packagers, the nature of the issue may preclude
+  a prolonged release schedule. For fixes deemed urgent, it may be in the best
+  interest of the Git users community to shorten the disclosure and release
+  timeline, and packagers may need to adapt accordingly.
+
+- Subsequently, branches with the fixes are pushed to private repositories that
+  are owned by the Git project, with tightly controlled access.
+
+- The tags are created by the Git maintainer and pushed to the same
+  repositories.
+
+- The Git for Windows, Git for macOS, BSD, Debian, etc. maintainers prepare the
+  corresponding release artifacts, based on the tags created that have been
+  prepared by the Git maintainer.
+
+- The release artifacts prepared by various binary packagers can be
+  made available to stakeholders under embargo via a mail to the
+  `git-security` list.
+
+- Less than a week before the release, a mail with the relevant information is
+  sent to <distros@vs.openwall.org> (see below), a list used to pre-announce
+  embargoed releases of open source projects to the stakeholders of all major
+  distributions of Linux as well as other OSes. This includes a Git bundle
+  of the tagged version(s), but no further specifics of the vulnerability.
+
+- Public communication is then prepared in advance of the release date. This
+  includes blog posts and mails to the Git and Git for Windows mailing lists.
+
+- On the day of the release, at around 10am Pacific Time, the Git maintainer
+  pushes the tag and the `master` branch to the public repository, then sends
+  out an announcement mail.
+
+- Once the tag is pushed, the Git for Windows maintainer publishes the
+  corresponding tag and creates a GitHub Release with the associated release
+  artifacts (Git for Windows installer, Portable Git, MinGit, etc).
+
+- Git for Windows release is then announced via a mail to the public Git and
+  Git for Windows mailing lists as well as via a tweet.
+
+- Ditto for distribution packagers for Linux and other platforms:
+  their releases are announced via their preferred channels.
+
+- A mail to <oss-security@lists.openwall.org> (see below for details) is sent
+  as a follow-up to the <distros@vs.openwall.org> one, describing the
+  vulnerability in detail, often including a proof of concept of an exploit.
+
+Note: The Git project makes no guarantees about timelines, but aims to keep
+embargoes reasonably short in the interest of keeping Git's users safe.
+
+Opening a Security Advisory draft
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The first step is to https://github.com/git/git/security/advisories/new[open
+an advisory]. Technically, this is not necessary. However, it is the most
+convenient way to obtain the CVE number and it give us a private repository
+associated with it that can be used to collaborate on a fix.
 
 Notifying the Linux distributions
----------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 At most two weeks before release date, we need to send a notification to
-distros@vs.openwall.org, preferably less than 7 days before the release date.
+<distros@vs.openwall.org>, preferably less than 7 days before the release date.
 This will reach most (all?) Linux distributions. See an example below, and the
 guidelines for this mailing list at
 https://oss-security.openwall.org/wiki/mailing-lists/distros#how-to-use-the-lists[here].
@@ -65,7 +184,7 @@ created using a command like this:
 	tar cJvf cve-xxx.bundle.tar.xz cve-xxx.bundle
 
 Example mail to distros@vs.openwall.org
----------------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 ....
 To: distros@vs.openwall.org
@@ -101,7 +220,7 @@ Thanks,
 ....
 
 Example mail to oss-security@lists.openwall.com
------------------------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 ....
 To: oss-security@lists.openwall.com

base-commit: e72d93e88cb20b06e88e6e7d81bd1dc4effe453f
-- 
gitgitgadget
