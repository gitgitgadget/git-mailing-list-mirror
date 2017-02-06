Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E35AC1FAFC
	for <e@80x24.org>; Mon,  6 Feb 2017 16:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751663AbdBFQzA convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 6 Feb 2017 11:55:00 -0500
Received: from zimbra-vnc.tngtech.com ([83.144.240.98]:36494 "EHLO
        proxy.tng.vnc.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751164AbdBFQy7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2017 11:54:59 -0500
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 5CD311E2C99;
        Mon,  6 Feb 2017 17:54:56 +0100 (CET)
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id VovDUKSq7mUU; Mon,  6 Feb 2017 17:54:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id D600C1E2F24;
        Mon,  6 Feb 2017 17:54:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id JnlP-x3wpccq; Mon,  6 Feb 2017 17:54:55 +0100 (CET)
Received: from [192.168.178.78] (46.128.140.114.dynamic.cablesurf.de [46.128.140.114])
        by proxy.tng.vnc.biz (Postfix) with ESMTPSA id 765F81E2C99;
        Mon,  6 Feb 2017 17:54:55 +0100 (CET)
Subject: Re: [PATCH] tag: generate useful reflog message
To:     Junio C Hamano <gitster@pobox.com>
References: <20170205214254.24560-1-cornelius.weig@tngtech.com>
 <xmqqo9yg43uo.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, bitte.keine.werbung.einwerfen@googlemail.com,
        karthik.188@gmail.com, peff@peff.net
From:   Cornelius Weig <cornelius.weig@tngtech.com>
Message-ID: <dad6002e-a31c-3be6-3141-2e9e678742b1@tngtech.com>
Date:   Mon, 6 Feb 2017 17:54:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqo9yg43uo.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 02/06/2017 12:25 AM, Junio C Hamano wrote:
> cornelius.weig@tngtech.com writes
> For a tag, I would imagine something like "tag: tagged 4e59582ff7
> ("Seventh batch for 2.12", 2017-01-23)" would be more appropriate.

Yes, I agree that this is much clearer. The revised version v3
implements this behavior.

>> Notes:
>>     While playing around with tag reflogs I also found a bug that was present
>>     before this patch. It manifests itself when the sha1-ref in the reflog does not
>>     point to a commit object but something else.
> 
> I think the fix would involve first ripping out the "reflog walking"
> code that was bolted on and stop allowing it to inject the entries
> taken from the reflog into the "walk the commit DAG" machinery.
> Then "reflog walking" code needs to be taught to have its own "now
> we got a single object to show, show it (using the helper functions
> to show a single object that is already used by 'git show')" code,
> instead of piggy-backing on the output codepath used by "log" and
> "rev-list".

I'll start investigating how that could be done. My first glance tells
me that it won't be easy. Especially because I'm not yet familiar with
the git code.

Thanks for your advice!
