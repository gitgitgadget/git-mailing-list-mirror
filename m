Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B3441F859
	for <e@80x24.org>; Fri, 26 Aug 2016 00:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752559AbcHZA4Q (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 20:56:16 -0400
Received: from mail-yb0-f182.google.com ([209.85.213.182]:34461 "EHLO
        mail-yb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750703AbcHZA4P (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 20:56:15 -0400
Received: by mail-yb0-f182.google.com with SMTP id d10so22366599ybi.1
        for <git@vger.kernel.org>; Thu, 25 Aug 2016 17:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0xOomyoTbGvOwO81y6I61gGrCtXXdXUfLkTkBP4atVo=;
        b=R1UJIYJi2wSc6Fm43Btmw4RxMNrGw9CtqtHhVNZOpiys7XP78JrNxqKnGkOShEmMr5
         m9pCHs5bvyrfk34hvWINBAImlpnTjPR1SpBNXR3W5UkoUef3K/g5cy9CSNK8Cj1/nBJS
         Eywu2QnsXxRQYlRMYpLmd2RPsyyd/JYQgLvvYhDSi0iUVdA+LDen/jYZImrG0bUocK1L
         8FI17/hRhXNXCpWB/lo0R7vK4jaRHWzBIXsqF/ujBxzfkOxiBm/TfeuYRkHorUlnnEZb
         3V0PMRd41npww42V7B4W6xJxVezHWOsv44JVhidL5gt+5SnWDHbPR/maT3vZo/5PTmG6
         5AJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0xOomyoTbGvOwO81y6I61gGrCtXXdXUfLkTkBP4atVo=;
        b=BM4J4EpZDuO5a0VOzqFtBogSjj0+myQ4lwOky6xaLD37SlnT5acJN6YCLdlsDSY1KH
         VePXBT2Wp9VEc0AmGo70SzPaoVntI9wBmiq9i9gTh0OX6MVKmlgDjUehhd5EEEpQrb7X
         cuy7E41zUJYpPwD5TimlZNyHiY6LG0/ZKAxk4Y4aTfXh6sOs2avcov7nhTuJYFcLB0pd
         Zo9g0CYSiCs2yBEEgDb7epKn4O2tt8x0HYoQI5+i3Lsmz9lodFIv7WNKbbzcMpSLDkZT
         dLjUSqUg7oqFepnOPYUcsfSZTd94DnSAoQ1Au8zqeuGEW8HXoW3fouxLzl5F90dGsIVS
         ib1g==
X-Gm-Message-State: AE9vXwNZE+YM7nBvGAvzfi3WzHqd+jl8tpI/HPFUCAWWnl3evL0TKezTAjjHB2Z66u/hvrMpQd13fjOf03Zz4Q==
X-Received: by 10.37.60.67 with SMTP id j64mr348043yba.111.1472172974891; Thu,
 25 Aug 2016 17:56:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Thu, 25 Aug 2016 17:55:54 -0700 (PDT)
In-Reply-To: <xmqqvayojx9e.fsf@gitster.mtv.corp.google.com>
References: <20160825110752.31581-1-larsxschneider@gmail.com>
 <20160825110752.31581-7-larsxschneider@gmail.com> <CAGZ79kaVg40H-LeDtFfDYqDFDDbr+um3ZYj8oAaqGu+q6k5e+A@mail.gmail.com>
 <xmqqvayojx9e.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 25 Aug 2016 17:55:54 -0700
Message-ID: <CA+P7+xrYM_r+Q_27hWM2FwbreV90AqPgoiH-qPZN0hoPiHpKhQ@mail.gmail.com>
Subject: Re: [PATCH v6 06/13] pkt-line: add functions to read/write flush
 terminated packet streams
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Martin-Louis Bright <mlbright@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 25, 2016 at 3:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
> What is wrong about that?  4*80k = 320kB overhead for length fields
> to transfer 5GB worth of data?  I do not think it is worth worrying
> about it.
>
> But I am more surprised by seeing that "why not a single huge
> packet" suggestion immediately after you talked about "without the
> possibility to intervene".  They do not seem to be remotely related;
> in fact, they are going into opposite directions.
>
> Puzzled.

Stefan's argument to me is thus "If we're already going to ignore
sideband packets here, why not go all the way and make variable length
packets and send a single packet of a maximum length? Doing thus will
solve some set of future problems nicely and makes this code easier."

I'm not sure I agree myself, but that's the logic as I understand it.
