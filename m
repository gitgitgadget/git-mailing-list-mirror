Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919F6C7EE43
	for <git@archiver.kernel.org>; Sat, 10 Jun 2023 20:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbjFJUWa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jun 2023 16:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjFJUVz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2023 16:21:55 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4123C3ABB
        for <git@vger.kernel.org>; Sat, 10 Jun 2023 13:21:45 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f7f6341b99so22074665e9.2
        for <git@vger.kernel.org>; Sat, 10 Jun 2023 13:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686428503; x=1689020503;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3jMKHyrK/DvKpC9ic6bhimoZDxB2Ab5NFj9E/8tc6ko=;
        b=JUVzDMnwYZUJ/Cfb4FEFT71Hu7VGD6PHYUmE2EVdLbCX7Y0dV/p5MKoOE+9anZSMM2
         ldpSvZrUV3p+BKj6zKvlnwYh4LYpEuvBFYfKt2mhnfXaXpD5+PFBW+/VjtcF3m/nwfEh
         GUrUGsy5dh/uwcFTMUN3iZpedRbJEBApdhlEKVEG0VQbxYaLxIFxmn+l75xS2XCKpD9E
         ZtgrZthKlKjVNnJU4b5j5TfERPJb7bEgFO5riXbr8J0vijuZAaVXB07xKit80BJDQOOj
         AfSov3Li540vgNJ8vhKG2zm+MMhzLlJpgreuE9gddBGaFPNudf5HPTI5347dpHeCORJ0
         HhHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686428503; x=1689020503;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3jMKHyrK/DvKpC9ic6bhimoZDxB2Ab5NFj9E/8tc6ko=;
        b=TfQEgrG0Q3of4V8K5Bh5MdNz/84Z5LzHZ/A7jqzimIObb/Nr1SOc/7Dcj4mRXmKh9U
         W4J8wFftbydnI2p46iSaZUHDy+pPmsFuiUa1Ybjkb8PVJ0u1SnCLCZyX7JgymFxecjku
         xNnaOL4ANfS1i+1XorSk7t+xKPSk50c8mpjeICch/0/5jQHjrFe1ljyuJTxEItYOExLx
         hkd9rwkD2WOgNFAVaOj2IqFTYzWvxv0wpAh68DPc8IbNzzUGDtvl2n8HnIKTpfiMVLoO
         G985PaP4kVskPd4nWd4v1jIkdEFg3LOIr+UJmcKHetBZjXYm+217eJ6cypmzY1OkgPhr
         Ii8w==
X-Gm-Message-State: AC+VfDyZ4jlqNhF57KL+cLdpbfkcT29adZ6AgGy/rSeN6F/F0XH2exq5
        Fb64Rnob6E+Yn258gRENuBpzVlXmV1I=
X-Google-Smtp-Source: ACHHUZ70ZG1arz9kd6m7kZ5fgJ2/Ll550mlr6w6H2plWC8Qwq0VFXz/ulczFqK1HbTvQwFLQa1ZdpA==
X-Received: by 2002:a05:600c:2044:b0:3f7:e800:abc8 with SMTP id p4-20020a05600c204400b003f7e800abc8mr3567904wmg.15.1686428503495;
        Sat, 10 Jun 2023 13:21:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o40-20020a05600c512800b003f4283f5c1bsm7510232wms.2.2023.06.10.13.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 13:21:43 -0700 (PDT)
Message-Id: <93b6233f0dd89d36c0eec7a4768f8b7d22db755b.1686428485.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
References: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 10 Jun 2023 20:21:24 +0000
Subject: [PATCH 25/25] diff.c: mention completion above add_diff_options
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Add a comment on top of add_diff_options, where common diff options are
listed, mentioning __git_diff_common_options in the completion script,
in the hope that contributors update it when they add new diff flags.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 diff.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/diff.c b/diff.c
index 3c88c37908d..fda7bc91f85 100644
--- a/diff.c
+++ b/diff.c
@@ -5491,6 +5491,9 @@ static int diff_opt_rotate_to(const struct option *opt, const char *arg, int uns
 	return 0;
 }
 
+/* Consider adding new flags to __git_diff_common_options
+ * in contrib/completion/git-completion.bash
+ */
 struct option *add_diff_options(const struct option *opts,
 				struct diff_options *options)
 {
-- 
gitgitgadget
