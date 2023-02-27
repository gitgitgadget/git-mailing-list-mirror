Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADABC6FA8E
	for <git@archiver.kernel.org>; Mon, 27 Feb 2023 01:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjB0B5J (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Feb 2023 20:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjB0B5H (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Feb 2023 20:57:07 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F58C12F1B
        for <git@vger.kernel.org>; Sun, 26 Feb 2023 17:57:06 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id bt28so4624859wrb.8
        for <git@vger.kernel.org>; Sun, 26 Feb 2023 17:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qysv65G1RU+ff6CVcJ5vqaT1N+Mc2CX4rV7gRf1A/bA=;
        b=IBsn36qWPa5pgv1rcz00SQ7GpCxwMJ7R+zKEWhvc8aDa7vCWhueDaPRb37jJli0RGw
         BJduWpuWx73AoS4ntAijBBbS62RYYPHTU4aaH0siBP09U9SyzOJajjXS3O6QdflGtH0K
         9RijwOrcjH5fsMmzuizQEEWyH2F6gHgtLCb6pu2YO5LDxGu35a3uAAGj5Ypp1OQPnmgD
         bfOs8Ewn9a1TYskcbj8o3UZFWCAWgMVwEfBpcTj4Ay8gcoyMRRiJFYeUJ90abFV1J+ra
         /CHIQqgOr4xUqUKHTm4qGYaGLNPb6TkJWXT8Nx6z2Pql2QDhDTCranrTupT55hYoRvYA
         ceRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qysv65G1RU+ff6CVcJ5vqaT1N+Mc2CX4rV7gRf1A/bA=;
        b=Gx3MQVqa7EyFAkPHzKmOUBgP4TnjN+rSbl0nRJ609kpwHTZT7RpA6N9VLBFqTrvHuX
         69Q6/62e9QotU1/1CfzLs/iqVAe0yD2pGqxja+gy/JiTRK+nxQm9fhRkGW44lQcxbkZl
         BWmqeiPNA9006wmLtZByU0tZaRQe5pWKDPzCIXhclqoK7ncowx7IkQYrJ7J3wa7TLWsX
         eZpgjwhSgBLWfsr8bdBz8CcGmdd80b5JR1HtA0s9dPBsb14ud2FW4yOaYaB+8BO2W+Jz
         tDP5xUazFX/mT0fmCBFu8yUAgQQigje4BAASCt/uVCfGPmKxKMKZIWNW6dq/gXYQE4H5
         pLmw==
X-Gm-Message-State: AO0yUKWRbgDAQivHY1wbxy6JolcJ/MaBzXyWr++mio4ke7jQ5M2q5ymY
        H0kmCAY7POIq7cM8hSy3Kd1T40Tkw9Q=
X-Google-Smtp-Source: AK7set+D9XNch8JJ/iY/DGY9bX4PIwLbMEbdLa/yP5jKPMZN6oSYsDbOHgfYQakquQDUI1Zxnahz2w==
X-Received: by 2002:adf:ec11:0:b0:2c5:98f2:5b16 with SMTP id x17-20020adfec11000000b002c598f25b16mr19205844wrn.1.1677463024628;
        Sun, 26 Feb 2023 17:57:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m7-20020adfe947000000b002c70f5627d5sm5579943wrn.63.2023.02.26.17.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 17:57:04 -0800 (PST)
Message-Id: <857d2435caf6211cd5a1baa6c9d77311ce7ba745.1677463022.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1465.v3.git.1677463022.gitgitgadget@gmail.com>
References: <pull.1465.v2.git.1675529298.gitgitgadget@gmail.com>
        <pull.1465.v3.git.1677463022.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Feb 2023 01:57:01 +0000
Subject: [PATCH v3 1/2] receive-pack: fix funny ref error messsage
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
 t/t5516-fetch-push.sh  | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

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
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 98a27a2948b..f37861efc40 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -401,6 +401,11 @@ test_expect_success 'push with ambiguity' '
 
 '
 
+test_expect_success 'push with onelevel ref' '
+	mk_test testrepo heads/main &&
+	test_must_fail git push testrepo HEAD:refs/onelevel
+'
+
 test_expect_success 'push with colon-less refspec (1)' '
 
 	mk_test testrepo heads/frotz tags/frotz &&
-- 
gitgitgadget

