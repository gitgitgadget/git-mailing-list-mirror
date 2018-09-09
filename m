Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AA1A1F404
	for <e@80x24.org>; Sun,  9 Sep 2018 08:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbeIINnc (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Sep 2018 09:43:32 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45467 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbeIINnb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Sep 2018 09:43:31 -0400
Received: by mail-lf1-f66.google.com with SMTP id r4-v6so15089921lff.12
        for <git@vger.kernel.org>; Sun, 09 Sep 2018 01:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1wUegYEbb3SDRdLL5AgWbX2IYjL206KPiArfTZCZRG4=;
        b=sv9mkXkZKHprK8S2nUcIgu9+YOs6PncHbESg81GljAsrJ6d4MmQGL9dRIhU0wORP0n
         J23BhWH6PdciSp0+eP4LlW2Qmc6yPjqMSyDtu6YjkzS9f4qdlQQQ33GKwiOIxPVVsg2r
         Qpp7phY37VOyKeFkBO6Y0cBM45cbNQHZ+Ihrp/sJd2xemEGb4dS1xrpfWrfzriSbIrel
         zUe8RNOofbvEH9q1R/0QaLPNyt1PE43WHBZ1hBoR4z6MrZeLMhB7Vc/fBGDX53MJPGM2
         8V5AIKBtk58WmHW8XCfzeRLjtyrIUXqs3xXHI4fc4fEHZ+6PyM2aouYV8kM4ev9T5qtv
         kZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1wUegYEbb3SDRdLL5AgWbX2IYjL206KPiArfTZCZRG4=;
        b=LYJoPP/yb/W05CZR6ayxYgPHDbULdFDEndqE58d1MPCz60Gs5x4X79t+awqfo3Uz+e
         aXqPj4K7F1Z/aLOur3JY3WveHMbC/CzRzdkmCfMtRd+LwLz0PPZaumTOZs6gnAoYE723
         J49GYdQ7kZThAen87vPK2YoQ5V/ct+uuYQwkOm5bc0Dn2MIgokrYNH9UaohXFOgm6vAR
         GM5KfshcpEmlxB11t7D7zZsA/d/6m3CjRQyzKpdjy/fpnJg3ue1c8ZoDN89L7XjqtSln
         F/5A4gMoRU79DlaZ3mG5W4iO//Dz44QOBHDfwr3wttouygjvGKGGaG3UYOrrE4YXnJ1x
         ta9w==
X-Gm-Message-State: APzg51CkBqA76E1CcxYssvaupNXgR+utYZE7wma8btRtnrf0qU3pJXsT
        CetyqkMyPoomEjWa3gWGIss=
X-Google-Smtp-Source: ANB0VdYVAyxBy9VRXZzlBoqZiWRVNfZpyodGfD57xvEefsBm7da6GKL8WhnU9Opu2hsTPgeTmPJT1g==
X-Received: by 2002:a19:10cb:: with SMTP id 72-v6mr9951040lfq.113.1536483272997;
        Sun, 09 Sep 2018 01:54:32 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g16-v6sm2102525lfb.5.2018.09.09.01.54.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Sep 2018 01:54:32 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, sbeller@google.com,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 02/23] read-cache.c: remove 'const' from index_has_changes()
Date:   Sun,  9 Sep 2018 10:53:57 +0200
Message-Id: <20180909085418.31531-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180909085418.31531-1-pclouds@gmail.com>
References: <20180903180932.32260-1-pclouds@gmail.com>
 <20180909085418.31531-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function calls do_diff_cache() which eventually needs to set this
"istate" to unpack_options->src_index (*). This is an unfortunate fact
that unpack_trees() _will_ destroy src_index so we can't really pass a
const index_state there. Just remove 'const'.

(*) Right now diff_cache() in diff-lib.c assigns the_index to
    src_index. But the plan is to get rid of the_index, so it should
    be 'istate' from here that gets assigned to src_index.
---
 cache.h      | 2 +-
 read-cache.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index 4d014541ab..260e4ee44a 100644
--- a/cache.h
+++ b/cache.h
@@ -703,7 +703,7 @@ extern int unmerged_index(const struct index_state *);
  * provided, the space-separated list of files that differ will be appended
  * to it.
  */
-extern int index_has_changes(const struct index_state *istate,
+extern int index_has_changes(struct index_state *istate,
 			     struct tree *tree,
 			     struct strbuf *sb);
 
diff --git a/read-cache.c b/read-cache.c
index 7b1354d759..86134e56a6 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2122,7 +2122,7 @@ int unmerged_index(const struct index_state *istate)
 	return 0;
 }
 
-int index_has_changes(const struct index_state *istate,
+int index_has_changes(struct index_state *istate,
 		      struct tree *tree,
 		      struct strbuf *sb)
 {
-- 
2.19.0.rc0.337.ge906d732e7

