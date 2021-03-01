Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358F4C433DB
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 17:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E1F865283
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 17:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238098AbhCARaj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 12:30:39 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:44491 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238194AbhCARXt (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 1 Mar 2021 12:23:49 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id E77293FF;
        Mon,  1 Mar 2021 12:13:52 -0500 (EST)
Received: from imap22 ([10.202.2.72])
  by compute3.internal (MEProxy); Mon, 01 Mar 2021 12:13:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=barag.org; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type:content-transfer-encoding; s=fm2; bh=nQvll
        lXZ04t4dwl7UIwBXBj984TfQ9d/bYikNu/t5u4=; b=Sx9rDUMaq6K+No4wLPRbU
        C61JKJ7QtU7y1cj9S06cDLxDVElhoGjdtncaCtsJfQWWhgMD+HX2bsYlDm1vP4qj
        /WnapY5azIkPn2qdhys0K/0EU8TenUvzpJIMYyAkPrTRq3GEGIkLI8X9szmRm52x
        lmmSojiCyFusq/oJyFu+603oKMiRyD7VUtM46DZqffunlkYUuWmPVG2NZyTVDBxq
        o5Eimu6YWAMQKZwqbzSaBvB0Z8tQoBbI2ELIcwWSzHlKjcPUpoYAdCM981ViYEXk
        Z8DFT+kjGkX/N8FtAPTFOFyu/m8wtk5BsWTat0C1YqH0uNedkZTqhZjl++EL9MBc
        g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=nQvlllXZ04t4dwl7UIwBXBj984TfQ9d/bYikNu/t5
        u4=; b=oQ54NO6RmvpB24RNm/6przK5tisTr8k7FRcbmsx4dPyLcx4cFrxCxlvGu
        pBivDtX0lcpcKpEQWLVYOrd4UY/WWH5cozsol7hyWpfjfCGAscVmPKlLgAoF/xeG
        t+4TZWlUxxQiWRtRbxTQxknlgfBFpsAjVbi3vZ/rV+sgGnlzzF+hr/zOyAtE3tpz
        5MGaO8BPeo4M+WoAX0sCdTPgWEXqP2BuapKhCoi+yUQOrZ+gv1DtJbkKkClcCAAk
        /tEAP8lz+bqV7I6vk33ferh89za37djYn+p9LLZRq4dbxDgA3Eue2jywGJ6wPMZH
        Z4R3M/zOE0dVlzvNNzwsTEGsmqPDA==
X-ME-Sender: <xms:0CA9YBF96UsL0YHTzMSknANVFAiZYXKbtCxN36FE23qKwxPY2S83dQ>
    <xme:0CA9YGWiaWoFy5gkc60aUy4RA1a65uvpsm32p5kgG2lE4ytNZgY_S91bYYCudF9fx
    dvaegfXv7BEa5mFAC8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrleekgdeljecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkjghffffhvffutgfgsehtqh
    ertderreejnecuhfhrohhmpedfufgvrghnuceurghrrghgfdcuoehsvggrnhessggrrhgr
    ghdrohhrgheqnecuggftrfgrthhtvghrnhepveffteekjeffhffhhfevteefkeeuheetke
    eujefhjefggeffvdelvedtudffhefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepshgvrghnsegsrghrrghgrdhorhhg
X-ME-Proxy: <xmx:0CA9YDI7XXmjVBgU8lCpfEqs4gqUNXZ4nBS7Vivv7LgGFnkQpyeSPQ>
    <xmx:0CA9YHGM3KJA4mwRfEHfAWobQFkZUREXCDECfGYJUYDf9FrM9YTBbA>
    <xmx:0CA9YHUWhTCp22cfylwqCAGgeB3I3BbWVBTCUQItBXKPR1ArSd2iFw>
    <xmx:0CA9YODc1_YTfKMaV9ON7XEK3z0iCxZnL1s9ftJHqOS_LvjzTNLkSg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id F346D62C005F; Mon,  1 Mar 2021 12:13:51 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-206-g078a48fda5-fm-20210226.001-g078a48fd
Mime-Version: 1.0
Message-Id: <89889645-d7c4-437e-a072-0ff543fe437c@www.fastmail.com>
In-Reply-To: <87lfb6kewc.fsf@evledraar.gmail.com>
References: <2d58fe40-9e8c-4653-8170-5411fd3cf6f4@www.fastmail.com>
 <87lfb6kewc.fsf@evledraar.gmail.com>
Date:   Mon, 01 Mar 2021 09:13:31 -0800
From:   "Sean Barag" <sean@barag.org>
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [BUG?] git submodule update --remote assumes 'origin' remote
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 1, 2021, at 8:38 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =
wrote:
> Just a quick note, I gather you're talking about de9ed3ef37 (clone:
> allow configurable default for `-o`/`--origin`, 2020-10-01) which was
> first released in v2.30.0.

Yes, that's exactly the commit.  I knew I forgot to include something.

> Just noting that in the context of this bug already being in a
> release, since we're now in the 2.310-rc0 period. Meaning likely not
> a release blocker in the next few weeks.

That makes sense - thanks for clarifying!
