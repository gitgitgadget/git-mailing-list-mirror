Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02574C7EE23
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 12:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235903AbjFLMy1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 08:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235914AbjFLMxU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 08:53:20 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A602E7C
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 05:53:12 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f6d38a140bso31654055e9.1
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 05:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686574390; x=1689166390;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icmOegVGKbOh0P8m6bXToPWg2ZvsGRKdZQqlcgh5YwI=;
        b=OgLri0pVbkN3UpMW2CN95ff2B6ijGmlTt/0welN+dJYsyASk88HVk3Jgej0WIEGH6P
         wDatvuSdfOu2okzveCmPfkLYc+St17zxN5NNznmfPo7BcLPVA/8bkglJUtdpW11HA8NR
         czjIB9QtOO6c68fxYwse4ydduhnGdqE7zFLC9Q43oASQIjnKuyRgdWW32nV6DrUQ6Tyg
         0wrFq//JMQkLmX7h7XoCnTuR2LVqltALO/xgPV9SFKTFGJmf5rXVwceYBjGmVcZD9mii
         DImyS8zz7QiMWNL0Le+nC4WyhO1csX8FDP/ZgcLJohe3USdRCRKsXA6V9H0v15ZEqjwr
         cPnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686574390; x=1689166390;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=icmOegVGKbOh0P8m6bXToPWg2ZvsGRKdZQqlcgh5YwI=;
        b=jhCN5FAwsPzXA/fTibcvuzH82b83Qe9JVImDkGGsJfjQiAbyUhgtvQiMkphEaZh9Bf
         bkV3zcuKKGbvxS6zix3lusyXgKsp7xaY6++ob+pGnfgU8PE3rrKV+d1f9kRR1kQuSNcc
         yZQisQTRtD5r8pp6vM9w9h4kzMuG2odUsvrElglF2oq8FLi3qy73gRvZJTKiM6sNDZhO
         lfc7HDD/knCx5VqRjLxXmDo3SuHjA9dq6zgO3uOYGVUykQiAhRlKIzpQeynFV2aiLBt0
         g0YJyuJRqw8+FWcuem3z61F7PXzQRjRC9kebAzxsXey2TNset9NIrngLf+LnXjDfaJZl
         vyhA==
X-Gm-Message-State: AC+VfDz6zZdKN3sJga/SUwMFM9gXOFjdCwNbA7BKBAqEK/Qu2huRmNig
        cqf7dQ8968npVU+6SaTATM0cHvhHc3w=
X-Google-Smtp-Source: ACHHUZ7jpwOrhQZuTtJix2xK4Se3x9GHPU93LvNp1/U4k5GsJau/5lPmY6ASZaO5oqcvv2aX6FuDow==
X-Received: by 2002:a1c:7204:0:b0:3f6:d90:3db with SMTP id n4-20020a1c7204000000b003f60d9003dbmr7291238wmc.3.1686574390238;
        Mon, 12 Jun 2023 05:53:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x22-20020a05600c21d600b003f70a7b4537sm11387204wmj.36.2023.06.12.05.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 05:53:09 -0700 (PDT)
Message-Id: <f8d430639bcec85d822747aec161f1069255c10b.1686574374.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
References: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
        <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Jun 2023 12:52:46 +0000
Subject: [PATCH v2 18/25] completion: complete
 --output-indicator-{context,new,old}
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
 contrib/completion/git-completion.bash | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index a34432796bf..a69421cd740 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1759,7 +1759,8 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--patch --no-patch --cc --combined-all-paths
 			--anchored= --compact-summary --ignore-matching-lines=
 			--irreversible-delete --line-prefix --no-stat
-			--output=
+			--output= --output-indicator-context=
+			--output-indicator-new= --output-indicator-old=
 "
 
 # Options for diff/difftool
-- 
gitgitgadget

