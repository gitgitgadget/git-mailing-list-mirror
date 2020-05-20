Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29337C433E0
	for <git@archiver.kernel.org>; Wed, 20 May 2020 03:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E33A620748
	for <git@archiver.kernel.org>; Wed, 20 May 2020 03:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MoZG6MQZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbgETDpJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 May 2020 23:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbgETDpI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 May 2020 23:45:08 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7784BC061A0E
        for <git@vger.kernel.org>; Tue, 19 May 2020 20:45:07 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id nu7so629974pjb.0
        for <git@vger.kernel.org>; Tue, 19 May 2020 20:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=stCIMIQtDEbS0qJRJ8o9zPYiCRHfGRlEK97As9KUZnw=;
        b=MoZG6MQZw/q0/Wij20PUSUhYBbMg7PVK8iu2VOSpwgjqf6RAwR73SCJQZX0ioN1Vm1
         pyzARl69AqMS2vOU0Id5sBPqwCwfhMTBSCNHFEpTEnn7GlfyWmUhEyvXo/Fy5ODo+5pK
         Er3YA/VBIQMc5f59cPDmi4J9eUEJ1U/uz14ZnVIljnIh3vAQrkpoj+dwqD0i0Hb8lGPu
         u//jti2M4xE9TkiKswEOB2BFoUNDJJa1+gYSFRHlnrkkBKlJOi1sgeiKlU1+owT8nU0O
         KoaRyg6Ml0rRvDwbDO0A+MNIxXiJFYWliHqoHmDVippVG2ExS6l6TaHHBYQjVkHLPVQF
         /xOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=stCIMIQtDEbS0qJRJ8o9zPYiCRHfGRlEK97As9KUZnw=;
        b=lLOGv4M7Mrt+81PxlfB40cOzUPc6K7/WBJFXAcTzUWhQoXPvofcmbPzhI/eNiOO7fn
         82SHUIQ928nMxDUu9Y6whPm2vV0xlq8gR33KN+OHY9+vBPMth4KfHQiI8sLQJalu3K3p
         dZ/G7W9Jo+H3rCvajYi4mh/eLKJhahyE6TAszLR2kvkOUa/rJDLPVLVt2n7knv3pgJ2O
         NcP4p1yNN9SJXplE9y6sXoPMQ2psFEYEgGZ7ZtRF4ol3LnR9ISlYPKUuPUeeRMxWdLYs
         ZzAVJ1KoR5UFYEVkZFIu1e3A0Cxlr2pnXM+fFdraazC31ublbtwH5oZIx1plHqQ60Psi
         sE4w==
X-Gm-Message-State: AOAM5315Rn0bZ5W7z+MRa7mQT22tzPd/JIp01jTPpeIVU0y12X8pLn/l
        4DB+Qe09ve59fPNR9Kva6e7M0Bkg
X-Google-Smtp-Source: ABdhPJy6eLGC8ScHJA8BnwYrkHn7APsHaXVBveA4qHRmCoE7xtNhhw7WIyqVjPGkojFaj9373dfouQ==
X-Received: by 2002:a17:90b:897:: with SMTP id bj23mr3020165pjb.82.1589946306690;
        Tue, 19 May 2020 20:45:06 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id h4sm762820pfo.3.2020.05.19.20.45.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 May 2020 20:45:06 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     liu.denton@gmail.com, chwarr@microsoft.com,
        garima.singh@microsoft.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 2/3] bisect: remove CR characters from revision in replay
Date:   Tue, 19 May 2020 20:44:43 -0700
Message-Id: <20200520034444.47932-3-carenas@gmail.com>
X-Mailer: git-send-email 2.27.0.rc0.187.gede8c892b8
In-Reply-To: <20200520034444.47932-1-carenas@gmail.com>
References: <20200520034444.47932-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

6c722cbe5a (bisect: allow CRLF line endings in "git bisect replay"
input, 2020-05-07) includes CR as a field separator, but doesn't
account for it being included in the last field, breaking when
running at least under OpenBSD 6.7's sh.

Read the revision into a raw variable and strip it of any possible
embeded CR characters, before use.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 git-bisect.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 71b367a944..8cd6095a71 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -210,14 +210,15 @@ bisect_replay () {
 	test -r "$file" || die "$(eval_gettext "cannot read \$file for replaying")"
 	git bisect--helper --bisect-reset || exit
 	oIFS="$IFS" IFS="$IFS$(printf '\015')"
-	while read git bisect command rev
+	while read git bisect command rawrev
 	do
 		test "$git $bisect" = "git bisect" || test "$git" = "git-bisect" || continue
 		if test "$git" = "git-bisect"
 		then
-			rev="$command"
+			rawrev="$command"
 			command="$bisect"
 		fi
+		rev=$(echo $rawrev | tr -d '\015')
 		get_terms
 		git bisect--helper --check-and-set-terms "$command" "$TERM_GOOD" "$TERM_BAD" || exit
 		get_terms
-- 
2.27.0.rc0.187.gede8c892b8

