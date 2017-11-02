Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 330F920281
	for <e@80x24.org>; Thu,  2 Nov 2017 19:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964811AbdKBTmH (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 15:42:07 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:44776 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934345AbdKBTmE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 15:42:04 -0400
Received: by mail-io0-f195.google.com with SMTP id m16so1531763iod.1
        for <git@vger.kernel.org>; Thu, 02 Nov 2017 12:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JnGCRS9/VGHg/YX8SkKVrSHPQmT/ljyU3D4Fp66rPd0=;
        b=U8DQzCjO/hMpUXAoeyX2KIDoftxP6P2UnV2zsGoUJ7+KyAn0LO6Psr6jSmBhC01+2j
         O2p1fk67YOGGMCI5dltwj9tMMAm3oJilaPM/dRnGrK+iBzh89oYx5y/mOBT6C7SIB1y7
         7mQ2Vb5KrdoBImh7C/mPZgee2zL692zO+Ofd9wiQAPfSH0fT3LbqDm/Sg5/WPeuAIyBU
         a3mfsutrHjqgnIWaReKMVWWs1YkFS9iuGtaRJPpj/buk4FaJos2IUYzeujpl9iUpgLzB
         ts6AavUrA0eQ5vzZUFgDc3UdIZCXeB2A7c/iRxbs0ITO+QKB/zSs8qti7Ib7qBwjC733
         aknA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JnGCRS9/VGHg/YX8SkKVrSHPQmT/ljyU3D4Fp66rPd0=;
        b=WmQf5tmphbJ7uyZF0G0njD1uK/aZS69J/rwX/fZQ8nq8RHgV4nB23uht4qVgx4L38E
         yMGgd5htXy6YlVksAFNXDkZ88wDx8vyk174m5340c4EkrovZv0fJdnllu8e6s1AmuVAr
         Y8OrDrUyqz/mapAIDrheHTkTvRs/gJgy71gLTVVXzghvHyao7LOFVGBHRof0iisP+U1J
         EpoaAAT19c17vmQfKzzBasghsUQN0NmBgvesfUVquB6lc1AgIOqVPILSnqAflrK7amTf
         /P30nZCSb5mYFJpcdRRWcDMGiMybuA0bq9zs12Q3B92bkt1dvWTuTwd1SM1rxWRqoRE+
         VRzw==
X-Gm-Message-State: AMCzsaUwY+uCxD77ZTCCp6f2GFZkuGnNha+ttdJdKvs7wE4T27gbbru0
        inYp8QP9L10X7wWKi/lDjtfHDBL+tXI=
X-Google-Smtp-Source: ABhQp+S+CA83r+kJ8ixSqWXJHsGn4aDg63b/OZ+TKvQOhmS7u0QQWPWts8ES6ZlO5twYVcZtg8o4VQ==
X-Received: by 10.36.57.76 with SMTP id l73mr4074400ita.17.1509651723599;
        Thu, 02 Nov 2017 12:42:03 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:1093:e9fc:3ec5:201d])
        by smtp.gmail.com with ESMTPSA id 129sm202749itx.11.2017.11.02.12.42.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 02 Nov 2017 12:42:03 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        jacob.keller@gmail.com, me@ikke.info, schwab@linux-m68k.org
Subject: [PATCHv3 5/7] builtin/describe.c: print debug statements earlier
Date:   Thu,  2 Nov 2017 12:41:46 -0700
Message-Id: <20171102194148.2124-6-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.7.g980e40477f
In-Reply-To: <20171102194148.2124-1-sbeller@google.com>
References: <20171031211852.13001-1-sbeller@google.com>
 <20171102194148.2124-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For debuggers aid we'd want to print debug statements early, so
introduce a new line in the debug output that describes the whole
function, and then change the next debug output to describe why we
need to search. Conveniently drop the arg from the second line;
which will be useful in a follow up commit, that refactors the\
describe function.

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
2.15.0.7.g980e40477f

