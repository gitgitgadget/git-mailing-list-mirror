Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78416C433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 07:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238741AbiBWHr0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 02:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiBWHrY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 02:47:24 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF6A35848
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 23:46:57 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id v21so2855486wrv.5
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 23:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HsHj2KxDWTA9QM6TZSN11NDwemvgrQd3pHbka8fElO8=;
        b=iG1G7llAmaVvRFg9Y4URY29IOAtwSh22rexujPd9nSHj15M+bHgNETBv1UHLnGE/eu
         +nrFLcYicOOM6s6OgjpoQiBzKP7WlZOvCdP5atOoNg5bAID+0wf0Z7nNTgCgXTsxMuzu
         UlIVOCBIeYj/+WVGOSW2mGVgFtGL//TQWDjy3VjFoy5e1/xNr/aYKGWVvCzplrF2ZrGa
         A18c5IO++kMoPgpYjTyQlpo44Mk9ChyBTlE9Ke6jPu1wEvvr1QXEMTrtIMTOfhbKsH+L
         qfiUvZxbGngKGpxUjqhOZcIDoUpo8cAxgMd3cCHAP7EBOPuLgVHqC/SCOwfwcclZKex4
         oPog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HsHj2KxDWTA9QM6TZSN11NDwemvgrQd3pHbka8fElO8=;
        b=ceUlUZJwTUWMzc298J/7Mif6RVRvy0SNNJqmWid6ZHtE7QdetL+cedUXbFJd1kN/Zy
         20zAibvqxLTFP2HXhEn07It4rVcB8YeZWtRYOzQjvoRjs1UwFTvIFJvUVdOYdCQiLmqv
         XJH77yrEU4mnuhsZiutM6GfrXovpyckX5JQU1oti7A/TApX3TJIBk58SvQJmNMymwaoh
         Q1/c9ytnMa+xOXqbM6Wlv97emxcnVJfOIz+bRURpC5A9m/lN2ybw//GX5UKJ/MCZnz2P
         LeiWNu1wCkex+WeeKAXCk2E3zI1oIpLkyOnCaQZzQ6z4bBq3EwbWFFjUTuC2IbMXjWM5
         rK2w==
X-Gm-Message-State: AOAM5339qBxvubpmp3Sqr3OwuP9PIWouL0ES6kXT/EstSSsqDH7VQBCi
        2jcaZoTaJniccoCE7CgkH6kd0cpgSEk=
X-Google-Smtp-Source: ABdhPJxJm1b0IDJOqeuYqY36/njGmQezUllvOQDd1bGd/+UQA6EQjtZIJp/uXau8irvv0NrB90DpvA==
X-Received: by 2002:adf:f1c1:0:b0:1e3:1381:7bd5 with SMTP id z1-20020adff1c1000000b001e313817bd5mr22333833wro.450.1645602415539;
        Tue, 22 Feb 2022 23:46:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k11sm5431974wrd.103.2022.02.22.23.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 23:46:55 -0800 (PST)
Message-Id: <4a7cd5542bb2f89b4874e4115542ccee9c4639af.1645602413.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v6.git.1645602413.gitgitgadget@gmail.com>
References: <pull.1122.v5.git.1645340082.gitgitgadget@gmail.com>
        <pull.1122.v6.git.1645602413.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 07:46:42 +0000
Subject: [PATCH v6 01/12] merge-tree: rename merge_trees() to
 trivial_merge_trees()
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

merge-recursive.h defined its own merge_trees() function, different than
the one found in builtin/merge-tree.c.  That was okay in the past, but
we want merge-tree to be able to use the merge-ort functions, which will
end up including merge-recursive.h.  Rename the function found in
builtin/merge-tree.c to avoid the conflict.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/merge-tree.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 5dc94d6f880..06f9eee9f78 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -28,7 +28,7 @@ static void add_merge_entry(struct merge_list *entry)
 	merge_result_end = &entry->next;
 }
 
-static void merge_trees(struct tree_desc t[3], const char *base);
+static void trivial_merge_trees(struct tree_desc t[3], const char *base);
 
 static const char *explanation(struct merge_list *entry)
 {
@@ -225,7 +225,7 @@ static void unresolved_directory(const struct traverse_info *info,
 	buf2 = fill_tree_descriptor(r, t + 2, ENTRY_OID(n + 2));
 #undef ENTRY_OID
 
-	merge_trees(t, newbase);
+	trivial_merge_trees(t, newbase);
 
 	free(buf0);
 	free(buf1);
@@ -342,7 +342,7 @@ static int threeway_callback(int n, unsigned long mask, unsigned long dirmask, s
 	return mask;
 }
 
-static void merge_trees(struct tree_desc t[3], const char *base)
+static void trivial_merge_trees(struct tree_desc t[3], const char *base)
 {
 	struct traverse_info info;
 
@@ -378,7 +378,7 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 	buf1 = get_tree_descriptor(r, t+0, argv[1]);
 	buf2 = get_tree_descriptor(r, t+1, argv[2]);
 	buf3 = get_tree_descriptor(r, t+2, argv[3]);
-	merge_trees(t, "");
+	trivial_merge_trees(t, "");
 	free(buf1);
 	free(buf2);
 	free(buf3);
-- 
gitgitgadget

