From: Brad Roberts <braddr@puremagic.com>
Subject: Re: [patch] fork optional branch point normazilation
Date: Sun, 17 Apr 2005 19:01:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.44.0504171859410.2625-100000@bellevue.puremagic.com>
References: <Pine.LNX.4.58.0504171806230.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 18 03:58:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNLWp-0007wK-1o
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 03:58:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbVDRCCM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 22:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbVDRCCM
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 22:02:12 -0400
Received: from bellevue.puremagic.com ([209.189.198.108]:56225 "EHLO
	bellevue.puremagic.com") by vger.kernel.org with ESMTP
	id S261597AbVDRCCA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2005 22:02:00 -0400
Received: from bellevue.puremagic.com (localhost [127.0.0.1])
	by bellevue.puremagic.com (8.13.3/8.13.3/Debian-6) with ESMTP id j3I21rrx005200
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 17 Apr 2005 19:01:53 -0700
Received: from localhost (braddr@localhost)
	by bellevue.puremagic.com (8.13.3/8.13.3/Submit) with ESMTP id j3I21rqu005196;
	Sun, 17 Apr 2005 19:01:53 -0700
X-Authentication-Warning: bellevue.puremagic.com: braddr owned process doing -bs
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504171806230.7211@ppc970.osdl.org>
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The patch needed some tweaking, but not in the way you thought. :)

commit a6aa192641e9ea242332fee4916abf5ad2640d75
tree c69878b009ec2f505d75aa7d99e9ee30cd21ab02
parent 60e1274460f50bcecdc3f162b4fced9e5ebf2dfb
author Brad Roberts <braddr@puremagic.com> 1113789519 -0700
committer Brad Roberts <braddr@gameboy2> 1113789519 -0700

Fix remove_specials for real.  The second half logic needs the original
head of the string.

Signed-off-by: Brad Roberts <braddr@puremagic.com>

Index: commit-tree.c
===================================================================
--- 02cf6917da6297ff4f9172f7af174ba329f01b3d/commit-tree.c  (mode:100644 sha1:ec53a4565ec0033aaf6df2a48d233ccf4823e8b0)
+++ c69878b009ec2f505d75aa7d99e9ee30cd21ab02/commit-tree.c  (mode:100644 sha1:f41cda6f9496b9e33cb95305ef1093f846c663ae)
@@ -83,11 +83,11 @@
 static void remove_special(char *p)
 {
        char c;
-       char *dst = p;
+       char *dst = p, *src = p;

        for (;;) {
-               c = *p;
-               p++;
+               c = *src;
+               src++;
                switch(c) {
                case '\n': case '<': case '>':
                        continue;


Later,
Brad

