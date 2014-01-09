From: Ryan Biesemeyer <ryan@yaauie.com>
Subject: [PATCH v2 4/4] merge: drop unused arg from abort_commit method signature
Date: Thu,  9 Jan 2014 00:45:44 +0000
Message-ID: <1389228344-38813-5-git-send-email-ryan@yaauie.com>
References: <6B177FFA-1797-45FE-9EF1-2C9E6EE8A234@yaauie.com>
 <1389228344-38813-1-git-send-email-ryan@yaauie.com>
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Ryan Biesemeyer <ryan@yaauie.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 09 01:47:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W13mm-0007k8-Mv
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jan 2014 01:47:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757464AbaAIArq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jan 2014 19:47:46 -0500
Received: from mail-pd0-f182.google.com ([209.85.192.182]:65203 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757097AbaAIAro (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jan 2014 19:47:44 -0500
Received: by mail-pd0-f182.google.com with SMTP id v10so2472035pde.27
        for <git@vger.kernel.org>; Wed, 08 Jan 2014 16:47:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4EMddLhRwC+YPQgEHTGZA7McXTCUDzoj8+r7+rQ1GWA=;
        b=aH6l9VN/JaT7hse9hu7Bqqvb5+JsUr8wlvSv478Sf806gTzeaR5JlRZjQRnnlFRlmR
         jnpcuvVWQIZPuKkBC3cV7+7R2LIJs8Awiy5Q9GEt0ZBsseOJKJ0h3p8a66/fJkrd3ZzT
         eI6emh9lT2y7VY7HSzZMFFFG7Lp8LlbMM3p00hI6MEaGZ+I04hCE1zgBkhN44V9hkTWP
         /N5OGW2hyUUNovfrk68qAhkxJ2BIqFp1gwL0Nuawxi1ZyPpQPt2b5ycjSztNvIyOUNeg
         lKiZK1a1UMutLbXKaHrjg0YYDfeM89+26MSSCqmxb3OGVp0zoEQvNOjUNhRmOGVRjm/Z
         Un/g==
X-Gm-Message-State: ALoCoQmX1SC7DS7I05o5+b8EVj4U0qTKz9POz20WjOMQvgel4Am1a5Pd/SdGzTXNp/O0TofC8xoy
X-Received: by 10.68.17.7 with SMTP id k7mr97634pbd.119.1389228464171;
        Wed, 08 Jan 2014 16:47:44 -0800 (PST)
Received: from beorn.local.com ([69.164.175.238])
        by mx.google.com with ESMTPSA id xs1sm6854477pac.7.2014.01.08.16.47.39
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 08 Jan 2014 16:47:43 -0800 (PST)
X-Mailer: git-send-email 1.8.5
In-Reply-To: <1389228344-38813-1-git-send-email-ryan@yaauie.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240238>

Since abort_commit is no longer responsible for writing merge state, remove
the unused argument that was originally needed solely for writing merge state.

Signed-off-by: Ryan Biesemeyer <ryan@yaauie.com>
---
 builtin/merge.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index b7bfc9c..c3108cf 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -795,8 +795,7 @@ static void read_merge_msg(struct strbuf *msg)
 		die_errno(_("Could not read from '%s'"), filename);
 }
 
-static void write_merge_state(struct commit_list *);
-static void abort_commit(struct commit_list *remoteheads, const char *err_msg)
+static void abort_commit(const char *err_msg)
 {
 	if (err_msg)
 		error("%s", err_msg);
@@ -812,6 +811,7 @@ N_("Please enter a commit message to explain why this merge is necessary,\n"
    "Lines starting with '%c' will be ignored, and an empty message aborts\n"
    "the commit.\n");
 
+static void write_merge_state(struct commit_list *);
 static void prepare_to_commit(struct commit_list *remoteheads)
 {
 	struct strbuf msg = STRBUF_INIT;
@@ -824,15 +824,15 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 	write_merge_msg(&msg);
 	if (run_hook(get_index_file(), "prepare-commit-msg",
 		     git_path("MERGE_MSG"), "merge", NULL, NULL))
-		abort_commit(remoteheads, NULL);
+		abort_commit(NULL);
 	if (0 < option_edit) {
 		if (launch_editor(git_path("MERGE_MSG"), NULL, NULL))
-			abort_commit(remoteheads, NULL);
+			abort_commit(NULL);
 	}
 	read_merge_msg(&msg);
 	stripspace(&msg, 0 < option_edit);
 	if (!msg.len)
-		abort_commit(remoteheads, _("Empty commit message."));
+		abort_commit(_("Empty commit message."));
 	strbuf_release(&merge_msg);
 	strbuf_addbuf(&merge_msg, &msg);
 	strbuf_release(&msg);
-- 
1.8.5
