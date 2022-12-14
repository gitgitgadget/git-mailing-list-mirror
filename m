Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 794E3C4332F
	for <git@archiver.kernel.org>; Wed, 14 Dec 2022 23:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiLNXts (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Dec 2022 18:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiLNXtr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2022 18:49:47 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5DB187
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 15:49:46 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so949245pjs.4
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 15:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cW+o7ofNq6CMJFg/jFEh9Dhy9FFBeXCi0X45eEkfXCY=;
        b=EiJSyDfEKabTUjZcRsdnGv6yjamSIjOcoKhL62ly8yDZUrcgO5mXQQ997dNEYQBODw
         Pscxs16rxDhvv3lOweV1fTs4SWS7Vx37tPReY/qdii6O7L+0u6pKUvyre1DPNWpTfqKw
         +9DhgTRAMRP6XpP6ynPGKRxtb7//7yE9JM8FhYE3lR4KMLuh62aIC7nMiZo+Px97+yld
         ifouMqfhb1HFG56a3t4AETLkqc9Ukw+s4sLb0tcvMC8grPUyge9S5Mw+Zo7y0Kwg0GXw
         W/CgST2UJwrRP37gfNaiYTMlH6xfFmO7AAWXKi+8xfu7kepFJOeH/qXXzMTWnjIJj2n/
         HBIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cW+o7ofNq6CMJFg/jFEh9Dhy9FFBeXCi0X45eEkfXCY=;
        b=1vGGS34TYrkjyL0OC5JZohwgI4JHCWF07qj7ZSFUYFL7PHhNmG2Fgyo1XFKxjHvWNI
         zmPb1cpFe9H9B1/LGRqyZYkT1aSXtCyzfCaBo65D9R8srn2t+AoGlb05GluU4RMk3ZRT
         RtvZPSdqyICP03dJ1umDd/6NlIx2mHxSyP9VIcacoz/REMXVEb55QoLGkbBeqXWsoBSh
         98fjFKN6Z1+icKr14SpsOSgLa8xX7dZ/c597Ob5cDNltO0i2ANYzgOaqNVY37jOQYbC4
         7kTFGIzbXcz2Lu1gWDt0Cx6KAEW8rtL7cEDdqeaDr9oT9U8nEvNnYah3jQxpX1QVchM8
         jeew==
X-Gm-Message-State: ANoB5pmyyblFl4Rzc1iCZMPDMuN2/wGuE8phd6f2UOLT5rj0VFluwfh/
        b+B6oXoiyOjj5BKPE99Nv/c=
X-Google-Smtp-Source: AA0mqf5DtL3WRJfIzJFiGoCCAGCtv7qRs6m6ye9XgdPU/bMTUS0TIMhxsnT21TW04e3+8epMyp7zBA==
X-Received: by 2002:a17:902:aa8b:b0:186:fb90:573d with SMTP id d11-20020a170902aa8b00b00186fb90573dmr30847354plr.3.1671061786036;
        Wed, 14 Dec 2022 15:49:46 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id i14-20020a17090332ce00b001869394a372sm2382387plr.201.2022.12.14.15.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 15:49:45 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Rose via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Seija Kijin <doremylover123@gmail.com>
Subject: Re: [PATCH] git: remove unneeded casts
References: <pull.1396.git.git.1671032126602.gitgitgadget@gmail.com>
        <Y5o9NNVx7dFLhIMd@coredump.intra.peff.net>
Date:   Thu, 15 Dec 2022 08:49:45 +0900
In-Reply-To: <Y5o9NNVx7dFLhIMd@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 14 Dec 2022 16:16:36 -0500")
Message-ID: <xmqqh6xxv946.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I'll stop here for now. It's a fair bit of leg-work digging
> these up (though again, I do think there's value in
> understanding why the cast was there, even if we know it
> isn't _currently_ doing anything).

I agree with the value of understanding why each of these casts has
become unnecessary, and thanks for demonstrating how a rerolled
version should justify its changes with its findings behind each of
the unnecessary casts.

What do you recommend the next round should look like?  Multi patch
series, each of which removes one cast with its proposed log message
explains how it has become unneeded?  A single patch with a gigantic
proposed log message that lists the findings for each and all casts
that are removed?  Somewhere in between, perhaps split along the
file boundary, or grouped by the event that made them unneeded
(e.g. "cmd_main() used to take non-const but when we made it to take
const, all of these casts we remove in this patch became unneeded")?

Thanks.



