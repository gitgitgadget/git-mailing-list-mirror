Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC8BC433DF
	for <git@archiver.kernel.org>; Wed, 20 May 2020 19:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0519207D8
	for <git@archiver.kernel.org>; Wed, 20 May 2020 19:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTUoTcfR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgETTw3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 15:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbgETTw2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 15:52:28 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD1DC061A0E
        for <git@vger.kernel.org>; Wed, 20 May 2020 12:52:28 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id m7so1782326plt.5
        for <git@vger.kernel.org>; Wed, 20 May 2020 12:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZGOryCDtKC9DjWbAZgWKiFKu+OOQBqh7vQkp6/Xoje8=;
        b=UTUoTcfRP5lI6wrnWKdWYRZA1aEn9tsbILvMede3eI4owXy1NAskWB6wlvTTfD1Hog
         yJ0/yvQ5pJniOCS1ooIyp2B70Pc/BM8AsIuaEOKuNgemYcgmUkMsjRqoJqPVPVJPO7MA
         5cN3Md97SRKWKYsJXFJjdPdwhlwVeBoyzpFzBpWFaFFCQ0b7RpwAg1oaZbTjyPSjv7kp
         TP7rjC8E2Yg3a9uPwppWJqPLYF6YmmLwe4kBNnT5S9z0IVfzIiDutbG/Biyuj6XL3/rZ
         OF9rATOOwRnmbOdXfV9PpQHeLEZIA4KMPWsuD/aqJHm0IrGWqn/X5f7qokfnwgc6ZfLT
         ciIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZGOryCDtKC9DjWbAZgWKiFKu+OOQBqh7vQkp6/Xoje8=;
        b=MGnOkDfcWXuXzHCO99mCmUyax54AF96e6QrwAUe8JoC3uF1WhPyosFw46OogUAx2k8
         jScntJkp3wT9gO4H287Ec87aQph2/TM8iSYn7IDStISDP2NFAMEnnOoDP9gWtXsjcw05
         VLR8x1d91xJOLQaJwl0yHMpRChN5arCKX83zrLDfqlRIBsG7QCcg/fcyXXe+xY2QFcKI
         3YkgvoxHR6osixgSCzHuS66Uncz7engvFg7VPbt6cURLAqtH9TrrVCdZpU1NCrMOPqk/
         okvYerVVj+bPT+VD2EebAeQirbVbjitk3cUUp3mvjG5UXwb/U40jJ4IlXV2I+wQZ6cXw
         VJ6A==
X-Gm-Message-State: AOAM5335qkBNU3eoe/wMdSY1EAQyVn3Xh+LunCyLw/V8O9wandomO1of
        yTh0J23wm+/KAuYF9I/2BoiRKEmM
X-Google-Smtp-Source: ABdhPJwoIixIlDhWb6UsXCAzwlAQt5Xq8Ow7QECh+LXKDZqCM94+JWVErSn4+hjiO1FxyqqkFTj6oQ==
X-Received: by 2002:a17:90b:ed3:: with SMTP id gz19mr7387089pjb.166.1590004347721;
        Wed, 20 May 2020 12:52:27 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id k5sm2742325pjl.32.2020.05.20.12.52.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 May 2020 12:52:27 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, pranit.bauva@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] bisect--helper: avoid segfault with bad syntax in start --term-.+
Date:   Wed, 20 May 2020 12:52:14 -0700
Message-Id: <20200520195214.62655-1-carenas@gmail.com>
X-Mailer: git-send-email 2.27.0.rc0.187.gede8c892b8
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

06f5608c14 (bisect--helper: `bisect_start` shell function partially in C,
2019-01-02) adds a lax parser for `git bisect start` which could result
in a segfault under a bad syntax call.

Detect if they are enough arguments left in the command line to use for
--term-{old,good,new,bad} and throw the same syntax error the old shell
script will show if not.

While at it, remove and unnecessary (and incomplete) check for unknown
arguments.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 builtin/bisect--helper.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index c1c40b516d..37db7d2afa 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -455,6 +455,8 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
 			no_checkout = 1;
 		} else if (!strcmp(arg, "--term-good") ||
 			 !strcmp(arg, "--term-old")) {
+			if (argc - i <= 1)
+				return error(_("'' is not a valid term"));
 			must_write_terms = 1;
 			free((void *) terms->term_good);
 			terms->term_good = xstrdup(argv[++i]);
@@ -465,6 +467,8 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
 			terms->term_good = xstrdup(arg);
 		} else if (!strcmp(arg, "--term-bad") ||
 			 !strcmp(arg, "--term-new")) {
+			if (argc - i <= 1)
+				return error(_("'' is not a valid term"));
 			must_write_terms = 1;
 			free((void *) terms->term_bad);
 			terms->term_bad = xstrdup(argv[++i]);
@@ -473,8 +477,7 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
 			must_write_terms = 1;
 			free((void *) terms->term_bad);
 			terms->term_bad = xstrdup(arg);
-		} else if (starts_with(arg, "--") &&
-			 !one_of(arg, "--term-good", "--term-bad", NULL)) {
+		} else if (starts_with(arg, "--")) {
 			return error(_("unrecognized option: '%s'"), arg);
 		} else {
 			char *commit_id = xstrfmt("%s^{commit}", arg);
-- 
2.27.0.rc0.187.gede8c892b8

