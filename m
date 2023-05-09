Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF18C7EE22
	for <git@archiver.kernel.org>; Tue,  9 May 2023 10:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235293AbjEIKcc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 06:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235261AbjEIKc3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 06:32:29 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10443C32
        for <git@vger.kernel.org>; Tue,  9 May 2023 03:32:15 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 0988C20010;
        Tue,  9 May 2023 06:32:14 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1pwKdh-hNZ-00; Tue, 09 May 2023 12:32:13 +0200
Date:   Tue, 9 May 2023 12:32:13 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org, Adam Majer <adamm@zombino.com>
Subject: Re: Is GIT_DEFAULT_HASH flawed?
Message-ID: <ZFohLeq1AfdVKqfY@ugly>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org, Adam Majer <adamm@zombino.com>
References: <ZEmMUFR7AJn+v7jV@tapette.crustytoothpaste.net>
 <20230426205324.326501-1-sandals@crustytoothpaste.net>
 <20230426205324.326501-3-sandals@crustytoothpaste.net>
 <xmqqbkjaqqfp.fsf@gitster.g>
 <20230427054343.GE982277@coredump.intra.peff.net>
 <6451a0ba5c3fb_200ae2945b@chronos.notmuch>
 <ZFLmGYXgvyydLB5E@tapette.crustytoothpaste.net>
 <645857d8e8fd7_4e6129477@chronos.notmuch>
 <ZFlr8PWOPRuLuP6E@tapette.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZFlr8PWOPRuLuP6E@tapette.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 08, 2023 at 09:38:56PM +0000, brian m. carlson wrote:
>On 2023-05-08 at 02:00:56, Felipe Contreras wrote:
>> brian m. carlson wrote:
>> > On 2023-05-02 at 23:46:02, Felipe Contreras wrote:
>> > > In my view one repository should be able to have part SHA-1 history,
>> > > part SHA3-256 history, and part BLAKE2b history.
>> > 
>> > That is practically very difficult and it means that it's hard to have
>> > confidence in the later history because SHA-1 is weak and you have to
>> > rely on it to verify the SHA-256 history later.
>> 
>> Why would I have to rely on SHA-1 to verify the SHA-256 history later
>> on?
>
>If your history contains mixed and matched hash algorithms, you'll need
>to be able to verify those commits to the root to have any confidence in
>a signed commit or tag, which means trusting SHA-1 if you have any SHA-1
>commits in the repository.
>
the history is traversed from the end anyway, so having sha-1 in the 
history is entirely irrelevant for verifying sha-256 commits, assuming 
one may only upgrade the algorithm.

the transition plan implies the intent to ultimately get rid of old 
algos, but this is a non-starter, because old histories need to remain 
accessible indefinitely (you can't rewrite all external references, and 
even for in-history references this would be unreliable and would 
falsify historical builds).

i won't try making an argument for mixed histories, as i'm assuming i 
wouldn't add anything that hasn't already been written.

-- ossi
