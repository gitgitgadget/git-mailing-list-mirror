Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8671C63697
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5728B241A7
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="J3/gzJ+K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgKQVr6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 16:47:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbgKQVr6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 16:47:58 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05A7C0613CF
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 13:47:57 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id z3so13509912qtw.9
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 13:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DyjLrIPhWNLVZ54Jka/84KiziIeEi2U5qd9H2KkmKUA=;
        b=J3/gzJ+KteeO6Lbi8/E6m2m2UqnpaAfIP8Bawbr4a2D5yTpw6Ei2FiGtp+UGrc3ibp
         l8JR40KHC5GXXqCuxz72MEZM6Hk+1KNcJiTvMIvWLS52nQvC9kHWaBp1WlCyHNZaqwd+
         zI/VJZiHXO9ixR08GeptEB6rBd/hY50i1CJeWFhXqmQZXhTB1REZoF1iotrNAu9RW/X0
         t4susIAFL9Tnc4uwJryonshdFnATV8MbuB8I/tUkRchQm+HqS3l7Wy1vXo7gTr7vE2O7
         FOG3y8NSjzsn6SCvxvw7/LFXK1xd2e7CqMe7r09gI+mrfpUfu5V1wbEewsp7bHouzmjV
         UvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DyjLrIPhWNLVZ54Jka/84KiziIeEi2U5qd9H2KkmKUA=;
        b=LqPfC9IYQuiUQe+1f+yb7bzG82eAGSCMuIg0ohu1Q/jdMik6X3OwcKS73N5yuXrBpx
         zpc/xwuC+gIMyd7adIYTdsYX57Yvuo0D+WLstzW06j2W/cRtj7/mPurmAWBno+w1yUWk
         zC7pzDnPlVk0JkWxxB6TTCsc961RufYhIXOz92M15xExz12PlJR4huKhfONlhoipNnIc
         ceSbK+1xiBJeug2+GJE7xZ6j3Ir3nPG3c+ZU0wtjgNNZ3oaaRMTKDlkyah7xFPB/BNG7
         PNVCpGarY3oWIVNyuWIDT1QtLWrZWhKO/OO6QChfZm9sDFwMYmozBWES0DLf53lYlB2o
         7yFQ==
X-Gm-Message-State: AOAM531AtqgGtXddfcusRdmWXRVjgRDMNqkSrCcC5Ov6QLsjzQBOHnPW
        znZV/9cpNbZhUlp7F5AH9vFsQN3CuECT5Ngs
X-Google-Smtp-Source: ABdhPJyQXKGzAU9YZMOxP11NzLEFmt3hLPxSn1DHy+GGwotnVkj5MYV6XSF7HAtXmLXrPgjXZzn17Q==
X-Received: by 2002:a05:622a:c8:: with SMTP id p8mr1312697qtw.293.1605649676886;
        Tue, 17 Nov 2020 13:47:56 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:7fe5:c4d6:f587:dc1f])
        by smtp.gmail.com with ESMTPSA id 9sm13982493qty.30.2020.11.17.13.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 13:47:56 -0800 (PST)
Date:   Tue, 17 Nov 2020 16:47:54 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        martin.agren@gmail.com, szeder.dev@gmail.com
Subject: [PATCH v2 17/24] pack-bitmap.c: check reads more aggressively when
 loading
Message-ID: <8f7bb2dd2e192562395bb815d891ec2ad28e6644.1605649533.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
 <cover.1605649533.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1605649533.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before 'load_bitmap_entries_v1()' reads an actual EWAH bitmap, it should
check that it can safely do so by ensuring that there are at least 6
bytes available to be read (four for the commit's index position, and
then two more for the xor offset and flags, respectively).

Likewise, it should check that the commit index it read refers to a
legitimate object in the pack.

The first fix catches a truncation bug that was exposed when testing,
and the second is purely precautionary.

There are some possible future improvements, not pursued here. They are:

  - Computing the correct boundary of the bitmap itself in the caller
    and ensuring that we don't read past it. This may or may not be
    worth it, since in a truncation situation, all bets are off: (is the
    trailer still there and the bitmap entries malformed, or is the
    trailer truncated?). The best we can do is try to read what's there
    as if it's correct data (and protect ourselves when it's obviously
    bogus).

  - Avoid the magic "6" by teaching read_be32() and read_u8() (both of
    which are custom helpers for this function) to check sizes before
    advancing the pointers.

  - Adding more tests in this area. Testing these truncation situations
    are remarkably fragile to even subtle changes in the bitmap
    generation. So, the resulting tests are likely to be quite brittle.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 4431f9f120..60c781d100 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -229,11 +229,16 @@ static int load_bitmap_entries_v1(struct bitmap_index *index)
 		uint32_t commit_idx_pos;
 		struct object_id oid;
 
+		if (index->map_size - index->map_pos < 6)
+			return error("corrupt ewah bitmap: truncated header for entry %d", i);
+
 		commit_idx_pos = read_be32(index->map, &index->map_pos);
 		xor_offset = read_u8(index->map, &index->map_pos);
 		flags = read_u8(index->map, &index->map_pos);
 
-		nth_packed_object_id(&oid, index->pack, commit_idx_pos);
+		if (nth_packed_object_id(&oid, index->pack, commit_idx_pos) < 0)
+			return error("corrupt ewah bitmap: commit index %u out of range",
+				     (unsigned)commit_idx_pos);
 
 		bitmap = read_bitmap_1(index);
 		if (!bitmap)
-- 
2.29.2.312.gabc4d358d8

