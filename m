Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5936720285
	for <e@80x24.org>; Sun, 27 Aug 2017 20:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751316AbdH0UFA (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Aug 2017 16:05:00 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38615 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751294AbdH0UE7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Aug 2017 16:04:59 -0400
Received: by mail-wr0-f194.google.com with SMTP id y91so1182214wrb.5
        for <git@vger.kernel.org>; Sun, 27 Aug 2017 13:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+0IBCUhRz/KNZzZqMER3W0WGrgOOclO85IfSU0Zfo0I=;
        b=IXKXwSOt+yKnE9IvzxLeuJZgY/V/AZT1xkymcCLfPAffHhSik/Ra3gxrGHlfZnBwu0
         3RMdY1JHoMPwkqZ7+/RQMakqZ9TneUHXmIX/7kzsdIeYnbiXoLS4sZJ/V2slAtV5/wnc
         31ogIckkltqidEHoOpwdFxdZtdKA8JSwvFW9jOVmg4qtDvF4Gsw/BE74bEnpXmg6myn5
         dLHUYSWI3JUPTIcNE1uaqX0zJP/orws4slNc7PVhlERtvsV4KUHrQNPV8qVXNJ6cJfWA
         rTsil2U2NM7czVvjKav05tKXjKwFqt9/rkjRTilNre3dVXCobxIsgIwpwHv9slV1rdkN
         bC8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+0IBCUhRz/KNZzZqMER3W0WGrgOOclO85IfSU0Zfo0I=;
        b=GirNHXdCTjIcGslVsdqJsuEPm7NWveABDbR5OP6SJH5z1HFer5DwmGHxsuY3OC6GXd
         r/NTE9h6ASd2H/C4nPOQSBRgt968FTO4nnNGuSdeurx6Fs2Kn/fTPvZJgk2Z0VpK07EX
         HitEHy3XAmSY6KLbG1S8FhH3Riv02OqFXlMbdQ22XGg3grUw4fs6FTojYxq161p3QNz1
         YF2eistraQ9Ht5AzOYHoBWtdXtG7VVZsnohqAssFsCxIRJ7ppNZM9GjQ2bc9G0KO1lVQ
         NNo37j0rRh+UQvCM/bKC359Z2iMerZwhsZi1zInoWTDiDuY1JiBCEDPkBDoyGPploMmI
         QP9Q==
X-Gm-Message-State: AHYfb5gRQOebnukB4uNNdR4dtgWfRubDMhOgiA0LMAsI2I39x1xpoizv
        lpXleC8wMA+Z54D/w+w=
X-Received: by 10.223.155.218 with SMTP id e26mr966502wrc.55.1503864298043;
        Sun, 27 Aug 2017 13:04:58 -0700 (PDT)
Received: from [10.32.248.91] (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id l13sm8242876wmd.47.2017.08.27.13.04.56
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 27 Aug 2017 13:04:57 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] pkt-line: re-'static'-ify buffer in packet_write_fmt_1()
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CAN0heSraJFbbog7FKpAtmob9W6_5-AS1StZFVW6xUwMDWfMYgg@mail.gmail.com>
Date:   Sun, 27 Aug 2017 22:04:55 +0200
Cc:     Git Users <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <179AC8FB-5991-4200-9AAC-2F8D0914D5F9@gmail.com>
References: <20170827073732.546-1-martin.agren@gmail.com> <9E4606AF-8814-42DE-8D3A-3A15C1B1723C@gmail.com> <CAN0heSraJFbbog7FKpAtmob9W6_5-AS1StZFVW6xUwMDWfMYgg@mail.gmail.com>
To:     =?utf-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 27 Aug 2017, at 21:09, Martin =C3=85gren <martin.agren@gmail.com> =
wrote:
>=20
> On 27 August 2017 at 20:21, Lars Schneider <larsxschneider@gmail.com> =
wrote:
>>=20
>>> On 27 Aug 2017, at 09:37, Martin =C3=85gren <martin.agren@gmail.com> =
wrote:
>>>=20
>>> The static-ness was silently dropped in commit 70428d1a5 ("pkt-line: =
add
>>> packet_write_fmt_gently()", 2016-10-16). As a result, for each call =
to
>>> packet_write_fmt_1, we allocate and leak a buffer.
>>=20
>> Oh :-( Thanks for detecting and fixing the leak.
>>=20
>> How did you actually find it? Reading the code or did you use some
>> tool?
>=20
> Valgrind found it for me. Most leaks it reports are "ok" since we're
> about to exit, it just takes more or less effort to realize that...

I am sorry if I am bugging you here, but I would really like to=20
understand how you found it.

I did run all tests under valgrind using "make valgrind" and I found
the following files with potential issues:

cat valgrind.out | perl -nE 'say /^=3D=3D.+\((.+)\:.+\)$/' | sort | uniq =
-c
7102
   2 clone.c
  33 common-main.c
   6 connect.c
  64 git.c
   4 ls-remote.c
 126 run-command.c
  12 transport.c
   7 worktree.c


No mention of "pkt-line.c". Did you run Git with valgrind on one of=20
your repositories to find it?

Thanks,
Lars=
