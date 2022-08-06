Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AD6C19F2D
	for <git@archiver.kernel.org>; Sat,  6 Aug 2022 16:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbiHFQZT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Aug 2022 12:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiHFQZR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Aug 2022 12:25:17 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABE72188
        for <git@vger.kernel.org>; Sat,  6 Aug 2022 09:25:14 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 8EDD232003AC;
        Sat,  6 Aug 2022 12:25:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 06 Aug 2022 12:25:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1659803111; x=1659889511; bh=HFGuygmJ3X
        UEI90HTt/Herfiym6kR8hQoFoD+e4MmuY=; b=MVhrITqQlKJ6P8RniuLgBElRnq
        z9lu/PzQg6eT7pnZLV5iw92gm9Zg49nT1Vqi7XEpkDupF/Nl6FfkdgOY0zjcdbL5
        SnAIgDcFf/OklTz4Ul/Y1H97QbhAPPNZMRmdOvZAMtc1kiuMQwN9mEo6z6cIXMBq
        J6D37l7bUBwibn7iP6hhRk6D/APnFDKstgBXjMeIiJV3pnYzhbSP2KyagBod/9t3
        92S7YS26ei8l9d3yrbBmXw6P5B9F8TAMjHtgdu4vhLcnzT4NbYhK2xFXiOyMnbLx
        Q5THUDNjqQa75i78myTyyrd0KOX5DyHxclVBbZk+p8dDpMnRD1lHGOME0IlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1659803111; x=1659889511; bh=HFGuygmJ3XUEI90HTt/Herfiym6k
        R8hQoFoD+e4MmuY=; b=14kUVhpys19pDESS9Qw7vBnzu9QLVJKB2W6yRQXnmrS5
        hQlCr8aauBiD5GsoMrpsWOqq5Kt2bzLq8ZYvUcPH1xQxr1wxVosAYmAnIDmMMIya
        DVoVlgK+mIK51hsHWrgJ31UvyJAoCMfGgJpr9rrmvJ6wrTMfz0q3tB/TNb2n2vbO
        PpeTMjP65WhFYwypMZuVFf9sTxDTErN0FMYTej0DbEstGylOgugjfoJUkUuX92kY
        YIgKp5lPOqI02WTK032oetft8aacOXZjDSxp4dMKRPAovjmma24qD6fn8nHNPcAu
        7TljmmAd1ma7afqQqMZXeeMf/76wHNoho4cTRNn7gA==
X-ME-Sender: <xms:5pXuYhcUVxp4I-A3qCVTigeDRY6v6FQS2ZE3OvYsKJila_lOgfKFSg>
    <xme:5pXuYvNTSjJGXQUFrR_vxSZUgKuf0dXm00ujWZf-lAExk9zxj4wr1PDiphMkrQ85y
    EVjcFNtT0GdsvB1qQ>
X-ME-Received: <xmr:5pXuYqhodka2TzFsl20iHsSG120rjtxfFlm7vrbpUx5mbN25pZbkCU4Jj9eqOPyPg17zC0GiSnw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeffedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpefhvghr
    nhgrnhguohcutfgrmhhoshcuoehgrhgvvghnfhhoohesuhelvddrvghuqeenucggtffrrg
    htthgvrhhnpeffheevteefjeevieekheeujeeivefguedvieefleeuiefgtddtleelheev
    ledvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgrhgvvghnfhhoohesuhelvddrvghu
X-ME-Proxy: <xmx:5pXuYq_rNNIeHhdw0PO_H2ySGiy_VeQiKCdZ_rx8kRSC-gErfa-Kwg>
    <xmx:5pXuYttX309uWwQnFvQ6BNGOntQu66AR2nLsRFFiVcmhImGrW_zpRA>
    <xmx:5pXuYpHG0RMU7YwjvDnUJhRUvNrONSKN85l0XjthDLkt1QNf9QjMPQ>
    <xmx:55XuYuUd1tMirVVSjdqGHPnAycqeNlG0iAi9VeEiac6sx_qN2F150A>
Feedback-ID: i96f14706:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Aug 2022 12:25:09 -0400 (EDT)
Date:   Sat, 6 Aug 2022 18:25:05 +0200
From:   Fernando Ramos <greenfoo@u92.eu>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, greenfoo@u92.eu
Subject: Re: [PATCH 0/2] mergetools: vimdiff3: fix regression
Message-ID: <Yu6V4cIajhoMhB3t@zacax395.localdomain>
References: <20220802214134.681300-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220802214134.681300-1-felipe.contreras@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/08/02 04:41PM, Felipe Contreras wrote:
> Hello,
> 
> I wrote vimdiff3 to leverage both the power of git's diff3 and vim's
> diff mode, but commit 0041797449 broke that.
> 

Hi Felipe,

This is the command that runs now when using 'git merge -t vimdiff3':

    vim -c "echo | 4b | bufdo diffthis" -c "tabfirst" LOCAL BASE REMOTE MERGED

...and this is the command that runs after your patch:

    vim -d -c "setl diffopt-=closeoff diffopt-=hiddenoff | hid | hid | hid" LOCAL BASE REMOTE MERGED

The new command you suggest is meant to improve two aspects:

    1. Preserves diff colors.
    2. Removes the "Press ENTER" message.

Regarding (1) I never noticed this because in my tests colors were always
shown...  but I just tried to run with '-u NONE' (which prevents .vimrc from
being loaded) and you are right: there are now no colors.

    vim -u NONE -c "echo | 4b | bufdo diffthis" -c "tabfirst" LOCAL BASE REMOTE MERGED
        ^^^^^^^
        `-> Tell vim not to load .vimrc

So... I started looking into my .vimrc and found the "problem":

    set hidden

By default this option is *not* set, which means buffers are discarded when
hidden (and that's why diff colors dissapear). By setting this option colors are
back even with '-u NONE':

    vim -u NONE -c "echo | set hidden | 4b | bufdo diffthis" -c "tabfirst" LOCAL BASE REMOTE MERGED
                           ^^^^^^^^^^

Regarding (2) we can remove the "Press ENTER" message by adding "silent" to both
"4b" and "bufdo", like this:

    vim -u NONE -c "echo | set hidden | silent 4b | silent bufdo diffthis" -c "tabfirst" LOCAL BASE REMOTE MERGED
                                        ^^^^^^      ^^^^^^

So... by making two changes to the current implementation (adding "set hidden"
and "silent") we can make it work. The nice thing is that, this way, "vimdiff3"
does not need to be treated as an exception and thus it will be (hopefully)
easier to maintain.

What do you think? :)

Thanks!

Fernando.

PS: I'll reply to this message with a patch that implements this in case we
decide to go this route.
