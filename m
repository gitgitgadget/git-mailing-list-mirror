Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 288DE2047F
	for <e@80x24.org>; Mon, 25 Sep 2017 04:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752576AbdIYEIQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 00:08:16 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34369 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750852AbdIYEIO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 00:08:14 -0400
Received: by mail-oi0-f66.google.com with SMTP id v188so2984818oia.1
        for <git@vger.kernel.org>; Sun, 24 Sep 2017 21:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZpEdbEUIDGmnmMpZ/TTCm6yurtVjEpXE/FjGd6hHOwQ=;
        b=Xd9jMxZpDRFHwQpEyu51emHUSQOV/Y4hRIqNN1v0E1YvljDz4f8g9yMgubC4Vh3GJt
         pt6SSOFs8VMFCSx6qcO1kRUpOtjKkk3auaAa8784kfzLwe+sbckMrO3WVb2+PIDvofwr
         D+zZt6uyjCYWOPLgz70PDWkOBfpB2/2Z+pSOxnn/4GyVkKqrkFWObIyBXcE80WJ1QYQV
         J1EOXsurYgeYEhWA8G8inhFbV/eCEUPvOEVQbVYX7c5vRrgwfsupFElf3RNbk6MGNbBO
         oYTjQ3ISv0UE4Qlzc+K2J15neI8A2xLPLogvir6ChlRidbvc3zwdr/v/vqPTeBYzdt6+
         /LGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZpEdbEUIDGmnmMpZ/TTCm6yurtVjEpXE/FjGd6hHOwQ=;
        b=YTxrV7yEDu6L/OoP4e9gwbj96GO2gwIq4ZRUsv2Z3yUs5OYQL7Ks7QJbifzUSigMUV
         Xpjenj5kEkbAzR2NgkCP9zAfyqRQiHeOBFp8+O2FdgzvwciqIkqqV0uIVy3AsWo23ti6
         lJHbWFwch8FnFGLrGIjupRfk15MXC3TKvrqWAk+b+geRpIzLDjywEeMU6ndYFsNrjN0D
         NDQJCPSOQlqvbyzdZZYyFgLddZ4X+t1DnBh7kpgU6IgDQqIs4xONVaqEi7t+cwNtBBIL
         rIx1Qae3EuJRotU7iPx1QjQ2nATUuxfLTUhy7DX5/aiqJp6fckY4QIHppiWBGBOvN2h6
         EWug==
X-Gm-Message-State: AHPjjUgNtRttIwUiT8/m+9XutVpPwM9KVNiqaKuP+JCNy3nE3hGnhAFv
        GUCg1l93Oe7zDAZaD5/Rcm5wSkmd
X-Google-Smtp-Source: AOwi7QAHIVnBCfHx51T+gAEtjpkuwvcZAcniRLB4pd19mIbuNshlX/xbOIoad9GXa+H2AgJ3HseMxA==
X-Received: by 10.202.177.70 with SMTP id a67mr7717941oif.35.1506312493776;
        Sun, 24 Sep 2017 21:08:13 -0700 (PDT)
Received: from pixel.attlocal.net (75-59-239-78.lightspeed.sntcca.sbcglobal.net. [75.59.239.78])
        by smtp.gmail.com with ESMTPSA id x206sm6514571oig.55.2017.09.24.21.08.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Sep 2017 21:08:13 -0700 (PDT)
From:   Brandon Casey <drafnel@gmail.com>
To:     git@vger.kernel.org
Cc:     Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 3/3] parse-options: only insert newline in help text if needed
Date:   Sun, 24 Sep 2017 21:08:05 -0700
Message-Id: <1506312485-8370-3-git-send-email-drafnel@gmail.com>
X-Mailer: git-send-email 2.2.0.rc3
In-Reply-To: <1506312485-8370-1-git-send-email-drafnel@gmail.com>
References: <1506312485-8370-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, when parse_options() produces a help message it always emits
a blank line after the usage text to separate it from the options text.
If the option spec does not define any switches, or only defines hidden
switches that will not be displayed, then the help text will end up with
two trailing blank lines instead of one.  Let's defer emitting the blank
line between the usage text and the options text until it is clear that
the options section will not be empty.

Fixes t1502.5, t1502.6.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 parse-options.c               | 10 ++++++++--
 t/t1502-rev-parse-parseopt.sh |  4 ++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 6a03a52..fca7159 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -581,6 +581,7 @@ static int usage_with_options_internal(struct parse_opt_ctx_t *ctx,
 				       const struct option *opts, int full, int err)
 {
 	FILE *outfile = err ? stderr : stdout;
+	int need_newline;
 
 	if (!usagestr)
 		return PARSE_OPT_HELP;
@@ -603,8 +604,7 @@ static int usage_with_options_internal(struct parse_opt_ctx_t *ctx,
 		usagestr++;
 	}
 
-	if (opts->type != OPTION_GROUP)
-		fputc('\n', outfile);
+	need_newline = 1;
 
 	for (; opts->type != OPTION_END; opts++) {
 		size_t pos;
@@ -612,6 +612,7 @@ static int usage_with_options_internal(struct parse_opt_ctx_t *ctx,
 
 		if (opts->type == OPTION_GROUP) {
 			fputc('\n', outfile);
+			need_newline = 0;
 			if (*opts->help)
 				fprintf(outfile, "%s\n", _(opts->help));
 			continue;
@@ -619,6 +620,11 @@ static int usage_with_options_internal(struct parse_opt_ctx_t *ctx,
 		if (!full && (opts->flags & PARSE_OPT_HIDDEN))
 			continue;
 
+		if (need_newline) {
+			fputc('\n', outfile);
+			need_newline = 0;
+		}
+
 		pos = fprintf(outfile, "    ");
 		if (opts->short_name) {
 			if (opts->flags & PARSE_OPT_NODASH)
diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt.sh
index ce7dda1..a859abe 100755
--- a/t/t1502-rev-parse-parseopt.sh
+++ b/t/t1502-rev-parse-parseopt.sh
@@ -98,7 +98,7 @@ END_EXPECT
 	test_i18ncmp expect output
 '
 
-test_expect_failure 'test --parseopt help output no switches' '
+test_expect_success 'test --parseopt help output no switches' '
 	sed -e "s/^|//" >expect <<\END_EXPECT &&
 |cat <<\EOF
 |usage: some-command [options] <args>...
@@ -111,7 +111,7 @@ END_EXPECT
 	test_i18ncmp expect output
 '
 
-test_expect_failure 'test --parseopt help output hidden switches' '
+test_expect_success 'test --parseopt help output hidden switches' '
 	sed -e "s/^|//" >expect <<\END_EXPECT &&
 |cat <<\EOF
 |usage: some-command [options] <args>...
-- 
2.2.0.rc3

