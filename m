Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93BA31F453
	for <e@80x24.org>; Wed, 20 Feb 2019 09:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfBTJml (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Feb 2019 04:42:41 -0500
Received: from smtpout11.ifi.lmu.de ([141.84.214.246]:39218 "EHLO
        smtpout11.ifi.lmu.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfBTJml (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Feb 2019 04:42:41 -0500
X-Greylist: delayed 347 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Feb 2019 04:42:40 EST
Received: from empusa.suse (unknown [IPv6:2001:4ca0:0:f235:8219:34ff:feb1:d00f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jost.steffen.tcs)
        by smtpin1.ifi.lmu.de (Postfix) with ESMTPSA id 0D1771D90DF;
        Wed, 20 Feb 2019 10:36:52 +0100 (CET)
Subject: Re: [PATCH 1/1] Introduce "precious" file concept
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Per Lundberg <per.lundberg@hibox.tv>,
        Joshua Jensen <jjensen@workspacewhiz.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Clemens Buchacher <drizzd@gmx.net>,
        Holger Hellmuth <hellmuth@ira.uka.de>,
        Kevin Ballard <kevin@sb.org>
References: <20190216114938.18843-1-pclouds@gmail.com>
 <20190216114938.18843-2-pclouds@gmail.com>
 <87wolzo7a1.fsf@evledraar.gmail.com>
 <CACsJy8CR7VGp7htC_wKC9BUCaQsmkp5Zd4+M7bddPL-jKyfDMQ@mail.gmail.com>
 <xmqq8syb3b3j.fsf@gitster-ct.c.googlers.com>
 <87h8cy6cme.fsf@evledraar.booking.com>
From:   Steffen Jost <jost@tcs.ifi.lmu.de>
Organization: LMU Munich
X-Tagtoolbar-Keys: D20190220103651747
Message-ID: <6c40dcc2-5ef1-7cfb-858d-029b72fa3709@tcs.ifi.lmu.de>
Date:   Wed, 20 Feb 2019 10:36:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <87h8cy6cme.fsf@evledraar.booking.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20.02.19 10:19, Ævar Arnfjörð Bjarmason wrote:
> Most git users are at the level of only knowing very basic
> add/commit/pull/push command interaction. I feel strongly that we need
> to make our tools safe to use by default, and not require some
> relatively advanced "precious"/attribute facility to be carefully
> configured in advance so we don't throw away uncommitted work on the
> likes of merge/checkout.
> 
> 1. https://public-inbox.org/git/87zhuf3gs0.fsf@evledraar.gmail.com/
> 2. https://public-inbox.org/git/871s7r4wuv.fsf@evledraar.gmail.com/
> 

+1
Please consider that silently deleting files is a no-go.

I teach computer science, and our switch from subversion to git for our second year programming projects caused a lot of grief, so much that my colleagues consider switching back to subversion as the point of first contact with revisioning.

Silently deleting partially revisioned files is a major source: students regularly destroy IDE or OS specific config files that they cannot restore themselves. (Project participants use all kinds of different IDEs on different OSs and thus have all kinds of weird hidden files that always manage to get checked into the repository, wreaking havoc on another's machine. So they get deleted and thus disturb the student that needed those files.) We do provide a huge .gitignore that ought to prevent this, but despite numerous warnings they only add it later, which then causes previously checked-in files to be lost upon switching between branches.

Please, by default, issue at least a warning before files are irrevocably los - or maybe keep a local snapshot of everything for the last few checkout in order to undo them?


Thanks,
  Steffen.

-- 
+49-89-2180-9139
http://www.tcs.ifi.lmu.de/~jost/

Lehr- und Forschungseinheit für Theoretische Informatik
Ludwig-Maximilians-Universität München
Oettingenstr. 67 (E111)
80538 München
BAVARIA
