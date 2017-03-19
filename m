Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D4D420323
	for <e@80x24.org>; Sun, 19 Mar 2017 20:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752599AbdCSUZp (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Mar 2017 16:25:45 -0400
Received: from avasout01.plus.net ([84.93.230.227]:44955 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752400AbdCSUZp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2017 16:25:45 -0400
Received: from [10.0.2.15] ([146.90.175.94])
        by avasout01 with smtp
        id xwRi1u00522aPyA01wRj0z; Sun, 19 Mar 2017 20:25:43 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=BZKo6vl2 c=1 sm=1 tr=0
 a=c4JbszTospdBBUsinAk+iw==:117 a=c4JbszTospdBBUsinAk+iw==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=YnPJ5dqK2h73g42b77UA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Subject: [PATCH 2/2] refs: remove forward declaration for
 files_log_ref_write()
Message-ID: <78de71f0-87ce-b92e-d592-1370ec3830ac@ramsayjones.plus.com>
Date:   Sun, 19 Mar 2017 20:25:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Commit 7d3989dac9 ("files-backend: make files_log_ref_write() static",
18-03-2017) made the files_log_ref_write() function static by adding
an, otherwise useless, forward declaration. This causes sparse to
issue a warning. A much simpler solution is to simply add the static
keyword to the function definition.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Duy,

If you need to re-roll your 'nd/files-backend-git-dir' branch, could you please
squash this into the relevant patch.

Thanks!

ATB,
Ramsay Jones

 refs/files-backend.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 0f423be18..b4cae64ab 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -165,10 +165,6 @@ static struct ref_entry *create_dir_entry(struct files_ref_store *ref_store,
 					  const char *dirname, size_t len,
 					  int incomplete);
 static void add_entry_to_dir(struct ref_dir *dir, struct ref_entry *entry);
-static int files_log_ref_write(struct files_ref_store *refs,
-			       const char *refname, const unsigned char *old_sha1,
-			       const unsigned char *new_sha1, const char *msg,
-			       int flags, struct strbuf *err);
 
 static struct ref_dir *get_ref_dir(struct ref_entry *entry)
 {
@@ -2926,10 +2922,10 @@ static int log_ref_write_fd(int fd, const unsigned char *old_sha1,
 	return 0;
 }
 
-int files_log_ref_write(struct files_ref_store *refs,
-			const char *refname, const unsigned char *old_sha1,
-			const unsigned char *new_sha1, const char *msg,
-			int flags, struct strbuf *err)
+static int files_log_ref_write(struct files_ref_store *refs,
+			       const char *refname, const unsigned char *old_sha1,
+			       const unsigned char *new_sha1, const char *msg,
+			       int flags, struct strbuf *err)
 {
 	int logfd, result;
 
-- 
2.12.0
