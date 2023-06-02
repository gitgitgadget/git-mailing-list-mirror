Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E640C7EE24
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 12:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234946AbjFBM6P (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 08:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbjFBM6O (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 08:58:14 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0B01A2
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 05:58:13 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 388C2320095C;
        Fri,  2 Jun 2023 08:58:10 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Fri, 02 Jun 2023 08:58:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1685710689; x=
        1685797089; bh=xpRJG57JGWyxhmxnTEfaFB3Bp5Mf0xmX+YiJdpDLKEw=; b=T
        lo44HeFKSD0lz+mTTV8blGcuo+s992aNhMEmFtqzLG9RWXyYVEVfpqNTTLXT5TrG
        691925mORFNYl65wFUbGlbordAg1ur27Ae2ye/WWsmwGriV6CbVyd/niTkHJD8IE
        EZwf+von+XaZkbN+0hv/xJLD34urrJj3cPWCq2KUAWM24PNchygx0fVJDIabAK7w
        NiisGqkmRlr6h9vWh8jAOdMpxqEHFcObdk6eL7p1UAljlZ+SoM6yMZSDc+l2k9KP
        QyjZxNLDJWq6m/p+Gz9oXwNqG9bfrVofb9Mv6rWyMzVcvo8hKd0WKNsX9cUHyIxT
        yF3OhbUwBvZNdmzuUOspQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685710689; x=1685797089; bh=xpRJG57JGWyxh
        mxnTEfaFB3Bp5Mf0xmX+YiJdpDLKEw=; b=sz0qmp8qjyNek8tCd3NFNhezOaGQQ
        TEUjHYXe0QPoO2JnkMgtiFpjh92iYFyp1yrdhG0rdmG+0VlV5yVm30vT64sIz6OS
        DFbrELV2zkInM1GARd7MhEXBkynVG+50+kWtDcPF8Et5qmdKamBwKk62G8UR+yxu
        L22fhO6A6dxYNbdHbgDd8p/Z99emtQPrG42/mLnwrdhxEgTuwVsI5sLYKCkxXb7J
        zHXqtbfsC891pRnD1Jn5X9ThlSPMkKkCRZLJjvkZB8aeFQJwTk74Ad3GWXI7/QpY
        Gf8e2myh7ntEvfutSAGOgtZqNVqKpKAh2mWcgLnE9xqROlmCUmEU9eBYA==
X-ME-Sender: <xms:Yed5ZIP6s-w4ADW6wO9QJE5Y3b9OsdD2BcQmAFEOiesUkOzP4Ctpg54>
    <xme:Yed5ZO93bU5KYjM6EGuhkAtsJJyhxbeNyoWeTEDzIOwzFbJbM_VTnDSq-SjrmSty0
    Kx5RLkh-T7rSl1Ceg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeelfedgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvvefutgesth
    dtredtreertdenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdf
    uceotghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpe
    dtkedtjeeiffelteffheeiheeufffgheelueeftdejkeeufffgiefhgeekffffueenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskh
    hhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:Yed5ZPQiEYiQSyr0pANyOzna-fFjHfftktXE0oDBUquqLq8D_wKBuw>
    <xmx:Yed5ZAuGhmrLNCIOjWG_dL4gVgC9ZOYyJyDM4yRPXEKyeFZMfrTxdg>
    <xmx:Yed5ZAe5HJCDhkUpETyeB_akgmLqZoSYydqmQrAthOOG9XRHFc1LBA>
    <xmx:Yed5ZKoZ6U-X8vgtzv28f1IcSZx6HJrVRTYHzlxQ_yQkJjCHe1h3-Q>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6531F15A0091; Fri,  2 Jun 2023 08:58:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-447-ge2460e13b3-fm-20230525.001-ge2460e13
Mime-Version: 1.0
Message-Id: <79bddb7f-d120-4898-ac9e-cff9b404918b@app.fastmail.com>
In-Reply-To: <1201c202-e046-01a3-df87-d959f0611725@decentral.ch>
References: <1201c202-e046-01a3-df87-d959f0611725@decentral.ch>
Date:   Fri, 02 Jun 2023 14:56:24 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "Tim Tassonis" <stuff@decentral.ch>
Cc:     git@vger.kernel.org
Subject: Re: Release Notes wrongly identify git as a self-learning program
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hi

This is just the commit messsge jargon. :) it's been like this for years.

Long before ChatGPT.
-- 
Kristoffer Haugsbakk
