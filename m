Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CC6D208DB
	for <e@80x24.org>; Thu, 24 Aug 2017 08:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751363AbdHXIRT convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 24 Aug 2017 04:17:19 -0400
Received: from 1.mo64.mail-out.ovh.net ([178.33.109.67]:59304 "EHLO
        1.mo64.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751304AbdHXIQH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2017 04:16:07 -0400
X-Greylist: delayed 4139 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Aug 2017 04:16:06 EDT
Received: from ex2.mail.ovh.net (gw1.ex2.mail.ovh.net [164.132.80.186])
        by mo64.mail-out.ovh.net (Postfix) with ESMTPS id 64CCB8AACC;
        Thu, 24 Aug 2017 10:16:05 +0200 (CEST)
Received: from [10.0.2.127] (86.200.152.136) by EX7.indiv2.local (172.16.2.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 24
 Aug 2017 10:16:04 +0200
Subject: Re: sequencer status
To:     Junio C Hamano <gitster@pobox.com>
CC:     Git Mailing List <git@vger.kernel.org>
References: <8e25c42f-80f2-e0d4-38e4-b4fe9c8074e0@morey-chaisemartin.com>
 <xmqqshgiyxos.fsf@gitster.mtv.corp.google.com>
From:   Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Openpgp: preference=signencrypt
Message-ID: <b34e408e-a302-197a-5abd-d77f9fcaf5ea@morey-chaisemartin.com>
Date:   Thu, 24 Aug 2017 10:16:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:56.0) Gecko/20100101
 Thunderbird/56.0
MIME-Version: 1.0
In-Reply-To: <xmqqshgiyxos.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Language: fr-xx-classique+reforme1990
X-Originating-IP: [86.200.152.136]
X-ClientProxiedBy: CAS3.indiv2.local (172.16.1.3) To EX7.indiv2.local
 (172.16.2.7)
X-Ovh-Tracer-Id: 10035427348795221981
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeelledrtdeggddtfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Le 23/08/2017 à 19:57, Junio C Hamano a écrit :
> Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com> writes:
>
>> Two questions:
>> - Could this be a candidate for contrib/ ?
>> - Would it be interesting to add the relevant code to sequencer.c
>> so that all sequencer based commands could have a --status option
> I actually think we would want a "git sequencer" command, which can
> be fed an arbitrary instruction sheet created by a third-party and
> told to "run" it.  A new command $cmd that wants to rewrite history
> (like "rebase -i", "cherry-pick A..B", etc. do) can only concentrate
> on preparing the sequence of instructions and then internally invoke
> "git sequencer run" until it gives the control back to the end user.
> When the user tells $cmd to continue, it can relay that request to
> "git sequencer continue" under the hood.  
> Once its use is established, it might be even possible to let users
> run "git sequencer continue", bypassing frontends for individual
> commands, e.g. "git cherry-pick --continue", etc., but I do not know
> if that is generally a good idea or not.  In any case, having such a
> front-end will help third-party scripts that want to build a custom
> workflow using the sequecing machinery we have.
>
> And in such a world, we would need "git sequencer status" command
> to give us where in a larger sequence of instrutions we are.  
>
> So I tend to think this should be part of the core, not contrib/,
> and should become part of a new command "git sequencer".

I like your idea. I'm not sure I have the bandwidth to do this (by myself at least).
If someone (hopefully more familiar with the sequencer code than me) wants to work on this, I'd gladly help.

Nicolas



