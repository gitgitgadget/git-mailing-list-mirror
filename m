Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F8EB1FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 17:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932569AbdBPRHZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 12:07:25 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35611 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932348AbdBPRHX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 12:07:23 -0500
Received: by mail-lf0-f65.google.com with SMTP id v186so1957222lfa.2
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 09:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=48qQx96h3g3Nk/I3VJ2JvI8yaQeaO0u0xshQSbthy4s=;
        b=EOiFZgFfBV2RKJWz7EW/r1UamOBynCZ9rWYKs9BFeXGQm7j5dRRmVomnHC3ytTcFyX
         ktcxcyP2vbTtLF0LGnmFpljK6UQ7oiBz5JRWi4+k6HqJBTAkG6B5pSmaZreB6DQMBDIT
         puPf/mAPEd+1i7RuRrGcj+a9hGCSYtrf+mtQcZqvaUThjxnxZc5pWlioe4bFnY5CGAhe
         spev86Cuxdy975te1GT4oOMkYHaMc5gHsu/Nf6V8AiYj+NxsoanFCk/Tf5wBsj6GU5dw
         c8Ly3XGjX/Ou2qk69eo2iu+2QekF8PRVDkM8jZSJlWOV9De1upeHTn334IgIL/NbwO/H
         papQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=48qQx96h3g3Nk/I3VJ2JvI8yaQeaO0u0xshQSbthy4s=;
        b=qi1uUIm+wBMo+I0R1pQ5uyAhizxKVR2YBrl1f1IRWNRUM6A0X0BHex31g4g+AakLup
         BNOssgTF+2cHhiGsuAnQey2BsaFfc9vL6ve05KgPBn/RQmQ8hrq+YfgyC32urWBZh0kd
         DiA7eIuXrP/V9ShRP0+ziXJv1dImZ9fC7A3dY+b7hmnGFFwOgfTt8WK1aiEFyqVxpwnS
         jf2uzKt2pJcaG8G4PhWekAMOOTBOfxYzV/i4hT7uOXTIKK/xPG5mRBiEVUxxOUeGmxkN
         23gCljY66ybjqZKNKPoj1paz8GoGseDiu7scMwWPpEaKyTki5WHgYF/v5T+IuMHFd0az
         AkLw==
X-Gm-Message-State: AMke39l8ssi1Kn8ypgE7+dmZNXTsDgMeN5By+aWwWPDo+TDxsrhAkGQSl+vswy9yrsW/fg==
X-Received: by 10.46.80.29 with SMTP id e29mr858261ljb.78.1487264841721;
        Thu, 16 Feb 2017 09:07:21 -0800 (PST)
Received: from localhost.localdomain ([2001:470:1f0b:8fc:eda1:2dcd:3a83:adeb])
        by smtp.gmail.com with ESMTPSA id s7sm1867896lja.27.2017.02.16.09.07.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Feb 2017 09:07:21 -0800 (PST)
From:   Maxim Moseychuk <franchesko.salias.hudro.pedros@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jonathantanmy@google.com,
        Maxim Moseychuk <franchesko.salias.hudro.pedros@gmail.com>
Subject: [PATCH V2 2/2] stop_progress_msg: convert xsnprintf to xstrfmt
Date:   Thu, 16 Feb 2017 20:07:13 +0300
Message-Id: <20170216170713.10065-3-franchesko.salias.hudro.pedros@gmail.com>
X-Mailer: git-send-email 2.11.1
In-Reply-To: <20170216170713.10065-1-franchesko.salias.hudro.pedros@gmail.com>
References: <20170216170713.10065-1-franchesko.salias.hudro.pedros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace local safe string buffer allocation by xstrfmt.

Signed-off-by: Maxim Moseychuk <franchesko.salias.hudro.pedros@gmail.com>
---
 progress.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/progress.c b/progress.c
index 76a88c573..29d0dad58 100644
--- a/progress.c
+++ b/progress.c
@@ -243,21 +243,18 @@ void stop_progress_msg(struct progress **p_progress, const char *msg)
 	*p_progress = NULL;
 	if (progress->last_value != -1) {
 		/* Force the last update */
-		char buf[128], *bufp;
-		size_t len = strlen(msg) + 5;
+		char *bufp;
 		struct throughput *tp = progress->throughput;
 
-		bufp = (len < sizeof(buf)) ? buf : xmallocz(len);
 		if (tp) {
 			unsigned int rate = !tp->avg_misecs ? 0 :
 					tp->avg_bytes / tp->avg_misecs;
 			throughput_string(&tp->display, tp->curr_total, rate);
 		}
 		progress_update = 1;
-		xsnprintf(bufp, len + 1, ", %s.\n", msg);
+		bufp = xstrfmt(", %s.\n", msg);
 		display(progress, progress->last_value, bufp);
-		if (buf != bufp)
-			free(bufp);
+		free(bufp);
 	}
 	clear_progress_signal();
 	if (progress->throughput)
-- 
2.11.1

