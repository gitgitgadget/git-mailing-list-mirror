Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34896C433E0
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 12:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FC4F206BE
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 12:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvL7zUba"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404854AbgFYMtV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 08:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404828AbgFYMtN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 08:49:13 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9DAC0613ED
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 05:49:12 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j94so5739252wrj.0
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 05:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ErI2OlJ5F+BITkR+n1dtdGRWwDA6IqCxbOTgA+Hvcyc=;
        b=EvL7zUba2W88nYipflEsLdAEdnBLn5tTUAHyM2ChQmNTkhifqp3pjHDg1Vdd6Lsr6v
         Dd3OG6GF89p1BV6U3gev2+KvSWuO0pXqCgCLhR7SaewKp+4+BiZ3oxPD9g7cZiOLyI68
         hGOoS5mpRO3yOpM8V/hy+aSCIjmxqsMekfi+mkZ79phOGZ60BEtN/CQISKXbXg5TARke
         RoYLTR9QFdPGVAFJil21bdfd7IaEodB+nkqcaOmQ9Ihr9vgl9LrHwDqVWE4JnFxhTJb7
         FTniE+/qfKNZMZTlOW7U02xRY6cbgrLNRVIg31JSPBTHY93JJLJ7KRQZhiai8kUOJHKz
         6r/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ErI2OlJ5F+BITkR+n1dtdGRWwDA6IqCxbOTgA+Hvcyc=;
        b=djrtVD9DOUxSmXENY6GL/XTMELYbhzcYz5by5s77a84jaWfsrswCLBGfsk4qKvdmDU
         F2Ys0VMoj9Ww3cQSrkjJAd0udEniUoSMKeXTx+vuxGxxSLhKyN35aL3z2IUHHvztb7uV
         U2WFTuNs+IZTTAyhbhXYp0m0s4NhUcskJ2qmy0E5f1PUo1pPmSP7QoRYNUFkrPDygy+W
         aq+kNOzYwqlusGo99d9j7QoDygKOxp5DvBGC9Wu70OHXBzyVgfCCcCkuHYSwpJKGRpDH
         DSTFz1zuFikL36B9YNQDIWTbdLIe+QEcCHL1Is+UN0A16GsTWtb7L+WBYAS3kSS0xVma
         oeig==
X-Gm-Message-State: AOAM532xzLkYcrRjr/CAESBvgInKChJqpZ0CC9Dm+mXEnUBYjEWTxm1b
        VONXkYbXDDUmEr74rML0S4+3pZqL
X-Google-Smtp-Source: ABdhPJzg6G+RULFOL6HxhkMQ3+jZdCJM/eQ17WOtBGpbWE43Psuo05wfTMoLLtiYcQZic3qai5uTwQ==
X-Received: by 2002:adf:f311:: with SMTP id i17mr22418542wro.237.1593089351487;
        Thu, 25 Jun 2020 05:49:11 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-308-216.w86-199.abo.wanadoo.fr. [86.199.91.216])
        by smtp.googlemail.com with ESMTPSA id y16sm31563409wro.71.2020.06.25.05.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 05:49:11 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [RFC PATCH v1 14/17] merge: use the "resolve" strategy without forking
Date:   Thu, 25 Jun 2020 14:19:50 +0200
Message-Id: <20200625121953.16991-15-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200625121953.16991-1-alban.gruin@gmail.com>
References: <20200625121953.16991-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This teaches `git merge' to invoke the "resolve" strategy with a
function call instead of forking.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/merge.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 7da707bf55..d50b4ad6ad 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -41,6 +41,7 @@
 #include "commit-reach.h"
 #include "wt-status.h"
 #include "commit-graph.h"
+#include "merge-strategies.h"
 
 #define DEFAULT_TWOHEAD (1<<0)
 #define DEFAULT_OCTOPUS (1<<1)
@@ -744,7 +745,10 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 				       COMMIT_LOCK | SKIP_IF_UNCHANGED))
 			die(_("unable to write %s"), get_index_file());
 		return clean ? 0 : 1;
-	} else {
+	} else if (!strcmp(strategy, "resolve"))
+		return merge_strategies_resolve(the_repository, common,
+						head_arg, remoteheads);
+	else {
 		return try_merge_command(the_repository,
 					 strategy, xopts_nr, xopts,
 					 common, head_arg, remoteheads);
-- 
2.27.0.139.gc9c318d6bf

