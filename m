Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 071A11F404
	for <e@80x24.org>; Fri,  2 Mar 2018 02:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164449AbeCBC4I (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 21:56:08 -0500
Received: from avasout01.plus.net ([84.93.230.227]:48031 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164430AbeCBC4H (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 21:56:07 -0500
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id rardeQQ32yLu5rareeuisA; Fri, 02 Mar 2018 02:56:06 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=QqtwI26d c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=LzoTUGzMI8N1yiqeNaQA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ungureanupaulsebastian@gmail.com,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 2/2] parse-options: remove the unused parse_opt_commits()
 function
Message-ID: <1b5dcc90-896b-9a45-e1eb-c7ee946a2105@ramsayjones.plus.com>
Date:   Fri, 2 Mar 2018 02:56:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfA728RDXJfRo7TBYwX+77APd2t8nKn8/R5t7jozSxxfD8uJ6Ioj3tnsAwCfsZaUIjjWaDoA/Py88OAqmeLjDmHljJBfi9jf0crr905wEHf+BIFbf5z6W
 oMXQcGb6AblA40HZDjxnz678iLmxF1kRBirJEhvFqTUnH49N1HGnbGfbeE7dK/voulI11R0fVemI9g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Commit fcfba37337 ('ref-filter: make "--contains <id>" less chatty if
<id> is invalid', 2018-02-23), removed the last use of the callback
function parse_opt_commits(). Remove this function declaration and
definition, since it is now dead code.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 parse-options-cb.c | 16 ----------------
 parse-options.h    |  1 -
 2 files changed, 17 deletions(-)

diff --git a/parse-options-cb.c b/parse-options-cb.c
index c6679cb2c..c7320a73f 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -78,22 +78,6 @@ int parse_opt_verbosity_cb(const struct option *opt, const char *arg,
 	return 0;
 }
 
-int parse_opt_commits(const struct option *opt, const char *arg, int unset)
-{
-	struct object_id oid;
-	struct commit *commit;
-
-	if (!arg)
-		return -1;
-	if (get_oid(arg, &oid))
-		return error("malformed object name %s", arg);
-	commit = lookup_commit_reference(&oid);
-	if (!commit)
-		return error("no such commit %s", arg);
-	commit_list_insert(commit, opt->value);
-	return 0;
-}
-
 int parse_opt_object_name(const struct option *opt, const char *arg, int unset)
 {
 	struct object_id oid;
diff --git a/parse-options.h b/parse-options.h
index 4b4734f2e..2b8378ac1 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -224,7 +224,6 @@ extern int parse_opt_expiry_date_cb(const struct option *, const char *, int);
 extern int parse_opt_color_flag_cb(const struct option *, const char *, int);
 extern int parse_opt_verbosity_cb(const struct option *, const char *, int);
 extern int parse_opt_object_name(const struct option *, const char *, int);
-extern int parse_opt_commits(const struct option *, const char *, int);
 extern int parse_opt_tertiary(const struct option *, const char *, int);
 extern int parse_opt_string_list(const struct option *, const char *, int);
 extern int parse_opt_noop_cb(const struct option *, const char *, int);
-- 
2.16.0
