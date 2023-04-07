Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF83AC6FD1D
	for <git@archiver.kernel.org>; Fri,  7 Apr 2023 10:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjDGK5F (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Apr 2023 06:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239661AbjDGK4t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2023 06:56:49 -0400
X-Greylist: delayed 44420 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 07 Apr 2023 03:56:06 PDT
Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B2F9EC1
        for <git@vger.kernel.org>; Fri,  7 Apr 2023 03:56:06 -0700 (PDT)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4PtFf84lBZz5tlD;
        Fri,  7 Apr 2023 12:56:00 +0200 (CEST)
Message-ID: <a548ca26-2766-1a95-4928-c22063d5d890@kdbg.org>
Date:   Fri, 7 Apr 2023 12:56:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] userdiff: support regexec(3) with multi-byte support
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Diomidis Spinellis <dds@aueb.gr>,
        Eric Sunshine <sunshine@sunshineco.com>,
        demerphq <demerphq@gmail.com>,
        Mario Grgic <mario_grgic@hotmail.com>,
        "D. Ben Knoble" <ben.knoble@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <CAPig+cSNmws2b7f7aRA2C56kvQYG3w_g+KhYdqhtmf+XhtAMhQ@mail.gmail.com>
 <b45bf46f-580a-870c-5293-10ecdf2e56d3@aueb.gr>
 <b8b3777b-ee6e-d90e-3365-5cb9c9d129fe@web.de>
 <c4728fac-bea9-3794-077e-c978d99f46bf@web.de> <xmqq5yad7wv3.fsf@gitster.g>
 <bc6e89c9-d886-c519-85b3-fbc3f4eb5528@web.de>
 <7327ac06-d5da-ec53-543e-78e7729e78bb@web.de>
 <7fe0aa93-a764-66b0-5015-2f5fbd3901ab@kdbg.org>
 <39eb2a9f-83e0-449e-1157-152c43d49b48@web.de>
Content-Language: en-US
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <39eb2a9f-83e0-449e-1157-152c43d49b48@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.04.23 um 09:49 schrieb René Scharfe:
> Am 07.04.23 um 00:35 schrieb Johannes Sixt:
>> This is not equivalent. The original treated a sequence of non-ASCII
>> characters as a word. The new version treats each individual non-space
>> character (both ASCII and non-ASCII) as a word.
> 
> I assume you mean "The original treated [a single non-space as well as]
> a sequence of non-ASCII characters [making up a single multi-byte
> character] as a word.".  That works as intended by 664d44ee7f (userdiff:
> simplify word-diff safeguard, 2011-01-11).

I misread the original RE. I thought it would lump multiple multi-byte
characters together into one word, but it does not; sorry for that. It
looks like your suggested replacement is behaviorally identical to the
original after all, except perhaps for this one:

> The new one doesn't match multi-byte whitespace anymore.

but I did not find a reference that confirms it. I don't think we need
to bend over backwards to keep this compatibility, though.

-- Hannes

