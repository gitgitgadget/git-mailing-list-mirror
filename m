Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63713C2BA15
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 16:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ACCF2073B
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 16:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Got4H1Zi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404018AbgDCQIu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 12:08:50 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:54276 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403873AbgDCQIt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 12:08:49 -0400
Received: by mail-pj1-f65.google.com with SMTP id np9so3169714pjb.4
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 09:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k0TTErNib/oVDKYqMrFH1TE4YX/C72t6kSBmdz23lsc=;
        b=Got4H1ZiA3EW0zzuA7fTrRJ/lNe2WWwl4JyHpo2tq8LK28CHLv9FjmDGlz/9BF0zkt
         nkPEhfoUyFkP7qkT70iafdfVyh2Bbdi9N6cPpGsOBPL63MDa+o0Udo5JHGqU7XwxI0Ft
         isAgvuDc2aYOlWeGDvn48E04GOd69L4ma2h2iqhNpNglqttMucqoDBhFOLSqTABMJ4oZ
         vvqiro8E1K20T4uNC/1DI/vmvYCwA3VlcVL4EubJ869c8Gzww002rpprMBbZlrHE+VKg
         gKK3c2pjlgRzBU3Vv0cJH0kko4e27XSAoyN/gKHHDQ+rZ6FP7GbbiYuRdE2S7SYt1mry
         AdJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k0TTErNib/oVDKYqMrFH1TE4YX/C72t6kSBmdz23lsc=;
        b=UsS0sFwlUCYXW2AZ9KYdRquRgq1JB291DBjk2Ax7duQ4lDiD2wgQEcNZpwmB2JZfCp
         rpIcqbg2pqjvq4Dzm1krVMvxki84mspEZNZbtGW7t9rvqhDHM3trr/tNTnIomFx1Se9C
         EaPl6N69JF9kaq+440PAX0BM8UKoHE7TOQ96vaBvGKZqWjhOIdRYDecIg/j89+k7ACuP
         kSbM6kTQ4cogxmcvPNFSgKcDspz998jLs23pACFv36PA6WZivx4fYHAI+2g4xWGBWa1B
         FPADoxpVmEQoz8SChf48WZT59dENiuwR0PMnXQWJLr8/QbrXasGBWQ/Ru2NGGJV1CezS
         UQiA==
X-Gm-Message-State: AGi0PuYi5YNUL4igmDD/lWLe8WxG0YL0CMRW45PS5FFNrspnqfUX8UN2
        xznxGKJGZOMTXaYZjO0/Yo8ZatLa8Ss=
X-Google-Smtp-Source: APiQypKptXJGIG4XBXs4ETbocJErQnb9iJWcvD5KqOElNl+DxVnzYV3sCyc9vCPFGtM5CkfJoVC2pA==
X-Received: by 2002:a17:902:d3cb:: with SMTP id w11mr8415077plb.257.1585930126886;
        Fri, 03 Apr 2020 09:08:46 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id 21sm5670420pgf.41.2020.04.03.09.08.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2020 09:08:46 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v7 3/7] refs.c: refactor to reuse ref_is_hidden()
Date:   Fri,  3 Apr 2020 12:08:34 -0400
Message-Id: <20200403160838.6252-4-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <xmqqftdl3fss.fsf@gitster.c.googlers.com>
References: <xmqqftdl3fss.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Add new function `ref_is_matched()` to reuse `ref_is_hidden()`. Will use
this function for `receive-pack` to check commands with specific
prefixes.

Test case t5512 covered this change.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 refs.c | 11 ++++++++---
 refs.h |  1 +
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 1ab0bb54d3..229159ea1a 100644
--- a/refs.c
+++ b/refs.c
@@ -1389,13 +1389,18 @@ int parse_hide_refs_config(const char *var, const char *value, const char *secti
 }
 
 int ref_is_hidden(const char *refname, const char *refname_full)
+{
+	return ref_is_matched(hide_refs, refname, refname_full);
+}
+
+int ref_is_matched(struct string_list *match_refs, const char *refname, const char *refname_full)
 {
 	int i;
 
-	if (!hide_refs)
+	if (!match_refs)
 		return 0;
-	for (i = hide_refs->nr - 1; i >= 0; i--) {
-		const char *match = hide_refs->items[i].string;
+	for (i = match_refs->nr - 1; i >= 0; i--) {
+		const char *match = match_refs->items[i].string;
 		const char *subject;
 		int neg = 0;
 		const char *p;
diff --git a/refs.h b/refs.h
index 545029c6d8..a2ea043f7f 100644
--- a/refs.h
+++ b/refs.h
@@ -739,6 +739,7 @@ int parse_hide_refs_config(const char *var, const char *value, const char *);
  * parameter always points to the full ref name.
  */
 int ref_is_hidden(const char *, const char *);
+int ref_is_matched(struct string_list *, const char *, const char *);
 
 enum ref_type {
 	REF_TYPE_PER_WORKTREE,	  /* refs inside refs/ but not shared       */
-- 
2.24.1.15.g448c31058d.agit.4.5

