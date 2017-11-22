Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E23720954
	for <e@80x24.org>; Wed, 22 Nov 2017 21:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751470AbdKVV4k (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 16:56:40 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:40822 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751303AbdKVV4j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 16:56:39 -0500
Received: by mail-it0-f68.google.com with SMTP id 72so8077432itl.5
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 13:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6k060ccPiyMZ1vjlSl5AAII7sO9ETIN+yKOzycGhPF4=;
        b=oSuahd6v76dcZVncB1LPTBfQegzW01WlmFiMPEGMjVHNvd180rtCoZkb8vblZeFPKp
         SmYq5YcmL3LDDuBJg2Xs/F7+sUAltgbJsjI7PwVOG2yGHqDcO6XIkHVfmQ3OLUa4kgRe
         0m6MFd/yEU/qui3OENDtc+CK93wZWtwJALKBW0iYBuk964hLPB6DImc/pp3/wRFWPuf+
         tjw7gpM8WxfEl4o6dhj44MCiznQbDzCJHxKz1t9n9kXhJWIVUCLBqSCAqMOCwbGNdRKJ
         56oWQZHc3PtzW4L0X/ZZ5SbhpZNGV9CjUfjhFkLKy9PNsImsOVshi0WoGFJJsjzcRTmM
         YA9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6k060ccPiyMZ1vjlSl5AAII7sO9ETIN+yKOzycGhPF4=;
        b=hMHQf18uUGfjg9E3SPcyreoB8qy95nKqxkfDXSqAnpO7D/I9ApcLpB0FERGgpnP7O8
         dyG7yJOL7vB/oCs/ejUXm3x30nGT1wPISGSIEL82xN/6SMgKwdv1SZGNyAFyDnsYraDI
         2ebGnosI1CxPLS+kAey8+Pbr+UWu0ANPuZ2Bf6l+BeI5f6QjpG8KR/okwY9i0zTkJ/Zu
         IyTMqAAyEE2OwvKmcvj5M0JicsGrIQ6iTB4C7VgD0DqbFOGe7ObLPtzSBJ2Hkx+3xzaj
         Zw8vXzwiHBR83Z/1fABuKhz+7YNyKSIwR08dRaI6i0KGmLLQ4vFmnU7bcFMb8IsG+BRz
         xuJw==
X-Gm-Message-State: AJaThX5rgEQwQA0b9cT94g4OHucBgWNvkNZNE2Csudnir39WV6eVX82I
        DoeesAcuNoeEB1igXuETy9c=
X-Google-Smtp-Source: AGs4zMabiL2dmSXq8yURFlBMqab1sG6bq8hlZyNTkOkjslPtrAQVpb8bszQsWxb8/vTcWnb1uZJmiw==
X-Received: by 10.36.249.134 with SMTP id l128mr9041658ith.12.1511387798607;
        Wed, 22 Nov 2017 13:56:38 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id 97sm6406475ioh.22.2017.11.22.13.56.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Nov 2017 13:56:37 -0800 (PST)
Date:   Wed, 22 Nov 2017 13:56:35 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Nathan Neulinger <nneul@neulinger.org>,
        Santiago Torres <santiago@nyu.edu>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: git status always modifies index?
Message-ID: <20171122215635.GE11671@aiede.mtv.corp.google.com>
References: <a039d139-dba5-683e-afbf-4044cd32ab1d@neulinger.org>
 <20171122153028.olssotkcf3dd6ron@LykOS.localdomain>
 <5050d779-2981-6f06-49f7-0ecb4efb25b8@neulinger.org>
 <20171122161014.djkdygmclk227xmq@LykOS.localdomain>
 <dfbf4af3-e87c-bdcb-7544-685572925a50@neulinger.org>
 <20171122202720.GD11671@aiede.mtv.corp.google.com>
 <20171122211729.GA2854@sigill>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171122211729.GA2854@sigill>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Wed, Nov 22, 2017 at 12:27:20PM -0800, Jonathan Nieder wrote:

>> That said, I wonder if this use case is an illustration that a name
>> like --no-lock-index (as was used in Git for Windows when this feature
>> first appeared) or --no-refresh-on-disk-index (sorry, I am terrible at
>> coming up with option names) would make the feature easier to
>> discover.
[...]
>         Or maybe just living with the minor philosophical rough edges,
> since it seems OK in practice.

To be clear, my concern is not philosophical but practical: I'm saying
if it's a "git status" option (or at least shows up in the "git
status" manpage) and it is memorably about $GIT_DIR/index (at least
mentions that in its description) then it is more likely to help
people.

Thanks,
Jonathan
