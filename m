Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284DAC433E6
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 22:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF6E323600
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 22:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbhAGWik (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 17:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbhAGWij (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 17:38:39 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77857C0612F5
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 14:37:59 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id z5so7742150iob.11
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 14:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=5QtryUtB2geCFY9CXZ50ui0RLV2bSiCJJDxkKQ1wk4M=;
        b=EfSaGsN7RsbO1zkuO5HfqrlVRX01f+iWDcnXMqUNaq3SNRfWOsT/9SDKaFNaN5G+FQ
         d1D5v0bf7bDLNeSKn9I9kuA372VQ8L6s7iKcwNOE5bkHO8g89MCef/eZrnr3qb1HUFTx
         sAmnBD2/nC4VisRoAiKWkAOV5oO6KR3JRfEAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=5QtryUtB2geCFY9CXZ50ui0RLV2bSiCJJDxkKQ1wk4M=;
        b=TvpL2Fkk76deZnJI8D0CUG0zjxvV3EyLd93izDuVZFu0y30Gie5x87xArLv2aX/FP7
         dNUg9kLh+UTOSZj+FSuXFxFipfAN800TpiCuIsb6VXiUZx3tA+Oj12ALRFWImkpYhovH
         VPsvdJS7GOj2hpzWPvx5RHph9Pre9MEhw8oJEvgF4Tgg0/7cUwkapjFZnS8qre8SzLCS
         0A8VTJ6uB5Fnda2rf3hSlH6gYIkIvh33iJcJ1MoBDioYa1Lx8Q+kG/svqxNRzXtri7q1
         hPid/TyDhWuqQxFSrtM1i2GKTmQ9G8WiWOpoxswImheO8Kc6ZHif39YOIW6IZcL3Cp0K
         2G1Q==
X-Gm-Message-State: AOAM530cn2By0od6Ji60D74lxq7vLnkFILK9K9JYHhTiEv17eY1GRS5L
        VM5AnP0DAfOhu0cxZVCg0ixLzA==
X-Google-Smtp-Source: ABdhPJwBu/U2oWoAFIjtg0bKrtsShoXLlkESPy5VV1tepO0z+3N+p2aO5VSdPIZkUholmox0nOvGZg==
X-Received: by 2002:a05:6602:3303:: with SMTP id b3mr3006567ioz.179.1610059078649;
        Thu, 07 Jan 2021 14:37:58 -0800 (PST)
Received: from chatter.i7.local ([89.36.78.230])
        by smtp.gmail.com with ESMTPSA id a15sm5304752ilh.10.2021.01.07.14.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 14:37:57 -0800 (PST)
Date:   Thu, 7 Jan 2021 17:37:55 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        jrnieder@gmail.com, git@vger.kernel.org
Subject: Re: Patchwork instance "Submitter" attribution and GitGitGadget
Message-ID: <20210107223755.6fg77xjdbqiscwb2@chatter.i7.local>
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>, jrnieder@gmail.com,
        git@vger.kernel.org
References: <75987318-A9A7-4235-8B1D-315B29B644E8@gmail.com>
 <nycvar.QRO.7.76.6.2001201314580.46@tvgsbejvaqbjf.bet>
 <xmqqiml4bsra.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.2101071534440.2213@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2101071534440.2213@tvgsbejvaqbjf.bet>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 07, 2021 at 03:35:54PM +0100, Johannes Schindelin wrote:
> > Would it help to use the "Sender:" header?  IIUC right now GGG
> > records its name on "From:" with its e-mail and a human-readable
> > name derived from the author of the ptach, but if it can record the
> > true author on "From:" and leave GGG's name on the "Sender:", would
> > patchwork use the "From:" side of the identity instead?
> 
> To tie up that loose end: GMail seemed to insist in my tests on replacing
> the `From:` header, therefore we cannot implement this `Sender:` idea, not
> using GMail to deliver the GitGitGadget patch series at least.

Can you possibly set X-Original-From: in the header? Patchwork almost does the
right thing with it, though right now it expects that the From: will be set to
the list's email address (which is only correct for google groups).

We have a workaround for the current situation on patchwork.kernel.org [1],
but it requires parsing the body of the message instead of just relying on the
headers.

> > If that works, it would have an additional benefit of not having to
> > add the in-body "From:" to override the mail-header "From:", to avoid
> > attributing the authorship to GGG.

Using the in-body From: is both good and proper for such service. Trying to
put the author's email into the actual From will run afoul of SPF.

-K

[1] https://git.kernel.org/pub/scm/infra/patchwork/procmail.git/tree/git.rc
