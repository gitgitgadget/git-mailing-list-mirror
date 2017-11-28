Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF1E620C11
	for <e@80x24.org>; Tue, 28 Nov 2017 00:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753180AbdK1Act (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 19:32:49 -0500
Received: from mail.zeus.flokli.de ([88.198.15.28]:57496 "EHLO zeus.flokli.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753285AbdK1Act (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 19:32:49 -0500
Received: from localhost (unknown [185.104.140.104])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: flokli@flokli.de)
        by zeus.flokli.de (Postfix) with ESMTPSA id 326DC390C48;
        Tue, 28 Nov 2017 00:32:47 +0000 (UTC)
Date:   Tue, 28 Nov 2017 01:32:35 +0100
From:   Florian Klink <flokli@flokli.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH] git-send-email: honor $PATH
Message-ID: <20171128003235.vbu3afu5junfebg7@tp.flokli.de>
References: <20171118124249.26479-1-flokli@flokli.de>
 <20171118210109.ttp7bnihi3xb4xvs@genre.crustytoothpaste.net>
 <xmqqd14foz7p.fsf@gitster.mtv.corp.google.com>
 <20171119123511.pck5aqak4yyc6367@tp.flokli.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20171119123511.pck5aqak4yyc6367@tp.flokli.de>
User-Agent: NeoMutt/20171027
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>Support to detect sendmail binaries in windows' PATH seems a bit more complex.
>The separator is different, and PATHEXT would need to be considered too.  I'm
>not even sure if having a sendmail binary in PATH on windows is something usual
>or if defaulting to smtp to localhost (what we currently do) is good enough (tm).
>If we want to start parsing PATH under windows too, I'd suggest to use
>File::Which instead of implementing it on our own.
>
>>I would feel a lot more worried about trying elements on the $PATH
>>first and then using the two standard places as fallback.  If the
>>order of addition matters at all, that would mean that trying
>>elements on $PATH first and then falling back to the two standard
>>places *will* change the behaviour---for the affected users, we used
>>to pick one of these two, but now we would pick something different.
>>sendmail is usually installed out of the way of $PATH for regular
>>users for a reason, so picking anything whose name happens to be
>>sendmail that is on $PATH does not sound right.
>>
>>Of course, for users who do not have sendmail at one of the two
>>standard places _and_ has one on one of the directories on $PATH,
>>the order in which we check would not make a difference, so my
>>suggestion would be to do the other way around.
>
>I could happily provide a patch that does it the other way round, too. But let's
>first decide on what to do with windows ;-)

Seems like there is not really much of motivation to try better in detecting
sendmail binaries in PATH on windows ;-)

Will send patch v3, which reverses the order as suggested by Junio shortly.

-- 
Florian
