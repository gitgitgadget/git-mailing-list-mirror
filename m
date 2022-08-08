Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B9AC00140
	for <git@archiver.kernel.org>; Mon,  8 Aug 2022 18:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244191AbiHHSOf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 14:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiHHSOe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 14:14:34 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC0712AB3
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 11:14:32 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 6F8025C01E8;
        Mon,  8 Aug 2022 14:14:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 08 Aug 2022 14:14:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1659982470; x=1660068870; bh=oLiV+IQTZm
        +nVKFa6sXRG8qgaQ5bgCdDv+yFDHQ9Yts=; b=UyVOQkdYOCK1DoZGQnlPRa9kG9
        IkW4Yoo3H+JmJP3u9tXaNhreWNTqY8nUfYCAzl8u3lCt8NTiZ/T11tTehrcfWfTi
        asHu7A2AJjo3jUhlsE2lQb5xXSJCu6x4Xafyek+rmh6xtt7omNXbNxAg6NcpmXiJ
        6ppHsO13TiBIFWuTp257f6T2WXV0JtYBSt5WzFpSn7WFvDGw7DrHVoksH6GJ/xm4
        EipYm2gNQRAIJSYz2rmUvVT8yPJvvaMXBpPTLW7sSRuhclm38rWbuftGRQI/hf2F
        5scqkUEHbPqTOXPYLxsAvZrVmnqslweYbrTMBGz/gtv8BjZqAA0P6XEGp//w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1659982470; x=1660068870; bh=oLiV+IQTZm+nVKFa6sXRG8qgaQ5b
        gCdDv+yFDHQ9Yts=; b=G7fau0WSus6HSP3rabekjWXIeUIqgyXBtbwOU/Sryzrj
        Jgyo90c/5pf8h3gpHVKFZ4+WXMvdYfKmBKwl1NDx/1S20+qGpB6wCQ9sVsbCa9/V
        Lwz2joylq4Vkxz8KTioB2fDr1g1X7maWWjLfse2FeFCSigHaMo8WbZz7lZTJWAkg
        3PISuDEkZSeSQbYHtzIcMWiex1GSNNg7r6RHXPgtxr3slqBHgNtn6cm8COQCgGMI
        EyaMw00YL1bKMDrkMeuuFI2be0+UnnRlOAOYiwee5xygWTpFTr+qwba7uK5bpQdx
        OCWqwiHw+6Ce9SydVoUTi/QfXaFIdcGAHMerNFse8A==
X-ME-Sender: <xms:hlLxYoL__btKJXh7J0bYodV-fPgjOzEEcJRZC57KJhzAR0oqSRhmoA>
    <xme:hlLxYoKygs79S0BMNiPhaChsmOejksiJs16HKa3WtfG7oKeIgPmNI3Z2JKLI5CZcy
    D72A6uVXLo31BoEvA>
X-ME-Received: <xmr:hlLxYoslP50eLh2WliY9s-Cbq8sL4_kdSJMQ64oplqVSgMvuaeE1HUJuibQr2vbZpqlYIv0HdrQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefkedguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpefhvghr
    nhgrnhguohcutfgrmhhoshcuoehgrhgvvghnfhhoohesuhelvddrvghuqeenucggtffrrg
    htthgvrhhnpedtueeuvedvhedvffejvdffteeiudfgfedtfeettefgvdduheelhefffefg
    ffffleenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvggvnhhfohhosehuledvrdgvuh
X-ME-Proxy: <xmx:hlLxYlZKpRrhcLXCIwVPCwV5jtU7BG0nVpGJT-KgiSmzrTO67p-CaA>
    <xmx:hlLxYvautTBJo7PmZiZC1IOBP1WT4yU0GgFK92djw4cdXjDs-6EWeQ>
    <xmx:hlLxYhAfOxgPGz76FGB32lAzSDhtRUqF1G14NdafCMrt1GBCnutg1A>
    <xmx:hlLxYgBJ2WfUl3cIgb7l4HW-UX02DDgi4_R2xMuHs1sGlSm-NBaa0Q>
Feedback-ID: i96f14706:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Aug 2022 14:14:28 -0400 (EDT)
Date:   Mon, 8 Aug 2022 20:14:26 +0200
From:   Fernando Ramos <greenfoo@u92.eu>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 2/3] mergetools: vimdiff: fix single tab mode, single
 window mode and colors
Message-ID: <YvFSgjK0P5kzoOfg@zacax395.localdomain>
References: <20220807024941.222018-1-felipe.contreras@gmail.com>
 <20220808053459.184367-1-greenfoo@u92.eu>
 <20220808053459.184367-3-greenfoo@u92.eu>
 <CAMP44s3v_4PdOfaviXCxik1LL5k_kkmZ2Yp=+Qfb8CqyNCdMUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMP44s3v_4PdOfaviXCxik1LL5k_kkmZ2Yp=+Qfb8CqyNCdMUQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/08/08 01:37AM, Felipe Contreras wrote:
> On Mon, Aug 8, 2022 at 12:35 AM Fernando Ramos <greenfoo@u92.eu> wrote:
> >
> > vimdiff3 was introduced in 7c147b77d3 (mergetools: add vimdiff3 mode,
> > 2014-04-20) and then partially broken in 0041797449 (vimdiff: new
> > implementation with layout support, 2022-03-30) in two ways:
> >
> >     - It does not show colors unless the user has "set hidden" in his
> >       .vimrc file
> >
> >     - It prompts the user to "Press ENTER" every time it runs.
> 
> For the record, in my version these two issues are fixed in a much simpler way:
> 

Yes, it was simpler but remember it had two small issues:

  1. In "vimdiff3" mode, if you switch to buffers #2 or #3, highlighting
     disappears.

  2. It treats a single tab with a single window as a special case, when in
     fact it is just a subcase of a layout with many tabs where one of them
     contains just one window.
     The new patch series makes no distinction between them by keeping track
     of the number of windows opened on each tab which, as you noted, adds
     some extra complexity (but needed complexity nevertheless if we want to
     have highlighting enabled in all cases)


> >         # Add an extra "-c" option to move to the first tab (notice that we
> >         # can't simply append the command to the previous "-c" string as
> >         # explained here: https://github.com/vim/vim/issues/9076
> >
> > -       FINAL_CMD="-c \"$CMD\" -c \"tabfirst\""
> > +       FINAL_CMD="-c \"set hidden diffopt-=hiddenoff diffopt-=closeoff\" -c \"$CMD\" -c \"tabfirst\""
> >  }
> 
> These diffopt settings look awfully familiar.
> 

I would go as far as saying they are the same :)

As you explained, it is better to keep these options explicitly set so that
buffer diff'ing works in all cases.

Notice that in this new patch series, however, these options apply to all
layouts (and not just to "vimdiff3"), as we want highlighting to also be
enabled in multi-tab single window layouts.


PS: I have been testing many layouts today with and without an empty .vimrc and
everything seems to work. But it would be great if others reading this did the
same to make sure there are no other strange vim configuration options that
affect the way diffs are displayed (as, unfortunately, we have found out in the
past more than once!)

Thanks!
