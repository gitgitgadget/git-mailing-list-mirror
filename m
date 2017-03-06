Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FFF520133
	for <e@80x24.org>; Mon,  6 Mar 2017 13:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932191AbdCFNrV (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 08:47:21 -0500
Received: from mail-io0-f180.google.com ([209.85.223.180]:35383 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932133AbdCFNq2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 08:46:28 -0500
Received: by mail-io0-f180.google.com with SMTP id z13so68882317iof.2
        for <git@vger.kernel.org>; Mon, 06 Mar 2017 05:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Cmn7Jpqd/3/44jMKjEqUCfFzzGx8HmewbEGXJP1+C4Q=;
        b=dSUaepusAoJHDkDjK8TALzfw05agOvbpxorcpypb+pDo9+ZgmPhg0MBzaF/38EGL3r
         tu8Zd8iiWcFl2730NkUEiuFjq3bdnIIPDFj7eUGMxp6KbEbrjxA5NOdebYy91ICi1HDI
         NT7LjXQcsH9JNeaHN7fzREi7veOYqjLCL7ek+bUVT2Ch0hpUMj+ynSjcUdM8THKj80Nc
         TwWdGR740e9/V1ZVEiVKIl8dBLkJzGSK8U83hN9+JlRCJ8pFtEkSZEgSTWK12Iu9f/AF
         C/yDNGvzKAgMCka4Sj4XVdQcGsNp93QuIAPAcqvhxkeQsC1qoMcMgG8PWuI+HLxeqvhr
         tpsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Cmn7Jpqd/3/44jMKjEqUCfFzzGx8HmewbEGXJP1+C4Q=;
        b=dFGQklP1POzoL2I8NZiJwEG4bXmYJAgloZqjqhi7l0MC8Uy9NISa4y/TbpEMoWB8ig
         sU2zcVoGiNMPEzjezM9q5nXkQ5j9/6kLsRRi00GOQ9x14rg5lOuEJj+ydwP35sC4Huj4
         MwCypzeQYcDYBGaCc+U1DPl9nzNLXmfUuD/xi/Sv5OOHwlIMAO4NxLiAk1hiGMGn1x9b
         +fPxDN6FVuUmDLhqyZJlFE1qLKTZq79KqgagDMaanz6WNSq9KnGJRn8oJH9pEdNrCCuc
         LAdYwYDwFLEhc5ZUfiEfZ/lfC7LVQ6lU+1IyLK50rUS5LMUC1Mm66/yICJu8vPwuUfEX
         +q+A==
X-Gm-Message-State: AMke39lcDTBVnEoPvNykIl3lcMU4cWh4ss1da4wCjkKP8N3tcUFxCC/f6yU+Iw/MslYs3g==
X-Received: by 10.107.30.213 with SMTP id e204mr1092206ioe.203.1488807403240;
        Mon, 06 Mar 2017 05:36:43 -0800 (PST)
Received: from [10.3.3.214] ([199.227.34.94])
        by smtp.gmail.com with ESMTPSA id y124sm4870348itd.19.2017.03.06.05.36.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Mar 2017 05:36:42 -0800 (PST)
Subject: Re: Delta compression not so effective
To:     Linus Torvalds <torvalds@linux-foundation.org>
References: <4d2a1852-8c84-2869-78ad-3c863f6dcaf7@gmail.com>
 <CA+55aFzQ0o2R2kShS=AuKu0TLnfPV-0JCkViqx5J_afCK0Yt5g@mail.gmail.com>
 <eba83461-34cf-6d64-4013-873b04af9b82@gmail.com>
 <CA+55aFx7QFqrHw4e72vOdM5z0rw1CCkL2-UX8ej5CLSBWjLNLA@mail.gmail.com>
 <603afdf2-159c-6bed-0e85-2824391185d1@gmail.com>
 <CA+55aFxxQUixAJWXkUgVvDNCHD4LuYYuQRTE7dJ_OZTo9Gxqew@mail.gmail.com>
 <9961a973-0d5d-5ff9-ab78-eea07bdb5dbf@gmail.com>
 <CA+55aFw=U4PbfvVzeyuWk2VOsgicZRRKZRkrGp7jr_ppvgP3ng@mail.gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
From:   Marius Storm-Olsen <mstormo@gmail.com>
Message-ID: <ef0b90a6-4386-7479-b56b-acfe34989bda@gmail.com>
Date:   Mon, 6 Mar 2017 07:36:45 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <CA+55aFw=U4PbfvVzeyuWk2VOsgicZRRKZRkrGp7jr_ppvgP3ng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/5/2017 19:14, Linus Torvalds wrote:
> On Sat, Mar 4, 2017 at 12:27 AM, Marius Storm-Olsen <mstormo@gmail.com> wrote:
> I guess you could do the printout a bit earlier (on the
> "to_pack.objects[]" array - to_pack.nr_objects is the count there).
> That should show all of them. But the small objects shouldn't matter.
>
> But if you have a file like
>
>    extern/win/FlammableV3/x64/lib/FlameProxyLibD.lib
>
> I would have assumed that it has a size that is > 50. Unless those
> "extern" things are placeholders?

No placeholders, the FlameProxyLibD.lib is a debug lib, and probably the 
largest in the whole repo (with a replace count > 5).


> I do wonder if your dll data just simply is absolutely horrible for
> xdelta. We've also limited the delta finding a bit, simply because it
> had some O(m*n) behavior that gets very expensive on some patterns.
> Maybe your blobs trigger some of those case.

Ok, but given that the SVN delta compression, which forward-linear only, 
is ~45% better, perhaps that particular search could be done fairly 
cheap? Although, I bet time(stamps) are out of the loop at that point, 
so it's not a factor anymore. Even if it where, I'm not sure it would 
solve anything, if there's other factors also limiting deltafication.


> The diff-delta work all goes back to 2005 and 2006, so it's a long time ago.
>
> What I'd ask you to do is try to find if you could make a reposity of
> just one of the bigger DLL's with its history, particularly if you can
> find some that you don't think is _that_ sensitive.
>
> Looking at it, for example, I see that you have that file
>
>    extern/redhat-5/FlammableV3/x64/plugins/libFlameCUDA-3.0.703.so
>
> that seems to have changed several times, and is a largish blob. Could
> you try creating a repository with git fast-import that *only*
> contains that file (or pick another one), and see if that delta's
> well?

I'll filter-branch to extern/ only, however the whole FlammableV3 needs 
to go too, I'm afaid (extern for that project, but internal to $WORK).
I'll do some rewrites and see what comes up.

> And if you find some case that doesn't xdelta well, and that you feel
> you could make available outside, we could have a test-case...

I'll try with this repo first, if not, I'll see if I can construct one.

Thanks!


-- 
.marius
