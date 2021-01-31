Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C17C433DB
	for <git@archiver.kernel.org>; Sun, 31 Jan 2021 04:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1703D64E15
	for <git@archiver.kernel.org>; Sun, 31 Jan 2021 04:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbhAaEgS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jan 2021 23:36:18 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:48657 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230184AbhAaEb6 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 30 Jan 2021 23:31:58 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 3237AB6E;
        Sat, 30 Jan 2021 23:23:43 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sat, 30 Jan 2021 23:23:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=L5MbpVmMqGVqrlOnd74KqD2hWMM7TlzkY1ommGqLf
        bQ=; b=e5jbB+ljY8l4uI4huJ5U/mMFikI1TFYM8QAk+YLoDTdJxQ+dFOQycPvPp
        lDwb4fmw8kZXxDD0ceOa9Ozd8Y2Kpp1OF4t5ohWVyI4fNtmnxo9AnXIxxIHPym05
        RfFt/jLN75/uoRzpm4p+vlsqHndH4mU5xxdItG9Nfq/PLPPyWcM+12RbCh2CL+nR
        Fg0TM2GTwFP+/B2wohrvfp8AZ3DkU2MRhD92lbgnIJ2634YdJGFCZKLE6UIao9y5
        qJ4dopTBnGX+lOfGjhmJhnrBjYQWAsu5EbBAsasjHj5tYeJwOcw8KqyLR02ag0e7
        V25lmFeHFZIg5wscPnoZhZpLX2Zgw==
X-ME-Sender: <xms:zjAWYKGJsULjPt7VXpb2d4A2rhs6jTCseIzOezsCYIfmNy4HmrfAFw>
    <xme:zjAWYLVboK1WzLifDnhzCDK9djkNNv0LR3zRCFQRJ8S1AxccWcWyO10wgS7jNHGAJ
    o98fkKkjUNM9rki4L0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeehgdeikecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurheptggguffhjgffgffkfhfvofesthhqmh
    dthhdtvdenucfhrhhomhepveholhhtohhnucfjuhhrshhtuceotgholhhtohhnsegtohhl
    thhonhhhuhhrshhtrdgtohhmqeenucggtffrrghtthgvrhhnpeelvedtgeehhfdvudfhie
    egjeffteeludevjefhkedvheekffeghfdtgedttdeujeenucfkphepjedurdduvddtrddu
    heehrdegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eptgholhhtohhnsegtohhlthhonhhhuhhrshhtrdgtohhm
X-ME-Proxy: <xmx:zjAWYEIC6Hf2hPK4fndYKTIqAc8cP6Z-n9QaHqNQRW_9Q7h7h_DLtw>
    <xmx:zjAWYEGuixWFnnc3-5SXEpB3JmGmnV0nr8mVkWkQvTxuRIkgJvCtyw>
    <xmx:zjAWYAVcN-kHFW3tDSp9pTZiR21EIyncT0vSwS-ADU2pSh8jkedLLA>
    <xmx:zjAWYIgn80ye0eL_a7fCp7scm2aQLBcE-myk0sDd3xj3mZ_3zMtMEQ>
Received: from [192.168.0.171] (pool-71-120-155-4.nrflva.fios.verizon.net [71.120.155.4])
        by mail.messagingengine.com (Postfix) with ESMTPA id A126B1080057;
        Sat, 30 Jan 2021 23:23:42 -0500 (EST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.32\))
Subject: Re: Git Conditional Includes Question (possible bug?)
From:   Colton Hurst <colton@coltonhurst.com>
In-Reply-To: <xmqqlfcbs69z.fsf@gitster.c.googlers.com>
Date:   Sat, 30 Jan 2021 23:23:39 -0500
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B569AC8C-8AF3-46E6-B8FB-A6EBEF42FA00@coltonhurst.com>
References: <1E4AB5E8-DD46-45CA-9A3F-C49F115BE0D4@coltonhurst.com>
 <xmqqlfcbs69z.fsf@gitster.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3654.40.0.2.32)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio,

> as "git config --help" says:
>=20
> * If the pattern ends with `/`, `**` will be automatically added. For
>   example, the pattern `foo/` becomes `foo/**`. In other words, it
>   matches "foo" and everything inside, recursively.
>=20
> and "~/colton/github/**" as a pattern would match the path to the
> repository in question.

That solved the issue. My email was in the subdirectory config files, =
but not having the `/` at the end of the path ruined it. Thank you so =
much for the help!

Have a great day and weekend!


Colton=
