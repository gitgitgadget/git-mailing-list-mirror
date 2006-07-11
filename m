From: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 1/3] Make the unpacked object header functions static to
 sha1_file.c
Date: Tue, 11 Jul 2006 10:10:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607111009550.5623@g5.osdl.org>
References: <20060710230132.GA11132@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0607101623230.5623@g5.osdl.org> <20060711145527.GA32468@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0607111004360.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 11 19:17:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0LrJ-0004DJ-1K
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 19:17:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbWGKRQ4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 13:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbWGKRQz
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 13:16:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19633 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751137AbWGKRQy (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jul 2006 13:16:54 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6BHAUnW011894
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 11 Jul 2006 10:10:31 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6BHATVD029578;
	Tue, 11 Jul 2006 10:10:30 -0700
To: Carl Baldwin <cnb@fc.hp.com>, Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0607111004360.5623@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.85__
X-MIMEDefang-Filter: osdl$Revision: 1.140 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23717>


Nobody else uses them, and I'm going to start changing them.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
 cache.h     |    2 --
 sha1_file.c |    4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index b5e3f8f..d433d46 100644
--- a/cache.h
+++ b/cache.h
@@ -219,8 +219,6 @@ int safe_create_leading_directories(char
 char *enter_repo(char *path, int strict);
 
 /* Read and unpack a sha1 file into memory, write memory to a sha1 file */
-extern int unpack_sha1_header(z_stream *stream, void *map, unsigned long mapsize, void *buffer, unsigned long size);
-extern int parse_sha1_header(char *hdr, char *type, unsigned long *sizep);
 extern int sha1_object_info(const unsigned char *, char *, unsigned long *);
 extern void * unpack_sha1_file(void *map, unsigned long mapsize, char *type, unsigned long *size);
 extern void * read_sha1_file(const unsigned char *sha1, char *type, unsigned long *size);
diff --git a/sha1_file.c b/sha1_file.c
index 459430a..8734d50 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -684,7 +684,7 @@ static void *map_sha1_file_internal(cons
 	return map;
 }
 
-int unpack_sha1_header(z_stream *stream, void *map, unsigned long mapsize, void *buffer, unsigned long size)
+static int unpack_sha1_header(z_stream *stream, void *map, unsigned long mapsize, void *buffer, unsigned long size)
 {
 	/* Get the data stream */
 	memset(stream, 0, sizeof(*stream));
@@ -720,7 +720,7 @@ static void *unpack_sha1_rest(z_stream *
  * too permissive for what we want to check. So do an anal
  * object header parse by hand.
  */
-int parse_sha1_header(char *hdr, char *type, unsigned long *sizep)
+static int parse_sha1_header(char *hdr, char *type, unsigned long *sizep)
 {
 	int i;
 	unsigned long size;
