Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DE641F404
	for <e@80x24.org>; Tue,  4 Sep 2018 19:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbeIDX46 (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 19:56:58 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46327 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbeIDX46 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 19:56:58 -0400
Received: by mail-ed1-f68.google.com with SMTP id k14-v6so4152776edr.13
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 12:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=A0INjSGkyHU5Ql5UNhpmCi5KSS6G6ZmMUnpdwy/zLQ0=;
        b=MVBjBhFJMEBd48WHSOmTdOEvken6Opf+/fbq3KmAk5CP+bezeIIzBvVWZkVC4099FW
         hFBtc7vCPjiCC7FGKDGmHoEoeNb18PBGI8zlsngeqtUD95EIL1fvXBUDe2/HLkh65RNu
         1OdyAIY1oy4yb0ajWyHz+0dD3J4TDaGsrIYPMHJVntqGXu/ZRgfnXhi5BQEyGqWyoELz
         EGaBMpEfIgdMyN1x4IQPd777m09H74p83uLROHq97tocPTLZZ5XHLv9E3AuWrS8FKhv+
         XSPExSYSCSDNL5bWuv5g47xMBWOSyqxTTpCO2674/OwWXCI5bhdBMDof97mephY0FM6c
         xf8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=A0INjSGkyHU5Ql5UNhpmCi5KSS6G6ZmMUnpdwy/zLQ0=;
        b=Ter8KXYEvZHxwqsjuryKZkmF9tDWk3wEcoy7A/OWkkZgWR9f1vcmyy7/FaPCBPJNuH
         bdejfkd2RA0R+fxaPHr22VWSLDeLYUoXYlkY728FiVj8dyW/5IubxaxQ9vvweHsGwi5y
         2ka/NoEK7HdejrZRSHR62NUdYV3UMnxXQFW9MMXsmWbAT/sNsMxjYi1YVa1+jGSZTNDx
         lvKo6zhLTz+bepCFF5LfookpGwDckZj+a9gtmwTK8yiNqngI8DqGv+mgkbBF0293cHBH
         NMhwB9mDvCPHnaidfUQaVSnSQLAybQ4PMFFe/XWSiLMBksQg/gZgjPMB7QO58O1WxaS6
         dwSQ==
X-Gm-Message-State: APzg51AziSqwGEpFSC48j3cxO2Y9HROl2Jvg7IH2n1p5cKyrAbI6aQwW
        o2ulO9qnH7nMR0Kz3Gv+vDSRGMl3xaUtt8Th1GzM73fg
X-Google-Smtp-Source: ANB0VdbhFr1SjWZTUoV75veHLcYWhwciKwHSWny6pxDCzKTCm3xrnLftrASODesiJtTHV9LX5KVe4xr8fdoYXEyx1Co=
X-Received: by 2002:aa7:ca51:: with SMTP id j17-v6mr37098723edt.45.1536089425031;
 Tue, 04 Sep 2018 12:30:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180821184140.GA24165@sigill.intra.peff.net> <20180821190701.GE30764@sigill.intra.peff.net>
 <8736uud0gq.fsf@evledraar.gmail.com> <20180831225558.GA22917@sigill.intra.peff.net>
 <20180901074145.GA24023@sigill.intra.peff.net>
In-Reply-To: <20180901074145.GA24023@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 4 Sep 2018 12:30:14 -0700
Message-ID: <CAGZ79kZtXOmKo-86x=x4Z+tA0uiSmy4ntX+U4aCUYSjy4_DVDw@mail.gmail.com>
Subject: Re: [PATCH 0/4] un-breaking pack-objects with bitmaps
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>   [1/4]: bitmap_has_sha1_in_uninteresting(): drop BUG check
>
>     The actual fix. This should get merged to next ASAP (or the original
>     topic just reverted).
>
>   [2/4]: t5310: test delta reuse with bitmaps
>
>     I did this separately to give us flexibility to squash or merge
>     quickly. But it does find =C3=86var's bug on a git without patch 1.
>
>   [3/4]: traverse_bitmap_commit_list(): don't free result
>
>     The original assert should have simply been useless, but it was the
>     surprising behavior of this function that turned it into a bug.
>
>   [4/4]: pack-bitmap: drop "loaded" flag
>
>     And this is just an annoyance I ran into, which is a fallout from
>     our conversion to using an allocated bitmap_index struct.

FWIW, the whole series is
Reviewed-by: Stefan Beller <sbeller@google.com>
I am sorry for suggesting the BUG() in the first place.

Stefan
