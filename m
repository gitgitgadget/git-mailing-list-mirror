From: Brian Gesiak <modocache@gmail.com>
Subject: [PATCH 02/15] builtin/ls-remote.c: rearrange xcalloc arguments
Date: Tue, 27 May 2014 00:33:43 +0900
Message-ID: <1401118436-66090-3-git-send-email-modocache@gmail.com>
References: <1401118436-66090-1-git-send-email-modocache@gmail.com>
Cc: Brian Gesiak <modocache@gmail.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 26 17:34:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WowvM-0004dd-CV
	for gcvg-git-2@plane.gmane.org; Mon, 26 May 2014 17:34:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752943AbaEZPet (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2014 11:34:49 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34360 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752929AbaEZPes (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2014 11:34:48 -0400
Received: by mail-pa0-f45.google.com with SMTP id ey11so7739655pad.4
        for <git@vger.kernel.org>; Mon, 26 May 2014 08:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+mGpHrLHUtCmQYgdIFFSac/B+vPin++e42iJWCxeDAQ=;
        b=NUytsheP5Elm4NzcR1A7GS9sGo9l1VYHWaNiLcYbZeuTS9oCNQ6qycOCAqumZc8kmy
         dhuGb68c7NqVjKQwG4y8FHQ7I92GIWIl6/jIUI5M3tltgknaI532r4mo0BSPnhOIb3zg
         UiqvdERJVexKtyqKCG5m/9KrXI9BLl3UlAJ2Ibc1amDsi3yF7w/rxh4UMicMDYmptJHH
         q5xVoDexPKdovhJJnVEboFJhlTF6uMQ3+AosIhwJJOnr1HFmwjqEQAy4NbufGr5tYNbC
         TJLiFqUhbXETa2wM1awDDhD+aPsm3p0UKDd2JliWmZtNgMHtaFe/J+nwiCQqGfnhhB/a
         1KwQ==
X-Received: by 10.68.223.202 with SMTP id qw10mr5473272pbc.163.1401118487689;
        Mon, 26 May 2014 08:34:47 -0700 (PDT)
Received: from localhost.localdomain (p3080-ipbf5805marunouchi.tokyo.ocn.ne.jp. [60.46.42.80])
        by mx.google.com with ESMTPSA id mt1sm18850446pbb.31.2014.05.26.08.34.46
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 26 May 2014 08:34:47 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.543.gc8042da
In-Reply-To: <1401118436-66090-1-git-send-email-modocache@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250093>

xcalloc takes two arguments: the number of elements and their size.
cmd_ls_remote passes the arguments in reverse order, passing the
size of a char*, followed by the number of char* to be allocated.
Rearrgange them so they are in the correct order.

Signed-off-by: Brian Gesiak <modocache@gmail.com>
---
 builtin/ls-remote.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 39e5144..aec1c0c 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -92,7 +92,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 
 	if (argv[i]) {
 		int j;
-		pattern = xcalloc(sizeof(const char *), argc - i + 1);
+		pattern = xcalloc(argc - i + 1, sizeof(const char *));
 		for (j = i; j < argc; j++) {
 			int len = strlen(argv[j]);
 			char *p = xmalloc(len + 3);
-- 
2.0.0.rc1.543.gc8042da
