Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D0C31F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 20:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfKNUrU (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 15:47:20 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38088 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfKNUrT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 15:47:19 -0500
Received: by mail-pg1-f194.google.com with SMTP id 15so4542281pgh.5
        for <git@vger.kernel.org>; Thu, 14 Nov 2019 12:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6hXDklbEa5mUDp9rqN80Udd76QOBA3Gdj3lGqIpnSOI=;
        b=oD2rpXuDCyV6/ALbfrDpvMufg9SnvkjxsC3AALZI2gDD9iElWOvvHM/3vK8T4c/X0O
         L9PW837UVzfMYrWWmm/J4mwTCTAjHA3bXuCJoUPUvNylyGu3MJBT6vAp6fWBFu70nD6o
         QmI2oVxvfIGNB0HQY2Byu9/b24ah8cCk5Di99gu5IS9rtyD6uMdNi+2/DtS43KKm7/Ql
         0qOX7CM1hxnaKkp/0WrMoHA34B0CYa3GW3zdkVsGY/z6p/kz73mSnaluqrSsJi/Zd6b8
         FG/61QLI8QkoMjH02KyDSw5zjRqzW/elFQk1TBqzNnp1Hq2jybU4/bxELIGUs9SrnKgA
         zcRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6hXDklbEa5mUDp9rqN80Udd76QOBA3Gdj3lGqIpnSOI=;
        b=gbxNzLuT02bonE4M2n5pJQIIDypdEARtL9cQQ7cKUcV6oPWjRRP3bxIOyyayZ2+7TR
         z2mlEZXh6Iv3kMNTxNN2OXj3Hg3d2ZNKovx5sGVWdHtZW10lkbnmUuCHctBHJvNcR1R7
         rAu8E6C5kIE4LTtfj04/XSgyB/z8RCDrF6KJ8YYwtOweY1sDEn0W4GvXEPBJQnNfiwvT
         Ft8/6rGuABqdyi3mFkZ4uObc30rZXaDAIekockY0eaLroweZKHKNn/rr/unRoTjw9pc0
         whwYdyIUbvzqrfCfjzgIz73AMzwXAvxs0ksZ3kOL4kUZ7ppGPRB5fy8WfBkMXpGMiLnk
         R7Rg==
X-Gm-Message-State: APjAAAUKdr7nY0ha4k/4GEnr/PwynJPemmSdCwPvlLTN2adm7L1EDll2
        dbLINrpIQ0U4T4IUxlGPS/rQSh/s
X-Google-Smtp-Source: APXvYqy/YNfUv0L0vbddMh47xY4/vh5IAQfb4NkQBvhq+xtdUuztt57FSpB7n/LUVN6or4d4l292yA==
X-Received: by 2002:a63:6581:: with SMTP id z123mr12290650pgb.367.1573764438927;
        Thu, 14 Nov 2019 12:47:18 -0800 (PST)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id p3sm8897262pfb.163.2019.11.14.12.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 12:47:18 -0800 (PST)
Date:   Thu, 14 Nov 2019 12:47:16 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v3 05/10] revision: make get_revision_mark() return const
 pointer
Message-ID: <ca01bfa0858a225d8181da9502aac33bf6ee7b5a.1573764280.git.liu.denton@gmail.com>
References: <cover.1573241590.git.liu.denton@gmail.com>
 <cover.1573764280.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573764280.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

get_revision_mark() used to return a `char *`, even though all of the
strings it was returning were string literals. Make get_revision_mark()
return a `const char *` so that callers won't be tempted to modify the
returned string.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 revision.c | 4 ++--
 revision.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/revision.c b/revision.c
index 0e39b2b8a5..2151b119b7 100644
--- a/revision.c
+++ b/revision.c
@@ -3944,7 +3944,7 @@ struct commit *get_revision(struct rev_info *revs)
 	return c;
 }
 
-char *get_revision_mark(const struct rev_info *revs, const struct commit *commit)
+const char *get_revision_mark(const struct rev_info *revs, const struct commit *commit)
 {
 	if (commit->object.flags & BOUNDARY)
 		return "-";
@@ -3966,7 +3966,7 @@ char *get_revision_mark(const struct rev_info *revs, const struct commit *commit
 
 void put_revision_mark(const struct rev_info *revs, const struct commit *commit)
 {
-	char *mark = get_revision_mark(revs, commit);
+	const char *mark = get_revision_mark(revs, commit);
 	if (!strlen(mark))
 		return;
 	fputs(mark, stdout);
diff --git a/revision.h b/revision.h
index 4134dc6029..addd69410b 100644
--- a/revision.h
+++ b/revision.h
@@ -322,8 +322,8 @@ int handle_revision_arg(const char *arg, struct rev_info *revs,
 void reset_revision_walk(void);
 int prepare_revision_walk(struct rev_info *revs);
 struct commit *get_revision(struct rev_info *revs);
-char *get_revision_mark(const struct rev_info *revs,
-			const struct commit *commit);
+const char *get_revision_mark(const struct rev_info *revs,
+			      const struct commit *commit);
 void put_revision_mark(const struct rev_info *revs,
 		       const struct commit *commit);
 
-- 
2.24.0.346.gee0de6d492

