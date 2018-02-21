Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36D681F404
	for <e@80x24.org>; Wed, 21 Feb 2018 21:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751332AbeBUVay (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 16:30:54 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:11005 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeBUVax (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 16:30:53 -0500
Received: from [192.168.2.240] ([92.22.21.220])
        by smtp.talktalk.net with SMTP
        id obyUeFZzGoNnDobyUeVNLm; Wed, 21 Feb 2018 21:30:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1519248651;
        bh=C7KxLOfNnxUom6SMoqFM5gCoiXLxnimxF6u4F9S8WYc=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=SOJcWsxpg7hvyGJCkrt6DUmhvjQDuXKJ8ZZ5TIXlHUNBhf32DKumv5A9l3awn1xQf
         4qZoUP0dDOC9fSJ6GSluuNNEvOQWLuyubggv+Wb/PPKVpaMXUHn1ZdGW5uI4Eew3fT
         Ox3NjAGHPN9CIo2xZ0PMyiud9IFg4CjTWSA32zNA=
X-Originating-IP: [92.22.21.220]
X-Spam: 0
X-OAuthority: v=2.2 cv=ZZ9tDodA c=1 sm=1 tr=0 a=VSxTZYxioCnvaH7igEU67w==:117
 a=VSxTZYxioCnvaH7igEU67w==:17 a=IkcTkHD0fZMA:10 a=xvdqEhimaQSW6vb63hwA:9
 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Git should preserve modification times at least on request
To:     Peter Backes <rtc@helen.PLASMA.Xg8.DE>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
References: <20180219212235.GA9891@helen.PLASMA.Xg8.DE>
 <nycvar.QRO.7.76.6.1802192257100.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <20180219220819.GA10466@helen.PLASMA.Xg8.DE>
 <nycvar.QRO.7.76.6.1802201127140.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <20180220210554.GA24474@helen.PLASMA.Xg8.DE>
 <nycvar.QRO.7.76.6.1802202329540.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <20180220224808.GA25678@helen.PLASMA.Xg8.DE>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <0a9f7d75-b362-bb9d-48ef-c4a6a921ff96@talktalk.net>
Date:   Wed, 21 Feb 2018 21:30:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180220224808.GA25678@helen.PLASMA.Xg8.DE>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfFLAoANs1QUbrDg0v+Dhh3qoUHZhqI3SbJx14w71HzumgYO3z/Os3qcgv+YqZEFXwiRkYqXPSbrpW3S+warVfP5rHMZfmoYRDJEjcDNFIfTupvK9RMoS
 RhdpccAcPr3UMWN0OkDJ7RK7sw9ID9eFxc8A5tea4pVEjYkNLC1CEI54ivB8/+YiuFppDJNe4RIW70hlc6yKG+WOAO3zGfDayhW5LQFZRRkcCQgz/w3BiD4B
 nNysoTH7V52T2uTpe0JIUg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/02/18 22:48, Peter Backes wrote:
> 
> On Tue, Feb 20, 2018 at 11:32:23PM +0100, Johannes Schindelin wrote:
>> Hi Peter,
>>
>> On Tue, 20 Feb 2018, Peter Backes wrote:
>>
>>> On Tue, Feb 20, 2018 at 11:46:38AM +0100, Johannes Schindelin wrote:
>>>
>>>> I would probably invent a file format (`<mtime><TAB><path><LF>`)
>>>
>>> I'm stuck there because of <path> being munged.
>>
>>  From which command do you want to get it? If you are looking at `git
>> diff`, you may want to use the `-z --name-only` options to avoid munging
>> the paths.
> 
> I plan to use "git diff-tree --name-only $w_tree HEAD" and subtract
> all lines from "git diff-index --name-only HEAD" to get the files for
> which the timestamp should be stored..
> 
> If I use "-z" I get the non-munged path, but I cannot safely store such
> paths in the proposed file format; they might contain newlines (sigh).
> So at one point I have to munge. Then the same question arises when I
> have to get the actual path from the munged path when restoring the
> timestamps.
> 
> If there's no ready-made functionality to munge and unmunge paths, I
> have to write some awk for this. At first I thought this might add one
> more dependency to git, but it seems that awk is already used in
> git-mergetool.sh, so I suppose it's okay to use in git-stash.sh etc,
> too.

In recent versions of git there's unquote_path() in Git.pm, you could 
possibly use that with perl -e from your script

Best Wishes

Phillip
> Best wishes
> Peter
> 

