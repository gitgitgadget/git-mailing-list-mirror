Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BD8C1F667
	for <e@80x24.org>; Sun, 13 Aug 2017 19:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751578AbdHMTgj (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Aug 2017 15:36:39 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:33738 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751011AbdHMTga (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Aug 2017 15:36:30 -0400
Received: by mail-it0-f67.google.com with SMTP id m34so6835604iti.0
        for <git@vger.kernel.org>; Sun, 13 Aug 2017 12:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=jvXyaVSiCggTyhxKpQ8ziFSaiXsGIHkhRHc5+lGZG08=;
        b=ODd9dycm3Jvrta+2EIi4Pb8ymGJPcWR/+PAseE1Q9gowmh46rfvDuNQ6Dmx+8mY9VV
         tsE0plZnPzCIh2RtitETuTBmGE+eqWYnyAuJ2dZAXNzJu9/GgelzmECof3I9NRJats9J
         jPQLyU1js3tpVewZFUnF8BJ3zuxIwkhZ23uhby/hEQ2GjuNmsOzv65tuBbIDDRQt05V3
         s3jXbLz9DjgqWoPAqGU8w/SRhF2ZNkB7P137f6j2HsttNHipSg3pLNgimt6lSzhrFaHm
         UGqc1VrsD1MqHaUqHJsF+exGROlVl0BEJj4soDKJ2jyESIoLd5VjMoAiyWfuw5PQom00
         kzQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=jvXyaVSiCggTyhxKpQ8ziFSaiXsGIHkhRHc5+lGZG08=;
        b=FbtiJfSZEJe6PKBFN2+xfu3Aq5fAwsuFT9CNyng1/HmNeGmUC26Km1nlE73Zi1wh+l
         jNx7LKNUsDQJKxcEZqewVFII5X2iXinah8rmri47cRctRXZ9FsGXz79hklL8eSi9WAtZ
         ggHHcGXu/JGc7lAIkPvB3jB5k1LEpvuRJ15KrIhTeFJdDJIidUN4563kZdVv4aohvppk
         BUp93HxlpsvCQN8CsW+denVfAYQAwhJvo49DIjluxWhguqFSbIrRpKTN+FfMzRMxT0fD
         wGFY3OqIzu/tTmZv6aDwZ5X4+VP16CSmL4wf6YaclqEb7pWMOr+mpGSX9T/V4rRIb6ko
         3WIg==
X-Gm-Message-State: AHYfb5gtNGCEc7pkoIOM3Ht+OiOcIb+csH9FjhvT4LjcLRvw6ehDljs/
        63yx3e0VYcobQFkcxUI=
X-Received: by 10.36.149.134 with SMTP id m128mr3696936itd.175.1502652989966;
        Sun, 13 Aug 2017 12:36:29 -0700 (PDT)
Received: from localhost.localdomain ([192.252.136.182])
        by smtp.gmail.com with ESMTPSA id s66sm2045678ita.9.2017.08.13.12.36.29
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 13 Aug 2017 12:36:29 -0700 (PDT)
From:   Richard Maw <richard.maw@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 7/7] Plumb in namespaced ref store
Date:   Sun, 13 Aug 2017 20:36:11 +0100
Message-Id: <20170813193611.4233-8-richard.maw@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20170813193611.4233-1-richard.maw@gmail.com>
References: <20170813193611.4233-1-richard.maw@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 refs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 9a3dcfb..e80244f 100644
--- a/refs.c
+++ b/refs.c
@@ -647,7 +647,6 @@ int refs_delete_ref(struct ref_store *refs, const char *msg,
 	struct strbuf err = STRBUF_INIT;
 
 	if (ref_type(refname) == REF_TYPE_PSEUDOREF) {
-		assert(refs == get_main_ref_store());
 		return delete_pseudoref(refname, old_sha1);
 	}
 
@@ -986,7 +985,6 @@ int refs_update_ref(struct ref_store *refs, const char *msg,
 	int ret = 0;
 
 	if (ref_type(refname) == REF_TYPE_PSEUDOREF) {
-		assert(refs == get_main_ref_store());
 		ret = write_pseudoref(refname, new_sha1, old_sha1, &err);
 	} else {
 		t = ref_store_transaction_begin(refs, &err);
@@ -1589,6 +1587,9 @@ static struct ref_store *ref_store_init(const char *gitdir,
 		die("BUG: reference backend %s is unknown", be_name);
 
 	refs = be->init(gitdir, flags);
+
+	namespaced_ref_store_create(gitdir, &refs);
+
 	return refs;
 }
 
-- 
2.9.0

