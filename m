Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CBD01F403
	for <e@80x24.org>; Tue, 12 Jun 2018 17:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754372AbeFLRgM (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 13:36:12 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:37327 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754209AbeFLRgL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 13:36:11 -0400
Received: by mail-yw0-f194.google.com with SMTP id j134-v6so637444ywg.4
        for <git@vger.kernel.org>; Tue, 12 Jun 2018 10:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bll/MVkcGT0HPr7YnDlAtMDVkrBpnCqYgxE3cyau9oI=;
        b=h6nY0gwCLYX9svDCTo7EwMIvI0DXbsnnUqtY5Qz1Cb/z8JB5L3MqmMyCWoncWuTd9c
         rMx+hwONzO9iez0I6kKywF4h/xsyW9YMrlpyHa/OFJ8TnF+sgucHhNu0sDRhag8QfuTE
         gu/FZajXMBtb+fWfaXoAxONbGGNN/P9Q+w1p1itzv1xPWo6zfZzWonfBUwIoQzzl615G
         nqSKaJthO2Lc1vzGykMgCwnQgeT3gUscXIkJcjJ54YMXx2l6JNTIlan4HxtCqpsHLF1c
         vOhC7WyLC2htYhI1w7IynM6Duaa5sFQrnjigaBA2Krar/gSzpkzg8yN4LJ+RIw2obVok
         fEvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bll/MVkcGT0HPr7YnDlAtMDVkrBpnCqYgxE3cyau9oI=;
        b=SER4M0j41SQROcziQhWYvEh3wSM2Qx+W7HEXNmM8CnO1BgTaErsK13+ROe68jFikAt
         T1LpXMSIaivVQuW9/ersH67nGMPTwOcCs9eMqCJ1ajDdlkHbdGZLLzEwSDgv+dFO2uft
         uFgaFJTCxUFBcbPviuzJUfcFF2xVOK+JPtdEm/bn2zu4eZu2uTE9o3NYWlsKI3NkkNXb
         2TxpPch66aRaMPad13qCFKX9oriOPFr3WHE1YIDZO6MKX0hDxkYe1cR8s1/T96hGRCGG
         IaJSRD8JXbF+xwFtDUTT6sda+CIeC6btRMzTGWVjQd7BAjCt8GYNP+FSY7ANKNXjteCq
         zQ5g==
X-Gm-Message-State: APt69E2n0nUPRs2eBOEbNuuxkC6QfIAc9BnaiOxLJfh+AAlIa6U/ZNyZ
        PkhtGcEBrv0rIGWrT6J6bvPgSfmOqPGhwdrC72uIgg==
X-Google-Smtp-Source: ADUXVKIg5MsdY1YQ52h/P7H6j6luTp1aWsKqYh2eENxXLsT5YwHE4eRDqY7Xlk2Ml3tUGrAP1eUdLZnXbHAmkyNpp8M=
X-Received: by 2002:a81:b283:: with SMTP id q125-v6mr658233ywh.414.1528824970406;
 Tue, 12 Jun 2018 10:36:10 -0700 (PDT)
MIME-Version: 1.0
References: <CACsJy8CNrQ-CKoJ+1NCR1rsO+v0ZNZ9CVAFsJpmcRWZY6HUtKw@mail.gmail.com>
 <20180609110414.GA5273@duynguyen.home>
In-Reply-To: <20180609110414.GA5273@duynguyen.home>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 12 Jun 2018 10:35:59 -0700
Message-ID: <CAGZ79kb3_0W7osWbU4tcvGvy0KVQJBpFD7q6njTjWJ7vOEmrtg@mail.gmail.com>
Subject: Re: BUG: submodule code prints '(null)'
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>, Heiko Voigt <hvoigt@hvoigt.net>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 9, 2018 at 4:04 AM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Tue, Jun 05, 2018 at 05:31:41PM +0200, Duy Nguyen wrote:
> > I do not know how to reproduce this (and didn't bother to look deeply
> > into it after I found it was not a trivial fix) but one of my "git
> > fetch" showed
> >
> > warning: Submodule in commit be2db96a6c506464525f588da59cade0cedddb5e
> > at path: '(null)' collides with a submodule named the same. Skipping
> > it.
>
> The problem is default_name_or_path() can return NULL when a submodule
> is not populated. The fix could simply be printing path instead of
> name (because we are talking about path in the commit message), like
> below.
>
> But I don't really understand c68f837576 (implement fetching of moved
> submodules - 2017-10-16), the commit that made this change, and not
> sure if we should be reporting name here or path. Heiko?

That change is quite interesting as I did not understand it at first
sight as well.
See https://public-inbox.org/git/20171016135827.GC12756@book.hvoigt.net/
and the follow ups, specifically
https://public-inbox.org/git/20171019181109.27792-2-sbeller@google.com/
that tries to clean up the code, but was ultimately dropped.
