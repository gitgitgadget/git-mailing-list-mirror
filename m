Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EC4C35254
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 13:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0782421927
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 13:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="Xbecomv+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbgBENHZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 08:07:25 -0500
Received: from a7-10.smtp-out.eu-west-1.amazonses.com ([54.240.7.10]:52148
        "EHLO a7-10.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726386AbgBENHZ (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 5 Feb 2020 08:07:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1580908043;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=+d1Fqosg7oaG/bF1JxCkLUwn6ymqKuEOoYwZLexL+kE=;
        b=Xbecomv+VafV6fUsWtWUlE/0mkmQtIvsxBzH5jutJyQP9uG/UMis7PY1rTT270dw
        lwMk1Fil1adE58fKCwNzLNRzVocoSsBGoXiz7Gj1onIT7pXA11BbVVID2eSoHOaJ0yz
        9PjLg+H/ZGrahW/m+u9V1SKGdxm8lwDPJCkxGA3o=
From:   Jacques Bodin-Hullin <j.bodinhullin@monsieurbiz.com>
To:     git@vger.kernel.org
Message-ID: <0102017015765b98-e2e26f61-dd07-4a32-a72f-2d7b2159fffe-000000@eu-west-1.amazonses.com>
In-Reply-To: <010201671ebf523a-da55f2d8-876a-4b3b-a6fe-29d790bed2c1-000000@eu-west-1.amazonses.com>
References: <010201671ebf523a-da55f2d8-876a-4b3b-a6fe-29d790bed2c1-000000@eu-west-1.amazonses.com>
Subject: [PATCH] parse-options: lose an unnecessary space in an error
 message
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Wed, 5 Feb 2020 13:07:23 +0000
X-SES-Outgoing: 2020.02.05-54.240.7.10
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jacques Bodin-Hullin <j.bodinhullin@monsieurbiz.com>
---
 parse-options.c          | 4 ++--
 t/t0040-parse-options.sh | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index b42f54d48b96c..71dbe84d896b4 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -420,7 +420,7 @@ static void check_typos(const char *arg, const struct option *options)
 		return;
 
 	if (starts_with(arg, "no-")) {
-		error(_("did you mean `--%s` (with two dashes ?)"), arg);
+		error(_("did you mean `--%s` (with two dashes)?"), arg);
 		exit(129);
 	}
 
@@ -428,7 +428,7 @@ static void check_typos(const char *arg, const struct option *options)
 		if (!options->long_name)
 			continue;
 		if (starts_with(options->long_name, arg)) {
-			error(_("did you mean `--%s` (with two dashes ?)"), arg);
+			error(_("did you mean `--%s` (with two dashes)?"), arg);
 			exit(129);
 		}
 	}
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 705a136ed92c9..9d7c7fdaa2af1 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -242,7 +242,7 @@ test_expect_success 'Alias options do not contribute to abbreviation' '
 '
 
 cat >typo.err <<\EOF
-error: did you mean `--boolean` (with two dashes ?)
+error: did you mean `--boolean` (with two dashes)?
 EOF
 
 test_expect_success 'detect possible typos' '
@@ -252,7 +252,7 @@ test_expect_success 'detect possible typos' '
 '
 
 cat >typo.err <<\EOF
-error: did you mean `--ambiguous` (with two dashes ?)
+error: did you mean `--ambiguous` (with two dashes)?
 EOF
 
 test_expect_success 'detect possible typos' '

--
https://github.com/git/git/pull/540
