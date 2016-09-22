Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DBDC1F4F8
	for <e@80x24.org>; Thu, 22 Sep 2016 18:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030243AbcIVSxq (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 14:53:46 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34377 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941026AbcIVSx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 14:53:28 -0400
Received: by mail-qk0-f194.google.com with SMTP id b204so5745643qkc.1
        for <git@vger.kernel.org>; Thu, 22 Sep 2016 11:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OA2F+U+P850UaVNQrGyxQCQLvRqF8a4kKWKQgouS6qg=;
        b=1KibyxdK/McB0NAbxBamMOuAZI2xw4aBQtWcBAyRXkCjs0L7vDlvQIbl/r9hgqUzLN
         gaamb++FIcNIhi9QGolztUCPATLNXW/x+3it0hSBj0jYI1mbOnwAsDgxJUCI3AoVYSJ8
         jLPlMG3phkb7VbbcoKdkvJd5lab35qOmdNnaFsCl2faAh33GXM56RYCMJPeAOOcF1QTF
         /Y+f1PRLWX/MqQKeiqgC44ESaoEekWrxNozdIC9Y3YIkL+US/6YIFdUxZB35pVw4cA9E
         irwXinLcjpVJqYlUJiyuzoJZS82zfOCD/xHUrg1fZC/bKMxOHZJ4KPQyYQ42iYXga6p6
         0Ixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OA2F+U+P850UaVNQrGyxQCQLvRqF8a4kKWKQgouS6qg=;
        b=VUVp8qRLfvv6cmueYB2JWtHcUfcX3et/HWocorqJ3hARjl95edvmX09mqlnN0osWW3
         c3z1ilyAoHo5GrNjK1V0/UCyQ3PTycCSvyxfqaw1sO52q8yUYldn95HsO/iA1pCUO1IW
         HgA+4zCZfcRNmTgGYJqNz0rs1WR7WZkhEM/t9kT8t7B9paZl8Pp8HsI/RSjQyeH19lc5
         6VMKdBsY2apc8AXj6xoDVwoyABVxGW8+X6Z5gOzXVy6dXDKeC9rTHT7fRCekmvYrkL4B
         F+kCvZsRWZ5pYKKp/kym2AjlN/TS1NoOMVO8GVTJ9Lb9x3LdCH+X6szAbafIyd9HW+wa
         ddsg==
X-Gm-Message-State: AA6/9RnEZGkuht6pfNiCpiKjfoePSZXebw1Wx57MZrK8KAymab2QooPUFRoSYgiNOlNfWTlK
X-Received: by 10.55.70.65 with SMTP id t62mr3612700qka.31.1474570407231;
        Thu, 22 Sep 2016 11:53:27 -0700 (PDT)
Received: from LykOS.nyu.edu (NYUFWA-WLESSAUTHCLIENTS-19.NATPOOL.NYU.EDU. [216.165.95.8])
        by smtp.gmail.com with ESMTPSA id m87sm1675117qkl.21.2016.09.22.11.53.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Sep 2016 11:53:26 -0700 (PDT)
From:   santiago@nyu.edu
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org, Lukas P <luk.puehringer@gmail.com>,
        Lukas Puehringer <lukas.puehringer@nyu.edu>
Subject: [PATCH 6/6] builtin/tag: add --format argument for tag -v
Date:   Thu, 22 Sep 2016 14:53:17 -0400
Message-Id: <20160922185317.349-7-santiago@nyu.edu>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20160922185317.349-1-santiago@nyu.edu>
References: <20160922185317.349-1-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lukas P <luk.puehringer@gmail.com>

Adding --format to git tag -v mutes the default output of the GPG
verification and instead prints the formatted tag object.

This allows callers to cross-check the tagname from refs/tags with
the tagname from the tag object header upon GPG verification.

Signed-off-by: Lukas Puehringer <lukas.puehringer@nyu.edu>
---
 builtin/tag.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 94ed8a2..3dd1e65 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -24,7 +24,7 @@ static const char * const git_tag_usage[] = {
 	N_("git tag -d <tagname>..."),
 	N_("git tag -l [-n[<num>]] [--contains <commit>] [--points-at <object>]"
 		"\n\t\t[--format=<format>] [--[no-]merged [<commit>]] [<pattern>...]"),
-	N_("git tag -v <tagname>..."),
+	N_("git tag -v [--format=<format>] <tagname>..."),
 	NULL
 };
 
@@ -106,7 +106,13 @@ static int delete_tag(const char *name, const char *ref,
 static int verify_tag(const char *name, const char *ref,
 				const unsigned char *sha1)
 {
-	return verify_and_format_tag(sha1, name, NULL, GPG_VERIFY_VERBOSE);
+	int flags;
+	flags = GPG_VERIFY_VERBOSE;
+
+	if (fmt_pretty)
+		flags = GPG_VERIFY_QUIET;
+
+	return verify_and_format_tag(sha1, name, fmt_pretty, flags);
 }
 
 static int do_sign(struct strbuf *buffer)
@@ -425,8 +431,11 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		die(_("--merged and --no-merged option are only allowed with -l"));
 	if (cmdmode == 'd')
 		return for_each_tag_name(argv, delete_tag);
-	if (cmdmode == 'v')
+	if (cmdmode == 'v') {
+		if (fmt_pretty)
+			verify_ref_format(fmt_pretty);
 		return for_each_tag_name(argv, verify_tag);
+	}
 
 	if (msg.given || msgfile) {
 		if (msg.given && msgfile)
-- 
2.10.0

