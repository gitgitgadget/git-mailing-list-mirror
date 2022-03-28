Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF25C433EF
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 19:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244875AbiC1TVl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 15:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244223AbiC1TVk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 15:21:40 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654A85DA7D
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 12:19:59 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id A42F43201DD2;
        Mon, 28 Mar 2022 15:19:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 28 Mar 2022 15:19:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=kidHJexAewGswDBeLwRqwsybs88RRAzcSjYS/0
        JnHog=; b=Bx5QU+JJon2WtJ4pkR7v78yVdW8piHtIk7VwdA87+//ZfuiT9gOYpM
        IHf2nCmajeKH3b62u83ZYyea3lSPjsrmVoiW8/YBWbVrO1wDSiC4ZjESMEFTJphp
        aAsZX9lMr57gpiZeB3lYvCckUueLfxonrBMU8inNBlj2wYnCTt4vBJZcEdzP+88/
        kSdc9vL65plEqu00+ErkoQ1/dyLbXW8CBijyZS5A0YiNYABTlkJ54BVPz9ZG81R0
        vP+lrwam+hDaryUb+rV1QKgCDdOYmPBzwGCDuDuqD5BEvtOCGOvg6wf5kiOvNcbR
        vaJhTeptQyuyErhvQYfYp6vUACB7c6Zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=kidHJexAewGswDBeL
        wRqwsybs88RRAzcSjYS/0JnHog=; b=WVNCiTeHQpHfHHD9EK0WWl4ID20Qp9rSO
        dVFXlDglJk4V2lrynD2ZzvJlsH1WknD8k1AXGAigUQX6baBipEmznu+cFmm3ywTb
        nv6dR/OrIRDh4tMISb0DwyiX26ZmAQD+HIY/op3nR9Eu2BhUPuA2ciTy4ecMgKOg
        jXfLNz4Ipw7/mHMAxm0SHzYWrW5ZRKPyxwAhzZj32lLGAqrG8QzoIs6EYSPFyncO
        NF6hyDbeBeu8CUX5KB59mGRNQ1eAFJpeFJjX0aMl1mBsGNibpfxy1rWGeh7Q5rmG
        PZ27vIlRTDf3urfPLxjDbEV0G8kkARzVK3DLQQ1QefcfT5ENsUgDg==
X-ME-Sender: <xms:WwpCYmwQMsiyqT86BE8PC5GiWsNhA1mUtz51tNo_T9cFVwO_7_tsOw>
    <xme:WwpCYiQimEstPXc4KIGcygRweCz6PHAPF52WzSFAvM3lYT5htjZSd0NvvCrUbLnqv
    z-hY5yFJ82bZcRfjA>
X-ME-Received: <xmr:WwpCYoU5A4fpmRaiKIHXBpHD9KRAsGcyueYVOXL_o015EZ_ewbVy9Oc_VgEPZeOiwKcFXXzaCYI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudehjedgudefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehttd
    ertddttdejnecuhfhrohhmpefhvghrnhgrnhguohcutfgrmhhoshcuoehgrhgvvghnfhho
    ohesuhelvddrvghuqeenucggtffrrghtthgvrhhnpedvjeeifeelhfetiefhhfdthfefke
    fhhfeutdetvdfgvefgveefheffgfekjeefheenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvvghnfhhoohesuhelvddrvghu
X-ME-Proxy: <xmx:WwpCYshnjAOCdwNIbveYW0fHJJkKatz-wf5Evg0WPuglcAZpkM2KHw>
    <xmx:WwpCYoCkqQBdyaMtR1ZywFliN7Wts9hdkGGQ0y_7kBS8IWF67VJVOw>
    <xmx:WwpCYtKm7Njkz9TiVjDv9VJx1dvbN5TKjVLVL6l1UwkkC2DkA17RRA>
    <xmx:XApCYq1oNNWBUmJtFdrzUel8BuF6SnTbD_5jIjVEY3FTJ3B0H0U7Bg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Mar 2022 15:19:53 -0400 (EDT)
Date:   Mon, 28 Mar 2022 21:19:51 +0200
From:   Fernando Ramos <greenfoo@u92.eu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org,
        davvid@gmail.com, sunshine@sunshineco.com, seth@eseth.com,
        levraiphilippeblain@gmail.com, rogi@skylittlesystem.org
Subject: Re: [PATCH v6 3/3] vimdiff: add tool documentation
Message-ID: <YkIKV7aqKpvBCFvN@zacax395.localdomain>
References: <20220327112307.151044-1-greenfoo@u92.eu>
 <20220327112307.151044-4-greenfoo@u92.eu>
 <2d1b3c6d-4345-8b7d-b8b8-4baf1edd91f0@gmail.com>
 <xmqqbkxq639i.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbkxq639i.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> What is the reason why a user may want to specify them separately?
> 
>  * I want to use this layout when using plain vim but gvim is so
>    different that I want to use a different one from usability's
>    point of view.
> 
>  * The layout I want to use with plain vim, when fed to gvim or
>    nvim, would totally make them misbehave.  I cannot reuse the same
>    layout even if I wanted to.
> 
>  * Depending on the kind of conflict I deal with, I want to use
>    different layouts, but there is no easy mechanism to choose
>    between multiple values I give to mergetool.vimdiff.layout, so I
>    use one layout for vimdiff and another for gvimdiff, and
>    depending on the layout I want to use, I switch between vimdiff
>    and gvimdiff.
> 
>  * Something else?
> 
> If on the other hand, a user may want to stick to a single layout no
> matter which variant of vim is used, it may make more sense to just
> use a single mergetool.vimdiff.layout across all the different
> variants of vim implementations, and possibly, have their own one
> override the most generic "vimdiff" one.  E.g. gvimdiff would use
> mergetool.gvimdiff.layout if exists, or mergetool.vimdiff.layout
> otherwise.

I think I agree. From the three reasons you mention, only the third one makes
some sense, and even that one is too weak to justify having different
configuration option names.

I'll only leave `mergetool.vimdiff.layout` in v7, which will affect all three
variants.

