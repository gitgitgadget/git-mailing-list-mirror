Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F646C77B7D
	for <git@archiver.kernel.org>; Sat, 13 May 2023 08:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjEMILf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 May 2023 04:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjEMILc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2023 04:11:32 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217D74683
        for <git@vger.kernel.org>; Sat, 13 May 2023 01:11:31 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f50020e0f8so2318515e9.0
        for <git@vger.kernel.org>; Sat, 13 May 2023 01:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683965489; x=1686557489;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zLF17RMkDWQZaPscNLEkVOshiQA/le+SgNc4KUNkIDk=;
        b=lpybRPbDaW1o4y1YDKZBMx5RZLE0GhC/TLhOc5hmaVfQYPTkl6qiiIb6J0GaJQO+P/
         kyLPFDNEzNr62tvAHNwWeB8YSQtdo6YwZF5HoRn16639YzS+kaghoUPawrT/+1ZaTzuH
         H/lolCYOcgJizmwfoYCc4KFPu33XUJz7j4oQGvLf57f7v+Ob5CSRgvxO54M1kDKY/aSL
         SFfCJChD1DUyqrosIoRb6Lopim7pm0A0F3y77SNHdm6dNqWT/+6ohvaH77T0Vz9o8HcB
         i05msajak/kMVwVheobjhwarr+hjTsRPnyDFOZ0NLJrqL9+T+rTMsmf3zXzSO8+TDC9W
         k8zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683965489; x=1686557489;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zLF17RMkDWQZaPscNLEkVOshiQA/le+SgNc4KUNkIDk=;
        b=FtK0SrK2CYC+9Fd5iPk5gDrg9qXlU7JI0Ss6uaUBLve/qCjJbprLldpKZy+bp6/M4o
         c/ZBo3lT8M54lwI0Zk0lM/iuhImX6h+hNHN1d57TxtSFb2iw5oe8OFuZR11X1wrg6z9i
         0cfMraIH17eN14YU1DtB8aOZPK/D36y0KrhuXvOfAiJ45SbfRSpodWcxzrVmNuwqOSzK
         7HADz5fPnpgBPQ60E9QHiXbBoxcc6z7RN8mC6M/FYrnPaP56SD1v8eyoxjlMXWbeVutP
         NjduFye8uw6AvOEqceZRPASHNahaP46hZTyjHDFY+W14E0BwTQh4SXe/UgQ5CY+CD82M
         2UJg==
X-Gm-Message-State: AC+VfDwp0oIZixfHZPUfIDf+svYRlp03VusbLNg5WIEVcGvZsJJct6C/
        p5/eNnFYFRSoq1yvswoMgQIxdnNvZks=
X-Google-Smtp-Source: ACHHUZ4siIXj4IBVU1GcWXDnSD2mDpIcW7pV5zPVXPBK5c8qsfQ0nZxwtQJL0cieVX0mlQP1BAGgCg==
X-Received: by 2002:a7b:cb93:0:b0:3f4:2374:3511 with SMTP id m19-20020a7bcb93000000b003f423743511mr15867564wmi.10.1683965489209;
        Sat, 13 May 2023 01:11:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k11-20020a7bc40b000000b003f4247fbb5fsm17563054wmi.10.2023.05.13.01.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 01:11:29 -0700 (PDT)
Message-Id: <2ac7c7a7c615db75a46076b58a51d363bc2daf2e.1683965487.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1531.v2.git.1683965487.gitgitgadget@gmail.com>
References: <pull.1531.git.1683759338.gitgitgadget@gmail.com>
        <pull.1531.v2.git.1683965487.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 13 May 2023 08:11:25 +0000
Subject: [PATCH v2 1/2] rebase --update-refs: fix loops
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `total_nr` field in the `todo_list` structure merely serves display
purposes, and should only be used when generating the progress message.

In these two instances, however, we want to loop over all of the
commands in the parsed rebase script. The loop limit therefore needs to
be `nr`, which refers to the count of commands in the current
`todo_list`.

This is important because the two numbers, `nr` and `total_nr` can
differ wildly, e.g. due to `total_nr` _not_ counting comments or empty
lines, while `nr` skips any commands that already moved from the
`git-rebase-todo` file to the `done` file.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 5f22b7cd377..f5d89abdc5e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4202,7 +4202,7 @@ void todo_list_filter_update_refs(struct repository *r,
 		if (!is_null_oid(&rec->after))
 			continue;
 
-		for (j = 0; !found && j < todo_list->total_nr; j++) {
+		for (j = 0; !found && j < todo_list->nr; j++) {
 			struct todo_item *item = &todo_list->items[j];
 			const char *arg = todo_list->buf.buf + item->arg_offset;
 
@@ -4232,7 +4232,7 @@ void todo_list_filter_update_refs(struct repository *r,
 	 * For each todo_item, check if its ref is in the update_refs list.
 	 * If not, then add it as an un-updated ref.
 	 */
-	for (i = 0; i < todo_list->total_nr; i++) {
+	for (i = 0; i < todo_list->nr; i++) {
 		struct todo_item *item = &todo_list->items[i];
 		const char *arg = todo_list->buf.buf + item->arg_offset;
 		int j, found = 0;
-- 
gitgitgadget

