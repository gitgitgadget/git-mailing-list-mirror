Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC42C433ED
	for <git@archiver.kernel.org>; Sat,  8 May 2021 02:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4024A60E0C
	for <git@archiver.kernel.org>; Sat,  8 May 2021 02:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhEHCKA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 May 2021 22:10:00 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:39097 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229775AbhEHCJ6 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 7 May 2021 22:09:58 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 3164D5C0143;
        Fri,  7 May 2021 22:08:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 07 May 2021 22:08:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        linuxprogrammer.org; h=date:from:to:cc:subject:message-id
        :references:mime-version:content-type:in-reply-to; s=fm3; bh=EdJ
        oTe1CFzBkmk0bXOsbjykS0ZHQshEf7xZqDa8z2ss=; b=f1JNmdKfdYGeQZ1pVSB
        Kw2jzc5J1ZSYEb9LycmJ8y8fZFacw8dYqwlN106oNBEW9sOA6JaHEEGskkQIxTgG
        sd8f6xbVEOZ9vkWgnTRTiGs7blxvYH70vN+p+q61QyhyHA9byYqhFsfP/v2cOuWx
        goapdOT7ycshTJ615ppjKycjISMoBxLE6R/hld4oi1eZsZr3V57CUccuvqfuiK1z
        q19BoPHL+3n8BdCarQMmOA6SLmLyhvdYJ8v0ppSveuvm/kWzlF94Fuv9CUT50BZE
        Sq08GStJ6IHaBroC47TwifMS/WqxS2GgvxnSYBLtT0UJIZdEzvZXnd/kgRUiifBh
        yVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=EdJoTe
        1CFzBkmk0bXOsbjykS0ZHQshEf7xZqDa8z2ss=; b=o4Ejhsb+4+atO/CGMROAE7
        AHvIOce3RwzXARwqcjchbaB1H+AKQ+dlQbGKzldrde9T2OCVAv2A4LGqXOXK9Foc
        RsRxRGOI9F1VCYpVDf1KbAJvNB2+C+tcDeDHvskMZayZpRREaF7AxkS79oZA62VQ
        Nd32ZACyzK3RfYtVCv5POItVaSmp66g/9zEhJdN6RSo4Pf+4oWqUwY6W935hS00f
        DO7+1E6es+M4zZNumoZesb4bx22wVDlEqWJo8S9MvTXpgJKu7xYwTB5VY/bSP7lI
        aWrBpqfFgm5USjRsbysTi5u0IHJB5zUOHhIXB2RPWJdq/ySLdnusC1KH2BIuyRuw
        ==
X-ME-Sender: <xms:uPKVYIRy4ASpJJdFMvYAJ6fDS5UaqyhCPs_fJAtZnGLYPBpzBRFcdA>
    <xme:uPKVYFx2GQxo1c8sSPUw2U2PFgxoPJ765j0V5S472cRdQu5YhK5xTCJBHWWjfCo9V
    72vzzw2KiDHCvT6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdegfedgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttderjeenucfhrhhomhepugifhhes
    lhhinhhugihprhhoghhrrghmmhgvrhdrohhrghenucggtffrrghtthgvrhhnpefgffeife
    dttddufedvfeffhfegkedtgeekheetleejkeehuefgtdffkeefieelgfenucffohhmrghi
    nhepshgufhdrohhrghenucfkphepieekrddvvdegrdeikedrheenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegufihhsehlihhnuhigphhrohhg
    rhgrmhhmvghrrdhorhhg
X-ME-Proxy: <xmx:uPKVYF1lXuNrNRbF2dmau6Zdm__DQYzS6PVOjYyvNcup5tRvLRbs1g>
    <xmx:uPKVYMAi4volRPElK987mPtwJqPcbKCsyf6ycQfAyMgzZrFDtWhbug>
    <xmx:uPKVYBgQxcLCX_QGTTM4CJoehBYDDx5N0KAav48HHwOD9LUbBkYRkA>
    <xmx:ufKVYBLx3YFsC8LAcx-7wSb7InLBJram_y6w9py6w8ihz7S9WqtA9w>
Received: from localhost (ip68-224-68-5.lv.lv.cox.net [68.224.68.5])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Fri,  7 May 2021 22:08:56 -0400 (EDT)
Date:   Fri, 7 May 2021 19:08:55 -0700
From:   dwh@linuxprogrammer.org
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Sebastian Schuberth <sschuberth@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        patchwork@lists.ozlabs.org
Subject: Re: Pain points in Git's patch flow
Message-ID: <20210508020855.GF3986@localhost>
Mail-Followup-To: Git Mailing List <git@vger.kernel.org>,
        Sebastian Schuberth <sschuberth@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        patchwork@lists.ozlabs.org
References: <YHaIBvl6Mf7ztJB3@google.com>
 <22a0a383-0ae1-c7d1-75f7-7dfdfe5fb504@gmail.com>
 <87fszn48lh.fsf@evledraar.gmail.com>
 <CAHGBnuOVmzzhgW6GanHBXNb22UW3P1m3i6PJnOUEhYPO76hH4g@mail.gmail.com>
 <20210419214921.afurkxy7oru6bny6@nitro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20210419214921.afurkxy7oru6bny6@nitro.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19.04.2021 17:49, Konstantin Ryabitsev wrote:
>On Mon, Apr 19, 2021 at 07:54:37AM +0200, Sebastian Schuberth wrote:
>> > of these proposed alternatives involve moving away from something that's
>> > a distributed system today (E-Mail infrastructure, local clients), to
>> > what's essentially some website run by a centralized entity, in some
>> > cases proprietary.
>>
>> That's a good point, I admit I haven't thought of that. Probably
>> because I also don't care much. So *does* it really matter? What
>> exactly concerns you about a "centralized entity"? Is it the technical
>> aspect of a single point of failure, or the political / social aspect
>> of being dependent on someone you do not want to get influenced by? I
>> guess it's a bit of both.
>
>Patches sent via email remain immune to this. Even if vger falls over, it's
>merely a list service -- there are alternative ways of transmitting RFC2822
>messages that don't involve a central host (such as via a NNTP gateway,
>publishing a public-inbox "feed", etc). Email remains one of the few protocols
>that are designed ground-up to be decentralized and I'm afraid that we are
>again finding ourselves in a world where this is increasingly relevant.

I agree with Konstantin on this one. To this day, email is still the
most decentralized and "user sovereign" system on the internet. The
standardization of protocols and file formats is not perfect but it is
"complete" in the sense that it meets all of the requirements for
decentralized software development.

Think about it like this. Right now, I could use an IMAP client to
download all of my emails from GMail, store them in mbox files, then
use the IMAP client to upload the email to Fastmail or SDF.org or some
other email provider. Or better yet, I can install local tools for
working with my email. The fact that email providers/tools are largely
interchangeable and replacable--despite Google/Yahoo/Microsoft's best
efforts--gives maximum power to users.

Like I said, I totally agree with Konstantin and I think the vision he
described in his post on developer sigchains is what I've always wanted
as an open source developer. It is common to hear the argument that
centralized systems are more convient and easier to use and the more
decentralized a sysetem, the harder it gets to use. I suspect that is
only a half-truth because I don't think we've achieved full
decentralization which is what Konstantin touches on in his post too.
Full decentralization will bring automatic maintainence of p2p
connections and synchronization. Things will "just work".

I know I'm veering off topic a bit here but decentralization has been
the focus of all of my learning, research and work for more than a
decade now. Email is critical for maintaining decentralized development
capabilities.

Cheers!
Dave
