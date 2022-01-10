Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B134AC433F5
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 21:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343760AbiAJVFo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 16:05:44 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:43627 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239741AbiAJVFn (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 10 Jan 2022 16:05:43 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id CD5453200933;
        Mon, 10 Jan 2022 16:05:42 -0500 (EST)
Received: from imap46 ([10.202.2.96])
  by compute3.internal (MEProxy); Mon, 10 Jan 2022 16:05:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=artagnon.com; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=HWBrRE3zCicjHWiaYvXdLJg/Zql/lzA
        4BVaofLXE3o0=; b=EsrtC0jE1PMw8bOzItkgdj/K6YgzmBc/cV33Q+c+WcLbLA4
        Zb3mBVcQ8b7YPVSH/RJcBlvkd0Xc2mwg4PCnXEx+J26omlgeaWibB9ka9UAO1gF0
        anOogC/vfmD1NWIb+enxE6zjGQw3MnP25fr3kBCtZmXrAJ8lYe0KCzLDMQI5sx3N
        F91OULKJpY5jBk0GW5KvPfFKJbEJu9H5m7Oa6c3nrZWaSZGbtqG8+cr8OQ1iLzQU
        NQDnLxtFp4eeEtVWG30mOXJgXemKTF0zbSUjkHO5ARWh9Ed3iRL9x93BKWb6OxNq
        rhXBVJCbKUQbjou5Yw7SsdI15sV4isuiSVgUHNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=HWBrRE
        3zCicjHWiaYvXdLJg/Zql/lzA4BVaofLXE3o0=; b=mqgCTojshVIOzRlAPG0Tda
        e5DE9Np7EN3pfpbuMSX64Bj+iv3W1vVTVPHKdOZnEEWoiImAsfTNABmLyKKsT7xC
        aDU27tRKuJcpSbrX3alXgUfbTgcQQ/HohzxM7TfsAqYw71OAui/B1CfavQ4zdg3b
        NkWZc1GY/rXyauXeVeVEJ4WlGJxJSGXs4mIu8hFUrsPCnP1V4AH64u8HkgKqKROD
        Dn1I6fWWZCBie9dHOhFAq5laKTNFNkg0eMAQRpEYybDmgT2zuzxB3QqataA2/WWD
        Bki4BXlrdNWwuKMJI3y0qcsaFFnGlMnm8/uTaMzuqfX7AKuI+Vu10er6ERTHg1VQ
        ==
X-ME-Sender: <xms:pp_cYQyzwRp4UWR9D8yNEeFmYcFpUnbtuTbwTI0eCWStTRHN7FYlLQ>
    <xme:pp_cYUQgXCo08wMHiR2KgtygrtXtxc5DpFj8HhiTQdcuNGuWTrYmE4gLlaOj8ooxk
    3PBLbHoPd2kpfX0rvg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudehuddguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkjghffffhvffutgesth
    dtredtreertdenucfhrhhomhepfdftrghmkhhumhgrrhcutfgrmhgrtghhrghnughrrgdf
    uceorhesrghrthgrghhnohhnrdgtohhmqeenucggtffrrghtthgvrhhnpefgheffhfffvd
    dtteehffeuudfhgeeiueevhfeukeeujedtheeggeefleeftdffkeenucffohhmrghinhep
    sghishgvtghtrdhshhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehrsegrrhhtrghgnhhonhdrtghomh
X-ME-Proxy: <xmx:pp_cYSUtR3x5Nr6QNd3V38jd1W-N6MoPGNqe4nY6sqX6FvPAkl-EZw>
    <xmx:pp_cYeji3NWg3e6xY7Uc99RH6jIMYHWaTm_WdpfouIDt7K7RNCAS6A>
    <xmx:pp_cYSDRDB0h20tUohQej9etVzfA4u7EGCBAL4zVRLqn5JOpzxF34w>
    <xmx:pp_cYZ-XggPPITwaemGQ3mYPrl_40VUQJLlkPL822Gp7N2f_Y5U9Mw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0B9AD1EE007D; Mon, 10 Jan 2022 16:05:41 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4527-g032417b6d6-fm-20220109.002-g032417b6
Mime-Version: 1.0
Message-Id: <bafa9564-fa48-413d-bbef-3f068c03dd31@www.fastmail.com>
In-Reply-To: <xmqq4k6b34h8.fsf@gitster.g>
References: <1edfc6ff-4db8-447f-9eb7-85843258a286@www.fastmail.com>
 <xmqqilus3ctf.fsf@gitster.g>
 <fead25d6-6f5f-487a-ad4c-0657fe9785fd@www.fastmail.com>
 <xmqq4k6b34h8.fsf@gitster.g>
Date:   Mon, 10 Jan 2022 22:04:44 +0100
From:   "Ramkumar Ramachandra" <r@artagnon.com>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     "Git List" <git@vger.kernel.org>
Subject: Re: git bisect bad @
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Junio C Hamano wrote:
> "Ramkumar Ramachandra" <r@artagnon.com> writes:
> 
> >   # on coq.git, for those curious
> >   $ git bisect start
> >   $ git bisect bad @
> >   $ git bisect good V8.14.1
> >   $ git bisect run bisect.sh # oops!
> >   Lancement de  'bisect.sh'
> >   'bisect.sh': bisect.sh: command not found
> >   La base de fusion ea3595845f5013359b2ba4402f948e454350a74c est mauvaise.
> > ...
> 
> "command not found"?

Yeah, I suppose bisect invokes exec(), which then probably expects the executable to either be in $PATH, or expects me to specify the path of the executable, failing that; in other words, './bisect.sh'. In any case, this minor typo shouldn't penalize the user by having to abort the bisect, and restart it, specifying good and bad commits all over again. Then again, there are other ways to bump your head: what if I forgot to chmod +x the bisect.sh? What if there is no bisect.sh? Should I have to restart the bisect process from the beginning?

This presents another possible opportunity for enhancement: in an overwhelmingly large majority of the use cases (or so I assume), './' is really redundant.

Warm regards,
Ram
