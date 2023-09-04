Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3BCC83F33
	for <git@archiver.kernel.org>; Mon,  4 Sep 2023 17:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345881AbjIDRNo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Sep 2023 13:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjIDRNn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Sep 2023 13:13:43 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75522E6C
        for <git@vger.kernel.org>; Mon,  4 Sep 2023 10:13:37 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 653315C0196;
        Mon,  4 Sep 2023 13:13:34 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Mon, 04 Sep 2023 13:13:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1693847614; x=
        1693934014; bh=P/mITRclCqJvOImtoeD+iPXwpizoTct2QStUXqqzsiY=; b=A
        begj5BYM2UppEb1W/Vw+2I2q95SQ7lDfUBcilqWUVGjlEHJOTokKi4+JXpGTodE+
        B/Y8MZXuwt1QbnC0EyhFpZVKhax9wiwJAyKXgeN8M4zSWhFzpRZI3dXBcNHCgV1C
        0Qyz4uhoO2rj312DXpk/hf+EVGrkYAg6TO2HO1YJOCpmOkE/kKnPmdASsVTgT1BF
        paTK7mTaA0RhAJZ95fz4j6VEmWxjeUF4DUA6nakxRtyx0npcjXjdovLB6Rp+uCO6
        nDQhQhjYL49gU2bzymu1UsIYdg+Vfx6fhSZ3u5vFa1k14/AgXutucM1h9aZGrp6w
        4mAKqz9L29CqaZp/92znA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1693847614; x=1693934014; bh=P/mITRclCqJvO
        ImtoeD+iPXwpizoTct2QStUXqqzsiY=; b=fZcixBReRhEQHwgqectgq+FMtDLsN
        huA+BcVLcueLSVjjk0H8GD3n49GKsjGS6NnwVcdytECdkfviQwYcrP4bcPPPPJRX
        j8AqYiH4n6wWkQc2PowegfF8/+kJtXjbzOFw7hR/ULD08CCJ34Tvqf+1Gslqxsil
        mJj6r+JEOXFxhjx2gzRc4rZw/8FbGBgmFe2wtNA7P9Od51mPcti1a4xYHrvTH4ja
        MP4hJjLkNx7DlHygI9Hl2Te2MYjqluTAu9d9xXXtSUCcCIwxblGi7D2AVLgaMaP5
        XpL57xasYtSyRdUKIzH0A71H92dOKYTQUvP+mS5EpztMp33fY+Njij05Q==
X-ME-Sender: <xms:PhD2ZOaNZ4e7riVtZ0Uyjn833a-xfmDSKO-eYYUqojp4Wqoc8t2xl3s>
    <xme:PhD2ZBYrkjyqjsZmFQn-gFIw5Ohvru2nKifKipG5OpmpZlzwzL4C6t6RTZDRwgVZG
    DvodUE9_ldBl9vSQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudegkedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedtkedtjeeiffelteffheeiheeufffg
    heelueeftdejkeeufffgiefhgeekffffueenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:PhD2ZI90muA2nRARTF0jABs7N5k9LOwwEARZ7lshSewtmYtvk18p8g>
    <xmx:PhD2ZAqHMyFKbShwFKRBtVM8ZZxK9HFMZV2sPjolUhjRUVPS1-qNcQ>
    <xmx:PhD2ZJo_v9NbKlXJ559zWiablUN4wj6MDHLZnaeVM_du-iyjc7KknA>
    <xmx:PhD2ZKCpTB51FwpNYrjWX_zrz9vrS6vl8IEf5SNXiZDGDvPT278-yQ>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2252B15A0091; Mon,  4 Sep 2023 13:13:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-701-g9b2f44d3ee-fm-20230823.001-g9b2f44d3
Mime-Version: 1.0
Message-Id: <8642763e-d3e7-49c4-b2ea-d5e4bebfbca5@app.fastmail.com>
In-Reply-To: <94b9535b-8c2a-eb8f-90fb-cd0f998ec57e@gmx.de>
References: <cover.1686505920.git.code@khaugsbakk.name>
 <cover.1693584310.git.code@khaugsbakk.name>
 <e9a59108311369d8197b9870a8810d5283ec124f.1693584310.git.code@khaugsbakk.name>
 <94b9535b-8c2a-eb8f-90fb-cd0f998ec57e@gmx.de>
Date:   Mon, 04 Sep 2023 19:10:49 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, "Denton Liu" <liu.denton@gmail.com>,
        "Jeff King" <peff@peff.net>
Subject: Re: [PATCH v2 1/3] range-diff: treat notes like `log`
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On Sun, Sep 3, 2023, at 14:17, Johannes Schindelin wrote:
> Hi Kristoffer,
>
> On Fri, 1 Sep 2023, Kristoffer Haugsbakk wrote:
>
> > [snip]
>
> Very well explained.
>
> The root cause for this is 8cf51561d1e (range-diff: fix a crash in parsing
> git-log output, 2020-04-15) which added the `--notes` argument in
> `read_patches()`' call. The commit message explains why this is needed:
> the (necessary) `--pretty=medium` would turn off the notes, therefore
> `--notes` had to be added to reinstate the original behavior (except, as
> you pointed out, in the case `--notes=<ref>` was specified).

That's interesting. I didn't find that commit in my history spelunking.

>> Remedy this by co-opting the `--standard-notes` option which has been
>> deprecated since ab18b2c0df[2] and which is currently only documented in
>> `pretty-options`.
>
> This sounds a bit less desirable, though, than passing the `--notes`
> argument only as needed. This patch (on top of `notes-range-diff` in your
> fork) lets the new test still pass while leaving `--standard-notes`
> deprecated:
>
> [snip]

I like it. I didn't like my solution but it was the only thing that I
could get to work. I would like to use your solution instead. Thank you.

Maybe you could supply a commit message for v3? v3 would then consist of
two commits:

1. Your fix
2. Those two tests

Or should it be handled in some other way?

Cheers

-- 
Kristoffer Haugsbakk
