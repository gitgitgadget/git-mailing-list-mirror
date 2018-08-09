Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B7C11F405
	for <e@80x24.org>; Thu,  9 Aug 2018 06:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbeHII5L (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 04:57:11 -0400
Received: from forward100o.mail.yandex.net ([37.140.190.180]:60823 "EHLO
        forward100o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727563AbeHII5L (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 Aug 2018 04:57:11 -0400
X-Greylist: delayed 642 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Aug 2018 04:57:09 EDT
Received: from mxback7g.mail.yandex.net (mxback7g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:168])
        by forward100o.mail.yandex.net (Yandex) with ESMTP id 495832A20825;
        Thu,  9 Aug 2018 09:23:08 +0300 (MSK)
Received: from smtp2o.mail.yandex.net (smtp2o.mail.yandex.net [2a02:6b8:0:1a2d::26])
        by mxback7g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id tlezCnSiti-N1dSMhuw;
        Thu, 09 Aug 2018 09:23:02 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail; t=1533795782;
        bh=bqW6vhEuyIaIqjaWu5aoomHcyVy24koi+ndCLLBPTQw=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=pcmQ8ZaBYLPCGP+CnZKKXBQjskR9ENBjobUrUjZleNANEFLgodsA9hQMRZbzleyf+
         vDRDcd6eRtYPpqB3x8+Z++P3comzH4C7U348qaaF4/xKhKwSVjH7GK32sOHaO1qExz
         gHJn0vtCkLkB2V7HEsceY5pEajcFzOD6ijowzXZ0=
Received: by smtp2o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id ZN5nw3gID7-N1B4cO3H;
        Thu, 09 Aug 2018 09:23:01 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail; t=1533795781;
        bh=bqW6vhEuyIaIqjaWu5aoomHcyVy24koi+ndCLLBPTQw=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=avULnM0deqnz5CxXv1P926Eyt5lOxscFaRD11iRjmSWYLuJRflf7RyUvuaCD4yCC9
         4yo1XRFx9QwCAZ4Z8ODa/3viltkhV4l+zbxZeRSsJZXfMKv9CF2yJFTKLIAJoWMsTL
         bbHx9NuDpoWvyYTi6/D1CzK+f9kg7vivdwv+VeiQ=
Authentication-Results: smtp2o.mail.yandex.net; dkim=pass header.i=@ya.ru
From:   Nicholas Guriev <guriev-ns@ya.ru>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Nicholas Guriev <guriev-ns@ya.ru>, Git List <git@vger.kernel.org>
Subject: [PATCH v2] status: -i shorthand for --ignored command line option
Date:   Thu,  9 Aug 2018 09:21:42 +0300
Message-Id: <20180809062142.15638-1-guriev-ns@ya.ru>
X-Mailer: git-send-email 2.18.0.548.gee56419
In-Reply-To: <CAPig+cTD7XYbaPBzj36Eudrud80r-cz1CPLDsLA9CHJC6Yc-Qw@mail.gmail.com>
References: <CAPig+cTD7XYbaPBzj36Eudrud80r-cz1CPLDsLA9CHJC6Yc-Qw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It allows for uniformity with the --untracked-files option. Also
the new short flag saves the number of keys to press for the
typically git-status command.

Signed-off-by: Nicholas Guriev <guriev-ns@ya.ru>
---
 Documentation/git-status.txt | 1 +
 builtin/commit.c             | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index d9f422d..cce352a 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -97,6 +97,7 @@ configuration variable documented in linkgit:git-config[1].
 	(and suppresses the output of submodule summaries when the config option
 	`status.submoduleSummary` is set).
 
+-i[<mode>]::
 --ignored[=<mode>]::
 	Show ignored files as well.
 +
diff --git a/builtin/commit.c b/builtin/commit.c
index 158e3f8..44829b9 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1319,7 +1319,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 		  N_("mode"),
 		  N_("show untracked files, optional modes: all, normal, no. (Default: all)"),
 		  PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
-		{ OPTION_STRING, 0, "ignored", &ignored_arg,
+		{ OPTION_STRING, 'i', "ignored", &ignored_arg,
 		  N_("mode"),
 		  N_("show ignored files, optional modes: traditional, matching, no. (Default: traditional)"),
 		  PARSE_OPT_OPTARG, NULL, (intptr_t)"traditional" },
-- 
2.7.4

