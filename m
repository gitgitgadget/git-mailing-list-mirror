Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA633C433FE
	for <git@archiver.kernel.org>; Mon,  7 Feb 2022 21:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241141AbiBGVdZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 16:33:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241044AbiBGVdM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 16:33:12 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBCEC043181
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 13:33:11 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id f17so27210689wrx.1
        for <git@vger.kernel.org>; Mon, 07 Feb 2022 13:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=L70Bj04IYq30hwhq9Ie3sb3mr5ltQTCSdsjilrUOVnQ=;
        b=jlQRlW8XYAtY3MACIC2oaLWnXD3nVGKN81w6SGo3fPsp80LGAHOVopndtRffB5FGIz
         CpIRIPeFeTYgCT3bK58ORzkyKLlfKt+HwfvedMlX3Ow7SLeD34/4HbcK4l0qrqPWbyQI
         OoAojKY8SAZNh7aa/vLotYLCx5gcXsIDCmH5AOFa6zp5Et6yz+Rz7Mn6F7pjDBD/1geo
         vf4t+5NsO+pzABFBk/5gMhEFwVNPVRiX6klZX5tkR1E4EoYLavgWoLa5XdylTcuJuGZb
         IAnep2u5BfETHzEplrZMGJEJVAX7w4aYS1sFYDXvHC3Pip58eQqMj6a/3nXAOH4/k721
         SksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=L70Bj04IYq30hwhq9Ie3sb3mr5ltQTCSdsjilrUOVnQ=;
        b=0fsAUDny98lZ4A6Fiv8aRIraapHWYjZWE4drWqfrRgNV+93bv3p4r4pj4gXgJuhzpa
         daUNTn5R0mzED8EQXtFdprngCERGTHax2xclIHd/96SyzKxWXYF+Q2uDYy8nNKxftBsX
         CtxdXDxjHwnzA/dN4uniwxjzQ/RcCvFZO/1wzszUotykxu22tHG5zLfg+D42/ekDSKdu
         Wpz2nWNWZ2OQpQHvK9D34+Y0Lp1h61fwDwf+KZ/ZoRH9fE0K7ZTvR3i0kVbQJrxU3x/x
         esPGiHcvBpicCbTfBYMuDudA4PWMVRDt4EWnleEfojAULdVzJikJisBmc+vwFWCcIofr
         tQzg==
X-Gm-Message-State: AOAM531iC0boKYBxbV4zEf/JW4pK6eR3r2c9OAVqGz0m95xSRyf+46lH
        DPYvEEmTVmUfPC8+XrZ++AEGlhPI7IE=
X-Google-Smtp-Source: ABdhPJwHwcBaoi0r75tyfCs4F9fC5xMnHNtHbVqylNW8Gd+xMdZE4h/Uw/I0e8C/Wo1Ev2eiiNeCoQ==
X-Received: by 2002:adf:a2da:: with SMTP id t26mr1062127wra.290.1644269590475;
        Mon, 07 Feb 2022 13:33:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y3sm12015440wry.109.2022.02.07.13.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 13:33:09 -0800 (PST)
Message-Id: <f687a0bfa167aa453a531ad4d2ec9687887a90e7.1644269584.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1101.v6.git.1644269583.gitgitgadget@gmail.com>
References: <pull.1101.v5.git.1643641259.gitgitgadget@gmail.com>
        <pull.1101.v6.git.1644269583.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Feb 2022 21:33:03 +0000
Subject: [PATCH v6 6/6] config: make git_configset_get_string_tmp() private
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, sunshine@sunshineco.com, allred.sean@gmail.com,
        gitster@pobox.com, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
        derrickstolee@github.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

This method was created in f1de981e8 (config: fix leaks from
git_config_get_string_const(), 2020-08-14) but its only use was in the
repo_config_get_string_tmp() method, also declared in config.h and
implemented in config.c. Since this is otherwise unused and is a very
similar implementation to git_configset_get_value(), let's remove this
declaration.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 config.c | 4 ++--
 config.h | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/config.c b/config.c
index 1a03ced1a54..870b22dd2ff 100644
--- a/config.c
+++ b/config.c
@@ -2179,8 +2179,8 @@ int git_configset_get_string(struct config_set *cs, const char *key, char **dest
 		return 1;
 }
 
-int git_configset_get_string_tmp(struct config_set *cs, const char *key,
-				 const char **dest)
+static int git_configset_get_string_tmp(struct config_set *cs, const char *key,
+					const char **dest)
 {
 	const char *value;
 	if (!git_configset_get_value(cs, key, &value)) {
diff --git a/config.h b/config.h
index 1d98ad269bd..184aef1eca4 100644
--- a/config.h
+++ b/config.h
@@ -494,7 +494,6 @@ void git_configset_clear(struct config_set *cs);
 int git_configset_get_value(struct config_set *cs, const char *key, const char **dest);
 
 int git_configset_get_string(struct config_set *cs, const char *key, char **dest);
-int git_configset_get_string_tmp(struct config_set *cs, const char *key, const char **dest);
 int git_configset_get_int(struct config_set *cs, const char *key, int *dest);
 int git_configset_get_ulong(struct config_set *cs, const char *key, unsigned long *dest);
 int git_configset_get_bool(struct config_set *cs, const char *key, int *dest);
-- 
gitgitgadget
