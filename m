Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B95BC76188
	for <git@archiver.kernel.org>; Mon,  3 Apr 2023 17:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjDCRg2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 13:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDCRg0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 13:36:26 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF0D1FF9
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 10:36:26 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id iw3so28790035plb.6
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 10:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680543385;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=2L80H1gqrvqZx/5fzTXNBrzijJOaUE4YsA5rDHGp6fg=;
        b=DepA+J7XflnyGNaCfXSMu29BMecvGMIJ1jqXczwq1Vnw2P4iGoXrRl9QFOturZsxfB
         0y87QSgJ1k3vQR+zHaee0882YB9iutluTBe7KcUqh9jrb2zxt3/tx+zA/RRR2cBB2Lqi
         p0wxUoRQZjXl++Gu1IQekevw+dbHbVz804KXeMqC5mK3UFvDtbwRSmUYLE7i+GznHHoG
         F2qgAwZjKGLMtVITEje53F5546ZEjKR0AIwVrnHSZFj0xvEqNbfgIvEILbmPqdlaFN9w
         pfWjSjxRp+QJB3jfIvJOIZlSqsABEVwgcdSRvCS3I6DmtU6n6/ENUA1f5Dwd93BoG3vv
         vp7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680543385;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2L80H1gqrvqZx/5fzTXNBrzijJOaUE4YsA5rDHGp6fg=;
        b=dpVZG4D496VbSKtpyT6sQWNrJKzzoiFvBbOyZ2LJIGH3sUM69w1fa4SHt8Bm7usicI
         7vdbjbP0IFSCpFFKjd2a2UV7DoMTnCDjPoTmO0iJvq2Ple2Da1jzD188lf8v2N4cEsyj
         YfHWcmgMDvF0jV6HRxPVE6owBIiDEXrT++ABjDtey9dS8C9LtqGJBfCeof7vT3aCAvuf
         R7UN6zSqce9/49eAtacvjQdLKvU48srK0A3OrLZqOA2q6nPMsm1a8Chx4PiJKENj3z+6
         ZAkalS95Dt72VErSfCyzRUWXg1by5TovdHCoPIHthKN6nWBC2BuIMCN1O43qT7nWuzqN
         gKoA==
X-Gm-Message-State: AAQBX9cu6lnMmvaQJwqzACRVi404hr00sc0bJoQWXCdAMx7n8DX01/9f
        lIhmfltwotjFzUm45spm9VoUaZ7qm2A=
X-Google-Smtp-Source: AKy350aUcAJfh8FTn685Cbc927xI46jV8UjPTMcl+kHUd3XBJKCoYs/EVqXDxEKU4oImjSSGzgcjQA==
X-Received: by 2002:a17:90b:1b4c:b0:241:b90:4a1c with SMTP id nv12-20020a17090b1b4c00b002410b904a1cmr4466304pjb.44.1680543384970;
        Mon, 03 Apr 2023 10:36:24 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id s1-20020a17090ae68100b0023d0290afbdsm10061880pjy.4.2023.04.03.10.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 10:36:24 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2023, #06; Wed, 29)
References: <xmqqv8ij5g83.fsf@gitster.g>
        <CABPp-BGoPuGCZw+9wCgdYyRR4Zf4y9Kun27GrQhtMdYWpOUsYQ@mail.gmail.com>
Date:   Mon, 03 Apr 2023 10:36:24 -0700
Message-ID: <xmqq8rf86f6v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> * cw/submodule-status-in-parallel (2023-03-02) 6 commits
>> ...
>>  Comments?
>>  source: <20230302215237.1473444-1-calvinwan@google.com>
>
> Perhaps this could be marked as needing a reroll, based on both
> https://lore.kernel.org/git/CAFySSZDk05m6gU5-V1R+y3YnQ5PPduVW54+_gjBwD0rmacsLsw@mail.gmail.com/
> and https://lore.kernel.org/git/xmqqv8jczbs0.fsf@gitster.g/ ?

Sounds fair.  Thanks!
