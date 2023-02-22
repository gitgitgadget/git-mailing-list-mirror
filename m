Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79245C61DA4
	for <git@archiver.kernel.org>; Wed, 22 Feb 2023 23:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbjBVXdm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Feb 2023 18:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbjBVXdl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2023 18:33:41 -0500
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302B8C654
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 15:33:34 -0800 (PST)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1720433ba75so12222975fac.5
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 15:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GgorQTHhTufpsRt+nLLEspo6ZGwk+9GFbYZJHXQvxMc=;
        b=orlFEdYGI7B+xxCSMJjC0NyydhcaZLYoGhk5qO13IXmeheIfGNj0bWF+VaSPQMYesJ
         ZoYOkY1t9nwT5nN95ty9FqEppPtqjctgdDSGR1C8hWRJJP1TgmZD37bGGdKiY8XzVox8
         QD/82xdhcBKLGmTHq71+wDRNzv0NLa2VxiLUu7xnrwzcRuIs8EmXhSInaBYWoSgkeO8P
         ND3nEExp82LHAN4VnJjjGC4W9Y6xLfK8zQ1vHGNvteguBrcWcYfWsWTVILaixxDsDpGf
         MnKdVFFYij5UL/YeRtAGuVB9oDpNdiqNIROxlozBXi1xQrTSdqD5+0Ns2Jn84LkYb0az
         lvcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GgorQTHhTufpsRt+nLLEspo6ZGwk+9GFbYZJHXQvxMc=;
        b=fsdLvUdJIXFCqjN0GYT37ow53o98Hpr2y2Mey3bK/s3gez4137QzyWaohh/0q/Rxay
         7QAJdz5MRyQw00wQbiNycerRlixLhhwNdaENbVTvi1DTFDajPKbM5LDpil4TxoNPeNX7
         L+vOCXJavSb7h2niTwxamT9dMPmTBtUm8nFP1fIS9YjPdc+jxT44S4nYs1ln87RlQoHn
         8clCbxXIBQIwJy3KcZatl3fRHSzcRmpW4tCQVvNlmrqlMmgygytT0y+Z5hYNGKA5D6Ca
         HVTi5ek3yken/kJPb2nKE5lnrDmRv7JEe8B1in1Wl0umwy/tqujSoi5TCoX/j12WN/wS
         OvDA==
X-Gm-Message-State: AO0yUKXCpnPrjQYAK0tklfgSxEIdcLq9IFxK/2iAjU1oOezlXfJAWh9U
        fkRKizTh406qUSRwto1Vlz91P3WrGDS4F2jidwY=
X-Google-Smtp-Source: AK7set8mP/6QtX0/+ka78dJ7hS6SxcjmwgikP1Nb++pXZa7b+KuFXYsyckY0gLPu5wzAAawiNedCVOQ8kNeQZhM/Bo8=
X-Received: by 2002:a05:6870:75c5:b0:16e:4b62:df20 with SMTP id
 de5-20020a05687075c500b0016e4b62df20mr950312oab.141.1677108813457; Wed, 22
 Feb 2023 15:33:33 -0800 (PST)
MIME-Version: 1.0
References: <20230221055805.210951-1-alexhenrie24@gmail.com>
 <20230221055805.210951-3-alexhenrie24@gmail.com> <852c6efd-49a7-f6f0-dd6a-b28cb0909784@dunelm.org.uk>
 <CAMMLpeQ9gEKNX5VtGCgLL_Qzk59ZYji57u-SPy-XeSRPuF2NwA@mail.gmail.com>
 <f0d0a3fb-d7eb-84d6-7852-0d30eb38af63@dunelm.org.uk> <xmqq8rgpcn8l.fsf@gitster.g>
In-Reply-To: <xmqq8rgpcn8l.fsf@gitster.g>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Wed, 22 Feb 2023 16:33:21 -0700
Message-ID: <CAMMLpeRXYm-Qtr6556fZxmND+stku9cK+aBGr7h7ezw+Mrg=-g@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] rebase: stop accepting --rebase-merges=""
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
        tao@klerks.biz, newren@gmail.com, Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 22, 2023 at 3:18 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> On 22/02/2023 01:38, Alex Henrie wrote:
> > On Tue, Feb 21, 2023 at 3:55 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
> >>
> >> Is there a particular reason you decided to redo the option parsing
> >> rather than just calling parse_merges_value() from the existing "if
> >> (rebase_merges)" block? I don't think it really matters, I'm just curious.
> >
> > Without a parse_opt_merges callback, how could we know whether the
> > user passed --no-rebase-merges as opposed to passing nothing at all?
> > const char *rebase_merges would be NULL in either case. It's an
> > important distinction to make because --no-rebase-merges overrides
> > rebase.merges but the absence of a command-line argument does not.
>
> The usual way we handle that is to set the value of rebase_merges from
> the config before calling parse_options(). However your solution is fine.

On Wed, Feb 22, 2023 at 4:08 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Is it?  If it is not too much to ask, I'd prefer to have code that
> does not surprise people, and "the usual way" you mentioned is what
> readers around here expect to see.  I didn't check and think about
> the patch in quetion, and especially the existing code that the
> patch needs to touch, too deeply, so if it is too convoluted already
> that it would be a lot of work to make it work in "the usual way",
> it may be OK, but otherwise, the solution may not be fine.

There was a const char *rebase_merges in cmd_rebase and an int
rebase_merges in struct rebase_options. I deleted const char
*rebase_merges, leaving only int rebase_merges. int rebase_merges is
set from rebase_config before it is set from parse_options.

Do you want me to add back const char *rebase_merges? If so, where
should it be declared so that it can be set from both rebase_config
and parse_options?

-Alex
