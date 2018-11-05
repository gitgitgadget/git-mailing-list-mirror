Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F5CF1F453
	for <e@80x24.org>; Mon,  5 Nov 2018 19:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388043AbeKFEmd (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 23:42:33 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43898 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387556AbeKFEmc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 23:42:32 -0500
Received: by mail-lj1-f194.google.com with SMTP id g26-v6so9110647lja.10
        for <git@vger.kernel.org>; Mon, 05 Nov 2018 11:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qCPyQVjgCI7BzIVTX5kUZeVztFrHz7FyNMcuJu6ZSVM=;
        b=dl3NMH9vhCI/NZ3GRPGebeZUQXTe3Qit3Zl2GY7Yy6L+Bt3nqg3po9HNMZRQzcyCel
         J/t0J37QSYNaK+v/oYUtvgyxtGEVhD4Y0cET9JfXijS8Np+RZDKsjRkRRVxWcO91kmxs
         gYitERZWV/IglsBZ0IyS/8zz3R4RDbi3GWCcHztaKnWHGDqMX2tmhbXcu87HA0jUXRb1
         wHLmszI9PKwuuekVN//oMuNqSEcFRJQCIJVgZgR9s7CxfdDNfJ/Y3OJvEbe0viN8gyTs
         U8A+mRCvU0KMBcLz0lXJBeuWVgDBnm55aVc4NrqJ3aXlKvaLPyrregChAzyw3DEiasTM
         BAXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qCPyQVjgCI7BzIVTX5kUZeVztFrHz7FyNMcuJu6ZSVM=;
        b=ogqOjnx4ID+Ke/2663Hmu1aeaZNJkqzhbKq9eE4zGLaWy41Jq1+Gnrsa9yw12Uoq80
         VmEpS4xCk1eaBl+ZWf6siRb0yh/qKyu+MlUZeo+mmK0jdTT/9+Dg1Awde6a1SFdJjCA7
         mwCgpI1ZzyiKFOfjbxs3N2DopJ9mPqu8X1FCQEtk0btszkeX/TOiB8kPM/AaXZXkc2kW
         6WJ4gwVHyHK1NpKFufyyM5ywPLtqyJt8CfNVOy43Sb4a0CaJk3ySpjFwXDgQvAvcYEvh
         gWTdrpZMMUTcm21PU1H+3kcudEWtJS2WGPqKw4aT0wgM49KUYwKGfV75/siH6AU5favv
         w2ig==
X-Gm-Message-State: AGRZ1gKmawvhAikFKdt8OrXRXDGIH4cXvo6b9xtKFZmjM7osfDgIWfiI
        TA2PhGgu80wkQvxNbeCWWBA=
X-Google-Smtp-Source: AJdET5dbWf8WuNwJwza7qHDajEboIyNv4zLyF6MgPKM3qGAl3Uzl4EUA+tpQ+yzljrOP8nAbwcA6gA==
X-Received: by 2002:a2e:5356:: with SMTP id t22-v6mr12582608ljd.26.1541445682808;
        Mon, 05 Nov 2018 11:21:22 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id x5-v6sm3591056lfe.58.2018.11.05.11.21.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 11:21:21 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 13/16] parse-options.c: turn some die() to BUG()
Date:   Mon,  5 Nov 2018 20:20:56 +0100
Message-Id: <20181105192059.20303-14-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1005.gac84295441
In-Reply-To: <20181105192059.20303-1-pclouds@gmail.com>
References: <20181028065157.26727-1-pclouds@gmail.com>
 <20181105192059.20303-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These two strings are clearly not for the user to see. Reduce the
violence in one string while at there.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 parse-options.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 0bf817193d..3f5f985c1e 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -197,7 +197,7 @@ static int get_value(struct parse_opt_ctx_t *p,
 		return 0;
 
 	default:
-		die("should not happen, someone must be hit on the forehead");
+		BUG("opt->type %d should not happen", opt->type);
 	}
 }
 
@@ -424,7 +424,7 @@ void parse_options_start(struct parse_opt_ctx_t *ctx,
 	ctx->flags = flags;
 	if ((flags & PARSE_OPT_KEEP_UNKNOWN) &&
 	    (flags & PARSE_OPT_STOP_AT_NON_OPTION))
-		die("STOP_AT_NON_OPTION and KEEP_UNKNOWN don't go together");
+		BUG("STOP_AT_NON_OPTION and KEEP_UNKNOWN don't go together");
 	parse_options_check(options);
 }
 
-- 
2.19.1.1005.gac84295441

