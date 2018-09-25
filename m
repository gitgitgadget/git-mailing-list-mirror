Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D2491F454
	for <e@80x24.org>; Tue, 25 Sep 2018 22:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbeIZElZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 00:41:25 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:39898 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbeIZElY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 00:41:24 -0400
Received: by mail-wm1-f51.google.com with SMTP id q8-v6so207947wmq.4
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 15:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=UszrF4q2hEDYVcH7/nD6XOF/NEhWeKhqWmeGXqIyvaA=;
        b=Pn3gGKGFl/yz116ljEakxXhKWq6mPzo6K4AOjRF+SYYoNC4AhZTOvcMe7nuPH6zvh1
         pK2lXoqNtJLN9DR+WmCPEFRCPQzTKH8mqCJwhnkiIyu8vHrJEEuAVw5YERcFW17Hc7aG
         CETzsAv79PzdDe2aJCJJy0m5VOukaWyr9Wdbewgd7vDNNPK9Gd8cHPOQ04ou+8Tq1YZF
         TsUK5xd2rjJA4VzyN1R/uxZ7OcFOP5KVAtwOyn6k6CWByZ1r4ohGv6LaCpbCFzmgZMLC
         5kTinRf3yb8XvoDI69RgKavy6U07iud3BoM6ad4nektjKqi6wdyDHRuBuKNHM/GZT5rr
         rp+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=UszrF4q2hEDYVcH7/nD6XOF/NEhWeKhqWmeGXqIyvaA=;
        b=VNafHVTQg+QmPx3L7SP3SPidN/+RAtUTzJz1pYuMl7Ah6vyEKlDKz/ZmVvkp/ECtc3
         OkEf8cM0K6nFwUnWCZNb15SOaxvBLeoPpIiUOUfCJiqCqZkXLSIA20jYLHCD+ttvQXjv
         FVlZtA9Xg4QgxvXh0Sz/SRevpaegqydZTYt2Tftf/SHyf7/U4+sBMkFd9rmljcyN//LT
         4O13lvPaMek7POoac+T43vqBYGDMf99NBSr6hD5UIMI3YcUNM7o69N/49UQGVwIm8yZ+
         5QupCbMbhu8t4/i5/CEtdlw1o6GTlxFfUhdM2DZSWJk9e9j/161AkF6L2rym56mzA3nA
         8Zsg==
X-Gm-Message-State: ABuFfogWtM5SdPQhO1QRgPNpxHJftUhxMQhKioBIIqfBJzbUEpZa2Aso
        2sz/hfzo7yrd7w8D8Dl5PbE=
X-Google-Smtp-Source: ACcGV61ZDk2zEKk6oIIlQAwEUStFz4vL1T7a7mEwVky1rr3xKvyzhZpXRhQ8knj7MadYfUEr7oC3mA==
X-Received: by 2002:a1c:4182:: with SMTP id o124-v6mr2416344wma.101.1537914698175;
        Tue, 25 Sep 2018 15:31:38 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id o19-v6sm5158127wro.50.2018.09.25.15.31.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 15:31:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Duy Nguyen <pclouds@gmail.com>, Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH v4 9/9] Documentation/config: add odb.<name>.promisorRemote
References: <20180802061505.2983-1-chriscool@tuxfamily.org>
        <20180802061505.2983-10-chriscool@tuxfamily.org>
        <CAGZ79kYPik87zvLUPPKFzcATFUdBFcXrAkTYxpxvAQy6w1CcUw@mail.gmail.com>
        <CAP8UFD1ia1xWk9pjfTUQ3zD7=dP=8UjKzf=G0ptsz=qRH8_X+Q@mail.gmail.com>
Date:   Tue, 25 Sep 2018 15:31:36 -0700
In-Reply-To: <CAP8UFD1ia1xWk9pjfTUQ3zD7=dP=8UjKzf=G0ptsz=qRH8_X+Q@mail.gmail.com>
        (Christian Couder's message of "Tue, 25 Sep 2018 10:07:18 +0200")
Message-ID: <xmqqd0t1nr93.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> The main issue that this patch series tries to solve is that
> extensions.partialclone config option limits the partial clone and
> promisor features to only one remote. One related issue is that it
> also prevents to have other kind of promisor/partial clone/odb
> remotes. By other kind I mean remotes that would not necessarily be
> git repos, but that could store objects (that's where ODB, for Object
> DataBase, comes from) and could provide those objects to Git through a
> helper (or driver) script or program.

I do not think "sources that are not git repositories" is all that
interesting, unless they can also serve as the source for ext::
remote helper.  And if they can serve "git fetch ext::...", I think
they can be treated just like a normal Git repository by the
backfill code that needs to lazily populate the partial clone.

And it would be nice to be able to say "I took these commits from
that remote and that remote should be able to backfill the trees and
the blobs necessary to complete these commits" for more than one
remote would obviously be a good thing.  The way we mark the
promisor packs currently is by a mere presence of a file, but
nothing prevents us from extending it to write the nickname of the
configured remote the pack was taken from to help us answer "who can
feed us the remaining objects?", for example, so I do not think it
is an insurmountable problem

I guess JTan is the primary person who is interested/working on the
partial clone with backfill?  Have you two been collaborating well?

Do you two need help from us to make that happen, and if so what do
you need?  Stop the world and declare this and that source files are
off limits for two weeks, or something like that?


