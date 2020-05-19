Return-Path: <SRS0=xHKm=7B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B02C433DF
	for <git@archiver.kernel.org>; Tue, 19 May 2020 04:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6440620708
	for <git@archiver.kernel.org>; Tue, 19 May 2020 04:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=iskunk.org header.i=@iskunk.org header.b="Af26rmft";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fr7T9Lkz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgESEW4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 May 2020 00:22:56 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:51773 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726045AbgESEWz (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 19 May 2020 00:22:55 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id F2C862BA;
        Tue, 19 May 2020 00:22:54 -0400 (EDT)
Received: from imap36 ([10.202.2.86])
  by compute7.internal (MEProxy); Tue, 19 May 2020 00:22:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iskunk.org; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm3; bh=9EcWwNufyZ7ZwG3Zm29HmmYVCHNsMwX
        pLXH4K7tUnSM=; b=Af26rmftEcu86gXatBzXFM4fB01lLhQ+cFl8aRFcjq69ke2
        65tqF2eoKZ4+C4u9b+GE15yu6fvO+i5R0QFAgd5q2orHlzLqbw/3DPeUYCbVut/f
        H/YjBNWAqjWtvRNhZFvm3b4Sx+wuadB6LUryTR2VGP2NxZ9vV4Sd1phGpn4nk/ep
        DnFKfeRYuO8xtH0POL3fkmCmGUMlXfDUOr18EejjxxkpRPECqlQ0gaUzzjV/tdb2
        y7DvggkGwv5WfoB2nneLivIcMbQDZkp/bAVYlWaSbxM/dAcdFXaXGjWL4y0fpP5l
        7QWP5hlMumCf7bM7ihNQ+9b7FBFi52P014NuJ2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=9EcWwN
        ufyZ7ZwG3Zm29HmmYVCHNsMwXpLXH4K7tUnSM=; b=fr7T9LkzH0Si1VVYvYXZMg
        gSQf72FYooQFecyVrZG8r4NaJQ59TgOmYjzL3AhrdY4njBwAOhxcGPhpNQNQSuoJ
        55Gwxtxx15FGGglkijI6GLmB+yfC6ZBuLvI+1cvKPwsocXMlrwLcyM0kWIAav8t/
        yuxXTYO+1lkDJVIDfIunFKu7No623PqAYb7CVKUhLV955h3TlRbzn3iB8g6GHWBM
        N8PJWHl8IuVFdr+z9egCYV2gC5kBMtQyhPltWhesHhcE6YhijDNB4iC8vLfduMqG
        WexKpqYPBSyg2Nz8bl0tYTyM21FhtSd9RNqRFg5fmOV2Fr7oDHtQ1D1/wweMasOA
        ==
X-ME-Sender: <xms:Hl_DXmvs2NHtd6trwhAXM9i54PIGwzAJyVe4WW-KITwFxMblkeQHrg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddtiedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvufgtsehttd
    ertderredtnecuhfhrohhmpedfffgrnhhivghlucftihgthhgrrhguucfirddfuceoshhk
    uhhnkhesihfumfgfpffmrdfqtffiqeenucggtffrrghtthgvrhhnpeekvdehgeegvedtje
    egudelvdeghfejuddujeekhfethfdtfedvieekgfejgffhueenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehskhhunhhksehiuffmfgfpmfdrqf
    ftif
X-ME-Proxy: <xmx:Hl_DXrfnXkJaHYhJ0AOBEjc9-24nQ_J-ZnZ0E0zeq4y0ZYDSqhp_HA>
    <xmx:Hl_DXhxrq8xAAiABFviRijMoXb_TkWNmbxS4ZO6K_yQ_ahLnIhpyIQ>
    <xmx:Hl_DXhMv63G0RZLGTZE75xx26aMywiE7ksplIvLsUqRDAbFCJ3YNIQ>
    <xmx:Hl_DXpJZlPS5FmcxPomxrUMgF8rKlSbOxOmLeqdYfcoEYxX9UHD65A>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 253F51880067; Tue, 19 May 2020 00:22:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-dev0-464-g810d66a-fmstable-20200518v1
Mime-Version: 1.0
Message-Id: <40a42f1d-61bd-46fb-8946-5588df7b044b@www.fastmail.com>
In-Reply-To: <20200519024945.GB70483@coredump.intra.peff.net>
References: <7422404e-7fc8-4961-aae4-3f0adb71bb3a@www.fastmail.com>
 <20200519024945.GB70483@coredump.intra.peff.net>
Date:   Tue, 19 May 2020 00:22:00 -0400
From:   "Daniel Richard G." <skunk@iSKUNK.ORG>
To:     "Jeff King" <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: Minor portability issues + fixes
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

On Mon, 2020 May 18 22:49-04:00, Jeff King wrote:
> 
> All system defines in Git should be pulled in via git-compat-util.h.
> That does include stdint.h, but only if NO_INTTYPES_H is defined
> (otherwise we prefer inttypes.h). And POSIX (2004) says:
> 
>   The <inttypes.h> header shall include the <stdint.h> header.
> 
> But perhaps that is not so on AIX (it wouldn't be the first time we've
> seen a platform that does not strictly follow POSIX).

On AIX 4.3, where I am building, inttypes.h does not #include stdint.h,
and stdint.h is not present under /usr/include/. (This is an old system
used for ABI compatibility-testing purposes.)

This is not general to AIX, however, because on 5.3, both stdint.h and
its #include are there.

That said, my build is using GCC 4.7, which provides a modern stdint.h.
The GCC tree contains a fixincluded version of inttypes.h, but this also
lacks the <stdint.h> #include.

> Does building with:
> 
>   make NO_INTTYPES_H=YesPlease
> 
> work?
>
> If so, then perhaps it should be added to the AIX defines in
> config.mak.uname.

I've confirmed that this works. But would it not be safe to #include
both inttypes.h and stdint.h explicitly if both are present, rather than
cater to AIX specifically? I could see this similarly arising in, say,
an old version of Solaris.

> > Setting that variable to an empty value causes a bare directory to be
> > passed to the linker, which of course then errors out. I would suggest
> > setting it to "-L" instead.
> 
> That would just be redundant with the earlier argument. That might be
> the easiest way to turn it into a noop, but we can probably do better
> with $(if) or similar, which would allow somebody to build with:
> 
>   make CC_LD_DYNPATH=
> 
> even without using the autoconf script.

That is a fair point. CC_LD_DYNPATH is used only a handful of times, so
this wouldn't be much more work.

> I do wonder, though, if configure.ac could be extended for AIX to
> support whatever syntax the system linker uses for setting the run-path.
> I understand that you don't care either way about this feature, but this
> might be a good opportunity to fix it.

This could be a bit complicated, I'm afraid.

The applicable value for CC_LD_DYNPATH on AIX is "-Wl,-blibpath:".
However, have a look at the description for this option in the
ld(1) man page:

       libpath:Path
            Uses Path as the library path when writing the loader
            section of the output file. Path is neither checked for
            validity nor used when searching for libraries specified by
            the -l flag. Path overrides any library paths generated when
            the -L flag is used.

            If you do not specify any -L flags, or if you specify the
            nolibpath option, the default library path information is
            written in the loader section of the output file. The
            default library path information is the value of the LIBPATH
            environment variable if it is defined, and /usr/lib:/lib,
            otherwise.

(excerpted from an AIX 7.1 system)

That implies that when you use this option, you must specify not only
the path you're interested in, but also /usr/lib:/lib! And when I look
at an existing AIX build of ours, that makes use of Libtool, I see that
it is in fact passing in a rather lengthy path for -Wl,-blibpath:, that
ends with ":/usr/lib:/lib".


--Daniel


-- 
Daniel Richard G. || skunk@iSKUNK.ORG
My ASCII-art .sig got a bad case of Times New Roman.
