Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4797C46CA1
	for <git@archiver.kernel.org>; Mon, 18 Sep 2023 10:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240883AbjIRK2g (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Sep 2023 06:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241165AbjIRK2Y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2023 06:28:24 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A359FD1
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 03:28:18 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 245DD240C7;
        Mon, 18 Sep 2023 06:28:16 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qiBUG-X5l-00; Mon, 18 Sep 2023 12:28:16 +0200
Date:   Mon, 18 Sep 2023 12:28:16 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] parse-options: add int value pointer to struct option
Message-ID: <ZQgmQJvN0phJsFjz@ugly>
References: <2d6f3d74-687a-2d40-5c0c-abc396aef80f@web.de>
 <ZP4NrVeqMtFTLEuf@nand.local>
 <xmqq7cowv7pm.fsf@gitster.g>
 <2349e897-9e0d-4341-86fc-9da117a1eb48@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2349e897-9e0d-4341-86fc-9da117a1eb48@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 18, 2023 at 11:53:19AM +0200, René Scharfe wrote:
>Am 11.09.23 um 21:19 schrieb Junio C Hamano:
>> Yup, that does cross my mind, even though I would have used
>>
>> 	union {
>> 		void *void_ptr;
>> 		int *int_ptr;
>> 	} value;
>>
>> or something without a rather meaningless 'u'.
>
>OK, but I neglected to ask what we would get out of throwing different
>types into the same bin.

>It complicates type safety by making it impossible for the parser to 
>distinguish the used type. [...]
>
this is somewhat ironic, given that using a union has some semantic 
value by illustrating that the fields are mutually exclusive.
but i'm not sure that the checking is really important here, given that 
the initializers are inside centralized macros anyway.

regards
