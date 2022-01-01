Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F047EC433EF
	for <git@archiver.kernel.org>; Sat,  1 Jan 2022 14:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbiAAOBZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Jan 2022 09:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiAAOBY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jan 2022 09:01:24 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FE6C061574
        for <git@vger.kernel.org>; Sat,  1 Jan 2022 06:01:24 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 2so26052823pgb.12
        for <git@vger.kernel.org>; Sat, 01 Jan 2022 06:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UPPlerw+Ij73r1zyZz/VpYVo7uhD+qoPOr1r0d8ErCA=;
        b=kh7kXFx2BVTYfPxQpy8zTWfVpDctexHFwFpVD+ka/jMnARHC71dUO7tGLW2uI8FMIR
         ueJUtepBAviyO8NnSCs65TqPaNvDpMz4jKBiBfCwLvuYT/zayC4OLJZYfcmdV2nhXgcI
         e8YRDLJKAE7c2rt7erry/ZiYLnWI9UxGJwUHlb1/yQhu/tund57nel3sJIZCuvOY2D23
         tOIWemca4frAdHaLH1Njr/pTDSQmlPq/MkLlJDwCy6k69rzTPdnuqwW3qEBqWO9RKLVi
         WlvdTuFq6NHtRHvtleCKP0YnDdKqk1M6BnZfjxqFbKfN6I7RSfP2PxKPaVsJyvqbl/Mj
         jHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UPPlerw+Ij73r1zyZz/VpYVo7uhD+qoPOr1r0d8ErCA=;
        b=41k2Er//C/1eNsRDr4Ty+FykK5MqeC4Juiz6aAEQdUlX/i/XV5AwfM8fQ8KrXEnrcn
         m2o1fDrDVwbf9nciTpLv2CwyxriyY6srwxiBepy7pRqhv/P6CNCfluxgowvoTqm2t0xY
         qTjxK6RCiL2eLjU3WJ57uJ1uYtGVj8JzDEKvfkc8PeVdi4gsoHCqJpW9BVgz6C5omewJ
         uOC7+4hzN+0dMh0Uqj968mqVTHSMgFA8OmgM4YUFQcWHzLXo1HFoOMYsVyUYp8zNNNUP
         2xF3eXeq5xSROl6XZsG9yS+gH35s4br2JQKjsOF4ou2haxogGVfBLHNC6x68vTCC99l7
         OYNw==
X-Gm-Message-State: AOAM5320POTMg3vpwX8/h39U/ohTjwxwiSikq8q+GrBzCkDhFX/nrHdu
        tptYvwNgid/e62OCr9bTx5Q=
X-Google-Smtp-Source: ABdhPJyUmRKnuSlyY/dWDwPzkRyqGBuJl1/Ijji/LM+T1m4p1HSazT30VwfFU2U2lPSvWoAAMulWaQ==
X-Received: by 2002:a65:6454:: with SMTP id s20mr34550652pgv.20.1641045682443;
        Sat, 01 Jan 2022 06:01:22 -0800 (PST)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.33])
        by smtp.gmail.com with ESMTPSA id z3sm27823029pgc.45.2022.01.01.06.01.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Jan 2022 06:01:22 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, tenglong.tl@alibaba-inc.com
Subject: tl/ls-tree-oid-only (was: What's cooking in git.git (Dec 2021, #06; Mon, 27))
Date:   Sat,  1 Jan 2022 22:01:17 +0800
Message-Id: <20220101140117.19409-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.33.0.rc1.1802.gbb1c3936fb.dirty
In-Reply-To: <xmqq7dbpvb0q.fsf@gitster.g>
References: <xmqq7dbpvb0q.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 27 Dec 2021 16:16:53 -0800, Junio C Hamano wrote:

> * tl/ls-tree-oid-only (2021-12-21) 1 commit
>  - ls-tree.c: support `--object-only` option for "git-ls-tree"
>
>  "git ls-tree" learns "--oid-only" option, similar to "--name-only".
>
>  Will merge to 'next'?
> source: <cover.1639721750.git.dyroneteng@gmail.com>

A new patch was posted on this: 

  https://public-inbox.org/git/cover.1641043500.git.dyroneteng@gmail.com/#t

Thanks.
