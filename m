Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A249208E9
	for <e@80x24.org>; Fri, 27 Jul 2018 12:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730771AbeG0OHA (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 10:07:00 -0400
Received: from siwi.pair.com ([209.68.5.199]:45206 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730703AbeG0OHA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 10:07:00 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 779983F4004;
        Fri, 27 Jul 2018 08:45:13 -0400 (EDT)
Received: from [192.168.1.6] (83.sub-174-231-157.myvzw.com [174.231.157.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 08EBA3F4013;
        Fri, 27 Jul 2018 08:45:12 -0400 (EDT)
Subject: Re: [PATCH v1 03/25] structured-logging: add structured logging
 framework
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20180713165621.52017-1-git@jeffhostetler.com>
 <20180713165621.52017-4-git@jeffhostetler.com>
 <20180726090921.32232-1-szeder.dev@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <7d027531-71f2-0a64-a5a2-4c477dd7133b@jeffhostetler.com>
Date:   Fri, 27 Jul 2018 08:45:11 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180726090921.32232-1-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/26/2018 5:09 AM, SZEDER Gábor wrote:
> 
>> +void slog_set_command_name(const char *command_name)
>> +{
>> +	/*
>> +	 * Capture the command name even if logging is not enabled
>> +	 * because we don't know if the config has been loaded yet by
>> +	 * the cmd_<command>() and/or it may be too early to force a
>> +	 * lazy load.
>> +	 */
>> +	if (my__command_name)
>> +		free(my__command_name);
>> +	my__command_name = xstrdup(command_name);
>> +}
>> +
>> +void slog_set_sub_command_name(const char *sub_command_name)
>> +{
>> +	/*
>> +	 * Capture the sub-command name even if logging is not enabled
>> +	 * because we don't know if the config has been loaded yet by
>> +	 * the cmd_<command>() and/or it may be too early to force a
>> +	 * lazy load.
>> +	 */
>> +	if (my__sub_command_name)
>> +		free(my__sub_command_name);
> 
> Please drop the condition in these two functions; free() handles NULL
> arguments just fine.

sure.

> 
> (Sidenote: what's the deal with these 'my__' prefixes anyway?)
> 

simply a way to identify file-scope variables and distinguish
them from local variables.

Jeff
