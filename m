Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6B721F42B
	for <e@80x24.org>; Sun, 26 Aug 2018 10:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbeHZNpo (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Aug 2018 09:45:44 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37004 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbeHZNpn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Aug 2018 09:45:43 -0400
Received: by mail-lj1-f194.google.com with SMTP id v9-v6so10008181ljk.4
        for <git@vger.kernel.org>; Sun, 26 Aug 2018 03:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jc9K8MrzwNQC3PwbT7pLCXzrSou0xu+R3lWMT7BQBD8=;
        b=Hh62DOcGmXw+u4uAetI3ZD/gk7AUIm4KU0u7EJsXiqFppbmd8HyC1XWlUxzK7+vq96
         WY12iqwsaRtaKncbFnsDxEj0uJ9oMtXNN1QmXm29Tye67CxtwUJdgrOJPdGyQWyYRQ7U
         tL+Y32T2XuA+KFoEACaDOK3tNNwWPkE2S3QDEWGhGVkOxBW8c/GDkDiF21KNE/zH3lg6
         B7j7dW14fmQXeXldY9WAmnsWe7dtYHXxrNlN7ksXJIT5dhng3Cy9T6XNGdEBGfWDDxNk
         rzwuj9l9WNp+6KWekXtFkT4rpCJCUpTeZtadMda1EL465YKZKbsYBmNVR4sYlfFjZGcp
         EPcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jc9K8MrzwNQC3PwbT7pLCXzrSou0xu+R3lWMT7BQBD8=;
        b=ToUxk1vehtzor3iI2Y8gQ/7J5IMRPquknu9z4tRx168RNlVEyR3e82l/FN4I+SID/9
         AhuKWAicXi9XtZk4Gd2zgqOTdIO2IS82Z5jdgdgimShreHJ7jDWSY3PVm29nMArqYbAG
         CiK2SwlkMq+9vNxk0kmJd9mfmWg+qiaIUvs02TGuLE67OQ8lzC/w9EiTmHVoQkVSZAdP
         2CSKD+3ZI+3U+QnsqHWK4VB7ZXdb7KHRwMV3MsARU/8ObgCXEoFFpphdYloLxUCOsJAh
         eaoty0pxCpgbESiAnN14oj8K/BeCUIT5IvoGUOJ+C/zg49AMBN2SV7EfCv0BnzbIC5qv
         Msng==
X-Gm-Message-State: APzg51Cx4m5dZoKS1nlYR+E+IKKNuLyleuIhg4PMcxxcAHz4Rbfcec6y
        rcU2+9S3XjM+w4VTTlmj8j9b5uMp
X-Google-Smtp-Source: ANB0VdbH2tA7KeAlXxCs4H+3PViDv5xCl+vICo3vCTBrKrxAhzQYA5KvPLCprLFF0bHQbbX32qhM1w==
X-Received: by 2002:a2e:8257:: with SMTP id j23-v6mr5705100ljh.49.1535277816369;
        Sun, 26 Aug 2018 03:03:36 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id z5-v6sm2276882lfg.75.2018.08.26.03.03.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Aug 2018 03:03:35 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 18/21] tree-diff.c: remove implicit dependency on the_index
Date:   Sun, 26 Aug 2018 12:03:11 +0200
Message-Id: <20180826100314.5137-19-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180826100314.5137-1-pclouds@gmail.com>
References: <20180826100314.5137-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 tree-diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tree-diff.c b/tree-diff.c
index d29127b029..b5ff14711c 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -607,7 +607,7 @@ static void try_to_follow_renames(const struct object_id *old_oid,
 	choice = q->queue[0];
 	q->nr = 0;
 
-	diff_setup(&diff_opts, the_repository);
+	diff_setup(&diff_opts, opt->repo);
 	diff_opts.flags.recursive = 1;
 	diff_opts.flags.find_copies_harder = 1;
 	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
-- 
2.19.0.rc0.337.ge906d732e7

