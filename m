Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70A0C433E0
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 00:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C6F0206D7
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 00:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=jramsay.com.au header.i=@jramsay.com.au header.b="EZRk6JC9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uuJ0MrB4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgFOAeh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Jun 2020 20:34:37 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:51679 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727951AbgFOAeg (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 14 Jun 2020 20:34:36 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id AE4315C004F;
        Sun, 14 Jun 2020 20:34:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Sun, 14 Jun 2020 20:34:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jramsay.com.au;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type; s=fm1; bh=yEuU1s+KUcslXg0Df13B4RWfmu
        +OVuYDn9T2cm+kHOc=; b=EZRk6JC9VEpJo7pNKQnAjvblaYOAXb/wTYKHgDI0Rw
        tNApKeXg6hxTg726lOrbUtYuz8VC4U1WqtSZllB+6Ur7RKBCZcZTdywwT36tDI/2
        VCAb1g6PhukdYYiB5rIbsVCCVxFUa8BVqEXYXFzkxi2w62n4xUOOH+c8fhBuvVA/
        DMvgSwXDBIQEtYbBhSATH8EzUMP1sNHZV3ziQWvx+6UUitYHUNP7wV8ldNfJLOsR
        tEcJIVbPT/JnD+TwXG32h1humkzUwkE8CMA1Q7ZaiBbJhik3UZ0p7GxS8/WdwOlM
        je1z430rmibUXC6cSOltm/kQs/Q4odsYCBcC/eflZp/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=yEuU1s
        +KUcslXg0Df13B4RWfmu+OVuYDn9T2cm+kHOc=; b=uuJ0MrB4ROURNc9nrGUjtj
        ZIWUIVymSlu+twIArrT5xXgSgPhO4L7JCcqeaIDsqtHKLptxI3PHg8ollKWBh6TA
        KvNqn3eCMtOmNmAAsbZk4nmx0rDrmTDKY7kJpT9RJcTfyjLpH5iCxiP2F3vxnZ5r
        ULoPPzSgUIM2DI6VnI1dnzvgK3mxGGaUPXDZXye9nxXV0d6suKnuILYhKh5N7ubB
        dDjIOtuFvvVlqjHF739rPHDO3UjPEU8vs07APVEXKTZka33tQX4NfvzPj7Un+WKY
        qxWBNIHJ6uCZKWFTmK56STPNLVpLAuw8kPPl9XuG2wnUDe19KooHDvMqlbtMnaBw
        ==
X-ME-Sender: <xms:G8LmXqcmIyVp7KSjrgNTFhNh04z9nPtWrxD-wfO9poTGG4RPWh8UUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudeijedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffoffkjghfgggtsehttdhmtdertddtnecuhfhrohhmpedflfgrmhgv
    shcutfgrmhhsrgihfdcuoehjrghmvghssehjrhgrmhhsrgihrdgtohhmrdgruheqnecugg
    ftrfgrthhtvghrnhepvdegueekffehfedtkeduleejleelkeetieethfehfeekfedvkefh
    vdehfedugeegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhlrggsrdgtoh
    hmnecukfhppeduvddurddvtddtrdeirdduuddtnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepjhgrmhgvshesjhhrrghmshgrhidrtghomhdrrg
    hu
X-ME-Proxy: <xmx:G8LmXkObmyBvZAbL-djXF5KpRea_XeGln1agfs9WLpUjJapt3oztEQ>
    <xmx:G8LmXril4-IhXollEGvTYJCzip-plFA2NU4GE4BqUtlmxIf6V-KniQ>
    <xmx:G8LmXn9LVLxuD5nm_EUBsR7hBhjyA0SudJKzyB6qRlOmpnwt-j4zTA>
    <xmx:G8LmXrWnc4dPrXkzMOrNWcfd-QSbGRbNnLzwisoLduEg_3yGCdANhA>
Received: from [192.168.1.38] (121-200-6-110.79c806.syd.nbn.aussiebb.net [121.200.6.110])
        by mail.messagingengine.com (Postfix) with ESMTPA id A8A8F3280059;
        Sun, 14 Jun 2020 20:34:33 -0400 (EDT)
From:   "James Ramsay" <james@jramsay.com.au>
To:     "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Simon Pieters" <simon@bocoup.com>,
        "Don Goodman-Wilson" <don@goodman-wilson.com>, git@vger.kernel.org
Subject: Re: Rename offensive terminology (master)
Date:   Mon, 15 Jun 2020 10:34:29 +1000
X-Mailer: MailMate (1.13.1r5671)
Message-ID: <42EBA147-1034-4CA2-8A85-AAF023FE3781@jramsay.com.au>
In-Reply-To: <nycvar.QRO.7.76.6.2006091126540.482@ZVAVAG-DN14RQO.ybpnyqbznva>
References: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com>
 <20200505231641.GH6530@camp.crustytoothpaste.net>
 <nycvar.QRO.7.76.6.2006091126540.482@ZVAVAG-DN14RQO.ybpnyqbznva>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> As mentioned elsewhere in this thread, Don (Cc:ed) and I started 
> working
> on this, and I just submitted it:
> https://lore.kernel.org/git/pull.656.git.1591823971.gitgitgadget@gmail.com/
> That patch series adds a config variable allowing to override the 
> default
> name of the default branch.

Thanks Johannes and Don for your work on the patch! And Billy for 
sharing your investigations and thoughts on naming.

> Billy then shared this information with James Ramsay of GitLab to
> discuss how GitHub and GitLab can coordinate on changing the default
> branch name in new repositories. Here is the GitLab ticket to track
> their progress: https://gitlab.com/gitlab-org/gitlab/-/issues/220906

Yes, we are investigating the changes needed to support changing the 
default branch name of new projects created in GitLab.

> Tentatively, I would like to propose having this meeting in the coming
> week, via Zoom, just like we did the Virtual Contributor Summit last
> September.
>
> Could I ask all interested parties to reply to this email?

Great idea - thanks Emily! Please include me in the invitation.
