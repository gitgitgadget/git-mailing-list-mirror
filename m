Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C370C76196
	for <git@archiver.kernel.org>; Mon,  3 Apr 2023 17:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbjDCRHv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 13:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjDCRHu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 13:07:50 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31D626B7
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 10:07:45 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id f22so24582825plr.0
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 10:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680541665;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=IjCWavNQH/pDwGyKi/S/+4mSjYFzCg/4sITwwvn66w4=;
        b=XtOIsmrxPHAeKZE0gJb/xGacBmu+TfTbWVQwCiEqV3qJ/b9ZudjgWLmKZjEPGlz0z8
         ZhzoQSWKhtwzt8/CxVwNss+UswmLoHQfBnl2nzzWvZPhJgRcXPUNVsn21BH/68XsOg0f
         nVRMVDO2JEX6XSImWlk3NCnEtC+00QAPcj7SNexWeqGC2CsK00PfjwF8rY32uwNvl6wQ
         hEFmhiA2TnrTJQKFRiJzIJwNwWZ+QyqV0SWoGwcscPLHn/TE+9F9KYN4ynbFGRPnzriw
         66aoCnHxmNp/yLbHEtnoCZeRHv12yt6UDJEsPcO/gyXM5pWE9stxOUsCV2sOx2VBEUj0
         wrPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680541665;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IjCWavNQH/pDwGyKi/S/+4mSjYFzCg/4sITwwvn66w4=;
        b=Jh8PI5d4xDbJ5+tiUhdNYuF57RaCUtcaTb7cCfVEz7gBSsJgHM+osCqyQRDJGp2j8U
         9gv+OiCpLrgSLZq86Gtuwebnn1nJkflB0pzEJQVJQ/WCcuwRPTqsQ+29vn8xpnKXO8j9
         hN7vFReTjIVplD/qIO41CtomgvnkMKLxFR22utm0GICNAO2Ax/bcTky/OsfACyXl7zpx
         4muuh1EexM3ObcGx8N0g6LR13IJKQotqINToPvqZbjZH1KV5yPNo2Dv15R8EFPkcVRdG
         dM1EyTUE/rsmiLiTr8664zhszfvS4bp0/IVeslq/yecFiwdIH1/xrdzN26pmr2M15hi7
         Lxeg==
X-Gm-Message-State: AAQBX9eOQ28DV2/Xpvul0wTfvdX+Qiudk12r2SJe/ChKuF5i+oQhuJDH
        PHCLBDQqus9sK1E7Xp4eMO8=
X-Google-Smtp-Source: AKy350aOpTdyZXn5C7e1whvmQdw2BgCJg/OBUt4w3qnOfEg9qYjuflDsiwL3ZhT0ErdHKC3KGikzCQ==
X-Received: by 2002:a17:903:2312:b0:1a1:8fd4:251 with SMTP id d18-20020a170903231200b001a18fd40251mr45149104plh.55.1680541665125;
        Mon, 03 Apr 2023 10:07:45 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id z3-20020a170902ee0300b001a1ea1d6d6esm6842020plb.290.2023.04.03.10.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 10:07:44 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     William Sprent via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        William Sprent <williams@unity3d.com>
Subject: Re: [PATCH v2 0/2] builtin/sparse-checkout: add check-rules command
References: <pull.1488.git.1678283349.gitgitgadget@gmail.com>
        <pull.1488.v2.git.1679903703.gitgitgadget@gmail.com>
        <CABPp-BHhjjO32EAzi_Deck6fxsyG=uMrvAnJLaD0e9qMtrcDEQ@mail.gmail.com>
Date:   Mon, 03 Apr 2023 10:07:44 -0700
Message-ID: <xmqqttxw6gin.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> This round addresses all my issues, and I agree with the other change
> made in this round.  So, v2 is:
>
> Reviewed-by: Elijah Newren <newren@gmail.com>
>
> Thanks for sending this in, William!

Thanks.
