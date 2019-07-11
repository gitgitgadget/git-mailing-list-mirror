Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6CC61F461
	for <e@80x24.org>; Thu, 11 Jul 2019 18:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729531AbfGKShg (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 14:37:36 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42972 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729527AbfGKShf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jul 2019 14:37:35 -0400
Received: by mail-ot1-f66.google.com with SMTP id l15so6865231otn.9
        for <git@vger.kernel.org>; Thu, 11 Jul 2019 11:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dereferenced-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IV1auwxcdZtAwcxkvhE496emdG7y9WCOfhu9LZcvbE0=;
        b=Z48qUI0A/yUqSOTffm6Pj1rQKBRWy8yKK15/7H64lJOkEw9V1JhVhF+crH3cSw9h6D
         Zf6PDTr5rjuPth/oklkjjafF5idMWrHA7TsHysSW+aTCe3w7FYuYv9Ks9yGoHHZv1iuL
         Eh1FHEkGDldeoFeWzuqUaau16+IkKvS9HD1ab01qvmPjBL4c9CEW2w1Ag66uHDeDqvd7
         3cwC6iiBOcIO5BW8YiGlmf5g5YL28qpiQvWSHQRlQut/TZdKAlKwHZOE1RptBAoP2yXe
         UxJ6JeF7bg7kz5woh6mkcBmJcopToO3wJH98j3YI7bworKAVWRsBkhzk6bcZNPh6Zm0r
         p/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IV1auwxcdZtAwcxkvhE496emdG7y9WCOfhu9LZcvbE0=;
        b=SV/vbW/UFDqppJ9b4HEylFN5RohT1kWpluhyn56qpe2FAPG3HcRC2TKWFApHbgkYw4
         CWc7fXkZI1CmmGfUXV+6ThOApF9Jydf7hYuccoBGgUlC1fGqRAJFZLkVzVTmfHLZB26J
         srVLoLrYqCMaiCO1JDYUTdpOLJ1NYmCtPpwchZhYu1kaH2SxSGZW1oRTOd37xi4moupw
         WIHBki0vJRv4XoAdOzln59AmJh8Nn4plS+5cTP0jZBn+DJaStpO/rcYGhiJ0DqsXm5XY
         yngC4nirblU931iUBd7+0fUfhNc1StMUMU64F9jaJoUlKp5PZEFES53ZvVxD/V2ylo+M
         ZmAQ==
X-Gm-Message-State: APjAAAXrkMJoWTMeKZFxtx5ceS7p62lZwkCrg3juiCemycJG9XqByiAp
        teE2mw2R0XxJTGDWsxo8T9D6I/ep
X-Google-Smtp-Source: APXvYqxH7ufX1kyG+7S07P+CMz1yOE1/QtJ3Lek7S1RbhAt2M3X6/VlRyP+/nB6rZdQlDP7kSR3oMw==
X-Received: by 2002:a9d:5a16:: with SMTP id v22mr4446515oth.150.1562870254746;
        Thu, 11 Jul 2019 11:37:34 -0700 (PDT)
Received: from nanabozho.attlocal.net ([2600:1700:8660:6160:5d50:4f59:ae8:3eb7])
        by smtp.gmail.com with ESMTPSA id h9sm2016646otl.51.2019.07.11.11.37.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 11:37:34 -0700 (PDT)
From:   Ariadne Conill <ariadne@dereferenced.org>
To:     git@vger.kernel.org
Cc:     Ariadne Conill <ariadne@dereferenced.org>
Subject: [PATCH v4 1/3] log: use mailmap by default
Date:   Thu, 11 Jul 2019 13:37:25 -0500
Message-Id: <20190711183727.8058-2-ariadne@dereferenced.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190711183727.8058-1-ariadne@dereferenced.org>
References: <20190711183727.8058-1-ariadne@dereferenced.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `git log` command shows the author and committer name recorded in
the git repository itself, while other commands respect `.mailmap`
by default.  I believe this is a bad design: it causes log entries to
reflect inaccurate information: anyone who changes their name or
e-mail address will not have that change (recorded in mailmap file)
reflected when using `git log` by default.

Anyone who explicitly wants the current behaviour can clearly request
it by setting the `log.mailmap` setting to `false` in their
`.gitconfig` file.

Signed-off-by: Ariadne Conill <ariadne@dereferenced.org>
---
 builtin/log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index 7c8767d3bc..3d2ce8fa3d 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -47,7 +47,7 @@ static int default_follow;
 static int default_show_signature;
 static int decoration_style;
 static int decoration_given;
-static int use_mailmap_config;
+static int use_mailmap_config = 1;
 static const char *fmt_patch_subject_prefix = "PATCH";
 static const char *fmt_pretty;
 
-- 
2.17.1

