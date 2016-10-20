Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F38BC1F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 18:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932417AbcJTSMp (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 14:12:45 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:33959 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751039AbcJTSMp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 14:12:45 -0400
Received: by mail-yb0-f193.google.com with SMTP id 191so1178917ybv.1
        for <git@vger.kernel.org>; Thu, 20 Oct 2016 11:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hp3qOjJw35wNIqe6gQxRiD+3lIoNN1bYRiXKHgxcIhY=;
        b=hjVN/Xe0vpfivHUyaa8+WDc/b1gn511vQh3gOWe1aBANL+3UT6olxN63ngUmCl79qd
         t9Bw6k9JnSlaHrtjg1XqhVxVuBloVD86hWN4gYl7ql6/cZxBEJHpAv+Bl6AHiBpo8N5t
         xdP8I6qY1RKzuABNhWkI0s1hjOz6hMPtK0bfW1PEOZ2+TEjrsVkDPZYh3zFz1+GdRPiK
         33+l8IENzsVu2MCVW/dvO+3rmZCCEzNQxyVbR3uen+TjJRMvLWG6NX3DswKWQkxawYVS
         5IDLQYoSPXQrvCt0XfAYtcs/T6BlGMPDw8sLGmEPHZQksOR2gKxZSzoY0kV3MSCh8YAH
         TwCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hp3qOjJw35wNIqe6gQxRiD+3lIoNN1bYRiXKHgxcIhY=;
        b=c0v9FHIY6thSGAJ0rdDJ52qTROOQOMDiaivw+4oHJ2qGGTN7iQmvEshec+jzaudIJh
         SRGoyP3IgjqbeEmczeU9YDpJnWeVKpUcv87CcsAwP/mQaaFqCKIWQ2cVbDLWXYfAVIci
         1k+Tz1nttP4/r2jHY4Aqr5TRzwkUYF/w8ux3+EuT+oAhcQ+95FHFvMMt528PGGnRE4oa
         iFMrLM0m374tNX1tK4ftyUQ/egwR94ymEzq74rdpuDwGJZo9cdvmrEqw5lZMDC9yBAYc
         xNuy4uFMf+e3M254W4aSkYOqyjzplFjSIYHQY4HN8uitKcYhmRgCD9CRheT8XbLgy4CJ
         UBgw==
X-Gm-Message-State: AA6/9Rl9QxiXoRCych4cj9h/DExIl8XFXwL4vFp6h3ABsKk3abI9Cl99GqwiWSTpO37Hlr9wZcCedKkf5Smdzw==
X-Received: by 10.37.161.198 with SMTP id a64mr3388517ybi.72.1476987164142;
 Thu, 20 Oct 2016 11:12:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.10.2 with HTTP; Thu, 20 Oct 2016 11:12:23 -0700 (PDT)
In-Reply-To: <1476986671.28685.5.camel@kaarsemaker.net>
References: <1476908699.26043.9.camel@kaarsemaker.net> <20161019210448.aupphybw5qar6mqe@hurricane>
 <xmqq4m48j70o.fsf@gitster.mtv.corp.google.com> <1476986671.28685.5.camel@kaarsemaker.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 20 Oct 2016 11:12:23 -0700
Message-ID: <CA+P7+xq5bo-Fwa95j3aynjMP0Qw+PiuMt=hc4ngvTDpeG8nhPw@mail.gmail.com>
Subject: Re: [PATCH] rev-list: restore the NUL commit separator in --header mode
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 20, 2016 at 11:04 AM, Dennis Kaarsemaker
<dennis@kaarsemaker.net> wrote:
> On Wed, 2016-10-19 at 15:41 -0700, Junio C Hamano wrote:
>> Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:
>>
>> > +   touch expect &&
>> > +   printf "\0" > expect &&
>>
>>
>> What's the point of that "touch", especially if you are going to
>> overwrite it immediately after?
>
> Leftover debugging crud. I tried various ways of generating an
> actual/expect to compare.
>
>> > +   git rev-list --header --max-count=1 HEAD | tail -n1 >actual &&
>>
>>
>> As "tail" is a tool for text files, it is likely unportable to use
>> "tail -n1" to grab the "last incomplete line that happens to contain
>> a single NUL".
>>
>> > +   test_cmp_bin expect actual
>> > +'
>
> Yeah, I was fearing that. I didn't find anything in the testsuite that
> helps answering the question "does this file end with a NUL" and would
> appreciate a hint :)
>
> D.

I did some searching, and we do use sed so I replaced it with sed \$!d
which appears to work. I think we should probably implement a
test_ends_with_nul or something.

Thanks,
Jake
