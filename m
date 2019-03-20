Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF66920248
	for <e@80x24.org>; Wed, 20 Mar 2019 11:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbfCTLsd (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 07:48:33 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35543 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727921AbfCTLsd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 07:48:33 -0400
Received: by mail-pf1-f193.google.com with SMTP id t21so1012850pfe.2
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 04:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9BmWPilqglEsaEmy0glCNo+Q/095fnq1EKmnSUkEezQ=;
        b=EQ3e0T+upeCTLlubTlKdgyYJaOPEivUSJEhHX8ZCHXKFkdl8l6WG1kTOf2p5Bzbsl3
         kchm27ZPD6DuWgmVmJvNKfFTPJXjStpwIHfnPTLqdCKZpEP19pVyvQFszgeODAfDU5rh
         rGUJsmcZdnYFa4t1uVhJeNoD3+gDzc5a73gqy271FG8uTFhqWljs/1CJ/fMAphzsROQN
         pxAjqQYZA9j4TT72dSz/qGNagJxYFVae/nUrS/rxjsWfzWaPDYXAwa2cmY6vCJNu7CCm
         pknwcAWatjlbhRdE4VjevRkAsz7RNeqjwxQ2Nn6Ppg3ThoQcGKNSmCZPWXW/tua4ZTP2
         1LjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9BmWPilqglEsaEmy0glCNo+Q/095fnq1EKmnSUkEezQ=;
        b=A6z6xitaDjAIvW9znWGcSYXDokR9pfa46zJlwVsh1QUzJmWVfbBKwVlE761cFddL5n
         DMNUKNFej+VpfDg4OYz2rRfEAoyeomhfCzoG/CtHk2Nbz/C91znq7E5jFCSu6+hMoGds
         fjyprVi1iMwm458FOL/FvUWqjVkBxJUxtWgQYsU/An9yOaLeXgmklN/Sv0F0hPus9/Q1
         OsFr/JfZ/5x8uAWqH9wRXFKN41ylUfBOOOJa6saKXzwsnvH6uO+xrbcvv/U4Cu4t6sC+
         zUfTCmx/9XXQHDqkUp5wxE5FABlMZ4L/DYgybdXgJYgaJHJo6x8IuX84HwmuG5nquzlA
         NgcA==
X-Gm-Message-State: APjAAAU0hFHfJUStfN9ma3L7N3Mb2ZwVTP4lpd4dGWkXRdeD9n1neot3
        iwHKNi/INNjJeEP4ML77Bd+KvjiV
X-Google-Smtp-Source: APXvYqyQYyberRPszOEQbsvJJ6NkjJieepWhqa+wLe3NjcBB3mF3yyKCWIjwKDQLk94sIj6uxhkysA==
X-Received: by 2002:aa7:82d9:: with SMTP id f25mr7604008pfn.45.1553082512611;
        Wed, 20 Mar 2019 04:48:32 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id o7sm6060742pfi.105.2019.03.20.04.48.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 04:48:31 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 20 Mar 2019 18:48:28 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 17/20] diff.c: allow --no-color-moved-ws
Date:   Wed, 20 Mar 2019 18:47:00 +0700
Message-Id: <20190320114703.18659-18-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.548.gd3c7d92dc2
In-Reply-To: <20190320114703.18659-1-pclouds@gmail.com>
References: <20190320114703.18659-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This option is added in commit b73bcbac4a (diff: allow
--no-color-moved-ws - 2018-11-23) in pw/diff-color-moved-ws-fix. To ease
merge conflict resolution, re-implement the option handling here so that
the conflict could be resolved by taking this side of change.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 8f79d3f002..6ce59d0621 100644
--- a/diff.c
+++ b/diff.c
@@ -4868,7 +4868,11 @@ static int diff_opt_color_moved_ws(const struct option *opt,
 	struct diff_options *options = opt->value;
 	unsigned cm;
 
-	BUG_ON_OPT_NEG(unset);
+	if (unset) {
+		options->color_moved_ws_handling = 0;
+		return 0;
+	}
+
 	cm = parse_color_moved_ws(arg);
 	if (cm & COLOR_MOVED_WS_ERROR)
 		return error(_("invalid mode '%s' in --color-moved-ws"), arg);
@@ -5379,7 +5383,7 @@ static void prep_parse_options(struct diff_options *options)
 			       PARSE_OPT_OPTARG, diff_opt_color_moved),
 		OPT_CALLBACK_F(0, "color-moved-ws", options, N_("<mode>"),
 			       N_("how white spaces are ignored in --color-moved"),
-			       PARSE_OPT_NONEG, diff_opt_color_moved_ws),
+			       0, diff_opt_color_moved_ws),
 
 		OPT_GROUP(N_("Diff other options")),
 		OPT_CALLBACK_F(0, "relative", options, N_("<prefix>"),
-- 
2.21.0.548.gd3c7d92dc2

