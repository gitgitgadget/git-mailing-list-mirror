Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D25FC208CD
	for <e@80x24.org>; Sat, 19 Aug 2017 05:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751056AbdHSF36 (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Aug 2017 01:29:58 -0400
Received: from mout.web.de ([217.72.192.78]:64579 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751029AbdHSF35 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Aug 2017 01:29:57 -0400
Received: from [192.168.178.36] ([91.20.52.82]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LlneG-1d9bVh2OsS-00ZOGQ; Sat, 19
 Aug 2017 07:29:45 +0200
Subject: [PATCH 2/4] archive: factor out helper functions for handling
 attributes
To:     git@vger.kernel.org
Cc:     David Adam <zanchey@ucc.gu.uwa.edu.au>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <alpine.DEB.2.11.1708131240360.15538@motsugo.ucc.gu.uwa.edu.au>
 <ae893c19-652d-1c8f-50ba-1242b95be84e@web.de>
 <887652a4-3f03-e2dd-2c68-cff4f7194898@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <aaf9c857-76b9-5766-59ce-cffc1b65015f@web.de>
Date:   Sat, 19 Aug 2017 07:29:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <887652a4-3f03-e2dd-2c68-cff4f7194898@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:mxisagbSPZObecWXSSV3BPye7d/qULX/27hOW5YyxMHQ9zokWF5
 aVwN1q5VzFWxGBb2aNgPda3UEzxzjUUY6xzifnSUzKMHfZrb8mSfnhHaNNfCC6P4Vx3ErLD
 sQL9QW3tiAMmFLj54aLTvJx8PCDIDymoCMw974eqHcAh8QcuYWy3XbMVXYVeSPTBAf0yiMV
 PVAym1fxAjDlVLvca/urA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lYxBolcfD5w=:gSHwRKB495Z37dvm91mgYF
 M8OSM8RSUTbIXwB3H733LxmOTynKLiud5AbBJqr72LK05+7uOmKvHmJ2PMNfytlfSXEdw/jAy
 El6ZwRot4texVa1tBZzFvRwc4yqAd195yoQ7JC6fBKfXI5YPBATQ9RTF7aHFUbadOmYrmBoIY
 gaNDQJyY6CKmXKGae/4HSCjqFe0LNiKc3bSSzsz3V5XRUog87aUL35WOUO3ivKGe0tjXiKyFD
 t3OWrKbb5UqAKYkEVOGJP1vtRJpLH+iGioakoXA2P26sGQr7mcXiDIawdR+7p/Ab86jS1DbRt
 Tr0y5NtvLrRuKn+GZc3p5R3r3bda6GSUdg7jg/u4xsZqKqQsiaEwzS8asJas0pXyJpWRkisbm
 19r8swB3t54VDHVfVHbX8GOo7m5ayFS99APgr2oxLinVkndQIsjfbR2oXuCLiEN291keiLrQa
 ouE6ixR8waeEpu1RCvLP8P+jDuPMtPXTn6ZzZTbqx405hO4zvo/R/naLqOG0TZuTzitSBx/lw
 70xdWAa8K8OMcjR4o85Mo18WtxjP2tReP5qWWTJ9mncILUiQn+9no/cRvqmJi5XwXQ8rO/gG4
 Xq5GJJGzsezOP2QyTEeT9B7CZbcI50Dsiw/8G2u7A92X52/HXdZwuagAXpbyTs+pMYIDsvdNd
 kS0WHuF6FYPwsQS0hsNCwYHzuAt29gGxbEtuJPARdIXm6DdHVt4lK3zqs7zs1IjMU2LxkuXR0
 34cagifB4BLef3Z9wpg68+9Y3s+0bmPpL6vQ6RBpcTnUXkX17owzauHs9v6NlqQEjj/O45A1G
 /GkQrzEBRalzfnBgON6hBqfaz30+qsdZgix0AuCxZkwsp7BNtw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add helpers for accessing attributes that encapsulate the details of how
to retrieve their values.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 archive.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/archive.c b/archive.c
index 557dd2db85..8e5f632912 100644
--- a/archive.c
+++ b/archive.c
@@ -103,12 +103,30 @@ struct archiver_context {
 	struct directory *bottom;
 };
 
+static const struct attr_check *get_archive_attrs(const char *path)
+{
+	static struct attr_check *check;
+	if (!check)
+		check = attr_check_initl("export-ignore", "export-subst", NULL);
+	return git_check_attr(path, check) ? NULL : check;
+}
+
+static int check_attr_export_ignore(const struct attr_check *check)
+{
+	return check && ATTR_TRUE(check->items[0].value);
+}
+
+static int check_attr_export_subst(const struct attr_check *check)
+{
+	return check && ATTR_TRUE(check->items[1].value);
+}
+
 static int write_archive_entry(const unsigned char *sha1, const char *base,
 		int baselen, const char *filename, unsigned mode, int stage,
 		void *context)
 {
 	static struct strbuf path = STRBUF_INIT;
-	static struct attr_check *check;
+	const struct attr_check *check;
 	struct archiver_context *c = context;
 	struct archiver_args *args = c->args;
 	write_archive_entry_fn_t write_entry = c->write_entry;
@@ -125,13 +143,10 @@ static int write_archive_entry(const unsigned char *sha1, const char *base,
 		strbuf_addch(&path, '/');
 	path_without_prefix = path.buf + args->baselen;
 
-	if (!check)
-		check = attr_check_initl("export-ignore", "export-subst", NULL);
-	if (!git_check_attr(path_without_prefix, check)) {
-		if (ATTR_TRUE(check->items[0].value))
-			return 0;
-		args->convert = ATTR_TRUE(check->items[1].value);
-	}
+	check = get_archive_attrs(path_without_prefix);
+	if (check_attr_export_ignore(check))
+		return 0;
+	args->convert = check_attr_export_subst(check);
 
 	if (S_ISDIR(mode) || S_ISGITLINK(mode)) {
 		if (args->verbose)
-- 
2.14.1
