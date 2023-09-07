Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF1EEC875F
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 22:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241619AbjIGWUf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 18:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234773AbjIGWUX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 18:20:23 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9171E1BC7
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 15:20:19 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-307d58b3efbso1294078f8f.0
        for <git@vger.kernel.org>; Thu, 07 Sep 2023 15:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694125218; x=1694730018; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YH2eCz+ojYjlC28yymk59q16Hks8uxKTS4lfGNd8zkY=;
        b=NpycQfuRrkNHpn6jmXQw0WSte39JWGMIxBEJc/ZstMHtW1tUtBSInK2E4d7kGnrtP4
         ebw9BhSPvkK7DXytb558oExTTT4n3yrXCInw6/RuRFgsnyjY2dqkY3xl6yRFi2YYFDfq
         8ct7+2+F9fo/x49Pf+V56Iqej2RO3MY2f6t21Ac1lfhIpgYbAra14CXwGdbbbJ1shIqx
         RkBHBiwgJ4fiKc/TArxg+xQtAPDwkBdgU7KxnN+6QyRRpdHIxZkcZsZdi2xLCLFuFICE
         S6vAS82PZnCPQhmOkMj/iBv5e+wrnbWxivPrsf8dj4e59C0pBeIgc8CtMsszuvQLc7pL
         Dj5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694125218; x=1694730018;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YH2eCz+ojYjlC28yymk59q16Hks8uxKTS4lfGNd8zkY=;
        b=sfUIdw3W1cWitEMe91jg5SQqQpRb4a5BjjlxRtwTMKTyMoBXf5q9pAq42l/XQ//oAX
         I62XGVL56WM+q7bu5lH6d31N9FcmWuCI5sQkZXU1eBq7H7YQyrrznZwryfF8R4FT0H8g
         Yiqbj4sk5sCB3eHxZqoy279SQwehnmnhJyJxGgF2guysm7ofOcHHHz1x1bJY8ppse9zk
         c2/DJ/g9XcRCqwN041U3kgA11zwT8Lcu7VAyWoYYgJdW3QrdYtWLw87nNoeFRtmp71Xb
         uIQSxBWs4hIpSfPPPhirw3L9iUbsBVdq+HoIyUc1ql3WUfBZ67ja2wg/O8rN0g+yDo8B
         xYrA==
X-Gm-Message-State: AOJu0Yw8WWlziUuRFvPoWt3zrRhbZ83ybKZkC1iAZG45JW4kM7vYWcO6
        FRLlnk72KoBhhNAmpgP2HOWRvu1ywT8=
X-Google-Smtp-Source: AGHT+IEASm5o7gskwbPLwrdWP4DnPniwIEq5K5UrLqGJgKMu+ho/Y5s+CzIjiqwy75p+lLHBgcaQsQ==
X-Received: by 2002:a5d:654d:0:b0:319:8dcf:5c00 with SMTP id z13-20020a5d654d000000b003198dcf5c00mr439524wrv.69.1694125217796;
        Thu, 07 Sep 2023 15:20:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l6-20020adff486000000b003180155493esm433076wro.67.2023.09.07.15.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 15:20:17 -0700 (PDT)
Message-ID: <ef6b77016cd50c438fb58d79ffb10f748ddc5244.1694125210.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1564.v3.git.1694125209.gitgitgadget@gmail.com>
References: <pull.1564.v2.git.1691702283.gitgitgadget@gmail.com>
        <pull.1564.v3.git.1694125209.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Sep 2023 22:20:05 +0000
Subject: [PATCH v3 09/13] trailer --parse docs: add explanation for its
 usefulness
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Linus Arver <linusa@google.com>,
        Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Linus Arver <linusa@google.com>

For users who are skimming the docs to go straight to the individual
breakdown of each flag, it may not be clear why --parse is a convenience
alias (without them also looking at the other options that --parse turns
on). To save them the trouble of looking at the other options (and
computing what that would mean), describe a summary of the overall
effect.

Similarly update the area when we first mention --parse near the top of
the doc.

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/git-interpret-trailers.txt | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 0eea937c30e..2d49445b1c3 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -31,7 +31,9 @@ the last two lines starting with "Signed-off-by" are trailers.
 
 This command reads commit messages from either the
 <file> arguments or the standard input if no <file> is specified.
-If `--parse` is specified, the output consists of the parsed trailers.
+If `--parse` is specified, the output consists of the parsed trailers
+coming from the input, without influencing them with any command line
+options or configuration variables.
 Otherwise, this command applies the arguments passed using the
 `--trailer` option, if any, to each input file. The result is emitted on the
 standard output.
@@ -158,7 +160,10 @@ OPTIONS
 
 --parse::
 	A convenience alias for `--only-trailers --only-input
-	--unfold`.
+	--unfold`. This makes it easier to only see the trailers coming from the
+	input without influencing them with any command line options or
+	configuration variables, while also making the output machine-friendly with
+	--unfold.
 
 --no-divider::
 	Do not treat `---` as the end of the commit message. Use this
-- 
gitgitgadget

