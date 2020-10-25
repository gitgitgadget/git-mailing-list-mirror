Return-Path: <SRS0=tbmj=EA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A02C55179
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1186020936
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtUMLths"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1766828AbgJYDNz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Oct 2020 23:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1766825AbgJYDNy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Oct 2020 23:13:54 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A02C0613D0
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:13:54 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id k68so5082444otk.10
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S2eDfVGUiyHpawzgftowHtF3fud9qQUOkFfKgPJeFGo=;
        b=WtUMLths/RwYN7fvwXfEfNmbohiYg4GyaRKSQedaTEMt1NokjccSO1GzxEs84Qo9jE
         lS8qnN/Xo8hNl+hq45rTS8nEWuriDjfFVV1yrLTHU876VV4YVERmeV4hW0FzNT8DY/YD
         lAyhYKxuCZgtKhyX5F/f+nDuLjNVqDyHfwlK77oeb5iQ4dRFspeFd0oeaCLz8g5iuKK5
         J8C8uL0sWgRAirpfxQ+PGbdpEqecJHKnTR1j3QFfYcfVOfPI8WNuVCJFfjr4V/VQ/FGu
         SnlYxOdsMQcGtxo3/Q3l2PiXYTwXj0mJscW65MAVYLiT18uxiQkUiyJO8py0TX3npkhs
         ZCvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S2eDfVGUiyHpawzgftowHtF3fud9qQUOkFfKgPJeFGo=;
        b=m5EAjYuHN93nuALIVDxoiiZDtk+Q2MVYngbQfORztIZbbzmwyCtSUeA3JhrzlPb4y8
         tthaO+uDIo9fbUxhb7bKcHawqR1uTVUcoVhUiKiSkSFvKC5kB6f2v/yjOcOjUc1rPeqQ
         VX013MN15JV8w2uTgbUzgEA1ItD3miZaF9TdOrBqYTx1V5TsFrXeRHATwD19laPafz8g
         bRjzH2SmVC67Z95BNMl8OQx0GOJHOA7WNNhfKvYIi6qS1wqpe5QLsebyxXGypcxp+Nwp
         TCOmvo8coA2qU9YB7NuQ+6z8iDXvrOg3G7qIgEiJvXBl9usuOTv2bF7OZYhpOAUR6vAG
         zztQ==
X-Gm-Message-State: AOAM531qnmBbaYAKklRSWyIPgIlGZyjU1Gn9CZh54d3i+c9j0EkYxvhW
        XU6az4v7jPkXv+o+7dZEjGM0Ys4MMc65MA==
X-Google-Smtp-Source: ABdhPJwixGS8Kz36bfCZ8IJV3fhS2MrfJP2uOOTXTULgomvdhH5CQO1u3Nk6zn6Zn8h/MZwjdGOxEg==
X-Received: by 2002:a9d:6e15:: with SMTP id e21mr8819488otr.139.1603595633579;
        Sat, 24 Oct 2020 20:13:53 -0700 (PDT)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id u1sm1744162ooj.28.2020.10.24.20.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2020 20:13:53 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 05/29] completion: zsh: fix for directories with spaces
Date:   Sat, 24 Oct 2020 22:13:19 -0500
Message-Id: <20201025031343.346913-6-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201025031343.346913-1-felipe.contreras@gmail.com>
References: <20201025031343.346913-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 05ccaac194..5d6740c6ff 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -35,7 +35,7 @@ if [ -z "$script" ]; then
 	local -a locations
 	local e
 	locations=(
-		$(dirname ${funcsourcetrace[1]%:*})/git-completion.bash
+		"$(dirname ${funcsourcetrace[1]%:*})"/git-completion.bash
 		'/etc/bash_completion.d/git' # fedora, old debian
 		'/usr/share/bash-completion/completions/git' # arch, ubuntu, new debian
 		'/usr/share/bash-completion/git' # gentoo
-- 
2.29.0

