Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDA6C43334
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 20:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiGYUnw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 16:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiGYUnv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 16:43:51 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF4322B01
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 13:43:48 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id B21215C017E;
        Mon, 25 Jul 2022 16:43:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 25 Jul 2022 16:43:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1658781825; x=1658868225; bh=uJLByq0hVv
        xREbr0TTrMluhGlyqE7YScC7BCRq17KSg=; b=oqeQmvwg0QrxsHGl4NRO5KfjfS
        48KG/IoTInsSDNuXuA7Vu5R/s0koUaSEMplvQ2rI11LevMJrE6GiXjxSBOnMV/xD
        DrniCjdXu2RWslPfAJwtSd2uWFknRp53tv4teoXFghAVrEwJ3Zsv51ItbFuxhO0g
        m1zu5bVpcNXQ9JPE4rabmtI6QRfd8cRNA2H4gHvc4kkmhD4ynwyzwWBUz93QNWKZ
        75avLRN0w1K4udCtxTmfd5lGzOsUlbvM+uPo9ggLAiD1ZJDLYma4nyPuri4XwcC1
        WcbSzKDe0FV52IndEwx3tKZCne1E/5lo+VdpgsptoRUunp0wofpAict8MS8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1658781825; x=1658868225; bh=uJLByq0hVvxREbr0TTrMluhGlyqE
        7YScC7BCRq17KSg=; b=BJVd7h6P7QqIIcRGigW+CxcIp6Pxv7EOVmAtUc8YJzwf
        qkIfbh68A1SN9Tze+tch7jkPMdGlG6Gji0k1v8+IiBe0RM1Du+Slcohnl8xUqP4w
        wEyGqHoxOnCoxLU4g2LlT0ZYuseNW4w+wrWfdyA7tbeMB+dMn+FGWs+jery8EBJQ
        tc95Es9szbYYPGIuUkxLQgcY5wmJzbYMISxsdPo9PgQMaoxnN08N0+MVv6BNG7/C
        bzudyA4DDkvZDnPeLsOskXXGwzS1C3dIRBZnFe/9MptNM98asf7Ba+1is6TgnF7A
        7hUp/zizoBeDFOWT9mtWcWg3zMkPN4vXcPKXpRBzfQ==
X-ME-Sender: <xms:gQDfYgw6HI8wBrsaa-cPeLQGqGIYR3gYfgFazt-ajwfbsYIzmraFRQ>
    <xme:gQDfYkSbMX7UTg1-1VPQrSau1Xyb7asYPfrMgLI-6a9-Ua3BiKLvtL1qI8PRisRwf
    U9885Bp3SqxFj4Yzw>
X-ME-Received: <xmr:gQDfYiWMrl43OLhGDujHp6Rj3hbLp6GXELGW5FPWAAMyCEf60fm_J9TmOJEfEoZLEqw24aevXd0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddtkedgudehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdduhedmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredt
    tddtjeenucfhrhhomhephfgvrhhnrghnughoucftrghmohhsuceoghhrvggvnhhfohhose
    huledvrdgvuheqnecuggftrfgrthhtvghrnhepudfgudevtdeuhffhudfhkeekieehgeel
    ffehkefggeelleevhfeliefgveetffdunecuffhomhgrihhnpehpohhsthhimhhgrdgttg
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgv
    vghnfhhoohesuhelvddrvghu
X-ME-Proxy: <xmx:gQDfYuhVOq_Os60_rm_NCnvDs4GUJ9y3XeycW8awU5zXG7UZOGJzfg>
    <xmx:gQDfYiDIKKMjumTYQ8P06XxtKfyfiOC1U_-5hqnlLR5KDsNa6Z4sLQ>
    <xmx:gQDfYvKRkNpN_SU-VLK4kXUG7g_jdEe74QmCpYK0joalx_FAshiyDg>
    <xmx:gQDfYj42v292n4Fu8WU0gcuw4mV-7t8ngYCYjLU_bLAWgs2H6iW19Q>
Feedback-ID: i96f14706:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Jul 2022 16:43:44 -0400 (EDT)
Date:   Mon, 25 Jul 2022 22:43:42 +0200
From:   Fernando Ramos <greenfoo@u92.eu>
To:     Claudio Ebel <claudio.ebel@web.de>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Changed diff3 view from =?utf-8?B?Mi4z?= =?utf-8?B?NiDihpI=?=
 2.67 for vimdiff
Message-ID: <Yt8AfljwGc6a95Sv@zacax395.localdomain>
References: <99c80fc2-0f94-a607-ca71-c45961c07e2b@web.de>
 <CAN0heSrCocuKA+8UvU8dH_bsM4Xg8L3M8O4W0buXkUc3uCxpGA@mail.gmail.com>
 <YtsMhb0XUPw2EekJ@zacax395.localdomain>
 <7dc225d7-eb36-9fb8-5977-6913ac4dd007@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7dc225d7-eb36-9fb8-5977-6913ac4dd007@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> 
> After successfully compiling Git, I'm almost ashamed to ask, but I was NOT
> able to run the vim command you suggested, Fernando:
> 
> vim -c "echo | split | vertical split | 1b | wincmd l | vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabdo windo diffthis" -c "tabfirst" local.txt base.txt remote.txt merged.txt
> 

Hi Claudio,

Notice that this command was meant to be executed *directly* from the terminal
(and not from .gitconfig).

It just opens 4 files that, as you noted, do not exist... but that's ok with
vim: it will open 4 buffers named after the provided filenames and only save
them to disk when running ":w".

The result should be something like what is shown in [1], ie. 4 empty buffers
named "local", "base", "remote" and "merged" shown with the expected layout.

Hope this helps!

Fernando.


[1] https://postimg.cc/dL8G2mng
