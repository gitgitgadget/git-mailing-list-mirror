Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0522720248
	for <e@80x24.org>; Mon, 15 Apr 2019 21:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbfDOVyX (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 17:54:23 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39018 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbfDOVyX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 17:54:23 -0400
Received: by mail-qt1-f195.google.com with SMTP id t28so21060722qte.6
        for <git@vger.kernel.org>; Mon, 15 Apr 2019 14:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=platin-gs.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z5R3DwuSpeVP3Em9LmFxQvJu9SuXQ9zNV+TLEpjjKLc=;
        b=ka6fAEfLvACnD8CjuLml7lBfG3m7DPSutHm4Z8KaRe9s8AtGdeBkyrdibI2hLoA+fA
         5x0i2Il5CQZjimgN/2p89hAgdSmzOGk80bpd9pR55KVu8n8nrn4GrZgGpFN1Eb3QMlyQ
         GbROLpfh9q34Y7p27cOJakwjgGJuTXRVsaAxh5F9+rey0Kbv3MWug606z0JrAcTWNkVL
         d8hHK9itspc9Uuai+N1XpcH71rXNC0ieD17hGyfr8qU6yTJXOW4eUcJyvGK4gey1hDPj
         sCG8aplyWUF+ZJ8YHa9/xNb4mM35irJXpplAWTQ6zMJOrigt7ncVzynZISSojyMJRKyP
         c1zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z5R3DwuSpeVP3Em9LmFxQvJu9SuXQ9zNV+TLEpjjKLc=;
        b=OB7kdRX72kZpt/g51RUIlXYXIQSzwANN77NOVIcNo11pRYVqIjXTkiIZzUnv5WsL8b
         PAkZkdB6ASL9W/MXw2/V6ibiDHkEFX7tdTbsost/TvM7QIadQKORZ22TvLdlc5hWIOlR
         9QTHamEXTAv4iOvnu+XNdyIdQOIuGvpfPQaPVtYz/xlnlMWEgdpEWr4ISQIHGg/uhTJl
         AhA94yHz7FvekQt41oy1x+kAstlBhsfc03oNv/+7UWiFhD92EjetM2J5eoGlM6x1MS1G
         wiyrt+S0WyqOljQGD35Kz4rQgSdj07wuUanch9P4Jv9KqMY3PqHTL7ADQYEzFgsnrt2U
         VBWg==
X-Gm-Message-State: APjAAAX6hyHHQJl8sH16MN19JcExKJUCoyareB2RvlN4uW1VA4WHf6no
        yzm1Sd47p6/MKmuL5qCsCYJvj1wDS1Wf81JNWiQ=
X-Google-Smtp-Source: APXvYqx08q1XT2JtXmE7EcsQpUgKWdmqIs/zRQHW3OifB1Hhy8A13THjpgvsWFSYtvfE0hE7Sk/i/Ih9TH6R74NdFkU=
X-Received: by 2002:aed:3641:: with SMTP id e59mr62277408qtb.235.1555365262447;
 Mon, 15 Apr 2019 14:54:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190410162409.117264-1-brho@google.com> <CAJDYR9SL9JCJjdARejV=NCf9GYn72=bfszXx84iDc416sZm31A@mail.gmail.com>
 <9439c697-246f-3bcb-4d34-85099e577e8b@google.com>
In-Reply-To: <9439c697-246f-3bcb-4d34-85099e577e8b@google.com>
From:   Michael Platings <michael@platin.gs>
Date:   Mon, 15 Apr 2019 22:54:10 +0100
Message-ID: <CAJDYR9QSAoYkrbdyJBN1tg0v1x6Do9qGf0+6hYL-n49+HSfu8g@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] blame: add the ability to ignore commits
To:     Barret Rhoden <brho@google.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Kastrup <dak@gnu.org>, Jeff King <peff@peff.net>,
        Jeff Smith <whydoubt@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> My main concerns:
> - Can your version reach outside of a diff chunk?

Currently no. It's optimised for reformatting and renaming, both of
which preserve ordering. I could look into allowing disordered matches
where the similarity is high, while still being biased towards ordered
matches. If you can post more examples that would be helpful.

> - Complexity and possibly performance.  The recursive stuff made me
> wonder about it a bit.  It's no reason not to use it, just need to check
> it more closely.

Complexity I can't deny, I can only mitigate it with
documentation/comments. I optimised the code pretty heavily and tested
on some contrived worst-case scenarios and the performance was still
good so I'm not worried about that.

> Is the latest version of your stuff still the one you posted last week
> or so?

Yes. But reaching outside the chunk might lead to a significantly
different API in the next version...

> Similarly, do you think the "two pass" approach I have (check the chunk,
> then check the parent file) would work with your recursive partitioning
> style?  That might make yours able to handle the "split diff chunk" case.

Yes, should do. I'll see what I can come up with this week.

> No algorithm will work for all cases.  The one you just gave had the
> simple heuristic working better than a complex one.  We could make it
> more complex, but then another example may be worse.  I can live with
> some inaccuracy in exchange for simplicity.

Exactly, no algorithm will work for all cases. So what I'm suggesting
is that it might be best to let the user choose which heuristic is
appropriate for a given commit. If they know that the simple heuristic
works best then perhaps we should let them choose that rather than
only offering a one-size-fits-all option. But if we do want to go for
one-size-fits-all then I'm very keen to make sure it at least solves
the specific cases that we know about.
