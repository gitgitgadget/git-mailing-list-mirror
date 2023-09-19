Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE27ACD54AB
	for <git@archiver.kernel.org>; Tue, 19 Sep 2023 09:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjISJlG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Sep 2023 05:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbjISJlD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2023 05:41:03 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95285EA
        for <git@vger.kernel.org>; Tue, 19 Sep 2023 02:40:57 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 99107242F0;
        Tue, 19 Sep 2023 05:40:54 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qiXDy-l19-00; Tue, 19 Sep 2023 11:40:54 +0200
Date:   Tue, 19 Sep 2023 11:40:54 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] parse-options: use and require int pointer for
 OPT_CMDMODE
Message-ID: <ZQlspgfu7yDW0oTN@ugly>
References: <2d6f3d74-687a-2d40-5c0c-abc396aef80f@web.de>
 <e6d8a291-03de-cfd3-3813-747fc2cad145@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e6d8a291-03de-cfd3-3813-747fc2cad145@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 09, 2023 at 11:14:20PM +0200, René Scharfe wrote:
>Some uses of OPT_CMDMODE provide a pointer to an enum.  It is
>dereferenced as an int pointer in parse-options.c::get_value().  These
>two types are incompatible, though
>
s/are/may be/ - c.f. https://en.cppreference.com/w/c/language/enum

>-- the storage size of an enum can vary between platforms.
>
here's a completely different perspective:
this is merely a theoretical problem, right? gcc for example won't 
actually use non-ints unless -fshort-enums is supplied. so how about 
simply adding a (configure) test to ensure that there is actually no 
problem, and calling it a day?

regards

