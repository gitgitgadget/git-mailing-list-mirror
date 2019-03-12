Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 830CE20248
	for <e@80x24.org>; Tue, 12 Mar 2019 17:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbfCLR2u (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 13:28:50 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45960 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728645AbfCLR2t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 13:28:49 -0400
Received: by mail-wr1-f68.google.com with SMTP id h99so2613213wrh.12
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 10:28:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n+g2CnDG6vLTDa8uBiX+AO9eRHCYZ3vVyKqjV3SeVVM=;
        b=Wx0cVNor7VfHo3wsTlUMgFAjrJ/vsVaBAnbFBTT5m9uZ1vJRZZd01hK4VXrCQFSaRz
         4nz6XPwFKbWmr8xKHa20PsIiXt81ykSxzrbkL0PCpRoNnABmFjmLoAaDSM70j99TcNr3
         iJMt02wBtKS0wI2p6KISXTlmBQfv121sn6H3tGYgOVaDbgeTCPGj7aluAxuj2/A6aemg
         W4gWyFotcp3b0lpvYPbXrcxI1+EglLeb85pKxnAVeZaaXvENEd8HKHzhgrkRNy2nQq9b
         5Llmr6QenljRUpm5nARMnGO6COa6cSd9f709oIF4cfhiw0FS0VaZB3op+DBKhTA5XUAP
         78Hg==
X-Gm-Message-State: APjAAAUwbuRS0HytFUjJQcLFHvkRqjrdgbwDp5J5vBkH5VKGixH2SYhJ
        jWnu3jItHX5Eu78XqLPHI4l1Kw16H+DOrBSD/3VbrA==
X-Google-Smtp-Source: APXvYqyzM3uoERGVgrjauDqkHrHxzf8bd5xzlakRGzhRbuXlsvCZ+fq0e6MrwSuTuBO00py3hxo81mVWVrolYcCglbg=
X-Received: by 2002:adf:d84c:: with SMTP id k12mr16168327wrl.58.1552411727519;
 Tue, 12 Mar 2019 10:28:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190208090401.14793-1-pclouds@gmail.com> <20190308095752.8574-1-pclouds@gmail.com>
 <20190308095752.8574-11-pclouds@gmail.com> <7d3742d6-73e4-2750-6ecb-9edf761d96dd@gmail.com>
 <CACsJy8DrrEg++wUszU2B1zJ_gvO1WC8MXXa53ZpMnObgqy=AeQ@mail.gmail.com>
 <CABPp-BFStPOtA_OGrS3HCe_XqWN1roBnzss3nefcHdQg=9eYLQ@mail.gmail.com>
 <d78392c3-7282-43ab-b88c-aa13fb5f937a@gmail.com> <CACsJy8DxOeKEAygiEa644pcQw-zTsnLyrtPL4sKWmPFEdNWpcQ@mail.gmail.com>
 <CAPig+cRN_cKhu2UQSiJHOK-bgk+g7897_2Acb_kgNK7w6_fS5g@mail.gmail.com> <CABPp-BHpoa+tNW=7+6TOmoQTvbap3iavqApEGny4E-rwv1gZVQ@mail.gmail.com>
In-Reply-To: <CABPp-BHpoa+tNW=7+6TOmoQTvbap3iavqApEGny4E-rwv1gZVQ@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 12 Mar 2019 13:28:35 -0400
Message-ID: <CAPig+cSe-v-GU=UG_PyUjf9itz_Ddqq4-Ni4h=2TtbLDXr5WJA@mail.gmail.com>
Subject: Re: [PATCH v3 10/21] checkout: split part of it to new command 'switch'
To:     Elijah Newren <newren@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 12, 2019 at 12:51 PM Elijah Newren <newren@gmail.com> wrote:
> On Tue, Mar 12, 2019 at 8:37 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > It's not much of a datapoint, but I do use "git checkout -B" (and
> > therefore would use "git switch -C") periodically (in addition to
> > -b/-c, which I use all the time). And, convenience is important,
> > especially considering that "git switch" is already more painful in
> > some ways than "git checkout", due to having to trigger and spell out
> > certain things explicitly (such as detaching).
>
> Ooh, interesting.  I haven't used it and didn't know who did, but
> since you do you can probably answer the question surrounding the
> long-name for the -C option from earlier in the thread:
>
> Do you use checkout -B only when checkout -b fails, or do you use it
> pre-emptively?  The former would suggest we should use a name like
> --recreate, while the latter would suggest a name more like
> --force-create.

It doesn't come up often, but I use "git checkout -B" when I know that
I want to start an existing branch over from scratch to build upon
some unrelated branch. This almost always happens when I'm programming
experimentally. I'll create a new branch with the desired _final_
name, start work on it, realize that some other approach might be
better, so set that aside and create a new branch with some junk name,
work on that for a while, possibly repeat, creating more branches with
more junk names, etc. Sometimes the result is that bits a pieces of
the various junk-named branches can be pulled together into a final
product, in which case I may "git checkout -B <final>", overwriting
the first branch I created, and then pull a few things from other
junk-named branches to reach the end. (More often, though, one of the
junk-named branches ends up being what I want to go with, so I just
"git branch -M <final>", throwing away the original branch, and
keeping the junk-named one but with the _final_ name). Sorry for the
too long-winded explanation.

I think --force-create is a better name because "force" implies
strongly that you're doing something potentially dangerous. Also,
every option in git-branch which deletes or overwrites a branch name
requires "force", so it's good precedent to follow.

> > Again, not much of a datapoint, but I do use --orphan periodically.
> > The idea of "fixing" the behavior so that --orphan starts with a clean
> > slate is certainly appealing (since it matches how I've used orphan
> > branches in each case).
>
> The only three people who have commented on --orphan in this thread
> all apparently feel the same way: the current behavior is wrong.
> Maybe we can switch it to start with an empty index after all?

Starting empty may match intuition better. (More importantly, perhaps,
it's harder to come up with a use-case for --orphan which doesn't
involve starting with a clean slate.)
