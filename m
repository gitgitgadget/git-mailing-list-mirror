Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D163C4332F
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 09:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiKUJkq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 04:40:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbiKUJko (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 04:40:44 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCAB905BE
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 01:40:43 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-39e61d2087dso32621057b3.5
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 01:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TwUXeNyJJY+6Jmdgbh4wVJyh/zdxT/OpBSHStYlQLH4=;
        b=gLeOIxo7QT8E1BJfeg1NP1oGA+klEqZbqh0G4dcaVnJ0gB4PHMZ3Ou7AJZDTtA8uNv
         zXBw1HBFG/SYSjN881BCjHI0l0a/aiJzCrtemOTOFauYozPLGbStgP567Tgtc9H6YWyj
         qNhcWGbbeAVR3Frj+ADPG9OIc4MHyPgFcSnsGFvbbl9vCt6GznWqpe3DHGjANAo7UWv1
         ryBBk14mpaOCo+Peqc4VNp1Pg6rUBx+fKl93Ii38AGLeHVBCe0O7yHQKQW9q0jGMxwVQ
         +hhdQ+f9v6+nRpXo+qmtPemL7NQvova2rbMDjYdl3Nm1ie8Yn9ZqG5d7HyXhHAfYfcRp
         WhTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TwUXeNyJJY+6Jmdgbh4wVJyh/zdxT/OpBSHStYlQLH4=;
        b=uAACk6sEGNiExH0AaoHskyuTR5LTDUlzMQluoCTvF6Q8LqkLAnDcRy6XZ02Tvoh57U
         1L7zAozrS/SHA7GIzgCHLNUV1ScbagvaoUtlMk2XlYX4Xm7knzp8oXl/DyYdu/EyEY62
         DROCFdJ3ag9zyC7MYeQJMq5UI5jzaK5DIy7anYQRdxSC7jEf9O1cbtuBRBZbe3fm+j79
         mn//JGjTqOVCLrQOPd6XmHu4aB4CwTNVHlRHXsdd9+7spvUeBLmtjGxd6fVz6n4bKPH2
         Sf3ZJ3bnzi6vbTGgLeeazJ3q0dAvslku3slq2KVV03T1RU1maStm9ji7bWwbgJ5pA7K5
         eSGA==
X-Gm-Message-State: ANoB5pnSN6LSlTKRNiFPcs5oLZmsOjIE2CVayowERIfdEsmygMcCgblU
        BjjO+gr9lOKSpjFLtgtyI1b/RfPXTn4fxkn9MyM=
X-Google-Smtp-Source: AA0mqf442dkil8dFL1ub0G4pwj134Gucz4i6FcMbcN6MfdDi8kKZZdEaHecoOa5EGShLEAbA6LaH8MotbqoRX8q0uL4=
X-Received: by 2002:a81:25d8:0:b0:373:4467:e0c6 with SMTP id
 l207-20020a8125d8000000b003734467e0c6mr16304805ywl.340.1669023642535; Mon, 21
 Nov 2022 01:40:42 -0800 (PST)
MIME-Version: 1.0
References: <20220916205946.178925-1-siddharthasthana31@gmail.com>
 <20221120074852.121346-1-siddharthasthana31@gmail.com> <20221120074852.121346-2-siddharthasthana31@gmail.com>
 <xmqqy1s4wyvf.fsf@gitster.g>
In-Reply-To: <xmqqy1s4wyvf.fsf@gitster.g>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 21 Nov 2022 10:40:31 +0100
Message-ID: <CAP8UFD1CB90eoWpQmGJbfxK7uHX0-u4BuSE-v=mD1yuW+nnAxA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] cat-file: add mailmap support to -s option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Siddharth Asthana <siddharthasthana31@gmail.com>,
        git@vger.kernel.org, johncai86@gmail.com,
        Johannes.Schindelin@gmx.de, avarab@gmail.com, me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 21, 2022 at 8:27 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Siddharth Asthana <siddharthasthana31@gmail.com> writes:
>
> > +test_expect_success 'git cat-file -s returns correct size with --use-mailmap' '
> > +     test_when_finished "rm .mailmap" &&
> > +     cat >.mailmap <<-\EOF &&
> > +     C O Mitter <committer@example.com> Orig <orig@example.com>
> > +     EOF
> > +     git cat-file commit HEAD | wc -c >expect &&
> > +     git cat-file --use-mailmap commit HEAD | wc -c >>expect &&
> > +     git cat-file -s HEAD >actual &&
> > +     git cat-file --use-mailmap -s HEAD >>actual &&
>
> Doesn't this break under macOS where wc output tends to be padded
> with SP on the right?  We used to often see test breakage when a
> carelessly written test like
>
>         test "$(wc -l <outout)" = 2
>
> which expects the output file to have exactly two files (the
> solution in this sample case is to lose the double quotes around the
> command substitution).

I guess that's the reason why `wc -c | sed -e 's/^ *//'` is used in
the strlen() function in t1006-cat-file.sh. There are a number of
places in the tests where wc -c or wc -l are used without piping the
result into sed -e 's/^ *//' though. So it's not easy to understand
why it's sometimes needed.

> Besides, having "cat-file" on the upstream side of a pipe is a bad
> practice.

Yeah, right. So I would suggest the following:

     git cat-file commit HEAD >commit.out &&
     wc -c <commit.out | sed -e 's/^ *//' >expect &&
     git cat-file --use-mailmap commit HEAD >commit.out &&
     wc -c <commit.out | sed -e 's/^ *//' >>expect &&

Thanks!
