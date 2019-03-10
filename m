Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73A8720248
	for <e@80x24.org>; Sun, 10 Mar 2019 20:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfCJUDU convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 10 Mar 2019 16:03:20 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35643 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbfCJUDU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Mar 2019 16:03:20 -0400
Received: by mail-wr1-f67.google.com with SMTP id t18so2830097wrx.2
        for <git@vger.kernel.org>; Sun, 10 Mar 2019 13:03:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SwdUAHJBA7sDmZzt8wDnv9BGH1RX6XfJB4nldAdlVAY=;
        b=L+1lj0ax33n91kY/QowoskJM69Bc0S9RNC88JHgdmUspjOQ+2/yw+wUG3TmzPKIYnC
         Hj0jPEmOcU3n+l1EHr0N9v3v1FSHjerZ3g80d4Sd8O4vDm94Zal/RoB1aUL77jffibI3
         wh/sr/DemanqG0hYdxAmk4AOtNXJ+zzBglF1JmrQO/osy1L7XqE5WywYJ3skxRU01Svs
         D5Yzpja1ut2QFX4klUtlMgCUqnw5KdNYOHXtG9CcDvUpCYXfyYW/URdFc1J6oZbCF20Q
         zn+l1bVtiwB2gycZoVN4Q3UJ0j6LWt+8xdmn4MTCW4Q4Vj4gfCgOF8KRW2fOVEIgc52L
         yddw==
X-Gm-Message-State: APjAAAX7G5stzS+cd/a0b9UpL9EDfHdEyn/qtRXJchsE0zhMbt2nIUwu
        N0ItIm+my0dH0LR0yryTZXc5yCi6xQVqA2CtoHc=
X-Google-Smtp-Source: APXvYqx6fRDZTkWP1PN0jppM0kd4m/W7JGSltDT1Hgl+IXkUvLS4fLMMIV1tYi3XFViqjBcOEvshv4WX+rjaIBxJqV4=
X-Received: by 2002:adf:d84c:: with SMTP id k12mr9077832wrl.58.1552248198290;
 Sun, 10 Mar 2019 13:03:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190308101655.9767-1-pclouds@gmail.com> <20190308101655.9767-7-pclouds@gmail.com>
 <CABPp-BFv-a3Uw1g+ebLqTHRbCedsv1akZxxJ7QfeyXtXBdQuOw@mail.gmail.com>
In-Reply-To: <CABPp-BFv-a3Uw1g+ebLqTHRbCedsv1akZxxJ7QfeyXtXBdQuOw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 10 Mar 2019 16:03:07 -0400
Message-ID: <CAPig+cQ8YqAJ=3T++FCpew1SAUnwPYzZ3wRwExGu8Ed97ELrnw@mail.gmail.com>
Subject: Re: [PATCH v1 06/11] restore: add --worktree and --index
To:     Elijah Newren <newren@gmail.com>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 9, 2019 at 1:52 PM Elijah Newren <newren@gmail.com> wrote:
> On Fri, Mar 8, 2019 at 2:17 AM Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
> > +       if (!opts->checkout_worktree && !opts->checkout_index)
> > +               die(_("neither '%s' or '%s' is specified"),
> > +                   "--index", "--worktree");
>
> Is this die() or BUG()?  I thought --worktree was the default.

The user might type "git restore --no-worktree --no-index" which would
trigger this error message, so definitely die(), not a BUG().
