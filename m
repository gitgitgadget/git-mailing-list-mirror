Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86EBC4363A
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 00:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7991F20790
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 00:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGCO8OUq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729319AbgJ2AeG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 20:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728515AbgJ2AeF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 20:34:05 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10179C0613CF
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 17:34:05 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id a12so717218ybg.9
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 17:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9JnY+ffYpgMJwnKFB1jFqfH1MtJgwwd9mufms2ZlSyA=;
        b=OGCO8OUqv3N9c3Ym1PywfOof5LFfFRswOiAoKHlQEfsAWv9WPa+oANvhqamVNdolXd
         XXupqFUE3JJxNR6zV/fN9+vJXbBGnC1fos+ATZIt0sHxWOaM2ev3zObkzm4pfLFYpIuh
         0aEqaPFFkLrRaFFoufW0iWFqf+Z1HZtPbwUkjyN3QsgALaYNhwlohEcpIBmdt8FYAA+B
         5PE2IMQfWuoxgwZBKDSyFe8eOxDIii5Zf6r1id3itJr5Lc/nqv9M3E1rqVyDWTfo+rb8
         BssPBFUYSWvvtC6+acY61VGrjiFtJTwbJOMkVp91LVCmzWm4wP8g7U+knX/NdR1zWt1B
         I8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9JnY+ffYpgMJwnKFB1jFqfH1MtJgwwd9mufms2ZlSyA=;
        b=a0g/JUsLgCUKFxRw+to1cUSYHZdPoxT8vmIwQljpnK/UhKCAU5zwNfbYuL3Ip2gLM3
         6tPMOE1Bwca8cxtt3obcL22qEnOivmfxfttAcPVtogKR/z0aFZ0DBZXw+nnw2eumVJpD
         9QkxgKjr71dajF6Sy4PvAjDGf0Z0IBAqHHhJr2WeNzn0lVu4ks6CHGVQkiYLV/YMox9t
         ttIQyEYe7t7yaQLYHN5wuo/J9D0aIsRUY+M89pNXrIA0VwNdRCd4qluJ1nEvygfy9nnx
         nriO5vznTev78yvjX2HOiQ0LnPXrSeeYVgPuMs6uqK4LW1LVL6yCp4Gdx+MgPFozzqdr
         yJzQ==
X-Gm-Message-State: AOAM532RN64XqY9XcbKsZ5H+tXPE1Vi3Yoab9893La1UvTH/UKJTaM1W
        V2TkBRjYHWoUab1ruxoQfICVcxcmJGB3wG12
X-Google-Smtp-Source: ABdhPJze/dhLok66p2vXSyGdG7FiRHlyjVRCrthX+BeGR+BBjBgv4euNkb4hoCLVDG8kS5khlMuALQ==
X-Received: by 2002:a9d:eca:: with SMTP id 68mr3391872otj.141.1603850842903;
        Tue, 27 Oct 2020 19:07:22 -0700 (PDT)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id 4sm2136056oij.40.2020.10.27.19.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 19:07:22 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 05/29] completion: zsh: fix for directories with spaces
Date:   Tue, 27 Oct 2020 20:06:48 -0600
Message-Id: <20201028020712.442623-6-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201028020712.442623-1-felipe.contreras@gmail.com>
References: <20201028020712.442623-1-felipe.contreras@gmail.com>
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
2.29.1

