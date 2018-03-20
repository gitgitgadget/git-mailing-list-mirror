Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 426651F404
	for <e@80x24.org>; Tue, 20 Mar 2018 19:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751411AbeCTTcc (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 15:32:32 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:44385 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751320AbeCTTcb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 15:32:31 -0400
Received: by mail-wr0-f182.google.com with SMTP id u46so2892791wrc.11
        for <git@vger.kernel.org>; Tue, 20 Mar 2018 12:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=J3y/gVhfOHL01rJkYJaKrDUpKa9UAQW9Gd8d7Du1thU=;
        b=szrcgWUVbWR+BWwEQrk9RcUWP3007fHXld86A0WcvBay2yOM7//PKOwONKjafN9SiH
         WmrBA5iFw+8djTi4ex5L+cTPRKN6OZ1AN5NYr9pFIjuSSeQUtxbuUzM1bUVBGkK1cK2f
         NzqwD0+ZhOLgSwex+E/VAwKN784RMdLeZYTaSMozED3Bv6DkFJqo7QkaR9ByYzVeE7CC
         9T0Qetj7YupP6npM6SSwavV3I7srbk9xB6vC1IIld2M00Y2NwqeYYn3wMl+xqK0xYO1m
         NhU+BRRaQDkE1EXUhdx40Tpuk5d16C0SIGU5Hl5ZaB05u76Sv0pfgeEdYX/5sTKrzHFe
         zFsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=J3y/gVhfOHL01rJkYJaKrDUpKa9UAQW9Gd8d7Du1thU=;
        b=C68A6tArkQ7YPGFJ8m/bOyYNGJNXP0PdrRyayscIc1KjZu7H3KYa/NXcyGAjdBxALt
         g+8MlDa8IlGW6LC5LWQhHOAxoww43xvU+nRFkfJAKxb17/ZQsOPlj8jmkVk8E474HOWJ
         LcTqmQ3wngxEkvjMthnGhCzlO9kNo4ALacAWgyrhzcOHUY/QRBExnSwHamndQWilyMSx
         61tY1Wl67cXde9czghlAiA900VGERTVcDrXcVLiccePJYsfOdikB3/OAZmmvBWZ3RJ71
         n2Nal4Sd50QcvO8Ss+ZsJ8Aophw19Gbb7MYT/qiH5KlN3TTwXIiYvWVy8IHSMWQZWdw7
         Crbw==
X-Gm-Message-State: AElRT7FnYAhQ4jxRPzI+t4ODSDNt6GAm11WVBoSC+QI32x8V97RCyKd8
        LJJpJncLQE9oFJpP6nziUe8=
X-Google-Smtp-Source: AG47ELu3PqtFvvbWKNZrTe/mcU6Zvx2yu2tAIoYrRWqIv6vYu0b0boWdDUk0+kLgLsyYQYOwnRj0Cg==
X-Received: by 10.223.135.14 with SMTP id a14mr14711713wra.261.1521574349691;
        Tue, 20 Mar 2018 12:32:29 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u62sm3200160wma.15.2018.03.20.12.32.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Mar 2018 12:32:29 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/2] rebase --recreate-merges --keep-empty: don't prune empty
References: <20180320101114.17663-1-phillip.wood@talktalk.net>
        <nycvar.QRO.7.76.6.1803201639540.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <e306f33a-3cd9-b753-ed61-66b7ff614087@talktalk.net>
Date:   Tue, 20 Mar 2018 12:32:28 -0700
In-Reply-To: <e306f33a-3cd9-b753-ed61-66b7ff614087@talktalk.net> (Phillip
        Wood's message of "Tue, 20 Mar 2018 18:40:45 +0000")
Message-ID: <xmqqr2oer19v.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> On 20/03/18 15:42, Johannes Schindelin wrote:
> ...
>> As indicated in another reply, I'd rather rebase the --recreate-merges
>> patches on top of your --keep-empty patch series. This obviously means
>> that I would fold essentially all of your 2/2 changes into my
>> "rebase-helper --make-script: introduce a flag to recreate merges"
>> 
>> The 1/2 (with s/failure/success/g) would then be added to the
>> --recreate-merges patch series at the end.
>> 
>> Would that be okay with you?
>
> Yes, that's fine, it would give a clearer history

With or without the above plan, what we saw from you were a bit
messy to queue.  The --keep-empty fix series is based on 'maint',
while the --signoff series depends on changes that happened to
sequencer between 'maint' and 'master', but yet depends on the
former.

In what I'll be pushing out at the end of today's integration run,
I'll have two topics organized this way:

 - pw/rebase-keep-empty-fixes: built by applying the three
   '--keep-empty' patches on top of 'maint'.

 - pw/rebase-signoff: built by first merging the above to 0f57f731
   ("Merge branch 'pw/sequencer-in-process-commit'", 2018-02-13) and
   then applying "rebase --signoff" series.

Also, I'll revert merge of Dscho's recreate-merges topic to 'next';
doing so would probably have to invalidate a few evil merges I've
been carrying to resolve conflicts between it and bc/object-id
topic, so today's integration cycle may take a bit longer than
usual.
