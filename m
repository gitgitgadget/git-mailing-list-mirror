Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977F2C5479D
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 04:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236670AbjAIEgE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Jan 2023 23:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234276AbjAIEfe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2023 23:35:34 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2BAF001
        for <git@vger.kernel.org>; Sun,  8 Jan 2023 20:30:57 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id c85so1973217pfc.8
        for <git@vger.kernel.org>; Sun, 08 Jan 2023 20:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hmiJAq6BBb5sICA/eesx9ULpcfElj+7mNufySzJ/Pjk=;
        b=ls/cqb0UbldAZzuFafp2jTGCtDjKIsKCc3VnI5jf3+6O/z2oR8+AGkiPaMTtQ0Urkp
         uXKInRMatYAYP5YXP9pxSwnDVftXCz4h8zocyQx8bLyqr67+wiC42s7RjJOREcGvEjnw
         EP7MV2ukxVvuXVLG0KapMzjMUl1n4asVe4HQW1UOVZSaDoqCQfKtEyCL3ThyLmUm9/UY
         RQmrobU1Wozo9B4LkRcdl5/Ea0wzX7KSgaBvmrMw5E7dAR5MLYfawj28I6Ec3SYcGJJn
         OAQJ0lNPidly4SccdjzGGN6QbJ4tvNYTM8IkENqqKj6qWlaXU5hnrleHCiQ0edAsJnj8
         MiTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hmiJAq6BBb5sICA/eesx9ULpcfElj+7mNufySzJ/Pjk=;
        b=cop4qscT5IuDFQVN0K3Iv1eSAF6MG9HMGjXfl5lCbSmPnezQ553FDszUQZnrbn0cX1
         L+svHAw5Rt3ns4vWzyqW0muo3nG4Qgdg4OokJxM81gopT7IcVs8BC48ToIlFUY0lXHID
         lo8jFjOMNytzf9lx8NB72Q9HZ4F5cFRYhn3yRg9DOKobxBwM9Uwt8q95hoFFZG3Oq5Iw
         FwKFzZQuAwHFHwheeqSd3A92Q/qyi/t1VJXCkzV9mzfziUfYmUQ+64bwPfrdtTvQMoK4
         pWt8KHnm7nouMe2Rx79hc4IXYpMX87CfgY8iCIuGB/1MK1QW5F0Q4CAF5kvqC/MYt8/l
         E69Q==
X-Gm-Message-State: AFqh2krO19dIV4j0reG1TycM8orGKkoXQri9XKNlEXvSEBzgJxYIHktl
        oTkwq6xVbt1O6hVi1dpP210Y662KkhiRSw==
X-Google-Smtp-Source: AMrXdXuk0KoodY4TAtvR/VYZkTKBN7QtY0dIUwtucyMc9hy9W5KSsLdZz+y3u8i+tYMqqbRNX3r29g==
X-Received: by 2002:a05:6a00:26e8:b0:583:3d0a:4c34 with SMTP id p40-20020a056a0026e800b005833d0a4c34mr10389932pfw.4.1673238656836;
        Sun, 08 Jan 2023 20:30:56 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id s64-20020a625e43000000b0056da63c8515sm4878417pfb.91.2023.01.08.20.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 20:30:56 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Yutaro Ohno via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Yutaro Ohno <yutaro.ono.418@gmail.com>
Subject: Re: [PATCH] doc: use "git switch -c" rather than "git checkout -b"
 consistently
References: <pull.1422.git.git.1673166241185.gitgitgadget@gmail.com>
Date:   Mon, 09 Jan 2023 13:30:55 +0900
In-Reply-To: <pull.1422.git.git.1673166241185.gitgitgadget@gmail.com> (Yutaro
        Ohno via GitGitGadget's message of "Sun, 08 Jan 2023 08:24:01 +0000")
Message-ID: <xmqqbkn8wcqo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Yutaro Ohno via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Yutaro Ohno <yutaro.ono.418@gmail.com>
> Subject: Re: [PATCH] doc: use "git switch -c" rather than "git checkout -b" consistently

Hmph.  When two things work equally well, is it a good idea to
describe only one "consistently", or mention both that can be used
pretty much interchangeably in different places?  I am not 100% sure
"consistently" is a good thing here.

Thoughts from others?
