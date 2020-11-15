Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83949C2D0E4
	for <git@archiver.kernel.org>; Sun, 15 Nov 2020 14:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4012122314
	for <git@archiver.kernel.org>; Sun, 15 Nov 2020 14:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgKOOnq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Nov 2020 09:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbgKOOnp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Nov 2020 09:43:45 -0500
Received: from wp156.webpack.hosteurope.de (wp156.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:84a3::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA54C0613D1
        for <git@vger.kernel.org>; Sun, 15 Nov 2020 06:43:45 -0800 (PST)
Received: from p5099125b.dip0.t-ipconnect.de ([80.153.18.91] helo=[192.168.100.43]); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1keJFn-0001pC-4d; Sun, 15 Nov 2020 15:43:43 +0100
Subject: Re: [PATCH 0/5] handling 4GB .idx files
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20201113050631.GA744608@coredump.intra.peff.net>
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
Message-ID: <323fd904-a7ee-061d-d846-5da5afbc88b2@virtuell-zuhause.de>
Date:   Sun, 15 Nov 2020 15:43:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201113050631.GA744608@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1605451425;8abdfad1;
X-HE-SMSGID: 1keJFn-0001pC-4d
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13.11.2020 06:06, Jeff King wrote:
> I recently ran into a case where Git could not read the pack it had
> produced via running "git repack". The culprit turned out to be an .idx
> file which crossed the 4GB barrier (in bytes, not number of objects).
> This series fixes the problems I saw, along with similar ones I couldn't
> trigger in practice, and protects the .idx loading code against integer
> overflows that would fool the size checks.

Would it be feasible to have a test case for this large index case? This
should very certainly have an EXPENSIVE tag, or might even not yet work
on windows. But hopefully someday I'll find some more time to push large
object support on windows forward, and these kind of tests would really
help then.
