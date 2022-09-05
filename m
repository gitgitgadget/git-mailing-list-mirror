Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B020ECAAD5
	for <git@archiver.kernel.org>; Mon,  5 Sep 2022 08:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237601AbiIEI1L (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Sep 2022 04:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237338AbiIEI0z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2022 04:26:55 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C06C2AF8
        for <git@vger.kernel.org>; Mon,  5 Sep 2022 01:26:53 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id az27so10281939wrb.6
        for <git@vger.kernel.org>; Mon, 05 Sep 2022 01:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=MY4cEWfxvWDsPb0Udi7F7NUEwfYzrCwE0SmdI6y8/+Q=;
        b=GbmVZFUEScJyzH++XkkyyPpKuTqPF3XTNgW8kLc07V+7K7uCtZEhqiX+PMJXD5iASL
         ebZhI9FGfXkv6+URVM62GvMPnhvKph2+DmySQFZZ/+mOFtd9Qp4E7zKhrMuV2h6vq+9M
         74WwvrkrWplOiGdcWtGW4Jpm3//zO41R8AHQQlPgsf79hS63P8L9FKu2dm1FOM5TqiQk
         LQjrzln8RbvsjMPGQYBI24rzOFj4X3cOOEJ1glowCAwv0tJaBJEoA08IylOG5Nf7B6BQ
         P8IRAzaH8k3BegO3wGDACwBIpsfrER4lN7X4q5NZHHPuuJSuzhe0n4YdJ6AG8oJWkJfh
         LvAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=MY4cEWfxvWDsPb0Udi7F7NUEwfYzrCwE0SmdI6y8/+Q=;
        b=7nr/1vGlw7LH7pUZ2pYk62mCUb1MknNpWH4VxwYP7koQG0O0ZnVP6H/MZLj8jtjHNB
         ensJtnmB7gQVvgyX7DIzkMPIZSxldASupuRSfkzXAAVhwky1FIzz3PLbat2PWL5G1wiV
         CoH8TOFTevK5KJBX5GgDAFoX2WTYBjVTV9kf9zD86gjOxKFSHWv95uLhfweL4sZ4UF44
         CXzuvPSgF++/Yw0D8u8J/uG4niD/hej6wKI7sryDQX8wdYhslY1yWUZVYobKp4PEtKXi
         hIvmi4PvMW8fg6rwTAERmKoTf2muMj07KZ5Z197wP4IH1m8VXCvWBeps1uwxOtcRLVWe
         U/Fw==
X-Gm-Message-State: ACgBeo1Ro0YxT6ZnNYoX0wvxUmQLqVssASf4LuNy1T7krhJB9/DVZsgx
        yW2wRLVSlx5mDibZ+dN9dmnYA3V5WfK5Rw==
X-Google-Smtp-Source: AA6agR5gWCGSUtnYGbMMF2PvoSU2mUGAOEkkROgK5WaoQVC7Fxn25YGD1OEvmRrvACC53k+Xqh1btw==
X-Received: by 2002:a05:6000:1563:b0:222:c70e:b2a5 with SMTP id 3-20020a056000156300b00222c70eb2a5mr24266798wrz.492.1662366411895;
        Mon, 05 Sep 2022 01:26:51 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i4-20020a05600c354400b003a2f6367049sm10564258wmq.48.2022.09.05.01.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 01:26:50 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 01/34] CodingGuidelines: update and clarify command-line conventions
Date:   Mon,  5 Sep 2022 10:26:12 +0200
Message-Id: <patch-01.34-b8cbd443987-20220902T092734Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1425.g73df845bcb2
In-Reply-To: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Edit the section which explains how to create a good SYNOPSIS section
for clarity and accuracy, it was mostly introduced in
c455bd8950e (CodingGuidelines: Add a section on writing documentation,
2010-11-04):

 * Change "extra" example to "file", which now naturally follows from
   previous "<file>..." example (one or more) to "[<file>...]" (zero or
   more).

 * Explain how we prefer spacing around "[]()" tokens and "|"
   alternatives, this is not a new policy, but just codifies what's
   already the pattern in the most wide use in the documentation.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/CodingGuidelines | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 4c756be517a..0d959f8c96b 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -650,8 +650,8 @@ Writing Documentation:
    (One or more of <file>.)
 
  Optional parts are enclosed in square brackets:
-   [<extra>]
-   (Zero or one <extra>.)
+   [<file>...]
+   (Zero or more of <file>.)
 
    --exec-path[=<path>]
    (Option with an optional argument.  Note that the "=" is inside the
@@ -665,6 +665,16 @@ Writing Documentation:
    [-q | --quiet]
    [--utf8 | --no-utf8]
 
+ Use spacing around "|" token(s), but not on the inside of "[]()"
+ tokens:
+   Do: [-q | --quiet]
+   Don't: [-q|--quiet]
+
+ Don't use spacing around "|" tokens when they're used to seperate the
+ alternate arguments of an option:
+    Do: --track[=(direct|inherit)]
+    Don't: --track[=(direct | inherit)]
+
  Parentheses are used for grouping:
    [(<rev> | <range>)...]
    (Any number of either <rev> or <range>.  Parens are needed to make
-- 
2.37.3.1425.g73df845bcb2

