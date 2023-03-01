Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA70C64ED6
	for <git@archiver.kernel.org>; Wed,  1 Mar 2023 10:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjCAKUg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Mar 2023 05:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjCAKUe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2023 05:20:34 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DD1199D1
        for <git@vger.kernel.org>; Wed,  1 Mar 2023 02:20:33 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id j2so12638529wrh.9
        for <git@vger.kernel.org>; Wed, 01 Mar 2023 02:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4N8cOaOsyFzLmyRhD0NMlgD3QIcbgjdgzAcYJbr6p+Q=;
        b=RbQXZZWVW7mFrA2Z+kbVS3cwLwuBZnNK67f8iyEvp5MEqtQJkFyv1MhsnYkIDnmc2/
         LXX278ht6Z+JLaBkXoiMt7eR1eLWXqHNeqDU+x+w7q9Cu5zmopKwK7tP/LlawNHM9vql
         4ATVzNff/7lAf4pxpdhUC6RUSU0+sS8IMmN9icvmVHzaSmYQRIJ8WmSS8HQ/HBeCtblj
         q1GAhcIqRSbYGaYO83EkSfEBzRNTl9801oeBEarOdhxqHtC6QlsOpA4ogO3dM4m7c4nT
         NFrdUEMDJaz7ZbcN20Wf2Khi1B0O2K2p3Yk6ZETZEt3gc7cCSXCMwgolGhkLxdL5GIqJ
         bpew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4N8cOaOsyFzLmyRhD0NMlgD3QIcbgjdgzAcYJbr6p+Q=;
        b=ik9N/EBGdwnARw0uDZebuc3MuQbX0njn4kWdJbThGJmKLcVcNbTf2aKBl+0I8ZOR5Z
         gepXfTEnCfU8ToiA2UawmK03YGxYR9+HJN6RUJvtRSH8vowYbG2LbmpG76JMujNPBIZ9
         rZsc7wc0MNXk4RybQ89kJBJ1Wl7RxINTKpNU/XrVANKg4ILfdBSdqjDkmSevoDAw9xDN
         4ahDYRdh9jOWIR2UTogVFZkkHeiPsMSSpgeFVzmFJGvSk5nEIUTaK4ZO/Cq65E4GiE/G
         1HshGKEjzlKXJn0HWlneK311il7Yq64MSv1Vm3r3b2jlk24V+L34JSe3mjme9BuBv0Co
         OHGA==
X-Gm-Message-State: AO0yUKVn942qv1NwF2tBc1wDYd6dCSREvHglXkW7rBKmbQvGFS8C1Y0N
        RbE1FUwfhLHgljYSmVwF6UwvJ0st5p8=
X-Google-Smtp-Source: AK7set9QHIWq2oMB88yc5ITp7Xv4NJdSWYPbnHFzIWyuzRqf2K+zh5CTkC2dHRqTV+MgNVkOiJ7yBQ==
X-Received: by 2002:adf:e68f:0:b0:2cb:a82c:2523 with SMTP id r15-20020adfe68f000000b002cba82c2523mr4908655wrm.35.1677666031598;
        Wed, 01 Mar 2023 02:20:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m4-20020a05600c4f4400b003e209b45f6bsm20204002wmq.29.2023.03.01.02.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 02:20:31 -0800 (PST)
Message-Id: <eef7bca63c616d745bc748fd53bdcbaf6551160b.1677666029.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1465.v4.git.1677666029.gitgitgadget@gmail.com>
References: <pull.1465.v3.git.1677463022.gitgitgadget@gmail.com>
        <pull.1465.v4.git.1677666029.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Mar 2023 10:20:28 +0000
Subject: [PATCH v4 1/2] receive-pack: fix funny ref error messsage
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>, ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

When the user deletes the remote one level branch through
"git push origin -d refs/foo", remote will return an error:
"refusing to create funny ref 'refs/foo' remotely", here we
are not creating "refs/foo" instead wants to delete it, so a
better error description here would be: "refusing to update
funny ref 'refs/foo' remotely".

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 builtin/receive-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index cd5c7a28eff..c24616a3ac6 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1464,7 +1464,7 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 
 	/* only refs/... are allowed */
 	if (!starts_with(name, "refs/") || check_refname_format(name + 5, 0)) {
-		rp_error("refusing to create funny ref '%s' remotely", name);
+		rp_error("refusing to update funny ref '%s' remotely", name);
 		ret = "funny refname";
 		goto out;
 	}
-- 
gitgitgadget

