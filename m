Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52578C54FD0
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 06:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26391206B9
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 06:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nysryF/B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgD0Goc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 02:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbgD0Gob (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Apr 2020 02:44:31 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B13C061A0F
        for <git@vger.kernel.org>; Sun, 26 Apr 2020 23:44:31 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id h6so8003344qvz.8
        for <git@vger.kernel.org>; Sun, 26 Apr 2020 23:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SROFubzfP+IrneZTncIhYVmyQ7iWaWYPpc20amnZCKk=;
        b=nysryF/BswWNArIOIbSXuL5D/4fiP6BroF4rZRU5iCV42OdlStEvp1JNIcNp0Gy9xt
         3Xjta1pNfpOkQqQJZ3qyJIYf95o+x5jd3TgoEYp/a/nNUSSquVkoct/hhwIZh5pV40X+
         /oviUVQypk6EUjuUKbkJHYsmmjg/39je9irfCHjFLX+BqmyGxjRF/sFqZ8oB929G/XhS
         1wos8iADykwfYnNvi7FeAYEixBhjtYcBv/Uyi3XL/hbApjavihe+5rcHBKHzOJHbsAPz
         ttQOK9vmWkWsGXPP1waXU3OjHfw/ooOEvysztKtM+bbKzc1s3cKRBkTH3baYO5gnJ7Vs
         nmSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SROFubzfP+IrneZTncIhYVmyQ7iWaWYPpc20amnZCKk=;
        b=i7MvqrbZKa3EAuxxR0POvaIphGeeaO4Sj6utIvMuXrIbs5WsLgkygSTGpQGWXVwgY3
         nWydzq/Pgb5XMKW+YcGdHdEPWScTEJj1QX2I26sZ+JG8ru8pXV4FJGatjNShBZn4Fh6n
         FNEZ1KolvVBOMAvSskHPbtR8BrWikL/qVL0kMleY0vuhvq12Z3gvGnVIWA4CYlkpbIIM
         LmeeFWt/iO7HeSIQ32Hy9sIo1WnXT/uU4KKkHv319k0I03L5USGvUHNPdrvJu7m0407a
         aXp5F8xawkZI/LRx38pKHOq8/qjfCWd3sZUOuHHVw8XfHqvYJR7pJTW4MKKh8sdtBD+R
         PzDQ==
X-Gm-Message-State: AGi0PubBzVCFJmJ1UJ8oiTG/0gXoJWm0tGF89BuG0KUIaobypeP6KZmf
        UE9gw6aoXdK6uklS443EaFd3oqW5
X-Google-Smtp-Source: APiQypJJaR8B/KrDgo4EjQIv0Wi82mquxwRVlc8n1QNUiXbwvL2Mpj9DRt9CMInB9yPQkR1oZTv8nw==
X-Received: by 2002:a0c:efc8:: with SMTP id a8mr20089368qvt.153.1587969870475;
        Sun, 26 Apr 2020 23:44:30 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id x5sm9589027qtm.81.2020.04.26.23.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 23:44:29 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Andrew White <andrew.white@audinate.com>
Subject: [PATCH] push: unset PARSE_OPT_OPTARG for --recurse-submodules
Date:   Mon, 27 Apr 2020 02:44:08 -0400
Message-Id: <c2b92691ca85029fde3bd6969252cc827ca697b5.1587969824.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
In-Reply-To: <346FFB0C-7419-4E2D-B593-9F64F9403D11@audinatedante.onmicrosoft.com>
References: <346FFB0C-7419-4E2D-B593-9F64F9403D11@audinatedante.onmicrosoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the usage for `git push` is shown, it includes the following
lines

	--recurse-submodules[=(check|on-demand|no)]
			      control recursive pushing of submodules

which seem to indicate that the argument for --recurse-submodules is
optional. However, we cannot actually run that optiion without an
argument:

	$ git push --recurse-submodules
	fatal: recurse-submodules missing parameter

Unset PARSE_OPT_OPTARG so that it is clear that this option requires an
argument. Since the parse-options machinery guarantees that an argument
is present now, assume that `arg` is set in the else of
option_parse_recurse_submodules().

Reported-by: Andrew White <andrew.white@audinate.com>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/push.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 6dbf0f0bb7..90f071fcf2 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -434,10 +434,8 @@ static int option_parse_recurse_submodules(const struct option *opt,
 
 	if (unset)
 		*recurse_submodules = RECURSE_SUBMODULES_OFF;
-	else if (arg)
-		*recurse_submodules = parse_push_recurse_submodules_arg(opt->long_name, arg);
 	else
-		die("%s missing parameter", opt->long_name);
+		*recurse_submodules = parse_push_recurse_submodules_arg(opt->long_name, arg);
 
 	return 0;
 }
@@ -554,7 +552,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		  PARSE_OPT_OPTARG | PARSE_OPT_LITERAL_ARGHELP, parseopt_push_cas_option },
 		{ OPTION_CALLBACK, 0, "recurse-submodules", &recurse_submodules, "(check|on-demand|no)",
 			N_("control recursive pushing of submodules"),
-			PARSE_OPT_OPTARG, option_parse_recurse_submodules },
+			0, option_parse_recurse_submodules },
 		OPT_BOOL_F( 0 , "thin", &thin, N_("use thin pack"), PARSE_OPT_NOCOMPLETE),
 		OPT_STRING( 0 , "receive-pack", &receivepack, "receive-pack", N_("receive pack program")),
 		OPT_STRING( 0 , "exec", &receivepack, "receive-pack", N_("receive pack program")),
-- 
2.26.0.159.g23e2136ad0

