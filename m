Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F6971F453
	for <e@80x24.org>; Tue, 16 Oct 2018 13:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbeJPV3f (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 17:29:35 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:64927 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbeJPV3e (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 17:29:34 -0400
Received: from [192.168.2.240] ([92.26.121.144])
        by smtp.talktalk.net with SMTP
        id CPYpgwwotwhzSCPYqgqRWn; Tue, 16 Oct 2018 14:39:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1539697140;
        bh=cM2y0/fXHGQQdoRzELhEDVNTgZolOH2+5qk/gcJEzvY=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=lhHrX/7cXmOLV+6WUJPPH3nzIuBYiaIJA5GUL7vN8s1aIkp2vPyzWadPxl4FxliDW
         I5PnDYV2ao9CkyrMKlgKpobS82vKKDiRY3/kjrJbeNRPm5pLQ+9CE+JhWZhmkBwkbc
         AK/riWqFoHCaWWYrYh3IMxaEUSfCdVn5Cvl1bmqI=
X-Originating-IP: [92.26.121.144]
X-Spam: 0
X-OAuthority: v=2.3 cv=e8Iot5h/ c=1 sm=1 tr=0 a=AM9PLn0bJgvrHi3wmEITIQ==:117
 a=AM9PLn0bJgvrHi3wmEITIQ==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=MhFL_bMfXVOGNxH4GHwA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: What's cooking in git.git (Oct 2018, #01; Wed, 10)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
References: <xmqq8t36mk4t.fsf@gitster-ct.c.googlers.com>
 <42930bb1-502b-b168-be12-92aee526a258@talktalk.net>
 <xmqqa7nkf6o4.fsf@gitster-ct.c.googlers.com>
 <ca3b162d-d1c6-1ed1-cb20-4232d91f7b51@talktalk.net>
 <xmqqbm7zb81z.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <9521f0a8-efa7-46d7-1aeb-aea700fc2fed@talktalk.net>
Date:   Tue, 16 Oct 2018 14:38:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <xmqqbm7zb81z.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJCQo1CaR3CP79U7L9LBKKkHM/Ub6vU0JIn0iJeOBRUgMK6LJufJgYLb+aYTKgJ5F/5Hs3nYQTVfrDvgt6qpN+L1leEmkjR7Ux55MBw+Xl10ifw0H72S
 dYNrgo3dBnQtAqqpPqhLln3IfWKUBuZjiiLQ4z8E9B6e3KhIT8yvUPuot0cBqiPHo3gnh5Xu1mYUHe0BcT8SLEPkHoD76rnbC/3GR3CMxNF5nMPXYNWnuNOp
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/10/2018 14:36, Junio C Hamano wrote:
> Phillip Wood <phillip.wood@talktalk.net> writes:
> 
>> It would be nice if the parsing used starts_with(option_name, user_text)
>> rather than strcmp() as well. Also I think --color-moved=no is valid as
>> a synonym of --no-color-moved but --color-moved-ws=no is not supported.
> 
> I am not sure about starts_with().  Do you mean we should accept
> "--color-mo", as that is a prefix of "--color-moved" that is not
> shared with any existing option, until we gain a different option
> "--color-more"?

I was thinking of the option arguments rather than the option names 
although being able to abbreviate the names in the same way as the 
commands that parse_options() would be good too (I seem to remember 
someone saying they had some rough patches to use parse_options() for 
diff and log in a discussion of adding completion support to 
parse_options())

> If you mean "--color-moved-ws=no" (or "--no-color-moved-ws") as a
> way to countermand an earlier --color-moved-ws=<something> on the
> command line, I fully agree that it is a good idea.

Oh I assumed --no-color-moved-ws was allowed but it isn't it. Allowing 
--color-moved-ws=no as well would match what is allowed for 
--color-moved. I'll try and look at that.

Best Wishes

Phillip

