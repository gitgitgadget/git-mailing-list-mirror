Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3563C433EF
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 01:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D8DE60F48
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 01:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbhJXBxb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Oct 2021 21:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbhJXBx3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Oct 2021 21:53:29 -0400
X-Greylist: delayed 477 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 23 Oct 2021 18:51:09 PDT
Received: from mail.archlinux.org (mail.archlinux.org [IPv6:2a01:4f9:c010:3052::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58AFFC061764
        for <git@vger.kernel.org>; Sat, 23 Oct 2021 18:51:07 -0700 (PDT)
From:   Eli Schwartz <eschwartz@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-rsa; t=1635039787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lPGLKZsQwrMnmPymYt5VqYX/5Jxz0RfNCkZHHuTf7Yc=;
        b=BbJlsLuPSKDlAth7qFq/1cqjjD1/ku68BelWvT9OLIAFCrcsvasaCm9EfZG3YWS+ooOgCH
        kFd05qwMLZENQ+cI/rwogzBJhQNU4me9ESnHlUlQcTBc6eBQxZAfHGZgSnOgboNShWaAS6
        r+g4Vn3tPz4+GFLVRAKojiWP/6cNlBqSIVCejh2HM2YKJsWRygRon33CkFb4AZUhU2X36C
        6cFpRBqFEM78fBOkLnESU5AFdKs1xXewJmB9izqPjvaMILYavRS0mdocO0eDibDVcpWvah
        LwG9Bv5pjpM28bYdnD0sLxcn//HO1BDc0Duk1mmxdWgzyCeSdGY0kNK0eh+hRA187IUTbq
        tT/Vc7p3ZJ+wNTvciTwpUkPEhfqeF5PR5pdEbsjUxU9X5b1DN0kYTZ+L3ctI2isfsLus6Z
        cB3hAr1/7mN1+wpfg+r0DoWSG3uzLKiYrGPW/j/z9eJ7qiq9YiKcQWQ4lbY3ZvM35LJ0JX
        I4ZygmVVs/qpZoI8iKKNS8aaiFQ1tuEdtSi09ERo2On/b20j8EsQjmFi5rcZf3BUkenDY9
        fi/Cd6QhWdVQesQpjwWHlU0RmvIuAAwqCNBhxSBGkmcjPU2gzUnZiz7NrFciru8E7k8uk4
        xtmwyCTkyAejveEUyr6hT4JI30n43vtgpchD3p+9l0cZo6bEXbLyM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-ed25519; t=1635039787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lPGLKZsQwrMnmPymYt5VqYX/5Jxz0RfNCkZHHuTf7Yc=;
        b=O+2xtgl9Xhi5DbopJdjjwc6S/UkodudFysiTo/aTaFKogCDlzlS1jGvCQPu1uGO9gpPVRG
        43KgbLvDLKHPr4Cw==
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Subject: [PATCH 1/3] pretty.c: rename describe options variable to more descriptive name
Date:   Sat, 23 Oct 2021 21:42:54 -0400
Message-Id: <20211024014256.3569322-2-eschwartz@archlinux.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211024014256.3569322-1-eschwartz@archlinux.org>
References: <20211024014256.3569322-1-eschwartz@archlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: mail.archlinux.org;
        auth=pass smtp.auth=eschwartz smtp.mailfrom=eschwartz@archlinux.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It contains option arguments, not options. We would like to add option
support here too.

Signed-off-by: Eli Schwartz <eschwartz@archlinux.org>
---
 pretty.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/pretty.c b/pretty.c
index 73b5ead509..9db2c65538 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1216,7 +1216,7 @@ int format_set_trailers_options(struct process_trailer_options *opts,
 
 static size_t parse_describe_args(const char *start, struct strvec *args)
 {
-	const char *options[] = { "match", "exclude" };
+	const char *option_arguments[] = { "match", "exclude" };
 	const char *arg = start;
 
 	for (;;) {
@@ -1225,10 +1225,10 @@ static size_t parse_describe_args(const char *start, struct strvec *args)
 		size_t arglen = 0;
 		int i;
 
-		for (i = 0; i < ARRAY_SIZE(options); i++) {
-			if (match_placeholder_arg_value(arg, options[i], &arg,
+		for (i = 0; i < ARRAY_SIZE(option_arguments); i++) {
+			if (match_placeholder_arg_value(arg, option_arguments[i], &arg,
 							&argval, &arglen)) {
-				matched = options[i];
+				matched = option_arguments[i];
 				break;
 			}
 		}
-- 
2.33.1

