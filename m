Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0BA41F453
	for <e@80x24.org>; Fri, 26 Oct 2018 20:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbeJ0FVW (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 01:21:22 -0400
Received: from mail-io1-f74.google.com ([209.85.166.74]:50180 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbeJ0FVW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 01:21:22 -0400
Received: by mail-io1-f74.google.com with SMTP id q127-v6so2007705iod.17
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 13:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NsNqphqv04RNIMicGYs8zg5bzeRKZjbVsdgDEV3pmI0=;
        b=tx1Yt62ZdCc2BMspQbEoX2BCnjbozWgbCGIn/DHRgsZtnzy80+iR43oKCDO8nZeHw2
         9lUz288pRwLFz/hqIxB666KfFmLzkr9IY8PEkYkB5LyP0O2M5+NShX03tYwenmwzp5Hn
         LR3NHqvf9+M/BJc6OgQl2BaFiUgLwWvuM5Panax2k7KszK/ZFLeyj34dwKStCyhg/Qex
         Teq+zzGTSiWffvuhKIFv5C5kQ3k86kHO6WYlAiduOFTETi0HcY+d0dghM1RFi369VjcN
         HyonTDZRsjlzzwo4wvOmi56cTBxBZsFmhbb68TD4/0stfiaBIkiF6dfvePGsdZFh/JIc
         SjtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NsNqphqv04RNIMicGYs8zg5bzeRKZjbVsdgDEV3pmI0=;
        b=kX2nBIIEfYYWq2YSJGJ3nL/m6stk5NqbK8+hiVXJvyewZMd+L7LwrmC/B585JBx/yb
         xF3a6U++zWYYKFQhKI7VMVnKs4il0+e9hSvLuMoh6w81aUt2DuSJ2mQ4jHNmpdfrvkuQ
         6gDR6iU6ajdGWr2Y+QPPrVUGnEZaBsFEEjypdo48/jIee3+PoSYtWRSLQ+wywIgJU8Vx
         Y3tesVYo/7IQOLW5/J5WpmwB/gOBNooaTi5Iue6EPTUtzeixTozWBdtIFKBTIj2+MoTg
         lgtiDy2fikXMz+pzyUJ2kE+YwXMI4ch4DvjbQ/4SrNmRvXTr0WWaQyE65GSiWannDOsd
         z0eg==
X-Gm-Message-State: AGRZ1gJwfupiUGLOTgyiMRoAlyuoub7SZBAyg9LWofYg3ixncfjHl6+9
        ikihvCLcwTVyO1h5YR4+FOXTS1B48CYKUgvx288W
X-Google-Smtp-Source: AJdET5fM0B6bu7wl2LYoRP82+tTCkOJztDMB/q/a3QfpwKEak9jpq6SfqoLs1OmeHgjRRM1PswXYt/OerDz2HsyjTMH/
X-Received: by 2002:a24:73c2:: with SMTP id y185-v6mr3637169itb.32.1540586572720;
 Fri, 26 Oct 2018 13:42:52 -0700 (PDT)
Date:   Fri, 26 Oct 2018 13:42:49 -0700
In-Reply-To: <20181025233231.102245-11-sbeller@google.com>
Message-Id: <20181026204249.132969-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20181025233231.102245-11-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH 10/10] builtin/fetch: check for submodule updates in any
 ref update
From:   Jonathan Tan <jonathantanmy@google.com>
To:     sbeller@google.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Gerrit, the code review tool, has a different workflow than our mailing
> list based approach. Usually users upload changes to a Gerrit server and
> continuous integration and testing happens by bots. Sometimes however a
> user wants to checkout a change locally and look at it locally. For this
> use case, Gerrit offers a command line snippet to copy and paste to your
> terminal, which looks like

As I said in my review of the previous patch, I think this should be
squashed into the previous patch.

Also, remember to add the version when formatting the e-mail ("[PATCH
v? ??/??]").
