Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE33020756
	for <e@80x24.org>; Tue, 10 Jan 2017 20:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750754AbdAJUaU (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 15:30:20 -0500
Received: from bsmtp3.bon.at ([213.33.87.17]:35040 "EHLO bsmtp3.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750729AbdAJU3t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 15:29:49 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 3tykCX4LXnz5tlC;
        Tue, 10 Jan 2017 21:29:44 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 671C63A9;
        Tue, 10 Jan 2017 21:29:43 +0100 (CET)
Subject: Re: [PATCH v4 14/14] mergetool: fix running in subdir when rerere
 enabled
To:     Junio C Hamano <gitster@pobox.com>
References: <20170109054238.42599-1-hansenr@google.com>
 <20170109232941.43637-1-hansenr@google.com>
 <20170109232941.43637-15-hansenr@google.com>
 <3a09e318-f14b-5f14-a992-3bd045f0a4c6@kdbg.org>
 <xmqqmveyson3.fsf@gitster.mtv.corp.google.com>
Cc:     Richard Hansen <hansenr@google.com>, git@vger.kernel.org,
        davvid@gmail.com, sbeller@google.com, simon@ruderich.org
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <15bc6621-4131-032c-4af6-8c76a366e4d8@kdbg.org>
Date:   Tue, 10 Jan 2017 21:29:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqmveyson3.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.01.2017 um 20:25 schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
>> BTW, the --sq and eval business is not required here. At this point,
>> $IFS = $'\n', so
>>
>> 		set -- $(git rev-parse --sq --prefix "$prefix" -- "$@")
>>
>> will do. (Except that it would not detect errors.)
>
> I thought you are suggesting not to use --sq but it is still there.

A copy-paste-p. Of course, I want to suggest not to use --sq.

> Unrelated, but I notice that in this:
>
>     eval "set -- $(git rev-parse --sq --prefix "$prefix" -- "$@")"
>     shift
>
> It is my fault but it is a roundabout way to say:
>
>     eval "set $(git rev-parse --sq --prefix "$prefix" -- "$@")"

Clever! But I fear that half a year down the road we will appreciate a 
comment like

	# rev-parse provides the -- needed for `set`

and then we are back at two lines, so I dunno...

-- Hannes

