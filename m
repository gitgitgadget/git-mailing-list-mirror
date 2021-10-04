Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FD6C433F5
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 19:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D06360F6E
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 19:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237350AbhJDTD0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 15:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237016AbhJDTDV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 15:03:21 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC6FC061749
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 12:01:32 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id l7so45262846edq.3
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 12:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xSYUzMHMQcczvOB9kgHzkwBckCraSf1Ut58TeWIY0IM=;
        b=HYfsrrtjHHbDutnNOecWvZU0Ia096u76hODp7y//rP2JE8ZR/psMaZy4wVRTpmY+UM
         Rlfc4GdP5V9vs4TqiGmdkevye7XrS2IZmq8X80C6xe0UyDG/v+ga/riM2tZA7Hdrom6F
         3gG3DcFy2fcbET3I45877swzYdKrbordXac62bDYb8FSiOQwdgDL9mNx8FkzUBh6PDIb
         2CVq5jY9P1g+xzvMH1lkRQumBMKhbExMzv5Ah+rlEQKpob5QW4sqePcVHXYdCa2rmCZj
         qMwnwrp8Z4iB7YhF4foh6QAXwR4QnU0fKWk/ZG7OKR2CjMtoIYlkRWitg2ze9SsGLKyn
         mwXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xSYUzMHMQcczvOB9kgHzkwBckCraSf1Ut58TeWIY0IM=;
        b=R5DnuoIlrkMqSwfPP48LDyh/0DOVTfp8ErXDzfZ/K9nmN7L8yLYAgiH7V375TpTeqF
         giS4Esat2MPMVETeXUZ2ayhOWbKl7IBtTXIDAUWLq5TXOWqHMJRQiCYRtVjIcRfAnC0z
         Y3z6QfAz63TedxZTY2zX/UpPYeyIuyt4gV7VrAeO7ew0PsH/Ti1wSK9AvFFbfeZ17eVy
         w1RT3WnFnzDDfBcirzQ8IajQ+nNDrq2uRU5x7HUPie1n0oA8t8Ep0NeJD8cT5of0WVT+
         gyeS5fvwnmCd/si/MQ7NY/TWQuJTyhTCYotPbJyW7QRqVfnDTZPHV4KJed3JfuwEcsVU
         tF1g==
X-Gm-Message-State: AOAM531b+BuA8natI9nsYCdSfLNHbvLEpiQ5ZEM/n4ROWr4z74xCEKh1
        qJSJm9ohkr/zk6tNS413yFU=
X-Google-Smtp-Source: ABdhPJzSgAf7MD3E3mhzoi4w8BXi7HzI6xHS9WppQLAQV/DuL/N+9/Vo+910AKJR615iw2YLyI7XkA==
X-Received: by 2002:a17:906:82c8:: with SMTP id a8mr7871793ejy.384.1633374091071;
        Mon, 04 Oct 2021 12:01:31 -0700 (PDT)
Received: from localhost.localdomain (178.115.74.220.wireless.dyn.drei.com. [178.115.74.220])
        by smtp.gmail.com with ESMTPSA id v13sm6759357ejo.36.2021.10.04.12.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 12:01:30 -0700 (PDT)
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     newren@gmail.com
Cc:     aclopte@gmail.com, git@vger.kernel.org
Subject: [PATCH v2 4/4] Documentation/git-status: mention how to detect copies
Date:   Mon,  4 Oct 2021 21:00:50 +0200
Message-Id: <20211004190050.921109-4-aclopte@gmail.com>
X-Mailer: git-send-email 2.33.0.rc2.dirty
In-Reply-To: <20211004190050.921109-1-aclopte@gmail.com>
References: <CABPp-BFqJi0q0844NKfU8K5HRpAJ7yP2OkyBUiFQSAw-ZjNoyw@mail.gmail.com>
 <20211004190050.921109-1-aclopte@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The man page documents that git-status can find copies, but does not
mention how. Whereas git-diff has command line options -C, there is
no such option for git-status - it will only detect copies when the
"status.renames" config option is "copies" or "copy". Document that
in git-status.txt because this has confused me and others[1].

[1]: https://www.reddit.com/r/git/comments/ppc2l9/how_to_get_a_file_with_copied_status/

Signed-off-by: Johannes Altmanninger <aclopte@gmail.com>
---
 Documentation/git-status.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 255dc6af9b..8f959afa0f 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -211,7 +211,7 @@ show tracked paths:
 * 'A' = added
 * 'D' = deleted
 * 'R' = renamed
-* 'C' = copied
+* 'C' = copied (if config option status.renames is set to "copies")
 * 'U' = updated but unmerged
 
 ....
-- 
2.33.0.rc2.dirty

