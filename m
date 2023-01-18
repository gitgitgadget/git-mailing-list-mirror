Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1ACC00A5A
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 03:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjARDao (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 22:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjARDaZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 22:30:25 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B5353558
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 19:30:24 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d2so12483713wrp.8
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 19:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KsvXxRc41yRRXoCeuMp+jDk6Yf1HTqCPl2KPj4S0kA8=;
        b=RJ2xkSF4elsKtjriaTR+wRhtc64jpk2bMXyh7Mj40T/xJ1qaozhdvCqjPbUNcIGWVv
         emZt8dmVwUnu0XFip5i+FSC6pK0qTyjGKUf38vMr7HQ7hJ5mFPKgGGeOpaOufq9ea1ql
         BXoFPeccP2xJ2rZ4sZaKxHBMrhP3jMLpjDdmKRlWv1/szqDkxF888J4TZicnIquknvgJ
         3RFP0U7CaGfZo0T415QsyUqMFg1KGEywfBlcZ/Fei8w1lEu2A3MStQSfk/93DbY86+f8
         +ccKOiR9jDNmtgv8U7qofwiS2BOHijJSW9rsBc1AWOjYMtMt9hfOPFbrvUvkRBRgjSaL
         CZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KsvXxRc41yRRXoCeuMp+jDk6Yf1HTqCPl2KPj4S0kA8=;
        b=6/lXSTxWkWgrz8EU0OZ68GKVclscux9gGJF/REpAsd+PLcV5o+kpOjQLeftE/ZOzQH
         xxsgRIOnyhXxgQoZHK+t2BWToSl74kQ8hlxfcol4YqUrMJvGauzjpTmSHPBRtCSqQqTm
         v9/5WsNVSHT7nihaS/JuBB75E/I/bVJLN33fZXo80M0IoTI0l4ET4AUcfGHMK2GyCmYj
         uzZuGwSxs4dpKq70WBR0K3wAyYGCHju1hYFOVKGSwQDE2e2eARPhBRtZAPdsjEwNXNlK
         1qNFCqNibcfCHtI7+6uAY9nH8O9mHU4rk9FlX4Pqbf9Ob/cBmxjW8XQ1L/woKfmjdtub
         BH/g==
X-Gm-Message-State: AFqh2kp7Q+nFefU+7czhI2Iza0fP/8CsydEqhS3Mz016rGskDkmTBq3i
        YGei7X7KzdnK8Va4Ro7WVO9yhy21fAg=
X-Google-Smtp-Source: AMrXdXuMexIxbiXdqKqUW4zfRfSbPCMzRkD3XwLy91gAt8lGjnvVuwr0+xgKVCwEXmkWsI7RiITPaw==
X-Received: by 2002:a5d:5642:0:b0:2bb:d412:9866 with SMTP id j2-20020a5d5642000000b002bbd4129866mr4571577wrw.25.1674012622833;
        Tue, 17 Jan 2023 19:30:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g2-20020a5d4882000000b00286ad197346sm30114632wrq.70.2023.01.17.19.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 19:30:22 -0800 (PST)
Message-Id: <9967401c972cab547d7619a208c3a0e6a3923cd4.1674012618.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
References: <pull.1352.v5.git.1673475190.gitgitgadget@gmail.com>
        <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 18 Jan 2023 03:30:08 +0000
Subject: [PATCH v6 03/12] daemon: rename some esoteric/laboured terminology
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
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Matthew John Cheetham <mjcheetham@github.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew John Cheetham <mjcheetham@outlook.com>

Rename some of the variables and function arguments used to manage child
processes. The existing names are esoteric; stretching an analogy too
far to the point of being confusing to understand.

Rename "firstborn" to "first_child", "newborn" to "new_cld", "blanket"
to "current" and "cradle" to "ptr".

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
---
 daemon-utils.c | 46 +++++++++++++++++++++++-----------------------
 daemon-utils.h |  6 +++---
 daemon.c       | 10 +++++-----
 3 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/daemon-utils.c b/daemon-utils.c
index 8506664b440..f23ea35ed7b 100644
--- a/daemon-utils.c
+++ b/daemon-utils.c
@@ -230,44 +230,44 @@ static int addrcmp(const struct sockaddr_storage *s1,
 }
 
 void add_child(struct child_process *cld, struct sockaddr *addr, socklen_t addrlen,
-	       struct child *firstborn , unsigned int *live_children)
+	       struct child *first_child, unsigned int *live_children)
 {
-	struct child *newborn, **cradle;
+	struct child *new_cld, **current;
 
-	CALLOC_ARRAY(newborn, 1);
+	CALLOC_ARRAY(new_cld, 1);
 	(*live_children)++;
-	memcpy(&newborn->cld, cld, sizeof(*cld));
-	memcpy(&newborn->address, addr, addrlen);
-	for (cradle = &firstborn; *cradle; cradle = &(*cradle)->next)
-		if (!addrcmp(&(*cradle)->address, &newborn->address))
+	memcpy(&new_cld->cld, cld, sizeof(*cld));
+	memcpy(&new_cld->address, addr, addrlen);
+	for (current = &first_child; *current; current = &(*current)->next)
+		if (!addrcmp(&(*current)->address, &new_cld->address))
 			break;
-	newborn->next = *cradle;
-	*cradle = newborn;
+	new_cld->next = *current;
+	*current = new_cld;
 }
 
-void kill_some_child(struct child *firstborn)
+void kill_some_child(struct child *first_child)
 {
-	const struct child *blanket, *next;
+	const struct child *current, *next;
 
-	if (!(blanket = firstborn))
+	if (!(current = first_child))
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
+void check_dead_children(struct child *first_child, unsigned int *live_children,
 			 log_fn loginfo)
 {
 	int status;
 	pid_t pid;
 
-	struct child **cradle, *blanket;
-	for (cradle = &firstborn; (blanket = *cradle);)
-		if ((pid = waitpid(blanket->cld.pid, &status, WNOHANG)) > 1) {
+	struct child **ptr, *current;
+	for (ptr = &first_child; (current = *ptr);)
+		if ((pid = waitpid(current->cld.pid, &status, WNOHANG)) > 1) {
 			if (loginfo) {
 				const char *dead = "";
 				if (status)
@@ -277,10 +277,10 @@ void check_dead_children(struct child *firstborn, unsigned int *live_children,
 			}
 
 			/* remove the child */
-			*cradle = blanket->next;
+			*ptr = current->next;
 			(*live_children)--;
-			child_process_clear(&blanket->cld);
-			free(blanket);
+			child_process_clear(&current->cld);
+			free(current);
 		} else
-			cradle = &blanket->next;
+			ptr = &current->next;
 }
diff --git a/daemon-utils.h b/daemon-utils.h
index 97e5cae20b8..c866e9c9a4e 100644
--- a/daemon-utils.h
+++ b/daemon-utils.h
@@ -32,7 +32,7 @@ struct child {
  * live children.
  */
 void add_child(struct child_process *cld, struct sockaddr *addr, socklen_t addrlen,
-	       struct child *firstborn, unsigned int *live_children);
+	       struct child *first_child, unsigned int *live_children);
 
 /*
  * Kill the newest connection from a duplicate IP.
@@ -40,7 +40,7 @@ void add_child(struct child_process *cld, struct sockaddr *addr, socklen_t addrl
  * This function should be called if the number of connections grows
  * past the maximum number of allowed connections.
  */
-void kill_some_child(struct child *firstborn);
+void kill_some_child(struct child *first_child);
 
 /*
  * Check for children that have disconnected and remove them from the
@@ -49,7 +49,7 @@ void kill_some_child(struct child *firstborn);
  * Optionally log the child PID that disconnected by passing a loginfo
  * function.
  */
-void check_dead_children(struct child *firstborn, unsigned int *live_children,
+void check_dead_children(struct child *first_child, unsigned int *live_children,
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

