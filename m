Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD36C433E0
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 22:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0D7164F1B
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 22:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbhCRW5c (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Mar 2021 18:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbhCRW5S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Mar 2021 18:57:18 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1727DC06174A
        for <git@vger.kernel.org>; Thu, 18 Mar 2021 15:57:18 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id k14-20020a9d7dce0000b02901b866632f29so6784807otn.1
        for <git@vger.kernel.org>; Thu, 18 Mar 2021 15:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0+ANMLcrPy+asEbdLb1vhQINbj+K+2vuqTk4pwrUjTw=;
        b=jkf3YzaIUPj4G1rYQx+R9gBmRPckKgS+aH8lgCFp1sbm/Ns6k+08nMxQ8A9a5gwZQB
         sai5XS4691DL/F3u2so1BiPuz/SABgYPDrMI3ZgclhfVOKGgjixJCkUVGDVfLXTwEPqD
         shcJ7+51Xnv1P7PfjemiTUbcqhE4DNOy30urXZNaAkQGLC6urS7jU9pwcyuDxDzMdcn5
         fUzMmqYL2C0mENVEgpW1oyVep7Q+v2JVyUZF1fUyxgMwSi/0VL04liJ0BzX8ao95I0Lt
         vluA0efW84NJM3zmKMkx2jjhSmgtuXGSQcNd7ArNCYpoWAZCFJy3MSI/RMx66tauyd44
         Rebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0+ANMLcrPy+asEbdLb1vhQINbj+K+2vuqTk4pwrUjTw=;
        b=lhCGJFNr5mmbwp717XcIAYBsXqH8/NIo92ByoKJ14BIPkJ21AKKbgn5mFxf7s9r9Eg
         IFScUDmFKSev1Nf5MBksvd2gkd0PA49AdsOteukki1BY4xwxGMZvMxvpRfRDY6pqd8Xa
         DTNuEGhGN+MjG5pNz5AG/fUKuIHpZAkypMDEF9O+8gFaE0+rVEAVybhtxL5Q5SUk/O1M
         M24Zc52hK2Vua7CTt/yYhtBk4BoWBPaWVQL/As2V5ppqBTjQzgVXm78h0/dwSku6Hn0d
         85qG1sfM2Y1+doA7MWRBd+x1kysD6XzmsaLNHx8DJwYdqUJnn9bVMROe6U1z23PvIXrX
         RabA==
X-Gm-Message-State: AOAM532lAG/cpGBQtSMoX+/BWHdYMbDjoXHfWcZYVz17peVP5oh/HUNh
        RZlJrX4Ucqnh3EOHn9Br2kqoXj5ZeT6Z0pqpF+I=
X-Google-Smtp-Source: ABdhPJxvM2J/KJ1mAgAjiZHv3B5kmzWDzeQhyOfqiuaI/yGq9S1yhVri7mGSCd8SkWywApeqmJOgf0SmCsBIQ1EJfAg=
X-Received: by 2002:a9d:628d:: with SMTP id x13mr8675770otk.19.1616108237463;
 Thu, 18 Mar 2021 15:57:17 -0700 (PDT)
MIME-Version: 1.0
References: <pull.903.git.1615760258.gitgitgadget@gmail.com>
 <pull.903.v2.git.1616016143.gitgitgadget@gmail.com> <afd326c5011b09d89b6354817c1913d85142c335.1616016143.git.gitgitgadget@gmail.com>
 <xmqqk0q4rxxh.fsf@gitster.g>
In-Reply-To: <xmqqk0q4rxxh.fsf@gitster.g>
From:   Nipunn Koorapati <nipunn1313@gmail.com>
Date:   Thu, 18 Mar 2021 15:57:06 -0700
Message-ID: <CAN8Z4-Ug4i-zBrz0xSRXZUCM5+50Cg46m6Ap5rsJWHu+=Nr6eQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] fsmonitor: add assertion that fsmonitor is valid
 to check_removed
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Nipunn Koorapati via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Nipunn Koorapati <nipunn@dropbox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 18, 2021 at 1:47 PM Junio C Hamano <gitster@pobox.com> wrote:
> Isn't this the other way around, wrt to the previous step?
>
> At least, "pass around istate throughout the callchain in the
> diff-lib.c file" change should stand alone and come much earlier in
> the series (perhaps as step #1).  Then "call refresh_fsmonitor from
> run_diff_index() and make sure in check_removed() that fsmonitor
> does not have bogus VALID bit" assertion should come on top, as a
> single step, I would think.

Just to make sure I understand - it sounds like you're recommending I
split this diff up into
two parts - one which passes istate through the callstack, and a
second which provides
this assertion. It also sounds like you're recommending reordering the series to

1 - pass istate around callstack
2 - add is_fsmonitor_refreshed and use it to assert fsmonitor is
refreshed in check_removed in prep for usage
3 - use fsmonitor bit to save a call to lstat
4 - Add perf benchmark test

This makes sense to me - and I can execute the factoring in the next
patch series iteration


--Nipunn
