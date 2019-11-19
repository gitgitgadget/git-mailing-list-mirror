Return-Path: <SRS0=OLpm=ZL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D28EC432C0
	for <git@archiver.kernel.org>; Tue, 19 Nov 2019 23:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74B632245B
	for <git@archiver.kernel.org>; Tue, 19 Nov 2019 23:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIXPQ0Ja"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfKSXCO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Nov 2019 18:02:14 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33698 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfKSXCO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 18:02:14 -0500
Received: by mail-wm1-f67.google.com with SMTP id a17so3648713wmb.0
        for <git@vger.kernel.org>; Tue, 19 Nov 2019 15:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kwRpcRAuoIA3K0TxGagSHMdiNbjl+x6pKzuCEQLCkak=;
        b=QIXPQ0JauqjWzyX2EZAPMSUarDdY1qFFiYxHEyTwa6Dl0fMdOL/jYWilV3XbDrkdI1
         i2aifdteQMxZ2EfGkp0oZPPWX90B7FGKFVwf7wseoMAdmAtNRNWEGFYJT8pKBZWup0qr
         YxOmbvXeMECrP0eHtkBiVx6MJS5cIdcjC2HVmw68WjfE1V1nwldIJFfPLSbGDogEPJP9
         9jabznbQQgJpFnfBx+C4aIf5OFdmkm/Pi/OUBNdxqSpPsPdzjgAh15nf0DW9Q8/OHzai
         fJaXPEEuz1qTY0AgrMlLGvOJ12e7eOzulab6nCCzdk4r30H071O5pZEFZKok6l1dKAyI
         YS1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kwRpcRAuoIA3K0TxGagSHMdiNbjl+x6pKzuCEQLCkak=;
        b=r3uZZ0lDSoh3DO8sMLMf0JGKxt6RAczNNHb5puWLt4CdEHyi3DivC+gL9Q0HbsNxxJ
         HaYq/Yx6G0nJNOCXRruRkOBtWs0Hc1btC+VgH9kuybY8FLi9CHA8P9+9fPQQblr0Zv5e
         vlJFghagypjPlO8VHq+f5Dz1afwIXHyO+TBE33Y63mztzRrCeUdpYcFrainlAJYWW/oV
         IM7oeYffQ67LtEldHkPXsOL9zmCvo/z/QAtc6NwaVWgRtw27ytC1s06aZ73HKKGGsvqk
         VEJDo70F/1xtWr4XX6p7LdjeptxZnpW4+HmTi1QIq875cHhhVOOiInlPi+bZJYokcO31
         lPlg==
X-Gm-Message-State: APjAAAVZ7AD5Ss7aguEf1R78efFmvo8pXRH25bHR0XdbOVZ6KxA2YGM1
        ls60yFGOEgEHQ8HD8FEbaNmA2ASm
X-Google-Smtp-Source: APXvYqz2jgSeyPT9UTARkvOfBuofhSXQWPF7qktfbJUY/w3PlGf0VnB5mwHuZIgTHsyZN+tAc/eoVw==
X-Received: by 2002:a1c:7709:: with SMTP id t9mr311789wmi.80.1574204531450;
        Tue, 19 Nov 2019 15:02:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a186sm4442520wmc.48.2019.11.19.15.02.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Nov 2019 15:02:11 -0800 (PST)
Message-Id: <d7bf1849ce8430beed3619fb9d87b58746424a54.1574204529.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.451.v5.git.1574204529.gitgitgadget@gmail.com>
References: <pull.451.v4.git.1574088732.gitgitgadget@gmail.com>
        <pull.451.v5.git.1574204529.gitgitgadget@gmail.com>
From:   "Erik Chen via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 19 Nov 2019 23:02:09 +0000
Subject: [PATCH v5 1/1] fetch: add trace2 instrumentation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Erik Chen <erikchen@chromium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Erik Chen <erikchen@chromium.org>

Add trace2 regions to fetch-pack.c to better track time spent in the various
phases of a fetch:

    * parsing remote refs and finding a cutoff
    * marking local refs as complete
    * marking complete remote refs as common

All stages could potentially be slow for repositories with many refs.

Signed-off-by: Erik Chen <erikchen@chromium.org>
---
 fetch-pack.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index f80e2d1149..a4a5e6cf9c 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -669,6 +669,7 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
 
 	save_commit_buffer = 0;
 
+	trace2_region_enter("fetch-pack", "parse_remote_refs_and_find_cutoff", NULL);
 	for (ref = *refs; ref; ref = ref->next) {
 		struct object *o;
 
@@ -679,7 +680,8 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
 		if (!o)
 			continue;
 
-		/* We already have it -- which may mean that we were
+		/*
+		 * We already have it -- which may mean that we were
 		 * in sync with the other side at some time after
 		 * that (it is OK if we guess wrong here).
 		 */
@@ -689,7 +691,13 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
 				cutoff = commit->date;
 		}
 	}
+	trace2_region_leave("fetch-pack", "parse_remote_refs_and_find_cutoff", NULL);
 
+	/*
+	 * This block marks all local refs as COMPLETE, and then recursively marks all
+	 * parents of those refs as COMPLETE.
+	 */
+	trace2_region_enter("fetch-pack", "mark_complete_local_refs", NULL);
 	if (!args->deepen) {
 		for_each_ref(mark_complete_oid, NULL);
 		for_each_cached_alternate(NULL, mark_alternate_complete);
@@ -697,11 +705,13 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
 		if (cutoff)
 			mark_recent_complete_commits(args, cutoff);
 	}
+	trace2_region_leave("fetch-pack", "mark_complete_local_refs", NULL);
 
 	/*
 	 * Mark all complete remote refs as common refs.
 	 * Don't mark them common yet; the server has to be told so first.
 	 */
+	trace2_region_enter("fetch-pack", "mark_common_remote_refs", NULL);
 	for (ref = *refs; ref; ref = ref->next) {
 		struct object *o = deref_tag(the_repository,
 					     lookup_object(the_repository,
@@ -714,6 +724,7 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
 		negotiator->known_common(negotiator,
 					 (struct commit *)o);
 	}
+	trace2_region_leave("fetch-pack", "mark_common_remote_refs", NULL);
 
 	save_commit_buffer = old_save_commit_buffer;
 }
-- 
gitgitgadget
