Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A15881F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 18:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751568AbdB0Svp (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 13:51:45 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33277 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751526AbdB0Svn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 13:51:43 -0500
Received: by mail-pg0-f68.google.com with SMTP id x17so1862519pgi.0
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 10:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=fl5StJcatQCBBt6/uOoFWoTL3d7liXtr4ZeezjXHyzk=;
        b=tQbdkOHnz51m1dRtwUKlkWr+1XoHO5rIB7cet48EJ7939yVV7iaopgJ2jrpz4CcOCv
         h7DvMS7yVcp7sL3OXNJR7Uh8xfXD4HmMHHLruDwhOWFUNEGiUopV9AMzLMVn8EyZD0Ma
         xP+3B9QpNVsvlTxMJWAxjvN10nPRQ5iTtod7sdGFMvAPTnPO4grFJa/1s9cMcgeMSGkf
         VA3jHNo+fqrHFTzYtixo/lWs9uencMQnScoxxYDST7RwHWC0i1yksNPCdjy6UfN+AUFH
         d4S0qiJIdTX8FcWk5H72cwwjVwDGDz4ddFfbnM6B4GkB1cul7j4Br1JL/5RznUUJtxYX
         dXBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=fl5StJcatQCBBt6/uOoFWoTL3d7liXtr4ZeezjXHyzk=;
        b=Vg1k+XIrTy0GlVFydMh9mwLnlDSjuL9+gGtaXryM5vgkBzpDw9qYFvgEqkVc3T4HFr
         PM557cAkkk+74iAL/ZNVJ/KYdvydK7S1p6AiKdQgur0LUZHohXm5CENIc1p+akAQ4JYz
         YazK17OlWPX045UEXNGfL3egCfxE8QdfuoCdzqa1AovijUnnZhOBWKXgL6ATDXhRa2c1
         9TbIh5SwRggCzAykmQJXGLqOJWefF4qYhn5YHKcL3Jce4jDkwYzbd++RTBYny7oU56I7
         YWgeU2Ha/n9ZFoXmKT6eg62IJP9yzu05HoFlE01hkT5jMisCQu0HRl+qJ/Fn29GFFrhE
         m0XQ==
X-Gm-Message-State: AMke39mMrWzI17uWvis8YETWBmgnMisCmOGAdheHdXH/8GuSm9zk9BPVSaguRN3IqJ6r8w==
X-Received: by 10.99.243.21 with SMTP id l21mr22465618pgh.37.1488220976499;
        Mon, 27 Feb 2017 10:42:56 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:c953:ec42:862e:1e81])
        by smtp.gmail.com with ESMTPSA id o18sm32174569pgn.36.2017.02.27.10.42.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 27 Feb 2017 10:42:55 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Sebastian Schuberth <sschuberth@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v5 1/1] config: add conditional include
References: <20170223122346.12222-1-pclouds@gmail.com>
        <20170223122346.12222-2-pclouds@gmail.com>
        <xmqqwpcg7k6r.fsf@gitster.mtv.corp.google.com>
        <CACsJy8CerU-=PF6wqzUAM02jkrVVGJ5MA0NgL6z9bHn5KM6jiw@mail.gmail.com>
        <xmqq1sun5vo6.fsf@gitster.mtv.corp.google.com>
        <20170226060726.mvdip4vnbdngypzx@sigill.intra.peff.net>
Date:   Mon, 27 Feb 2017 10:42:55 -0800
In-Reply-To: <20170226060726.mvdip4vnbdngypzx@sigill.intra.peff.net> (Jeff
        King's message of "Sun, 26 Feb 2017 01:07:26 -0500")
Message-ID: <xmqqinnvxyog.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I don't think driving that with a two-entry table is the right thing
> here. We are as likely to add another "foobar:" entry as we are to add
> another modifier "/i" modifier to "gitdir:", and it is unclear whether
> that modifier would be mutually exclusive with "/i".

OK, I didn't take /i as something that was meant as a modifier; I
took the "gitdir:" and "gitdir/i:" are totally different tests that
are spelled similarly, but for the implementation expediency, called
into a single helper function without having a layer that presents
the same function signature in the middle to make it drivable by a
table.

Let's leave it to the review of a future patch that wants to add a
third condition then.  At that time, we will have more things to
look at to make a better decision.



