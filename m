Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C309DC27C76
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 22:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjATWJH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 17:09:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjATWJA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 17:09:00 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3B4A3179
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 14:08:57 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id c10-20020a05600c0a4a00b003db0636ff84so4681525wmq.0
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 14:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KsvXxRc41yRRXoCeuMp+jDk6Yf1HTqCPl2KPj4S0kA8=;
        b=gK+kKG7cs53nPdtDD8sejY0IQk6Th75xNhlmI1vWriXHn4P4yT5yC91On/Ds1Vt8/g
         sroc31LjFKb2A6z3HE0lVrg+X3vRqGWEY9TBVukCojhQvFWGVwo19XUWF9VCVEnB2UUy
         OfeiprStPUXYvUtPbVeJA+d+cgy7nFHImW7gpLu8dr5/pTYrsZfd/tB/8zvAGVI/40fZ
         TS5PvVHceA7Jh2H/EWK5XV/tHj4tvCfkMK6kcEO2WpsD8tqoc7Wv8KFimosCKuwYX9qQ
         Ew+crB8OBXk8Is7rhyklqQACVhGIHQwmtsTvvfCuHGAwUKIdf27lq1RzhVTh/XjNYvmy
         RWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KsvXxRc41yRRXoCeuMp+jDk6Yf1HTqCPl2KPj4S0kA8=;
        b=435HZ0rv5f7RQ0BuauzX+/I/zPdcc7Ix2aUEnDp2nKP/ElQrhGmhpMFQhX4v77sNSA
         uhfrmNf6Dd6yhXHN894htEVMyiJ+U1Cjnqomo1H8kt6aFH95aW9NNftaJuxHxvcWu6Fk
         9I4RP0hwOXnVcvremqKrMPtMKMNtbL76wZtOb+lSR20GIgnRfB9qV/f7gpIcoYTs5uiW
         ItF8LF3uIBkvvSnuSGna3w1yEJPeVSZV3ZnL+/Ak/Sk9Jh2+dlg2qGUoK6ZUaXHPH42n
         tJILWcezSZ1xU9sUCYDZrLZCReNTgzkgpFm6fF1YbiVVKD2/sZ9pdIvL01UuO6mOcdlS
         sPNQ==
X-Gm-Message-State: AFqh2kqQvJQVfDJWNMfBp5WtUqJcBaXMveXhViYNC5EdhqRegs2FuT80
        NOPWOzjZAlX0c8gqHq9dOablkeL0bho=
X-Google-Smtp-Source: AMrXdXuXM+m1NpjdQXkJH47nAcZNzg9CgVxyR8yqFXJe/V3F/GKw/+93EXklJDj/cZAm7ENw4hWXbg==
X-Received: by 2002:a05:600c:3b29:b0:3da:f678:1322 with SMTP id m41-20020a05600c3b2900b003daf6781322mr16481977wms.38.1674252535335;
        Fri, 20 Jan 2023 14:08:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m27-20020a05600c3b1b00b003db012d49b7sm14069655wms.2.2023.01.20.14.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 14:08:55 -0800 (PST)
Message-Id: <9967401c972cab547d7619a208c3a0e6a3923cd4.1674252531.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
References: <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
        <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 Jan 2023 22:08:41 +0000
Subject: [PATCH v7 03/12] daemon: rename some esoteric/laboured terminology
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
        <avarab@gmail.com>, Matthew John Cheetham <mjcheetham@outlook.com>,
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

