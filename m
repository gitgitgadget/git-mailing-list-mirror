Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33980C433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 09:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346875AbiEZJVf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 05:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346876AbiEZJVY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 05:21:24 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9657AC6E69
        for <git@vger.kernel.org>; Thu, 26 May 2022 02:21:11 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id z17so670044wmf.1
        for <git@vger.kernel.org>; Thu, 26 May 2022 02:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=i1fcypi1lc5gMfS/KDkqEFX5k2mvQoZzcsQsTX7NiCI=;
        b=HD8tJPTaDvshDtVMjKqRaqR2nOJtbD929qKsuMO6EJ/UAVpNhFPk72MzsOnknn8yMs
         v0QN1Rrbhtk/VnZZu2Cv2sk5OO+PjPHcgvdq27HLjdszmVWOBmG8EmMs5kOEGbhvi9kZ
         cmPAqW6qv8OYXo6ACczxdos3s0Yhcgy8oQvkNtVlUW3WWlfLqyNh9y0/ncroFsr2AwEH
         XDLsh+u9QryFiguiC2tWN0rtf8slPnu55zWl6xPZHmvjFubzFCkXMi/sD9GWaWBOloix
         xmEZ+9E2cpyB7dqcjXrbe/DSjv6snXWfxOKFwqE4MzpA9uj5u1dtPYprqJPHQK4h18RP
         MgAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=i1fcypi1lc5gMfS/KDkqEFX5k2mvQoZzcsQsTX7NiCI=;
        b=KmeIthTG+IxP/h1ilL0dDPSdr0KmUFD641W4iL+lI1aeF9lvGRlc4/exJ1MG4OjN9T
         itsyY2o9BBCUo5VsAwoyEMq6kqKq/kunDcYjZgR1ftB2+nFF3Fo/kegqQxIFnvJWLJtI
         EEB1AO0R8sBlCwN3Pnlzfss3yD+cKuY/a9gMzCXeSmWqyp0MIyicjOx86IakDg0itB9Q
         n0iruBpjtVOkUmKyYctBJlwXZbMJKk3nvgy6aIlL2JVGRCUXuC//wRPAwfF6b1PI5Vmf
         SStBfCR4w6AByCqGU9ZiGsCwBfl71gYotsS1CIikkNPNYmeL1uA3/fcDAEYEXFLHZTgX
         tN5A==
X-Gm-Message-State: AOAM533uBXCLN2tIXdkgq2HLdZ/9JV9sVaHMQSTEk9LCM1IV7nNT7jOO
        /qwGvPIRiiRUGiGEcWjqKles7vBeI24=
X-Google-Smtp-Source: ABdhPJzE9jfAf6qtZthG81rtpVCYFebu5I/QEkjb9RLu9XqNdifv81kCMHieB8Tp/Sq/0JjcVXwhIg==
X-Received: by 2002:a7b:c451:0:b0:397:4c13:1873 with SMTP id l17-20020a7bc451000000b003974c131873mr1382182wmi.151.1653556869874;
        Thu, 26 May 2022 02:21:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s10-20020adff80a000000b0020c5253d8besm1182699wrp.10.2022.05.26.02.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 02:21:09 -0700 (PDT)
Message-Id: <ece3eecdc4de44cdec1b6efa9079930721db85ad.1653556865.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1242.git.1653556865.gitgitgadget@gmail.com>
References: <pull.1242.git.1653556865.gitgitgadget@gmail.com>
From:   "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 26 May 2022 09:21:05 +0000
Subject: [PATCH 3/3] rebase: note `preserve` merges may be a pull config
 option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philip Oakley <philipoakley@iee.email>,
        Philip Oakley <philipoakley@iee.email>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philip Oakley <philipoakley@iee.email>

The `--preserve-merges` option was removed by v2.35.0. However
users may not be aware that it is also a Pull option, and it is
still offered by major IDE vendors such as Visual Studio.

Extend the `--preserve-merges` die message to also direct users to
the use of the `preserve` option in the `pull` config.

Signed-off-by: Philip Oakley <philipoakley@iee.email>
---
 builtin/rebase.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index aada25a8870..6fc0aaebbb8 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1205,7 +1205,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			     builtin_rebase_usage, 0);
 
 	if (preserve_merges_selected)
-		die(_("--preserve-merges was replaced by --rebase-merges"));
+		die(_("--preserve-merges was replaced by --rebase-merges\n"
+			"Your `pull` configuration, may also invoke this option."));
 
 	if (action != ACTION_NONE && total_argc != 2) {
 		usage_with_options(builtin_rebase_usage,
-- 
gitgitgadget
