Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5A2C433FE
	for <git@archiver.kernel.org>; Wed, 23 Nov 2022 00:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234575AbiKWADP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 19:03:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiKWADM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 19:03:12 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199221C93C
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 16:03:10 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id ci10so8360894pjb.1
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 16:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k8g534tFEFvZpLEI7b3/r73lrz6C3sUNgURlgugbwOc=;
        b=mVvYaTaiTId+1/ZVcmGnk5CuhsZlB775RiAsKLLNMV/Ho/7/5VXnTls1j365uFUFWb
         sotoLEJIXbdbmnrZbL/VQg5DxppSKCzkNIA8XskHeG3PokUkR60LGhgK4WT+eDnxG7b+
         Pw5ob58KRv4P2SYC+9cyiuWRwkL6o6f62PuNBasiA3NIF3E5sdEVaAio5vCve8N2FOaT
         a1dlkvttEGi3HCceDx5nDP4EU20N2R4qXNPz17+wFY3aYwpCwPTxuQQM2zzkk/hII3o5
         IxWNLJ5k5zynUbE4frMhy6T2bUY+/3IgGZA3ooQptjTjTGgjQvdS+X699WPc1j9kRerm
         /hHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k8g534tFEFvZpLEI7b3/r73lrz6C3sUNgURlgugbwOc=;
        b=SVK1Bxf4QKD/DeBi2G9rd4BTGj50/brmd7p7S7NG/0131icPwYsLv7iFCdjZbS/tC9
         SQTy3F/etYS82PwOiAtkbWKIDuDcA3gGlYvz9kqEm11a4j1eehtcTZNxm2u7/Dzo/40g
         s6nJeK35yqD0nOMi3PFYXcFP5OBVOp8ZL+D5oiAFuCfxzqUU5YQ8M/HG91HFXh3QpuTU
         vQUPXetu5nrF/OCL+14KRyeTDlBLxqVddE16ExPOgYg436DL6l0cF99cDyPz4nzkQNpu
         kpoT7hva7yHFWCU0VwirSbw2cfk8FJMdOUxyRVQDp+yusV8GItKL3//eQ6q9q9Ma6sy4
         EyrA==
X-Gm-Message-State: ANoB5pkkAitepleQTHLSf/Yv+re0yMedzfyscmn5PFOmGx2SmuumcuMT
        6LyxNZEt1YcXbOpm7izxA3cc42dcSVr6bg==
X-Google-Smtp-Source: AA0mqf5ljicrqpIgD7CN40VHZLGug9OPkYyofyb0lX1tVHUomf2xiQ5CzvRzikDxGUfbStHEVesubA==
X-Received: by 2002:a17:902:e884:b0:187:403c:7a15 with SMTP id w4-20020a170902e88400b00187403c7a15mr12238417plg.28.1669161789481;
        Tue, 22 Nov 2022 16:03:09 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id s10-20020a170902ea0a00b00186ae20e8dcsm12608808plg.271.2022.11.22.16.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 16:03:09 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2022, #04; Fri, 18)
References: <Y3g95OYdwzq2OP3z@nand.local> <xmqq35ad181e.fsf@gitster.g>
        <Y3rDQ3x44BUmmGHV@nand.local>
Date:   Wed, 23 Nov 2022 09:03:08 +0900
In-Reply-To: <Y3rDQ3x44BUmmGHV@nand.local> (Taylor Blau's message of "Sun, 20
        Nov 2022 19:16:03 -0500")
Message-ID: <xmqqmt8ipmf7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> These are the topics I'd feel comfortable merging down before the
> release candidate:
>
>  + pw/rebase-no-reflog-action                                   11-09/11-14    #2
>  + pw/strict-label-lookups                                      11-10/11-14    #2
>  + dd/bisect-helper-subcommand                                  11-11/11-14    #3
>  + js/remove-stale-scalar-repos                                 11-11/11-14    #2
>  + ab/coccicheck-incremental                                    11-11/11-14   #14
>  + kz/merge-tree-merge-base                                     11-12/11-14    #2
>  + ab/t7610-timeout                                             11-15/11-15    #2
>  + dd/git-bisect-builtin                                        11-15/11-15   #13
>  + rp/maintenance-qol                                           11-15/11-15    #4
>
> I also feel comfortable with these (below), but they are newer topics
> than above. I would like to see at least ps/receive-use-only-advertised
> in this release, since it saw the most comprehensive review of any of
> these.
>
>  + mh/gitcredentials-generate                                   11-14/11-18    #1
>  + jt/submodule-on-demand                                       11-14/11-18    #1
>  + ps/receive-use-only-advertised                               11-17/11-18    #7
>  + jk/parse-object-type-mismatch                                11-18/11-18    #2
>
> These ones I am not as sure about, though Ævar (cc'd) will probably try
> and tell you they're ready to go ;-).
>
>  + ab/cmake-nix-and-ci                                          11-04/11-08   #14
>  + ab/submodule-helper-prep-only                                11-08/11-08    #9
>
> Thanks,
> Taylor


Thanks.  After trying to catch up with the in-flight topics, I
mostly agree with the above list.
