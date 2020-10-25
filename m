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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8E6C4363A
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEEC320936
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzfPVZSe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1766899AbgJYDOd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Oct 2020 23:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1766885AbgJYDOZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Oct 2020 23:14:25 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06172C0613D2
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:14:21 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id f97so5112726otb.7
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SVig8LGObvIw1oRjICDoKkMEQS+1YfW803Mwgz++GCg=;
        b=ZzfPVZSeOE9Ub5qR4Ei1+I14itnXyTuoxtZgkWi0ldBNixBxSIOtWeVuWBJzAv+lzn
         qNnmCksYYUqx4BstiilfqxrCQvBHiWzKIMFElEYd3MJFpCR/3xKAut8hOSSDIne9sHGG
         Z3HHl4LbngRFJSVtU5UoFaKBv+8ETKkwXtYgmmRd5lAF7OZLeFNMl2r9XZ84Zl2JGzH8
         zHWoOuIrgt0aVRqPkLWvmG64GMrmn9R1aQrVpXjbotAtxoCBJRdK6CHgcrJUA7VdM3Q3
         5LepmplZ91qncTj5lqStVZXVbZheCSLs4isMQFDvbWxSBQ/hhnwGi/pcQ1IflRz5f9P4
         1hRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SVig8LGObvIw1oRjICDoKkMEQS+1YfW803Mwgz++GCg=;
        b=QTvoI+d3oFf1y76mn0C4Ag5LAy6U0mnmT6cIwpeiJxv/+4KYmOhHdG1TG2yWV/sSka
         O6eyefmqiTwTiC/6hidxqSBeDX/GqvwyEq3tub7C1Mq5nG0bm0v7ZUhMNNbSCuw5Iv6/
         qU3ELKdjvK7rTOaHvQshh6qWDSA94i7DqbttipAt01BFhVp5/k5g/faBUfRxqSV1utCH
         Nbt+xZNWqWF0jSljNYyY9zlW5+h5mdI5+QYUqh92JALfIWHS6vbA2yVGLuHN/A1Yr2LQ
         7yOL06Jbw1/VHgCBWoslzBllPdg0hslNEgcIzQ1lFbCItWfe3otQonJKfPwalwdEUNJX
         KnUg==
X-Gm-Message-State: AOAM530kk0QG5qHqrl2xsETUvPRbsS1wVPR2KgSvQ+4XIvUwHQrF/7Fl
        bRutNnDkt4G0T2mxUtYE6lifUyib46+X0A==
X-Google-Smtp-Source: ABdhPJytUz6E8z6bHZoCih3cbYboU36CgJ8AeujVYNFV+WAlFmxtueDmbyjYWbB2mq+DWBC8+p05wQ==
X-Received: by 2002:a05:6830:2389:: with SMTP id l9mr8709078ots.316.1603595660171;
        Sat, 24 Oct 2020 20:14:20 -0700 (PDT)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id d3sm1585510otb.24.2020.10.24.20.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2020 20:14:19 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 23/29] completion: zsh: add alias descriptions
Date:   Sat, 24 Oct 2020 22:13:37 -0500
Message-Id: <20201025031343.346913-24-felipe.contreras@gmail.com>
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
 contrib/completion/git-completion.zsh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 2016e8c1b7..d90eb6863b 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -189,8 +189,9 @@ __git_zsh_cmd_common ()
 __git_zsh_cmd_alias ()
 {
 	local -a list
-	list=(${${${(0)"$(git config -z --get-regexp '^alias\.')"}#alias.}%$'\n'*})
-	_describe -t alias-commands 'aliases' list $* && _ret=0
+	list=(${${(0)"$(git config -z --get-regexp '^alias\.*')"}#alias.})
+	list=(${(f)"$(printf "%s:alias for '%s'\n" ${(f@)list})"})
+	_describe -t alias-commands 'aliases' list && _ret=0
 }
 
 __git_zsh_cmd_all ()
-- 
2.29.0

