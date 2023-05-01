Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07A0C77B7C
	for <git@archiver.kernel.org>; Mon,  1 May 2023 18:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbjEASVo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 14:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbjEASVl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 14:21:41 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342121BC6
        for <git@vger.kernel.org>; Mon,  1 May 2023 11:21:40 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f315735514so139034175e9.1
        for <git@vger.kernel.org>; Mon, 01 May 2023 11:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682965298; x=1685557298;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uktDzCdP4OYrLr62od7DFl+s2SZPRYyuCa+v52eWHD8=;
        b=Mbxbt06PgGyCprti1lKp1ZOrkZvwIjNDpR+0G7JOZc2WCx/PuMa2gDbnNdVAHqYmGR
         7VydIbqrkt3PmvzehQMZoqSRTHkC8IUOyfnqMwB6hMIvT2bP8h171AMOO/SywwY8o8Si
         2WgmHpg3S+SuDYYm+/MjACu93BsFepcL1Tx4dCl4kt6o5SxX1WsZKhWCdXZyePaohqYR
         1hYkvYuREqZ8Mktzfm+HK0+P8s/gEG1K289i22LbcWw0sZ4pNKgosJ3334/WszAmzcJW
         ESuWfqPYbjV+io5bijnjGyFTvF9iDSJwPkIu7mRvRvLYgmyQnuMYWE9RYV7ThRaYon0+
         X+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682965298; x=1685557298;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uktDzCdP4OYrLr62od7DFl+s2SZPRYyuCa+v52eWHD8=;
        b=duYzKMORkrhPd4pJ7wtZGvhwfWYsugbsVjt3ESIboTj0e3aOzSqVgGCCFeD8TgT4yh
         Z7NNwwKQ6aEmsLPbmUGfqNFcbC94lIiITj3uUYcYfkta1Zbog3IH3+7T9G2eAcFYnIFY
         2hkIIJetnu3Bxw0FWIjB/Nc+Axk/XXg4rMNYJZ55iutTEwPT/vf2M4tq3IScU3AENtZ5
         xfvMjyZ6NxJ97XlYXQWP52sk3SGDUtdqe7tjpUjxW5PMolii8Ik3b+Ba1q92Shbs5mFM
         w8WyDvOA+1iizrq2CB4ewf8K7w6jb0bmFT3N6HT0cq6ABGos3khf/2N19sUjbWC26xj4
         Dj5A==
X-Gm-Message-State: AC+VfDwFxIWmJMA7G7Rol2YmTtMubsKzZlTcE56+fqvDKQUun4NfYV1P
        UFZZenhnmA1N9j1Ja+vgGkszOo+0F3Y=
X-Google-Smtp-Source: ACHHUZ6QLPfshCnRwhhb6FX/j5emdfZfulQ7452dtKWHqzW4/5OkqXhQFUb1TVwTboI5a13pnm2w8A==
X-Received: by 2002:adf:db4c:0:b0:306:31cb:25fb with SMTP id f12-20020adfdb4c000000b0030631cb25fbmr1570413wrj.17.1682965298397;
        Mon, 01 May 2023 11:21:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n16-20020a05600c181000b003f046ad52efsm36317025wmp.31.2023.05.01.11.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 11:21:38 -0700 (PDT)
Message-Id: <2162a352a46dc0c40afccc4defc88a1e8940ce6c.1682965296.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1526.git.1682965295.gitgitgadget@gmail.com>
References: <pull.1526.git.1682965295.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 01 May 2023 18:21:35 +0000
Subject: [PATCH 2/2] fsck: use local repository
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

In 0d30feef3c5 (fsck: create scaffolding for rev-index checks,
2023-04-17) and later 5a6072f631d (fsck: validate .rev file header,
2023-04-17), the check_pack_rev_indexes() method was created with a
'struct repository *r' parameter. However, this parameter was unused and
instead 'the_repository' was used in its place.

Fix this situation with the obvious replacement.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/fsck.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 75b30d1d00c..dcc165bf0c5 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -869,20 +869,20 @@ static int check_pack_rev_indexes(struct repository *r, int show_progress)
 	int res = 0;
 
 	if (show_progress) {
-		for (struct packed_git *p = get_all_packs(the_repository); p; p = p->next)
+		for (struct packed_git *p = get_all_packs(r); p; p = p->next)
 			pack_count++;
 		progress = start_delayed_progress("Verifying reverse pack-indexes", pack_count);
 		pack_count = 0;
 	}
 
-	for (struct packed_git *p = get_all_packs(the_repository); p; p = p->next) {
+	for (struct packed_git *p = get_all_packs(r); p; p = p->next) {
 		int load_error = load_pack_revindex_from_disk(p);
 
 		if (load_error < 0) {
 			error(_("unable to load rev-index for pack '%s'"), p->pack_name);
 			res = ERROR_PACK_REV_INDEX;
 		} else if (!load_error &&
-			   !load_pack_revindex(the_repository, p) &&
+			   !load_pack_revindex(r, p) &&
 			   verify_pack_revindex(p)) {
 			error(_("invalid rev-index for pack '%s'"), p->pack_name);
 			res = ERROR_PACK_REV_INDEX;
-- 
gitgitgadget
