Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58D701F403
	for <e@80x24.org>; Sat, 16 Jun 2018 05:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756850AbeFPFmf (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Jun 2018 01:42:35 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:40725 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754008AbeFPFmL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jun 2018 01:42:11 -0400
Received: by mail-lf0-f68.google.com with SMTP id q11-v6so17517421lfc.7
        for <git@vger.kernel.org>; Fri, 15 Jun 2018 22:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P2hlLZ9PnKc8Bpye+FdZ/RjCuxrVByVseVL1rH0psbg=;
        b=lhvOd0g3NqJaAG/jd0e97K89a7rIUM1pVQP1QMjY2f/IIYC71YxxxeI3uBd+PYLriD
         kBJAlXdlAYAvwAmCOyH8Fun0YVQy290p9+/GmuMwdhHE1RBlu3Yw34W9P+DErZ3Lkx57
         xMNl8pRjKLq3L+S6zih8JqIEFYpNuxJyQ8P2ddC6qCEqlFrup1cj8DqbdF4SrF0b5EwL
         kGs2OZaVXgr2obv94JyFW7WuB4DWMzu1JGwdB/zQP70mXsliEhQtwr2Hu9iTF4m23Ps1
         6edLM78XRr+eq/+ugqwiLBJUZt4KbhurzlNCo5nIO6lFCenxVJTsjE72sgpr870DBlLV
         RhYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P2hlLZ9PnKc8Bpye+FdZ/RjCuxrVByVseVL1rH0psbg=;
        b=anVv57Bi2CsVosd4YyTycoiVhQEvV7vckI938FsSukrW8OpxDPV8v97a6zQjCLNW4M
         i8XPQlGJwunvYDDMHflrLCac8bS38jH1dK77SQ+T5UHamvQlw9ISHvCUEKGH6z1SoNbH
         8SVmlR9ANj+zj92MUNVuSDZF7Qy/bLxESHmLCgRh6lqQUAknSzQBDfOlYboQ+kgx3Zhc
         bp4Et0ad4aroc6pBluy44tWOK0DY5ialmYvKO+6544NAHVh4I+h2C/W6zeHmqRgYtAuW
         cyJK48bJOECbuy+YNve1v96hGL9d52gwHog2+07EzNz7c7ZZ0B0ClJ6WnFxXOWeiWb5W
         X3iA==
X-Gm-Message-State: APt69E14Bi35RCoTu4RtP2qfdBGfMVK6nwIetoNUa+Z6kpSR5tWoD6DY
        jN+X+iKqSnfK8ttcYPjrXbCUQg==
X-Google-Smtp-Source: ADUXVKKn8+q7hKdydeXOJS+7SHq6knB9wQWftfoIueY90XEQoP9/hQm4pxxopPlHjgGBbO8rsdzFhA==
X-Received: by 2002:a2e:8990:: with SMTP id c16-v6mr3134423lji.123.1529127730228;
        Fri, 15 Jun 2018 22:42:10 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g5-v6sm1745194lje.21.2018.06.15.22.42.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 22:42:09 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 09/15] merge.c: stop using index compat macros
Date:   Sat, 16 Jun 2018 07:41:51 +0200
Message-Id: <20180616054157.32433-10-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180616054157.32433-1-pclouds@gmail.com>
References: <20180616054157.32433-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 merge.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/merge.c b/merge.c
index 0783858739..21e6dc09be 100644
--- a/merge.c
+++ b/merge.c
@@ -36,12 +36,12 @@ int index_has_changes(struct strbuf *sb)
 		diff_flush(&opt);
 		return opt.flags.has_changes != 0;
 	} else {
-		for (i = 0; sb && i < active_nr; i++) {
+		for (i = 0; sb && i < the_index.cache_nr; i++) {
 			if (i)
 				strbuf_addch(sb, ' ');
-			strbuf_addstr(sb, active_cache[i]->name);
+			strbuf_addstr(sb, the_index.cache[i]->name);
 		}
-		return !!active_nr;
+		return !!the_index.cache_nr;
 	}
 }
 
@@ -66,10 +66,10 @@ int try_merge_command(const char *strategy, size_t xopts_nr,
 	ret = run_command_v_opt(args.argv, RUN_GIT_CMD);
 	argv_array_clear(&args);
 
-	discard_cache();
-	if (read_cache() < 0)
+	discard_index(&the_index);
+	if (read_index(&the_index) < 0)
 		die(_("failed to read the cache"));
-	resolve_undo_clear();
+	resolve_undo_clear_index(&the_index);
 
 	return ret;
 }
@@ -85,7 +85,7 @@ int checkout_fast_forward(const struct object_id *head,
 	struct dir_struct dir;
 	struct lock_file lock_file = LOCK_INIT;
 
-	refresh_cache(REFRESH_QUIET);
+	refresh_index(&the_index, REFRESH_QUIET, NULL, NULL, NULL);
 
 	if (hold_locked_index(&lock_file, LOCK_REPORT_ON_ERROR) < 0)
 		return -1;
-- 
2.18.0.rc0.333.g22e6ee6cdf

