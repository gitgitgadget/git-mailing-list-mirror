Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A803DC001DB
	for <git@archiver.kernel.org>; Sun,  3 Sep 2023 01:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235387AbjICBbq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Sep 2023 21:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbjICBbq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Sep 2023 21:31:46 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2209F0
        for <git@vger.kernel.org>; Sat,  2 Sep 2023 18:31:42 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-6493389c56fso1962776d6.2
        for <git@vger.kernel.org>; Sat, 02 Sep 2023 18:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693704702; x=1694309502; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3rEnnEZai3RIQYmm1CGAXJutimGRdQXACgts1aFGz70=;
        b=qrtWbvHGo05S+Qu6PpzJhlvJS/XZ0uOYDp2I5ZyvM+ypu1mIz4wmb70YQ66HJhRH5O
         /27oGf6OJWVljN5Ds/3uJz/zfpEBPbyGiz3pguNEn2SI38EC0RCUsQihnsIh6IP3KIzC
         wpMoeAzAgQ7YjAM7U9uXCgcohFOcQDKpbSC+npHvv6zsot7PJN4+QQ1xGEqszo29Ao2n
         SQaCHT+rShbCCb49rifATsMMsIkXIDDhmuvqjDS4SFN48eZXkkDIW8whD9OILTw1xStn
         bRn/3v00C0V+LhHU/4mWdRBCKT20B+w2iZRrlJdOzgvvZtZww82g2yw48l2MD5WOH8nB
         pArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693704702; x=1694309502;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3rEnnEZai3RIQYmm1CGAXJutimGRdQXACgts1aFGz70=;
        b=BZBvsaONjz2cREIzZSxf+Fflp499ReNiNNGbeIa8P6/ulRLLbE7hVLI9PRalPjFqGp
         Q7HxDFBO94BA+kuBbf921JRQpjFKdOTnaQcvhRzRobu2QOSx/ew0QoiHe5uup9Rpa3GC
         tHptxAPKJF7Sm3fxHYBwb36P8VPdJLsvYfg0SD8R7ECqf6uba7vQhtDQxHcqcSBlr1/S
         AvKMK+85nIGmdFKUwuTPTOcmB9D1291sZZWAZocEOCUIoN/Q+PmmiPLzgbH5+kUvgFGL
         7CT06y8NP1hqiuivDfQjwQShkDrjtkBdbi7hLtoPWZCu7tSB70xYLcxchW0bC0Yef+86
         fuEw==
X-Gm-Message-State: AOJu0Yzikq+eN0d/o6tvtY3alWVGsZJaSJeTtG2Nn5Qt+WnAGpo96a1o
        RX4BZT8VayiIQBBTo+9giF9yus6XpZkwWvpucLvuC4SZ
X-Google-Smtp-Source: AGHT+IGROTUhx6+E7cNHl89l5Fd+fxsWegiz+KnW26h3k1Elt1tVLIyhuxcrffO2jOBJgqa5IJRRKW2KaLSzrKxRuro=
X-Received: by 2002:a05:6214:2dc8:b0:64f:4d37:4867 with SMTP id
 nc8-20020a0562142dc800b0064f4d374867mr7439159qvb.40.1693704701715; Sat, 02
 Sep 2023 18:31:41 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1565.git.1691245481977.gitgitgadget@gmail.com>
 <pull.1565.v2.git.1691818386345.gitgitgadget@gmail.com> <CAFWsj_X=_PVyLcRgy77PL+kisjFqRSTCojB61B5cSK=6YROajg@mail.gmail.com>
In-Reply-To: <CAFWsj_X=_PVyLcRgy77PL+kisjFqRSTCojB61B5cSK=6YROajg@mail.gmail.com>
From:   =?UTF-8?B?5ZSQ5a6H5aWV?= <winglovet@gmail.com>
Date:   Sun, 3 Sep 2023 09:31:30 +0800
Message-ID: <CAFWsj_XCbAy4yuHxsV3DgqMWzN8oE_Jfkp1mxxZggGtbEEfnsw@mail.gmail.com>
Subject: Re: [PATCH v2] merge-tree: add -X strategy option
To:     Izzy via GitGitGadget <gitgitgadget@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, newren@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello, is there any problem with this patch?
