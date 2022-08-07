Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79876C19F2A
	for <git@archiver.kernel.org>; Sun,  7 Aug 2022 18:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234775AbiHGSjR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Aug 2022 14:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbiHGSjP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Aug 2022 14:39:15 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41DB5F9B
        for <git@vger.kernel.org>; Sun,  7 Aug 2022 11:39:14 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id A886E5C00D7;
        Sun,  7 Aug 2022 14:39:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 07 Aug 2022 14:39:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1659897550; x=1659983950; bh=2oDkrwCBcL
        G6/a/W5l8GDZDfJ+8nrWHPN4xMnMIGZ8s=; b=QMaKZheWNVfJrFQyZREVbusYg8
        z9EizulpuMFBRqcj+THyVuWJTmFcjbHueEJ1qjPwqSJPDomIQyJvoVxVDh+8qxCN
        WgdaoHwccKxBTQI9RQxpcIK2Mb1U8AAsOGS4uZ5EAnHrSZwX+ysSOTCNIN7gjx1k
        14C7TMY8GOlCZgUqp1gjQ5gyOiFaY7A7CICXT1d2tj101Z9EuqI2cvN7iIhvtMb0
        eQRJGg8kTxBr7oMelImcKm1OUWqQifZqjW2kmG6x851Os+yjTzeu6ZdkGcaMmih6
        mUo9kl/Ql2GBziFb366oti3lUOeOh8tKUifh5P8863/LsZnA98oq66XBErPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1659897550; x=1659983950; bh=2oDkrwCBcLG6/a/W5l8GDZDfJ+8n
        rWHPN4xMnMIGZ8s=; b=Dpzu0XBx7mUdzlTUXVHpV1NeVVZa9tzUtJwj7fSnXwbn
        8ULcAwzYZDmLTQna5hwScvI6lNcyydotM5YneP8Mjp0OlJJpgBZ3lMUd3CheGSC+
        Pc+UGdhiRdu7js5bXUVYFkI384oogUPWWarb4jj9X7H+Q/S9P5TAhhk2gWnhSW02
        04FzA9WpYGji+qsHR4HiudocqxoEh19w03KVw+vJU+ZMsONOqOF3ViGK78K5kJra
        PlPrS+z7zJR1Jvd1iTT16WZ5knz3h0NJ7phU+5GttmcpcqgxZUZUaOCZVsmC69fe
        LC8j6SFZYLuIa5xs1HwZIsjdU59ZaAkO9ykyAfXNMg==
X-ME-Sender: <xms:zgbwYg4WQkKxusv1vgyLWMoEodu_NndpM0YBye98-DQ5BVl3KGnvrw>
    <xme:zgbwYh4U0laFdsAIUQeMMCETob8fSCG0vblrzvi_PWz4gfsBxPKZZD8NnzfRJ46Oz
    kjXo3D3D_NXBMOQhA>
X-ME-Received: <xmr:zgbwYvfcjTwm8ufF23UxWRPhTVdj5Bg2bG1mVPWiED5EaeuVMHym2NkTxIaMaCTInmJNAsCtMpc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefiedgudefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpefhvghr
    nhgrnhguohcutfgrmhhoshcuoehgrhgvvghnfhhoohesuhelvddrvghuqeenucggtffrrg
    htthgvrhhnpeffheevteefjeevieekheeujeeivefguedvieefleeuiefgtddtleelheev
    ledvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgrhgvvghnfhhoohesuhelvddrvghu
X-ME-Proxy: <xmx:zgbwYlJrhGf8Mgglvrp9SGpg6NOJovljngCAfjq-Ej9_hVGg8zdhpA>
    <xmx:zgbwYkIiqVM8_8LB3hDk7V0rOBTA8vXzxpfnlS1k4U_GAgw1hCJE_Q>
    <xmx:zgbwYmx-ieVO98fRqH8J8SrrWqhJJ6w7wsxtpBbFLSfOSpfn3epbMQ>
    <xmx:zgbwYuwBh2u7o6fO_NIJvxJOQao0wCY4IWG6_ZH-E5k1dKunOVBKyw>
Feedback-ID: i96f14706:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Aug 2022 14:39:09 -0400 (EDT)
Date:   Sun, 7 Aug 2022 20:39:05 +0200
From:   Fernando Ramos <greenfoo@u92.eu>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 0/9] mergetools: vimdiff: regression fix and reorg
Message-ID: <YvAGycJR8Yq3hxOh@zacax395.localdomain>
References: <20220807024941.222018-1-felipe.contreras@gmail.com>
 <Yu9vvAKJzOpoQ5AS@zacax395.localdomain>
 <CAMP44s2s7QV9+Pgkchfk9=X-6Vwz_QZP0Vd145-euT-SR9Xw6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMP44s2s7QV9+Pgkchfk9=X-6Vwz_QZP0Vd145-euT-SR9Xw6Q@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/08/07 10:39AM, Felipe Contreras wrote:
>
> That's because the diff mode only highlights differences between the
> windows in the tab. If you do something like "BASE,MERGED" the diff
> won't show colors for LOCAL or REMOTE.

That's right. I've been looking into this in detail today and I think I finally
have a good solution which...

    - Makes vimdiff3 work as any other layout (no special case, not even an
      extra "if" to handle it)

    - Makes colors work *in all cases*: single tab with single window and also
      multiple tabs where one or more of them contain one single window (in that
      case the diff is made agains all buffers)

    - Works even with an empty .vimrc

I'll post the patch as a reply to this message.


> That's why I don't like any mode other than vimdiff3 (and occasionally
> vimdiff): because I want to see the diff for all the files, even if I
> don't see those files. If I open mergetool with vimdiff and I close
> the BASE window I get something better than vimdiff2.

You can keep using vimdiff3 but now, also, after this fix, you can use any
layout you want and append "+ MERGED" at the end (or beginning) and that
particular tab (and only that) will behave the same as "vimdiff3" :)


> To me if I configure "BASE,MERGED" and I close the first window, I
> should end up with the same view as "MERGED", but I don't, which is
> why I fundamentally don't like this layout approach.

This won't work. Not even after the fix. If you want to modify the layout (ex:
by closing a window) vim won't automatically update the list of buffers to
consider for the diff.

You can always manually update the list later *or* use "+ MERGED" as previously
described.

The root cause for this is that, when opening vim, we must decide what to diff
on each tab, and the logic after my patch works like this:

    - If there are more than 1 window, diff among opened windows.
    - If there is only 1 window, diff among all buffers

Seems to be the best of both worlds :)

Let me know what you think.

Thanks.
