Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 322B81F461
	for <e@80x24.org>; Thu, 11 Jul 2019 17:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbfGKR0n (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 13:26:43 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43692 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbfGKR0n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jul 2019 13:26:43 -0400
Received: by mail-ot1-f66.google.com with SMTP id h59so2757752otb.10
        for <git@vger.kernel.org>; Thu, 11 Jul 2019 10:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dereferenced-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IV1auwxcdZtAwcxkvhE496emdG7y9WCOfhu9LZcvbE0=;
        b=tphZoG0Bock3tRXUyy/Te45m0qG/5O6yLWfLLzIAbrt7nnTH6bZaxfUKyUDynrpq77
         Fu/30IzJbEqYQT/Vw+Fzsz4Re20TUqGH75dHaG/LcNUoZWmjaakHu9choFu/M6p3IwLN
         +zZ0/Nzqjs4QSXW+8gVRXKIPeY9Q07n8hsrKHrBWFgticBMxpVl0FCJS0L++dMLKjdFq
         XeL8QI74bsQ9kFI5w85fPDaDYkYabw13hQQKNtzfGA5QfOXHPfghjnU0rFDMndChTrId
         p7vyLeklOyTYvZuamArj1mTdfAkiRhUKg9BXa8SOe6qF7i7F5gaVMWH1DZWdn++bl8U8
         YRgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IV1auwxcdZtAwcxkvhE496emdG7y9WCOfhu9LZcvbE0=;
        b=sqff4XYeN4To1OnydTgtbsAfgtk0PPD3HLXAQl4O2if/H51c710elpeCru3c3P1Pkf
         sGqrvG2P+vTHkEp1kcwcCz1CXZTfUx/+pdK53wso7qQjJFN1AvRTKuwYATcf0l4n6FE+
         e/SuSO0FvjqIKdw/yln1ZXnz29TlvOlhYpuU5d/CTOVHH7c0VWQs3o3y9Rss6Ry5Tzq9
         hJXbfX7kjEZwAXPbqxDx8+1Jvx04YqvR7eQHeFlCs74b0aVd11nnwNDKXwh65bq1j3ol
         xpOjSUb/xtXqq1lircNdkUJWHIX+/Qq9Vo3ZB2Qbp4Ulrobz2IwlwWojPTMeLg9FeSWW
         72Rg==
X-Gm-Message-State: APjAAAUXJJkyKwZy+ZqShDsHwlOjsPk9XTVJRgnks1Ca3H4xfIiMlbur
        uvs6yguFoO1EZG1C/nLdvzbcd9Ra
X-Google-Smtp-Source: APXvYqxcjY+HZVVskegtN8XPnTqZ8cqTs65/PqVBFr6XrYXhy5Dr/5XyyaYFv7HTH+poVbufkRflQw==
X-Received: by 2002:a9d:12af:: with SMTP id g44mr4130626otg.96.1562866002348;
        Thu, 11 Jul 2019 10:26:42 -0700 (PDT)
Received: from nanabozho.attlocal.net ([2600:1700:8660:6160:5d50:4f59:ae8:3eb7])
        by smtp.gmail.com with ESMTPSA id h11sm2045933otj.76.2019.07.11.10.26.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 10:26:41 -0700 (PDT)
From:   Ariadne Conill <ariadne@dereferenced.org>
To:     git@vger.kernel.org
Cc:     Ariadne Conill <ariadne@dereferenced.org>
Subject: [PATCH v2 1/3] log: use mailmap by default
Date:   Thu, 11 Jul 2019 12:26:24 -0500
Message-Id: <20190711172626.16480-2-ariadne@dereferenced.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190711172626.16480-1-ariadne@dereferenced.org>
References: <20190711172626.16480-1-ariadne@dereferenced.org>
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

