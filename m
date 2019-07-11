Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0CD81F461
	for <e@80x24.org>; Thu, 11 Jul 2019 18:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbfGKSHR (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 14:07:17 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37399 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728532AbfGKSHR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jul 2019 14:07:17 -0400
Received: by mail-ot1-f65.google.com with SMTP id s20so6781582otp.4
        for <git@vger.kernel.org>; Thu, 11 Jul 2019 11:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dereferenced-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IV1auwxcdZtAwcxkvhE496emdG7y9WCOfhu9LZcvbE0=;
        b=Cf2ib7t7Yyf/dmiL5HxCrEfggGZR2yJlE46AEAN3DuMz7yt11MYkzu3NR504PkOvGf
         VJfC7wjfXDTZsIfZEiUsDRuCJpCNza6SauhQ72SlRyf0Zqm41XuYIEC3ePel/1aw/YQj
         dcHmRTsXcelbDKGHAlCf+xAASzscdmxIde9Tn0Jm7BHmJlF4/hmTSMl/34FZFL9EuTTY
         sfaOBxxpBEBqA9WXTbhMU8uqzwvgKC50psiHbP3trB4TGsuMIFUFscUOoqkLlad3W7Oi
         t4JZgAOgG2VRBuYJo0v+6FkyM+WQqsKvDzCkRlq6OS8/SIuL718pqjsOZzHQiFanT2c9
         lvoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IV1auwxcdZtAwcxkvhE496emdG7y9WCOfhu9LZcvbE0=;
        b=TN/Tri0wku6USYFPnHTz5yPw36Dhn3sFPNiLtPPUBOBMMMiFm8X7eQd8aQvDl0u+7M
         +nFHSSSMBYrS/Hcnu9RmdxLQkaK+AURNwDmdEjYLP6LyRtScLeKkciTiC7iYjRX0VoJM
         oQ7MU67ZpyLu0GKWeEN/YMFQpho3tgaX4KeBk0siVqGJ/yM9KN115byM+rvqRQKNQDXn
         y+iqP0AobySBgU+6oK1sxmrXOrKIgF9mqdB/rhvwqXDHiOIPHhWd6m9KR0y0WpnME6JI
         wpOKmVaWsj5g2E6sxihqG8Ljjjo2957robVm8dq1e65Q6deKMpFa/CupE7zr5QjB3i7K
         4WiQ==
X-Gm-Message-State: APjAAAUXv9YGTcjuXSYVBBTfHAjMqGennsvjcyZ3mxzPbTuJQqdoGNL+
        Zxv0NUpbYICU/prbgw7m2pn53N+g
X-Google-Smtp-Source: APXvYqwPelvsuBUuuhuFWoFtOC+8MJtTZaBGS6hDN2EFAiigedjCtTqpEhKdiWOXtb5fWcYX77C7zA==
X-Received: by 2002:a05:6830:10da:: with SMTP id z26mr4297107oto.348.1562868436549;
        Thu, 11 Jul 2019 11:07:16 -0700 (PDT)
Received: from nanabozho.attlocal.net ([2600:1700:8660:6160:5d50:4f59:ae8:3eb7])
        by smtp.gmail.com with ESMTPSA id 132sm2131545oid.47.2019.07.11.11.07.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 11:07:16 -0700 (PDT)
From:   Ariadne Conill <ariadne@dereferenced.org>
To:     git@vger.kernel.org
Cc:     Ariadne Conill <ariadne@dereferenced.org>
Subject: [PATCH v3 1/3] log: use mailmap by default
Date:   Thu, 11 Jul 2019 13:06:42 -0500
Message-Id: <20190711180644.30417-2-ariadne@dereferenced.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190711180644.30417-1-ariadne@dereferenced.org>
References: <20190711180644.30417-1-ariadne@dereferenced.org>
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

