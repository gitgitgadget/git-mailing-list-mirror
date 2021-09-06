Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CE4C433EF
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 18:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6107B6101C
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 18:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242559AbhIFSLj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Sep 2021 14:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233859AbhIFSLh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Sep 2021 14:11:37 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8C7C061575
        for <git@vger.kernel.org>; Mon,  6 Sep 2021 11:10:31 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id f22so7617148qkm.5
        for <git@vger.kernel.org>; Mon, 06 Sep 2021 11:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IAcpsYUA5Mzn8TXgO5H03D7ilDHNfVc7/cHFWR/gQHg=;
        b=oVFy8Fu2JLRDdoGmX9JQmfCX1bIx4jejGNqnG5g5peL9kGBv1PyQVlJspT855gMEJp
         iGfkQHEvvNPosqQ6E9Kdmfgu7Is5i3hhTDU5r/0cHn9TRQ2XyDIIWGzK73Ff0qfQDGXt
         W/8ErCcnP2maTceQ1ANA1S0KKDznQTRvSTCbLH7zroBUvXyokL5yp1jvqBf90UKPtsDJ
         W4gOsBz8bRU8sQAa6QskGdKFB2ydGeTp0ND0tMDjNZExMIqotw5ez0Oq28+/2JpHJEpf
         dyYc4zxXmPQNQkkztQLYgxy+eHI//RoibO7LCinfoeamOHL/R6UMarWgSMuLHYpuH2dy
         yzXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IAcpsYUA5Mzn8TXgO5H03D7ilDHNfVc7/cHFWR/gQHg=;
        b=ktQ9EJ9VDwxazPGBoRBH3v6fOJ4Cw4GwcdJG2Mj6Kr4WEXxy3gv0P38gpCrr3mWkun
         idrOlCUaA5GZDycuEINM3qZLj+ngpFQ1FAjnndO5OJLzYdX22GjdWuTyfg52VIdusL1o
         IREL00X5duQ++0FDzBee46UqXASyayFKlsjv7lf2cHAOPzNOsa9++ailz8tt/GeII77S
         BihaoRDW5riNsuK8iI5NA8ZQcgyLu/oMqCmQofRJ2VjwigVh01ZTzt3jB9qaKY2gJu9a
         7MAEOlowklQKCqNSfTIDWeHIoU+M6RjYGDimPhNInMOfb/8jzJhobAuty0g+jYkuHNk4
         OxsA==
X-Gm-Message-State: AOAM530WN38HtkSrhC3kFHf392y1Hyav1ZwQ20HFtJRWJmz7EJD0UyuB
        qZbwzRQxz3PSsF31dXtG7mhyVAgAYeuibg==
X-Google-Smtp-Source: ABdhPJxBO2mj+oY/IECKWwP3h/mYqvIfMOntyvmnnnUbauJ9Q9ldWHCug1n3mHabln8/tSMCZrDURA==
X-Received: by 2002:a37:8e44:: with SMTP id q65mr11796369qkd.372.1630951830382;
        Mon, 06 Sep 2021 11:10:30 -0700 (PDT)
Received: from CalumsBeastlyLaptop ([139.147.201.88])
        by smtp.gmail.com with ESMTPSA id v8sm5741697qtk.49.2021.09.06.11.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 11:10:30 -0700 (PDT)
Received: from calum by CalumsBeastlyLaptop with local (Exim 4.94.2)
        (envelope-from <calum@calumsbeastlylaptop.computercalum.com>)
        id 1mNJ4f-002coC-Fq; Mon, 06 Sep 2021 14:10:29 -0400
From:   Calum McConnell <calumlikesapplepie@gmail.com>
To:     git@vger.kernel.org
Cc:     Calum McConnell <calumlikesapplepie@gmail.com>
Subject: [PATCH 2/3] Die if filter is attempted without a worktree
Date:   Mon,  6 Sep 2021 14:10:01 -0400
Message-Id: <20210906181002.625647-2-calumlikesapplepie@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210906181002.625647-1-calumlikesapplepie@gmail.com>
References: <20210906181002.625647-1-calumlikesapplepie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As far as I know, this isn't possible.  Rather than add a bunch of
code to workarround something that might not be possible, lets just
halt and catch fire if it does.  This might need to be removed before
the change goes into master

Signed-off-by: Calum McConnell <calumlikesapplepie@gmail.com>
---
 convert.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/convert.c b/convert.c
index 5d64ccce57..df70c250b0 100644
--- a/convert.c
+++ b/convert.c
@@ -646,6 +646,11 @@ static int filter_buffer_or_fd(int in, int out, void *data)
 	sq_quote_buf(&worktreePath, the_repository->worktree);
 	dict[1].value = worktreePath.buf;
 
+	/* The results of a nonexistent worktree could be... weird.  Lets avoid*/
+	if(dict[1].value == NULL){
+		BUG("There is no worktree for this worktree substitution");
+	}
+
 	/* expand all %f or %w with the quoted path */
 	strbuf_expand(&cmd, params->cmd, strbuf_expand_dict_cb, &dict);
 	strbuf_release(&filePath);
-- 
2.30.2

