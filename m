Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 595E220193
	for <e@80x24.org>; Thu, 27 Oct 2016 20:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933978AbcJ0UOr (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 16:14:47 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36750 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750823AbcJ0UOq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 16:14:46 -0400
Received: by mail-lf0-f67.google.com with SMTP id b75so2522089lfg.3
        for <git@vger.kernel.org>; Thu, 27 Oct 2016 13:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MoOlZS8IasqFEl6P6PK0JJoPoi9gkTNzgoSv0Mh/Q3E=;
        b=n0wIun9i2NQP0/ps0fe1GvC/U7EN+i9SjrdBX41I4W0RsIWJVt+gckaAQ3jCNFXw3D
         6EaZtB7h6zsWLR8Qdsbt0qXvSPKJSb+iYoI/7WzXGfq7dpNEVW6fDMoQVe8dKHO3rixZ
         8XpfHRjITB8+Lj6tc7QPldZknpRhsO4Uo3ViBnKmdnPv3w6BpfbW5BWC1CHvTzIjh22A
         CSc/+2MFukYETNM/9PPKNSMBe6iiKRTT3SDquiqoVm53TWNoFQfvP54x7WZ4XEItyGNr
         TW0cNiWym+7O0C+1ibiZtxMPFKb3ImtLUC3qjhEPpbVDr5PDk78WKn9MANjODU9jHwBs
         hhNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MoOlZS8IasqFEl6P6PK0JJoPoi9gkTNzgoSv0Mh/Q3E=;
        b=bY/uCyKHDrZnTRLIBbKCGqm3uWiKFO4cgBGsgXCJYYPQ+QVMBAULYZwYDQRTtAXqyR
         ZSa5oSc6HV1aMjmofzyY4k9j+6BjTZSDV5PW8JGZLhVAVWaTTs+pPL3dx4fAC38MASRL
         Wo8ghSXLPNa9r0RuK/IGKCsQix/3t6YMwpZBgtCRpGvbnfJmjCT8prlFENUkiqyNczQQ
         89NAy1yIwcZoCFGA+x7gLswmRzZq3GrCs1cZ6nCOl1Ienug5ojOO0rkvKUohykNRHNhP
         DoBVCNUbhCueCUA4g5X1fZG9dG2FTOpohvPW4wGjyDGjZPqQ2gjxYq2mp9jGztLjL4zr
         oJ7Q==
X-Gm-Message-State: ABUngvf9g3K5bPiEQEJ+yuABOXJ1kGn0gG9DlaUA5jM0pgNyg039EooxLqGoD0KPd/Wj0XbAAUHtakQ21W6low==
X-Received: by 10.25.74.200 with SMTP id x191mr3540729lfa.154.1477599284807;
 Thu, 27 Oct 2016 13:14:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.163.84 with HTTP; Thu, 27 Oct 2016 13:14:44 -0700 (PDT)
In-Reply-To: <xmqqvawd7mnr.fsf@gitster.mtv.corp.google.com>
References: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
 <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
 <xmqqvawd7mnr.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 27 Oct 2016 22:14:44 +0200
Message-ID: <CAP8UFD3Er7AWO8-bwXbsGr05eoBUEgPcmiS53n-PT19e9h+7sg@mail.gmail.com>
Subject: Re: [PATCH v15 01/27] bisect--helper: use OPT_CMDMODE instead of OPT_BOOL
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Pranit Bauva <pranit.bauva@gmail.com>,
        Matthieu Moy <Matthieu.Moy@imag.fr>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 27, 2016 at 6:59 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Cc'ed those who touched either "git-bisect.sh" or "builtin/bisect-helper.c"
> in our relatively recent past.
>
> Does any of you (and others on the list) have time and inclination
> to review this series?

As part of my mentoring Pranit for the GSoC I already took a look at
those patches some months ago on GitHub.

I could take another look at them but my eyes will not be fresh
anymore, so I don know if it will be valuable.
