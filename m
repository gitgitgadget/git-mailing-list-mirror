Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12D0F1F516
	for <e@80x24.org>; Thu, 21 Jun 2018 15:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933120AbeFUPVs (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 11:21:48 -0400
Received: from mail.vm.ouaza.com ([212.83.178.2]:36557 "EHLO mail.vm.ouaza.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932848AbeFUPVr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 11:21:47 -0400
Received: from x260-buxy.home.ouaza.com (133-218-190-109.isp.overthebox.ovh [109.190.218.133])
        by mail.vm.ouaza.com (Postfix) with ESMTPSA id 76DA02094E;
        Thu, 21 Jun 2018 17:20:47 +0200 (CEST)
Received: by x260-buxy.home.ouaza.com (Postfix, from userid 1000)
        id 7FF7B8A2BD8; Thu, 21 Jun 2018 17:21:45 +0200 (CEST)
Date:   Thu, 21 Jun 2018 17:21:45 +0200
From:   Raphael Hertzog <hertzog@debian.org>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, jn.avila@free.fr
Subject: Re: [PATCH 2/2] i18n: bisect: mark two supplementary strings for
 translation
Message-ID: <20180621152145.GA29912@home.ouaza.com>
References: <20180621142742.28575-1-hertzog@debian.org>
 <20180621142742.28575-3-hertzog@debian.org>
 <CACsJy8DcXo3HURwZXbvGYjrJpfku+RXESP=ErLzYj3NhNabRTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACsJy8DcXo3HURwZXbvGYjrJpfku+RXESP=ErLzYj3NhNabRTQ@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Virus-Scanned: clamav-milter 0.99.4 at mail
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi,

On Thu, 21 Jun 2018, Duy Nguyen wrote:
> Nice. There's another string in bisect_common() that should also be
> translated: "revision walk setup failed". Maybe you can mark it too?

Sure. A new version of the second patch is attached.

Cheers,
-- 
Raphaël Hertzog ◈ Debian Developer

Support Debian LTS: https://www.freexian.com/services/debian-lts.html
Learn to master Debian: https://debian-handbook.info/get/

--EeQfGwPcQSOJBaQU
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment; filename="0002-i18n-bisect-mark-three-supplementary-strings-for-tra.patch"
Content-Transfer-Encoding: 8bit

From 9731f23b9e2f47bdb90e552264c9d030b4f40629 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Rapha=C3=ABl=20Hertzog?= <hertzog@debian.org>
Date: Thu, 21 Jun 2018 16:06:48 +0200
Subject: [PATCH 2/2] i18n: bisect: mark three supplementary strings for
 translation
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The whole bisect procedure is translated but the last message that the
user will see in the process is not translated. Let's fix this.

Also mark the "revision walk setup failed" error message for
translation. It's already used in other files so will not generate
any new string to translate.

Signed-off-by: Raphaël Hertzog <hertzog@debian.org>
---
 bisect.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/bisect.c b/bisect.c
index a579b5088..4943eb333 100644
--- a/bisect.c
+++ b/bisect.c
@@ -647,7 +647,7 @@ static void bisect_rev_setup(struct rev_info *revs, const char *prefix,
 static void bisect_common(struct rev_info *revs)
 {
 	if (prepare_revision_walk(revs))
-		die("revision walk setup failed");
+		die(_("revision walk setup failed"));
 	if (revs->tree_objects)
 		mark_edges_uninteresting(revs, NULL);
 }
@@ -658,8 +658,8 @@ static void exit_if_skipped_commits(struct commit_list *tried,
 	if (!tried)
 		return;
 
-	printf("There are only 'skip'ped commits left to test.\n"
-	       "The first %s commit could be any of:\n", term_bad);
+	printf(_("There are only 'skip'ped commits left to test.\n"
+		 "The first %s commit could be any of:\n"), term_bad);
 
 	for ( ; tried; tried = tried->next)
 		printf("%s\n", oid_to_hex(&tried->item->object.oid));
@@ -984,7 +984,7 @@ int bisect_next_all(const char *prefix, int no_checkout)
 
 	if (!oidcmp(bisect_rev, current_bad_oid)) {
 		exit_if_skipped_commits(tried, current_bad_oid);
-		printf("%s is the first %s commit\n", oid_to_hex(bisect_rev),
+		printf(_("%s is the first %s commit\n"), oid_to_hex(bisect_rev),
 			term_bad);
 		show_diff_tree(prefix, revs.commits->item);
 		/* This means the bisection process succeeded. */
-- 
2.18.0.rc2


--EeQfGwPcQSOJBaQU--
