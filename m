Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6446FC77B71
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 17:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjDNR6u (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 13:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjDNR6p (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 13:58:45 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C4E7D91
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 10:58:43 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id v20-20020a05600c471400b003ed8826253aso5517253wmo.0
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 10:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681495121; x=1684087121;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OXZgtomDUzZgqaysrY3KHewgOZIRwk9evIrjx/Ge6ec=;
        b=LjvOZ2A/kO643jsuJMZGrLhw6WRDZHM0mgy3t3GqWUe15KN7iVi6Rs+L+j91zhsRo2
         vdU/hMfyWugRMvJcZIerI6nS7ZeV6y0A6SqVM0YwZqVzExWLHK5YCrQThqL0VDp7/JzY
         1nc1br359RmIWFhqe7aVFd9bSttOFVJ/ovMFw8h8SeowWLgWl7P0CTq8HNP+fLXPmSH9
         rNdeyaNmC1yFCI6Ol9OyytRaOBSjpqfQ95AzB65ODd5sJRKZTn35sOaqsv9tQT8gs8T8
         O+ptRnEi5pCuuD1+e/92FGo4GVg7qh6cyvEZi30L05VOEow8UOpwrqMMZeLopXL9W5Q0
         /uDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681495121; x=1684087121;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OXZgtomDUzZgqaysrY3KHewgOZIRwk9evIrjx/Ge6ec=;
        b=OY5QoGwIM+t6a39WdTvTRImzpm6sqKruPBiKvYYjQTXlkvLirx/wbxk8u1GhxOXyRH
         lEziCejU5Z7Y+NyJr7jmQO4/j8x6XHWm1tAv6dKV1gkHVM9mbgZVy5D7O6ncX90V+Hlk
         VAoV71FCXpnfDTWZWAiuBXigvSTZyHMwQENqq0khbwAP5cQHcmA27ezzdUug5VxjKF5c
         Nsj/GkzKBOlwk3who0Zftqc6vSMorPs0KzRWL2XhTa0bqueNXRYn9Eop6FLk4EiPEaEq
         +DzevQsmuMAyEKW5vICjStiuo7W+rf+8FG4k7tvD7/Bj1E6nO0ftaSDMsofy6yE59tQC
         Ekwg==
X-Gm-Message-State: AAQBX9fmufGTW4W6K8hc4Ik2fx2xIPKeKMbpW0FIV4GX29CoQN2aa9UH
        +3je/EecByGFM31u1boIHTKxI8MTJC4=
X-Google-Smtp-Source: AKy350YwzBYZ8yJnualqce+6D5pwXIRswk/iMewQiT99wZx3KnxzviE83mP821ghwyd/MIwQ5lJ8Gw==
X-Received: by 2002:a7b:cbcc:0:b0:3ed:eab9:976a with SMTP id n12-20020a7bcbcc000000b003edeab9976amr4624311wmi.5.1681495121262;
        Fri, 14 Apr 2023 10:58:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p6-20020a1c7406000000b003ed2c0a0f37sm4777362wmc.35.2023.04.14.10.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 10:58:40 -0700 (PDT)
Message-Id: <f3a47758f9dce20c29ffb776bffaf73e238c20d1.1681495119.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1515.git.1681495119.gitgitgadget@gmail.com>
References: <pull.1515.git.1681495119.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 Apr 2023 17:58:35 +0000
Subject: [PATCH 2/5] completion: complete REVERT_HEAD and BISECT_HEAD
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

The pseudorefs REVERT_HEAD and BISECT_HEAD are not suggested
by the __git_refs function. Add them there.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index dc95c34cc85..bcda376735c 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -767,7 +767,7 @@ __git_refs ()
 			track=""
 			;;
 		*)
-			for i in HEAD FETCH_HEAD ORIG_HEAD MERGE_HEAD REBASE_HEAD CHERRY_PICK_HEAD; do
+			for i in HEAD FETCH_HEAD ORIG_HEAD MERGE_HEAD REBASE_HEAD CHERRY_PICK_HEAD REVERT_HEAD BISECT_HEAD; do
 				case "$i" in
 				$match*|$umatch*)
 					if [ -e "$dir/$i" ]; then
-- 
gitgitgadget

