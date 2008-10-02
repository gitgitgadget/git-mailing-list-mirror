From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH] config.c: make git_parse_long() static
Date: Thu, 02 Oct 2008 19:14:27 +0900
Message-ID: <20081002191427.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 02 12:16:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlLEb-0007Bl-8r
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 12:16:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753271AbYJBKOz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 06:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753222AbYJBKOz
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 06:14:55 -0400
Received: from karen.lavabit.com ([72.249.41.33]:41923 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753234AbYJBKOx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 06:14:53 -0400
Received: from d.earth.lavabit.com (d.earth.lavabit.com [192.168.111.13])
	by karen.lavabit.com (Postfix) with ESMTP id BBE70C7B30;
	Thu,  2 Oct 2008 05:14:52 -0500 (CDT)
Received: from 6138.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id JKJ7YQIDRVOY; Thu, 02 Oct 2008 05:14:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=IjYOXTaLqKD5GNc5yM16vATqHrxkKD7g/nqk75Ku9/2tWX6mO5z2GIGfmmMWe585a41RL+9CvP8FpEGHBICPXONHcB7Em+DAOknJY45Zz7kdq4nI1PE4wnrnlX6AdBqRfuhrY6MCFpWWPNg6KthfS4/VazQ/NvCqRfR6TUbm3oU=;
  h=From:To:Cc:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97306>

This function is not used in any other file.

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---
 cache.h  |    1 -
 config.c |    4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index de8c2b6..5a61f5e 100644
--- a/cache.h
+++ b/cache.h
@@ -742,7 +742,6 @@ typedef int (*config_fn_t)(const char *, const char *, void *);
 extern int git_default_config(const char *, const char *, void *);
 extern int git_config_from_file(config_fn_t fn, const char *, void *);
 extern int git_config(config_fn_t fn, void *);
-extern int git_parse_long(const char *, long *);
 extern int git_parse_ulong(const char *, unsigned long *);
 extern int git_config_int(const char *, const char *);
 extern unsigned long git_config_ulong(const char *, const char *);
diff --git a/config.c b/config.c
index 53f04a0..7d5843f 100644
--- a/config.c
+++ b/config.c
@@ -255,7 +255,7 @@ static int parse_unit_factor(const char *end, unsigned long *val)
 	return 0;
 }
 
-int git_parse_long(const char *value, long *ret)
+static int git_parse_long(const char *value, long *ret)
 {
 	if (value && *value) {
 		char *end;
@@ -291,7 +291,7 @@ static void die_bad_config(const char *name)
 
 int git_config_int(const char *name, const char *value)
 {
-	long ret;
+	long ret = 0;
 	if (!git_parse_long(value, &ret))
 		die_bad_config(name);
 	return ret;
-- 
1.6.0.2

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
