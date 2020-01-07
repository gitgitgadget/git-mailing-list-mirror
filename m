Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F39C3F68F
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 15:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2820E222D9
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 15:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bs00Nk6m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbgAGPHf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 10:07:35 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45837 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbgAGPHe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 10:07:34 -0500
Received: by mail-wr1-f65.google.com with SMTP id j42so54287098wrj.12
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 07:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JPwX4jfmIM3FzBfAtYiHdY73brYHR2F1JAWGP4FXRO0=;
        b=bs00Nk6mBqoQZQFu1UhT/xtE2+IZqazacc78Uv1FiGLMCBsyJM8NwWC4EFX9WKpm+z
         SzBnptauaD96OQ8Z9TvGKX6c586aXIaagPFF52Su+9DLX93fTQI7awwlh5+Tya048WbR
         5IU3wJwVVvB99tJrSfZLlTYyvtIN1WGe22/AxCPJx5hBuu/pygCH2BrtVhCz03+rUrLt
         exawA4HrgD9DYMmq8c1psvyWRFDtzMZJCkK4AZBQ861Py9EfFXtt0BMdqHpdD50IiUPj
         SBt8ngzjkIJVomMEW97P6XA42upNHQs19zJjMDmUzi+FYLyYaQY5H7LwJxtsi4Z0KfyS
         Ls1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JPwX4jfmIM3FzBfAtYiHdY73brYHR2F1JAWGP4FXRO0=;
        b=Onib70r96egbW8UwNG7BF+uFvDDADtO+wgBpwzABEpJohV/OWvjzsOCJyHhwwwSkAr
         vbFBr14adKOPfGFbuWlHWyj2DU40hWafowji2Evm3bNUhEU62G+07Qpni/Oeodfz5yV2
         peyl5labC5y/qRiu6W8sSjJmxwsZlBBvBm+OS7bNCLo0VFz7FSWApEsO6lR/b9GDBmPy
         K1Kk0LjMMCc49qANqaBCUBmOEfC4zAaq1XyMI4vBi3877BbuCJMBVuZUM/MzBhvBN6je
         VUpdNfqkrg9lO2SfrYNQdJBlrlHdl9MBIZ6jFhdGNcCQoadvo0aOVV+A7dMfkwCQrOQB
         AudQ==
X-Gm-Message-State: APjAAAU0fLc/i/Nfkd1/P+FkxwsdxiITzYhleZwXX0AxCy6/IJj6hexM
        CcaJ+LqXF6VJ3PfIkzyNUOgCll0x
X-Google-Smtp-Source: APXvYqxJBGOwXVFYMUGYXBozEqWC1WTQSuPWVLA/l8Wrc1AFyjtYFqmoWZjwbPhMpa/VKDrdkuufVw==
X-Received: by 2002:adf:eb89:: with SMTP id t9mr111518367wrn.5.1578409653009;
        Tue, 07 Jan 2020 07:07:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g2sm91525wrw.76.2020.01.07.07.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 07:07:32 -0800 (PST)
Message-Id: <2e003cfc0a6512861c5826a79e54ebc2ebf3eafb.1578409650.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.689.git.git.1578409650.gitgitgadget@gmail.com>
References: <pull.689.git.git.1578409650.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Jan 2020 15:07:30 +0000
Subject: [PATCH 1/1] string-list: note in docs that callers can specify
 sorting function
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In commit 1959bf6430 (string_list API: document what "sorted" means,
2012-09-17), Documentation/technical/api-string-list.txt was updated to
specify that strcmp() was used for sorting.  In commit 8dd5afc926
(string-list: allow case-insensitive string list, 2013-01-07), a cmp
member was added to struct string_list to allow callers to specify an
alternative comparison function, but api-string-list.txt was not
updated.  In commit 4f665f2cf3 (string-list.h: move documentation from
Documentation/api/ into header, 2017-09-26), the now out-dated
api-string-list.txt documentation was moved into string-list.h.  Update
the docs to reflect the configurability of sorting.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 string-list.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/string-list.h b/string-list.h
index 7bb0ad07e6..6c5d274126 100644
--- a/string-list.h
+++ b/string-list.h
@@ -4,7 +4,8 @@
 /**
  * The string_list API offers a data structure and functions to handle
  * sorted and unsorted arrays of strings.  A "sorted" list is one whose
- * entries are sorted by string value in `strcmp()` order.
+ * entries are sorted by string value in the order specified by the `cmp`
+ * member (`strcmp()` by default).
  *
  * The caller:
  *
@@ -209,7 +210,8 @@ struct string_list_item *string_list_append(struct string_list *list, const char
 struct string_list_item *string_list_append_nodup(struct string_list *list, char *string);
 
 /**
- * Sort the list's entries by string value in `strcmp()` order.
+ * Sort the list's entries by string value in order specified by list->cmp
+ * (strcmp() if list->cmp is NULL).
  */
 void string_list_sort(struct string_list *list);
 
-- 
gitgitgadget
