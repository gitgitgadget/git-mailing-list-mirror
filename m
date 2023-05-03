Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F84BC77B75
	for <git@archiver.kernel.org>; Wed,  3 May 2023 21:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjECVVR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 17:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjECVVO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 17:21:14 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E753572B7
        for <git@vger.kernel.org>; Wed,  3 May 2023 14:21:12 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-63b7588005fso4595802b3a.0
        for <git@vger.kernel.org>; Wed, 03 May 2023 14:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683148872; x=1685740872;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vfrgnM8BCgUCtxgB8f90BdkmSpeK8j8KE4E8dHiJYpc=;
        b=YLv/+bZnEnKyFUafyqzH1029lxXPqukJG2f/WlMU8vcdKJ0SINaLT6NVK35ycIP032
         R3tfEmHnK85UJnV3rvESSPbwuWnyya6N3VkOu/PK4I0Z1AooTkSMNsD0W5YX9pIhe4oQ
         yjvXyl/39BtPITNsZQFQGCQdyuBqEhkRisVMRKV5kmzczo9EUbAq0CKxj+QJoyb8LzJ+
         oFb6sEZC4JhN9365GhDYiZkuY3cB0N2fWeaNWzwor4FXglbx+8aFN2p6WAFa7grxgN5i
         NLOQMBZ3e/EBKps97AKs8dPPbp7HlA8EscSSzcr55fFTaWdQ2qqVpWiDKDMekqLITmMR
         pCvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683148872; x=1685740872;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vfrgnM8BCgUCtxgB8f90BdkmSpeK8j8KE4E8dHiJYpc=;
        b=l2woiFml9eKpX6QboPo1aU0f/IBPwqJImwaz4INxNCsoIYpATqHTFR6Tc/Pv6j3Bnj
         GZy+giI3SndbbOTlm8bJQT4a6vTRYC5pK7UAlALB48rLJu9bkwR0sWa9gkgYAe8r+l3p
         8j+fZQOG+/rf17vIVDoV7JKIo4tDQbQ9rbz4tmnYqBqZXfLKr0pmktoPD00VRvmvqv8c
         iGZkayS0DrlV3Ye3tRe0w2f/PnjI0MCeWEVonbqR/9bFcPLLwB2mjbEWdUHkj3N9uFRA
         dazDu3BBw1s2R5M/4pphBeW4WfDizIWmFxXmX80rVEcIkjPUWCFuaKe/8v9THfG239/m
         o1+g==
X-Gm-Message-State: AC+VfDzWCMYxJaqCCChaf5rby9n9HyUyI/Qlgyz9uOdWuoCdH8o9YHme
        9wZydVyn3GCn8CmBO4O96aX4zgOa71w=
X-Google-Smtp-Source: ACHHUZ5sImBC569wuNc2/XODOB34HGEqYl1bSMTji8dX2LZFKZvJnlJdW7fPnqQi/3KK/BZyVNFa6g==
X-Received: by 2002:a05:6a20:1447:b0:f3:532a:7150 with SMTP id a7-20020a056a20144700b000f3532a7150mr76049pzi.0.1683148872280;
        Wed, 03 May 2023 14:21:12 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id r12-20020a62e40c000000b0063d666566d1sm26227pfh.72.2023.05.03.14.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 14:21:11 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     johncai86 <johncai86@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2023, #01; Tue, 2)
References: <xmqqcz3ixsas.fsf@gitster.g>
        <20230503203843.34xwgjdsnifnmzbf@pop-os>
Date:   Wed, 03 May 2023 14:21:11 -0700
In-Reply-To: <20230503203843.34xwgjdsnifnmzbf@pop-os> (johncai's message of
        "Wed, 3 May 2023 16:38:43 -0400")
Message-ID: <xmqqa5ylp0vs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

johncai86 <johncai86@gmail.com> writes:

>> * jc/attr-source-tree (2023-05-01) 1 commit
>>  - attr: teach "--attr-source=<tree>" global option to "git"
>> 
>>  "git --attr-source=<tree> cmd $args" is a new way to have any
>>  command to read attributes not from the working tree but from the
>>  given tree object.
>> 
>>  Will merge to 'next'?
>>  source: <pull.1470.v4.git.git.1682822352360.gitgitgadget@gmail.com>
>
> Christian sent some more feedback on this one. Latest version:
> https://lore.kernel.org/git/pull.1470.v5.git.git.1683144574158.gitgitgadget@gmail.com/

Yeah, I noticed you sent out an update about an hour or so ago.
Will replace.

Thanks.
