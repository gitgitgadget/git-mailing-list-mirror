Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68AEB2047F
	for <e@80x24.org>; Sun, 17 Sep 2017 22:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751884AbdIQW2Z (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Sep 2017 18:28:25 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:33446 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751562AbdIQW2W (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Sep 2017 18:28:22 -0400
Received: by mail-io0-f195.google.com with SMTP id j26so7461961iod.0
        for <git@vger.kernel.org>; Sun, 17 Sep 2017 15:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EQqn5DsKZti/BFA2DZnbFVmPnmKIGdo80qorMpNym5M=;
        b=btq0SIxZKpbxip6kT3M0xk4VaEJGd7dWGLAE+azJ9RMZnsOtvGoKmrs7qblnV17oIE
         YCdMx77Q2Go3wf6GnyH4JN7F0x/1iAhxRi/TNds1gZYLavlH9GdaH9IJzoYkX5efDGWK
         WYf7m+v7/v0lSq8eD+Ci289P4TnI2aNdwyGZsJM4is/PeLICpQNg+k6D/JyBugi7PViI
         wMxZFBtr7dZgLFzIRrc9pcmvxmevmDqnaqR8wAdQpIzR+TiiRioIynvwlJrZAZ3xcmQE
         pRapQci+uZy6q5VZLM/++MBEQzztRh3hevTeKiLERCmgXlde8Yryg51Squ3rpcV6mVQr
         a9bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EQqn5DsKZti/BFA2DZnbFVmPnmKIGdo80qorMpNym5M=;
        b=J2gkeStAUr6hwxPZGHyzo72WGgvTQcvk1YLhigjq5QPf/mInkHRVA9sV2t6fTuAjha
         /L26DgchbXVTEzWoqeqU8v76F/tk3n+eMl0lvCYPH955if34IgiwXF6ZsslyhAnoO9S2
         DEk7lRc/56shK26xdC1Zl+vZi01q9+Xh9ZXwYd/ALZIFfBLs5QRlFAy4A5WXGYwFM9e1
         jMS3BCLJpRovm0AmEit8nr7+HPS4tg2rZriaVnRF0Elfzf1vrF8KalYazfpiCX+H6pio
         t3nX5YR0pe2HN4rr2306bGzi9FzQyE4io+7XWUO/D6SfTQx1urZmYvVUSuTmlb4/RdQ+
         0oPQ==
X-Gm-Message-State: AHPjjUj6CRCXSH0Jh9y/jWpJT/W1LeDhhb/rtOdgBn3FOUsdZFfshvKV
        Llejeua1ee0gu9AT6iI=
X-Google-Smtp-Source: AOwi7QAys77jooil8ONhM9RmSkdo0SVBSTadIauqrAPOuiRD9buhHslu72O6bzLYsirkPdGtZEPPGA==
X-Received: by 10.202.54.6 with SMTP id d6mr4255105oia.85.1505687301853;
        Sun, 17 Sep 2017 15:28:21 -0700 (PDT)
Received: from pixel.attlocal.net (75-59-239-78.lightspeed.sntcca.sbcglobal.net. [75.59.239.78])
        by smtp.gmail.com with ESMTPSA id d74sm6324438oib.30.2017.09.17.15.28.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Sep 2017 15:28:21 -0700 (PDT)
From:   Brandon Casey <drafnel@gmail.com>
To:     git@vger.kernel.org
Cc:     ilya.bobyr@gmail.com, Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 2/4] rev-parse parseopt: do not search help text for flag chars
Date:   Sun, 17 Sep 2017 15:28:15 -0700
Message-Id: <1505687297-31183-2-git-send-email-drafnel@gmail.com>
X-Mailer: git-send-email 2.2.0.rc3
In-Reply-To: <1505687297-31183-1-git-send-email-drafnel@gmail.com>
References: <1505687297-31183-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When searching for flag characters in the option spec, we should ensure
the search stays within the bounds of the option spec and does not enter
the help text portion of the spec.  So when we find the boundary white
space marking the start of the help text, let's mark it with a nul
character.  Then when we search for flag characters starting from the
beginning of the string we'll stop at the nul and won't enter the help
text.

Now, the following option spec:

    exclame this does something!

will produce this 'set' expression when --exclame is specified:

    set -- --exclame --

instead of this one:

    set -- --exclame this does something --

Mark t1502.4 and t1502.5 as fixed.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 builtin/rev-parse.c           | 6 ++++--
 t/t1502-rev-parse-parseopt.sh | 4 ++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 2bd28d3..b19f677 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -434,7 +434,7 @@ static int cmd_parseopt(int argc, const char **argv, const char *prefix)
 	/* parse: (<short>|<short>,<long>|<long>)[*=?!]*<arghint>? SP+ <help> */
 	while (strbuf_getline(&sb, stdin) != EOF) {
 		const char *s;
-		const char *help;
+		char *help;
 		struct option *o;
 
 		if (!sb.len)
@@ -451,8 +451,10 @@ static int cmd_parseopt(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 
+		*help = '\0';
+
 		o->type = OPTION_CALLBACK;
-		o->help = xstrdup(skipspaces(help));
+		o->help = xstrdup(skipspaces(help+1));
 		o->value = &parsed;
 		o->flags = PARSE_OPT_NOARG;
 		o->callback = &parseopt_dump;
diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt.sh
index 910fc56..3d895e0 100755
--- a/t/t1502-rev-parse-parseopt.sh
+++ b/t/t1502-rev-parse-parseopt.sh
@@ -85,12 +85,12 @@ set -- --foo --bar 'ham' -b --aswitch -- 'arg'
 EOF
 "
 
-test_expect_failure 'test --parseopt' '
+test_expect_success 'test --parseopt' '
 	git rev-parse --parseopt -- --foo --bar=ham --baz --aswitch arg < optionspec > output &&
 	test_cmp expect output
 '
 
-test_expect_failure 'test --parseopt with mixed options and arguments' '
+test_expect_success 'test --parseopt with mixed options and arguments' '
 	git rev-parse --parseopt -- --foo arg --bar=ham --baz --aswitch < optionspec > output &&
 	test_cmp expect output
 '
-- 
2.2.0.rc3

