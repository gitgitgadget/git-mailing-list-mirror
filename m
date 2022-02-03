Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A70C433F5
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 17:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352958AbiBCRkX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 12:40:23 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:44861 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352956AbiBCRkU (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 3 Feb 2022 12:40:20 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id AF9515C0183;
        Thu,  3 Feb 2022 12:40:19 -0500 (EST)
Received: from imap46 ([10.202.2.96])
  by compute2.internal (MEProxy); Thu, 03 Feb 2022 12:40:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hurrell.net; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; bh=6FGvQCUMjt0+UFqrYtFQeKkvZSp1sOCaPyvu3E
        B1sU4=; b=SDjbDti3JVOXMueMsOQBM5xP5/f3qQKRdcQCCsrC8MtBj7oNH2nRO5
        sVY/Q3K+vKcDO5XLpJBU3laFHolpKx/sYcUgbxgjbXH41x7NvBM+/rSKH4glbqLY
        gc1jOdH+FY0sq/PV3CCjNi3zU5L/ljiYutrHBXPoNyMro4tkCIpqtBnK55wFqquH
        tBzQ6nSeL00wA4SQgPcCDtrZrUerFC2FNiJdgAbbtBHDwoISh62ybKUlBOY7XUqP
        6Uz5cPzQo0fFCxkOuslLIfT5QRE2FX7QBvJuLOjQNver+Z/IQDtqP74qFzvw57AS
        5muar9je3hunuFZc2vyfxjY/h/aHrB2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=6FGvQCUMjt0+UFqrY
        tFQeKkvZSp1sOCaPyvu3EB1sU4=; b=TarDyc3JUfVDFiaB3qEv71GkbiYW8jz1b
        /98Afr6vCbi1znLCEfIBE6T0dF7LovTxkolZP8xFlsiHDXcLG7JhUH0sQe6nAtXo
        OwY47Zh/kDjlYxLvLML2cU9/6s0WE6Ls/N5UdklmB0si+PAywqg+v4Rf6BJBYUop
        zMjr2aN8ZROdF8oAtphXb6ZybQEGoa+NW+Nv067lWqRdB1DnLE5qySL++OmmNMc2
        /x9JUCnHzUv/XZn0c9MYpu0meZXAQ+p/r5xgHyXv0LwlwwZ5QMdc7OFOJCfnkblk
        C3dX9e8cDVKph7bcLEbwo5gvJN16H7qlT0WI+DA+RNfbZHlPtnpYw==
X-ME-Sender: <xms:gxP8YarcBLU5wm267Ax902B734dz1uxzeXz7kJOPIznaYA4ovCmgcw>
    <xme:gxP8YYrMAJInWPsIpPZcV0DTUp0zEDrIxso9rL3EUR0zQDuYVJd69efwYtPUrHus8
    kFc5CcNMflwA-PZO30>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrgeejgddutddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvufgtsehttd
    ertderredtnecuhfhrohhmpedfifhrvghgucfjuhhrrhgvlhhlfdcuoehgrhgvgheshhhu
    rhhrvghllhdrnhgvtheqnecuggftrfgrthhtvghrnhepuedttdevtdejiedtgfefveevfe
    elkeetudeljedtjeeuhffhkeekveetfeevvdehnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehhuhhrrhgvlhhlrdhnvght
X-ME-Proxy: <xmx:gxP8YfNqsxQTss17VdqfJW0soCgYHw79qRiLpsQO7eSvGPq8VPChcw>
    <xmx:gxP8YZ5HYpmfek3fYmulVM-Ep0f0vmHB3X_msOK5-gnIOQZmcjZJuQ>
    <xmx:gxP8YZ42HOEKxSC5yv4jP79Bmxxqz-FfUOkbc2khYwUWe_sjXuWJRg>
    <xmx:gxP8YWjT-aQJTg6Nk6BaEcFs7zEbA4OlX47KNpNlEjQCEac_5wjGGg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 363051EE0439; Thu,  3 Feb 2022 12:40:19 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4586-g104bd556f9-fm-20220203.002-g104bd556
Mime-Version: 1.0
Message-Id: <3f1972f3-c764-41e9-9853-8f1c303d4f6b@beta.fastmail.com>
In-Reply-To: <0b8222c2-7337-7e8f-33d1-7926462daac1@gmail.com>
References: <ee1dd453-e698-440a-911b-d14389e33715@beta.fastmail.com>
 <0b8222c2-7337-7e8f-33d1-7926462daac1@gmail.com>
Date:   Thu, 03 Feb 2022 18:39:58 +0100
From:   "Greg Hurrell" <greg@hurrell.net>
To:     phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: git-checkout doesn't seem to respect config from include.path
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 3, 2022, at 4:54 PM, Phillip Wood wrote:
> Hi Greg
> 
> On 02/02/2022 16:04, Greg Hurrell wrote:
> 
> > `git config --get merge.conflictStyle` correctly reports that my setting is
> > "diff3" on such machines, and `git config --get-all merge.conflictStyle`
> > shows:
> > 
> >      diff3
> >      zdiff3
> > 
> > In other words, it knows that I have multiple values set, but it uses
> > a last-one-wins policy.
> > 
> > However, when I try to run a command like `git checkout -b something`,
> > Git dies with:
> > 
> >      fatal: unknown style 'zdiff3' given for 'merge.conflictstyle'
> 
> I think what is happening is that git parses each line of the config 
> file as it reads it so the old version of git sees "zdiff3" and errors 
> out before it reads the include line.

That gave me the idea of moving the `include.path` setting higher up in
the file, to see if `git checkout` would consult that value first, but
it doesn't work; `git config merge.conflictStyle` shows the value from
the file indicated in `include.path`, but a command like `git checkout`
still dies based on the value in ~/.gitconfig.

Overall this points to the general problem that it is not only hard to
make a single config that works on different machines, but it's hard to
make a _combination_ of files that works on different machines.

For now, I think my workaround is going to be templating out
machine-specific files.

Greg

