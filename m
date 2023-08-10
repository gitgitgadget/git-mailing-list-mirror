Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260A0C41513
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 21:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjHJVSP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 17:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjHJVSK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 17:18:10 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DABA2738
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 14:18:08 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fe12baec61so11695275e9.2
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 14:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691702287; x=1692307087;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1oQmft0cjVhwbiWKvOpOPZ4GHmuR71V36XV/wh8G53w=;
        b=X0hEe8fMZVb1RZCDp4VoyhbGQB7GaIEZlCig8b9ENPg8bp2IEe5IqEkEyYd/t966JC
         OzeJ5qmTRfDDv3S8kn+ZXun2UU8AX8Qz4ZIAeaQqapWNbBveo5arbt7IhuliCgKgq2lm
         d+yodSxQEf/nJyut1UiCVcRrm8YXlnQqKsVCY0xSOLNY3wVWx0uI3jVprDTq0XOnrWYn
         4JPHijAV1zSQASUeTlZ9LyieqrRjFl4Z2I2HSwKnWnyPBpdUTk6iLwbD6eoE7/9U+86U
         UCS9n64jZncsK1Lx5c7tkolyI/WUT43+Hzb0V0M1eqKO6pmJtnlmu/Md931ObPd3GZFJ
         MbBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691702287; x=1692307087;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1oQmft0cjVhwbiWKvOpOPZ4GHmuR71V36XV/wh8G53w=;
        b=H1WOzSN1oSVikseYOI6Viw7IjCOZxw1M7QJe6+jUPWkv6o6KDAFBuIYH4sAN0bnWmq
         a+OownWeJTcTia1T/+ZQGd3trNeuwwa+Sb/fNUiwprQP5S8RkWEiJrhwsiYuFtGvYuSf
         fqE+D/xwnNQbhcI3+Ii8cQaD76lYfkn3iFfd1yHrMfdoAJilF433bS4wVl9eQ+Dov+3w
         L9ilo8gnRlgcS7oKe4wj3ilt0ekyFXR3MTCSbThVrfpMnap/vIbebwV9bqz+IqAoSMm3
         yNMyeinNswFdptcAorLLK8o6J9nVu2/BegcGh5U/7iWhIPm1pH7ULlNjbOibDl/xo3ER
         YA+g==
X-Gm-Message-State: AOJu0YzhUOXubWF9aQnhscnUdGDRqVgqFRE6GEIyxnxdA20sa6EAjjTY
        hr5I/mMp76u3fYeVHkOpX1HVBgLrNcE=
X-Google-Smtp-Source: AGHT+IFFYqcgKfbExMMDphx/vwKPY+Bm6uFOxW72VKFsPGjDyXEf0Ks+rfB8cokH6A1oluXFtitAHw==
X-Received: by 2002:a5d:42c7:0:b0:319:52a5:569f with SMTP id t7-20020a5d42c7000000b0031952a5569fmr1647288wrr.11.1691702286825;
        Thu, 10 Aug 2023 14:18:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c13-20020a5d528d000000b003142c85fbcdsm3249271wrv.11.2023.08.10.14.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 14:18:06 -0700 (PDT)
Message-ID: <0df12c5c2dda5799074f0dcea696df0a63ca1145.1691702283.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1564.v2.git.1691702283.gitgitgadget@gmail.com>
References: <pull.1564.git.1691210737.gitgitgadget@gmail.com>
        <pull.1564.v2.git.1691702283.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Aug 2023 21:17:54 +0000
Subject: [PATCH v2 04/13] trailer doc: narrow down scope of --where and
 related flags
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

The wording "all configuration variables" is misleading (the same could
be said to the descriptions of the "--[no-]if-exists" and the
"--[no-]if-missing" options).  Specifying --where=value overrides only
the trailer.where variable and applicable trailer.<token>.where
variables, and --no-where stops the overriding of these variables.
Ditto for the other two with their relevant configuration variables.

Reported-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/git-interpret-trailers.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 91a4dbc9a72..72f5bdb652f 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -112,7 +112,8 @@ OPTIONS
 --where <placement>::
 --no-where::
 	Specify where all new trailers will be added.  A setting
-	provided with '--where' overrides all configuration variables
+	provided with '--where' overrides the `trailer.where` and any
+	applicable `trailer.<token>.where` configuration variables
 	and applies to all '--trailer' options until the next occurrence of
 	'--where' or '--no-where'. Upon encountering '--no-where', clear the
 	effect of any previous use of '--where', such that the relevant configuration
@@ -123,7 +124,8 @@ OPTIONS
 --no-if-exists::
 	Specify what action will be performed when there is already at
 	least one trailer with the same <token> in the input.  A setting
-	provided with '--if-exists' overrides all configuration variables
+	provided with '--if-exists' overrides the `trailer.ifExists` and any
+	applicable `trailer.<token>.ifExists` configuration variables
 	and applies to all '--trailer' options until the next occurrence of
 	'--if-exists' or '--no-if-exists'. Upon encountering '--no-if-exists, clear the
 	effect of any previous use of '--if-exists, such that the relevant configuration
@@ -134,7 +136,8 @@ OPTIONS
 --no-if-missing::
 	Specify what action will be performed when there is no other
 	trailer with the same <token> in the input.  A setting
-	provided with '--if-missing' overrides all configuration variables
+	provided with '--if-missing' overrides the `trailer.ifMissing` and any
+	applicable `trailer.<token>.ifMissing` configuration variables
 	and applies to all '--trailer' options until the next occurrence of
 	'--if-missing' or '--no-if-missing'. Upon encountering '--no-if-missing,
 	clear the effect of any previous use of '--if-missing, such that the relevant
-- 
gitgitgadget

