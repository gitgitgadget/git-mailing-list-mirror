Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5494C32772
	for <git@archiver.kernel.org>; Tue, 23 Aug 2022 19:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiHWTlY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Aug 2022 15:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234036AbiHWTkk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2022 15:40:40 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D468985AB2
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 11:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661279906;
        bh=Py4DZ5ccGE2HF31wDssxa6we9w/IudbvaApoY2LjTRU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=CkrG7Us7jOOsmoEN/VEJ/fvGAIrQplP+AWlv+QrslZGURj2iASb1rDc+lfY06rY3m
         CCYi4UfUoC9H8Zc0t889mk1lm8j1gj6aQ4wpaez2p7wD53LdIU2CiVft8QmPzHB4Ll
         tg6+sIVCUzPqxmk/pKaygq5WNCKwg17G7NWGZ2F4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([89.1.212.11]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MBm1U-1oaTsb4BsC-00C6K5; Tue, 23
 Aug 2022 20:38:26 +0200
Date:   Tue, 23 Aug 2022 20:38:27 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
cc:     Git mailing list <git@vger.kernel.org>
Subject: Re: Regression in 'git add -p' with 'interactive.diffFilter' since
 builtin version is default
In-Reply-To: <s40ss309-3311-o08s-38r2-9144r33pq549@tzk.qr>
Message-ID: <2qpp7417-79qr-364s-3798-r471sp6ron54@tzk.qr>
References: <ecf6f5be-22ca-299f-a8f1-bda38e5ca246@gmail.com> <s40ss309-3311-o08s-38r2-9144r33pq549@tzk.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Dp65aIXfMq1rUAsRTmZMEl5ku4/0WmeQ1XeN4mVBmwtTag1w+rh
 YLkLFOA4VckDwA+2VNUB5rbaQq36s3JTB/LBqifjlEW/zlfM1l70YveeNE04W6kYjnvJGRj
 aOnbII8nEb0mjpD+4i6R/4d7M8cuSKtHrq3P28ROcTx6/yRPtIOmXKXRlXr1Ne8w7HjfmGD
 9YvACJyh+5da6spVGxg2A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zSU55RNqSTI=:/wls/d5LJk87ilpxQLBOI9
 AxGtgBGwcMZWmQkbTl9HdhjvT6DPM+fuJB4LLlH28VvbHREu6qQ0VXENR0x7vO9FUzVzFZg+1
 5c9WXqfSOp148/B8ZP/IguDIR7Xoeir8XVBOXtY7KI+EY7yDbkKA5okD0RvPlC6IRX10jXtp9
 s4QsD7aDz3eGPtmHSMQNpZo+6tdqpvICfwxv0x5C8RWHR+TGSSpXTGmv9+kHwb8HaJWVucN0E
 aJ7h2B49D3BtASXn2sv/YcydzlTFEq5w2UiMGVQ+xfYxtGwuc6oF1U9S5L1gRgh5W4+91zD+A
 17a2sE0skFCavev7v/lzYeJOAP7YgG7Y2Ot7zHQ6BAYNkJkAqmDxogunpoETdBNYinmPGyzcH
 9R+0/mP6SB5Xvz2enCokkAqghBZ3NofYeluKPmo8hpBtZW/LE9pkBVIBuTzKn2aVk6jhLv1nc
 jl5rx8xSYXVXgCjaI2SR2T8aZcT8qdraVT8vWek26ErvTAWLLaAsvyLTMKANgnmPidenK8bEo
 dFU6xASdScNskOojK5fmZDOcJhOA1OnPeurU9XY1iTccf7FbOyqXe3egDW/TN/62thBgOfRim
 /uq2jaSsaEDXjCiU8fynT4mEevIIcNkx9jt1fehbosDpOlAlnVN1JVglLbRoElje6YsGvl+iA
 i+aqdrqFyJmlEOWSCVzoYaEHz8IYaky4qmquIO0TUYNKYe3vgNl57s03DO1BffWUxnapPwawW
 jqcltlec9Q6/sHv0o5PLEoKCDEAODIWVIK0BGMsCUhFRV0RxfXe1sRUJCtXkJC8eFHu+diwj3
 3QW2FKKVCBYj8Nnnf9DRX1593xRA5Gxr77RAv3RoHnVSEBFxPmFDi9IySOFrnR44emdrwLq2q
 6kVjw9T4sgH11Te5ppSYiEih5NlpasuDSgOI+dGYYefzIZK77Uwq3oiOicWVgFLv3TZcdzDQM
 wdQWztZF2XqZP+pSi6+kbcmcIS9Q2Lh+UI5FpPEJVY+bzKrldamYBRadlUnSGbDM9u07eoP2l
 B7cUfKTt/ux/5EjfXwrGvl95Xz20MV8ORxN+btMxDYB+zm7Nco1Kx6Zt4t4tFDD9Yv1Ogv26d
 cLQ9p9s3mDUPwH4RJ+9xi86bDYrnCPCIAr4JZoTgCdPnW22R4LVQ5eHXQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philippe,

On Tue, 23 Aug 2022, Johannes Schindelin wrote:

> Hi Philippe,
>
> On Mon, 22 Aug 2022, Philippe Blain wrote:
>
> > I found a regression in the builtin 'add -i'. I use diff-so-fancy [1]
> > as a pager and also use it via 'interactive.diffFilter'. With the
> > builtin implementation, this errors with:
> >
> >     error: could not parse colored hunk header '?[36m?[1m?[38;5;13m@ f=
ile:1 @?[1m?[0m'
> >
> > With the Perl version, it works fine.
>
> Hmm. This looks different than what Peff reported in
> https://lore.kernel.org/git/20201112184026.GB701197@coredump.intra.peff.=
net/,
> where the command errored out with:
>
> 	  $ git -c interactive.difffilter=3D'diff-so-fancy' add -p
> 	  fatal: mismatched output from interactive.diffFilter
> 	  hint: Your filter must maintain a one-to-one correspondence
> 	  hint: between its input and output lines.
>
> I _think_ I have an idea how to address this. Stay tuned.

Seems that the Git mailing list is taking a mental health care day... it
took a while for the quoted reply to show up, and while I submitted
https://github.com/gitgitgadget/git/pull/1336 half an hour ago, it also
has yet to arrive...

Ciao,
Dscho
