Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2CAE1F597
	for <e@80x24.org>; Thu, 19 Jul 2018 09:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730049AbeGSKDM (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 06:03:12 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:43811 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbeGSKDL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 06:03:11 -0400
Received: from [192.168.2.201] ([92.22.19.104])
        by smtp.talktalk.net with SMTP
        id g57Gf2X34oI6Lg57GfnWRh; Thu, 19 Jul 2018 10:20:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1531992056;
        bh=5QcU9A/PQWPJSK9Xz9s2Xa5qyt/yHMjqxkSaREwh9Bc=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=B2uEiGgIpMr9a/zAKcGO9AtlnDvUISttKWkP9UgmpC5t/y2Bubo+dch6C1WwMzciY
         u+ydTUCUgzCdsATWj4/beUXQSsJjUYT1Q9/rASea64Vo14QH1WWPYtSOXmRvUB72z0
         yN7iICUoZ/1dPz+ha8tflmKgtUJMMiPcUA7E9cnQ=
X-Originating-IP: [92.22.19.104]
X-Spam: 0
X-OAuthority: v=2.3 cv=FOE1Odgs c=1 sm=1 tr=0 a=f/8ZdrXn5sPnqdHA06GUHw==:117
 a=f/8ZdrXn5sPnqdHA06GUHw==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=lmC5_LFL7ly8c2_hNEUA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] sequencer.c: terminate the last line of author-script
 properly
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Akinori MUSHA <knu@iDaemons.org>, git@vger.kernel.org
References: <86a7qwpt9g.knu@iDaemons.org>
 <xmqqwou0xtar.fsf@gitster-ct.c.googlers.com>
 <eb66f8fb-1535-37a8-526d-ed31f06c045c@talktalk.net>
 <xmqq7elslayl.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <9ecdf160-bc8b-b91d-a70e-ca6fb9d2a756@talktalk.net>
Date:   Thu, 19 Jul 2018 10:20:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqq7elslayl.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfF1r95QqZtAkX2xPt1BMGNHsJmzRgEzYGW2kPYNN2jyqER5YRJCMtRRm9r7lp0yNzVmZ2Km4f5UpT65aWp2tMcjMHvl3esDG6bFFzgss5Ydj4KCWaXLU
 2u5kra/4jQGXh5+1VOdcHj1mgIEiwyhl09gRmuvDaI0hzg+bwOS0htTAZTQOPrqIlr3ZugtCOOW5rDAE/frzLG+XAqwbRVvdeqsAcKiJs4aufBDRpIetdw4T
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 18/07/18 18:17, Junio C Hamano wrote:
> Phillip Wood <phillip.wood@talktalk.net> writes:
> 
>>> (I think we had code to do so in "git am"
>>> that was rewritten in C first).
>>
>> The code in builtin/am.c doesn't try to write valid posix shell (if
>> one assumes it is the only consumer of the author script then it
>> doesn't need to) which results in simpler code, but external scripts
>> cannot safely eval it anymore.
> 
> Are you sure about that? If so we probably should see if we can fix> the writer, and better yet, if we can share code with the writer
> discussed here, as presumably we are fixing it in this thread.
> 
> But I do not see how builtin/am.c::write_author_script() would
> produce something that would not eval correctly.  sq_quote_buf() was
> introduced specifically to write correct string for shell's
> consumption.

You're right, I'm not sure how I missed the calls to sq_quote_buf()
yesterday, sharing the am code with the sequencer would clean things up
nicely.

Best Wishes

Phillip

