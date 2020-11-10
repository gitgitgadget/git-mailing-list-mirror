Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC49C388F7
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B55220781
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xnv74KQ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731946AbgKJVWK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 16:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731880AbgKJVWH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 16:22:07 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9D4C0613D1
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 13:22:07 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id l36so130369ota.4
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 13:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PNb4m+fcbT0dHh0qgBa3+vMGgmX9k+yzQr1pu/wqUeE=;
        b=Xnv74KQ7eqJjHQPECodNQeYmeVO0MX8UU23hZH/Cq1/nMyY8zrjPctiS0kzB+GAj5J
         le/8aSSMuxp1dbekBwXt3Ldf/QClqBByHkJTNRzxUL+vE/jH3m8bPks9/8EkJMCQONjq
         tI/J31MnGX2OrcFY0UKqpYHjkFCe6o1gb15zEXegj03C7N/NQ/iSG8ODGjJayML+Xbpd
         laHx7kf4b3242fCAU+PfpFKCyjFn7juvdW72Y/o9BZxboJfNg506iyJyrKhuhQzGY4bq
         jeWQH/CtiJZc/4Rt1XQsnZpWsZ9nO1HkyQEs6iBd/o9Ta7UbdPD3AGDfAS1bWFr7lhbX
         xNOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PNb4m+fcbT0dHh0qgBa3+vMGgmX9k+yzQr1pu/wqUeE=;
        b=uVbTISqOzZXO71GmTHwtuoHi3z34A05MPsTTN6DXhGxTg4Xn0Uv2SWF47w9uf3bca/
         6giwKQcZXH6HXyeAR/GtZ+0js4kGDExhen8Fi3/GlsROw75uL1mAzf+zt19RrWc5fzDu
         BJgvFqnNQoPPc/z7GLdcG1jvdcl1psUyf110Q6+G38bpDwgzCYHi0z/pa+89+WUHWI5/
         8/ChWBpKFLwKl9wyBygpCKN+yZqnvUyuge6S+ETyFicfsqwlgbv8vx3SqJr6O2TOqLed
         dFP0OFGUm6XH+IUR/QCs6uyVI8v1RG9Nwq0TOjQxb2Q2BhNmXYsyBsTOGSdm4etVW8T7
         osfA==
X-Gm-Message-State: AOAM530gKzLb1k5netBIceK9Vi2I10S0Oz/R6/E3ixQ3CQHlh39UOshr
        fzXreCtQ8r6ncbiVEkDcqbZdJl4PngksEw==
X-Google-Smtp-Source: ABdhPJz0IQ67LWvMowwsLrG3GzOhHB8W7UB53OuC99VZrz82REWwsP8qKabiOVyFQZg4bQlRtpfC3Q==
X-Received: by 2002:a05:6830:150d:: with SMTP id k13mr14595529otp.26.1605043326987;
        Tue, 10 Nov 2020 13:22:06 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id f5sm22683otl.48.2020.11.10.13.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 13:22:06 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 14/26] completion: bash: change suffix check in __gitcomp
Date:   Tue, 10 Nov 2020 15:21:24 -0600
Message-Id: <20201110212136.870769-15-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201110212136.870769-1-felipe.contreras@gmail.com>
References: <20201110212136.870769-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We don't match the prefix, we shouldn't match the suffix either.

There are no functional changes since all the callers that add a suffix
add an =, and if $cur_ ended with that suffix, we would return
immediately.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 9f5dd4e3e7..829985e4fb 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -337,8 +337,8 @@ __gitcomp ()
 			fi
 			break
 		fi
-		c="$c${4-}"
 		if [[ $c == "$cur_"* ]]; then
+			c="$c${4-}"
 			case $c in
 			*=|*.) ;;
 			*) c="$c " ;;
-- 
2.29.2

