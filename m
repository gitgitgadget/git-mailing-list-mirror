Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D94C07E99
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 23:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20D5761977
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 23:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbhGEXxE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 19:53:04 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:52337 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229698AbhGEXxD (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 5 Jul 2021 19:53:03 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 3B96E5C00A7;
        Mon,  5 Jul 2021 19:50:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 05 Jul 2021 19:50:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=furrypaws.ca; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type; s=fm3; bh=murqnZuAF9PdNSD9KC8LBYuLTo
        dvo2gpTl7JwMVHej8=; b=Eg4tjqg25qhR6vBiDCw8KTvQYrGFQR7I1SSwS46Pne
        RAim9B88BIY5L7DoGKqnIVwmpjVdNM/yWlMZWZ3UYzJfXEtDPakyOghhqd0kC/rJ
        sH/nEzalkdPshBWKIkmeatt18WCdFPcxK6rFQwcq/wmBaZIkb7xouP1rQOQ+Lqa/
        n5grOrjKgblH8mFtWVEukzsgFGNwc3c8mCyFFsGqGRtBmc9OrZkOtuAisCjTUvti
        ZULHlCIajIEAdMNXb8lhusQF34DpZyntLuM6kWuVtwCYHPOu4qmblRGqcUMTs1SS
        8/IF4b0nFMxmhI4HmjseA8SKA4ik2H2sWSe85eG7yfBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=murqnZ
        uAF9PdNSD9KC8LBYuLTodvo2gpTl7JwMVHej8=; b=N03hV1TuajSqIKRFucaDMm
        6Y6e2NB38813Bsiu68k4saCEQ3mMJ9G3sLpkwtjamm8iE3kwAA8zWOFKGlmXzHik
        MP/MYmNHebqvWaQyikwB9lgeNvvdS8Xx+5SQjb1/+255dd7oystrEM5oYNkob43+
        o9e8wdlNQ9Sw58EAXUi+9WJrJlaptEyQR9P2NsIzgWNviap8W//OzUtW67YSpJ8u
        NC6qejnDnB2MhMQ68BR4p1rocQ80B5+yorbZ2X41+3SRiKOhi0zPdzn8YQL1Dbhz
        ytYdfYTAchyXeayPXvj+I13kmzhg1hKGuc3khPnk8yIB0NqUmxbNv4so3XPrEsYA
        ==
X-ME-Sender: <xms:vJrjYILvXxSnLsyqvdjozgBN7hpQg6m3gmDC_IxonGTBbdOjsR1qgg>
    <xme:vJrjYILi1a2FrGXaAa9TjIpGMMP91mVKuUrRPTuLeHrMsuxapK3BzeNwWdILkCIaX
    i1quaZADq_6OfLTGw>
X-ME-Received: <xmr:vJrjYIuVyrCYk0f1vkiwljebgqVSSNJsKFZLU3eD_4e5xTkRCAslOaapMzRrzPP1cTqMgMn2bm8_P4itn2mXZKktnq3sCNJc85qy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeejhedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffokfgjfhggtgesthdtmh
    dtredttdenucfhrhhomhepfdetnhgurhgvficuuegvrhhrhidfuceorghnughrvgifsehf
    uhhrrhihphgrfihsrdgtrgeqnecuggftrfgrthhtvghrnhepffeuieeutddvheehveffhf
    dtvefhgfehgeegfedvveehhfeiudegjefgffetfeevnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvgifsehfuhhrrhihphgrfihsrd
    gtrg
X-ME-Proxy: <xmx:vJrjYFb6o_NBfYJqOBgAoQJvJTxnAL4ayJfrbB3Yl49Yh40wdIv6wQ>
    <xmx:vJrjYPaeRqf2X5Dh_Wr-wmwh9gD77qmZ1axVHUq8VaV5t9LJ59V2BA>
    <xmx:vJrjYBBPkQu6wXGgedf3x3z4KS361IlrcvMkqHAzsRzJy0XbftYIxA>
    <xmx:vZrjYKw7MGqxq9xy3ZQPfDZ7do8a13by_F2wcAEytdRsMd48KZVKHQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Jul 2021 19:50:20 -0400 (EDT)
From:   "Andrew Berry" <andrew@furrypaws.ca>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     git@vger.kernel.org, "Bagas Sanjaya" <bagasdotme@gmail.com>
Subject: Re: [PATCH] docs: .gitignore in parents is current repo only
Date:   Mon, 05 Jul 2021 19:50:19 -0400
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <54FBABC9-2BDF-4879-AB5A-BAE4E8179D80@furrypaws.ca>
In-Reply-To: <xmqq4kd8mt05.fsf@gitster.g>
References: <20210702222044.72767-1-andrew@furrypaws.ca>
 <b9da43a8-897b-7cce-ecbc-ea56078f0f09@gmail.com>
 <889D9AD1-1114-49B4-ADB0-BF78160743E4@furrypaws.ca>
 <xmqq4kd8mt05.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5 Jul 2021, at 15:59, Junio C Hamano wrote:

> "Andrew Berry" <andrew@furrypaws.ca> writes:
>
> Meaning something like the following?
>
> I do agree that it makes it a lot clearer.
>
>  Documentation/gitignore.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git c/Documentation/gitignore.txt w/Documentation/gitignore.txt
> index 53e7d5c914..58c2e41bbe 100644
> --- c/Documentation/gitignore.txt
> +++ w/Documentation/gitignore.txt
> @@ -27,8 +27,8 @@ precedence, the last matching pattern decides the 
> outcome):
>     them.
>
>   * Patterns read from a `.gitignore` file in the same directory
> -   as the path, or in any parent directory, with patterns in the
> -   higher level files (up to the toplevel of the work tree) being 
> overridden
> +   as the path, or in any parent directory (up to the toplevel of
> +   the work tree), with patterns in the higher level files being 
> overridden
>     by those in lower level files down to the directory containing the 
> file.
>     These patterns match relative to the location of the
>     `.gitignore` file.  A project normally includes such

Yes, that's good. My only suggestion would mirror the earlier one, to 
split toplevel to "top-level" or "top level".
