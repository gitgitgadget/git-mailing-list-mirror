Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09462C433B4
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 02:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDFD4610A6
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 02:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbhDQC7L (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Apr 2021 22:59:11 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59561 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbhDQC7G (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Apr 2021 22:59:06 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7810E12E6D4;
        Fri, 16 Apr 2021 22:58:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VprzMfx90Dm4EQZ71hDow1AlUjU=; b=dNJrti
        B4oteK6RXwM+bOQ7Ck+bIFgTuod6T7+MOwm7n11Ejb7V1zKf+ICkIV3tatrDd9r8
        5DsibRgYmcBbqzTgXXpaglGlYjpw/HrIRaA1B4jDu/UhpXU/B1/ssI7+vHzsQ05f
        wDcUdsBjOAXk25BRTrqwP2Lgu74OKdOYCeyVQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BypPba8NglRoYbHggjAJXQwsNBJeK3VO
        JjAkiMrM4o/FExoZSX32pP2rUNzeyr05xhxXIVFZNp5Z+lesJmyMiRen3rhd/2si
        KRighHiG+B2Cp8xGtQp3ejXjCmakXikHHeQsVTXWQOj2VB6NTKj40SdrZ5IgoAop
        54uRSE0TnCI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 68F5312E6D3;
        Fri, 16 Apr 2021 22:58:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AF75E12E6D2;
        Fri, 16 Apr 2021 22:58:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v10 2/2] [GSOC] trailer: add new .cmd config option
References: <pull.913.v9.git.1618245568.gitgitgadget@gmail.com>
        <pull.913.v10.git.1618562875.gitgitgadget@gmail.com>
        <daa889bd0ade1111eb8b1471fe7e953fcb41d12b.1618562875.git.gitgitgadget@gmail.com>
        <xmqqy2dikpc1.fsf@gitster.g> <xmqqr1jakp57.fsf@gitster.g>
Date:   Fri, 16 Apr 2021 19:58:35 -0700
In-Reply-To: <xmqqr1jakp57.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        16 Apr 2021 12:25:40 -0700")
Message-ID: <xmqqpmytiplw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CE8620E4-9F28-11EB-8BCA-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> OK.  I think there still will be disagreement on this last point
>> between Christian and I, but I'd be happy with this as the first cut
>> for newly introduced .cmd and then when it becomes needed add
>> something like the attached patch on top to optionally run the given
>> command when configured.
>>
>>
>>  trailer.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git c/trailer.c w/trailer.c
>> index 7c7cb61a94..39132211cc 100644
>> --- c/trailer.c
>> +++ w/trailer.c
>> @@ -723,7 +723,8 @@ static void process_command_line_args(struct list_head *arg_head,
>>  	/* Add an arg item for each configured trailer with a command */
>>  	list_for_each(pos, &conf_head) {
>>  		item = list_entry(pos, struct arg_item, list);
>> -		if (item->conf.command)
>> +		if ((item->conf.run_implicitly && item->conf.cmd) ||
>> +		    item->conf.command)
>>  			add_arg_item(arg_head,
>>  				     xstrdup(token_from_item(item, NULL)),
>>  				     xstrdup(""),
>
> Actually, if we were to do this, I actually suspect that, unlike the
> textual replacement of $ARG in the old .command configuration, we
> should take advantage of the fact that the command can tell the
> cases between an empty string given as $1 and no positional argument
> was given for $1.  So what add_arg_item() does here for .command
> (which has to give an empty string, because it will textually
> replace an occurrence of $ARG) and for .cmd may have to be different.
> Perhaps record NULL here, so that when the command line is formed,
> we can tell that we do not want add an extra "" that becomes $1,
> when we are dealing with .cmd in this codepath.

And continuing this line of thought, I think it would be a perfectly
fine extension to allow the script/program that is launched by the
.command or .cmd mechanism to signal interpret-trailers that it does
not want it to add a trailer as the result of this invocation by
exiting with non-zero.  And that would be a reasonable way forward
without having to add yet another ugly workaround .runMode.

For example, trailer.signoff.cmd could be this script:

	#!/bin/sh
	if test $# != 1
	then
		exit 1
	else
		git log -1 --author="$1" --format='"%aN" <$aE>'
	fi

where the "implicit" invocation is signalled by not passing any
argument, to which the script reacts by exiting with 1, and the
interpret-trailers would discard the result of the unasked-for
invocation.




