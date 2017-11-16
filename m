Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AE50201C8
	for <e@80x24.org>; Thu, 16 Nov 2017 02:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933675AbdKPCBG (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Nov 2017 21:01:06 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:38756 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933636AbdKPCA4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Nov 2017 21:00:56 -0500
Received: by mail-it0-f66.google.com with SMTP id n134so4133737itg.3
        for <git@vger.kernel.org>; Wed, 15 Nov 2017 18:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GqjMnPIBOW9XgxhB/tS/EE6e6lTWH6powvK2IFOmXgw=;
        b=jnKoSS4wgsrnCqI94k9goX2JhQOsk712YJE4zPQbBxkRoYBra1CACpsJ5TiHG1A6KB
         gG62Y+8HbdnJ9irKcTOTHK+bJkOpxYHQgWurNnafQegAqLw9Wabik/lrYkGsHT/gLIEz
         iJ2ShXpqahWOQ3XxEbp92JHTvpPf3AvZKGVKShXNQXr6ofQLLMe+uz5CP7k3BfS7XW9x
         xC5oMSfpIPZn3hUSNhMG7VT2ewsV4AQL3dZeLZDiyDhqAGBBsUI3rm2eApBnK+Q7zSxj
         9mvilOcMkbw+fmiCYKx4cwC0shUSCxloZ5eIEEnf866tNny/opHCOwc+mSyfZw+vHJ8q
         AGmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GqjMnPIBOW9XgxhB/tS/EE6e6lTWH6powvK2IFOmXgw=;
        b=SZDMV/xA7D/5KeObXuBRXpy0OpMg+ceDd+CJ2/XA28Fq9N/MVY9+aBzgLH5aCrSMVI
         hbsgrkn69L6Ixkq8wGi694evb7YiVwXdWfuWEDEyX9W94oWZE/S7imaiLcEbt5/vzsSk
         vQx53W950Zsoaedb1g4ncxdbiHK3Lk6upYfpeB/wbt+FNrZK736tJqW5frrzwGdcNJgy
         negHqkPzddtyAf5oqvrEX273v5b4w3Q5AgTXU2uCA5IDVf1N26/M+qcTcWwfFZVSC4Gj
         s0e0ZL5hmEnWk6uXXzGWHdHnkAFtXDimnC0QRC3p8AoUegzO/JTL7j36CuVzyxpsZEc+
         TXbQ==
X-Gm-Message-State: AJaThX50qV9RK2np99dVSj5HD5fQPz73k/2PKi1MtFku8m4Ka4XDym8G
        8p+cXoj8bXpkWIAYi7D97Zj78dl2gv4=
X-Google-Smtp-Source: AGs4zMaLRGBQPF4YS/kvhPslad8MiWhElkniE1+aXa24fj6YDMqrspW/c9u0o45L6CJAJD/KgFZMTA==
X-Received: by 10.36.214.193 with SMTP id o184mr572951itg.71.1510797655050;
        Wed, 15 Nov 2017 18:00:55 -0800 (PST)
Received: from localhost ([2620:0:100e:422:34c9:3de6:9af7:a340])
        by smtp.gmail.com with ESMTPSA id u188sm197785itb.2.2017.11.15.18.00.54
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 15 Nov 2017 18:00:54 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jonathantanmy@google.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv5 5/7] builtin/describe.c: print debug statements earlier
Date:   Wed, 15 Nov 2017 18:00:37 -0800
Message-Id: <20171116020039.17810-6-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.128.gcadd42da22
In-Reply-To: <20171116020039.17810-1-sbeller@google.com>
References: <20171116020039.17810-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When debugging, print the received argument at the start of the
function instead of in the middle. This ensures that the received
argument is printed in all code paths, and also allows a subsequent
refactoring to not need to move the "arg" parameter.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/describe.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index fd61f463cf..3136efde31 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -293,6 +293,9 @@ static void describe(const char *arg, int last_one)
 	unsigned long seen_commits = 0;
 	unsigned int unannotated_cnt = 0;
 
+	if (debug)
+		fprintf(stderr, _("describe %s\n"), arg);
+
 	if (get_oid(arg, &oid))
 		die(_("Not a valid object name %s"), arg);
 	cmit = lookup_commit_reference(&oid);
@@ -316,7 +319,7 @@ static void describe(const char *arg, int last_one)
 	if (!max_candidates)
 		die(_("no tag exactly matches '%s'"), oid_to_hex(&cmit->object.oid));
 	if (debug)
-		fprintf(stderr, _("searching to describe %s\n"), arg);
+		fprintf(stderr, _("No exact match on refs or tags, searching to describe\n"));
 
 	if (!have_util) {
 		struct hashmap_iter iter;
-- 
2.15.0.128.gcadd42da22

