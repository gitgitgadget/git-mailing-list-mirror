Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B7AC433F5
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 07:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A40FD6128C
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 07:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243771AbhKRHQI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 02:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243692AbhKRHO7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 02:14:59 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7365DC06121E
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 23:11:34 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id p18-20020a17090ad31200b001a78bb52876so7413686pju.3
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 23:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MWL+oVUsBX56daYe7mkNFI8R3ecQj59HSMMsxIlQuWo=;
        b=dlSEZilaqTHHR3f1fUmoYZKBzhqGc+xVe5/Bv7kXbNvGZ144B6EwtkOIYwMxKUQKiQ
         yrM9KjgkATK2ruBVpjV3qWI8y6oZseuXWaD0C/3TbT2kW9A4rb01mRrN5Z/lrn7ehIn0
         dEit/nuKE0dHn7WhG5nZe+OF1X5tA2GYle3YRuoqHXxZ6X/HwYrY0VA5XECK91SrWHvv
         WADN41Se8OTK4lLQcs049zFiIDh/J5KzGDQ4bWMIxN/x4hnadk41XhANgfPjdcXV85ds
         rY37k/uI+Q6eMp4QEi7v0d0YNZpi72WLrwODd9I/KhVdQXXBMzADJrEubdl6yoSn7Grq
         gWKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MWL+oVUsBX56daYe7mkNFI8R3ecQj59HSMMsxIlQuWo=;
        b=oi+Q3inPCVExBrh0TjgD4GHTo8b9w7e9TpCIaz7UbctVQszgP28axzItr45vrHN5+H
         9MnAIBcyHlNfHbD97LIn/eZtC9LYvlBnz+wGtjZjNhOV5McjDVgXVtwFDD1cubHcsRDD
         Q6Qb7wHaL9wSoex614iKGEAjqiCMcik4HArKnwZTZkpNrhCVnPJlNwZqBWL3mbGBF6ih
         t1VFZ3AeR7mJHWJPgo8ff76SR8pv7pO5X27pXmGI4tqOzkuFrp93t3WDvcfnbnXant2b
         xZQ4TOAetUh/b7uOPYnQV/bXc0zOLN0ccZF+1G4N31Vk1oiiJgNN4hsZ0u4pSqZtQLEj
         jb9A==
X-Gm-Message-State: AOAM533Sc7rrhbOGbKkSOi9fprXbCYpIPf3kUDfUmY/nqD84djCqq7KV
        ihDsLDAXJc/A8PxbYbWBqTOC8s59o68XSg==
X-Google-Smtp-Source: ABdhPJxGobHA/Nn7QqwZi1VOUYZi1Yiyox2EzWSt4rQi4pPhe/8mGeBtaKNSi5Ypayv/I3XKwHIdBA==
X-Received: by 2002:a17:90a:2e16:: with SMTP id q22mr7898849pjd.156.1637219493720;
        Wed, 17 Nov 2021 23:11:33 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.103])
        by smtp.gmail.com with ESMTPSA id l4sm2011101pfc.121.2021.11.17.23.11.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Nov 2021 23:11:33 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, stolee@gmail.com,
        Teng Long <dyroneteng@gmail.com>
Subject: [PATCH v2 1/1] midx: fix a formatting issue in "multi-pack-index.txt"
Date:   Thu, 18 Nov 2021 15:11:14 +0800
Message-Id: <9b910a44f4143c94787110a688f2b17ba4eeb0fc.1637218943.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.33.1.9.g5fbd2fc599.dirty
In-Reply-To: <cover.1637218943.git.dyroneteng@gmail.com>
References: <cover.1637218943.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is a formatting issue  in "multi-pack-index.html", corresponding
to the nesting bulleted list of a wrong usage in "multi-pack-index.txt"
and this commit fix the problem.

In ASCIIDOC, it doesn't treat an indented character as the
beginning of a sub-list. If we want to write a nested bulleted list, we
could just use ASTERISK without any DASH like:

      "
      * Level 1 list item
      ** Level 2 list item
      *** Level 3 list item
      ** Level 2 list item
      * Level 1 list item
      ** Level 2 list item
      * Level 1 list item
      "

The DASH can be used for bulleted list too, But the DASH is suggested
only to be used as the marker for the first level because the DASH
doesn’t work well or a best practice for nested lists,
like (dash is as level 2 below):

      "
      * Level 1 list item
      - Level 2 list item
      * Level 1 list item
      "

ASTERISK is recommanded to use because it works intuitively and clearly
("marker length = nesting level") in nested lists, but the DASH can't.
However, when you want to write a non-nested bulleted lists, DASH works
too, like:

      "
      - Level 1 list item
      - Level 1 list item
      - Level 1 list item
      "

Reviewed-by: Taylor Blau <me@ttaylorr.com>
Reviewed-by: Derrick Stolee <stolee@gmail.com>
Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 Documentation/technical/multi-pack-index.txt | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/technical/multi-pack-index.txt b/Documentation/technical/multi-pack-index.txt
index fb688976c4..642e2517f3 100644
--- a/Documentation/technical/multi-pack-index.txt
+++ b/Documentation/technical/multi-pack-index.txt
@@ -17,12 +17,12 @@ is not feasible due to storage space or excessive repack times.
 The multi-pack-index (MIDX for short) stores a list of objects
 and their offsets into multiple packfiles. It contains:
 
-- A list of packfile names.
-- A sorted list of object IDs.
-- A list of metadata for the ith object ID including:
-  - A value j referring to the jth packfile.
-  - An offset within the jth packfile for the object.
-- If large offsets are required, we use another list of large
+* A list of packfile names.
+* A sorted list of object IDs.
+* A list of metadata for the ith object ID including:
+** A value j referring to the jth packfile.
+** An offset within the jth packfile for the object.
+* If large offsets are required, we use another list of large
   offsets similar to version 2 pack-indexes.
 
 Thus, we can provide O(log N) lookup time for any number
-- 
2.33.1.9.g5fbd2fc599.dirty

