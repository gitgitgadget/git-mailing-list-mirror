From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH] archive.c: reduce scope of variables
Date: Wed, 29 Jan 2014 05:18:35 -0800
Message-ID: <1391001515-5672-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 29 14:18:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8V2T-0008Bd-Rm
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jan 2014 14:18:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896AbaA2NSl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jan 2014 08:18:41 -0500
Received: from mail-pd0-f174.google.com ([209.85.192.174]:53698 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751649AbaA2NSk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jan 2014 08:18:40 -0500
Received: by mail-pd0-f174.google.com with SMTP id z10so1673785pdj.5
        for <git@vger.kernel.org>; Wed, 29 Jan 2014 05:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=lKjPthQWCD7klxyboaYvwWWsr6+eheW6zchP8NWxfLA=;
        b=m7p65ApfRUbnlBxAQrr32xj5Id7+nVhq+o8IwdYBE3aaERDwTWGLdiPiDilFaAIdYx
         zvvQCLJaT/+hYW007svQxU/VJBy/WTGp7ltuSUhZR4bzQqi4BoD0ctCD8UZsECz/jNcm
         NOWPK0WuAkzW7hClU5mQ7vcHuGs31Prwl+SekycIXTJJYKj/Jrqo1L5IY+44PPMeRe3E
         t4fszIBftqH8HnCBtHeaJT7Z5Y6Pyc9GP8iZE+gVIdBbtzaCnVArG3YHAPwapd1rvSG7
         Vx3z5HSXrMHxZ5hCVp1Dv6705hnIeQTJwEfY8/zu0rC7plU5Y0oPpBPMtsl6YOqlV51x
         M1hQ==
X-Received: by 10.66.142.42 with SMTP id rt10mr7880605pab.1.1391001520238;
        Wed, 29 Jan 2014 05:18:40 -0800 (PST)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id dr1sm7159037pbc.18.2014.01.29.05.18.39
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 29 Jan 2014 05:18:39 -0800 (PST)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241207>

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 archive.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/archive.c b/archive.c
index 346f3b2..49b79f8 100644
--- a/archive.c
+++ b/archive.c
@@ -112,7 +112,6 @@ static int write_archive_entry(const unsigned char *sha1, const char *base,
 	write_archive_entry_fn_t write_entry = c->write_entry;
 	struct git_attr_check check[2];
 	const char *path_without_prefix;
-	int err;
 
 	args->convert = 0;
 	strbuf_reset(&path);
@@ -132,6 +131,7 @@ static int write_archive_entry(const unsigned char *sha1, const char *base,
 	}
 
 	if (S_ISDIR(mode) || S_ISGITLINK(mode)) {
+                int err;
 		if (args->verbose)
 			fprintf(stderr, "%.*s\n", (int)path.len, path.buf);
 		err = write_entry(args, sha1, path.buf, path.len, mode);
@@ -319,7 +319,6 @@ static int parse_archive_args(int argc, const char **argv,
 	const char *output = NULL;
 	int compression_level = -1;
 	int verbose = 0;
-	int i;
 	int list = 0;
 	int worktree_attributes = 0;
 	struct option opts[] = {
@@ -366,6 +365,7 @@ static int parse_archive_args(int argc, const char **argv,
 		base = "";
 
 	if (list) {
+                int i;
 		for (i = 0; i < nr_archivers; i++)
 			if (!is_remote || archivers[i]->flags & ARCHIVER_REMOTE)
 				printf("%s\n", archivers[i]->name);
-- 
1.7.10.4
