From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] use strbuf_addch for adding single characters
Date: Thu, 10 Jul 2014 10:54:24 +0200
Message-ID: <53BE54C0.5060701@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 10 10:54:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5A7k-0000Y5-OC
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jul 2014 10:54:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752151AbaGJIyg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2014 04:54:36 -0400
Received: from mout.web.de ([212.227.17.11]:55813 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751344AbaGJIyf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 04:54:35 -0400
Received: from [192.168.178.27] ([79.253.174.99]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0M0Qkb-1Wkbzw1agP-00uWyK; Thu, 10 Jul 2014 10:54:33
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
X-Provags-ID: V03:K0:XvrGBVxEyH8xdWjtX+cV6omzZ9c32hcPKd7PKocx+btSGkgtUio
 qGj9LvU4/qee3oyD9UyoRNI5NAFUEz2h9bvvqVGs/cWWQ6Qf37UL6bzvTVvwXqYHLLIbOzj
 dlyrSRbJHG+NZPWMMPT8ajcV9tn32JPhJnSYtEfMZpjGwMRFsh6tdU3DIhYiSXqZyfTQsu7
 hkRs5MiukR+jtA6Rip2ag==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253178>

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 merge-recursive.c | 2 +-
 pathspec.c        | 2 +-
 url.c             | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index b5c3c53..fad7b2c 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -171,7 +171,7 @@ static void output(struct merge_options *o, int v, const char *fmt, ...)
 	strbuf_vaddf(&o->obuf, fmt, ap);
 	va_end(ap);
 
-	strbuf_add(&o->obuf, "\n", 1);
+	strbuf_addch(&o->obuf, '\n');
 	if (!o->buffer_output)
 		flush_output(o);
 }
diff --git a/pathspec.c b/pathspec.c
index 8043099..89f2c8f 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -338,7 +338,7 @@ static void NORETURN unsupported_magic(const char *pattern,
 		if (!(magic & m->bit))
 			continue;
 		if (sb.len)
-			strbuf_addstr(&sb, " ");
+			strbuf_addch(&sb, ' ');
 		if (short_magic & m->bit)
 			strbuf_addf(&sb, "'%c'", m->mnemonic);
 		else
diff --git a/url.c b/url.c
index 335d97d..7ca2a69 100644
--- a/url.c
+++ b/url.c
@@ -121,7 +121,7 @@ void end_url_with_slash(struct strbuf *buf, const char *url)
 {
 	strbuf_addstr(buf, url);
 	if (buf->len && buf->buf[buf->len - 1] != '/')
-		strbuf_addstr(buf, "/");
+		strbuf_addch(buf, '/');
 }
 
 void str_end_url_with_slash(const char *url, char **dest) {
-- 
2.0.0
