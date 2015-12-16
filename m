From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] dir: mark add_untracked_ident() as a file local symbol
Date: Wed, 16 Dec 2015 16:06:52 +0000
Message-ID: <56718C1C.2040609@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: christian.couder@gmail.com
X-From: git-owner@vger.kernel.org Wed Dec 16 17:07:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9EcH-0008S1-Cq
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 17:07:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934108AbbLPQHp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 11:07:45 -0500
Received: from avasout08.plus.net ([212.159.14.20]:35602 "EHLO
	avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934065AbbLPQHo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 11:07:44 -0500
Received: from [10.0.2.15] ([146.200.5.254])
	by avasout08 with smtp
	id uG6y1r0065UqX4q01G6z3S; Wed, 16 Dec 2015 16:07:01 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=LpJvsSpc c=1 sm=1 tr=0
 a=GKs3PHufgjMgxBavMeQJCg==:117 a=GKs3PHufgjMgxBavMeQJCg==:17 a=0Bzu9jTXAAAA:8
 a=EBOSESyhAAAA:8 a=IkcTkHD0fZMA:10 a=hLqOqOg1XUkiebUatTYA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282576>


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Christian,

If you need to re-roll your 'cc/untracked' branch, could you
please squash the relevant parts of this into your patches.

Thanks!

Also, you may what to consider removing the emulation of uname()
on MinGW, since this is no longer required after your series.

ATB,
Ramsay Jones

 dir.c | 2 +-
 dir.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index 94fba2a..be27afa 100644
--- a/dir.c
+++ b/dir.c
@@ -1908,7 +1908,7 @@ static int treat_leading_path(struct dir_struct *dir,
  * We used to save the location of the work tree and the kernel version,
  * but it was not a good idea, so we now just save an empty string.
  */
-void add_untracked_ident(struct untracked_cache *uc)
+static void add_untracked_ident(struct untracked_cache *uc)
 {
 	strbuf_addstr(&uc->ident, "");
 	/* this strbuf contains a list of strings, save NUL too */
diff --git a/dir.h b/dir.h
index 1935b76..531c99a 100644
--- a/dir.h
+++ b/dir.h
@@ -307,7 +307,6 @@ void untracked_cache_add_to_index(struct index_state *, const char *);
 void free_untracked_cache(struct untracked_cache *);
 struct untracked_cache *read_untracked_extension(const void *data, unsigned long sz);
 void write_untracked_extension(struct strbuf *out, struct untracked_cache *untracked);
-void add_untracked_ident(struct untracked_cache *);
 void add_untracked_cache(void);
 void remove_untracked_cache(void);
 #endif
-- 
2.6.0
