Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C34C22047F
	for <e@80x24.org>; Sun, 17 Sep 2017 22:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751911AbdIQW20 (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Sep 2017 18:28:26 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:37862 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751533AbdIQW2X (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Sep 2017 18:28:23 -0400
Received: by mail-io0-f196.google.com with SMTP id 93so7463383iol.4
        for <git@vger.kernel.org>; Sun, 17 Sep 2017 15:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vi/2aJ2OuWpJm+CVYKnDJu2cCgM+HQ1YcJVxQ7QPVoI=;
        b=K+gx1flzLUJXTQh6/tlCuTj/Px692AppK3kE2X233oqMFgZUN4wfxGXhANJWsP6DUs
         WV74Cn8zE/4z1r7wzX3aUn6BMvCWxOK2Whput5FKZBWXeSQgi/tlB9ciXsXe68N9XhXa
         xCoBaSVb92YU4ODWTaBU2AlW5MgHy9XKczxaJFrG3s09kNqk5K12mkWxIupcAMjahEdZ
         +wUKIUuQ7seen3Ev6ln7BOWE6EaxtYJyaeU7zZF9XviYGnqmpUka9MKQdFtbo6mr0Ylz
         pDxY5MiAgHqHTPwIHpDpx8bZK+jVfJlkBHU6aa+ufORrLjSIiHcAxFngQwbl2XbJTCcU
         shvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vi/2aJ2OuWpJm+CVYKnDJu2cCgM+HQ1YcJVxQ7QPVoI=;
        b=F33TPOuLivEIfb1ygl8e/t37B0N/t1YxuUyXMC5uQC9oP/LA4Sow2O9LIo+pK07tmy
         WQUwWoNCL8GoLGoE9Iw0lgsg540cxcfmp8WCaXK8YzcoxO/48OCRgyrEsKNGW+DibO2z
         v0kg/FmvBYfBDfiqzfn7zoKY46H6LRTWXM5y9bNEyR6DL1fvDdItx5tn4Hg8A9l6+iSI
         nL1+zMF/nbFf9KpE6FG5ey2sx3OXj5EB1NEc6Z/IwnQCh2/sUNkZblOXXoyKoxLw28tw
         rJsm/Kug99AIBrFi7srla0Fy7veaPmAgg+JlQlFweowWrBlkesC+1nbAmcQtzEI5anDt
         0fKQ==
X-Gm-Message-State: AHPjjUilW6HGQOSFPCv4r/y+1h6/VbklK+lV2Y/90Y7HIKjQfHxd/EKx
        SWMQRZf2sx0F99B/V6Q=
X-Google-Smtp-Source: AOwi7QBeGwzuDVyTZFKZsNbMTgJVMq3buUbm0nBwoCjsV0DKOA1BtmCSJlpLTBZ2SGUQK7BpxykUWA==
X-Received: by 10.202.228.147 with SMTP id b141mr36584877oih.180.1505687302833;
        Sun, 17 Sep 2017 15:28:22 -0700 (PDT)
Received: from pixel.attlocal.net (75-59-239-78.lightspeed.sntcca.sbcglobal.net. [75.59.239.78])
        by smtp.gmail.com with ESMTPSA id d74sm6324438oib.30.2017.09.17.15.28.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Sep 2017 15:28:22 -0700 (PDT)
From:   Brandon Casey <drafnel@gmail.com>
To:     git@vger.kernel.org
Cc:     ilya.bobyr@gmail.com, Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 3/4] rev-parse parseopt: interpret any whitespace as start of help text
Date:   Sun, 17 Sep 2017 15:28:16 -0700
Message-Id: <1505687297-31183-3-git-send-email-drafnel@gmail.com>
X-Mailer: git-send-email 2.2.0.rc3
In-Reply-To: <1505687297-31183-1-git-send-email-drafnel@gmail.com>
References: <1505687297-31183-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, rev-parse only interprets a space ' ' character as the
delimiter between the option spec and the help text.  So if a tab
character is placed between the option spec and the help text, it will
be interpreted as part of the long option name or as part of the arg
hint.  If it is interpreted as part of the long option name, then
rev-parse will produce what will be interpreted as multiple arguments
on the command line.

For example, the following option spec (note: there is a <tab> between
"frotz" and "enable"):

    frotz	enable frotzing

will produce the following set expression when --frotz is used:

    set -- --frotz --

instead of this:

    set -- --frotz  enable --

Mark t1502.2 as fixed.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 builtin/rev-parse.c           | 12 ++++++++++--
 t/t1502-rev-parse-parseopt.sh |  2 +-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index b19f677..351b1a3 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -387,6 +387,14 @@ static const char *skipspaces(const char *s)
 	return s;
 }
 
+static char *findspace(const char *s)
+{
+	for (; *s; s++)
+		if (isspace(*s))
+			return (char*)s;
+	return NULL;
+}
+
 static int cmd_parseopt(int argc, const char **argv, const char *prefix)
 {
 	static int keep_dashdash = 0, stop_at_non_option = 0;
@@ -444,8 +452,8 @@ static int cmd_parseopt(int argc, const char **argv, const char *prefix)
 		memset(opts + onb, 0, sizeof(opts[onb]));
 
 		o = &opts[onb++];
-		help = strchr(sb.buf, ' ');
-		if (!help || *sb.buf == ' ') {
+		help = findspace(sb.buf);
+		if (!help || sb.buf == help) {
 			o->type = OPTION_GROUP;
 			o->help = xstrdup(skipspaces(sb.buf));
 			continue;
diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt.sh
index 3d895e0..6e1b45f 100755
--- a/t/t1502-rev-parse-parseopt.sh
+++ b/t/t1502-rev-parse-parseopt.sh
@@ -38,7 +38,7 @@ test_expect_success 'setup optionspec' '
 EOF
 '
 
-test_expect_failure 'test --parseopt help output' '
+test_expect_success 'test --parseopt help output' '
 	sed -e "s/^|//" >expect <<\END_EXPECT &&
 |cat <<\EOF
 |usage: some-command [options] <args>...
-- 
2.2.0.rc3

