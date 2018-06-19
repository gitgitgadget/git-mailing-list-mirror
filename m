Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.9 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_96_XX,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A39AE1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 13:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730733AbeGPN1n (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 09:27:43 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:43737 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730621AbeGPN1n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 09:27:43 -0400
Received: by mail-pf0-f196.google.com with SMTP id j26-v6so1749203pfi.10
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 06:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=stNjIvhqnvEpD/z6adaObgQPd2IhtbQVSpLtsn+Hs3s=;
        b=jyjAbDaGQAzTGhGnhZ1ZICPQ1QL5DAitHU223w31ejZ8sb1FPX3VbJSGqX+jR3uPUM
         M71Vz0U0zmDd2cT4vFbRFbKgzxJkeo/U0EY8YcGRHowz1GWOMIIbwarByEf9ZhkebUc+
         E5SmOyUDbGVC/rLcg01bMEgEajDcnKmol9i6/M8cBRERpGcZd24xzwgDv0nw/CbO4hfO
         id8aFG5PUlUzvrUqXlYx5mCYXt6evV3EOjVihQmfWYeWBa1mInq+V7snU9ETZ8duysC6
         Ldr9QYRs7nwtodjiQCovjSbpD7HHwvfD3bjlEC0wcFqPakR1CJMAkyfnh17y+giiI21C
         pTMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=stNjIvhqnvEpD/z6adaObgQPd2IhtbQVSpLtsn+Hs3s=;
        b=lxhRNJm7vvncuKsXB4ATpDje55pgSuJQ5W4Fz6Zhk4wpMuxZlBQ3VclvM3MVxzFL3X
         9JASVQP25iDe27s3kKzKv/UdvkgAyNvbiVZNhhBFPY5pFzJ3g8JJN5eP7nkP6aQFT/k6
         cRSvhkKMRi8pfk7OQw9EG05HeJgSJKp7+52qijX3QSkRI2XkIaaGMolwIw7e7WwLC9wl
         nIL9EXhVMFXBgyElkMGkl+g9pfnBLobYKqmxsbRplj9PegMy6Ls5Dy8YkaLCOCX01ugT
         JQs+9EnLMUEjwC5fCZ4lk4vvogt/U/To6+gCjReKDqiQVTbXyDVf5XsJFVecNXGtWgAl
         DxuQ==
X-Gm-Message-State: AOUpUlE3bwiVKggB1hTdtVmXsj7uqzlnNB9n7pOqxJhWwo/w1a9sN3qs
        lt5sQiAYcdnFskczODcgP0e9tg==
X-Google-Smtp-Source: AAOMgpf0pjB/J4ELxkFQypKJZvvdsQMznERGbWni+7LctiEsctrYaNXzeM9X5/A8/uF83qvdzGoU6w==
X-Received: by 2002:a63:fa48:: with SMTP id g8-v6mr4308895pgk.224.1531746022037;
        Mon, 16 Jul 2018 06:00:22 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id v15-v6sm45848791pff.120.2018.07.16.06.00.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 06:00:21 -0700 (PDT)
Message-Id: <01daf73121a97abc128c52b2705eccaff6c7c92b.1531746010.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.10.git.gitgitgadget@gmail.com>
References: <pull.10.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 19 Jun 2018 16:35:36 -0400
Subject: [PATCH 05/16] upload-pack: refactor ok_to_give_up()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

In anticipation of consolidating all commit reachability algorithms,
refactor ok_to_give_up() in order to allow splitting its logic into
an external method.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 upload-pack.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 0ed470713..e7ad7f24b 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -368,34 +368,45 @@ static int reachable(struct commit *from, int with_flag, int assign_flag)
 	return (from->object.flags & assign_flag);
 }
 
-static int ok_to_give_up(void)
+/*
+ * Determine if every commit in 'from' can reach at least one commit
+ * that is marked with 'with_flag'. As we traverse, use 'assign_flag'
+ * as a marker for commits that are already visited.
+ */
+static int can_all_from_reach_with_flag(struct object_array *from,
+					int with_flag, int assign_flag)
 {
 	int i;
 
-	if (!have_obj.nr)
-		return 0;
-
-	for (i = 0; i < want_obj.nr; i++) {
-		struct object *want = want_obj.objects[i].item;
+	for (i = 0; i < from->nr; i++) {
+		struct object *from_one = from->objects[i].item;
 
-		if (want->flags & COMMON_KNOWN)
+		if (from_one->flags & assign_flag)
 			continue;
-		want = deref_tag(the_repository, want, "a want line", 0);
-		if (!want || want->type != OBJ_COMMIT) {
+		from_one = deref_tag(the_repository, from_one, "a from object", 0);
+		if (!from_one || from_one->type != OBJ_COMMIT) {
 			/* no way to tell if this is reachable by
 			 * looking at the ancestry chain alone, so
 			 * leave a note to ourselves not to worry about
 			 * this object anymore.
 			 */
-			want_obj.objects[i].item->flags |= COMMON_KNOWN;
+			from->objects[i].item->flags |= assign_flag;
 			continue;
 		}
-		if (!reachable((struct commit *)want, THEY_HAVE, COMMON_KNOWN))
+		if (!reachable((struct commit *)from_one, with_flag, assign_flag))
 			return 0;
 	}
 	return 1;
 }
 
+static int ok_to_give_up(void)
+{
+	if (!have_obj.nr)
+		return 0;
+
+	return can_all_from_reach_with_flag(&want_obj, THEY_HAVE, COMMON_KNOWN);
+}
+
 static int get_common_commits(void)
 {
 	struct object_id oid;
-- 
gitgitgadget

