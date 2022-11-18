Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2A2C4332F
	for <git@archiver.kernel.org>; Fri, 18 Nov 2022 20:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiKRUCV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 15:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiKRUCT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 15:02:19 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87BDC7FBF
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 12:02:16 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id s5so8571108edc.12
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 12:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j+d4iIGYyobqlKULrcbrlCECjMsmS8vnLELxNtoxwzQ=;
        b=DAkqosgyC9RtEMQ0RD6oHSBbntoiil2mw8/GGC203XIvJhNBWF2f2AOSyxNBbssQ+N
         0RaWXukq3g4YnUzcm/ZgFq+6xysVcKSXkpMSwwOzNTkqdIuOQXFbMru4aCO8adYA6XqB
         v+SOpwL+sWRN/GagdhNW6b0vKB3H1Wli0eHCUfiR8RCiFTXnLJsZei7hK6/Ee14ZBqlQ
         tjpn+1VHVRVa8ld7NAkd8QKfrcOQt10koA2NngNUPZECqck6IJrsWOo9yx1hE6rW0j0I
         +j/52PVTCz6CdBaTR78lvQhXTGtQEmzG/vXziA/eoN43DWUb9Tq4enYCUQ3WiUla71hj
         BZrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j+d4iIGYyobqlKULrcbrlCECjMsmS8vnLELxNtoxwzQ=;
        b=H+GAK2RJWsYai9oORk7vi+I3Zanj5CVDaH7YvwcSuu0hCq4StP6Rujdyvz2DYxjF1u
         jKHcDCZTr8FzteVKLs49W7pfBsiEg0RMpWyOBZEAZBXjZzznzVd8alL+t/bF49ItDNqu
         R0vZpaheFG4ByQMvtggRcxvnpg/W7wmuGexfNFOg7/my+RU9e/5RP6tVBd7rp0bzpH6f
         BxPPyw6nN+qrhpUjWsw029dSb/gtFRrZqxId7AdbIpp8+L7lKErikEx+DYPNZo06u7hr
         aRvtMW8CLwLfiubY5Jau3Tc5TcZuuJNJO/TCWK+bgm+LBvvC3QyzbUUDnSBkP1l6zMjj
         CtMQ==
X-Gm-Message-State: ANoB5pmhrm3lO16pfUrvude6a/496D79PNukI/TlYFLgno+Jd/n743jE
        WXm9AQF8VxvOX63j8rdMcGA=
X-Google-Smtp-Source: AA0mqf5qMlLTkSX/FT/E8Jt7Zmop/xwY/AzXrhFM8Nfj04z//gVF2v7d08/BHYDap0RxvF2tfYv/cg==
X-Received: by 2002:aa7:d3cb:0:b0:461:8d98:3d6d with SMTP id o11-20020aa7d3cb000000b004618d983d6dmr7487230edr.116.1668801735269;
        Fri, 18 Nov 2022 12:02:15 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id o5-20020a1709062e8500b00779a605c777sm2056310eji.192.2022.11.18.12.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 12:02:14 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ow7Z0-005jOp-1T;
        Fri, 18 Nov 2022 21:02:14 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     David Cowden <dcow@pm.me>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git-subtree docs missing
Date:   Fri, 18 Nov 2022 20:56:08 +0100
References: <MzUvo2TfR7gGs7FQsyF-0TqfSNT6X_9eZlBkFBDoa2IrpnT81MYqhNJUKh_aSsNJaH0HrM9PeoQhx6LMlFy3bd3bVCo9aqlT_7Ul-wE6LkE=@pm.me>
 <mG2PHaCBIK7N--HeRqPn3Vn9Dc7MzTiahRjTxZq9_7T7UWF1YN1LT4wVeDSpFABOyeH-YjXGRMq8HVE_VFOBOYvkdwBNwhS3eDyGkqW-0Nw=@pm.me>
 <Y3fKTpufVB5oTfkD@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y3fKTpufVB5oTfkD@nand.local>
Message-ID: <221118.86edu0f2ux.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 18 2022, Taylor Blau wrote:

> On Fri, Nov 18, 2022 at 06:03:36PM +0000, David Cowden wrote:
>> However I'm now aware that `git-subtree` is part of contrib and not
>> officially part of git so my expectations for finding documentation
>> there may be wrong.
>
> Right. We don't have any standardized documentation in the contrib tree,
> so it isn't built for git-scm.com.
>
> The documentation we do have for 'git subtree' is at
> contrib/subtree/git-subtree.txt.

I think changing this would still be worthwhile. We've since made
"scalar" non-contrib, but when the discussion about how to do that was
ongoing I suggested creating a section in "git(1)" for "Optional contrib
commands"[1].

The eventual idea being that we'd always build e.g. the git-subtree
docs, but would not install the command by default.

I can dig it up if there's interest. I really think it's much better
than what we're currently doing.

I.e. we don't want "git-subtree.sh" to be "blessed" (for reasons outside
of the scope of this discussion), but I don't see why that would extend
to its docs not being accessible, and us not testing it by default as
part of "make test" etc.

My first encounter with "git-subtree" was of finding it on one system,
having a manual page for it, and then being preplexed that another
system didn't have it. I then found out through other means that it was
"contrib", and only optionally installed.

We'd still have it be optionally installed, but we're not doing anyone
any favors in not linking to it as part of our docs, and having some
blurb describing that it's shipped with git sometimes, but not part of
the main command set.

1. https://lore.kernel.org/git/cover-v2-0.1-00000000000-20220623T100554Z-avarab@gmail.com/
