Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D45C636D3
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 21:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjBIVqH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Feb 2023 16:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjBIVqG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2023 16:46:06 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3785FB57
        for <git@vger.kernel.org>; Thu,  9 Feb 2023 13:46:05 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id rm7-20020a17090b3ec700b0022c05558d22so3626420pjb.5
        for <git@vger.kernel.org>; Thu, 09 Feb 2023 13:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jfRea0JkISD4haIqkaqPBRZJY4HWHYD5fH4wqoqIQVY=;
        b=MhL97ij8wwZtMp9/uEWumiMazAAzw0zcfnOp2Q8Cd4b+dZJ0OeqRwKIVFG8x6LY5Tv
         5ZuPHEsguF1TByjMroDl9SQjZy4klUtBLcFtOo4brscKqloJHmsCO4uelHw0POrlMXSN
         WSL0MIDfCh2ZIYu0UrDAlwGoIGiju2/vhspNCuHM8cfB/f7HrFgBVloyQ8h+CqEewkUd
         fpJEdN1sPnxSvHZMIDjGVGk1QOSeFO03RiAM1yy3xIMB6wurC8tuPXQn2AsYKBOLR9bF
         PBpXCfhE4DsIu+xK9gVPjGGVjGzLN51IPxEL54mw9UNRtDub3coA17eT2PskT6zeIQtf
         VPVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jfRea0JkISD4haIqkaqPBRZJY4HWHYD5fH4wqoqIQVY=;
        b=kWNmhmw/eXyN3UxgJHgiRJdVIbTC8a2ZrghpNiPDJlXXUYPG/+3NL2RYRpjmtrR/Z+
         278fZZPGvc3Wjml/nA7eShq39RJbMofS0LHfGW24G+Hl2W1U9eJ6++Us2kibXKzX7gsD
         IgvwklouMdf04baTlxZFSUliIVic80FkeOw451L8TA0716JU8KLQxuH5vGGH8I65Fi1+
         CWCkelREk43IhkuXySqtgpd6a5pUj+0vMDJKGFWMAtlLumbExL0xj0L3wnmF7aXs944s
         icysGGpsInHI6kbdzsw2O1SEMnDjKaA/FOhYSoiBCNhXV9O8iiwabvdG8xhGOKHQr0/d
         WaCA==
X-Gm-Message-State: AO0yUKWY0MVvzuHBKZcCMnva9vbgvW8RD612ON7ZGjbHkRmg1YcxXl3v
        CqH2S4BTMHz2/lir1IuyZ672zN7HEXY=
X-Google-Smtp-Source: AK7set85IkwSacVkXOSzUvNaoDN9ibjMtGKGFNtoY0in5sg2pW5wqznVLvWi8S6bsPJFNl/YPRyp/w==
X-Received: by 2002:a17:902:da8b:b0:199:1804:248a with SMTP id j11-20020a170902da8b00b001991804248amr3605743plx.5.1675979164875;
        Thu, 09 Feb 2023 13:46:04 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id u19-20020a170902a61300b00198ff118fd3sm1975503plq.101.2023.02.09.13.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 13:46:04 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        git@vger.kernel.org
Subject: Re: The sad state of git.wiki.kernel.org
References: <20230203182255.lqla3hsme6riy4w7@meerkat.local>
        <Y95BEaOGJy9uBHkG@coredump.intra.peff.net>
        <CAP8UFD1q7-XbX4C_NjyL7A-6n6Nc4MgSbUKnzQOiRyKRMtLv_w@mail.gmail.com>
        <20230206214101.fe6rismtfzv4k75n@meerkat.local>
        <Y+KT9pHivnUyyu0K@coredump.intra.peff.net>
        <20230209213118.lhyjdndhs5ouk36w@meerkat.local>
Date:   Thu, 09 Feb 2023 13:46:04 -0800
In-Reply-To: <20230209213118.lhyjdndhs5ouk36w@meerkat.local> (Konstantin
        Ryabitsev's message of "Thu, 9 Feb 2023 16:31:18 -0500")
Message-ID: <xmqqy1p6ldgj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:

> On Tue, Feb 07, 2023 at 01:09:58PM -0500, Jeff King wrote:
>> > Okay, here's what I have:
>> > 
>> > https://archive.kernel.org/oldwiki/git.wiki.kernel.org/
>> > 
>> > It's just a static scrape excluding all Special: and User: pages, and carrying
>> > a very large "OBSOLETE CONTENT" warning.
>> 
>> That looks just fine to me. Thanks for taking care of this!
>
> This is now done. Thank you, everyone.
> The git.wiki.kernel.org site is now permanently archived.

Thanks.
