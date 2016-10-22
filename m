Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FD6E20986
	for <e@80x24.org>; Sat, 22 Oct 2016 23:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965045AbcJVXdU (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Oct 2016 19:33:20 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:36057 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965004AbcJVXdN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2016 19:33:13 -0400
Received: by mail-it0-f43.google.com with SMTP id e187so74374503itc.1
        for <git@vger.kernel.org>; Sat, 22 Oct 2016 16:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9yKx5XL2fPCSBjNmNBcznHL5VaOeH0WrWzRAbtx9mow=;
        b=XPE27t5HmP/Yj/1TGVdbURBR79L354gGBmS9tXPVz0zxlgkYE7SPInOwt3w2cgk3Rg
         za9iQKhGPIXqDve9b45GUQ0FgbwsZY5WpZiiHoHJGFzlgGcnnnftODUSOVyKTo7iuf8v
         cb0NyhwxNesd5bc2a0ECGE2XPc9Wjj0adJ2LQYGUj2izH+cD3jThpSfuGH8vDShlp9do
         HYPVeSzhXW6iL/PtPucaPo5hED/XHudwafSpoDByD3ZZcHMb2uBqht4qbJIR1urqLZdR
         2cjlRwfdG8efl0DynXgEnk5g5imgdQKK2BmJDlIYsyklBGd2Tv0JDg0ENq1FrID2Xh0p
         kX5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9yKx5XL2fPCSBjNmNBcznHL5VaOeH0WrWzRAbtx9mow=;
        b=aaCSk8CgsfaFMBylL22lCwEzBgSgYDz+nItA3Vk3LfoKXr+xpaC6Km9l9aIzlvfohI
         v5FnP+UmXYpQLYo8ZANd31DZpIhmkkmmib9GIytuEiU/itp2+sWRAtwlvdXKuYMM7qX4
         s2kqDPULi+LG6km5oIaxis7W1Su5cvU+pmdgafX/t/s2o9dnjMxY3vyX+gUB4MBE19U9
         1+7pm438OxwHNJyszlvjsqcBhZQmH9bpedcqe3xT+Hl+DElhOUE81S1KcGnIqXn7pzwl
         owF/XgK6h0I/e8pOfaWvIEl8n+OaqgnvqkqDDGYX0oWAe9Y+uLOHvgZH07jvl6gIeST0
         DYhg==
X-Gm-Message-State: ABUngvehMfK+TcwlUilGZfnkqorDDh711F6kQBEB1IWiCwb4EQxGWSDIN8hjdxHjclxixDyl
X-Received: by 10.107.198.146 with SMTP id w140mr2434284iof.200.1477179192295;
        Sat, 22 Oct 2016 16:33:12 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:4ca0:b1d9:cc22:1c7b])
        by smtp.gmail.com with ESMTPSA id h79sm1951294ith.19.2016.10.22.16.33.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 22 Oct 2016 16:33:11 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 21/36] attr.c: rename a local variable check
Date:   Sat, 22 Oct 2016 16:32:10 -0700
Message-Id: <20161022233225.8883-22-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.508.g6572022
In-Reply-To: <20161022233225.8883-1-sbeller@google.com>
References: <20161022233225.8883-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Throughout this series, we are trying to use "check" to name an
instance of "git_attr_check" structure; let's rename a "check" that
refers to an array whose elements are git_attr_check_elem to avoid
confusion.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 attr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/attr.c b/attr.c
index 9ed4825..7869277 100644
--- a/attr.c
+++ b/attr.c
@@ -682,12 +682,12 @@ static int macroexpand_one(int attr_nr, int rem);
 
 static int fill_one(const char *what, struct match_attr *a, int rem)
 {
-	struct git_attr_check_elem *check = check_all_attr;
+	struct git_attr_check_elem *celem = check_all_attr;
 	int i;
 
 	for (i = a->num_attr - 1; 0 < rem && 0 <= i; i--) {
 		struct git_attr *attr = a->state[i].attr;
-		const char **n = &(check[attr->attr_nr].value);
+		const char **n = &(celem[attr->attr_nr].value);
 		const char *v = a->state[i].setto;
 
 		if (*n == ATTR__UNKNOWN) {
-- 
2.10.1.508.g6572022

