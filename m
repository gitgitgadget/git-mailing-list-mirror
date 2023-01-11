Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A69C5479D
	for <git@archiver.kernel.org>; Wed, 11 Jan 2023 22:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236094AbjAKWNY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Jan 2023 17:13:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235978AbjAKWNS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2023 17:13:18 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136D83F129
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 14:13:17 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id h16so16405030wrz.12
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 14:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UCcatjtuaN1IUjSQ2kPLhhk9rJyJf2AjwsCYoHqfbdk=;
        b=EYDIYZCPm8k4FGHc7OvW199FQofPEFxwe3gP9jaAvXb7eEkJW6I1FQ47DPY6062NQ7
         sL84Te3hbPd4Yya5QYsuqe3ZXEJkkSf3WDXA75TNPD9YSk1hfp4Edsb6KVOnclcfTh4r
         rHQxPTymfClR79RdT0RB0iXFXRGOsk6CC4D9riTY27AP0f/fi9nTiV0bAxasdDpqfJvk
         W2qjNyN11UVW7/lWbf2ggOjep4k/l9Ou79ejYR0BFoDnsXtD9q8aLVUWPTQbXpJIiIDQ
         wMPrri4Tbes7bg/S8MWFYJfXBr3IPn75HKOTNYK7Fc4dXoZyZjMPxUaVItP5MoyPkeFc
         rWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UCcatjtuaN1IUjSQ2kPLhhk9rJyJf2AjwsCYoHqfbdk=;
        b=GZjWwT+zlL5L2W7yZ5JxNY0dVYIdOCJBMEeTsNpxhPMSTJYqbq62DkF5jq9Ld6UzS5
         9qji45wEGjOU6KD7fIG0pa0MNrbLeq2/dCR0Y6uxu5wbcXYrGTNkhuG0NSLq/3rksrkr
         8MgnuKp8k28CUfCBsgCCP9sPXfANKkdngDZd8IijNX5nuItKF194SPTebOPToeIZ4CxQ
         WSmxxwF2WZ3ZGmc8pNS9PGfChzD4149gzS3yZ8me84U4NPpKmN490g6qgsrwVjq5T1pX
         WT5NyKF+9rVgnNsoWRxqUm3rN60ygVz0EWiVaqaUmaIIweCIHul/a95chIZ+4fucLvLS
         nhFA==
X-Gm-Message-State: AFqh2kqChUDB3GZe3FHkln6jc5les0tWx6AdV8tGLKytBhUmKCpZ+AVt
        0hxKQHdpvRAvnatRKUIqsWKb+axDg08=
X-Google-Smtp-Source: AMrXdXv79rXAJZaa/BBbMp2mBdVaLrAd65k23JTJnFvy5ducoRKVZ5BfQFk6i7Lx5ZN1oKPvdCn7Pg==
X-Received: by 2002:adf:d22c:0:b0:2bb:eaae:3096 with SMTP id k12-20020adfd22c000000b002bbeaae3096mr8635697wrh.8.1673475195447;
        Wed, 11 Jan 2023 14:13:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id he12-20020a05600c540c00b003d9ddc82450sm19116532wmb.45.2023.01.11.14.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 14:13:14 -0800 (PST)
Message-Id: <8f176d5955dfc83616a39622972aaa71a71f5599.1673475190.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v5.git.1673475190.gitgitgadget@gmail.com>
References: <pull.1352.v4.git.1670880984.gitgitgadget@gmail.com>
        <pull.1352.v5.git.1673475190.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 11 Jan 2023 22:13:03 +0000
Subject: [PATCH v5 03/10] daemon: rename some esoteric/laboured terminology
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        Matthew John Cheetham <mjcheetham@github.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew John Cheetham <mjcheetham@outlook.com>

Rename some of the variables and function arguments used to manage child
processes. The existing names are esoteric; stretching an analogy too
far to the point of being confusing to understand.

Rename "firstborn" to simply "first", "newborn" to "new_cld", "blanket"
to "current" and "cradle" to "ptr".

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
---
 daemon-utils.c | 46 +++++++++++++++++++++++-----------------------
 daemon-utils.h |  6 +++---
 daemon.c       | 10 +++++-----
 3 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/daemon-utils.c b/daemon-utils.c
index 3804bc60973..190da01aea9 100644
--- a/daemon-utils.c
+++ b/daemon-utils.c
@@ -230,44 +230,44 @@ static int addrcmp(const struct sockaddr_storage *s1,
 }
 
 void add_child(struct child_process *cld, struct sockaddr *addr, socklen_t addrlen,
-	       struct child *firstborn , unsigned int *live_children)
+	       struct child *first, unsigned int *live_children)
 {
-	struct child *newborn, **cradle;
+	struct child *new_cld, **current;
 
-	CALLOC_ARRAY(newborn, 1);
+	CALLOC_ARRAY(new_cld, 1);
 	live_children++;
-	memcpy(&newborn->cld, cld, sizeof(*cld));
-	memcpy(&newborn->address, addr, addrlen);
-	for (cradle = &firstborn; *cradle; cradle = &(*cradle)->next)
-		if (!addrcmp(&(*cradle)->address, &newborn->address))
+	memcpy(&new_cld->cld, cld, sizeof(*cld));
+	memcpy(&new_cld->address, addr, addrlen);
+	for (current = &first; *current; current = &(*current)->next)
+		if (!addrcmp(&(*current)->address, &new_cld->address))
 			break;
-	newborn->next = *cradle;
-	*cradle = newborn;
+	new_cld->next = *current;
+	*current = new_cld;
 }
 
-void kill_some_child(struct child *firstborn)
+void kill_some_child(struct child *first)
 {
-	const struct child *blanket, *next;
+	const struct child *current, *next;
 
-	if (!(blanket = firstborn))
+	if (!(current = first))
 		return;
 
-	for (; (next = blanket->next); blanket = next)
-		if (!addrcmp(&blanket->address, &next->address)) {
-			kill(blanket->cld.pid, SIGTERM);
+	for (; (next = current->next); current = next)
+		if (!addrcmp(&current->address, &next->address)) {
+			kill(current->cld.pid, SIGTERM);
 			break;
 		}
 }
 
-void check_dead_children(struct child *firstborn, unsigned int *live_children,
+void check_dead_children(struct child *first, unsigned int *live_children,
 			 log_fn loginfo)
 {
 	int status;
 	pid_t pid;
 
-	struct child **cradle, *blanket;
-	for (cradle = &firstborn; (blanket = *cradle);)
-		if ((pid = waitpid(blanket->cld.pid, &status, WNOHANG)) > 1) {
+	struct child **ptr, *current;
+	for (ptr = &first; (current = *ptr);)
+		if ((pid = waitpid(current->cld.pid, &status, WNOHANG)) > 1) {
 			if (loginfo) {
 				const char *dead = "";
 				if (status)
@@ -277,10 +277,10 @@ void check_dead_children(struct child *firstborn, unsigned int *live_children,
 			}
 
 			/* remove the child */
-			*cradle = blanket->next;
+			*ptr = current->next;
 			live_children--;
-			child_process_clear(&blanket->cld);
-			free(blanket);
+			child_process_clear(&current->cld);
+			free(current);
 		} else
-			cradle = &blanket->next;
+			ptr = &current->next;
 }
diff --git a/daemon-utils.h b/daemon-utils.h
index fe8d9d05256..e87bc7b9567 100644
--- a/daemon-utils.h
+++ b/daemon-utils.h
@@ -28,11 +28,11 @@ struct child {
 };
 
 void add_child(struct child_process *cld, struct sockaddr *addr, socklen_t addrlen,
-	       struct child *firstborn, unsigned int *live_children);
+	       struct child *first, unsigned int *live_children);
 
-void kill_some_child(struct child *firstborn);
+void kill_some_child(struct child *first);
 
-void check_dead_children(struct child *firstborn, unsigned int *live_children,
+void check_dead_children(struct child *first, unsigned int *live_children,
 			 log_fn loginfo);
 
 #endif
diff --git a/daemon.c b/daemon.c
index ec3b407ecbc..d3e7d81de18 100644
--- a/daemon.c
+++ b/daemon.c
@@ -789,7 +789,7 @@ static int max_connections = 32;
 
 static unsigned int live_children;
 
-static struct child *firstborn;
+static struct child *first_child;
 
 static struct strvec cld_argv = STRVEC_INIT;
 static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
@@ -797,9 +797,9 @@ static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
 	struct child_process cld = CHILD_PROCESS_INIT;
 
 	if (max_connections && live_children >= max_connections) {
-		kill_some_child(firstborn);
+		kill_some_child(first_child);
 		sleep(1);  /* give it some time to die */
-		check_dead_children(firstborn, &live_children, loginfo);
+		check_dead_children(first_child, &live_children, loginfo);
 		if (live_children >= max_connections) {
 			close(incoming);
 			logerror("Too many children, dropping connection");
@@ -832,7 +832,7 @@ static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
 	if (start_command(&cld))
 		logerror("unable to fork");
 	else
-		add_child(&cld, addr, addrlen, firstborn, &live_children);
+		add_child(&cld, addr, addrlen, first_child, &live_children);
 }
 
 static void child_handler(int signo)
@@ -862,7 +862,7 @@ static int service_loop(struct socketlist *socklist)
 	for (;;) {
 		int i;
 
-		check_dead_children(firstborn, &live_children, loginfo);
+		check_dead_children(first_child, &live_children, loginfo);
 
 		if (poll(pfd, socklist->nr, -1) < 0) {
 			if (errno != EINTR) {
-- 
gitgitgadget

