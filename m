Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 305DE208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 16:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbeHHSYd (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 14:24:33 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:24756 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbeHHSYd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 14:24:33 -0400
Received: from [192.168.2.240] ([92.22.29.155])
        by smtp.talktalk.net with SMTP
        id nQwVfjfPsoI6LnQwVf1Vpt; Wed, 08 Aug 2018 17:04:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1533744252;
        bh=o1Gc3eY4U20gXDDWXZ6eiIAHrWuOEE3OopctaohniZM=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=UjZ4yuOJreBMayqgHia6H0vAan5WKloa5BI4cjaHnTK+QXIw8+NSnvBAT7M/rvXfN
         cYpttrB3oHvGxULCmk8oRAmmLtz64vIlr035IBG0cuOD5yhJF4s6Fb0p9z1VqbM+o9
         rvpVTwlYDDyAFUCp/q9BKQFJ+67Zq2uicLvfwuyU=
X-Originating-IP: [92.22.29.155]
X-Spam: 0
X-OAuthority: v=2.3 cv=FOE1Odgs c=1 sm=1 tr=0 a=yeAZMs3+wWQh+Rh+YWy7CA==:117
 a=yeAZMs3+wWQh+Rh+YWy7CA==:17 a=IkcTkHD0fZMA:10 a=ERDfErdY3h0YzXba3CUA:9
 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH v5 04/20] rebase -i: rewrite the edit-todo
 functionality in C
To:     Alban Gruin <alban.gruin@gmail.com>, phillip.wood@dunelm.org.uk,
        git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        gitster@pobox.com
References: <20180724163221.15201-1-alban.gruin@gmail.com>
 <20180731180003.5421-1-alban.gruin@gmail.com>
 <20180731180003.5421-5-alban.gruin@gmail.com>
 <325fd5d2-2a93-2270-7d1e-394c265f42d4@talktalk.net>
 <6826d318-b0ab-4e8e-e2ba-5425e3bf6f5f@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <75549397-9080-3b5a-8655-cea04065b2eb@talktalk.net>
Date:   Wed, 8 Aug 2018 17:04:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <6826d318-b0ab-4e8e-e2ba-5425e3bf6f5f@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfI2vNyzz1jxOABZh06eO//uMvI49sFwK6mrL+7z0Icnj8iKze9alrf/i/ZljTTspsmRTjn1oeZLN/82RAs2DKGcutYsDE96GRHx3Ed8JEv1nRNt3+RBK
 zkJPO0unxA6Pyv4vV1XFr3oc6osNfZKjImjb+gC4Mjj4/WoTN5S4XaF06rSGe7ZrU4OVISMBXcXvHeYikW+ctAfz5KYwFtwqhoPi/e+7pv8jbVBPf/tBZxqp
 Hst9o29UGhVlgv/stl/hd1hX7mUfNVrLwcforKWj96LzbbbqVqDYctxso8OH+JBNpQ4+X95DLdukpflQX5/uioYC8MW1GE0Q7C7UN1S1BqM2zDz2ej0GpOi4
 l4SzBJFuI+8w5A70M33qt7719FYgthHbPRRz9ogYIiC6OIdcxblvNxsZRbHAux3pPx1UOW53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/08/18 16:17, Alban Gruin wrote:
> Hi Phillip,
> 
> Le 07/08/2018 à 16:00, Phillip Wood a écrit :
>> On 31/07/18 18:59, Alban Gruin wrote:
>>> +
>>> +int edit_todo_list(unsigned flags)
>>> +{
>>> +	struct strbuf buf = STRBUF_INIT;
>>> +	const char *todo_file = rebase_path_todo();
>>> +	FILE *todo;
>>> +
>>> +	if (strbuf_read_file(&buf, todo_file, 0) < 0)
>>> +		return error_errno(_("could not read '%s'."), todo_file);
>>> +
>>> +	strbuf_stripspace(&buf, 1);
>>> +	todo = fopen_or_warn(todo_file, "w");
>>
>> This truncates the existing file, if there are any errors writing the
>> new one then the user has lost the old one. write_message() in
>> sequencer.c avoids this problem by writing a new file and then renaming
>> it if the write is successful, maybe it is worth exporting it so it can
>> be used elsewhere.
>>
>>> +	if (!todo) {
>>> +		strbuf_release(&buf);
>>> +		return 1;
>>> +	}
>>> +
>>> +	strbuf_write(&buf, todo);
>>> +	fclose(todo);
>>
>> There needs to be some error checking after the write and the close
>> (using write_message() would mean you only have to check for errors in
>> one place)
>>
> 
> Right.  Should I find a new nawe for write_message()?

That might be a good idea, I'm not sure what it should be though, maybe 
write_file()?, perhaps someone else might have a better suggestion.

Best Wishes

Phillip

> 
> Cheers,
> Alban
> 

