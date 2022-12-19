Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1A1C4332F
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 18:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbiLSSgk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 13:36:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbiLSSgN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 13:36:13 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B890915FFD
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 10:33:27 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id x22so23629928ejs.11
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 10:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jIWAyUKlEeXjRAe/2UvOxIdmpnSOm1f55PXjOIgIkbM=;
        b=RPC3vFJnumhAIDr+P8bol9BlR+GFxRg2tpBCa1iwBIq3f2mfreqdys4ogTcECj9xGO
         KYj9QqFjfcPSyciQGJlz4jbbzWvQ8JZ7ifsKqTbOMRNxodMOfANIxy9DYzOV/Hu67g8S
         u7U3HAu/v9dF+hENV9aVg/qtlZGQhzYv5stPTeQznjIG2TJJLocR2p6QfZNO0RQzy4RQ
         13wbeJJntF1npI1ia7juouvOvxqNHt+oXthNe58cXtgVb9C9onZtPDHu9L+qC0KRaEdp
         E/coQ7ckXpsTn6j3BbEKbZ7+nuiy9lRoZ+rc3SvGMKSaQs89lHSnV2MyVZxN5xDdF7YV
         nMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jIWAyUKlEeXjRAe/2UvOxIdmpnSOm1f55PXjOIgIkbM=;
        b=dJCknEvgig0nZlr79M5gn4NVinhJiHkm4Yq6XMxVH+qWRKzhgVNsLGgoZQt75oxhY3
         pG7OfUT6/cT+2hswqOF/tuTcaM3RBh214guE0cgJgGnEluswGlqHyoHn39Il97OvLFAh
         rmyRShs4OjrvZ2Lcc1Rjtcsal/sHsUUz/kGL4SVP/Rbtj3xxLfd19KcvWLwktMi4vpnx
         mOVfVYby57+Smx6v/89eJS0xDML1ee3I6Fla1dXAnBSIJpi1h4GmEQo3qEHnTZ8HY2WG
         lfER78DOx4qZvO9yuhGwsGJbg+gyrlEQbIioiYQ3nyx0nGex2Hh+Nts8K1IGRgYkTaGM
         nbiQ==
X-Gm-Message-State: ANoB5pmCcFEItak1epLT/7STZujNA8QC4f/kQ9TKhxxExZIZCaGX1PSM
        ZDhBp8Ob0uAys4VgGHSfAOraZDda6O7OKQ==
X-Google-Smtp-Source: AA0mqf5hN9Wgzf+zfdPjt5kbNDdGd/a1WE3qOgtRnsjPK62XFp9xT84kfdVjaY6+/yyfIHslYrVzAg==
X-Received: by 2002:a17:906:668e:b0:79e:5ea1:4f9f with SMTP id z14-20020a170906668e00b0079e5ea14f9fmr35320151ejo.54.1671474805919;
        Mon, 19 Dec 2022 10:33:25 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id p4-20020a17090628c400b007c0a7286ac8sm4697472ejd.69.2022.12.19.10.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 10:33:25 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p7Kx3-006i8e-0X;
        Mon, 19 Dec 2022 19:33:25 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Rose via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Seija Kijin <doremylover123@gmail.com>
Subject: Re: [PATCH] diff: use strncmp to check for "diff." prefix
Date:   Mon, 19 Dec 2022 19:26:11 +0100
References: <pull.1403.git.git.1671467624143.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <pull.1403.git.git.1671467624143.gitgitgadget@gmail.com>
Message-ID: <221219.86r0wvxmyy.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 19 2022, Rose via GitGitGadget wrote:

> From: Seija Kijin <doremylover123@gmail.com>
>
> This would be a lot more efficient than
> checking for the full string, as
> so many of the accepted values
> begin with "diff."
>
> This allows the computer to skip most checks
> if var did not start with diff at all.
>
> It would also let us add more "diff." strings
> in the future without having to duplicate
> these 5 character so many times.

This is missing a "why", is this one-off really needed for optimization
purposes? If not it doesn't seem worth the churn.

That we duplicate the "diff." part of "diff.renames" (as opposed to
"renames" is also a feature in my opinion, it makes things easier to
grep for.

It would really just be preferrable to have the compiler do this work
for us. A while ago I experimented with that, i.e. if/else if/else
chains of strcmp(): https://godbolt.org/z/rrnYWW7nj

As that example shows at least GCC doesn't do anything interesting with
it as optimizations are concerned, i.e. you'd really want something like
this instead (but for the compiler to do it for you):
https://godbolt.org/z/7hsPo59TM

But, as you can be seen at https://godbolt.org/z/zWK46rGK5 it *will* do
that if we just use memcmp().

So, doing that really seems preferrable, perhaps with some macro that
would provide the "n" to memcmp, so we wouldn't need to hardcode the
length.

But all of that would be predicated on whether the optimization is
actually worth it.

If we are micro-optimizing config reading we should be moving the
relevant code to the configset API, where we have the parsed keys as a
hash, rather than trying to micro-optimize the callback API, where we'll
call the callback N times, just to brute-force ask it if it's interested
in some small subset of the config space.
