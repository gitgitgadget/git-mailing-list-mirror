Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BEBC6FD1D
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 08:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjDAIqd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 04:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDAIqc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 04:46:32 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC3EEB73
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 01:46:31 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-17fcc07d6c4so11578202fac.8
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 01:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680338791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XfJghv4IwcBwZqf10lXzGVtOiySdrg8aI+L2KSpQUlE=;
        b=E9rQ32S/kxbg9juf+KViOO/WQaaupQo63trNhGh55BwY452kpvMhqoKLrndaiIdiAz
         nNB5B/mB80cUZE3dXFWC7nv8wnG4MmfpyWJ7IewbgDEiL+BGjAXdnLSnBzl3b6P8yzSm
         4NTQDroEkgCJBS2RCSl4a8MNeFwag/cJz1XQifQzFynLHIsms3K5g4tihfLs85XNchr8
         /9pFZDIKW3DS3UegH8tVsMMbE5Vt/p7RyOGVitFQkRIllWAOoTWPfx3ju+HDqUbZBv1H
         7bfwyFT9DOZPH0qkZPILQ6nXmmxsz40ka9Bx/CxDowKU6wUrLPaevtBR5+x2xODVcRdQ
         Pj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680338791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XfJghv4IwcBwZqf10lXzGVtOiySdrg8aI+L2KSpQUlE=;
        b=auep49mpum3Xo5qsaFFYdqRsExKtMPuPat7fGEuFihMAgs4qBNh/d37M55V+jlQeh8
         h3XrWDBH2btAyvcNaUOqnaBjPxyukYK3OR/rEdwi30lgfwYpI9lhsPGSRPyO/v/P+AG0
         1uRPoddI9N2ovJPmUNvD8on+JniY7Uix/iY9LnegnOvvj/N1Nx3bi9iuHm+gjukcvW/s
         f+9N0Jssb7AMxJkzI1Qj7Y2jFr9ZIeavo0U/ltxFalrtbOrqhketgNn27QvQ0x2tfy1K
         3fGjRy5W55htoxbNt86PagNiWPQmVZ5GcPoWpFrUkscKuN94/OXZ/L+2MEh6AG6tETq0
         Nqyg==
X-Gm-Message-State: AO0yUKVORaumQKzbX/PZJ+zuOwVXQMn3AV1Y91dv5iXYHoC1OApZZGjm
        OWtFj0nee1dxI1UtGMMqEEibnI823/c=
X-Google-Smtp-Source: AKy350aTdmXlwWnPtS9QWY+cbIrcb1e/PGJEelIA2Omwg5gHk7/pQNUQYEaYtnclS0VGjQyAEIldxA==
X-Received: by 2002:a05:6870:88aa:b0:177:b62d:cc1c with SMTP id m42-20020a05687088aa00b00177b62dcc1cmr18340199oam.0.1680338791061;
        Sat, 01 Apr 2023 01:46:31 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id vj12-20020a0568710e0c00b001762ce27f9asm1742679oab.23.2023.04.01.01.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 01:46:30 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 02/49] completion: bash: trivial cleanup
Date:   Sat,  1 Apr 2023 02:45:39 -0600
Message-Id: <20230401084626.304356-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230401084626.304356-1-felipe.contreras@gmail.com>
References: <20230401084626.304356-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index dc95c34cc8..45eaea57d5 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3565,8 +3565,7 @@ fi
 
 __git_func_wrap ()
 {
-	local cur words cword prev
-	local __git_cmd_idx=0
+	local cur words cword prev __git_cmd_idx=0
 	_get_comp_words_by_ref -n =: cur words cword prev
 	$1
 }
-- 
2.33.0

