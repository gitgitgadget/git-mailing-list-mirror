Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2279E1F597
	for <e@80x24.org>; Sat, 21 Jul 2018 23:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbeGVAES (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jul 2018 20:04:18 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:35590 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728236AbeGVAES (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jul 2018 20:04:18 -0400
Received: by mail-io0-f175.google.com with SMTP id w11-v6so7208803iob.2
        for <git@vger.kernel.org>; Sat, 21 Jul 2018 16:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nYeI+PZlJuLv5E+Xv9eaXOQclR6rr8qolKduivZzKeQ=;
        b=Sei1EChhkFoPudXp4t4kFGlF0v/7pPmxZa6LD6m2Q9E00cFAf2J22aI/uG7n+TiFY4
         3xvQ94y4qFBa1NAU18CAtM+lD1Gn3SavAZ+2/JovjpCdzrTMho6/elnl+gsEIhUdVf2g
         wW8Ax/v+b1Zwi8AIT1MbXGoTMrcgOj2R95NnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nYeI+PZlJuLv5E+Xv9eaXOQclR6rr8qolKduivZzKeQ=;
        b=QpExJGN2GBYS63UnsJBb9U9n8ROfbQiBj9w9Ff///Psyo2A29JvHo+BCT12MpqR8Zf
         Y66uO3nMxkD4Adk26+z0HXmu/aQey23PJzSp/uVqWnVcZGd2uJADI8C9suSR2FuV7snn
         +1ioaNgp3IbjnM8rXcHGIp1yMo2EuHUxbXj1AnAVK97A9wWXRpmjVchGFb6sV5quimZ7
         cjexgmqUpE1UOEbpUYKRKbSuSGu5rJbbqpzkf/xNwYguzCYLb+ubYrI2d1c/AgU6Tn+w
         0ajaSsBJQMerQQqg78YUS4mHY9RGDilcYApOTepEVUH/MKyzi3frdi95OQv2PmhYV9+S
         86Fw==
X-Gm-Message-State: AOUpUlG0AFolJ6iSwOnyZ5W8tUDfPaYH+yoM9MrLVgi8Twx7fN2qt+Cd
        MgrIsvubgVs0v/7oGymZtH2g+k29ePTxkmxLdU8=
X-Google-Smtp-Source: AAOMgpd9QmjvzXqgMY+UW0vXN4jpQLChcmE978H+CAUafH3zsGEpzv6pobHwTQYUXlbTRbdycgFC1t+vwswxEbkyGqE=
X-Received: by 2002:a6b:f612:: with SMTP id n18-v6mr6109463ioh.259.1532214592664;
 Sat, 21 Jul 2018 16:09:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180609205628.GB38834@genre.crustytoothpaste.net>
 <20180609224913.GC38834@genre.crustytoothpaste.net> <20180611192942.GC20665@aiede.svl.corp.google.com>
 <20180720215220.GB18502@genre.crustytoothpaste.net> <nycvar.QRO.7.76.6.1807220036340.71@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1807220036340.71@tvgsbejvaqbjf.bet>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 21 Jul 2018 16:09:41 -0700
Message-ID: <CA+55aFy_OJPMFbzMfN9yKwdGsx-8FZ0v_zt-d+xCN3KSCqdB9w@mail.gmail.com>
Subject: Re: Hash algorithm analysis
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        demerphq <demerphq@gmail.com>, Adam Langley <agl@google.com>,
        keccak@noekeon.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 21, 2018 at 3:39 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Do you really want to value contributors' opinion more than
> cryptographers'? I mean, that's exactly what got us into this hard-coded
> SHA-1 mess in the first place.

Don't be silly.

Other real cryptographers consider SHA256 to be a problem.

Really. It's amenable to the same hack on the internal hash that made
for the SHAttered break.

So your argument that "cryptographers prefer SHA256" is simply not true.

Your real argument is that know at least one cryptographer that you
work with that prefers it.

Don't try to make that into some generic "cryptographers prefer it".
It's not like cryptographers have issues with blake2b either, afaik.

And blake2b really _does_ have very real advantages.

If you can actually point to some "a large percentage of
cryptographers prefer it", you'd have a point.

But as it is, you don't have data, you have an anecdote, and you try
to use that anecdote to put down other peoples opinions.

Intellectually dishonest, that is.

           Linus
