Return-Path: <SRS0=rBju=ZV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F045EC43215
	for <git@archiver.kernel.org>; Fri, 29 Nov 2019 21:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C248521771
	for <git@archiver.kernel.org>; Fri, 29 Nov 2019 21:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4q4nhgW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfK2VLy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Nov 2019 16:11:54 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44700 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbfK2VLx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Nov 2019 16:11:53 -0500
Received: by mail-wr1-f66.google.com with SMTP id q10so520428wrm.11
        for <git@vger.kernel.org>; Fri, 29 Nov 2019 13:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Cr1NQtKfgGkbYNQal4RtVYegfd0J2myrq2tipAyCtKs=;
        b=c4q4nhgWJjOTZrJwK4rsVs5cdQKG2XrtHImejrURVvl/GlcFw4oNiTLP7JAPsKiy8U
         Jt78apaBjaoMwnTXbgNb704KlCySstp+gfcopKIwUBsJw/SBj2SvGgwUC3BQKH57YDgR
         nTwvwMorZ70X9uq6s7QS8LNkSyUuGp9ttGKq3VswZL9C3rCj9B3zzy7y3Fs8zHseeT3j
         7cVZ676d0iaZfqRH6Og393uvT7mJFeIufiMqivx99OO/fIVTghoLyrPKubWge97qqKZW
         gwOn5EbPj6uOIr31UFbbKlyi4UJ+NJg8uaLxKY6zRrDukxBD3zhlgMRQjIS61Id7sVD8
         zTqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Cr1NQtKfgGkbYNQal4RtVYegfd0J2myrq2tipAyCtKs=;
        b=REBSGOBeXJ9+nLacZIqOGOiQ5G8XRAvE6Qy2DO6QrG9dshggX2mVPXoUktOJzzAl7F
         QF5tigrChTRZ7+yNnDZweiuNiNIIKgJvy/v2ygMic/unDWkkCFbiqVKfkm7V6yZdEJEy
         +h9PbgpMHQ4ujxfjldHC3ioyQSFK6VJzrcaGEG1oIEdrRiXTp7E9XEt03coYAmTmqIK/
         1h/NHrPIqVm/mdci3oxuxvtGk+N0BqESGdodtB9rgG5LrAvZioMpEHW/ls0WuYygQliT
         s2fhJzSpLAeDfTmbvGS72ZApHaqywJVesdrqDuUumB0wK36zVB004FE+oP3RHvxQftvo
         PYWA==
X-Gm-Message-State: APjAAAXlYsqSYDvZlt7nBIuLK7kOqQRtumkQiZsgXU5wccognAzVe4JI
        OCgmsz1qwZUauG86hfOe7wtCcehh
X-Google-Smtp-Source: APXvYqxWTUyp8wrnaqyZgA6NXW9JVZMgKqXyfYVOBGIH234sdRqKnGxewxSRNEhAGIgXS+oiw6JzUQ==
X-Received: by 2002:adf:db86:: with SMTP id u6mr59407929wri.318.1575061911749;
        Fri, 29 Nov 2019 13:11:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b186sm14262927wmb.21.2019.11.29.13.11.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Nov 2019 13:11:51 -0800 (PST)
Message-Id: <1e02bf2d63e99a6416238999b646998af960bc4b.1575061909.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.171.v2.git.1575061909.gitgitgadget@gmail.com>
References: <pull.171.git.1573821382.gitgitgadget@gmail.com>
        <pull.171.v2.git.1575061909.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Nov 2019 21:11:41 +0000
Subject: [PATCH v2 1/9] add-interactive: make sure to release `rev.prune_data`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

During a review, Junio Hamano pointed out that the `rev.prune_data` was
copied from another pathspec but never cleaned up.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/add-interactive.c b/add-interactive.c
index d6cb98cd40..de2fccb0ef 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -435,6 +435,9 @@ static int get_modified_files(struct repository *r, struct string_list *files,
 			rev.diffopt.flags.ignore_dirty_submodules = 1;
 			run_diff_files(&rev, 0);
 		}
+
+		if (ps)
+			clear_pathspec(&rev.prune_data);
 	}
 	hashmap_free_entries(&s.file_map, struct pathname_entry, ent);
 
-- 
gitgitgadget

