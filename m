Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 537FB20209
	for <e@80x24.org>; Fri, 30 Jun 2017 09:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751931AbdF3Jxb (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 05:53:31 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:46555 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751898AbdF3Jxa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 05:53:30 -0400
Received: from [192.168.2.201] ([92.22.42.39])
        by smtp.talktalk.net with SMTP
        id QscCdOuPoQ527QscDdIN0L; Fri, 30 Jun 2017 10:53:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1498816409; bh=NnqGGGwCNoun5Hbn/A5cBl+9S2e2ssXPWxxLB2VvVNU=;
        h=Reply-To:Subject:To:References:Cc:From:Date:In-Reply-To;
        b=B6wo+IXqeUNwl9ahNKxOWHIhQtXkgU5zNr7y5mXFll8wOzcHOzKtKTUMxEtN+Zq8I
         QzwRr1nuHO0FvmONJK5M0cdVctOxgGfQQ1NIDLNKihoUd+/rmB+fPJfDrmbhgIe3eh
         wFCxgi/NrlCnASY24Zzq+0drjzwqqSH6lRqOS1iY=
X-Originating-IP: [92.22.42.39]
X-Spam: 0
X-OAuthority: v=2.2 cv=MI8io4Rl c=1 sm=1 tr=0 a=0UCMmuyk8Ln1ykD6Z38Clg==:117
 a=0UCMmuyk8Ln1ykD6Z38Clg==:17 a=IkcTkHD0fZMA:10 a=evINK-nbAAAA:8
 a=4r90M7QdFHJA289Wf44A:9 a=QEXdDO2ut3YA:10 a=RfR_gqz1fSpA9VikTjo0:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/5] Move unquote_path() from git-add--interactive.perl to
 Git.pm
To:     Jeff King <peff@peff.net>
References: <20170622102622.26147-1-phillip.wood@talktalk.net>
 <20170622231844.d3fdo6c367h3ldve@sigill.intra.peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <73f70ec5-b21f-e237-69a2-d0c4462d8c17@talktalk.net>
Date:   Fri, 30 Jun 2017 10:53:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170622231844.d3fdo6c367h3ldve@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJb+gfVJ0oKbUbs+v/1aFUH4Jy86fF98g0CR+GJgo0NH+YASdt4z1U/3fIrb8oa2xTPjvdHXuV0YBfvhrfsePO/O6WexVcSSQ9zONxGvvQcDV1H8wjq3
 /HmWTqi/ACBDgviTP+0bMYD17oiMjS+1e9ykuXUqMKdaFaw6C+M9/dHn35kWftO7DGXVaLPgHs7tqHRID3yARsxDQyFcf83Jteg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/06/17 00:18, Jeff King wrote:
> On Thu, Jun 22, 2017 at 11:26:17AM +0100, Phillip Wood wrote:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> I'm using this in some scripts and it would be more convenient to have
>> it available from Git.pm rather than copying and pasting it each time
>> I need it. I think it should be useful to other people using Git.pm as
>> well. It is not uncommon to get a quoted path back from a command that
>> needs to be passed on the commandline of another command. While one
>> can use -z in many cases, that leaves the problem of having to quote
>> the path when printing it in error messages etc.
> 
> Grepping around the calls to unquote_path in add--interactive, I
> definitely think many of them ought to be using "-z". But I don't think
> that's a reason not to make unquote_path() more widely available. It
> _is_ generally useful.
>
> The changes look sane to me. My biggest question is how add--interactive
> handles the exceptions thrown by the refactored function on error. Since
> these paths are coming from Git, it should be something never comes up,
> right? So failing hard is probably the best thing to do.

Yes, my assumption was that the error shouldn't be triggered, and if it
was then it would be a sign of bigger problems.

Best Wishes

Phillip

