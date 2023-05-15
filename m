Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CA4C77B7D
	for <git@archiver.kernel.org>; Mon, 15 May 2023 12:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241565AbjEOMNr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 08:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241379AbjEOMNl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 08:13:41 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF65E65
        for <git@vger.kernel.org>; Mon, 15 May 2023 05:13:19 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-307664010fdso11998579f8f.0
        for <git@vger.kernel.org>; Mon, 15 May 2023 05:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684152798; x=1686744798;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZcciXW4bVnfpjmGETKlCSrBasg/mBXiWS+E+hIM5QU=;
        b=UrY521e4xfuwRQD1TlW7KQaOHn4ktlipl/qkmE1YadiywkldK0FAFFXr/Nyvxp4NUj
         2wZmNlVj5DZ+187P5yRYwkfmRASSUp7d2UWvei01g53f2qqt76dGhdp5h8WXzFnijrqN
         RoiK1sPxWsFHlXMOAzp1pcl/M5iN4wb5E4b+ev2Gril0vX7FmtL2JfUuc3Pa3NiS3Vts
         LhC8+jj7fMmQXwqYfg0QquHMJalcpmFRBiP4dcUhizSW5/IPW2HX37trqWoHnLOzx4KG
         YC85yejIr4Vpv78y1LQoNRm6+9ezUVIFFc9jbFC/KQ4bfp7q6WbQYY7f5LU6fyN76XS+
         h0Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684152798; x=1686744798;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tZcciXW4bVnfpjmGETKlCSrBasg/mBXiWS+E+hIM5QU=;
        b=I8vEJJCFalD+QX3sgKQacr7GhRYqGPziuow6Vgnnj67zEcVogFd4I3q96AafyYdAk+
         ZJKWlkVxwhB1J6ZGPDEeBuaYA/T9JrmHRMBw/EoFoVYaBw66+KSVlfAbqixbvmyUBDlx
         69EKTH/5x46hssEMzUAyfqTObQlZH1UKmiXjoxocpH23MEwj0uZ2iwpFE/FAs5sckYfq
         X6UCaNbXbQApas3BXAGwrMHV1XLD+W056JHB++olLIBdGNDVLUi0DXXC7jBohtP4g3zM
         5EHi/Yp1g4k0JVXa8PQTtPlOaC2bzrtYgKAF9regZt1x+0M1TqxBomN5DlYa4QP5+8sH
         LJKg==
X-Gm-Message-State: AC+VfDwMA6pfGf0GxWvrHBnALkiFZMCRwC+0wLzlVB++eB5kVgnL8FJY
        +hlV69h1KxdVN2V2EXLo8g7Kf9NTjCE=
X-Google-Smtp-Source: ACHHUZ6d7c/UzOW1x/tzWGka5NYsAmxedIkcxML0OS6sxZnxq/0HwdNZLmVJqXf4dsP8FvGKrEVR/g==
X-Received: by 2002:a5d:4403:0:b0:307:8800:bbdb with SMTP id z3-20020a5d4403000000b003078800bbdbmr21509154wrq.58.1684152797866;
        Mon, 15 May 2023 05:13:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e7-20020adfe387000000b003064088a94fsm32075201wrm.16.2023.05.15.05.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 05:13:17 -0700 (PDT)
Message-Id: <94380984533e6677f48a71dc0ecdc5345ec89a17.1684152793.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1471.v3.git.git.1684152793.gitgitgadget@gmail.com>
References: <pull.1471.v2.git.git.1679478573.gitgitgadget@gmail.com>
        <pull.1471.v3.git.git.1684152793.gitgitgadget@gmail.com>
From:   "Sean Allred via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 15 May 2023 12:13:12 +0000
Subject: [PATCH v3 5/6] ls-remote doc: explain what each example does
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Sean Allred <allred.sean@gmail.com>,
        Sean Allred <code@seanallred.com>,
        Sean Allred <allred.sean@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sean Allred <allred.sean@gmail.com>

While it's good to have several examples to solidify the output pattern
and generally demonstrate how to use the command, most other EXAMPLES
sections (e.g., git-show-branch.txt, git-remote.txt) additionally
describe the problem/situation to which the example is applicable.

Follow this example in the ls-remote documentation.

Signed-off-by: Sean Allred <allred.sean@gmail.com>
---
 Documentation/git-ls-remote.txt | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index aabc1a7b90b..c0b2facef48 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -99,13 +99,18 @@ OPTIONS
 EXAMPLES
 --------
 
+* List all references matching given patterns:
++
 ----
 $ git ls-remote http://www.kernel.org/pub/scm/git/git.git master seen rc
 5fe978a5381f1fbad26a80e682ddd2a401966740	refs/heads/master
 c781a84b5204fb294c9ccc79f8b3baceeb32c061	refs/heads/seen
+----
 
-$ git remote add korg http://www.kernel.org/pub/scm/git/git.git
-$ git ls-remote --tags korg v\*
+* List only tags matching a given wildcard pattern:
++
+----
+$ git ls-remote --tags http://www.kernel.org/pub/scm/git/git.git v\*
 485a869c64a68cc5795dd99689797c5900f4716d	refs/tags/v2.39.2
 cbf04937d5b9fcf0a76c28f69e6294e9e3ecd7e6	refs/tags/v2.39.2^{}
 d4ca2e3147b409459955613c152220f4db848ee1	refs/tags/v2.40.0
-- 
gitgitgadget

