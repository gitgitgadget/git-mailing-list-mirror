Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F5BC38159
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 05:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjATFKI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 00:10:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbjATFJw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 00:09:52 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3752AD37
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 20:57:18 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id f25-20020a1c6a19000000b003da221fbf48so2814467wmc.1
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 20:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tCKd0+B56Cr5VOislpSoW8x2Zf/bawBtbrkY6KkWVVI=;
        b=T2+7YUeN0EaBhawavYSN72XkAwCi2+XoDGslVQ7ct1hYSwHe/uOMJqWD+kZmMayqzp
         GRoc3OcumXEPHWpDIcoBx66DOBJXdl8p90Hs+MPq2/4UiWcN/5Se9EvDQ+nJWuFfyB6S
         7aCos9IM3LqQOZGSNXgWANH1wnhy0LyUHvRt7ewBMhPtXPhQQaSfsX1hFlg8ZBKVHg/B
         bzYMmWtxkFzGi5f73h+mMxtIqVjMZGsrqt19zB3eaCDe6mVTvKHEiF0PhAv4V3bCkeDI
         Gcc0feuI1Q/H4UYPnC72R0LkeruwIN5n/erqXTyv7pnb75AVaJBE0oqSaAgpoNIMD60c
         SgAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tCKd0+B56Cr5VOislpSoW8x2Zf/bawBtbrkY6KkWVVI=;
        b=n7fEuDwzE5wxCgJHMM1ibpg2GMN3FGewPz5rlYH8oatl2KisahQYg2vaBPrH6tFi0/
         nrypcyGjjj3oBI+3lDpnqVv7vWBQNqv5ZuCnqymDVAKWkOU/jXwR5ZBxjloyaGvi8YlN
         x9YeXpgWHa20P2qiys95ClaILAUCFq+31G6pd51kOcik/om9fq0plzMO/Nsi0DNqJ2aB
         OysPrjH1W20J0znhG0yC+U90aSpvbHINfO3nC0ORKi0OOz6N6/tKXkAwWT96DngVSUxs
         fo8rijUba0WN0jm+cDHvNKDpnSOprw6Eex5DtTwxQvI2wydaP+WcA8MbcRKUsr0uWZ58
         OHbw==
X-Gm-Message-State: AFqh2krVpCC8D+cO0Uzt6aAx69v+D9ww1jZdWRPWq/jxJ+OzK5POjwV7
        LvHnnDNGQo6o2+RSTZ45nXus07ITRZw=
X-Google-Smtp-Source: AMrXdXulD8e90t3Wwz6q1e9+7z338MSS9DvPOBLWITn7/P8Se0Mm0N7aePYGTXgvFNf2vPD8DXR3vw==
X-Received: by 2002:a05:600c:1c9d:b0:3da:db4:6105 with SMTP id k29-20020a05600c1c9d00b003da0db46105mr12724921wms.37.1674190575644;
        Thu, 19 Jan 2023 20:56:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r6-20020a05600c458600b003da286f8332sm1066228wmo.18.2023.01.19.20.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 20:56:15 -0800 (PST)
Message-Id: <pull.1466.v2.git.1674190573.gitgitgadget@gmail.com>
In-Reply-To: <pull.1466.git.1674106587550.gitgitgadget@gmail.com>
References: <pull.1466.git.1674106587550.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 Jan 2023 04:56:11 +0000
Subject: [PATCH v2 0/2] rebase: mark --update-refs as requiring the merge backend
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--update-refs is built in terms of the sequencer, which requires the merge
backend. It was already marked as incompatible with the apply backend in the
git-rebase manual, but the code didn't check for this incompatibility and
warn the user. Check and warn now.

While at it, fix a typo in t3422...and fix some misleading wording (all
useful options other than --whitespace=fix have long since been implemented
in the merge backend).

Changes since v1:

 * Add a patch nuking the -C option to rebase (fixes confusion around the
   comment in t3422 and acknowledges the fact that the option is totally and
   utterly useless and always has been. It literally never affects the
   results of a rebase.)

Signed-off-by: Elijah Newren newren@gmail.com

Elijah Newren (2):
  rebase: remove completely useless -C option
  rebase: mark --update-refs as requiring the merge backend

 Documentation/git-rebase.txt           |  9 ---------
 builtin/rebase.c                       | 12 ++++--------
 t/t3406-rebase-message.sh              |  7 -------
 t/t3422-rebase-incompatible-options.sh | 16 ++++++++++------
 4 files changed, 14 insertions(+), 30 deletions(-)


base-commit: 2b4f5a4e4bb102ac8d967cea653ed753b608193c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1466%2Fnewren%2Frebase-update-refs-imply-merge-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1466/newren/rebase-update-refs-imply-merge-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1466

Range-diff vs v1:

 -:  ----------- > 1:  a0f8f5fac1c rebase: remove completely useless -C option
 1:  f7459f0996b = 2:  2e44d0b7e57 rebase: mark --update-refs as requiring the merge backend

-- 
gitgitgadget
