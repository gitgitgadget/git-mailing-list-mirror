Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0D5C2BBCF
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEC3823A1D
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730757AbgLHWFD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 17:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730747AbgLHWFC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 17:05:02 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D16C061794
        for <git@vger.kernel.org>; Tue,  8 Dec 2020 14:04:16 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id t63so1832272ooa.1
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 14:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cEQOsB+BOx66j/LFEO/fQE8ubCTEUkji902LrnsMttQ=;
        b=GN5h+hcIA9Wz1YOLpd5u2dqsHWTNabt7S+resS4QChqkx/oG6/w6J8cxqr0FmMEM4h
         9Bhqg20goj0jJDUSGGRyu690y1ycrGzPAcjhfr3QLGcdbkgJlBftEPwanTYzW7+BnElA
         gFf6GC7A+YhkZ0WAx+Q5ucGLbNC9YYRSEP+Xc1p+HzfahHcqLwdsPh9rwegZltPw4hLz
         6hT6cpIB0pDW5WcFvFr7vhXUKYV/qavoN6tzYW9UqHeOcSoHxIcJH1LfZ+Sa93kcemJ7
         8zz4n+jcJnL7IMctqQP63qpWrwu0cyr1VIRO0ikoKA1V6DlWxnmm3UPzhhQtTQ162mNW
         m+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cEQOsB+BOx66j/LFEO/fQE8ubCTEUkji902LrnsMttQ=;
        b=rVDjDBwuXN4yOUqTvcXuTgYcljVfvNhkTZUI62z++0P+5ypn/ffM4NxxLMNLcOFk3g
         /iHF+Rxnm21YSoL6dU0H1WzWt9EgIFKyuA4g1jYYsaYX60U77EHD3e+fEgD9g/cdj5mV
         iH3uLw+4WOJ+FrEMkYu/oH7kGuEbVOrGKnyNmGnkiDpuV11a2rOudNnqhi61rUrZjffS
         KAfj5cXikX9fnFnlMi7GrTmeG5L9RbszXI60OlkKBFBAi5MDEeiRH2knTvwDccDqW4EO
         iIpbSZWvQz4MdYiz4kLR2fk8qiyzHpSz1WGKHAquG41ecSTVfoiXMCqLKYXDWPBAinlV
         mDNA==
X-Gm-Message-State: AOAM533NvhXj/368u0jpqFVij49VY1Yr5id/k2tc4P0vL9madSsxsrxX
        fK2eA4L0z5mkQvkkK2IsZSJrrnBe/Xt+9Mj5
X-Google-Smtp-Source: ABdhPJwIinURTFyIlhL7nxcsu/sJHHBHF72YQxlNNXtFMu9NA3fg8WRuHPOIN5mN8+XO3E03ZA/k3A==
X-Received: by 2002:a4a:b4c4:: with SMTP id g4mr58776ooo.7.1607465055786;
        Tue, 08 Dec 2020 14:04:15 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id q18sm59918ood.35.2020.12.08.14.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 14:04:15 -0800 (PST)
Date:   Tue, 8 Dec 2020 17:04:13 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jonathantanmy@google.com, dstolee@microsoft.com,
        gitster@pobox.com
Subject: [PATCH v4 14/24] commit: implement commit_list_contains()
Message-ID: <033fb2ed55fcab150bc019c4d6b6749ab59e3274.1607464775.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
 <cover.1607464775.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1607464775.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

It can be helpful to check if a commit_list contains a commit. Use
pointer equality, assuming lookup_commit() was used.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit.c | 11 +++++++++++
 commit.h |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/commit.c b/commit.c
index fe1fa3dc41..9a785bf906 100644
--- a/commit.c
+++ b/commit.c
@@ -544,6 +544,17 @@ struct commit_list *commit_list_insert(struct commit *item, struct commit_list *
 	return new_list;
 }
 
+int commit_list_contains(struct commit *item, struct commit_list *list)
+{
+	while (list) {
+		if (list->item == item)
+			return 1;
+		list = list->next;
+	}
+
+	return 0;
+}
+
 unsigned commit_list_count(const struct commit_list *l)
 {
 	unsigned c = 0;
diff --git a/commit.h b/commit.h
index 5467786c7b..742a6de460 100644
--- a/commit.h
+++ b/commit.h
@@ -167,6 +167,8 @@ int find_commit_subject(const char *commit_buffer, const char **subject);
 
 struct commit_list *commit_list_insert(struct commit *item,
 					struct commit_list **list);
+int commit_list_contains(struct commit *item,
+			 struct commit_list *list);
 struct commit_list **commit_list_append(struct commit *commit,
 					struct commit_list **next);
 unsigned commit_list_count(const struct commit_list *l);
-- 
2.29.2.533.g07db1f5344

