Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA492200B9
	for <e@80x24.org>; Tue,  8 May 2018 02:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753682AbeEHCKd (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 22:10:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61555 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753525AbeEHCKd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 22:10:33 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2663DEE21E;
        Mon,  7 May 2018 22:10:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=CGi4oz+gEIPrclUrn+xaztBaR6k=; b=JfOxf+F
        lTCk8yzfNBMn6nQo5Mgxq7wf6LRd2t3midEcbIiUCkejsb8zMocFGZq2YH0Gu6xQ
        nN5F2gdrf000KOPauenWLlvFh1JnSXtE2/xe/wQX6j+epNqaRberUSX8qVH5xpb3
        n5zY/UZPceT+mvEyFmj3GSRK1AOO/4HKaSHo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=rKstDsjoAEqSq69QFYOU8U60NFN/JVuui
        FSRsBd0XJK/CT5tJNcCH4k5wUoIwP8eJ+KAGJATmECk3uYuqgecuMBaH/er+bzSg
        Wl41FQMTMhUFNErcbOZUBHqL89gcKTsRe2LtUl72nQfur5st41AzdkPqLoWAerkk
        pTf/5rDp3c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1BBEEEE21D;
        Mon,  7 May 2018 22:10:32 -0400 (EDT)
Received: from zaya.teonanacatl.net (unknown [98.111.125.125])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 758ABEE219;
        Mon,  7 May 2018 22:10:31 -0400 (EDT)
Date:   Mon, 7 May 2018 22:10:29 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 12/18] branch-diff: use color for the commit pairs
Message-ID: <20180508021029.GC26695@zaya.teonanacatl.net>
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
 <cover.1525448066.git.johannes.schindelin@gmx.de>
 <ba4791918c78770005d552856d8669648d7004f1.1525448066.git.johannes.schindelin@gmx.de>
 <20180505234852.GR26695@zaya.teonanacatl.net>
 <nycvar.QRO.7.76.6.1805062146070.77@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1805062146070.77@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Pobox-Relay-ID: FC3A9CAE-5264-11E8-8B05-67830C78B957-09356542!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Johannes Schindelin wrote:
> Hi Todd,
> 
> On Sat, 5 May 2018, Todd Zullinger wrote:
> 
>>> @@ -430,6 +451,8 @@ int cmd_branch_diff(int argc, const char **argv, const char *prefix)
>>>  	struct string_list branch1 = STRING_LIST_INIT_DUP;
>>>  	struct string_list branch2 = STRING_LIST_INIT_DUP;
>>>  
>>> +	git_diff_basic_config("diff.color.frag", "magenta", NULL);
>>> +
>>>  	diff_setup(&diffopt);
>>>  	diffopt.output_format = DIFF_FORMAT_PATCH;
>>>  	diffopt.flags.suppress_diff_headers = 1;
>> 
>> Should this also (or only) check color.diff.frag?
> 
> This code is not querying diff.color.frag, it is setting it. Without
> any way to override it.
> 
> Having thought about it longer, and triggered by Peff's suggestion to
> decouple the "reverse" part from the actual color, I fixed this by
> 
> - *not* setting .frag to magenta,
> 
> - using the reverse method also to mark outer *hunk headers* (not only the
>   outer -/+ markers).
> 
> - actually calling git_diff_ui_config()...

Excellent.  That seems to work nicely now, respecting the
color.diff.<slot> config.

> The current work in progress can be pulled as `branch-diff` from
> https://github.com/dscho/git, if I could ask you to test?

While the colors and 'branch --diff' usage seem to work
nicely, I found that with 4ac3413cc8 ("branch-diff: left-pad
patch numbers", 2018-05-05), 'git branch' itself is broken.

Running 'git branch' creates a branch named 'branch'.
Calling 'git branch --list' shows only 'branch' as the only
branch.

I didn't look too closely, but I'm guessing that the argv
handling is leaving the 'branch' argument in place where it
should be stripped?

This unsurprisingly breaks a large number of tests. :)

Thanks,

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
A common mistake people make when trying to design something
completely foolproof is to underestimate the ingenuity of complete
fools.
    -- Douglas Adams

