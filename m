Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5885FC2BA4C
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 08:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238558AbiAZImD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 03:42:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238548AbiAZIl6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 03:41:58 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29C5C06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 00:41:57 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id s9so8560143wrb.6
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 00:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8NExF/OXA41vxMib/2H60zyyvrhnSsyIIZN6k1MNhaw=;
        b=AWCRUpAg2hdrnQc5Bd7G6DQmg3H0zmJ95gmeKS0V4iBP5PdGzzqCK3M4fiDV5Ma/ba
         Gm2jFMvydr/NkFMlKzF2tyQFJHfylxEbSIB9UVRqUhD0uhGNXIkSYnLzABxeTXECLa/A
         PGl376I1fL8mYTJZgrEAKw7MabQKpL+vO1XVeCp0ov1UIlxS5PUeaY1lhBwmj7/HxxEG
         PK7Q6DjKntxvwfa88hnIr90BEp05P7l3Rl/xPwUHHGLg6kilvrwCn8BCYOwWe5XLcLoB
         qzDJrbYalw8aPuLrWtunBEcuo1qH7r6CvoiTwVlGlnJIfiprqGf5vYLWD/sJB5Aq8ftx
         Cj1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8NExF/OXA41vxMib/2H60zyyvrhnSsyIIZN6k1MNhaw=;
        b=xIHqoxoyA0g/e9JCr+8Gnq8wgz0dYK16ms6wGjINt1HlyHOtiIl91QOtlZ+wwesvhZ
         ldjMu4qMmQAF0V4DoSSlxdwg1NEzuELBOOm5rN1u12YiX3lv08OQRq26vrFww+ZL6tOV
         Sm30Otnvt3Hb73yZApP+4Pqx1Yqjb33XndXoKWt5d91qIkdH7snmoUrg7/Q3KqAA8rqW
         +tG605bOSoNRUXqnCFxkmu+X8/pGruZYA+raOly8g7opXpSrif5V01+imxCtX38RvfK1
         C24jkkZH/aIl/NpVa9Jj2WIHDc11xCTPJKiuOTNJlhVXNYiBr0sq/xGaXHTC4SS1H+cT
         jc4A==
X-Gm-Message-State: AOAM530ki7qK+IzSL1ZzlRfLqThi4UnIhOkKUr1wLgHfCKcRvfISFPwg
        tRT/0J1I6h3VIo+Hdt9xvY8LR65lNlU=
X-Google-Smtp-Source: ABdhPJwxgAV3doLCl68Yy3OijlRpgaPk+KHTvn6fCnjqFHVPqRUZAaGvGTlgyUFXUJOZGzbzV25FtA==
X-Received: by 2002:a05:6000:1569:: with SMTP id 9mr13451934wrz.265.1643186516072;
        Wed, 26 Jan 2022 00:41:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m2sm2729483wmq.35.2022.01.26.00.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 00:41:55 -0800 (PST)
Message-Id: <3a2cdce554a1755210592f3b9bb056d936ca98b6.1643186507.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1128.git.1643186507.gitgitgadget@gmail.com>
References: <pull.1128.git.1643186507.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 26 Jan 2022 08:41:47 +0000
Subject: [PATCH 5/5] scalar diagnose: show a spinner while staging content
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

It can take a while to gather all the information that `scalar diagnose`
wants to accumulate. Typically this happens when the user is in need of
quick solutions and therefore their patience is tested already. By
showing a little spinner that spins around, we hope to help the user
muster just a tiny bit more patience until `scalar diagnose` is done.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/scalar/scalar.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index c0ad4948215..224329f38f5 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -259,12 +259,26 @@ static int unregister_dir(void)
 	return res;
 }
 
+static void spinner(void)
+{
+	static const char whee[] = "|\010/\010-\010\\\010", *next = whee;
+
+	if (!next)
+		return;
+	if (write(2, next, 2) < 0)
+		next = NULL;
+	else
+		next = next[2] ? next + 2 : whee;
+}
+
 static int stage(const char *git_dir, struct strbuf *buf, const char *path)
 {
 	struct strbuf cacheinfo = STRBUF_INIT;
 	struct child_process cp = CHILD_PROCESS_INIT;
 	int res;
 
+	spinner();
+
 	strbuf_addstr(&cacheinfo, "100644,");
 
 	cp.git_cmd = 1;
-- 
gitgitgadget
