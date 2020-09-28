Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB52C4741F
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 23:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFC9A2076B
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 23:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxPB8Syg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgI1X2n (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 19:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbgI1X2m (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 19:28:42 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82ACC0613BC
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 15:51:10 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id q4so1573389pjh.5
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 15:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QK/JYDJ8drhIkjOy4v0Ve/QLRcTBRyio+a5+6Z0VRYw=;
        b=bxPB8SygZEvAtHqrN3NfCRPnKhkaGqgtl/Bqgva5BHxWDh8LT2HtL4NkmIDw/LwZRi
         CsHeBtfEytxd3zI5W1BKBsMqEbjjDgYvYwW5Gnj+DL6/huPPRT3xUIKSsvgyJqmINhDU
         nutKpQn0GbL9aPuNJelAj2VM+MNO6gND44bcVYjRWhdiry7Ra5ZcWsUFEtDtxTtyyc7g
         JU3P0ZR08kRkYwCL/JgTU8dkg+mYd6gB/+5xWsK97r5RkiM7i8iWRVa6sOVeiNEiFkHM
         nNweTTb2LAmq0RX7AEQ5Kbsdz8N4wSUr8GBqRSXPpxUyqApbj0xjJLWZOjl0gQK9m4dK
         32nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QK/JYDJ8drhIkjOy4v0Ve/QLRcTBRyio+a5+6Z0VRYw=;
        b=dsCI0bNXzNxbGKPsrpcSWga6idnb1HYsUyF0x//JWCbHaH4nyIhWG1Rp1XZptnEmza
         AzM5jmip0jEwtN2PtYUPjvxAUtiXes6SZdzPGpqjuUyKUy1Ee+bwNpkQl4a0oWChBFwm
         Y9mb7L/c+iZKVXY+TJdps6O0/wJDWQEWgpars4uyfZcWXA5TyrU8ebE49O3U0OYv1E3w
         Hs5kSLwQE0Won5I0A5mfHzaAbjAZxVuSmrvFHDwB9S7+bQEn9RA1is01uJVhYLsKrHFB
         fLpWUjgWUjL+RRlif5IqQlCwu/sBCfUOM5pH/oYdx2xUTM3jjBoF0GJe6jTkawgXxWxG
         g2+A==
X-Gm-Message-State: AOAM533Dbd2+pPUYoYTyUqoN5krMZ5nXpCrD6srRCQcIDQfe3WnhsxcI
        b+hDHnMZEUNNVmYGBkcSXvRzRHtofYqQPQ==
X-Google-Smtp-Source: ABdhPJx9HZimD3wc4oyHDTgx8tMKmbEOR9cZfotwVNENRq5lohK6fwpVFV5d6AfwLMC8UOgGBZp40A==
X-Received: by 2002:a17:90a:bc8d:: with SMTP id x13mr1237026pjr.229.1601333470040;
        Mon, 28 Sep 2020 15:51:10 -0700 (PDT)
Received: from localhost.localdomain (cpe-70-93-247-186.natsow.res.rr.com. [70.93.247.186])
        by smtp.gmail.com with ESMTPSA id l2sm2501510pjy.3.2020.09.28.15.51.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2020 15:51:09 -0700 (PDT)
From:   Evan Gates <evan.gates@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3] Doc: show example scissors line
Date:   Mon, 28 Sep 2020 15:51:08 -0700
Message-Id: <20200928225108.22634-1-evan.gates@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200928202035.24218-1-evan.gates@gmail.com>
References: <20200928202035.24218-1-evan.gates@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The text tries to say the code accepts many variations that look remotely
like scissors and perforation marks, but gives too little detail for users
to decide what is and what is not taken as a scissors line for themselves.
Instead of describing the heuristics more, just spell out what will always
be accepted, namely "-- >8 --", as it would not help users to give them
more choices and flexibility and be "creative" in their scissors line.

Signed-off-by: Evan Gates <evan.gates@gmail.com>
---
Changes in v3:
- Reword commit message to better explain intent
- Add "e.g." to hint at other forms

Changes in v2:
- Specify exact line instead of adding text about 8 character minimum

 Documentation/git-mailinfo.txt | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-mailinfo.txt b/Documentation/git-mailinfo.txt
index 3bbc731f67..7a6aed0e30 100644
--- a/Documentation/git-mailinfo.txt
+++ b/Documentation/git-mailinfo.txt
@@ -72,10 +72,9 @@ conversion, even with this flag.
 	is useful in order to associate commits with mailing list discussions.
 
 --scissors::
-	Remove everything in body before a scissors line.  A line that
-	mainly consists of scissors (either ">8" or "8<") and perforation
-	(dash "-") marks is called a scissors line, and is used to request
-	the reader to cut the message at that line.  If such a line
+	Remove everything in body before a scissors line (e.g. "-- >8 --").
+	The line represents scissors and perforation marks, and is used to
+	request the reader to cut the message at that line.  If that line
 	appears in the body of the message before the patch, everything
 	before it (including the scissors line itself) is ignored when
 	this option is used.
-- 
2.28.0

