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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DACC55ABD
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E9C4206F1
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNbTDZvx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731951AbgKJVWK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 16:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731912AbgKJVWJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 16:22:09 -0500
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E435C0613D3
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 13:22:09 -0800 (PST)
Received: by mail-oo1-xc44.google.com with SMTP id l20so3467993oot.3
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 13:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1Z5A+ReXvPAK1KMPYkePZvPxt9tNtBGjJsIazUNz07M=;
        b=nNbTDZvxc1zo3wIFILt4kxUwirTgLf7KhLUY9dYxdvP14YULJs9MrHXSzgcOSTLYOZ
         BdgdP3LxWPgpIWi3/7FDkbzK2WmBRiGhpjSmiW5krpx8mExFuMjcFKmxO2751ScB/YYc
         CFYWnkP/bmYpdgB/I2WDRiTZM+2GzTd4gxNpYWQr3LSuqHSjkxnwBft3LOahSW5bLrSw
         2Vxd63GQKr3+4JED/1zeEw9s1yxHfojbHxwdgMp986rwOTyE7CMcjlhuPgq91uMKSEjh
         Ath96UM8LNsFpy/H8vfWL+SXKIwp3c6WD+PtADlCBhAuMcr5KJvo5Q8OddlgI6Sk9cen
         OtdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1Z5A+ReXvPAK1KMPYkePZvPxt9tNtBGjJsIazUNz07M=;
        b=VL1vcXO/ZplxDEyyZmTRBeZs6N3qq6VFSOHy/3sWrZR2huuQWBf73WJEVQq673Lati
         e7hOHJGZja8yy57SRnFGwxufYn+aUkpok1k7tEsIb7e0ww71AD3o5qSY5gTOJaICGs3T
         4L8YIW6WSjLmf5qDhvHWco9Xp++mXqPmWtd16/uUS6DvEl1cJoY+bkblqRDvdm9ceW2z
         IdeEugxQpbLMknASTb93ow2tRWlwMusYBV5BjN//0jRhTlbKP8u9NEbleYhJP4IMgjTR
         a35K/2lYvZBkxM0gil5GDVoRnXv1RvDcc2c27No1B52/c38nqhHbJ3N08xoXJ1r2Ebdz
         HI2w==
X-Gm-Message-State: AOAM532SLIxebKaXD/ziwfu5P4kFnmzZv6xLVswcWl4UkqQ5F1AnuNdj
        vULf/AymwhiGhWOXKQDCMJ1R1JZv3RdK3w==
X-Google-Smtp-Source: ABdhPJyJFMUnlxVyWSzxYrMcz8vARuUvrnfHULTqWVZqnin2bCFCoRGuMLERwajbIiomnuXx1cKqQg==
X-Received: by 2002:a4a:1e43:: with SMTP id 64mr14802789ooq.57.1605043328806;
        Tue, 10 Nov 2020 13:22:08 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id 186sm40867ooe.20.2020.11.10.13.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 13:22:08 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 15/26] completion: bash: improve __gitcomp suffix code
Date:   Tue, 10 Nov 2020 15:21:25 -0600
Message-Id: <20201110212136.870769-16-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201110212136.870769-1-felipe.contreras@gmail.com>
References: <20201110212136.870769-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no point in adding a suffix after a suffix.

If a suffix is provided, we add it, if not, then the default heuristic
is used.

There's no functional change since most callers don't specify a suffix,
and the ones that do use an =, which by default doesn't add an
additional suffix.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 829985e4fb..594e41276e 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -325,7 +325,7 @@ __gitcomp ()
 		return
 	fi
 
-	local c i=0 IFS=$' \t\n'
+	local c i=0 IFS=$' \t\n' sfx
 	for c in $1; do
 		if [[ $c == "--" ]]; then
 			if [[ "$cur_" == --no-* ]]; then
@@ -338,12 +338,11 @@ __gitcomp ()
 			break
 		fi
 		if [[ $c == "$cur_"* ]]; then
-			c="$c${4-}"
 			case $c in
-			*=|*.) ;;
-			*) c="$c " ;;
+			*=|*.) sfx="" ;;
+			*) sfx=" " ;;
 			esac
-			COMPREPLY[i++]="${2-}$c"
+			COMPREPLY[i++]="${2-}$c${4:-$sfx}"
 		fi
 	done
 }
-- 
2.29.2

