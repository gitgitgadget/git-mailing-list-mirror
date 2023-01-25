Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B528C54E94
	for <git@archiver.kernel.org>; Wed, 25 Jan 2023 17:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235919AbjAYRNY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Jan 2023 12:13:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236083AbjAYRNH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2023 12:13:07 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFD7D7
        for <git@vger.kernel.org>; Wed, 25 Jan 2023 09:12:43 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id g23so18451409plq.12
        for <git@vger.kernel.org>; Wed, 25 Jan 2023 09:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=028lDLGXk9A0XBf+OCvPaIxKzYuca/bX3PQ8PT8YZ8E=;
        b=Y31cJvXbmjLwQmRpcEh7KzVDVx4ks7L5E2lP/0SET2SxfBlH6PJgP7liP+NFzAGmYl
         er2TlR52HIlaut4Op+AQwKh/43qPKudGKPoB0iv6HbkQQ+Eonpu6n0AOIw49Dkihmizl
         rVCkWGpmpDu8FeUyu2lBk2XwRuGZ8FxCF28uNYNMAKH7ji2cE/M6f6DomQrHKVOV+foU
         oOrNy4RLmJB0zvNcDhd+InnpaFJZF6nkwyoPsFaffoB0+PVEx20H/+rsIiWGC5Sh//FY
         9sx/VUrS60g1ZKhcC7Krf8bJxh5qT6CJTIhO2yuz1GHsuLmqBsMa2YBgTiBE1UiKGTc3
         MzLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=028lDLGXk9A0XBf+OCvPaIxKzYuca/bX3PQ8PT8YZ8E=;
        b=L4VI+JcP9GGDG8sFn3C+rK8RfcLSbmvwbTvkpQ//SlPfZ3670fMg6v8pzGAy7Isu/R
         2Yb92Vw4WSkeU6oMQ8qc94YiCzdA+my0q204uQta8F7otxNXtWbxIclrAS4MEM0rUhFo
         uqgolsU9yDE+yzxUNaTIs2qKchR9TQ8ktl8kCOx7ooqR9MsHADWogTBhpKByLLa+K3MI
         oLq0KtFcXDo7Fg0rsECMJGbATNo4Cg+nEfRPPR9DxfOOqK5H3xeDicAlVA+kxjSgyhvH
         dNZ0rscvB5Vgl68UClFZF4LXCjc3gh7/xiy/kcWnqvMJTWS9c3h8e81Vgq9fKr07HXWR
         cEMA==
X-Gm-Message-State: AFqh2kr8x29mcM3NulBRCt1GR/5cn0CbGRRXAAs8rkPbGh+3iun/R2nu
        e4CrE/CLEs6X2sDxh0z/L98=
X-Google-Smtp-Source: AMrXdXvwIsMRtPr1ustUd1YYa0Opf04TjSLMLACHMzaiRPVUyQCL/QR1NOt0qyi4RReliSYLpxbr/g==
X-Received: by 2002:a17:90a:2ecc:b0:226:7b3e:dea5 with SMTP id h12-20020a17090a2ecc00b002267b3edea5mr58382676pjs.36.1674666760563;
        Wed, 25 Jan 2023 09:12:40 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id p7-20020a17090a680700b0022c19bb0689sm96321pjj.45.2023.01.25.09.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 09:12:40 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: A summary of in-flight topics
References: <xmqq7cxbftvu.fsf@gitster.g>
        <CABPp-BH0LwHvN_bXp0BpekQ+f+15KNXQRzf5LCn3_BhcPzB-3A@mail.gmail.com>
Date:   Wed, 25 Jan 2023 09:12:39 -0800
In-Reply-To: <CABPp-BH0LwHvN_bXp0BpekQ+f+15KNXQRzf5LCn3_BhcPzB-3A@mail.gmail.com>
        (Elijah Newren's message of "Wed, 25 Jan 2023 08:05:57 -0800")
Message-ID: <xmqqzga6edx4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Tue, Jan 24, 2023 at 2:37 PM Junio C Hamano <gitster@pobox.com> wrote:
> [...]
>>  - ab/sequencer-unleak                                          01-18          #8
>
> Perhaps move to "Expecting a hopefully minor and final reroll"?  See
> e.g. https://lore.kernel.org/git/xmqqedry17r4.fsf@gitster.g/ where you
> commented on Phillip's approving the code changes but wanting a number
> of commit message cleanups and fixes.  Ævar did send a v3, and Phillip
> commented on two of those patches, suggesting one could still use some
> commit message cleanups.

Thanks, you're right.

>>  - ab/various-leak-fixes                                        01-18         #19
>
> Isn't this already merged as 9ea1378d04 ("Merge branch
> 'ab/various-leak-fixes'", 2022-12-14)?

The cover letter of its first iteration says

    This is a follow-up to the ab/various-leak-fixes topic merged in
    9ea1378d046 (Merge branch 'ab/various-leak-fixes', 2022-12-14). Like
    that topic this is mixed collection of various leak fixes, all of
    which should be simple to review & reason about.

Unfortunately the text does not appear in the cover for the
latest iteration, but that is how the topic name was reused.

THanks.
