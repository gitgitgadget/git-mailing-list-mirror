Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CF7C636D3
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 10:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbjBAKJX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 05:09:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjBAKJW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 05:09:22 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0C45245
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 02:09:21 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id f47-20020a05600c492f00b003dc584a7b7eso940453wmp.3
        for <git@vger.kernel.org>; Wed, 01 Feb 2023 02:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XZrrdHlc8TNarfghujMEjC2jvl/JulnvGg5WqVH3NLU=;
        b=XsFFF97g/gdBWcPAbr3ZHYDctPtduSU5OUtVHIpeo++iflYoD/f8cszaKD7x2LLJ4f
         3o6Alk9qnYpVruvRUvZSTt78h4cViqlTyTvfFxKDKXknfJK0+prz+JUW8/bUbYL9GeIo
         2raUBqCHphj0eoLLagBHbHyea1jNC3HQgS7lk0u/AQ+Hk1P2/T2v9bJHCdxMx1+w8XwU
         mjPBTTh2tU7or+2VPR+7iRt5cl8eO6SyT7si9jmRg3QlxqnbUmBk4Tbgb7rrMf/jvq6t
         TQsnBhkpiUcVaA+UvUrLDU0SD3WR2NNpxt84rzBHeOiFKIZFbD3miXXAtenszWP8fBUA
         kzKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XZrrdHlc8TNarfghujMEjC2jvl/JulnvGg5WqVH3NLU=;
        b=YaDLclEGPfHjI/aejl+CQ5sPY+AoONEhJN+0BEdAWoxgPaA64qOyhoa7znG/fntbD3
         JRMI8Z+MgZyfFcASktiZpgDHmgfLXw/1NcugCHt6Oukv4pCVB6SGnUn5cw3AGOKawK9E
         rktdUIfY7H61iXJJGsX2qlPPpxsU0jyo+FG/SmGcvtZlqIW7TREvMp6UFA10TqNrzsCD
         javxXg4BMc9t+Ej2gXvd5WW81ExbwtGEU5M9f5M7Ro3lpuFJGvEoAM5K6zq4uakFl2mg
         Sc1GoQJpaktHFNLjUNzyEgUW/+qk2SuRQztErkBRisfQwkE0wShK/cFlGAUH7ekbKDz8
         2Njw==
X-Gm-Message-State: AO0yUKUNFyTq1okQwC5r1+Gv815eWR0JfKNBeXEbI9IF7pb1/m7gEWtv
        BINRnYQzjUghern2hGa0MN2Bc73UmXI=
X-Google-Smtp-Source: AK7set92N8t05xfHda+gEHCMS7Sz2coF4ZJw1ri5p6VbtV81zzx0CukutStE3euXLEChTLGu5WEkew==
X-Received: by 2002:a05:600c:4f07:b0:3da:fd06:a6f1 with SMTP id l7-20020a05600c4f0700b003dafd06a6f1mr1398249wmq.31.1675246159334;
        Wed, 01 Feb 2023 02:09:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t8-20020a5d6908000000b002bc7e5a1171sm17175873wru.116.2023.02.01.02.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 02:09:18 -0800 (PST)
Message-Id: <pull.1447.git.git.1675246158282.gitgitgadget@gmail.com>
From:   "Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Feb 2023 10:09:18 +0000
Subject: [PATCH] clean: flush after each line
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Orgad Shaneh <orgads@gmail.com>, Orgad Shaneh <orgads@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Orgad Shaneh <orgads@gmail.com>

Some platforms don't automatically flush after \n, and this causes delay
of the output, and also sometimes incomplete file names appear until the
next chunk is flushed.

Reported here: https://github.com/git-for-windows/git/issues/3706

Signed-off-by: Orgad Shaneh <orgads@gmail.com>
---
    clean: flush after each line

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1447%2Forgads%2Fclean-flush-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1447/orgads/clean-flush-v1
Pull-Request: https://github.com/git/git/pull/1447

 builtin/clean.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index b2701a28158..f3de8170f9a 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -270,8 +270,10 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 
 	if (!*dir_gone && !quiet) {
 		int i;
-		for (i = 0; i < dels.nr; i++)
+		for (i = 0; i < dels.nr; i++) {
 			printf(dry_run ?  _(msg_would_remove) : _(msg_remove), dels.items[i].string);
+			fflush(stdout);
+		}
 	}
 out:
 	strbuf_release(&realpath);
@@ -544,6 +546,7 @@ static int parse_choice(struct menu_stuff *menu_stuff,
 			clean_print_color(CLEAN_COLOR_ERROR);
 			printf(_("Huh (%s)?\n"), (*ptr)->buf);
 			clean_print_color(CLEAN_COLOR_RESET);
+			fflush(stdout);
 			continue;
 		}
 

base-commit: 2fc9e9ca3c7505bc60069f11e7ef09b1aeeee473
-- 
gitgitgadget
