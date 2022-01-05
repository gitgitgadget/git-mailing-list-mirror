Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888F2C433F5
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 04:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237286AbiAEEC0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 23:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbiAEECZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 23:02:25 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E0EC061761
        for <git@vger.kernel.org>; Tue,  4 Jan 2022 20:02:25 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id m18so35869631qtk.3
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 20:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X2dpIIyirIvwvcV4zjYxX6Z+kUYNU2uhs0+nxZ/Lz6g=;
        b=ltCT1sfQciFag0BEglRLFxANc0aWN2fpohzMqM2NNOrCxkBZm21LtXEwGRtXmp9hlw
         4CfG6hwZnlvIFiUyW3MlFRxiel4OLdLVvKVgFJ+AgVtAiZGpp2XqkdfZIlqjOUeoRaFz
         kXc+C/FaV2dYH7L66fKDjyKrcOYbm9OXgzs/5ToT48XBRQxh3ciCWWZyZFWbb5bYV4RZ
         DMBdZYT6snDwm3BjlgmccgK+kTz2Eq398JsxcNykuSwUh9x1Yf/+I3E07AbfhQ9CCKfl
         5GTZFc7v8t+Mc2xiUommVkGsJnvvkgfOz+eFNjLSZrFWhCOBIgVwInF51Kdyk5gV4zAN
         8FoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X2dpIIyirIvwvcV4zjYxX6Z+kUYNU2uhs0+nxZ/Lz6g=;
        b=xQ6/B++C1cfunpDpsXhcPv91ymAzlz52+jRjHE2OBLSrdGiWN2O9oyZk1lG6p+nQfw
         6YkwPFP6aFQ2hzNELxl5jc/53cHZdDdD+7tB1Z6inFe8XssHrwzyExW34aQoDb9tFH2R
         eDUgXSCqX+e2gmfOPQK4bnzGHcjCricPey7y62mKU6atC+EZ/SGVYX0BAI7sHCPoW9aX
         vNL/OYsV0MLj5dJxvIIfPdY4xkazmlJobbs6PyJe12eUrS2vmQE1MMt2ErfjNqHcL6uN
         hkcUPFeV2RJ2e6d1+I71czMtiykJuL9LAiP+3xXBdp4E8V/Um7DVOpVfE8QGqV4BPlPi
         hHUg==
X-Gm-Message-State: AOAM532LEnDSPdE7C95uWt/aIIzpcFkLkIje6JNCFChm+h1hn67+4Vn8
        9iK9WfaSr9i8KAya/FeAH9uqA+wYiNI=
X-Google-Smtp-Source: ABdhPJzu3PIZyzhaaGzRRzEHSE5x+EBo5aK8OG1HA/cTr5fokf7jEDEeOkYfn+Gg7AEHxD47ww2hCQ==
X-Received: by 2002:ac8:57d1:: with SMTP id w17mr44760080qta.453.1641355344501;
        Tue, 04 Jan 2022 20:02:24 -0800 (PST)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id o9sm34807600qtk.81.2022.01.04.20.02.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 20:02:24 -0800 (PST)
Subject: Re: [PATCH 1/1] builtin/pull.c: use config value of autostash
From:   Philippe Blain <levraiphilippeblain@gmail.com>
To:     John Cai <johncai86@gmail.com>, git@vger.kernel.org
Cc:     Tilman Vogel <tilman.vogel@web.de>
References: <20220104214522.10692-1-johncai86@gmail.com>
 <20220104214522.10692-2-johncai86@gmail.com>
 <fe0b7337-3005-d09c-a3b6-65a100799676@gmail.com>
Message-ID: <e90dfdb8-afdd-d565-63ab-ce767236f87f@gmail.com>
Date:   Tue, 4 Jan 2022 23:02:22 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <fe0b7337-3005-d09c-a3b6-65a100799676@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi again John,

Le 2022-01-04 à 22:40, Philippe Blain a écrit :
> Hi John,
> 
> Le 2022-01-04 à 16:45, John Cai a écrit :
> 
> Usually we start the commit message by a description of the current behaviour,
> so in the case of a bugfix like here, a description of the exact behaviour
> that triggers the bug. As Tilman reported, this only affects fast-forwards,
> so that should be mentioned in your commit message.
> While what you wrote is not wrong per se (although I'm not sure what you meant
> with point 4), almost all of the behaviour is
> correct, apart from the (rebase + ff) case, so I would focus on that.

I forgot to mention in my previous mail, but in the same vein, I think your
commit message title could reflect a little more the bug you are fixing, maybe
something like

pull: honor 'rebase.autostash' if rebase fast-forwards

or something similar.
