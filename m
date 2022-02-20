Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3A1C433FE
	for <git@archiver.kernel.org>; Sun, 20 Feb 2022 06:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234454AbiBTGzJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 01:55:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234353AbiBTGzH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 01:55:07 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D049735878
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 22:54:46 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id f3so21391946wrh.7
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 22:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=s/FNUD3Nfv1aJ56di/sqnJE/jJBUPQEIKWoIKlAJYVg=;
        b=c46EpqgxQachmptG4Popgt16tA9qEtxMV9i3djxvN5lRPJleSClc3Cph5Bft/amGbB
         EbY4xigZs6QRmMWVm7Ub/8yJpr+YOPd0S+i+gJwuuwG9rQWzXZ46w37+0JoMzU1QdTzc
         m7mq9EXsVWQ1ijgF1142XFv++POlWzQ5uehaoYXXM+6Eskh4tQyZlHYY3QGwAZ0yIusI
         wAtswqTm0BrK7ebUAeXR2nIqhyL0YDKsie/6+eRcUhbzxLemtEtUXbKz+1CKwpwkdBZk
         aIBmUuYPDS53D2INdXIciMV4uyHrBiXz/0IzoxhJL/86rz2xIhM5jB0Z4qlPAkv+VJZq
         hOiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=s/FNUD3Nfv1aJ56di/sqnJE/jJBUPQEIKWoIKlAJYVg=;
        b=mfVjhUtrJy3zP42ef+lBF20LmoeENUxoEJd0FLiO56NMiHWeAAwh4R54k8dcvPV64a
         RGyySPFHUaV8H3q+7k7690fy3T0IpRqfDCdXxLaozCMArxJKwdOE0vE6Q+e43Yh3SABI
         vIPU3bPgVQtZbW6CcAdTt8S0rgXe/Qhvfc4r2kZUgSKlkeUWQKzcWta1t3Cdp9A6PGsD
         HsN5EYwxdEPDaqQ9u9RYdaGic51fAsn9BYlY9/cqWf4HxKm+vakQ2qaGRm1EHl2AqPH3
         xaR0HhUkjAhbaXfMZPaxXeZYQJTP18npd5pivA8ij3jS91SFP+AIiKqo+uX85frIUMoa
         YHKw==
X-Gm-Message-State: AOAM531yYpyHgemsEgFuoY4x8W5MZ9NGerwB6EJFfL5evSHQY9M3mLIL
        S4OKyjxTIfm1f8DH2ogKnklTN5bcvyc=
X-Google-Smtp-Source: ABdhPJxmZ0VK5TTr8hy1fq8nA8pCLcb/f/PYKaUJCaFlOPkEvp1Rk2vurA9Q9mdyVp+wc4ZUWj93Ag==
X-Received: by 2002:a5d:6e8e:0:b0:1e6:754b:47de with SMTP id k14-20020a5d6e8e000000b001e6754b47demr11092994wrz.208.1645340085133;
        Sat, 19 Feb 2022 22:54:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f17-20020a7bc8d1000000b0037bc3effe27sm3949107wml.38.2022.02.19.22.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 22:54:44 -0800 (PST)
Message-Id: <4780ff6784d426bf0a96859ef9bf9c14e87d5f50.1645340082.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v5.git.1645340082.gitgitgadget@gmail.com>
References: <pull.1122.v4.git.1644698093.gitgitgadget@gmail.com>
        <pull.1122.v5.git.1645340082.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 20 Feb 2022 06:54:32 +0000
Subject: [PATCH v5 02/12] merge-tree: move logic for existing merge into new
 function
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In preparation for adding a non-trivial merge capability to merge-tree,
move the existing merge logic for trivial merges into a new function.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/merge-tree.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 06f9eee9f78..914ec960b7e 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -366,15 +366,12 @@ static void *get_tree_descriptor(struct repository *r,
 	return buf;
 }
 
-int cmd_merge_tree(int argc, const char **argv, const char *prefix)
+static int trivial_merge(int argc, const char **argv)
 {
 	struct repository *r = the_repository;
 	struct tree_desc t[3];
 	void *buf1, *buf2, *buf3;
 
-	if (argc != 4)
-		usage(merge_tree_usage);
-
 	buf1 = get_tree_descriptor(r, t+0, argv[1]);
 	buf2 = get_tree_descriptor(r, t+1, argv[2]);
 	buf3 = get_tree_descriptor(r, t+2, argv[3]);
@@ -386,3 +383,10 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 	show_result();
 	return 0;
 }
+
+int cmd_merge_tree(int argc, const char **argv, const char *prefix)
+{
+	if (argc != 4)
+		usage(merge_tree_usage);
+	return trivial_merge(argc, argv);
+}
-- 
gitgitgadget

