Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1C231F597
	for <e@80x24.org>; Thu,  2 Aug 2018 15:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387667AbeHBRj4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 13:39:56 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37216 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387649AbeHBRj4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 13:39:56 -0400
Received: by mail-wr1-f67.google.com with SMTP id u12-v6so2619447wrr.4
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 08:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=SliPuE2zjXsHAPX9r1lpHh/MM/Zez3TM+ovaD7J4234=;
        b=fPVdSokPMvfyMDjWGn9JupvHvIwoYadz4PsaTtdsP+4MuH2rTeg4BB1BZVF/Rppd3F
         9DsHl+vvHVnf3YK5K7pC5BeChABmzaNsqLpRhh3W1EAZ3sSpxl/qdLWn5YPEGvDI8xM4
         FYblwgNXxHcHQxPIMrvF/QJSd2vLm2+87ipdnb8mgKs6H86cx/YKtC31fQkZ1oPKPcd4
         ie9XdmOukLQWggEeyuoF7V63GkmpnZ01WPK1553xl+1HFRa0Wm2wc5aWdK4EJlIf1pn0
         fVmzJTn8msHUfEomrck7rgIYyTnkjT5gcJqv2fevmFoXMhyPd8vs7LSQBI/KK1ZRXrIH
         7uQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=SliPuE2zjXsHAPX9r1lpHh/MM/Zez3TM+ovaD7J4234=;
        b=HLnxbrLYBYAdeaLq//m4GKMwdAUZC2BprqGV6uxroSSnCwTPIODaBixbOMHG1otk1a
         7arLwRsNAeA8Yl9XvQBmylb3J24S0ifq0u0z9ix9JliMKHDFdyBwlJnpxHGebMtjH7pr
         VEkUx00aB/ayFiVnPlyse+Euii893ASOZBBeEqd6z5vSVvlqF0j57aCsHbpIcWKRsFWe
         V4d8mWJdDH1jJyV0FfOu+7Rk89ER7jabvXsJykcJEWZ/ctb5CrEGfruvWdgbSFzGqA1n
         r63xm/VpVc48ZTPxw8/+VtjLE8AM3xPbN4DNMLDZRViN2GL0tshb6mPXiKDKh83hVOp6
         6OMQ==
X-Gm-Message-State: AOUpUlGoTqfJ704hIKdvJfrveHDl/6LEwyLvjC0TpbK0ztUgO1ZC/JmP
        pNK8V7Qwndsr+mhHCXEmb5M=
X-Google-Smtp-Source: AAOMgpdeKZ4PM3W4PgcrhwMKQqB1yJS4BLaVxupntAiJkH1OgU1qbdJkPHo7758vK9rmarBmMbYi+w==
X-Received: by 2002:a5d:6345:: with SMTP id b5-v6mr15940wrw.266.1533224890591;
        Thu, 02 Aug 2018 08:48:10 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id q16-v6sm2589940wmq.25.2018.08.02.08.48.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 08:48:09 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv2 0/8] Add color test for range-diff, simplify diff.c
References: <20180728030448.192177-1-sbeller@google.com>
        <20180731003141.105192-1-sbeller@google.com>
        <xmqq8t5p7veb.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kbkWEa2zchvSo8nr2RFt8NaeU-bnzY7=z=50D+GUZMqKA@mail.gmail.com>
Date:   Thu, 02 Aug 2018 08:48:09 -0700
In-Reply-To: <CAGZ79kbkWEa2zchvSo8nr2RFt8NaeU-bnzY7=z=50D+GUZMqKA@mail.gmail.com>
        (Stefan Beller's message of "Wed, 1 Aug 2018 12:46:04 -0700")
Message-ID: <xmqqy3do3h3a.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Wed, Aug 1, 2018 at 12:13 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Stefan Beller <sbeller@google.com> writes:
>>
>> > Stefan Beller (8):
>> >   test_decode_color: understand FAINT and ITALIC
>> >   t3206: add color test for range-diff --dual-color
>> >   diff.c: simplify caller of emit_line_0
>> >   diff.c: reorder arguments for emit_line_ws_markup
>> >   diff.c: add set_sign to emit_line_0
>> >   diff: use emit_line_0 once per line
>> >   diff.c: compute reverse locally in emit_line_0
>> >   diff.c: rewrite emit_line_0 more understandably
>> >
>> >  diff.c                  | 94 +++++++++++++++++++++++------------------
>> >  t/t3206-range-diff.sh   | 39 +++++++++++++++++
>> >  t/test-lib-functions.sh |  2 +
>> >  3 files changed, 93 insertions(+), 42 deletions(-)
>>
>> As I cannot merge this as is to 'pu' and keep going, I'll queue the
>> following to the tip.  I think it can be squashed to "t3206: add
>> color test" but for now they will remain separate patches.
>>
>> Subject: [PATCH] fixup! t3206: add color test for range-diff --dual-color
>
> Thanks for dealing with my stubbornness here.

I didn't know you were stubborn---I just thought you were busy in
other things.

> I assumed that the contribution would be a one time hassle
> during git-am, not an ongoing problem during the whole time
> the patch flows through pu/next/master, which is why I punted
> on doing this change and resending in a timely manner.

It is a bit worse, in that it won't be at pu/next/master boundary
but each and every time the integration branches are rebuilt, which
happens a few times a day.  Whitespace breakage after a merge is
detected and my automation stops to ask for manual inspection.
