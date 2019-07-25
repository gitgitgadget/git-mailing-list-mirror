Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D31221F462
	for <e@80x24.org>; Thu, 25 Jul 2019 17:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403846AbfGYRqg (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 13:46:36 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40503 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403832AbfGYRqe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 13:46:34 -0400
Received: by mail-pf1-f194.google.com with SMTP id p184so23110108pfp.7
        for <git@vger.kernel.org>; Thu, 25 Jul 2019 10:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n8cZdtSDWKIM72XTg9GUk6+oDnW3joDbDhXUaKQCDz0=;
        b=nJNRJkYA87ZZQEa7V+HiYrFY6Vn9ErHLUt9MGMzDDe0NhovbekvxGmPnlu+MgaXLjn
         j6CLJeRSIl78NyZ3w8o1+7ctevtxsDebjVxE8Pn0EwY9HXubd2WtWCMT8PbeWfeXjvcY
         WiAr3pjzJxh9Def57ZN6GTh6TWOEgf+Vjtxv6RJNu1XZg+yVFZ3OA9yyY6gH4o8zG6ZR
         SkmpCWwAS80I8u3cPjgzvIZ19O/1FWKful+jvGgobR8rk7sK1ySRKDFBhMUAm8XTyrk7
         9E7WXAUSmac2Mty7EVyFrH30lK/Wx5dxeapKDtXHmaTpN2a7axirv7qSqIvgAwiof5tT
         RrOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n8cZdtSDWKIM72XTg9GUk6+oDnW3joDbDhXUaKQCDz0=;
        b=NpnXmm1UCP0U6XJZC+Vp028hTEYO2OPvqXR5qe5IVzxhe3z+f8mVu0MXGY/SkdV9ZF
         HbSOxJS6f3S1xSk0AcNblWMglRDa5+93pqE64kB1pX7JRaBWk1RD8RHwXT0bLxIQH7xC
         pYNJKdmH5Kpium4TTPJy8+FI8nmBYf2pHfnOqXp/5y3eVNEwzGRhKjuocBEWY2LOHdh7
         3dmuBGbJXQx/76GIm6Zo+xs6PfdVxWLJlbvhXww29WKuLmv+AblTjyhZn+0DwPF8YrT4
         xDQaxzKTstLjlqxDLHRQBa25/hJGf7DlXOKC8Qfno+2DorMpGCGAhe+90vCyVYIWovGL
         WiHA==
X-Gm-Message-State: APjAAAWKTEBFiXQxqZ+iDnsCSxnD0Z2yOde1rSHEu06h78rse2YKRyQd
        lmTNBI3pT09c4wwJ6oNxUZa+F6X+
X-Google-Smtp-Source: APXvYqz5EYmEezGmdgj7bt0UQQOZZz8BZwR/RwsFLy6aqT69QfGRuXfWxWGlybqBsGSInOP6TXolBw==
X-Received: by 2002:a63:4f51:: with SMTP id p17mr65671326pgl.333.1564076793339;
        Thu, 25 Jul 2019 10:46:33 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id v138sm58171800pfc.15.2019.07.25.10.46.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jul 2019 10:46:32 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH 18/19] merge-recursive: be consistent with assert
Date:   Thu, 25 Jul 2019 10:46:10 -0700
Message-Id: <20190725174611.14802-19-newren@gmail.com>
X-Mailer: git-send-email 2.22.0.559.g28a8880890.dirty
In-Reply-To: <20190725174611.14802-1-newren@gmail.com>
References: <20190725174611.14802-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In commit 8daec1df03de ("merge-recursive: switch from (oid,mode) pairs
to a diff_filespec", 2019-04-05), an assertion on a->path && b->path
was added for code readability to document that these both needed to be
non-NULL at this point in the code.  However, the subsequent lines also
read o->path, so it should be included in the assert.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 0f689095d9..4cd6599296 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1058,7 +1058,7 @@ static int merge_3way(struct merge_options *opt,
 		}
 	}
 
-	assert(a->path && b->path);
+	assert(a->path && b->path && o->path);
 	if (strcmp(a->path, b->path) ||
 	    (opt->ancestor != NULL && strcmp(a->path, o->path) != 0)) {
 		base_name = opt->ancestor == NULL ? NULL :
-- 
2.22.0.559.g28a8880890.dirty

