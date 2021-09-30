Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6CE2C433F5
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 17:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC85160FC2
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 17:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352490AbhI3RDm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 13:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352481AbhI3RDj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 13:03:39 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B97C06176C
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 10:01:56 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id bb10so4507914plb.2
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 10:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5O8+bp9+rAeUi4F6Ug6kV5ONwx5ys4jpUyuCyTVICws=;
        b=cdPngq3mKO3jPV4VqN8ReXn0q+8q/gUnl52IcD7+hKLHPMuVThd6amYpPKmdbmfqPy
         JmF26Lpw2+OwrjOAMVP6zmZQJIGUyA9qF180875LcPhQjj+g1hA4KGg66sbJ/34zDrYs
         pu14IzEnifTMR/n6odBcHvHxwYN6Dl9atqy97KGFd3fWABt0Yta73nrHtJnX771BK1aA
         q5mpZegRV7eW/yPeMzwI0qbj3PHdrHmp18kh7mnLevaGHPVidSvTsGElW0NZUohFf36L
         J4DvoI55BgWERQBRoAeLudHOlP/Fvu1BlT3cCQRvPwltBJ9Gwy/yKrhr0PJSBWzTWRbq
         KOXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5O8+bp9+rAeUi4F6Ug6kV5ONwx5ys4jpUyuCyTVICws=;
        b=mB0yOBHN1TVd2g8FzUVKFKwTrfTvzlOM/tNXZNPzoMIvK51PN7SKqkgojiDcEylGiT
         CKBcXj5F+KV1/lvaMYiV/1xpsHbbMvndpo3pxYJpYnM0A9NO5xdekyG0OJhUeiUMnCuM
         w8gKL/Ip2/w3MV3wrZXLHew2ATwCRkDyI6gTZuXBj60d/2qZUIJcUc2T7IgWB9wdKCHU
         dFcfcnKIB/RwtAKf1Im0NP5xfO/V3nfCBzMp+abYtdABEggNNKBhSFti01r9AL+8jxFt
         mEiPEZ902/07RoW46NlzSpMMSTs6h3zUKILMn8Ie4XjhuREbEb8w5wRhdxgpaufR78JX
         UTfA==
X-Gm-Message-State: AOAM532F8xA/b5FPCbLK78C2kQFRmHcixWvfuo3wm7Z+WZVGANNVdYa/
        HLQv0Xxcq6KqEyTqWU2CML8Yo7Jtge8=
X-Google-Smtp-Source: ABdhPJyf6BGCv4dMzaXGrvU20sKHmJfrC0CnFYx3ohSVSef8aOLM6T6ZM2iha6SkigKdKVqZCZQtTw==
X-Received: by 2002:a17:90a:de16:: with SMTP id m22mr7749025pjv.54.1633021315968;
        Thu, 30 Sep 2021 10:01:55 -0700 (PDT)
Received: from sarawiggum.fas.fa.disney.com ([198.187.190.10])
        by smtp.gmail.com with ESMTPSA id p4sm2740678pjo.0.2021.09.30.10.01.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Sep 2021 10:01:55 -0700 (PDT)
From:   David Aguilar <davvid@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v6 5/5] difftool: remove an unnecessary call to strbuf_release()
Date:   Thu, 30 Sep 2021 10:01:46 -0700
Message-Id: <20210930170146.61489-5-davvid@gmail.com>
X-Mailer: git-send-email 2.33.0.887.g8db6ae3373
In-Reply-To: <20210930170146.61489-1-davvid@gmail.com>
References: <20210930170146.61489-1-davvid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `buf` strbuf is reused again later in the same function, so there
is no benefit to calling strbuf_release(). The subsequent usage is
already using strbuf_reset() to reset the buffer, so releasing it
early is only going to lead to a wasteful reallocation.

Remove the early call to strbuf_release(). The same strbuf is already
cleaned up in the "finish:" section so nothing is leaked, either.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
This is a small cleanup that I noticed while working on the new patches.
There are no previous versions of this patch.

 builtin/difftool.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index bbb8b399c2..859ccc6db3 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -560,8 +560,6 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 		write_entry(entry->path, entry->right, &rdir, rdir_len);
 	}
 
-	strbuf_release(&buf);
-
 	strbuf_setlen(&ldir, ldir_len);
 	helper_argv[1] = ldir.buf;
 	strbuf_setlen(&rdir, rdir_len);
-- 
2.33.0.887.g8db6ae3373

