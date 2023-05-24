Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33A1C77B7C
	for <git@archiver.kernel.org>; Wed, 24 May 2023 20:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236188AbjEXURN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 May 2023 16:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbjEXURM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2023 16:17:12 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E039310B
        for <git@vger.kernel.org>; Wed, 24 May 2023 13:17:09 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-64d3578c25bso1561499b3a.3
        for <git@vger.kernel.org>; Wed, 24 May 2023 13:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684959429; x=1687551429;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VbEjVNTTS9Q2Q8ZmVNOYGK9Njnsl4OzNrJZo4dPT+Rg=;
        b=UYeC8ryf06o21Cqz0iwuh7p9RDsgQBz5SnkeYWWi18ECqFXr65QfIAW7FX9uXbBD67
         5dUoOVPcCKyDZPAqDtiuerNhGrE9qQnnfcUCLh0Zhvazu9ORPWFeaFztFsrwwS/RXB1S
         lrSC+PxcDdPB0wjYjZsSLtAs5MKuUSRtFSzImVlhAmHqH3/9DPH4Xq4YoHljLP/ZkuD7
         9XAagKUvmX9XGOjLabS0DBf3KfJKgaVh5H1riDNylgr2rpHaIrkmmcol8Fh13NBVzkkD
         j6FfWGZHE9xBB9zbu5kQbBncSa+STO2BFFvI3ndYUrEMOdzpg5tA1qwZk8ZGSFCZcPl8
         zEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684959429; x=1687551429;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VbEjVNTTS9Q2Q8ZmVNOYGK9Njnsl4OzNrJZo4dPT+Rg=;
        b=LLFhW3/r538V0spVQRM8q10VE/CRuf+hVX5zlTu1QZ2wuYxKsc4u4c4H9pdUcyZvLf
         eFkNcqZw+Ime/AmIBOp2AuyZ7r9ohEDd9uA//mxOSErq3wXDDCeU2cQhoaXWbla3m2lc
         2F4moadn8wx5q1JOkMpASsqq+vaT2/T18o6Yanu294P1CsJJ+PBrlAF3YWOSunV7dOQw
         t9VhSzYS38fjO2tWmsA0ha5RvXt4J/RNafslohcCVPK79PAgBF217PI0t0EP7dGs0Kdc
         R52NJo7hKQn0smdxuraggpAoD7mCLDEzKNI7U2S6dL1KcGRuMDsyfl0laCMg9tXdXqlE
         uuaA==
X-Gm-Message-State: AC+VfDz9jb/vvmjKdZckvI2RB71HDV8Zyb+NZpkgBgAFwdSDcr20vnrA
        J4PZmiYu/Fwl9QBXOOnlHQw=
X-Google-Smtp-Source: ACHHUZ4giM0VhB4NcZEZ+p+ANLxnkyuYCYb6RzJUdPLTIQdUE5OF233KP4F88crYCgjAytVPIkfpog==
X-Received: by 2002:a05:6a00:1a0f:b0:64d:42f6:4c7b with SMTP id g15-20020a056a001a0f00b0064d42f64c7bmr4446595pfv.27.1684959429283;
        Wed, 24 May 2023 13:17:09 -0700 (PDT)
Received: from localhost (217.195.118.34.bc.googleusercontent.com. [34.118.195.217])
        by smtp.gmail.com with ESMTPSA id v19-20020aa78513000000b0064d35776709sm4464720pfn.78.2023.05.24.13.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 13:17:08 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.41.0-rc1
References: <xmqqedncqkzf.fsf@gitster.g>
        <20230523130808.17591-1-oystwa@gmail.com>
Date:   Thu, 25 May 2023 05:17:08 +0900
In-Reply-To: <20230523130808.17591-1-oystwa@gmail.com> (=?utf-8?Q?=22?=
 =?utf-8?Q?=C3=98ystein?= Walle"'s
        message of "Tue, 23 May 2023 15:08:08 +0200")
Message-ID: <xmqqzg5tfprv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Øystein Walle <oystwa@gmail.com> writes:

> On Fri, 19 May 2023 at 10:39, Junio C Hamano <gitster@pobox.com> wrote:
>
>> * "git branch --format=..." and "git format-patch --format=..."
>>   learns "--omit-empty" to hide refs that whose formatting result
>>   becomes an empty string from the output.
>
> Typo here. branch, tag and for-each-ref learn this, not format-patch :-)

Indeed.  Thanks for spotting.
