Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DD6C001DE
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 21:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjHJVSX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 17:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjHJVSO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 17:18:14 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57B42D55
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 14:18:11 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fe24dd8898so12641465e9.2
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 14:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691702290; x=1692307090;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YH2eCz+ojYjlC28yymk59q16Hks8uxKTS4lfGNd8zkY=;
        b=KWPRm1YBh0XfJmgmnSLNHcmEBj5i8elP5USpemhioK5WzYaxTtDaaJ+jJxefBacbZ1
         LGRNnNqJPtVKPzrBIJGctwgJ1i1AIBoTkHn5aK5vBY+2j+Jt/BsXUil9QqKOldoNup5O
         2UdVa0g9m2t/jsDrxltxuFe4OIpJl+uArx3mO/i1TJNOiYRyfi/kQ6u25B/k7M476fhI
         KOUwGGWgN/19ahHxtORi72m8dXU9HbZKQBKj7qP54TxzkOGTUia5IwBPyyfrYVqS/5jv
         7SiykFzJpBBhOqJhk5HLKiCotgoMwnzX28FbCWKLiXsFmM9KT9HYmdweLqRNPUStZ5Eu
         KHZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691702290; x=1692307090;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YH2eCz+ojYjlC28yymk59q16Hks8uxKTS4lfGNd8zkY=;
        b=TWwm8TIpyLPQXUAd+QpzDYN0T5F6DoHOb19IRGGofdGDi8YrVzODJ8BCS3uL14qntz
         dNIkeWxIjM5d6WbGX473uaz1Po//cQ5PnP765JQ43HZzyVWqMUd4bOGOkd96ybvLjKVo
         7mxs8OXGXa+5RfguTPKNz2CbjiMlQRiN1npfjGUbOiALmc7GOWvY9GgD1qD+V+0cityo
         46A41vA4chwXR2I6MCP9KA/96nB9WwPD859kaba8zxl+C2yBfzSISQlOUMMJ2t8NU1Er
         ZhZV28bpLZY22REhdTnoWEa7zaAEAOgBmnIimYyOsIlQDQSuMUhV/+yqB8IRWk3kLgpu
         BBnQ==
X-Gm-Message-State: AOJu0Yxctlf2Ya3CNNc1SMsnNcJZe80YleFJakFXrhRWH0GX7Aa7oLJp
        PSUNkeyvmVa8jJ1vAxfeZmtyehp0hLQ=
X-Google-Smtp-Source: AGHT+IG4mPdI/Z5B9oSPJiBVm/6E4JFsMn6pdwS7RB1GdadaXOhpRd98YK1KVO47dRmrluImqSc0cg==
X-Received: by 2002:a05:600c:234b:b0:3fc:521:8492 with SMTP id 11-20020a05600c234b00b003fc05218492mr64255wmq.5.1691702290053;
        Thu, 10 Aug 2023 14:18:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n5-20020a05600c294500b003fbaade0735sm6125289wmd.19.2023.08.10.14.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 14:18:09 -0700 (PDT)
Message-ID: <ef6b77016cd50c438fb58d79ffb10f748ddc5244.1691702283.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1564.v2.git.1691702283.gitgitgadget@gmail.com>
References: <pull.1564.git.1691210737.gitgitgadget@gmail.com>
        <pull.1564.v2.git.1691702283.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Aug 2023 21:17:59 +0000
Subject: [PATCH v2 09/13] trailer --parse docs: add explanation for its
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

