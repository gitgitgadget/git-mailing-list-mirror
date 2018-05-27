Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17C711F42D
	for <e@80x24.org>; Sun, 27 May 2018 18:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032874AbeE0S2K (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 May 2018 14:28:10 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54873 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751425AbeE0S2J (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 May 2018 14:28:09 -0400
Received: by mail-wm0-f67.google.com with SMTP id f6-v6so26532798wmc.4
        for <git@vger.kernel.org>; Sun, 27 May 2018 11:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9HMXQKDGQeFuDevU9mlSqfh25GPTithy1m97uAMYZdg=;
        b=YkBil2vI6qHsyvWFVNoE916tl+QoALs1kn7ulHO1gLk/HLvLTMdgmtPMB/pLYwyMHL
         ViDdLquTrN14KRBjg4sxoLbkyAIAg1XKw6UMV4dBNuG4lOYpFLWhRhXR+Oaqv0EGmB/x
         c1+59a93MQa0hBmIiLfC5CjgLy2CybgJrYNomfR6gh8o5yHB4lxXOinn1H0aGpHsnM2K
         t6FBiC7EIf+05uuSIq9mKLZXqsZWSNEolzjeIzmtri8QpDZaoAplkIprjU7HccFgnLDa
         DGm10xPWb61VXmq8WFUUQWr0LjK1PTB6VifdWzJxta6zJD+AiwUNeYJWPEBGIs5dosKC
         a/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9HMXQKDGQeFuDevU9mlSqfh25GPTithy1m97uAMYZdg=;
        b=pzy+8dEkWNHL0zOKDZ3miVh+q7EvykVhRh/lizn6nyQu6j2NUvhQaoIBEny6/r02Yc
         xVE6EAkiXfufkJZvtbPYlWtarTeupQG/5B6yforAHsdJAc6mq0900H+2eqtfOHPMRU3e
         FleP3sm1YWZEzS7FXD2+gMSVZ08YDMuMOz+IKpX0LIOtdqPi2gc+D62viLT7vdtfcqwA
         FeEhwKA3IJObfwT2TJmQZhlRxRmILoc+zfnsUkA4SoaCrmBLGhDT6U+vgxjOEBiTbp57
         PHDxIVRE6VpOCip6al8w4ROvKfBjVeUZoc+sdkYM1/I0Ko7jxSWt3uqQbaOsVjr2JeLn
         vu1g==
X-Gm-Message-State: ALKqPwfMNXcWaGTjlg9sB09CupJkGdb7ei6P/xCK0gs0tqnLjV9pcf4m
        /WCo0BbRy+0HvXnv2Am/pz51Ow==
X-Google-Smtp-Source: AB8JxZpS3ly61gqPSbgOSc1eoQzJf1rbDF77hHvOYEb8FhOWRbVRI7kyMqFce9oXWPygE54bMaaQsg==
X-Received: by 2002:a2e:1218:: with SMTP id t24-v6mr6658980lje.143.1527445688153;
        Sun, 27 May 2018 11:28:08 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id a11-v6sm128910lji.73.2018.05.27.11.28.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 May 2018 11:28:07 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v2 12/11] completion: complete general config vars in two steps
Date:   Sun, 27 May 2018 20:28:00 +0200
Message-Id: <20180527182800.25109-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180526135531.4516-12-pclouds@gmail.com>
References: <20180526135531.4516-12-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are 581 config variables as of now when you do "git config
<tab>" which can fill up a few screens and is not very helpful when
you have to look through columns of text to find what you want.

This patch instead shows you only first level when you do

    git config <tab>

There are 78 items, which use up 8 rows in my screen. Compared to
screens of text, it's pretty good. Once you have chosen you first
level, e.g. color:

    git config color.<tab>

will show you all color.*

This is not a new idea. branch.* and remote.* completion already does
this for second and third levels. For those variables, you'll need to
<tab> three times to get full variable name.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 I mentioned about this a while back in the --no-... completion RFC.
 It turns out not that hard to do, especially when branch.* and
 remote.* already kinda set a precedence.

 contrib/completion/git-completion.bash | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 2cbd14b346..ab026776df 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2314,9 +2314,14 @@ _git_config ()
 		__gitcomp "insteadOf pushInsteadOf" "$pfx" "$cur_"
 		return
 		;;
+	*.*)
+		__git_compute_config_vars
+		__gitcomp "$__git_config_vars"
+		;;
+	*)
+		__git_compute_config_vars
+		__gitcomp "$(echo "$__git_config_vars" | sed 's/\.[^ ]*/./g')"
 	esac
-	__git_compute_config_vars
-	__gitcomp "$__git_config_vars"
 }
 
 _git_remote ()
-- 
2.17.0.705.g3525833791

