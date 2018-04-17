Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12EFF1F404
	for <e@80x24.org>; Tue, 17 Apr 2018 01:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751210AbeDQByM (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 21:54:12 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:33778 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751060AbeDQByL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 21:54:11 -0400
Received: by mail-wr0-f177.google.com with SMTP id z73so30967651wrb.0
        for <git@vger.kernel.org>; Mon, 16 Apr 2018 18:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=rqc/Y6jBmy1NqoMGJlgpq4oYLUX2c4HU5YfBBYMOafc=;
        b=HuppggEFzrmoblHrXGRWWosrfOxNB+ONhh2/L52viKeEA+4H8M9F2NmwV/7nPivwNI
         91uDyPvHKOGIRfjPs7nx3kEamVzMYw1wqo6H3e4PizXyEvpx6mAP8rW1nA+T2QS/ThAv
         SpAPtCoUVog6rVpi7M4vEzZuEDJ4X30yCAsn8YNJx1L7yiS6XwBHL3k8f3w12l/3LeOP
         NNOC4Dwm5Q+JT/ka1KHpKk7WvJ7VyRgeVBmy81ztoP0IawoYxunKILbj9O1TgPr1urTw
         kcB9xb70usvKCGZ6JOY/Fka9kcqwAktCYRvGMFlBbDXf/quwb46IIxQs6n5zL08+hELG
         WDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=rqc/Y6jBmy1NqoMGJlgpq4oYLUX2c4HU5YfBBYMOafc=;
        b=ZW647dd2aIBWUcewW0vrHge8Jz4oAJm6o+EOoifoqoZCqZExlyLyioJpBcJyrRuhmg
         q6PKxD+tf2mQ10uDREmvQrd5v41MhxpXGCJvVFzMF2n8VKiFGpPiR9RMOCHUv29H5V/t
         ithX/qo5Tv2r2M21IrDsH/Cg8ndqenQ7Bd73jU5XXbKtW9IiPRu9BFmHpv0g3MeZY3hS
         Zff5gQ/D9Hpvmc/f+kUi6QRWvIck53PKDfcrHyAtms8h/N6Bx2kJMa3ugF4Na6fQB1/i
         3RUVNoCPUjAr9iwHkq/3H3B6jA6lcaDjSahy7NmW1NCCSJusdCOBuGBANkcBnsLsKaXk
         5j5w==
X-Gm-Message-State: ALQs6tAlnucGZScduSxlTqm9GABDO7k2rBDoPUn+ninH2hq/8j9LEujp
        rTNZSlmFpwlgE8qWYZnstWYOkmSS
X-Google-Smtp-Source: AIpwx4+NuwIAhKoMUPEV/uJmiyCpZOPSIqcd8OcUbBJAaZU+HzWwmE3JkaJCg9UN2TBgQlWAeE6w/A==
X-Received: by 10.28.137.131 with SMTP id l125mr362469wmd.14.1523930049725;
        Mon, 16 Apr 2018 18:54:09 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id p4sm10708302wma.5.2018.04.16.18.54.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Apr 2018 18:54:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Ben Toews <mastahyeti@gmail.com>,
        Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>, Ben Toews <btoews@github.com>
Subject: Re: [PATCH 8/8] gpg-interface: handle alternative signature types
References: <20180409204129.43537-1-mastahyeti@gmail.com>
        <20180409204129.43537-9-mastahyeti@gmail.com>
        <CAPig+cT3AobThgZ15iquyRQG0Qes1ZzQxycXcgHYuwQCuDEDBQ@mail.gmail.com>
        <20180414195954.GB14631@genre.crustytoothpaste.net>
        <xmqqbmejyc4j.fsf@gitster-ct.c.googlers.com>
        <20180417001212.GC14631@genre.crustytoothpaste.net>
Date:   Tue, 17 Apr 2018 10:54:08 +0900
In-Reply-To: <20180417001212.GC14631@genre.crustytoothpaste.net> (brian
        m. carlson's message of "Tue, 17 Apr 2018 00:12:12 +0000")
Message-ID: <xmqq604qwqbj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> If we just want to add gpgsm support, that's fine, but we should be
> transparent about that fact and try to avoid making an interface which
> is at once too generic and not generic enough.

One thing that makes me somewhat worried is that "add gpgsm support"
may mean "don't encourage people to use the same PGP like everybody
else does" and instead promote fragmenting the world.

But that aside, assuming that it is a good idea to support gpgsm, I
fully agree with your above assessment.

Thanks.
