Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00920C433F5
	for <git@archiver.kernel.org>; Fri, 27 May 2022 13:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352087AbiE0NDu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 09:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243084AbiE0NDs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 09:03:48 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601145A2DE
        for <git@vger.kernel.org>; Fri, 27 May 2022 06:03:47 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id wh22so8672493ejb.7
        for <git@vger.kernel.org>; Fri, 27 May 2022 06:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=wNuEETC5YYLKsyGSns2hhzevowwUnc6kES3jQ652QXE=;
        b=FV3q86agXf8yOaEb0wvrp67I9Miyjlsi3qISQGhlwehNazBETysQooIQSqTMC7A60O
         pNUukn+zQTWgXYF7NLKqb2MGTFVwwDyjFnn1MATSpCbpJfNVbsNAMCdfygVjgS0aMbq4
         GtPz3P0PCu0BQhcMc1n5MbV0O7gHxrIjPlyN40i5qmtF2Lb9znbcStqG848zDKuZ3Be1
         Iin2HR5j6VOPItDnf56QH5t6+SH1u0Oc7pcD8XZJo3WNNDPzc0H5/eBruz5v8RL77Hcu
         vMFHB70ZS/k9POR4zRsZodJ6ps/o/6lC7rKb3iWY2VXJqzd/b68fAKKRCXetaYJy26Ux
         tJHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=wNuEETC5YYLKsyGSns2hhzevowwUnc6kES3jQ652QXE=;
        b=orI7VLk+PNMrM+NLXLd034DBnAkppM59K9n2qeMzp7dNMp/EemQNEKTbDfJm5xAHhl
         qpVuuDWZomd+oWqzFNTSsXiX+l3WcjoKS3hUM/+9L/cWY26sHLJIlGMep/s4ITa2f0Cb
         GO9K7roALQV3Vx/gK+I6ZWGB6Dgifs6KgmwpvKq4Z0HaPjJEalcZEVyAc6RHIK+7jQqC
         SpUSAJBvNQx87rb3Heg+lDzSZpA34Q16uEM7XtPGq0+fXDtJu8fATQSes1LofFyX06u+
         WA6iVCuGExrn6PpvXC97y+uoPOJFcSHtDu4IkhFWcmbZQ/V/lUFEpc5hU91GgV0xeca9
         26ZQ==
X-Gm-Message-State: AOAM532Sp/2uqczM/j0W3CwO43jzy164Gu1O8/N6zj1GDh5521XDPck2
        b9fafFDULVRiSyeQ+8tOUXo=
X-Google-Smtp-Source: ABdhPJxCCpFnD8RC3sqORecPPgmDFztC1axiBnhKrKL5/Ox+u3A/SmKl8WeLV4P2fFmF7rf8jX1Buw==
X-Received: by 2002:a17:907:3fa4:b0:6fe:b83b:d667 with SMTP id hr36-20020a1709073fa400b006feb83bd667mr29460785ejc.481.1653656625909;
        Fri, 27 May 2022 06:03:45 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id u2-20020a17090617c200b006f3ef214de4sm1450501eje.74.2022.05.27.06.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 06:03:45 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nuZd2-000TVk-KO;
        Fri, 27 May 2022 15:03:44 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: js/bisect-in-c
Date:   Fri, 27 May 2022 14:52:11 +0200
References: <xmqqzgj41ya2.fsf@gitster.g>
 <220526.86r14g3yya.gmgdl@evledraar.gmail.com> <xmqq35gwyth3.fsf@gitster.g>
 <xmqqo7zkxdvu.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqo7zkxdvu.fsf@gitster.g>
Message-ID: <220527.86k0a72klr.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 26 2022, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>>>  Final bits of "git bisect.sh" have been rewritten in C.
>>>>
>>>>  Will merge to 'next'?
>>>>  source: <pull.1132.v3.git.1653144546.gitgitgadget@gmail.com>
>>>
>>> This topic has outstanding regressions in CLI parsing. I.e. we'll now
>>> offer to start bisection where we previously errored out on invalid
>>> command usage. See my replies in that thread.
>>
>> Pointers?
>
> I guess you meant this one?
>
> https://lore.kernel.org/git/220521.86zgjazuy4.gmgdl@evledraar.gmail.com/

Yes, sorry about the lack of specific reference upthread.

As noted after in
https://lore.kernel.org/git/220523.865ylwzgji.gmgdl@evledraar.gmail.com/
we're rewriting code in this case that doesn't have test coverage to
catch these regressions, so more than just a narrow bugfix I'd really
like to see a re-roll that gives some confidence that there aren't other
such issues by first adding missing test coverage.
