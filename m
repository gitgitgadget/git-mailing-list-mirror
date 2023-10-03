Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA23E7543E
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 09:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239649AbjJCJic (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 05:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjJCJib (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 05:38:31 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DB09B
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 02:38:27 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 8383A23FB1;
        Tue,  3 Oct 2023 05:38:25 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qnbrF-4Co-00; Tue, 03 Oct 2023 11:38:25 +0200
Date:   Tue, 3 Oct 2023 11:38:25 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] parse-options: use and require int pointer for
 OPT_CMDMODE
Message-ID: <ZRvhEWHWn4nDynD0@ugly>
References: <2d6f3d74-687a-2d40-5c0c-abc396aef80f@web.de>
 <e6d8a291-03de-cfd3-3813-747fc2cad145@web.de>
 <ZQlspgfu7yDW0oTN@ugly>
 <f778bc6f-dbe1-4df6-95ff-c9e9f36a3cc9@web.de>
 <ZQwdsfh1GQX0IOQs@ugly>
 <d9defed8-4e7e-4b84-be3d-57155d973320@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d9defed8-4e7e-4b84-be3d-57155d973320@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 03, 2023 at 10:49:12AM +0200, René Scharfe wrote:
>Am 21.09.23 um 12:40 schrieb Oswald Buddenhagen:
>> On Wed, Sep 20, 2023 at 10:18:10AM +0200, René Scharfe wrote:
>>> If we base it on type size then we're making assumptions that I
>>> find hard to justify.
>>>
>> the only one i can think of is signedness. i think this can be safely
>> ignored as long as we use only small positive integers.
>
>I don't fully understand the pointer-sign warning, so I'm not
>confident enough to silence it.
>
in theory, differently signed integers may have completely different 
binary representations. but afaik, that only ever mattered for negative 
numbers. and c++20 actually codifies two's complement, which was the 
de-facto standard for decades already.
so in practice it just means that we may be assigning a value that is 
outside the range of the actual type. but small positive values are 
compatible between signed and unsiged types.

regards
