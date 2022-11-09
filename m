Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFA3C433FE
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 14:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbiKIOY1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 09:24:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbiKIOYD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 09:24:03 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCD021838
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 06:22:02 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id t4so10907287wmj.5
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 06:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w9VU/ZWsgyYTdFaQX9gBvz5Tct6LHFpew8UtouAXQ8c=;
        b=IR/qJCbYtGjGa9zqOETG+I1oeCl2mBmxLPfS5j26yb1c7r/3zy7FCxVmF/Ycn3+Ti9
         Sk13BSjSRWqEeWj1JsJZDg3RysblqnbfgX5GZBExi3IJlwf3jLTVdwJ8/TCreYR4MNmb
         rZISvRd7dGs82xc6Dw0gqDq3Eb5GBU7ThtQcTv2fIy8JEr1fu1ZZklwkAqKnMBAsE8WV
         NM6WqXvg2HM2m5rUu9ch78LnamW8VpKyXCVV9dcJqyl2bNwSR9zpDvjVjW45q2f6R2zb
         y9th7buNkT3B1pxsyHIwYHeDiAKZ4VHpkd/nGrQKzIRMy51h9Nxd03rjJ/K99HKaOh73
         fT+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w9VU/ZWsgyYTdFaQX9gBvz5Tct6LHFpew8UtouAXQ8c=;
        b=d/TmYauKcijMmfA4bBNrhuirhvMxwWom/3F5NkHZ1HXtjmVg56+Ikru4kiDNc3QxDh
         ZkQCX1wbw7qXLWEevwPNNJNJXmNdY9sZjQnTnsVDDWQ3cnx4ukHOWcEA4hKNUcCqz6+Z
         KB+cFcb3ZeBXsZyFU8YpwJynH40/LaZVyCqQ6X25TBV4wT918IPzQHhTUK+hK//DxbxN
         hDWMMxe4qVuBXasf6tTZvtVXcACAoi9z7GSofle0ubpCoUIuNYvN4NMUxDwu6cBVJT5w
         3Ym1tv6/N/XfX9nYk4d4ZZUhkxeOjFJEk/PuWIX0WtB+dk2tcC+eX1Y3hdaNJpXICHpo
         MEYQ==
X-Gm-Message-State: ACrzQf0nCx4+pRyVulqyzzzi+3ahuwbaYiSwKeSJIAzK7dQzQXR7qMhd
        0cfEFreuWDORmoWXwMQ3xjOl2SFhUCU=
X-Google-Smtp-Source: AMsMyM5vPBl+oFDS9AkgKfkT0etUE9ZyMYtX4mqGjGFFVFfAvZSItF5+jUlDpKAPBnZ6WDvWCpdIaQ==
X-Received: by 2002:a05:600c:5563:b0:3cf:857e:18c0 with SMTP id ja3-20020a05600c556300b003cf857e18c0mr27596550wmb.24.1668003721285;
        Wed, 09 Nov 2022 06:22:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l15-20020a5d526f000000b002206203ed3dsm13309039wrc.29.2022.11.09.06.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 06:21:59 -0800 (PST)
Message-Id: <pull.1405.v2.git.1668003718.gitgitgadget@gmail.com>
In-Reply-To: <pull.1405.git.1667575142.gitgitgadget@gmail.com>
References: <pull.1405.git.1667575142.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Nov 2022 14:21:56 +0000
Subject: [PATCH v2 0/2] rebase: stop setting GIT_REFLOG_ACTION
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a follow up to pw/rebase-reflog-fixes that moves away from using
GIT_REFLOG_ACTION internally.

Thanks to Taylor & Ævar for their comments on V1. I've updated the commit
message of patch 1 as suggested by Taylor, the code is unchanged.

Phillip Wood (2):
  sequencer: stop exporting GIT_REFLOG_ACTION
  rebase: stop exporting GIT_REFLOG_ACTION

 builtin/rebase.c | 27 +++++++++++++++------------
 sequencer.c      | 45 +++++++++++++++++++++++++--------------------
 sequencer.h      |  6 ++++++
 3 files changed, 46 insertions(+), 32 deletions(-)


base-commit: 3b08839926fcc7cc48cf4c759737c1a71af430c1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1405%2Fphillipwood%2Fmore-rebase-reflog-fixes-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1405/phillipwood/more-rebase-reflog-fixes-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1405

Range-diff vs v1:

 1:  e9c3f5ac5c6 ! 1:  655b4e89f59 sequencer: stop exporting GIT_REFLOG_ACTION
     @@ Commit message
          pass the reflog action around in a variable and use it to set
          GIT_REFLOG_ACTION in the child environment when running "git commit".
      
     +    Within the sequencer GIT_REFLOG_ACTION is no longer set and is only read
     +    by sequencer_reflog_action(). It is still set by rebase before calling
     +    the sequencer, that will be addressed in the next commit. cherry-pick
     +    and revert are unaffected as they do not set GIT_REFLOG_ACTION before
     +    calling the sequencer.
     +
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
       ## sequencer.c ##
 2:  d3747bcc8d1 = 2:  31df037eafe rebase: stop exporting GIT_REFLOG_ACTION

-- 
gitgitgadget
