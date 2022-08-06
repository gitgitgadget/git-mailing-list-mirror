Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4111C19F2D
	for <git@archiver.kernel.org>; Sat,  6 Aug 2022 18:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbiHFS3t (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Aug 2022 14:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiHFS3r (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Aug 2022 14:29:47 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87AD7959D
        for <git@vger.kernel.org>; Sat,  6 Aug 2022 11:29:46 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 55853320079B;
        Sat,  6 Aug 2022 14:29:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 06 Aug 2022 14:29:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1659810582; x=1659896982; bh=sSVVohjCZ5
        rqZnUdJlZ+WWMPgZU+4LeHhU/frKHvgvw=; b=id3vDCZSCB+SLcbx0GZhR158Go
        7z+E/GEi1uk3ZPngXLadn1Zju4m7QS0UoRpxocPG2gKwjbGKgiBcAbXLG5E1Rm9f
        4/yq9Ua0uu1OcbBYJ3W8ZecY1wg4GnU+EFYCd0AbfrYwIIY9bTpuODYRJLVIC7CM
        0kyAhCTzzOljyMxy+UJGgTjRX+jh7mMf8A7io5GebBZH8CTJjVyxBsv5eAXmaNcA
        B/CM4inZqf3UdZmvpV6nsD6sVSDeFfs21IH+LTBl29OyT7WVQAMQJ2knDokUqj+s
        tbqz/Lj4Lgapn0fImOvgFJfWb4IOZqm+9bvo9CEwHWJYqHu8SYoRVHcEa8vA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1659810582; x=1659896982; bh=sSVVohjCZ5rqZnUdJlZ+WWMPgZU+
        4LeHhU/frKHvgvw=; b=qOGTaqkAkJi18f33WAzHv8WbYnLjGGPiC66hIFCdHA/d
        qp0P2V8hnnO4gK0tOVWSJ/kiBHtsGvyhb6DLblGP/UG47eBf3W8IgWpGAVvRcx5+
        QcxEGIS3VSzA9wDJ5+o5gMEyZx0j/w/D9i6RC6Dd9NHSP0ZJ2ZsWlc3n/aHMaiW6
        XnK/0IJuFT9RvKEw+g+OM4WPVey3znBR3sjV13npiKlXVFTYvHT1I8jgOYom22LU
        5fMQRgdQlrKRIT7ftd0fdFle7BUJrvTfzv4FbL3vyGqHLzMP7r37TsvbQxCJQ/Lv
        j2QzmxTKuV4AdyVzU1YBjFwP2GaOVgZbmQ4ylLFzTw==
X-ME-Sender: <xms:FrPuYt8lbVgb0qOIbOEQPa2HFag_c1W9XjNSTjOM0tYQOKjiNSCbfw>
    <xme:FrPuYhuWCUp5Kb4LBiZh4tttZdTbJDEms2YXsTiwbhKuB2YpDcazPVhgw4NIHi5yW
    Rda0ACJGLOB17UKEg>
X-ME-Received: <xmr:FrPuYrCDNeXbuJ_gRnFx3TKr2DP2dXdlVTB9a3klmK4o3l9ZeLDlACpo8iPcz35etaSnmDts8vY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeffedguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpefhvghr
    nhgrnhguohcutfgrmhhoshcuoehgrhgvvghnfhhoohesuhelvddrvghuqeenucggtffrrg
    htthgvrhhnpeffheevteefjeevieekheeujeeivefguedvieefleeuiefgtddtleelheev
    ledvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgrhgvvghnfhhoohesuhelvddrvghu
X-ME-Proxy: <xmx:FrPuYheePPdsTYSWg0y1qitsiq7BW1a0Sg1kfOLdPFyNuR5S6QNZ5A>
    <xmx:FrPuYiO-T6YyOCqrPaFK4N3zUTjg0_eZkh54HYt5zDxncuA6FKrlzA>
    <xmx:FrPuYjkD8pfTVV3TrHuwYD0qpJgBGL3c9qqNDho1dXpZigPEKyDdag>
    <xmx:FrPuYsVmbUlEjSgK6en4cKlLCsuCxwUyMLpRIiJFYPp5U7-KizaLIg>
Feedback-ID: i96f14706:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Aug 2022 14:29:41 -0400 (EDT)
Date:   Sat, 6 Aug 2022 20:29:38 +0200
From:   Fernando Ramos <greenfoo@u92.eu>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/2] mergetools: vimdiff3: fix regression
Message-ID: <Yu6zEiknXKFMJUVn@zacax395.localdomain>
References: <20220802214134.681300-1-felipe.contreras@gmail.com>
 <Yu6V4cIajhoMhB3t@zacax395.localdomain>
 <CAMP44s1uPFGYVJ7dzf1pFXENnUjTTwxHye2iT_HPNiMcmPjD9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMP44s1uPFGYVJ7dzf1pFXENnUjTTwxHye2iT_HPNiMcmPjD9A@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/08/06 12:53PM, Felipe Contreras wrote:
> Two observations though.
> 
> 1. The "silent 4b" is ignored, since bufdo makes the last buffer the
> current buffer, so if you want a different buffer you have to make the
> switch *after* bufdo.
> 

Yes, you are right. For the particular case where there are no windows (only
hidden buffers) it does not have any effect. It's presence there comes from
the fact that the command generation function works in the most "generic" way
(ie. producing output that works for all cases: windows, tabs and buffers).

In order not to have another special case in the generation logic I left it
there, but you are right in that it is not needed (fortunately it also doesn't
make any harm :)


> 2. You probably want to do "set hidden" on all the modes.
> 

You are right. It also makes the logic more symmetric. I'll add it.


> I don't see the need for all this complexity for this simple mode, but
> anything that actually works is fine by me.
> 

...in fact, back in May I just wanted to add a new "vimdiff4" mode and what
originally was a 5 lines patch became the current 1000+ lines patch monster
after all the (very welcomed, I'm not complaining!) suggestions :)


I'll reply to this message with a new version of the patch with your "set
hidden" suggestion. Thanks!


