Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C682C433B4
	for <git@archiver.kernel.org>; Sat,  8 May 2021 02:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7C006140E
	for <git@archiver.kernel.org>; Sat,  8 May 2021 02:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbhEHCLP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 May 2021 22:11:15 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:43195 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229775AbhEHCLN (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 7 May 2021 22:11:13 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id EA1005C0150;
        Fri,  7 May 2021 22:10:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 07 May 2021 22:10:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        linuxprogrammer.org; h=date:from:to:cc:subject:message-id
        :references:mime-version:content-type:in-reply-to; s=fm3; bh=/wg
        KKxbNO/ebo4/iisikFmsTcHbg5kfP8OmfaXnoOzY=; b=phhs99sas/OzgQ39WU3
        N2qNbWKD02LnbSgY+rLNHMDeNOojV5XHr/gcum9qFDxnj566g0RpLtEP8UVtXtwP
        YP5UTAeENFUHEt278M+TYhVIRX3J5Q7WIk44OUmGJDvZVqY8pFCBBtY8YRiGMlxk
        ftBVieWaLvydVc/fMQfc9l9B5Xs0G4AsWZWQNY55iU8FuXH64o156USqWIEhIJkX
        dNaiyN4vrPpBL8pgKJguT6IouN4ZMWPkOeTnq6tIRr4zwN4eEpE5YIfPP5li5DCi
        QDwp6UKs8juEJONod8uGwj8Qfxy/vZet1TsjcLh7mA8av85rLt/esEjzngshtOY+
        +QA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=/wgKKx
        bNO/ebo4/iisikFmsTcHbg5kfP8OmfaXnoOzY=; b=wgH0VTJBAIR9gN2NlYx9md
        jqwOh737LH3fyOPtdixfCzBPflTNc3QbOnWyEIi2Pp5hzZq7sn4sEpXq2yAyvG8L
        2Q3TieQoLRpxb/MB34d/8+jmrlgiCR7rienOaxzp/XflWau20ab1KibNIpoTeXcp
        mYH0AHLkOX99+QPERS2eTZmK0hRjcuxV7RUSmABl/+sXUAEdE5mHttcGuDBDvviH
        fm+uBLZ06wNSnENkYeQAJJw+xwzhN6I8p0ZjQvs1xOee7nDo6bcoySZBr9Tdyj5C
        btOoW+VAV3BUzot6CUR9hYbbJ1HM3zhxrs2KZiEDuGBOfW9lkUj8X+KoxONeVEWw
        ==
X-ME-Sender: <xms:BPOVYMtNvurALxN0F8JryEsfHUBmf8i_W_DxWUqQtGluKq1YXdgrVA>
    <xme:BPOVYJedBfb7ysRh98DILXLuk-A9s-xg4FKSG7qsKewQE-Y7fO246pbacGQ830nd6
    yQqKBxIH3pYfngx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdegfedgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttderjeenucfhrhhomhepugifhhes
    lhhinhhugihprhhoghhrrghmmhgvrhdrohhrghenucggtffrrghtthgvrhhnpefgtdekvd
    ektdefveehieefgefgffehjeekffdvlefhffeffeelhedvheehieelleenucfkphepieek
    rddvvdegrdeikedrheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegufihhsehlihhnuhigphhrohhgrhgrmhhmvghrrdhorhhg
X-ME-Proxy: <xmx:BPOVYHwbjvwc4Uarc88IqdAqc1XuozPxjVL-9CQv15OItUcLsvKu0Q>
    <xmx:BPOVYPOHZlgyiujxlvBpz9zf5WF8clWKvfiJQtWV3n9MY7fojBUQzw>
    <xmx:BPOVYM_4EwxuuKHrN7tyxE5Y3xAPzAB7FVIoor8NIFhMGr8x13KxMQ>
    <xmx:BPOVYKl-HcJTgqihBD7XMjun-3vanKYgD1ZtZQQ4ARDteA6f7292fQ>
Received: from localhost (ip68-224-68-5.lv.lv.cox.net [68.224.68.5])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Fri,  7 May 2021 22:10:11 -0400 (EDT)
Date:   Fri, 7 May 2021 19:10:11 -0700
From:   dwh@linuxprogrammer.org
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Sebastian Schuberth <sschuberth@gmail.com>,
        Eric Wong <e@80x24.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        patchwork@lists.ozlabs.org
Subject: Re: Pain points in Git's patch flow
Message-ID: <20210508021011.GG3986@localhost>
Mail-Followup-To: Git Mailing List <git@vger.kernel.org>,
        Sebastian Schuberth <sschuberth@gmail.com>, Eric Wong <e@80x24.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        patchwork@lists.ozlabs.org
References: <YHaIBvl6Mf7ztJB3@google.com>
 <22a0a383-0ae1-c7d1-75f7-7dfdfe5fb504@gmail.com>
 <87fszn48lh.fsf@evledraar.gmail.com>
 <CAHGBnuOVmzzhgW6GanHBXNb22UW3P1m3i6PJnOUEhYPO76hH4g@mail.gmail.com>
 <20210419193600.GA19186@dcvr>
 <CAHGBnuOv5PvCcKqed-sTOs2uxyuhRS7RDF4XvzPu9oHpyroasQ@mail.gmail.com>
 <20210419220013.mguw4l5644r2c7gj@nitro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20210419220013.mguw4l5644r2c7gj@nitro.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19.04.2021 18:00, Konstantin Ryabitsev wrote:
>I view email as merely one way of exchanging RFC2822-formatted messages.
>There are others and RFC2822 is robust enough to serve as a good standard
>base that allows both free-form and structured content, including mixed.

+1 on RFC2822 as universal message format. It is simple, easy to
understand, trivial to manipulate in any programming language and widely
supported. Standard file formats, along with standard protocols, both
without "proprietary extensinos" is the key to maintaining
decentralization and avoiding siloing of data and users.

Cheers!
Dave
