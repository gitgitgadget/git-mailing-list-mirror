Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C821CC7619A
	for <git@archiver.kernel.org>; Mon, 27 Mar 2023 09:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbjC0JLD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Mar 2023 05:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbjC0JLB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2023 05:11:01 -0400
Received: from mout-xforward.gmx.net (mout-xforward.gmx.net [82.165.159.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A0E171B
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 02:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1679908242; i=johannes.schindelin@gmx.de;
        bh=zP/VadzbsCpWzb41WIXNsSqcVt4V0sxU02isBP/IIY8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=mg+0i8+K/fMS6F43D5OlbLHKWxe0BqdQ+tTUbHmfC44a2L2BmFzQU+OE1QfExt1Zd
         fLiboDsMS5f4mIzWlLPDK0NfNlSOCJ4RHdoH2KW+t9ipdK0KRhWbrBrkKc57BnDJKY
         QPpzhmBZ8w9FEZ6HtaUbRx1RBJFJk5q4wLuU9SEel06rhhjayY6z8Nbxoi+3U7ZtSg
         3iaRfO6lDESOsm4f3WM0EG2hQnyVd3Q71wWyxpUDF67mdqHbCs9fgaqMjaCWK6XWd1
         Nou9DHGBGq/fYYVeUKMSFx96xa9bmCKwM4kjNv6EPEGnIQXUj8p79UidEl00KqkBC9
         oc3b0MZdBn6UQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.93]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MVeI2-1pqaGM25p6-00RWEb; Mon, 27
 Mar 2023 11:10:42 +0200
Date:   Mon, 27 Mar 2023 11:10:40 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Matthew John Cheetham via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v7 00/12] Enhance credential helper protocol to include
 auth headers
In-Reply-To: <Y91FjhNgZGz6foFl@coredump.intra.peff.net>
Message-ID: <0f94b998-e223-85cc-7730-f75675d5e649@gmx.de>
References: <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com> <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com> <e57c1ca3-c21c-db41-a386-e5887f46055c@github.com> <xmqqwn5bg695.fsf@gitster.g> <Y9JkMLueCwjkLHOr@coredump.intra.peff.net> <xmqqfsbxcmdd.fsf@gitster.g>
 <6f83ed25-a7e1-06dd-f180-d70c7e1b1973@gmx.de> <Y91FjhNgZGz6foFl@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:VmN5JKbfXtQBgwVPYI6GkpVQ5xyFoIl7OX3iS0LANE6FEDPbM7n
 debpUN7RtRp4pUHkVO7HjX65/epxR4qcANqkxrYgLrAMDdR7HjhCQqDY4h0S8GejPD7dL5U
 uGJoTXoTa31CIZShtu7RT1H2ljYMLAwnaq57rssSDe9x6YmP2K5pWb3MnSRCPwflwO4NpnR
 JnfXqO6WWt8/Fxkmyog8g==
UI-OutboundReport: junk:10;M01:P0:ILQsNmtHkHU=;oL3NYTp+sMqmMFeerelUHzuR5ZmDi
 gKvk0a1uWSz3UpzYBs8A58SRXDzENPH1NyVq3INXzl+n4SIkOZCgj6bhQOlOlAGsm03MTxTyB
 hCTk41bBzrv+vp70kbN6AasPsLfiiYLIf0NToGwdvLynFHpI6KYZus+4nPgeKwXB8dkaMCoKi
 QebF2stsR4vTV87qmcyq9F5AFOvNBo5Cpd30fClFbSSxC54qf6LOCMrpd9NIGXUfvkFmAJBmQ
 2Wy0mdmQAmTExabZbLiIpu/0nrNZ9zI5fso2CI5+5BQDSezKvyEQUhhFusmL1vSfAA8FmYBUW
 zkoLhEUHAWBUxXhqUyj7+qAFFR2zfNY+z2VRCbkvgcyoszN0eGTrCveZBath8sl5FYfrizDic
 dRl9f2vm32ieXQB4B5zY2pEHLUw8JmMTJ8UnR1br8uiJz5M5zM92zKRKSjXSmW4KRQ3bJZ/yr
 /9o+FMDNThSQN8fA0bxrmXC/GoiGev8+tQQmyY9uCWFmC3UdK3aoBt5QKH8wAQ1eKLT8VsEdj
 ihQw1tP06Xq1TxddQzYJG3MWoOOW8PW2AcOFXByW7lpnqPbYMr0ZfNDpb9LcGeMtDN7vE8H0Y
 XYIwiff45pb6tqy6Cartira4wRbsqPls/6DI3EpWlC8H+OyrrF94hlKCkZwx8kag9YSiWVWy4
 5VycEjtdMrcnlpmV64+XxiTgG4Q+vfBso/kjqhUIhFF4NLygJx1b93yhjB/O7fO0I3Nl12T+n
 Yrw49R7DTeSgwMKtH3vKU6Os02bO0Lz5VWMOzETlE7E4pPXWhUUFAgy7oyjoitdzwtGrs+dmN
 3pXmnW1nak3Ju/0QloV5odJ1Z3jVanx+xCSCYEW/6ElQlafnErjinnqVlZBj3mjbSh99przB5
 lhre/hyuQ2mfB43/hg9cZrEkuWcrDGdAKG+tQqc0427s9tFHYbR9T9uPYK5l1hHrtoeTxLNBD
 fuOsUl/XfxD46ivvKMGqYzRb62MImdjRvQmPYPau+xrOBfsOZQejAy8UBiLQIZnSieWQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

On Fri, 3 Feb 2023, Jeff King wrote:

> On Thu, Feb 02, 2023 at 11:14:33AM +0100, Johannes Schindelin wrote:
>
> > > I do not mind reverting the merge to 'next' to have an improved
> > > version.  Your "do we really want to add a custom server based on
> > > questionable codebase whose quality as a test-bed for real world
> > > usage is dubious?" is a valid concern.
> >
> > Except.
> >
> > Except that this code base would have made for a fine base to potentia=
lly
> > implement an HTTPS-based replacement for the aging and insecure
> > git-daemon.
>
> I'm skeptical that it is a good idea for Git to implement a custom http
> server from scratch.

To be clear: I never suggested to implement a generic HTTP server.

All I wanted was to have a replacement for `git daemon` that speaks
https:// instead of git://. It does not have to speak to every browser out
there, it only needs to respond well when speaking to Git clients. That is
a much, much smaller surface than "production-ready server, HTTP/2 and so
on".

And while the proposed test helper was not quite complete in that way, and
while it may have had much of the `git daemon` code that you would love to
lose, it would have offered an incremental way forward.

I am afraid that this way forward is now blocked, and we're further away
from dropping that `git daemon` code you wanted to drop than ever.

Ciao,
Johannes
