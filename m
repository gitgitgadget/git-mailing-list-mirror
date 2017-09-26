Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57B472047F
	for <e@80x24.org>; Tue, 26 Sep 2017 11:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030381AbdIZLWi (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 07:22:38 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:48282 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968096AbdIZLWf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 07:22:35 -0400
Received: by mail-wm0-f52.google.com with SMTP id m127so6685392wmm.3
        for <git@vger.kernel.org>; Tue, 26 Sep 2017 04:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E/lOwaqm3JBugFe0ifQUSg0YW8kgoF4b476yTOOLT5g=;
        b=RHIOGB15SbFkfoOJS+VCAFNLyCRaqJxP0Mss1OxdRdNRnynIrdPb5y8FULCx8sRKKg
         VI2sRdtk/GLn4srsjQR2wxw/5wwUXz9b8sViK9m64770/hLPerp1u9tzUcd4l4qOuuKR
         NQQfzUScUqwatDklXZq9m82ZAcvo0TPKrepVW0nlaRjIHjfYFRL3POGvY9JEY4/B/3Un
         OHDC6/lR2+8nwUT3B8IlckZc/7aNpkcuOuFPRqV80O1dtTEs/NTYVY/xiKGZu95MiOfq
         kVqLcEvIlkyfM1V04IOCq6qY6QAK12p8saECBYsIv0qp6QbT18Vxy7IWSWjtRu9Eyn3w
         za1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E/lOwaqm3JBugFe0ifQUSg0YW8kgoF4b476yTOOLT5g=;
        b=sXuKkKzgfNSAn2R1v11Mvtssk9JjLwVqt6XOCBQkwJ/O16QdSlSNuqUd2qP5uvnCC2
         5B0rUgO1Pm7vNYoUtFlGcV7ZTNmtxnC1D+uuM68RNMVugZqYgB/uI6K6vs9UioouDWWL
         9G2PMrTsZmdbihfcpj/mIJOl580Cg9xOJyeJJo9z/N0LLqVpN9gV2ZRKowPK1HJPHfpp
         SFwLHchEsWzGKFBc8rOPQyUEglWO6h2XRSrEgaMckTaVNYe7tNv2IHqLVpZEFozg1q8c
         oUSM5U283uxcD+hTWr/T+JvJIGkTpIj0y9KVc+E3M2z4txSOVJee1ZJja8tr3KuXKJoA
         ilMw==
X-Gm-Message-State: AHPjjUjzoA7YO5mpRzfJcY/HuJXP657UHS+sYwjfZKaZwnErTo+cR9De
        T7F1rM7vOjFIj8KA0Plbw18+zKmOL20=
X-Google-Smtp-Source: AOwi7QAucwiiHJROa9/FBzjw2/TiMXyEwKQLdPhKoVyCkc+8WQ2lm1ap8gAG8V18OMCQLRgqqdgW2A==
X-Received: by 10.28.165.136 with SMTP id o130mr3115388wme.107.1506424954142;
        Tue, 26 Sep 2017 04:22:34 -0700 (PDT)
Received: from hanwen.roam.corp.google.com ([104.132.61.99])
        by smtp.gmail.com with ESMTPSA id f19sm15854873wrf.85.2017.09.26.04.22.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Sep 2017 04:22:32 -0700 (PDT)
From:   Han-Wen Nienhuys <hanwen@google.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, bmwill@google.com,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH 2/3] read_gitfile_gently: clarify return value ownership.
Date:   Tue, 26 Sep 2017 13:21:49 +0200
Message-Id: <20170926112150.21850-3-hanwen@google.com>
X-Mailer: git-send-email 2.14.1.821.g8fa685d3b7-goog
In-Reply-To: <20170926112150.21850-1-hanwen@google.com>
References: <20170926112150.21850-1-hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 setup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/setup.c b/setup.c
index 42400fcc5..8c95841d5 100644
--- a/setup.c
+++ b/setup.c
@@ -541,7 +541,8 @@ void read_gitfile_error_die(int error_code, const char *path, const char *dir)
 
 /*
  * Try to read the location of the git directory from the .git file,
- * return path to git directory if found.
+ * return path to git directory if found. The return value comes from
+ * a shared buffer.
  *
  * On failure, if return_error_code is not NULL, return_error_code
  * will be set to an error code and NULL will be returned. If
-- 
2.14.1.821.g8fa685d3b7-goog

