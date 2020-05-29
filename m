Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09288C433E1
	for <git@archiver.kernel.org>; Fri, 29 May 2020 22:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA51320810
	for <git@archiver.kernel.org>; Fri, 29 May 2020 22:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ksYIdLur"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbgE2Wag (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 18:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgE2Wae (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 18:30:34 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D208C03E969
        for <git@vger.kernel.org>; Fri, 29 May 2020 15:30:34 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id s15so2337130qvo.6
        for <git@vger.kernel.org>; Fri, 29 May 2020 15:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=S031r3fa8qHI52krymqvmwy6Oalu9UjGWzVJofOIT6g=;
        b=ksYIdLurzMIF2IxsmHWRTr0srqUIYENxi54ba1jX+gMIWU9tbj7Levx5vytbVRcpkJ
         qKCl7cP9wXx2JoZHoWuBjvfQyUDVP6nrUytvoI6tGuMWsNVDfJSRr7J+eJmut836Cqmi
         DqqLWrqrjE8XimwHXQitIw57YIzu9JFSc9V5H3QIOMF6JaD10qZ77euE41Rv8pLwUK99
         7fQCU7SJSFhA5WVvlZim3vw6cEZSkGHWmEE+yf/lNo886aRxQnLa++aN+r2likdCDRTM
         MwfUEO41edw7Sv1BOmWeCiTZj/tVxSElVUdadPmCt/OCgQ2FQVemXc08rgVrEB5J85Vq
         +SWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=S031r3fa8qHI52krymqvmwy6Oalu9UjGWzVJofOIT6g=;
        b=udG0FeLAdvPp635Maryp9YsF25rQmHKKRFcdBaxEV471wDsASGGfiZdvXML4nwLMAd
         gdawyysWbosx6m2kNb2dNZUyr42efKyGrt/PhIVi+1w8csl2zYgHACVO3Z2Cl11tK2iz
         Yg1RXDwNtoHFyFr6Sk7aSMWjGW7BflGX6At/saRTEGXbb4bGM0sjkmI1DDl5NBCsbeLj
         mlcr8aGlB2v0N5FRbPUE16qIBBWoSjg/oQJYldgB//GL8/0IBX9DnZng1WxEgSRHGk9C
         cietVEGD5nm7Dln8bbLrUzrE7/B/QFqX+nzO5bZKBq1kcEjIpOdgQIAjcOnUT6iPAwwN
         6MCA==
X-Gm-Message-State: AOAM532+tpIoup69Uc5bz8o05mSZKpUhDcn59vDvfC9g9AadXf4eHzfz
        4Bo2y9w4F94yFdyQ6YX4Elyt19gvFvhx7qtQxGhXZMZ//x2TzudNB1jiWhx51Ue0mjaRkgcQJma
        rG4bb14ilMEGRd9iuHMZe7zc3ZntG8aPz+FdTSnhWca6hZnPJYIlnamYw+qqRj+12kXQiY51Nn6
        RC
X-Google-Smtp-Source: ABdhPJyVRdhTc8Pt+8wtcXmCRB99ux74KxTlMunYIJwKQQ1Qn1lyHTkZzMk2EBzF1WZBrbHTNH5eosWmoIoORB0cbeKj
X-Received: by 2002:a0c:b593:: with SMTP id g19mr10648329qve.55.1590791433431;
 Fri, 29 May 2020 15:30:33 -0700 (PDT)
Date:   Fri, 29 May 2020 15:30:14 -0700
In-Reply-To: <cover.1590789428.git.jonathantanmy@google.com>
Message-Id: <7c66ab1be0722eecf3a7be76921b4c1ef9bb50f2.1590789428.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1590789428.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
Subject: [PATCH 2/8] http: improve documentation of http_pack_request
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

struct http_pack_request and the functions that use it will be modified
in a subsequent patch. Using it is complicated (to use, call the
initialization function, then set some but not all fields in the
returned struct), so add some documentation to help future users.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 http.h | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/http.h b/http.h
index faf8cbb0d1..a5b082f3ae 100644
--- a/http.h
+++ b/http.h
@@ -215,14 +215,31 @@ int http_get_info_packs(const char *base_url,
 			struct packed_git **packs_head);
 
 struct http_pack_request {
+	/*
+	 * Initialized by new_http_pack_request().
+	 */
 	char *url;
 	struct packed_git *target;
+	struct active_request_slot *slot;
+
+	/*
+	 * After calling new_http_pack_request(), point lst to the head of the
+	 * pack list that target is in. finish_http_pack_request() will remove
+	 * target from lst and call install_packed_git() on target.
+	 */
 	struct packed_git **lst;
+
+	/*
+	 * State managed by functions in http.c.
+	 */
 	FILE *packfile;
 	struct strbuf tmpfile;
-	struct active_request_slot *slot;
 };
 
+/*
+ * target must be an element in a pack list obtained from
+ * http_get_info_packs().
+ */
 struct http_pack_request *new_http_pack_request(
 	struct packed_git *target, const char *base_url);
 int finish_http_pack_request(struct http_pack_request *preq);
-- 
2.27.0.rc0.183.gde8f92d652-goog

