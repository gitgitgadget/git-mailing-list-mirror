Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C20C433FE
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 19:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiKHTIk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 14:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiKHTIh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 14:08:37 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0200A1A80A
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 11:08:34 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id a14so22541600wru.5
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 11:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SswaFNJWCntnC6FA+tuyd7rQ0d13mf50TgJxb+dBArQ=;
        b=LqMvCLO3jnhDkcwHpUp1S/0QPAOmjWfw2DIKvjeJPe16mQlHLdYipfnA7c5VNO8tkJ
         q+t2nc3R5Vm7/spJdgIgmWZeFxOa0bslTu9wfcO0cUrsM11CqDSnoSdWA7LAjbfTUX8j
         GEwKtijVtIi6Vl3J3iGk+98l8wc+VcMQghIz1qV2BPkxaqGOv0fTjUuSq82GWrpYO0g6
         xddCeU10kLzdJSRTtlRxcN35YVBUOL3hjUuxC/KuzUA/AsmBaexqIAW2TfaB/oxFIoxg
         cdFRpDFfRA043tPSoFHeGRHxc07sFnWYrqVynvWJYwQ4GSe8H4feOMU/fZV6EPAACUq1
         1FBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SswaFNJWCntnC6FA+tuyd7rQ0d13mf50TgJxb+dBArQ=;
        b=B8BiEh8Ezhg4twNbX8+brFkOjyUR+puLpTe2v1KE3s1PJQ14H1a7f67X+MsFS0SVSp
         JaU6s+HuAJG81QwQQahDsbHVpr5wx4tfKrpXaJiugn8ycFfciGc/Tmq/AQQ7QwnrtXx0
         05Yty4zrCf6mvUNwfigwgNn8mGLqPXniXN8yKGm1LCx1jn41Sg4CSRHkkbIu+N+uykfV
         JM+YfqdvkxdVaQagZbCJY4gUZyQdy0gRNmtkK6A+COQ5wZ0WvAXEJq2A4NZJ//q1MA6m
         uzRTWOQDHTPguQZFRVitFsT5B7tU4/zEr6xKQs8wd6jHTITmjrEWkBUHGpE9PQBJsxyD
         8Lsw==
X-Gm-Message-State: ACrzQf0LFYC7teO+wDDmA6UCSqnuxsQZ5H1MlfDBCFkD0IRyLYz1M+BP
        2wcHDnoMwx4TR6P7Pxl74cLcLFLpiw0=
X-Google-Smtp-Source: AMsMyM7SDTi7vtDD+/sVYCkdJSqfpxFlTIEy25SYerRXmM4a6ws6tH+Ze9Pw6Mk/JjYW5YBxVW6x8Q==
X-Received: by 2002:adf:de10:0:b0:236:73c0:75ae with SMTP id b16-20020adfde10000000b0023673c075aemr37058096wrm.530.1667934512262;
        Tue, 08 Nov 2022 11:08:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g4-20020a5d5404000000b00228d52b935asm11218654wrv.71.2022.11.08.11.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 11:08:31 -0800 (PST)
Message-Id: <a445304594c6139770439c49cf18f10c6757cbab.1667934510.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1375.git.git.1667934510.gitgitgadget@gmail.com>
References: <pull.1375.git.git.1667934510.gitgitgadget@gmail.com>
From:   "Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Nov 2022 19:08:27 +0000
Subject: [PATCH 1/4] chainlint: add explanatory comments
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric Sunshine <sunshine@sunshineco.com>

The logic in TestParser::accumulate() for detecting broken &&-chains is
mostly well-commented, but a couple branches which were deemed obvious
and straightforward lack comments. In retrospect, though, these cases
may give future readers pause, so comment them, as well.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/chainlint.pl | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/t/chainlint.pl b/t/chainlint.pl
index 976db4b8a01..9908de6c758 100755
--- a/t/chainlint.pl
+++ b/t/chainlint.pl
@@ -505,7 +505,11 @@ my @safe_endings = (
 
 sub accumulate {
 	my ($self, $tokens, $cmd) = @_;
+
+	# no previous command to check for missing "&&"
 	goto DONE unless @$tokens;
+
+	# new command is empty line; can't yet check if previous is missing "&&"
 	goto DONE if @$cmd == 1 && $$cmd[0] eq "\n";
 
 	# did previous command end with "&&", "|", "|| return" or similar?
-- 
gitgitgadget

