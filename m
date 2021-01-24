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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF892C433E6
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 17:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBFB322CF6
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 17:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbhAXRGm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jan 2021 12:06:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbhAXRGi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jan 2021 12:06:38 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41DAC061573
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 09:05:57 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id i63so7004853pfg.7
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 09:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cVwqRHiCPVOdFvi8BGeDd6ox9vceEwe8HnBQfQjgJgU=;
        b=MVaCjdDnyU6jGBB8USEBY+s2Yb65gUuMGYSRsxRglGVJ/WdLzl3SJrhihAS26EOYJD
         4InSWvERPpzNr02qD/RuoFm0dY1c9sH7XgH7p9blQAI9F1VARc4Dxc5g1bv9m6UCdrlS
         /MKigCTqTL3sX1d917YDhtV/5huEJzAtJQSFJIFgRnjO2RpetHEUL7MhrPc5OpxdPNqD
         EcZwYby933brmvd+qMBDyMTfz9cMKn6fMo2FkBOXKUvYUSibH8bG61A+2IN87tpdHszM
         hlCq2vIy5kIyoyTfw34kgd6hLX2A82tOM0rer+QLcB7ooYuD82F1uTA9TU2BWLY740p5
         gadg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cVwqRHiCPVOdFvi8BGeDd6ox9vceEwe8HnBQfQjgJgU=;
        b=jLC3NzbFwP1WMmjPwrXbc5zvw6rtsg40LoQcqbgE+wNLws9S0BTL7nx2HdKN/x5xKj
         xmdPXqq+lfyT+YtXnkhp1AgA6cHGlDOeVtw3LJL6HlUfhB8SQzMXVfJgnKIdgJlBR5AP
         8/y8DfwfPb+cocTGgGk7AQEcSToAqh8jBgV6GpZK+p5AdjzxBWcsAbk8CQgBgPw44+2/
         7cHaxv7wbHJMl2mt7qeXiXv/y3DdldwNXH9BDEFqFdZgUzzb7R2pGk+1LbKk5ziqoAqG
         /9NGC5n/CPPHDC4WjyE1N1H1azp0wo1oJrmQxdtewSxDDAfzPzLjdp29mQDGkWmbNGlr
         BuPQ==
X-Gm-Message-State: AOAM533BEgybM0Wg2gaExbwm6o5+O3V6BNcku9hHBOm33HyXFUDWKGx8
        wVyDwmKIRLwoiNkJ6jiXtxkCZTa++lhkHg==
X-Google-Smtp-Source: ABdhPJyVCGjI1Ot2Bt6lDEphrzd7mrL2MrYRH47Q450JyriDG4IbRaqZWPna0mdRKr1yahsp/7RCxQ==
X-Received: by 2002:a63:af05:: with SMTP id w5mr3929795pge.22.1611507957276;
        Sun, 24 Jan 2021 09:05:57 -0800 (PST)
Received: from localhost.localdomain ([2409:4050:2d0e:58a:f516:739c:ea0e:a6ba])
        by smtp.googlemail.com with ESMTPSA id r30sm16283308pjg.43.2021.01.24.09.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 09:05:55 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        marcnarc@xiplink.com, phillip.wood123@gmail.com,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Taylor Blau <me@ttaylorr.com>,
        Charvi Mendiratta <charvi077@gmail.com>
Subject: [PATCH v3 1/9] rebase -i: only write fixup-message when it's needed
Date:   Sun, 24 Jan 2021 22:33:59 +0530
Message-Id: <20210124170405.30583-2-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210124170405.30583-1-charvi077@gmail.com>
References: <20210119074102.21598-1-charvi077@gmail.com>
 <20210124170405.30583-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The file "$GIT_DIR/rebase-merge/fixup-message" is only used for fixup
commands, there's no point in writing it for squash commands as it is
immediately deleted.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Reviewed-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 sequencer.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 8909a46770..a59e0c84af 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1757,11 +1757,10 @@ static int update_squash_messages(struct repository *r,
 			return error(_("could not read HEAD's commit message"));
 
 		find_commit_subject(head_message, &body);
-		if (write_message(body, strlen(body),
-				  rebase_path_fixup_msg(), 0)) {
+		if (command == TODO_FIXUP && write_message(body, strlen(body),
+							rebase_path_fixup_msg(), 0) < 0) {
 			unuse_commit_buffer(head_commit, head_message);
-			return error(_("cannot write '%s'"),
-				     rebase_path_fixup_msg());
+			return error(_("cannot write '%s'"), rebase_path_fixup_msg());
 		}
 
 		strbuf_addf(&buf, "%c ", comment_line_char);
-- 
2.29.0.rc1

