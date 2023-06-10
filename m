Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B25FC7EE29
	for <git@archiver.kernel.org>; Sat, 10 Jun 2023 20:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjFJUWP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jun 2023 16:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbjFJUVq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2023 16:21:46 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4FB3AA7
        for <git@vger.kernel.org>; Sat, 10 Jun 2023 13:21:40 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-30c4c1fd511so2677421f8f.1
        for <git@vger.kernel.org>; Sat, 10 Jun 2023 13:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686428498; x=1689020498;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icmOegVGKbOh0P8m6bXToPWg2ZvsGRKdZQqlcgh5YwI=;
        b=sIwrXrlWvp3l7eVg6KlkvzkpBVZ0PMIrzKB9pMdk4r82TL1SsUCoc+NHYModRmrcKO
         J+2heRAi+CzKI4n7Roj+adlhBrPNdzxyni5lw1/GBdKYYzMFAD2uLCPN7jH+OSBI7Pir
         WthbqqGlH98fwVTm+ESDI5E+YO86a5aBBp3BMuy9hTYZytpf7X3CUGoPKKVlihDJ+foY
         wlxFL2CZIDISZdUqaw+5d+IVlQScDOzZR0tb2/gmw4VwD6k0M+jJkXLwZ53z8d9216nE
         Gqpo259cKs529zkaHLinpT9coaHjKqe/XuSWBqe8scF8zpu92D9No9xrpPBz4JLncnT9
         enOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686428498; x=1689020498;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=icmOegVGKbOh0P8m6bXToPWg2ZvsGRKdZQqlcgh5YwI=;
        b=J85AomPUaidXCk4WGxTfJDEL4GPpB4EQkqvp7eNhfeEMsx1qslAM7nCCHQ35L6iYFX
         Kf2dc6GEKpAIYqDyfr4r3ZhLJb42m5bp+qJCkDtt8zatnTDJxj90Zu5Gxx9os2qwP78L
         WRqS6Mpa0gD9P4qPpkqOrRmKF5Z4igu49hB4gslgkle4BuBpDShTWlaRcPcooW6s0MdN
         zJq3eeIzMLKq1DF9a3DXL+JW+aLQWMAk9vgNyFZmo7okq7erRErqvA4WPjyv6DSod399
         HSZU8FZCkTMkaymfuQpp0W4G5CfoCVKVh02ndoqiAkTd2y+v94csQpqQKQjiI+Bj3cw7
         X/7A==
X-Gm-Message-State: AC+VfDyqFCjmAxc6kRd9mqwBqSByAEkF+htjgr8O6YBHz80lWBPMnMGj
        pOm6944BadCsGp6Clxv3F6GzpF31kFY=
X-Google-Smtp-Source: ACHHUZ4YnR/yOT47k35yE12BN6rbzVEj4RkqF4Nsx7/++dA4zoyEpMU+dtUKKDLW8w1NZscrRH76jQ==
X-Received: by 2002:a5d:53cc:0:b0:30f:b341:79ef with SMTP id a12-20020a5d53cc000000b0030fb34179efmr1386450wrw.71.1686428498535;
        Sat, 10 Jun 2023 13:21:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g9-20020a7bc4c9000000b003f7f249e7dfsm6677814wmk.4.2023.06.10.13.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 13:21:38 -0700 (PDT)
Message-Id: <f8d430639bcec85d822747aec161f1069255c10b.1686428485.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
References: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 10 Jun 2023 20:21:17 +0000
Subject: [PATCH 18/25] completion: complete
 --output-indicator-{context,new,old}
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
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

