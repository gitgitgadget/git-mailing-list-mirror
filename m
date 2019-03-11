Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 729D920248
	for <e@80x24.org>; Mon, 11 Mar 2019 09:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfCKJ1y (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 05:27:54 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:38849 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbfCKJ1y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 05:27:54 -0400
Received: by mail-it1-f195.google.com with SMTP id l66so6157388itg.3
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 02:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Slm1DFpBZOAIzv6iQAa6xCH+IhhtSDo4sFhWhnHHnwo=;
        b=CHbdC47neDgGYDQJjeZe56UQEIk6MG6AMa4evoC8sIS2fyESyDJK4FNUyZ8GqxOI1f
         1DGK3eN8lLsYmQ2tuqoH2AJ1kyno1dDxjPNVPGyMtKLe/eG7xkLW5WuCw6urH2d6QpOn
         rEmU0uKWa+YGs6KsOr5vp9RiHHkBPQTJ+szhPopWiIg2t/itGupVDMvCCpANowcNIvu7
         mwKYIQfSkDQLDk0DU5rGkEZeSTF6ywNqOlWhEe+NnPX4uYI/AS/cfyT0T3rxY/6zezyW
         Li8vFBoEeW2NXKgSxDNxgM/UB83g8vMrMNi8Aa58vAIfCkF8mHCsNfZAvtGXtoiacGL+
         gc3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Slm1DFpBZOAIzv6iQAa6xCH+IhhtSDo4sFhWhnHHnwo=;
        b=cmQ5i7BBL4pUGFIDCaP7yCbPfGwsWvnFubMbVv7OuKD9lEcY53chzccQlNmrcDYRNR
         7v4Lwdcqrei7RIykgc2SCXibaw7ZHRpXJ5Dc67G4scxLeB2Eu/GCS7Ezi5VOYWJJLP5/
         0PZpEzgNh7sTLSXY8vRhk+u8QGuG+Bl4qo25u0GsqeDEEwAR9/1oR5WiHfiYeHIN0eaa
         AYnCdTnWzvESLnj+Octs9RejKQjBMTH4Oq//1lzw6MTr3nFgOgJx+IydaB3as0/lAOgv
         5/sjLGt1UhhyjOMWYxSJW5nLalnxZuqhsePMI5Zf14mKdkDjGSXsPjk4YV4DKMwtBBzj
         sOgw==
X-Gm-Message-State: APjAAAXVaghURVdcE9s9DTKdIj99hxeAuNMYq1evhU9CtjN5MoTakX4k
        MQiFlrM6psmjaWHw6uRFrfe1IfF6OcvTfB7Qd5A=
X-Google-Smtp-Source: APXvYqyyaBnV+x7GLstojjBp0ek3wTvDo3JRCPF8lHDZyTMPdOLQHPO70qNv1bfc/92akT/mmUhLjSMPxog/WrBt20M=
X-Received: by 2002:a24:7542:: with SMTP id y63mr15277978itc.70.1552296473106;
 Mon, 11 Mar 2019 02:27:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190305120834.7284-1-pclouds@gmail.com> <20190308092834.12549-1-pclouds@gmail.com>
 <20190308092834.12549-2-pclouds@gmail.com> <xmqqtvg9kjdb.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqtvg9kjdb.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 11 Mar 2019 16:27:26 +0700
Message-ID: <CACsJy8D2qmu5PpC=--y+_g-dyztzxumo2bKD-ufwd79nm+Pw9g@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] worktree add: sanitize worktree names
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Konstantin Kharlamov <hi-angel@yandex.ru>,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 11, 2019 at 1:36 PM Junio C Hamano <gitster@pobox.com> wrote:
>                 while (...)
>                         ; /* try again ... */
>
> This "strip all .lock repeatedly" made me stop and think a bit; this
> will never make the component empty, as the only way for this loop
> to make it empty is if we have a string that match "^\(.lock)\*$" in
> it, but the first dot would have already been turned into a dash, so
> we'll end up with "-lock", which is not empty.

Yep. I added a BUG() check anyway in worktree.c just in case something
slips through in the future.

> > +     }
> >       return cp - refname;
> >  }
>
> See below for a possible further polishment.
>
>  * The first hunk is not about this patch but a long-standing issue
>    after the comment was given to this function for a single level
>    (I do not know or care how it happened--perhaps we had a single
>    function that verifies multiple levels which later was split into
>    a caller that loops and this function that checks a single level,
>    and the comment for the multi-level function was left stale).
>
>  * check_refname_component() can now try to sanitize; document it.
>
>  * The last hunk is from Eric's comment.

Thanks.
-- 
Duy
