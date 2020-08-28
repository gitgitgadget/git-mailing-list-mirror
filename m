Return-Path: <SRS0=bfGv=CG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E43AEC433E2
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 16:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4CFB208D5
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 16:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgH1Q1o convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 28 Aug 2020 12:27:44 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:40396 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbgH1Q1n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Aug 2020 12:27:43 -0400
Received: by mail-ej1-f66.google.com with SMTP id o18so2292543eje.7
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 09:27:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=t9VMQU5TOXG2qoMsFktTxqx2/C7UKL0ZhMPNzEkkN8Y=;
        b=ECR8gJq9aUkX57ZOuFhOvRWeXwQWiMgvubZHpxtgKaNWBrMPkcF9JxHTGo7r0p5Oj9
         4o1P42xGzRtcmRb2u+KV+RPQbA1ZOKIB+3oPkBUR/mMbpLHkSpzJw9BpYxKarruH0Foh
         zlxgQouZVcbfqfKVb69Tpj4Ha0i3ChFUwu4qgBRfUOrEZZ+mZSM5noEh0OLzJ7s3Vlxp
         YTe15ETgXWopbYjAHHQhuIzKLDsYekz1eK6YDxymZXTS2w44cO/XnXe+hnWO23Du9UwE
         iFh6vpYR98gnahtl1VNfnwf5MQbnlI0Jrbf1YAknxmUTIDk8NQ37vGVt1P/IVXae9O6D
         qA6A==
X-Gm-Message-State: AOAM5306AroibevQjGEYoow3R9HCXPVuyk4AcYzOukaZJyrdKH5mPV/C
        hTVjAiQbVr3iTL8EYefxZBgPCg++ZPr/E2/w4fzz3XvDtNY=
X-Google-Smtp-Source: ABdhPJzTQCOPiEB0ar8g5+n3hBREhJYaABytcjCOktjUNHcbXK9gnS+3/4HtH1mYQmFCNiWRhJs68MTSrhPbLcW6Abs=
X-Received: by 2002:a17:906:2cc2:: with SMTP id r2mr2672111ejr.482.1598632061746;
 Fri, 28 Aug 2020 09:27:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200827082129.56149-1-sunshine@sunshineco.com>
 <20200827082129.56149-4-sunshine@sunshineco.com> <nycvar.QRO.7.76.6.2008280413450.56@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2008280413450.56@tvgsbejvaqbjf.bet>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 28 Aug 2020 12:27:30 -0400
Message-ID: <CAPig+cRt3-3g+GSDD9q6NkoaejwgKMPk6nuc+Lax9y8_ZFzZ6Q@mail.gmail.com>
Subject: Re: [PATCH 3/5] worktree: teach "repair" to fix outgoing links to worktrees
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?SGVucsOpIEJvdGhh?= <henrebotha@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 28, 2020 at 8:55 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Thu, 27 Aug 2020, Eric Sunshine wrote:
> > +     struct strbuf main = STRBUF_INIT;
>
> This is needed to shut up GCC's "‘main’ is usually a function
> [-Werror=main]" error.

D'oh, thanks. I got hit by this just a couple months ago[1] and (for
some reason) was even looking at [1] the same day I submitted this
patch. Will fix it in the re-roll.

[1]: https://lore.kernel.org/git/20200610063049.74666-1-sunshine@sunshineco.com/
