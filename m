Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18988C43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 14:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D11B3207FD
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 14:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlogbQzL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfLIO2q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 09:28:46 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33346 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfLIO2p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 09:28:45 -0500
Received: by mail-wr1-f66.google.com with SMTP id b6so16456864wrq.0
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 06:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6olwWSyIwA5UH7Ytv+hJScM4a0A6K4LpWHa/drFI5Ts=;
        b=dlogbQzLSmPqRECAnUemkhqhzU6eXU5jIb4Y4ae03BsHYTweSsSWpEA3Tv+2Ht6B+W
         ZwB5C7fa7xhLAM5ToqjpR4TGmxx4iWGYHgTYYvSXcTcgV+PKpQF0CKqCNJ7aetQ9V+TE
         jBPl1ItmyECPrkbBCGmRP0Bzp0zS/Yt8QjI4WrrHuzOHPPJvT+7ThMsXmjjtgILQwGYR
         GwzwdWzv6VoxifVDO7S6JZTsEsEDbJfUIksHodLUzhQ4XPoldRRmQPH79z8loAjBIIK8
         GfJ0UobX+cUGwoo28HafkPkgEpqEAcGTZXxBrgAot5LPpVAbXO2xoCrwpFYyDBhtMsqh
         W8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6olwWSyIwA5UH7Ytv+hJScM4a0A6K4LpWHa/drFI5Ts=;
        b=sD7hc78cr/LsTCFbg89GwJhxGEGsl7j8y+NIMHoj0jf592jkBQxp0t18MOljac8UFz
         Nu8DHUrSK3NtyQnceIxwmtPNJXlAySWkggW5/1bJt4UAddz3h0TiVBFwtDR+3ZY+te/j
         mcfSEiJc6r37JVm+uGQErnJRRU/gY7D92PTcLe4ni2NYK+YSvhGXEx7FKTRj2aKGXhiT
         kev1g0zpzdmdTpazhuGHw+7ur6AK8zUH/Jb2yO5WD54CVPQ/Emq4UJu+dD4TQF9ezc2F
         vvRc1KzLeBy87c7rLTomxrjcySOTVqQZDALUiQQwTJ2Ow2mO+dGskZJXQsg10HnHtinL
         p70w==
X-Gm-Message-State: APjAAAXPNAwK06aHYMRtBzWPQ9lfELVC52+XqHzH+CyoJNPWnoddciyb
        rzcKqei79ba52d35Dl5j2KRRBd4V
X-Google-Smtp-Source: APXvYqzV2x2u9Em8cA8TC5wObAY5HWypWRiOND3S5CH/Ryfpctx5tubT8elU4+NZObTNuxNlo6EfNw==
X-Received: by 2002:adf:dd52:: with SMTP id u18mr2455785wrm.131.1575901723061;
        Mon, 09 Dec 2019 06:28:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u8sm12050971wmm.15.2019.12.09.06.28.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Dec 2019 06:28:42 -0800 (PST)
Message-Id: <pull.483.v2.git.1575901722.gitgitgadget@gmail.com>
In-Reply-To: <pull.483.git.1575466209.gitgitgadget@gmail.com>
References: <pull.483.git.1575466209.gitgitgadget@gmail.com>
From:   "r.burenkov via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 09 Dec 2019 14:28:41 +0000
Subject: [PATCH v2 0/1] git-p4: use lfs.storage instead of local .git/lfs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use lfs.storage if it defined in git.config. If lfs.storage not define -
used local .git/lfs.

Original code uses local .git/lfs in sync/clone operations, but if you have
external lfs storage better to use it.

panzercheg (1):
  "git lfs" allows users to specify the custom storage location by
    configuration variable lfs.storage, but when "git p4" interacts with
    GitLFS pointers, it always used the hardcoded default that is the
    .git/lfs/ directory, without paying attention to the configuration.

 git-p4.py | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)


base-commit: d9f6f3b6195a0ca35642561e530798ad1469bd41
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-483%2Fpanzercheg%2Fgit-p4-improve-lfs-logic-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-483/panzercheg/git-p4-improve-lfs-logic-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/483

Range-diff vs v1:

 1:  73d0dfc9dd ! 1:  e65375c528 git-p4: use lfs.storage instead of local .git/lfs Use lfs.storage if it defined in git.config. If lfs.storage not define - used local .git/lfs. Original code uses local .git/lfs in sync/clone operations, but if you have external lfs storage better to use it.
     @@ -1,10 +1,13 @@
      Author: panzercheg <panzercheg@gmail.com>
      
     -    git-p4: use lfs.storage instead of local .git/lfs
     -    Use lfs.storage if it defined in git.config.
     -    If lfs.storage not define - used local .git/lfs.
     -    Original code uses local .git/lfs in sync/clone operations,
     -    but if you have external lfs storage better to use it.
     +    "git lfs" allows users to specify the custom storage location by
     +    configuration variable lfs.storage, but when "git p4" interacts
     +    with GitLFS pointers, it always used the hardcoded default that
     +    is the .git/lfs/ directory, without paying attention to the
     +    configuration.
     +
     +    Use the value configured in lfs.storage, if exists, as all the
     +    "git" operations do, for consistency.
      
          Signed-off-by: r.burenkov <panzercheg@gmail.com>
      
     @@ -16,9 +19,11 @@
       
               oid = re.search(r'^oid \w+:(\w+)', pointerFile, re.MULTILINE).group(1)
      +        # if someone use external lfs.storage ( not in local repo git )
     -+        lfs_path = os.path.join(os.getcwd(), '.git', 'lfs')
     -+        if gitConfig('lfs.storage'):
     -+            lfs_path = gitConfig('lfs.storage')
     ++        lfs_path = gitConfig('lfs.storage')
     ++        if not lfs_path:
     ++            lfs_path = 'lfs'
     ++        if not os.path.isabs(lfs_path):
     ++            lfs_path = os.path.join(os.getcwd(), '.git', lfs_path)
               localLargeFile = os.path.join(
      -            os.getcwd(),
      -            '.git', 'lfs', 'objects', oid[:2], oid[2:4],

-- 
gitgitgadget
