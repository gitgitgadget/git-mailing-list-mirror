Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F773C00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 23:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbiHJXfM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 19:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbiHJXe4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 19:34:56 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65F78FD61
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 16:34:45 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id bs25so1038186wrb.2
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 16:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=RhPe/2YGJzGbswB35npBDWGmS6OQlK0k/r1JD67kQvU=;
        b=E1bOPZ3j/+UdimcyxovqB5oD7LnqIJP8ylGT7pfAxcwx9ny4IIAVXNQqT43PpcL5Xb
         Iv7ud/V9rxpFfPYXah+b7WxtncSE1jClvfawfepmSaQoQfLdUJeZZjgcMJCIWOSO6Fp+
         yZ/uz+exnuZfeow2RPi9PPnHUoxbgH8j6eU3NmpjfK/3WOfULUi4e6KHXj6TbKd4sBkQ
         5M+i0thXMT22YZpnb1n3FXUeqLhZkJoY0IHi5UxdEPmP2E8bbBTyANh8ZbWP8DVY3HL9
         oRt3urBvqHj8yKh94iCZ639t4amEfeXUijDK3SXgurI7FXbEU+0Z7GNCUHGx9e+CuS0U
         G24g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=RhPe/2YGJzGbswB35npBDWGmS6OQlK0k/r1JD67kQvU=;
        b=d78HyzO+vhfT+o1HGrItjjzImkEP3zEagolkwdNXb/cypr8W7h3OHkz+gpSjpmtAzT
         bLmGsyO3TTNVsX14Et908O6dxtEa9AsdcE+LrZfWy6VsJsut3Um1O9lGpmozNwXTsu+k
         tZ/Wy8UcigfUcgGvh7sHv/SFBRJ0a1D+x+SWWZ1t28oTsttiz1iAy3opK9UEpC80y/VB
         GwohYhzkWKejN32XSwtHho0MnUcA83EUf/q1Xc8O3Bk0z6fHfMcYjC60ZHDptsS33Lyp
         GBf5tcOFau2H4hALWb6ja1wYQYACJtpijN4w7s0JYTZDIZnmcevpSc7oS5ufcCKIgqRR
         hyCA==
X-Gm-Message-State: ACgBeo3xH0bbcJhObMcAXJPtoeD0fn2khuYrlt7eSpSQk4LB9/5uiirL
        nje437ddb+/UbSdBL8WPv0g2NFXK8jg=
X-Google-Smtp-Source: AA6agR5FDv50Ic5KrHR5Uqw0OfDTR4XyerJpzrRYTbC006HR+/nCNIas5RpWNDk2r7p9tdpaUG9HDw==
X-Received: by 2002:a5d:5148:0:b0:223:664f:1e7f with SMTP id u8-20020a5d5148000000b00223664f1e7fmr6483596wrt.397.1660174483847;
        Wed, 10 Aug 2022 16:34:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h2-20020a5d4fc2000000b0021e8d205705sm17986136wrw.51.2022.08.10.16.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 16:34:43 -0700 (PDT)
Message-Id: <b64475f5b170666b76f28f86f9a9391c426b2d83.1660174473.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1310.v3.git.1660174473.gitgitgadget@gmail.com>
References: <pull.1310.v2.git.1659577543.gitgitgadget@gmail.com>
        <pull.1310.v3.git.1660174473.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 Aug 2022 23:34:33 +0000
Subject: [PATCH v3 11/11] scalar: update technical doc roadmap
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, johannes.schindelin@gmx.de,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Update the Scalar roadmap to reflect the completion of generalizing 'scalar
diagnose' into 'git diagnose' and 'git bugreport --diagnose'.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 Documentation/technical/scalar.txt | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/Documentation/technical/scalar.txt b/Documentation/technical/scalar.txt
index 08bc09c225a..f6353375f08 100644
--- a/Documentation/technical/scalar.txt
+++ b/Documentation/technical/scalar.txt
@@ -84,6 +84,9 @@ series have been accepted:
 
 - `scalar-diagnose`: The `scalar` command is taught the `diagnose` subcommand.
 
+- `scalar-generalize-diagnose`: Move the functionality of `scalar diagnose`
+  into `git diagnose` and `git bugreport --diagnose`.
+
 Roughly speaking (and subject to change), the following series are needed to
 "finish" this initial version of Scalar:
 
@@ -91,12 +94,6 @@ Roughly speaking (and subject to change), the following series are needed to
   and implement `scalar help`. At the end of this series, Scalar should be
   feature-complete from the perspective of a user.
 
-- Generalize features not specific to Scalar: In the spirit of making Scalar
-  configure only what is needed for large repo performance, move common
-  utilities into other parts of Git. Some of this will be internal-only, but one
-  major change will be generalizing `scalar diagnose` for use with any Git
-  repository.
-
 - Move Scalar to toplevel: Move Scalar out of `contrib/` and into the root of
   `git`, including updates to build and install it with the rest of Git. This
   change will incorporate Scalar into the Git CI and test framework, as well as
-- 
gitgitgadget
