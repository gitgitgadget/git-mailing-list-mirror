Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF35620248
	for <e@80x24.org>; Wed, 13 Mar 2019 01:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbfCMBzu (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 21:55:50 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36806 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfCMBzu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 21:55:50 -0400
Received: by mail-wr1-f67.google.com with SMTP id g18so206648wru.3
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 18:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=aeELmriaDTrsvQi2XUd3u/2bgeeUYGvLjXl5n3I4Or0=;
        b=Ho687vD3nfPfODwkQvGk/W/bXH2Bpg/TEta23ThdHYuOcVutYqrFsD8B3ZBwRSwo7C
         c8zD+xlk5Ree2FUY7qwr5nYIa5/DlZVhgYagHavwREapLF/SkylSdUHcAtYE2v2O7eHT
         n1E3f/GBKc3ejLPvrgO8GBpqlbgWJPckASnwMqUH0HThG5MHpEhxP7vTNTdi4iTyVBwc
         oX3CjwUIi01XdyFWMWROxaOhNgzO7EyDZsE/WsICpzQUcfBaAbfKYNxG7b1ZKVb5lgcL
         xx+7C0NmNjQ0cdY+1w/9zHUWsRzB0ZsXyia7ae+3dHPaSJ8v4ooX5ZfGUy7GeSqWqPOi
         mUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=aeELmriaDTrsvQi2XUd3u/2bgeeUYGvLjXl5n3I4Or0=;
        b=uEp+0K1oW2pKguMERlKRdBJ5qw6J2EQmVixQ/9qZix2h1NIfpmD3on6uUcgujVtK4U
         Z69eKk1l16AvwFYYNbm54Vb+sey/0/WTXf7zpogKJfbPv1B/wStSmtx6EhUISM/C3mw2
         9JEs52MBQAHO0T/4kNG5OdhOORz6a0AK/5Z6sFVcOEhN5o3dcDbmUeZIOll2DTPfOn9P
         QPCaarc7bwYvTtJXMq+wyGoOQyGs217UDH86fbys+x8u6lLMIyRC4z6DPM5Rg8Q4hITD
         BSe9YKNXXTaznjHCkexs4Q5+gmqOGP/YtuF+fOjLl2wnUoqf6clAGsemvnlAHMwcShqS
         Kvsw==
X-Gm-Message-State: APjAAAVN7SX778Q/ERywZyT8cLUJQYAbujUiZiOSvCs0PHiPZ2CObm1e
        0yb+r4mh0m/ApZqZLv1wgQk=
X-Google-Smtp-Source: APXvYqyhGT1wtjFOYt58MtKhBmTeGvvrfVXViV89w7S1x6Tg1pdYCYFQnwEvmuDT17tkCho9H+QEhA==
X-Received: by 2002:a5d:570f:: with SMTP id a15mr7226410wrv.221.1552442148599;
        Tue, 12 Mar 2019 18:55:48 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id z15sm406849wmi.46.2019.03.12.18.55.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 18:55:47 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Elijah Newren <newren@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v3 10/21] checkout: split part of it to new command 'switch'
References: <20190208090401.14793-1-pclouds@gmail.com>
        <20190308095752.8574-1-pclouds@gmail.com>
        <20190308095752.8574-11-pclouds@gmail.com>
        <7d3742d6-73e4-2750-6ecb-9edf761d96dd@gmail.com>
        <CACsJy8DrrEg++wUszU2B1zJ_gvO1WC8MXXa53ZpMnObgqy=AeQ@mail.gmail.com>
        <CABPp-BFStPOtA_OGrS3HCe_XqWN1roBnzss3nefcHdQg=9eYLQ@mail.gmail.com>
        <d78392c3-7282-43ab-b88c-aa13fb5f937a@gmail.com>
        <CACsJy8DxOeKEAygiEa644pcQw-zTsnLyrtPL4sKWmPFEdNWpcQ@mail.gmail.com>
        <CAPig+cRN_cKhu2UQSiJHOK-bgk+g7897_2Acb_kgNK7w6_fS5g@mail.gmail.com>
        <CABPp-BHpoa+tNW=7+6TOmoQTvbap3iavqApEGny4E-rwv1gZVQ@mail.gmail.com>
        <CAPig+cSe-v-GU=UG_PyUjf9itz_Ddqq4-Ni4h=2TtbLDXr5WJA@mail.gmail.com>
Date:   Wed, 13 Mar 2019 10:55:47 +0900
In-Reply-To: <CAPig+cSe-v-GU=UG_PyUjf9itz_Ddqq4-Ni4h=2TtbLDXr5WJA@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 12 Mar 2019 13:28:35 -0400")
Message-ID: <xmqqo96ffsgs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>> Do you use checkout -B only when checkout -b fails, or do you use it
>> pre-emptively?  The former would suggest we should use a name like
>> --recreate, while the latter would suggest a name more like
>> --force-create.
>
> It doesn't come up often, but I use "git checkout -B" when I know that
> I want to start an existing branch over from scratch to build upon
> some unrelated branch.

FWIW, I always use "checkout -B" at least twice during an
integration cycle.  "git checkout -B jch master" before rebuilding
my private edition with select topics (including all the topics
already in 'next'), plus "git checkout -B pu jch" before rebuilding
the 'pu' branch with the other topics I happen to have looked at.
These are similar to your use case---the branches have constant
"purpose" and always exist, but they are rebuilt from scratch when
they get updated.

