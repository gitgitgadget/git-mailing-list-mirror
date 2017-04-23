Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09AF2207D6
	for <e@80x24.org>; Sun, 23 Apr 2017 07:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1044215AbdDWH11 (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Apr 2017 03:27:27 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:48632 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1044175AbdDWH10 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Apr 2017 03:27:26 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3w9gzJ41Xgz5tl9;
        Sun, 23 Apr 2017 09:27:24 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id DDC4F3A5;
        Sun, 23 Apr 2017 09:27:23 +0200 (CEST)
Subject: Re: [PATCH] archive-zip: Add zip64 headers when file size is too
 large for 32 bits
To:     Peter Krefting <peter@softwolves.pp.se>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
References: <3C736801-6BB8-41CC-88FF-C42FC853A736@blackthorn-media.com>
 <alpine.DEB.2.11.1704222019420.12779@perkele.intern.softwolves.pp.se>
 <37eb7c14-eb61-7a63-bdf0-ee1ccf40723f@kdbg.org>
 <04ad7a06-969d-ffa5-b792-ccc1e7e45fd2@web.de>
 <alpine.DEB.2.11.1704230737380.29888@perkele.intern.softwolves.pp.se>
Cc:     git@vger.kernel.org, Keith Goldfarb <keith@blackthorn-media.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <daa66f7e-b77e-3a27-a6f1-7d9059ab71b7@kdbg.org>
Date:   Sun, 23 Apr 2017 09:27:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.11.1704230737380.29888@perkele.intern.softwolves.pp.se>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.04.2017 um 08:42 schrieb Peter Krefting:
> René Scharfe:
>> The offset is only needed in the ZIP64 extra record for the central
>> header (in zip_dir) -- the local header has no offset field.

Good point.

> The zip64 local header does have an offset field, though. I thought that
> was the zip_offset value, but that doesn't make sense, I'm not quite
> sure what it is supposed to store. I need to investigate that further, I
> assume.

Let's get the naming straight: There is no "zip64 local header". There 
is a "zip64 extra record" for the "zip local header". The zip64 extra 
data record has an offset field, but since the local header does not 
have an offset field, the offset field in the corresponding zip64 extra 
data record is always omitted.

-- Hannes

