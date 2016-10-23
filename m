Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 465111FBB0
	for <e@80x24.org>; Sun, 23 Oct 2016 15:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755403AbcJWPHq (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Oct 2016 11:07:46 -0400
Received: from avasout02.plus.net ([212.159.14.17]:58704 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755088AbcJWPHp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Oct 2016 11:07:45 -0400
Received: from [10.0.2.15] ([194.75.29.46])
        by avasout02 with smtp
        id z37h1t00C0zhorE0137jRY; Sun, 23 Oct 2016 16:07:43 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=G/5eKJs5 c=1 sm=1 tr=0
 a=g54qAj+LxVGqXy9pVcJ+0w==:117 a=g54qAj+LxVGqXy9pVcJ+0w==:17
 a=IkcTkHD0fZMA:10 a=ybZZDoGAAAAA:8 a=1XWaLZrsAAAA:8 a=Y7e-WtpH6cleETgAXEQA:9
 a=QEXdDO2ut3YA:10 a=0RhZnL1DYvcuLYC8JZ5M:22 a=nJcEw6yWrPvoIXZ49MH8:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 17/36] attr: expose validity check for attribute names
To:     Stefan Beller <sbeller@google.com>, gitster@pobox.com
References: <20161022233225.8883-1-sbeller@google.com>
 <20161022233225.8883-18-sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <0425fea3-3419-c265-b964-f5a309b867fa@ramsayjones.plus.com>
Date:   Sun, 23 Oct 2016 16:07:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20161022233225.8883-18-sbeller@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 23/10/16 00:32, Stefan Beller wrote:
> From: Junio C Hamano <gitster@pobox.com>
> 
> Export attr_name_valid() function, and a helper function that
> returns the message to be given when a given <name, len> pair
> is not a good name for an attribute.
> 
> We could later update the message to exactly spell out what the
> rules for a good attribute name are, etc.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

[snip]

> +extern int attr_name_valid(const char *name, size_t namelen);
> +extern void invalid_attr_name_message(struct strbuf *, const char *, int);
> +

The symbol 'attr_name_valid()' is not used outside of attr.c, even
by the end of this series. Do you expect this function to be used
in any future series? (The export is deliberate and it certainly
seems like it should be part of the public interface, but ...)

In contrast, the 'invalid_attr_name_message()' function is called
from code in pathspec.c, which relies on 'git_attr_counted()' to
call 'attr_name_valid()' internally to check for validity. :-D

ATB,
Ramsay Jones



