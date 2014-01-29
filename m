From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 7/7] builtin/gc.c: reduce scope of variables
Date: Wed, 29 Jan 2014 08:59:37 -0800
Message-ID: <1391014777-13582-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 29 17:59:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8YUN-0003LH-A5
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jan 2014 17:59:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752227AbaA2Q7n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jan 2014 11:59:43 -0500
Received: from mail-pd0-f182.google.com ([209.85.192.182]:46430 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867AbaA2Q7n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jan 2014 11:59:43 -0500
Received: by mail-pd0-f182.google.com with SMTP id v10so1912561pde.41
        for <git@vger.kernel.org>; Wed, 29 Jan 2014 08:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=bmIjiqiYOyzyBEDC0E6rBBsXWd3pL+57SRNuuv3kLxc=;
        b=BlAjdRCCWTTsERLqxRJhx4mX8wmQu+YcesiDS8xdYO59v7R96TYY19J6iOZN5zV1cl
         tM3H3J7FOVnv1AZAKwTutLbrHUrU6GACXS/N9enLy58K3Q5KP8hduYf4YPdAGqN1mysf
         L1Q0jQCySOEycyx1VE5v7XfVMRHzCTMGD2/UaniCFbi4foIF8pbBfWG+WBjUr7ey7LHs
         cVXn470dAJokoWk2NzVEiKbmYcion/5wMirtv7j0Kd0hAZql3tUlaoPeiUwXpS7DLalu
         ji/F6DnlyF/EGRf7rStiAkdJRFC534ikyKf1Iw8XIOcaam7d6Pf2SV3ZRZWgFOuOHq49
         C70A==
X-Received: by 10.68.182.165 with SMTP id ef5mr8930220pbc.169.1391014782564;
        Wed, 29 Jan 2014 08:59:42 -0800 (PST)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id xn12sm20786520pac.12.2014.01.29.08.59.40
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 29 Jan 2014 08:59:40 -0800 (PST)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241215>

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 builtin/gc.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index c19545d..5bbb5e3 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -188,13 +188,12 @@ static int need_to_gc(void)
 static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
 {
 	static struct lock_file lock;
-	static char locking_host[128];
 	char my_host[128];
 	struct strbuf sb = STRBUF_INIT;
 	struct stat st;
 	uintmax_t pid;
 	FILE *fp;
-	int fd, should_exit;
+	int fd;
 
 	if (pidfile)
 		/* already locked */
@@ -206,6 +205,8 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
 	fd = hold_lock_file_for_update(&lock, git_path("gc.pid"),
 				       LOCK_DIE_ON_ERROR);
 	if (!force) {
+		static char locking_host[128];
+		int should_exit;
 		fp = fopen(git_path("gc.pid"), "r");
 		memset(locking_host, 0, sizeof(locking_host));
 		should_exit =
-- 
1.7.10.4
