Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 519751F454
	for <e@80x24.org>; Thu, 25 Oct 2018 23:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbeJZISU (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 04:18:20 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51490 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727551AbeJZISU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 04:18:20 -0400
Received: by mail-wm1-f65.google.com with SMTP id 143-v6so3121352wmf.1
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 16:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2kv7DDNLZvvlHMYMUfQJlVRtS/PU6HGf4lgifmEj2qU=;
        b=VH4H9lF2lx2wXLoS3EuVY1vgo98KKacZveG415cUMGNDbgzR/mmX//oTa9GF7XUmwV
         E0ogPRyANrBTWkJMgf8Rwsbit2DngUC0SfsYEp2vAiEeucc2pXEHRc/7E6+I8TKMIg6i
         fNtXGHCLVZvvU91Edp10jqbkJ4iUVh8YSfLUlEdgQ/mfCF4zgaoP5d7po16B8PuHsG5f
         xzBhmY7gUsZK0AYkFztzxZQY92On9mmU+V6p1xatCjywCu7Vb3DK4lTzaRz+UMr8Giui
         JDihbzOXANjmuYMRnogPT9indQRYQLs3Kbu7ap02owGdpw/TKcCB4oYfj2u8ydw48qvA
         8Cew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2kv7DDNLZvvlHMYMUfQJlVRtS/PU6HGf4lgifmEj2qU=;
        b=aQeK/wQpt6pfxG2rKeeGDD+V+g1oyM34AXdxCNeeBmzQsQcplxs78lYSn5SPCnEzFL
         osB7mS1k74HS+BrdTa4Btb0hUb3HsxV20M1yZBIAx/um0b2tK9r2aQiqcmtGq61Boepz
         kmeV66J4A5U4HNuMfRQEjE2sBW/uPqvj4sLekTSvlCt1gpGj0hZLtmoAfgaVC4kIUyo3
         6KqI8+v44xPVugY59WSxV5HP4SRmfa8jujKGpHo1vMllGeCbkk7XZKN3cHwKE6yfAn4R
         lVzVt01hbwbFIuBaW0QTo930QmH8EHGrORE6UwkCz1WTWsH1lTrFoQorNu2HJ1cEAuvk
         vxjA==
X-Gm-Message-State: AGRZ1gJYh7mGlihEHkcbaPhFPMIXse0u8TQcVOgbXDjpCbxvGEssB3kx
        LFJQtWwgWtMwJVnASf66zgSkU/utIxA=
X-Google-Smtp-Source: AJdET5etKGvxIj+RCKG9Z5EBwhD6a32NIMdWvclywlJJLG/CJnxLb7uFfR4cBfORFmgFYny1KfzgKA==
X-Received: by 2002:a1c:e102:: with SMTP id y2-v6mr3499624wmg.141.1540511019180;
        Thu, 25 Oct 2018 16:43:39 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v2-v6sm2618546wru.17.2018.10.25.16.43.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 16:43:38 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>, git@vger.kernel.org
Subject: Re: [PATCH] Clear --exclude list after 'git rev-parse --all'
References: <20181023191758.15138-1-agruenba@redhat.com>
        <xmqqefcgotbk.fsf@gitster-ct.c.googlers.com>
        <CAHc6FU6YLeTBU02k-Md7+H5kJDq2RXZmAXMaq8ZkiuSmZFXbwQ@mail.gmail.com>
        <xmqqr2gfn1cy.fsf@gitster-ct.c.googlers.com>
        <CAHc6FU5CpBNpzfPs0hkNm9Hw1iYnALvUY4WL1z=sPVT10fq+zw@mail.gmail.com>
        <20181025104542.GA14455@sigill.intra.peff.net>
Date:   Fri, 26 Oct 2018 08:43:37 +0900
In-Reply-To: <20181025104542.GA14455@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 25 Oct 2018 06:45:43 -0400")
Message-ID: <xmqqtvl9fv86.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> An easy test is:
>
>   $ git rev-list --no-walk --exclude='*' --all --all
>   3289ca716320457af5d2dd550b716282ad22da11
>   ...a bunch of other tip commits...
>
>   $ git rev-parse --exclude='*' --all --all
>   [no output, but it should print those same tip commits]

I actually was hoping to see a test that contrasts "--all" (which
lacks the alleged "clear exclude" bug) with another option that does
have the "clear exclude", both used with rev-parse, i.e.

    $ git rev-parse --exclude='*' --glob='*' --glob='*'
    ... all the ref tips ...
    $ git rev-parse --exclude='*' --all --all
    ... ought to be equivalent, but is empty due to the bug ...

would have been a good demonstration that shows what bug we are
fixing d(and would have been a good test to accompany the patch.






