Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADCAC07E96
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 00:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2297D61CAD
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 00:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbhGGAfd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 20:35:33 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:56999 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229834AbhGGAfd (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 6 Jul 2021 20:35:33 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id DC86F5C00BD;
        Tue,  6 Jul 2021 20:32:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 06 Jul 2021 20:32:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=furrypaws.ca; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type; s=fm3; bh=QZ8YKJP1O04EK5iAaEJh2zqnBZ
        054MY3sMwGUKNWPgc=; b=AF1x004Y5+outF30REHsjSmhhSugwf7QtKORk+3+Aw
        uOzKAZBNycgGgInP9gBipMwwtHxDjMlRaljhDytjkwPRCeHFaN4adP6120gwfAji
        jLOG4xrtzBh3YGbanBxcng6Ec/R3tC8otj3fCno4hLc9owcsOK5faZr89VF8578T
        itrWOalyjpVIkmYvgIbnSPZPhItYT5O/4VqOX5Gkq1RTn5vnWgtFICpJrN5iVKAd
        XBiBKWERLkrtFrskcZi4cNB2Cb74PV0iZOtP5UuAG8EAW7jvWv5WeuA+vha4yVdH
        u9QS02N4tzbM9BXKvRR1LbgcuVNiguYwwIinHMvvEy5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=QZ8YKJ
        P1O04EK5iAaEJh2zqnBZ054MY3sMwGUKNWPgc=; b=PuSThgqEEmK3/1HJqem9AS
        uda8JiY68HOEfiMdoHBIUK3P8n5riwnuJDa4PO3iCZQSa0AlN+1JWDXd1L9xqq2X
        DXg7CeWHrB0QBi/pHfQuPEuFvOTzfDp2M3NECs2CeLpKG27NF9XE5NDgWlgWlRW5
        uwz+D8D0195NGzOx9qw6ttu3ePZb3L/jy7tAoNJpwJxbiJZshM1ixY9r4+lRgJhJ
        29S/OGuUCcNUDQeVdupyJkFhqPfcMlhv98YHqyz+iKhXbsusPiL07O9w+2cPix7Y
        vVp8dHC9Aj84/5QRNSqR+03fRdAkvwdYU8eoisZBVMxorh8TKLAeGuRHr0mdDtlA
        ==
X-ME-Sender: <xms:NfbkYImADVX2MIrqFOxyqGXfFJBOedqz4s3X4WP7tP72g4uzpjgB0A>
    <xme:NfbkYH3sfOw8422kEBNLYrfmchcMNdF-jXoeX9nsIwFi_9Zmc0GI8ARk2wxbtcWlh
    HSCeBhQK5xtXbpRbA>
X-ME-Received: <xmr:NfbkYGpXRU6SHkaHHSI4Mje32jCPR0WZY1LuuklQogQ-3KggLld-hQBgXJTXuI_A5zKgE3HMe-E4fLAnx3gSflh5-WxZIxf3GqnqwN-F>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrtddugddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffoffkjghfgggtsehttdhmtd
    ertddtnecuhfhrohhmpedftehnughrvgifuceuvghrrhihfdcuoegrnhgurhgvfiesfhhu
    rhhrhihprgifshdrtggrqeenucggtffrrghtthgvrhhnpeffueeiuedtvdehheevfffhtd
    evhffgheeggeefvdevhefhiedugeejgfffteefveenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesfhhurhhrhihprgifshdrtg
    gr
X-ME-Proxy: <xmx:NfbkYEngqmb2s_BPH7e6D2FiHNCzyu2kBg_x-7vov7KUGY9AsHzelg>
    <xmx:NfbkYG3Z0onzB90E2Lep85GRNxHvvN5EE1pQZfN4m5ARsse0XbkBYw>
    <xmx:NfbkYLsdgZXSU9ZttUtA-JIzaZtF1BLQCwZYH-0AYufDEngwzxsSNg>
    <xmx:NfbkYC-vf3413OfimtmaeA9T-Yi0GP7380abX79cFY-dcIUk7ueJXw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jul 2021 20:32:53 -0400 (EDT)
From:   "Andrew Berry" <andrew@furrypaws.ca>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     git@vger.kernel.org, bagasdotme@gmail.com
Subject: Re: [PATCH] docs: .gitignore parsing is to the top of the repo
Date:   Tue, 06 Jul 2021 20:32:52 -0400
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <CA0F1460-CB39-45DC-8DED-13F7ABA674D1@furrypaws.ca>
In-Reply-To: <xmqqr1gbf02i.fsf@gitster.g>
References: <20210706205439.75015-1-andrew@furrypaws.ca>
 <20210706205712.75270-1-andrew@furrypaws.ca> <xmqqk0m3gl6a.fsf@gitster.g>
 <xmqqr1gbf02i.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6 Jul 2021, at 20:18, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>>
>> Line rewrapping makes it hard to see what actually got changed,

To check, that's asked for, correct? Or is it better to do one commit 
with the word changes, another to clean up the wrapping?

>> but
>> does this only move "(up to the top-level of the work tree)" around
>> without anything else, as discussed?
>>
>> If you do "toplevel" -> "top-level" while at it, perhaps we would
>> want to correct "work tree" -> "working tree".
>>
>> Looking better.

Yes, I realized I sent the wrong file when reviewing the sent email, 
hence the followup. Aside, it's not clear to me how to send patch emails 
that _also_ have not-to-be-committed notes like "oops, ignore the last". 
First time contributor problems!

> Another tangent.  The discovery process used for the .gitattributes
> files is identical to what is done to the .gitignore files; we may
> want to make sure that the explanation we give in our documentation
> won't cause the same confusion you are trying to avoid with this
> change.  Such a fix does not have to be (and probably should not be)
> a part of this change, though.

I'm out of the office for the next week, but otherwise I'm glad to take 
that on when I'm back if no one else picks it up.
