From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 14/15] update-index --refresh --porcelain: add missing const
Date: Mon, 21 Feb 2011 04:26:50 -0600
Message-ID: <20110221102650.GO32137@elie>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
 <20110221040012.GB26968@elie>
 <20110221101229.GA32137@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 21 11:27:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrSyr-0006Kv-Ex
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 11:27:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755332Ab1BUK05 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Feb 2011 05:26:57 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:54933 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753889Ab1BUK04 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Feb 2011 05:26:56 -0500
Received: by mail-iy0-f174.google.com with SMTP id 26so563440iyb.19
        for <git@vger.kernel.org>; Mon, 21 Feb 2011 02:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=C5xiPPD44VD+oUgtXtxfEJQWhMLNw1USdHw5AyHMZXQ=;
        b=s4Mde34sJ1jPYKzAeZzb/24ibaHYgy+xdgaT8FAC/atZx1QPTSB8KJ6ZX08rA1USNK
         oj7WGVSARDHk1vBJFlEtrZXCPYKlbgy6m8jRSFutdoyN2zkj8EWkKe6VcCBu7QKgaBTL
         GqZZZNVj9a0ooZwLeoYgMHjrV3QivC8gHWSfU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=P2eLP3rD7wE2mI3SImXyKhnUt+ATjpcZw5USen9TZ5+OCYwBMZH/mvwevormJt1pzU
         S20/18l3tua5Dpe3DO0AKqim4f30/qMJ60euz2QB+LoxEWbIGatfljX2J9smieEMdsep
         EW0YQoSet9Xm5nT00CccOm6nkO0H3FvV/EJek=
Received: by 10.42.189.136 with SMTP id de8mr1745866icb.174.1298284015625;
        Mon, 21 Feb 2011 02:26:55 -0800 (PST)
Received: from elie (adsl-69-209-53-52.dsl.chcgil.sbcglobal.net [69.209.53.52])
        by mx.google.com with ESMTPS id i16sm5044667ibl.12.2011.02.21.02.26.54
        (version=SSLv3 cipher=OTHER);
        Mon, 21 Feb 2011 02:26:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110221101229.GA32137@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167470>

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 cache.h      |    2 +-
 read-cache.c |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index a465f38..8188169 100644
--- a/cache.h
+++ b/cache.h
@@ -512,7 +512,7 @@ extern void fill_stat_cache_info(struct cache_entry *ce, struct stat *st);
 #define REFRESH_IGNORE_MISSING	0x0008	/* ignore non-existent */
 #define REFRESH_IGNORE_SUBMODULES	0x0010	/* ignore submodules */
 #define REFRESH_IN_PORCELAIN	0x0020	/* user friendly output, not "needs update" */
-extern int refresh_index(struct index_state *, unsigned int flags, const char **pathspec, char *seen, char *header_msg);
+extern int refresh_index(struct index_state *, unsigned int flags, const char **pathspec, char *seen, const char *header_msg);
 
 struct lock_file {
 	struct lock_file *next;
diff --git a/read-cache.c b/read-cache.c
index 4f2e890..15b0a73 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1104,7 +1104,7 @@ static struct cache_entry *refresh_cache_ent(struct index_state *istate,
 }
 
 static void show_file(const char * fmt, const char * name, int in_porcelain,
-		      int * first, char *header_msg)
+		      int * first, const char *header_msg)
 {
 	if (in_porcelain && *first && header_msg) {
 		printf("%s\n", header_msg);
@@ -1114,7 +1114,7 @@ static void show_file(const char * fmt, const char * name, int in_porcelain,
 }
 
 int refresh_index(struct index_state *istate, unsigned int flags, const char **pathspec,
-		  char *seen, char *header_msg)
+		  char *seen, const char *header_msg)
 {
 	int i;
 	int has_errors = 0;
-- 
1.7.4.1
