Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51113C7EE24
	for <git@archiver.kernel.org>; Wed, 10 May 2023 07:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236181AbjEJHT5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 03:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236170AbjEJHTn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 03:19:43 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067855FEF
        for <git@vger.kernel.org>; Wed, 10 May 2023 00:19:42 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1aad5245632so49417385ad.3
        for <git@vger.kernel.org>; Wed, 10 May 2023 00:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683703181; x=1686295181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YFB3MYguXsVRUngp3fiQLGAplWIbMGMoT4OQuV+4sQg=;
        b=SQNWGRXb9LxaolEoulB9fMM/vLtLCJ/bfXw6V7K0cx9aPI2QprqR2HqWzc5WMERQ8V
         B59Slxrqo848SkFxaPk/v//ZVTEVONu3AdvkRXpC/YtmNt5BtrDB3fHYTnyFnOwsFV/m
         xRFQINGKy9HfxNvq02YPxtV5uprDk7VVKx/WtODPPww+n9HaxHUrsu0w39yCOxz2h7qV
         UpZHo/3MyIKItVsbCiVF75cxp7OcJCIm/bDeeGD6etOAIs3ZAeS1ORpA3tAapYXP7FFs
         bio0AucADRrEluUiMOJe3r7kixYw1t6KQQPKsIXOJ48ASADFh2d2Eac+PsoYtxaF80Ej
         x5Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683703181; x=1686295181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YFB3MYguXsVRUngp3fiQLGAplWIbMGMoT4OQuV+4sQg=;
        b=gymGni5qg0L/EGKCfi5Y3dDnd1SwzKu7DFFUxD1/wRGWYBaXDc3WMuoB2HOz0hBbq1
         e81gsMjRhMTHaRR28hHLfjjPTO0fgQY1rRouuUOOGnugIX5CsfQ2Ja/i/OyycsNcA68g
         UB8JqF8LqwmonL0539hSmofjvAVtlxKlx7+ZFYaWL/aW/7jG2eLpLWfHPLYtFWKdroSD
         OUdVmoLC0IAW25hy+qFWBU7ZCSXheJD6YsVPOvmDzAC3UDUjy7CZsamm6h3Bir1LCo9e
         iaRIJpla8/218BHpcdyUFch/gfNoiCNkU9pCj/zb7Jd1oYTpBfYApS+jXQNnohhXXs7O
         wT0Q==
X-Gm-Message-State: AC+VfDw+2b6ONOpYMlaYnjItASA8qMGeqeqrWVinB72HxtqKbNtb3mdW
        AesDQlHJCZB4Sz48qZH2iqRwZwJi7Ea9Dtbvkes=
X-Google-Smtp-Source: ACHHUZ5PqegZVp3K2qOjuKj9kIn+jzDLGJO5hv2SeIvQDqqJBodabdZwYTZ/PsRZFxis3lxkrMlPpA==
X-Received: by 2002:a17:903:48e:b0:1aa:fe4f:9b99 with SMTP id jj14-20020a170903048e00b001aafe4f9b99mr16945942plb.19.1683703181198;
        Wed, 10 May 2023 00:19:41 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.58])
        by smtp.gmail.com with ESMTPSA id i12-20020a17090332cc00b001aaf5dcd762sm2942467plr.214.2023.05.10.00.19.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 May 2023 00:19:40 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: What's cooking in git.git (May 2023, #03; Tue, 9)
Date:   Wed, 10 May 2023 15:19:35 +0800
Message-ID: <20230510071935.7329-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.40.0.335.g9857273b
In-Reply-To: <xmqqmt2d0x0f.fsf@gitster.g>
References: <xmqqmt2d0x0f.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>* tl/notes-separator (2023-04-28) 6 commits
>  (merged to 'next' on 2023-05-06 at 598ed19c9b)
> + notes.c: introduce "--[no-]stripspace" option
> + notes.c: append separator instead of insert by pos
> + notes.c: introduce '--separator=<paragraph-break>' option

Sorry, there is an updated optimization for the commit of the
`--separator` option, which can be applied using the reply[1].
Please also inform me if a new patch is needed and I will send
it immediately.

[1] https://public-inbox.org/git/20230506092204.57914-1-tenglong.tl@alibaba-inc.com/#t

Thanks.
