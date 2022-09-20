Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13D7C6FA8B
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 00:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiITAUI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 20:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiITAUD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 20:20:03 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7313828E1A
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 17:20:00 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id k9so1786335wri.0
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 17:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=urmurQ+8NzmFPdzF9/pL+prln5VUERIcKXubaGlT5+0=;
        b=AISimjPUAMJtfYnQVlP35gV1nfYaOqWjsaDC+jEJimuMOzhZihofPQvv+O9YXJoOye
         yrQnaMUZ3WqgF/QSyIARD4fk7gEfJ0WLDVaivY1mHse8GR+F2mPO4eMgs6WLqdmMvl9t
         S7ba1ljVnEe/tZ8DxXLkEO8mqutqla1qsO2ku+0S2HiX18urHvHUo+sPuXtUYC4yv/Oa
         1/FwEvt6cJt8UkQqvhHmQO4XQstgdO/4st6x/fB5atUxgArspZDFiirm8fLICTZUq3ZM
         /LDKAaptVa/b537Wn5/Y/oW/s5/SGxUFnNOvvWncboD29CLokdtmmp/A6abdtY4dj617
         4fxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=urmurQ+8NzmFPdzF9/pL+prln5VUERIcKXubaGlT5+0=;
        b=vbNMxrGfjhftZFSqZDp1KaJaeC/GAPkr4U4SrPdcJ0WQ+AIRMKAMIGlsXKHd4+U9pg
         W87/6xicEYgbrURJDVxLorRx+hHF+qv/FMYQdMc+ZBlzNTkffznppd079FRtjc6oLNKU
         NoLOb82xhmhvwvZr6x6iVykmjR95z0V9ZLf50Z6Iuj6XeBfkBynmgy+coTZMDe1Tp59Z
         FVrmT9T7Yr259MrmMRULSmdy/s4GHsDjKoU/zpAC7uVmtM41aKVLniwmUScMkURfJic+
         NF1ZlNHVZb0Iu/DiiU9ZpZUQcHhSAcaatdhLZA54TyWmuxWphDtc6fUaNscZaVlrudKu
         NypQ==
X-Gm-Message-State: ACrzQf1aX2sgYOuOk8F13PkBpM9TWzeB64uTQ28JwKb1LxZi9jhtY2TT
        NAKi6rdwFxLssqEnewgIEjvJdP59hUo=
X-Google-Smtp-Source: AMsMyM4Wfbd3o5MlgBJduhyuJ9r07gJjRfuBCHPhzq2fVLo0Ourv2E+MGmfCEwB/U9pk9FEjErOJ/g==
X-Received: by 2002:a5d:64a1:0:b0:228:dab0:301d with SMTP id m1-20020a5d64a1000000b00228dab0301dmr11899946wrp.409.1663633198646;
        Mon, 19 Sep 2022 17:19:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b13-20020a056000054d00b0022abc6ded45sm15045914wrf.13.2022.09.19.17.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 17:19:58 -0700 (PDT)
Message-Id: <f97ca224ef4d33c098048fa9c80003dfa960da96.1663633195.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1360.git.1663633195.gitgitgadget@gmail.com>
References: <pull.1360.git.1663633195.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Sep 2022 00:19:55 +0000
Subject: [PATCH 2/2] version: fix builtin linking & documentation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Like most builtins, 'version' is documented in a corresponding
'Documentation/git-version.txt' and can be invoked with 'git version'.
However, the 'check-docs' Makefile target showed that it was "removed but
documented: git-version." This was cause by the fact that it is not built as
a standalone 'git-version' executable, therefore appearing "removed" to
'check-docs'.

Without a precedent for documented builtins that aren't built into an
executable *or* any clear reason why a standalone 'git-version' shouldn't
exist, the 'check-docs' error appears to correctly identify an issue. To
correct that mismatch, add 'git-version' to the 'BUILT_INS' list in the root
Makefile (indicating that the 'cmd_version()' function appears in a file
that is *not* 'builtin/version.c'). Additionally, to avoid the "no link"
message in 'check-docs', list 'git-version' as an "ancilliaryinterrogator"
(like 'git help') in 'command-list.txt'.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 .gitignore       | 1 +
 Makefile         | 1 +
 command-list.txt | 1 +
 3 files changed, 3 insertions(+)

diff --git a/.gitignore b/.gitignore
index 3d1b880101e..b3dcafcb331 100644
--- a/.gitignore
+++ b/.gitignore
@@ -181,6 +181,7 @@
 /git-verify-commit
 /git-verify-pack
 /git-verify-tag
+/git-version
 /git-web--browse
 /git-whatchanged
 /git-worktree
diff --git a/Makefile b/Makefile
index 35a07f80c52..cac3452edb9 100644
--- a/Makefile
+++ b/Makefile
@@ -818,6 +818,7 @@ BUILT_INS += git-show$X
 BUILT_INS += git-stage$X
 BUILT_INS += git-status$X
 BUILT_INS += git-switch$X
+BUILT_INS += git-version$X
 BUILT_INS += git-whatchanged$X
 
 # what 'all' will build but not install in gitexecdir
diff --git a/command-list.txt b/command-list.txt
index bb2e0a9214b..54b2a50f5f1 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -199,6 +199,7 @@ git-var                                 plumbinginterrogators
 git-verify-commit                       ancillaryinterrogators
 git-verify-pack                         plumbinginterrogators
 git-verify-tag                          ancillaryinterrogators
+git-version                             ancillaryinterrogators
 git-whatchanged                         ancillaryinterrogators          complete
 git-worktree                            mainporcelain
 git-write-tree                          plumbingmanipulators
-- 
gitgitgadget
