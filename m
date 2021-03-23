Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DADC433E4
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 14:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B0E7619A9
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 14:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbhCWOVR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 10:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbhCWOUi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 10:20:38 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E43BC0613D8
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 07:20:37 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id u7so14974578qtq.12
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 07:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IPJSgn4necOpC7KyHqJCuJGW3R+FVfxbiTb2ySPlXtI=;
        b=UwcKyPXUz/MaTCXw/R6cUVddGHT4mL3/hsSMde9OkpUHRFN6zz7RGiXRY1KP+9xqMn
         Cx0gkRTQXo/Np2HcdSvpk/w9QSFhSDlMIwkKQimpt/F6C7WLGPlZf15qR2goqjNsWDm2
         E8XD8IlilqsKLUYotSSsXRbhRSRLa16F6pgBSc4DqWekB6CNFE4ZpDNQhQ6wxaY7tGS5
         5A0DJ2A211R1ZxjtOG2nWEcoTw159CVyMukD7G7l5/HNLW6WX1urM2Ieyo9hTpNFJTwo
         HpcI9OZ/4mq5n06mv8RYljMogKYMBJcBiZ4v26aNzXUr81ec1F+se82RZ1Y+YK+jVII2
         rreA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IPJSgn4necOpC7KyHqJCuJGW3R+FVfxbiTb2ySPlXtI=;
        b=jKidG/EaC0U0j3aCN2nuXv2dDTMDf13HBr2IT5NSPpjGUv4/GVd4pRK5/snGA+5sxs
         PO8SCjTDj3DijYmQVcdXpHJBamBZ18yBLFRj0J+7vm8HUXjuFPWLWay6CDCfrJMzBWOR
         YsMUFi5+UWCKMcvq8LiPZKQMFuxFwtqj9j45c4e7kc5NFk6cSkwHJ+2H9jrZJD5zqjiR
         xRBRrA5zjjAiZhHMr+eWOSoZ7pqEHWjA6foWg26PeFjycJL3wGVbPxe40Pf1E3fcoJhM
         Ojc5zy7UpkAiXc9h+warbD+eBn3BEf84GAn+2cdtMiYRRlNguIRSOnSQnvVejet9XTSD
         eK+Q==
X-Gm-Message-State: AOAM5336UTHqL1B02CckpC+QgpLfJaVTjvdLRx6n0O3RJuLnil99IsWc
        ztID05ruurDmCjeHGSKYsP028w==
X-Google-Smtp-Source: ABdhPJzYIcXXsI5OWlmkIviy7OrYrxzQIdnD3QCzM1msNRPS30Mh5atYoWOyJ80pNjN6UQSSWrVLHw==
X-Received: by 2002:a05:622a:1342:: with SMTP id w2mr4445704qtk.163.1616509236423;
        Tue, 23 Mar 2021 07:20:36 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id j12sm11011690qtn.36.2021.03.23.07.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 07:20:35 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: [PATCH v6 7/9] entry: extract update_ce_after_write() from write_entry()
Date:   Tue, 23 Mar 2021 11:19:34 -0300
Message-Id: <b28e518c0d3459d8042f54a21f8b80df84a840c9.1616508954.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1616508954.git.matheus.bernardino@usp.br>
References: <cover.1616508954.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The code that updates the in-memory index information after an entry is
written currently resides in write_entry(). Extract it to a public
function so that it can be called by the parallel checkout functions,
outside entry.c, in a later patch.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 entry.c | 25 ++++++++++++++++---------
 entry.h |  2 ++
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/entry.c b/entry.c
index 1e2d9f7baa..4cf0db352f 100644
--- a/entry.c
+++ b/entry.c
@@ -251,6 +251,18 @@ int finish_delayed_checkout(struct checkout *state, int *nr_checkouts)
 	return errs;
 }
 
+void update_ce_after_write(const struct checkout *state, struct cache_entry *ce,
+			   struct stat *st)
+{
+	if (state->refresh_cache) {
+		assert(state->istate);
+		fill_stat_cache_info(state->istate, ce, st);
+		ce->ce_flags |= CE_UPDATE_IN_BASE;
+		mark_fsmonitor_invalid(state->istate, ce);
+		state->istate->cache_changed |= CE_ENTRY_CHANGED;
+	}
+}
+
 static int write_entry(struct cache_entry *ce,
 		       char *path, const struct checkout *state, int to_tempfile)
 {
@@ -371,15 +383,10 @@ static int write_entry(struct cache_entry *ce,
 
 finish:
 	if (state->refresh_cache) {
-		assert(state->istate);
-		if (!fstat_done)
-			if (lstat(ce->name, &st) < 0)
-				return error_errno("unable to stat just-written file %s",
-						   ce->name);
-		fill_stat_cache_info(state->istate, ce, &st);
-		ce->ce_flags |= CE_UPDATE_IN_BASE;
-		mark_fsmonitor_invalid(state->istate, ce);
-		state->istate->cache_changed |= CE_ENTRY_CHANGED;
+		if (!fstat_done && lstat(ce->name, &st) < 0)
+			return error_errno("unable to stat just-written file %s",
+					   ce->name);
+		update_ce_after_write(state, ce , &st);
 	}
 delayed:
 	return 0;
diff --git a/entry.h b/entry.h
index 60df93ca78..ea7290bcd5 100644
--- a/entry.h
+++ b/entry.h
@@ -41,5 +41,7 @@ void unlink_entry(const struct cache_entry *ce);
 
 void *read_blob_entry(const struct cache_entry *ce, unsigned long *size);
 int fstat_checkout_output(int fd, const struct checkout *state, struct stat *st);
+void update_ce_after_write(const struct checkout *state, struct cache_entry *ce,
+			   struct stat *st);
 
 #endif /* ENTRY_H */
-- 
2.30.1

