Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B92EF1F424
	for <e@80x24.org>; Fri, 30 Mar 2018 11:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751147AbeC3LJa (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 07:09:30 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:22085 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751096AbeC3LJ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 07:09:29 -0400
Received: from [192.168.2.201] ([92.22.46.114])
        by smtp.talktalk.net with SMTP
        id 1ruPfK4Zu4Zqz1ruQfZrHq; Fri, 30 Mar 2018 12:09:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1522408167;
        bh=LxlSGM6snD3sCKcvReHoFKiSYblT8M8enevfwrR+0kk=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=dvarGI+BobdauBeTlotafJuZf7bUfAnhHWnNDZtIs7SEzdBz9etrjTEuHLnUelSbB
         OR6f9l4aN5Ri2NDTgVOo4mDpoImVjNUxiTG13W4euBHOqVeLJmOcGo7+dwdvJ90C/D
         U7ImHVDz55ZVAWcmoWGmeEd/OS+W4TD8PuFNE/08=
X-Originating-IP: [92.22.46.114]
X-Spam: 0
X-OAuthority: v=2.3 cv=E/fjW5Vl c=1 sm=1 tr=0 a=KUgcAvQ5w6cTYeaau6oCBw==:117
 a=KUgcAvQ5w6cTYeaau6oCBw==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=evINK-nbAAAA:8 a=70P8zL2JQ48KCpGHY2AA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19
 a=QEXdDO2ut3YA:10 a=SHUmGpGg8TAA:10 a=RfR_gqz1fSpA9VikTjo0:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 0/3] add -p: select individual hunk lines
To:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Gustavo Leite <gustavoleite.ti@gmail.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20180219113619.26566-1-phillip.wood@talktalk.net>
 <20180316101346.7137-1-phillip.wood@talktalk.net>
 <xmqq1sg27mwf.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <a8dd262b-8b0c-8632-bf28-e03f9405317f@talktalk.net>
Date:   Fri, 30 Mar 2018 12:09:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <xmqq1sg27mwf.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfF/ioibUfl4J1xksalgrIbO1snxDXF77V0rwHDDX8dcbDoT0pjBmXN+Vo3x4OT9lRK/Z3/3xpClMwt0bdyGkxCETkJruX/6xSuci4DW/2iluqG3as8kM
 GXx3yv29xUp5i1GClBaThT+pkwJUZwe+P+IK24LhdxJj7AGY5XYL+6LuVqXV6DOCB2y8cc8WsYn5XEx6ycIP5iJaNmlLGltwfY5tT2D5doxOBUAwJ7Dte1Na
 1884Z1L48absqR/HEs7zti9KhQD+ygtNn6f5fw9TFOMWmho29QbhDgTWjXGm2jjynvgDIRHylpUdTVNNPN78/BB11t6UPFuXzAYAyUdveuc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29/03/18 19:32, Junio C Hamano wrote:
> Phillip Wood <phillip.wood@talktalk.net> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> Since v2 I've updated the patches to use '-' instead of '^' to invert
>> the selection to match the rest of add -i and clean -i.
>>
>> These patches build on top of the recount fixes in [1]. The commit
>> message for the first patch describes the motivation:
>>
>> "When I end up editing hunks it is almost always because I want to
>> stage a subset of the lines in the hunk. Doing this by editing the
>> hunk is inconvenient and error prone (especially so if the patch is
>> going to be reversed before being applied). Instead offer an option
>> for add -p to stage individual lines. When the user presses 'l' the
>> hunk is redrawn with labels by the insertions and deletions and they
>> are prompted to enter a list of the lines they wish to stage. Ranges
>> of lines may be specified using 'a-b' where either 'a' or 'b' may be
>> omitted to mean all lines from 'a' to the end of the hunk or all lines
>> from 1 upto and including 'b'."
> 
> I haven't seen any review comments on this round, and as I am not a
> heavy user of "add -i" interface (even though I admit that I
> originally wrote it), I haven't had a chance to exercise the code
> myself in the two weeks since the patches have been queued in my
> tree.
> 
> I am inclihned to merge them to 'next' soonish, but please stop me
> if anybody (including the original author) has further comments.
> 
> Thanks.
> 
Hi Junio, if no one else has any comments, then I think it's ready for
next. I've not used this latest incarnation much but I've used the
previous versions quite a bit.

Best Wishes

Phillip
