Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92ED320705
	for <e@80x24.org>; Wed,  7 Sep 2016 09:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965016AbcIGJc5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 05:32:57 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:53308 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S964985AbcIGJc4 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 7 Sep 2016 05:32:56 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id E796A20533;
        Wed,  7 Sep 2016 05:32:54 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute3.internal (MEProxy); Wed, 07 Sep 2016 05:32:55 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-sasl-enc
        :x-sasl-enc; s=mesmtp; bh=iJmJGDn7btI6mSOASrBUseCPUCU=; b=nCJX32
        S7p315moAYvPQWYI439DdEhH8tbY8Lh4xiSiU1MSDAjfw+BQE+DA+5huzDCWEElK
        5JkEJrGBgKHR/gA/rHdJtwf660zCkVaF8bPXVdGQhsWTV6+OmWh+a12oyIVdRITX
        Z8O7jygHHYRiZ4jj6jDO/s5aKlfOj3OLV+5Vw=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=iJmJGDn7btI6mSO
        ASrBUseCPUCU=; b=kRQ/KLOzs6NoIAxtZAWZxFqHtcWzERqWNqPBY0YBqBLF+KB
        2TZZD72j54ABNsDlKz8e9MCERYZ718lajnAy5xDFlnluJo+/YNbmy11YHqkIbtCM
        ZgLPbQg8D2ryiXjsU1+u+0bS9Wr3qJY+ZpNkNvOIJBgDGTwp8x+b+hdL3ul8=
X-Sasl-enc: 17Jpr2kj6YLRVWbxM5IqfdmmPM9Xln/y/PYdKJ/BgS5i 1473240774
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
        by mail.messagingengine.com (Postfix) with ESMTPA id 43098CCE95;
        Wed,  7 Sep 2016 05:32:54 -0400 (EDT)
Subject: Re: [PATCH] gpg-interface: reflect stderr to stderr
To:     Jeff King <peff@peff.net>
References: <ced7502d-0095-bd90-19e3-c14d0e4d4f07@drmicha.warpmail.net>
 <18a7e2984121d988137c135ec560fee56506981b.1473167263.git.git@drmicha.warpmail.net>
 <alpine.DEB.2.20.1609061827290.129229@virtualbox>
 <alpine.DEB.2.20.1609061839370.129229@virtualbox>
 <alpine.DEB.2.20.1609061843120.129229@virtualbox>
 <655b42d8-baa9-e649-2b3c-5b7bfc914bc5@drmicha.warpmail.net>
 <20160907083947.b7q7ebe62xsr6447@sigill.intra.peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
From:   Michael J Gruber <git@drmicha.warpmail.net>
Message-ID: <225f43eb-d708-dd9b-77d9-aa8cbe2cd9f1@drmicha.warpmail.net>
Date:   Wed, 7 Sep 2016 11:32:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160907083947.b7q7ebe62xsr6447@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King venit, vidit, dixit 07.09.2016 10:39:
> On Wed, Sep 07, 2016 at 10:27:34AM +0200, Michael J Gruber wrote:
> 
>> Now, I can't reproduce C on Linux[*], so there is more involved. It
>> could be that my patch just exposes a problem in our start_command()
>> etc.: run-command.c contains a lot of ifdefing, so possibly quite
>> different code is run on different platforms.
> 
> Maybe, though my blind guess is that it is simply that on Linux we can
> open /dev/tty directly, and console-IO on Windows is a bit more
> complicated.
> 
> You might also check your GPG versions; between gpg1.x and gpg2, the
> passphrase input handling has been completely revamped.

That's a good point to note.

gpg1 asks for the passphrase (without use-agent), gpg2 always delegates
to gpg-agent (and starts it on demand).

On Linux, gpg-agent says you should

export GPG_TTY=$(tty)

to make gpg-agent find the tty, and claims it's not necessary on Win.

In fact, it's not necessary on Linux either unless you want to use
pinentry-curses.

Alas, be it gpg1.4.21 or gpg2.1.13, whatever pinentry, I do get the
passphrase prompt, even with curses (if GPG_TTY is set, which was
necessary before any patches already).

I put up a request for more input from the reporters in the github
issue. I guess that's the best way to reach them.

>> It would be great if someone with a Windows environment could help our
>> efforts in resolving issue C, by checking what is actually behind[**]: I
>> can't believe that capturing stderr keeps gpg from reading stdin, but
>> who knows. Maybe Jeff of pipe_command() fame? I'll put him on cc.
> 
> I know nothing about Windows, but I'd be surprised if gpg is reading
> from stdin, as opposed to /dev/tty. It's probably more to do with how
> gpg finds the "tty" on Windows (presumably it looks at stderr for that).
> 
> Anyway, I wrote pipe_command() in such a way as to be prepared for
> exactly this kind of thing, so it would be trivial to extend it to an
> extra descriptor. The trouble is that run_command() doesn't understand
> anything except stdin/stdout/stderr. We can open an extra pipe() before
> calling run_command(), and make sure it is not marked CLOEXEC. I don't
> know if there are other portability concerns, though.

My suggestion to try "--status-fd=3" was meant to test whether the above
could help: If fd=3 helps, then our capturing stderr is not the problem.
(If fd=3 does not help then we still don't know...)

Michael

