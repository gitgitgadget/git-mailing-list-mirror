Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E69C433F5
	for <git@archiver.kernel.org>; Sat,  4 Dec 2021 22:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhLDWvA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Dec 2021 17:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbhLDWu7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Dec 2021 17:50:59 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BD6C061751
        for <git@vger.kernel.org>; Sat,  4 Dec 2021 14:47:33 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id s6so980615ild.9
        for <git@vger.kernel.org>; Sat, 04 Dec 2021 14:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gM0wXxe8KInMLkbTAolIlFi6MmAHclkLWIz92P1ecv0=;
        b=sj/Rf/9r1y1acQEH6RzvcDKujncKkjuEEaId6uYV6Dv8utRiiPyhbKXJoJlplbeMQc
         VDyHheT7VC+cTwTAfHB/HjOZjpT93VDNSHZ5cRYaBqOFhaFUse0jjomsnHn915RV1sQd
         z1byjRRSLG97ii8ACOKq4/+q3Npcd6afHe/WWlrOVgs2NnaqAqaVPjVYpWXwoydtPkvN
         7t/UMLpIaENnRP2IpRRkO4TB4bz15NDYFtnFF1iW3JCI+ta+JXZN4wlzCr1rr+8UT6p5
         Zqo8Am+AcKTbBCDOrFXwcvMdzI8IsIfQLwH5cM9CzwxYGhLoDEqBR17G7wR8iMPvjtu+
         /jdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gM0wXxe8KInMLkbTAolIlFi6MmAHclkLWIz92P1ecv0=;
        b=F3vMmKYyjkc5BtftwCqUVShNHGOCdh6mjD6FODe+DLtytSbFLPdGSGhoYjQy8tvcmA
         blWEaM8zRkrhaK9nsIHMPuSv0skFqL66l+EUI5rb1btfzW3rPnc2X2KVJipEDHFP1sm0
         MNtHf3XBwqL1Z80eooINO9stwuN/2WOhitQm7yLT1ntNvSwqwBcn2PwfL8Yv7w+IBXdF
         SFLW3NJL2zG/5CCvIWemqGn0WsBmv6zjqChDWE9DdTQUmocumUKyB5nmLr/JIL82H1RR
         bgsJWcz8HW0F+wEg9Q9N2r0Vd+GtAgEbtVDWsztaneg8+uEfZ5VAt2H0NpCfnNbxSqgo
         ECrA==
X-Gm-Message-State: AOAM531ypGMHgVQvDq0ob9Q691x4oaAF2dztDEVHyBZtYYLu6o3qH2Cn
        GLQgjsNmYZiixdqyh3Df4bChMkP7wFRATA==
X-Google-Smtp-Source: ABdhPJy2OjlQ4LGhihM7q/NH1yJZwdlup8V+N9n7PQZyIDuD0BPFfGZTaZNx5AVdXxDTj7nuUGOYLA==
X-Received: by 2002:a05:6e02:20e6:: with SMTP id q6mr25220914ilv.316.1638658052986;
        Sat, 04 Dec 2021 14:47:32 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k6sm4221242ilo.40.2021.12.04.14.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 14:47:32 -0800 (PST)
Date:   Sat, 4 Dec 2021 17:47:31 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: static-check hits
Message-ID: <YavwA6WFB3wyO76d@nand.local>
References: <ec008905-5e04-944d-f164-d52a622f0531@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ec008905-5e04-944d-f164-d52a622f0531@ramsayjones.plus.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 04, 2021 at 02:59:15PM +0000, Ramsay Jones wrote:
> Hi Taylor,
>
> Just a quick note about new hits from my 'static-check.pl' script
> caused by the 'tb/cruft-packs' branch. This script notes any symbols
> that are not referenced outside the defining compilation unit.
> (So they could be declared static in that compilation unit).
> Comparing the current 'next' and 'seen' branches:
>
>   $ diff nsc ssc
>   ...
>   62a63,64
>   > pack-mtimes.o	- pack_has_mtimes
>   > packfile.o	- close_pack_mtimes
>   ...
>   $
>
> This is not necessarily a problem, of course, if you have patches/plans
> to add callers in the future (or that they simply 'round out' an API).
> I haven't looked (so can't comment), beyond:

Thanks very much for pointing both of these out. Removing
pack_has_mtimes() entirely is fine with me. I was surprised that it was
unused, since I thought the code setting `is_cruft = 1` in
`add_packed_git()` would have been a potential caller, but that spot
just constructs the path itself and checks the result access()-ing it.

Similarly on close_pack_mtimes(): that was definitely intended to round
out the API (along with close_pack_revindex()), but isn't necessary
outside of packfile.c's compilation unit. We could probably apply the
same treatment to close_pack_revindex(), but I'll pursue that as a
separate matter.

> Also, the function definition of 'close_pack_mtimes()' has the opening
> { of the body on the function header line, rather than by itself on
> the following line.

Copied over from close_pack_revindex(), but fixed. Thanks!

Thanks,
Taylor
