Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9AB6C433EF
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 19:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237173AbhL1Tgq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 14:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235996AbhL1Tgq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 14:36:46 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86C7C061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 11:36:45 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id w20so31164887wra.9
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 11:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KwlOealDsYSlT3vr/iAxRQ7tZPRCqQeJ/p6VpI0LNjY=;
        b=DPyCII7CX32P4LvzU+YJotQb0o5D2q2YPpGqLt7rcjOTSKtoXWc6GjaqE5z8fOqJyR
         ON8iC0MSolVrAKOFQq5c8H07kmzQg2QhYJzF7BneMSfSt9NkRi6bdau9T1ovHTLaLWV3
         YRr7GT3ZDQmWYfOgdXz548U8rcfvsbgqz2M6m72bVrT8g43RhfRMGc64b3dobohKFGVA
         MEcS4H6kYEIq6VXST83AVXzqnlMC1T2ERHhS7onrEO5AqYq89aF9iEeRMxi4KaPdgTKX
         kd2fQjduDdvim6rIBm2Vii56VvisWuDkU35tzx1qvQ1EJhmUA+l6C8AMV/n40H4NlOuy
         UTyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KwlOealDsYSlT3vr/iAxRQ7tZPRCqQeJ/p6VpI0LNjY=;
        b=ctUCaUawjK8g+vw0/DjUGUaa383Y3dlLsoFLz+mdfC8jlTCzEvEQblJxojnk4gtQ3u
         HFgRkiifmht/nbnNzdkskDETt50Fe3jllQm8VJvAToil/ymlj5DD1GPZyyDeDASstil9
         OPeOE2EOonMQCUVvX2GtEGperj22alcwEOc0QYmVcLBFSVZSF2fzaAYZWhy7Zs9JXoBG
         UhK89ZvgH0mblamwKlB4S0RUTTCfXyxOiNj381kc7jvk6zgaegbiQaZpVwYh4CYt/HHQ
         gQYZdPonk/aFrM++iBMnKUqUbCy8e1cPL+pKAIfuxhwcXwcIPDJd7M/VcR37EQG6SBOq
         V/vQ==
X-Gm-Message-State: AOAM5300iJfgjtq/M6XRqMXqNNOSBZkdAusUcNIzKMcEZuN4GhRGtMFw
        jahRsyMdv/puwLxYil3CPk9h2I7VpNw=
X-Google-Smtp-Source: ABdhPJyRpdXG8ZTFIW8c6hvLgA4zQhtnNZIju2gvEBaqUaqx8KLYuQlHXguQm+Me8WeBcOVZHw5rHA==
X-Received: by 2002:adf:f70b:: with SMTP id r11mr18231277wrp.496.1640720204252;
        Tue, 28 Dec 2021 11:36:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m3sm18902719wrv.95.2021.12.28.11.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 11:36:44 -0800 (PST)
Message-Id: <96f6896a13e68263b96827e0c66f20178fb9dfd1.1640720202.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1099.v2.git.1640720202.gitgitgadget@gmail.com>
References: <pull.1099.git.1640012469.gitgitgadget@gmail.com>
        <pull.1099.v2.git.1640720202.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Dec 2021 19:36:34 +0000
Subject: [PATCH v2 1/9] trace2: use size_t alloc,nr_open_regions in
 tr2tls_thread_ctx
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Johannes Sixt <j6t@kdbg.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Use "size_t" rather than "int" for the "alloc" and "nr_open_regions"
fields in the "tr2tls_thread_ctx".  These are used by ALLOC_GROW().

This was discussed in: https://lore.kernel.org/all/YULF3hoaDxA9ENdO@nand.local/

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 trace2/tr2_tls.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/trace2/tr2_tls.h b/trace2/tr2_tls.h
index b1e327a928e..a90bd639d48 100644
--- a/trace2/tr2_tls.h
+++ b/trace2/tr2_tls.h
@@ -11,8 +11,8 @@
 struct tr2tls_thread_ctx {
 	struct strbuf thread_name;
 	uint64_t *array_us_start;
-	int alloc;
-	int nr_open_regions; /* plays role of "nr" in ALLOC_GROW */
+	size_t alloc;
+	size_t nr_open_regions; /* plays role of "nr" in ALLOC_GROW */
 	int thread_id;
 };
 
-- 
gitgitgadget

