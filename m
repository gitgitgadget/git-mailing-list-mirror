Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7636DC433B4
	for <git@archiver.kernel.org>; Sat,  8 May 2021 04:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 512116054E
	for <git@archiver.kernel.org>; Sat,  8 May 2021 04:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbhEHE3h (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 May 2021 00:29:37 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:55869 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229467AbhEHE3g (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 8 May 2021 00:29:36 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 842F15C009D;
        Sat,  8 May 2021 00:28:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 08 May 2021 00:28:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wfchandler.org;
         h=date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=CJ/NrtkyaWW+FKX0gVPEOlc3FBk
        Q/uCEo+r4K43eU8c=; b=JqVuiS/rCtTAF3IvltJuAWIFxrJDZs9TD1D8+P1PzkP
        yr0K+d/8aDSJjmEaPh2FLzBfdWujz598kWS4Pr1Ag2gDkWQlgnzQ2fLZFVyaotro
        m0v6gg64fZxdByA7aeVfd7rrGbCMoNDWo+Tkbrpeh6Q/3XAqpW3cSu1tqT6E2OpY
        xCw1kR5+GFJd4C7A5qDL1Y4PuRseim4zSJtTZ9ALyqCw+2U57/rfcu1G6WK1eLFT
        zo5RtX7zPTovKBE/gOdLwTWl+hh4DBqDZxccWZyTgYMsZyvLg0LeZNsH+1pfIzYq
        /ZNmi60Fm0y6JzSmy3Tz7mE/d55CHVmYyAeNRz6odeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=CJ/Nrt
        kyaWW+FKX0gVPEOlc3FBkQ/uCEo+r4K43eU8c=; b=MG/Azu2NBZagqH2QOAakA/
        oky34+w4c09HZOg5fK7zll0NZ+7W6w47D4MB4ekbcRFs3Jl6FUSYh64tZuunVUuf
        jB2PCjTQDQp4cL88v5kfdvTKI3hE5wRQvy+OYidVYQyxUa6U0kdnaTUvXlXs4gj3
        BCkOAPwvG2ebXpfe28Fq6nfUCytrN2e1e3s9yHRlwmFUFr3bqfa99krlSgtQhOKa
        +Jz9MNxVDnI2/+UbsfjexSqD/e/zdeZTLIsqkq2zk3v6OovKfTsjKM24fPzXGgQ5
        LPEhE3pipKba6+um41JtZFicVO5d5ODCj9K0e6Ms/b32m/P9k5VkGt/B812IkMfA
        ==
X-ME-Sender: <xms:cROWYPt_IPNOpMjenzgkmwe4ORKxo5Nl4Au9EjYjSc0tKmmvbJQ87w>
    <xme:cROWYAccLKVJazjkit4r-6vOyl4-4LOLs7fQPHS5aGHwthZzPQs7zP-ImsoNoJVzK
    b72ns9GYhN9yqQjBLE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdegfedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtre
    dttddtjeenucfhrhhomhephghilhhlucevhhgrnhgulhgvrhcuoeiffhgtseiffhgthhgr
    nhgulhgvrhdrohhrgheqnecuggftrfgrthhtvghrnhepgfdttefggfeludfgffeutdfhue
    etvdeikeehgeeihfeugffgueeutdeuheduieeinecukfhppeejhedruddukedrfedrudeg
    leenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiffh
    gtseiffhgthhgrnhgulhgvrhdrohhrgh
X-ME-Proxy: <xmx:chOWYCyRytQczYpw5UFGdcfjyAnEbDZuf8PtsmQEijwgKonsz48ikQ>
    <xmx:chOWYOPDINpNsXPIbEUvkBKu7je7umNuAqWfOmchNzf52aCsc56Kog>
    <xmx:chOWYP8defvP25s60MMwom3S9Sw4CVLLUPWLPRUuSMLUxc9AlOjFhg>
    <xmx:chOWYMEn8LVVYRj-CtPwo862AiCF1EzM5alaj0sEo21D-SIzxwagGA>
Received: from mini.wfchandler.org (d118-75-149-3.try.wideopenwest.com [75.118.3.149])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Sat,  8 May 2021 00:28:33 -0400 (EDT)
Date:   Sat, 8 May 2021 00:27:45 -0400
From:   Will Chandler <wfc@wfchandler.org>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH] refs: cleanup directories when deleting packed ref
Message-ID: <YJYTQYk5q8g6HaIm@mini.wfchandler.org>
References: <YJVQpaDwkQH/aCee@mini.wfchandler.org>
 <YJW3n6lVWVAuLQap@coredump.intra.peff.net>
 <YJW46fsdKaUv2Fln@coredump.intra.peff.net>
 <YJXF4xA0GFx2/2v4@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YJXF4xA0GFx2/2v4@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 07, 2021 at 06:57:39PM -0400, Jeff King wrote:
> Getting back to your patch, though, you are definitely fixing a problem
> with update-ref (which correctly realizes there is no loose ref to clean
> up, but forgets that we had to make a lockfile). And the solution you
> have looks correct. I think you just need to update the test to exercise
> it with "update-ref -d".

Thanks for the thorough analysis! Apologies for the confusion, I really
appreciate your patience.

I'll get the test fixed and note that this is specific to 'update-ref'.
