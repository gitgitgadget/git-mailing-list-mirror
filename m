Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88385C00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 08:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234767AbiG2I0f (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 04:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234779AbiG2I0C (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 04:26:02 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C103E286D0
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 01:26:00 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id j29-20020a05600c1c1d00b003a2fdafdefbso2147807wms.2
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 01:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=0U2O4DkUIBVAsjxraGQJy76siTM7vzKDbjb/To0tUsk=;
        b=T8UMCmvQMADKUoYCKTVZd6bIjfSoX4y8+8fH6ymFn99wPshUIVLu/PVodw1Jfv0cu2
         bbHFT94tME4SeUG7BF7sT0KpxFGla3Dsff/0Zbuda3sau79NunFEGuRTPkBIrLreR0dC
         piMhl8HumOn4knEnOqzfa6w8QAKfEAZhhzwWB7MLVMlArnlp3dd4zicQvEf2twYLGPz+
         Gx7x1iOncUuarko6vFtfXDBMMJazY/+Q/3xeSsCcW89LEWNwXHzzptVAhPyfpca9ZjfU
         RSW+5BlDhrAsaY06J2lBiFXOcTPnPj0abFmImYFz6voXnaTFdC0TXzy9zopftQJRstfw
         +PQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=0U2O4DkUIBVAsjxraGQJy76siTM7vzKDbjb/To0tUsk=;
        b=T/hNCupPMR7o3lhgnUe8r76uxrSgJUBRnjQFu5+1hEPqjpeoRdSk3iTC9mzFldXMdr
         FrZhhQ3g25YJQHMy9t30g7eD6F3GcaVVoibhgmpXRQY8/Afo2OOZmP26w/WAd+D5qIQ0
         T8+jVCQ9yH5qvIT/TAgLiG5PVhFcnv0h95FiAwERjXT7seNS8qdsIXJeJAi9L+khxugx
         IMf2CkhWnD8CH/B3xaEFuGWO7lT8ozHHdcTm0bdX62qBzCmSnYGvD3JrtATlPUc9lP03
         mVdSl0CsxxKXGNxv7qJ3dGbFKRniaiU/L8dSQC2tSpEphTTVJARZkFt+TS2OWLN1thdg
         bPxw==
X-Gm-Message-State: AJIora/kp73IvQmual27b1i0i/8Pk1vCGr/0rqCMquK2oMTK9saKwsL5
        CaMtN+Xl5RB7ZOQBsPiOMeEzohOthP1CVw==
X-Google-Smtp-Source: AGRyM1ugv1jxx/JN0oW9K3Yl7jaIlrh1njqQy82JzSjNdyri3wRI60ZNTaLb5a2L5o0qZA9DhbxmOA==
X-Received: by 2002:a05:600c:1d21:b0:3a3:3227:e482 with SMTP id l33-20020a05600c1d2100b003a33227e482mr1957986wms.121.1659083158678;
        Fri, 29 Jul 2022 01:25:58 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m20-20020a056000181400b0021e571a99d5sm2994802wrh.17.2022.07.29.01.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 01:25:58 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/9] docs: add and use include template for config/* includes
Date:   Fri, 29 Jul 2022 10:25:47 +0200
Message-Id: <patch-v2-1.9-ef6fa5450e7-20220729T081959Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1196.g8af3636bc64
In-Reply-To: <cover-v2-0.9-00000000000-20220729T081959Z-avarab@gmail.com>
References: <cover.1657819649.git.matheus.bernardino@usp.br> <cover-v2-0.9-00000000000-20220729T081959Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In b6a8d09f6d8 (gc docs: include the "gc.*" section from "config" in
"gc", 2019-04-07) the "git gc" documentation was made to include the
config/gc.txt in its "CONFIGURATION" section. We do that in several
other places, but "git gc" was the only one with a blurb above the
include to orient the reader.

We don't want readers to carefully scrutinize "git-config(1)" and
"git-gc(1)" looking for discrepancies, instead we should tell them
that the latter includes a part of the former.

This change formalizes that wording in two new templates to be
included, one for the "git gc" case where the entire section is
included from "git-config(1)", and another for when the inclusion of
"git-config(1)" follows discussion unique to that documentation. In
order to use that re-arrange the order of those being discussed in the
"git-merge(1)" documentation.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/Makefile                             | 1 +
 Documentation/git-fsck.txt                         | 2 ++
 Documentation/git-gc.txt                           | 3 +--
 Documentation/git-imap-send.txt                    | 2 ++
 Documentation/git-merge.txt                        | 5 ++++-
 Documentation/git-mergetool.txt                    | 3 +++
 Documentation/git-rebase.txt                       | 2 ++
 Documentation/includes/cmd-config-section-all.txt  | 3 +++
 Documentation/includes/cmd-config-section-rest.txt | 3 +++
 9 files changed, 21 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/includes/cmd-config-section-all.txt
 create mode 100644 Documentation/includes/cmd-config-section-rest.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 4f801f4e4c9..85b2088b888 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -51,6 +51,7 @@ HOWTO_TXT += $(wildcard howto/*.txt)
 
 DOC_DEP_TXT += $(wildcard *.txt)
 DOC_DEP_TXT += $(wildcard config/*.txt)
+DOC_DEP_TXT += $(wildcard includes/*.txt)
 
 ifdef MAN_FILTER
 MAN_TXT = $(filter $(MAN_FILTER),$(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT))
diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index 5088783dccb..29318ea957e 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.txt
@@ -107,6 +107,8 @@ care about this output and want to speed it up further.
 CONFIGURATION
 -------------
 
+include::includes/cmd-config-section-all.txt[]
+
 include::config/fsck.txt[]
 
 DISCUSSION
diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 0af7540a0c8..a65c9aa62d6 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -110,8 +110,7 @@ users and their repositories.
 CONFIGURATION
 -------------
 
-The below documentation is the same as what's found in
-linkgit:git-config[1]:
+include::includes/cmd-config-section-all.txt[]
 
 include::config/gc.txt[]
 
diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
index 63cf498ce9f..f7b18515141 100644
--- a/Documentation/git-imap-send.txt
+++ b/Documentation/git-imap-send.txt
@@ -54,6 +54,8 @@ CONFIGURATION
 To use the tool, `imap.folder` and either `imap.tunnel` or `imap.host` must be set
 to appropriate values.
 
+include::includes/cmd-config-section-rest.txt[]
+
 include::config/imap.txt[]
 
 EXAMPLES
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 3125473cc1d..6e5db8ef4c5 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -386,13 +386,16 @@ include::merge-strategies.txt[]
 
 CONFIGURATION
 -------------
-include::config/merge.txt[]
 
 branch.<name>.mergeOptions::
 	Sets default options for merging into branch <name>. The syntax and
 	supported options are the same as those of 'git merge', but option
 	values containing whitespace characters are currently not supported.
 
+include::includes/cmd-config-section-rest.txt[]
+
+include::config/merge.txt[]
+
 SEE ALSO
 --------
 linkgit:git-fmt-merge-msg[1], linkgit:git-pull[1],
diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index f784027bc13..c44e205629b 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -102,6 +102,9 @@ success of the resolution after the custom tool has exited.
 CONFIGURATION
 -------------
 :git-mergetool: 1
+
+include::includes/cmd-config-section-all.txt[]
+
 include::config/mergetool.txt[]
 
 TEMPORARY FILES
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index a872ab0fbd1..d9b6af8a571 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -1252,6 +1252,8 @@ merge cmake
 CONFIGURATION
 -------------
 
+include::includes/cmd-config-section-all.txt[]
+
 include::config/rebase.txt[]
 include::config/sequencer.txt[]
 
diff --git a/Documentation/includes/cmd-config-section-all.txt b/Documentation/includes/cmd-config-section-all.txt
new file mode 100644
index 00000000000..296a239f2ab
--- /dev/null
+++ b/Documentation/includes/cmd-config-section-all.txt
@@ -0,0 +1,3 @@
+Everything below this line in this section is selectively included
+from the linkgit:git-config[1] documentation. The content is the same
+as what's found there:
diff --git a/Documentation/includes/cmd-config-section-rest.txt b/Documentation/includes/cmd-config-section-rest.txt
new file mode 100644
index 00000000000..fe4721dac76
--- /dev/null
+++ b/Documentation/includes/cmd-config-section-rest.txt
@@ -0,0 +1,3 @@
+The discussion above this line is unique to this documentation, but
+everything below is included from section(s) in linkgit:git-config[1]
+aplicable to this command:
-- 
2.37.1.1196.g8af3636bc64

