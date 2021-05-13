Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32F2C433ED
	for <git@archiver.kernel.org>; Thu, 13 May 2021 14:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4F9761260
	for <git@archiver.kernel.org>; Thu, 13 May 2021 14:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbhEMOry (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 10:47:54 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:38803 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234642AbhEMOrD (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 May 2021 10:47:03 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id E9245E09;
        Thu, 13 May 2021 10:45:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 13 May 2021 10:45:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        linuxprogrammer.org; h=date:from:to:cc:subject:message-id
        :references:mime-version:content-type:in-reply-to; s=fm3; bh=uK3
        DiIHrhOPwBbhZX0keIhD49XnPb0EvJ9KJYZfv2WQ=; b=ejguDVfWybwkDUj2Lrl
        0kCcafxN4svFew5KgIMfQ+H5HvDdMvdmo2Q3LhA3QRNK52IjGilVaZkKO0OPnOF1
        U0IMiy5eyayXavO4HbS0R39q2nUhTjJ/7z0by5tiaT1iIXMvEHGYjbVrnJCL5qDH
        TsYpkRLFku+Hmhcrl+yL2ciO1ZEgJlBkx7pj9NxyxDPP4Wcza5h8IPkSb6MialLI
        wUUEYYIUBrAgyjJtT2BJbmji0vwT1q0t80Ac4x4+eQSkEWbM9Hq8x+pjQqlqDbZM
        9c8I/VwXtCDJJv0KJQjhfQoBQRMUbHiG7ky2ZCuEi7ru2E+HTjqEEDqhEOtIbuwW
        8xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=uK3DiI
        HrhOPwBbhZX0keIhD49XnPb0EvJ9KJYZfv2WQ=; b=PUw3ADr90rGPliNI3fWyaA
        a+DAaIrRj1ytmRkrhz83LkUFFVPnUPh2aIfm/56RFO10rEKpXVwPXdUk3DXASECF
        KEZUmOLsNQRqY4k65q0m5oQuxYA+biFiE2wuDG+6kzlk7QUu6M8XfAXDEmt68vxV
        aFnHDQIERwRcZobiGCy8wBFNE8BWq03OUB8/OdlXE9qeO1o0JkL4hBm99wfWLJrk
        eZNAOHNheeuqkoUQzWlDMq9GmQY4JBnC42casZF10DfzM1hjoDwannY/yjT6JQiy
        k+xnYkzpyMWKjBNmSiOr3dRQ2GmEacMwDY9FXkr6unWD2SA+gaL0yythxLo7TIzA
        ==
X-ME-Sender: <xms:oDudYHvJjG-OLWekqfPDORIPtKz-qhP0fnyhkjO7Eeozmkdm3uhWYg>
    <xme:oDudYIdnUKvfPCfXeWy_HXREwxZ4kAatxxzA_jHhS4KVPB_4__OVzuu_yP4dFVnut
    QhFW6ZT57a_WiV_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdehgedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttderjeenucfhrhhomhepffgrvhgv
    ucfjuhhsvggshicuoegufihhsehlihhnuhigphhrohhgrhgrmhhmvghrrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeeukefgjeelvdejffevlefggfevkedvjeejieegfffggfegfedv
    tddtfeejtddufeenucfkphepudejgedrhedvrdduhedrfeejnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugifhheslhhinhhugihprhhoghhr
    rghmmhgvrhdrohhrgh
X-ME-Proxy: <xmx:oDudYKy2E6gEH1IqnzNOTMr-69Gq2BeD5u03Nr6RiFIzLxe0JRYRdg>
    <xmx:oDudYGO79hkfWB0rqzBXs8GA6ixetqGgFnA6lt2iBMJSV69SGZQOng>
    <xmx:oDudYH9_8I-h5oLB_1zhE1cE0QOVFEpaE1w0cyZIi91oYukAXGlZSw>
    <xmx:oDudYJJdVvhiQ87NZapKR4O9OIZO-HnIlyiP4LdrzME-vvSXMOK4yg>
Received: from localhost (c-174-52-15-37.hsd1.ut.comcast.net [174.52.15.37])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Thu, 13 May 2021 10:45:52 -0400 (EDT)
Date:   Thu, 13 May 2021 07:45:50 -0700
From:   Dave Huseby <dwh@linuxprogrammer.org>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Subject: Re: [PATCH 3/3] SubmittingPatches: remove pine-specific hints from
 MUA hints
Message-ID: <20210513144550.GB11882@localhost>
References: <cover-0.3-0000000000-20210512T084137Z-avarab@gmail.com>
 <patch-3.3-9da5bc4a0c-20210512T084137Z-avarab@gmail.com>
 <20210512235136.GB10785@localhost>
 <609cc953e0ade_329320811@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <609cc953e0ade_329320811@natae.notmuch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13.05.2021 01:38, Felipe Contreras wrote:
>Have you tried notmuch? There's multiple clients.

I haven't. Is that popular for mailing list style Git work? When I was
part of the Tor Project back in the day, a couple of the main developers
used nmh and custom python scripts to great effect. I was always
impressed with the CLI-fu they had.

I decided to try Mutt after decades of using Alpine and Pine before
that. I'm open to something that is more congruent with the way I prefer
to work. Where do you recomment I start with notmuch? Tutorials?
Favorite client?

Cheers!
Dave
