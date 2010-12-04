From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 07/14] fast-import.c: Initialise variables to suppress msvc
 warnings
Date: Sat, 04 Dec 2010 19:06:36 +0000
Message-ID: <4CFA913C.8000204@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 04 21:58:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POzBj-0007u2-MW
	for gcvg-git-2@lo.gmane.org; Sat, 04 Dec 2010 21:58:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756012Ab0LDU6b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Dec 2010 15:58:31 -0500
Received: from anchor-post-1.mail.demon.net ([195.173.77.132]:43035 "EHLO
	anchor-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755945Ab0LDU6a (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Dec 2010 15:58:30 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1POysr-0001Pc-gZ; Sat, 04 Dec 2010 20:39:05 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162911>


The msvc compiler thinks that three variables could be used
while uninitialised and issues the following warnings:

    ...\git\fast-import.c(2474) : warning C4700: uninitialized local \
        variable 'e' used
    ...\git\fast-import.c(2314) : warning C4700: uninitialized local \
        variable 'oe' used
    ...\git\fast-import.c(2151) : warning C4700: uninitialized local \
        variable 'oe' used

In order to suppress the warnings, we simply initialise all
three of the pointer variables to NULL.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 fast-import.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 8263dbe..1d7cd03 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2148,7 +2148,7 @@ static void file_change_m(struct branch *b)
 	const char *p = command_buf.buf + 2;
 	static struct strbuf uq = STRBUF_INIT;
 	const char *endp;
-	struct object_entry *oe = oe;
+	struct object_entry *oe = NULL;
 	unsigned char sha1[20];
 	uint16_t mode, inline_data = 0;
 
@@ -2311,7 +2311,7 @@ static void note_change_n(struct branch *b, unsigned char old_fanout)
 {
 	const char *p = command_buf.buf + 2;
 	static struct strbuf uq = STRBUF_INIT;
-	struct object_entry *oe = oe;
+	struct object_entry *oe = NULL;
 	struct branch *s;
 	unsigned char sha1[20], commit_sha1[20];
 	char path[60];
@@ -2471,7 +2471,7 @@ static int parse_from(struct branch *b)
 
 static struct hash_list *parse_merge(unsigned int *count)
 {
-	struct hash_list *list = NULL, *n, *e = e;
+	struct hash_list *list = NULL, *n, *e = NULL;
 	const char *from;
 	struct branch *s;
 
-- 
1.7.3
