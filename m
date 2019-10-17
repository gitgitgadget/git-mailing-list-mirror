Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E96001F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 00:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441857AbfJRABs (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 20:01:48 -0400
Received: from smtp81.iad3b.emailsrvr.com ([146.20.161.81]:59537 "EHLO
        smtp81.iad3b.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2441828AbfJRABr (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 17 Oct 2019 20:01:47 -0400
X-Greylist: delayed 481 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Oct 2019 20:01:47 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=g001.emailsrvr.com;
        s=20190322-9u7zjiwi; t=1571356425;
        bh=hnrHhzp+alviO5H2pCYzFeFCSwD4M18lSo49H6U89Mg=;
        h=Subject:To:From:Date:From;
        b=mD5kLEJZpEKys6R3nDGZriMBwjWqgGP7E6/3OR4K3WMNO89aYNjYOay3/bOqDJZro
         +hI4EQK+B7zRQpgvfPbpGy4ipG1FWxuP0MtwJ/9JNMAP4LuCwNERr8sGf/g1d92T3p
         AIG81GnJCtCObCAJE8yD0VyksI1z1Y625tsfMJBw=
X-Auth-ID: jon@jonsimons.org
Received: by smtp19.relay.iad3b.emailsrvr.com (Authenticated sender: jon-AT-jonsimons.org) with ESMTPSA id 198EA40184;
        Thu, 17 Oct 2019 19:53:45 -0400 (EDT)
X-Sender-Id: jon@jonsimons.org
Received: from simonsj-mba2.hsd1.ca.comcast.net (c-73-223-68-105.hsd1.ca.comcast.net [73.223.68.105])
        (using TLSv1.2 with cipher AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Thu, 17 Oct 2019 19:53:45 -0400
Subject: Re: [PATCH v4 00/17] New sparse-checkout builtin and "cone" mode
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     newren@gmail.com, Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.316.v3.git.gitgitgadget@gmail.com>
 <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
From:   Jon Simons <jon@jonsimons.org>
Message-ID: <1ea216d8-e706-ec4c-a3f3-954e57e0458c@jonsimons.org>
Date:   Thu, 17 Oct 2019 16:53:44 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/15/19 6:55 AM, Derrick Stolee via GitGitGadget wrote:
> V4 UPDATE: Rebased on latest master to include ew/hashmap and
> ds/include-exclude in the base.

I did a partial review of the v4 patches out of curiosity and I notice
in sparse-checkout.c there are a couple of unchecked `fopen` call sites
that could be converted to `xfopen` to die gracefully upon error, and
one unchecked `fdopen` that can likewise be `xfdopen`.


-Jon
