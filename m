Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60637ECAAD5
	for <git@archiver.kernel.org>; Mon, 12 Sep 2022 16:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiILQYy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Sep 2022 12:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiILQYx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2022 12:24:53 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4892C7675
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 09:24:52 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id b23so9113951pfp.9
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 09:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=87VY3EWndJIkpJYZAZkQX2nx6LXym/XZZuGvtioPBk8=;
        b=QaVotou32CmzD99Vf+J/3iEK/x/vU6Sr3XRjc2sWkWL4PwGyWLU6T3NDcWTxUTzmB+
         MDuaS5K8DeeejwfDx8IMupetRkPTOgYWhKjE8x8U75bV+GWbAtaDnDkZ4tVolZGH9Pc+
         Kc9HrAobgu6JsyuFkH7ruxWM8TbXJoG4WvPJKIRc4vU9VCv0nj7kE6JuBLk4cG+LBkVG
         JIMqll/Li27vyh24nIU/9aaxvBaws/Xqe93c5LBSrOd0ttciZCxhm/sK5L04TRZuanOR
         hBBhT6us/gjuV/MF2EZmOAKjrTxGocUDdmhkgz5fur225F7JWfQxfOF2DXHGGs5ywiqX
         aoGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=87VY3EWndJIkpJYZAZkQX2nx6LXym/XZZuGvtioPBk8=;
        b=wRGNIpxlvq/SCiVGxSehvmgyUS84si4DlHuxoZ5vZwDGaY1N4hQ9BOQrdsJsLMB2hG
         DHPm1iizfeRDzF04UHSIeZF67WNaB+sr3kLc/I7G8Al+cbMpmuSbYaa4xvw69ZHyk22Q
         8Eu9mRKT7H6JTCJlWp73kx4mN8pxSFzEdC08et88DQnUTG4Q19r2zAImO2V1ZMMbWASO
         kX5iAkePkPM2Z+FX+nCMtCKCkh2Wu9T3gFaunIJ+GxJqFAk+ScjkviO7K/7P8XRxq0Vq
         O1acl74Z0HHgkzc/5/fhuVEyz89gDR5oLaU1aoJOD/r32ykroIzr4pkUJL12PTwciL0r
         81Iw==
X-Gm-Message-State: ACgBeo2OzvWFGmrFdLh5Irf4UUa2gIsDw7Y+7aiZ4FSXRMrBRwsU3WNO
        K2+M7vTwj2YtGPJUgLbxtMTA+wSZFZ4=
X-Google-Smtp-Source: AA6agR43ik+7b4vX758Ngt2tFJZz/wJAiIiMOfcG+07myd6sbKj3UhtvGySuzb7WIVYJ/nLvpOyqaA==
X-Received: by 2002:a05:6a00:1ad2:b0:53f:2455:17b9 with SMTP id f18-20020a056a001ad200b0053f245517b9mr23901101pfv.50.1662999891704;
        Mon, 12 Sep 2022 09:24:51 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id w63-20020a623042000000b00528a097aeffsm5556535pfw.118.2022.09.12.09.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 09:24:51 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH] ls-files: fix black space in error message
References: <pull.1350.git.1662904997760.gitgitgadget@gmail.com>
Date:   Mon, 12 Sep 2022 09:24:50 -0700
In-Reply-To: <pull.1350.git.1662904997760.gitgitgadget@gmail.com> (ZheNing Hu
        via GitGitGadget's message of "Sun, 11 Sep 2022 14:03:17 +0000")
Message-ID: <xmqqwna8ftm5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: ZheNing Hu <adlternative@gmail.com>
> Subject: Re: [PATCH] ls-files: fix black space in error message

"black" -> "missing" perhaps?  I'll queue with the reword for now
but if you have a better alternative please holler.

> ce74de9(ls-files: introduce "--format" option) miss a space
> between two words incorrectly, it leads to wrong i10n messages. So
> fix it by adding a space at the end of the error message.

Thanks.
