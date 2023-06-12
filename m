Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7AB8C7EE23
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 12:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236183AbjFLMxk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 08:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235757AbjFLMxR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 08:53:17 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BBFE67
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 05:53:04 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f7f6341bf9so43090635e9.1
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 05:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686574382; x=1689166382;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ztzLL4KgmrtUPgRMDMXzL1umxszvJ1+RIMd9x/Qs+L8=;
        b=WKLjwJTtwdh/Hr5jdI5YfBNdnuMm8ObFJLzVsIOeVjRTvSGRoT6JjM+ZyecZv8rIwW
         hH2hD/ZTo6CxERaBfvAJrUn8UFmZYolwuyLg7lkNuSkleU1FqcDui8upmjUVeJsWj/BK
         b/biITJVgCZhxRIijGQIofECcQhdQqrh4QwcGOXyCECGunowyF/OQ5awoz+It2fHRsj4
         dkQwGNyP08rNHc6B0f7SvwY8OVnZK8CSV9/i4x/0reXsZG9ciIDm/XNPgv3jxXZ1HlkY
         yxCzS8qtvmbC6absdrk/0pj9Y1j/dDnujlmpzIKzRUxcROxhAKT4btYxqcHMLEVYrEoj
         DtHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686574382; x=1689166382;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ztzLL4KgmrtUPgRMDMXzL1umxszvJ1+RIMd9x/Qs+L8=;
        b=OitPJj4ge/4Ysqfq/ymEz2YZA+KlZplYTNplCsvuOb8OAruuPbbQeBfzscQmr3RBhk
         cA7tn4pfTkqHcsSU0z0QaJtQ6zdJNgrcKJ8qKzlEYueGEOC6XPxrIs/3s7ai+vEw03iL
         n3zRwweI+ybL9iXXEtQ5uJrBZhVvHQVMZ5+mwF2pCHsk6KBZeZaaPXmKmGisCH1h5aHm
         2lUc64LViSFBjHKaainBTbRo06WvC6x0M5ycMbhtHpuUwgm0zMpgXbbSFYU4v+8kRmz/
         O/fY/EaMCgkgU9+w6R9tlDwAMiftQzIGspfnQx8Q+ru84HAhWA6rX+QI1lBddTkzrqac
         jEqA==
X-Gm-Message-State: AC+VfDxktJC+d6tIn5MSaomguGZCa08JvCg55RusIbOewd+XFqSCMKAE
        Bu4aXawo27iLwugXnrEioQXrDO4uNqo=
X-Google-Smtp-Source: ACHHUZ5Soh3y6kQbhT7Btdpee6SSy1mCpruDpiY2jn0V/AYpqhHXnzlNmVwLlQTD7jCObPXhPThrzw==
X-Received: by 2002:a7b:c84c:0:b0:3f6:76e:604b with SMTP id c12-20020a7bc84c000000b003f6076e604bmr7099744wml.0.1686574382408;
        Mon, 12 Jun 2023 05:53:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p18-20020a05600c205200b003f74eb308fasm11303166wmg.48.2023.06.12.05.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 05:53:01 -0700 (PDT)
Message-Id: <53b1c348f822ca32228cdb0f40b03c9ae9ec59c8.1686574374.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
References: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
        <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Jun 2023 12:52:36 +0000
Subject: [PATCH v2 08/25] completion: complete --find-object
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index dd6e12ad8f6..392fdbedd9f 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1740,7 +1740,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--color-moved --color-moved= --no-color-moved
 			--color-moved-ws= --no-color-moved-ws
 			--full-index --binary --abbrev --diff-filter=
-			--find-copies
+			--find-copies --find-object
 			--find-copies-harder --ignore-cr-at-eol
 			--text --ignore-space-at-eol --ignore-space-change
 			--ignore-all-space --ignore-blank-lines --exit-code
-- 
gitgitgadget

