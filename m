Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63B4220282
	for <e@80x24.org>; Sat, 17 Jun 2017 12:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752951AbdFQMZm (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Jun 2017 08:25:42 -0400
Received: from mail-ua0-f178.google.com ([209.85.217.178]:34424 "EHLO
        mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752924AbdFQMZl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jun 2017 08:25:41 -0400
Received: by mail-ua0-f178.google.com with SMTP id m31so38554224uam.1
        for <git@vger.kernel.org>; Sat, 17 Jun 2017 05:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Gmx2DQgi5dyiem08EWqhQNxlwJod+B0ZsHH4ni8ObR0=;
        b=Kb9g3LWoYkL8SDbF36VkISL82Nrepx7pWcBOdfK2o6nyPKbmTdJHKtttCtnz9VqhvY
         tXmVKhxFsq1CxLss/dhR02z1o4K1a+Nszb+Y24sQubmIt5lkPhr+Cua5Jiqcy9WZ1EX+
         4Ab7biHQxnItzp3YDFM1OyaMVddHDFfeDvNsSBQqHUYwbpLd3ZDddf/heLiwRNcIJajI
         l4D5S+/R1TAsIC0gsj9SI2pTEAxb0UUT4lS+DDyzoIASoJv0A/iC1Ra7bsmXyJ4CVMmR
         lUbVbZ8oKC2ftmry/3VZO7e0EaUJ2WDXkmluDFlTTEdR2dJzb+6x0geIK7I6sNassttT
         Oamw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Gmx2DQgi5dyiem08EWqhQNxlwJod+B0ZsHH4ni8ObR0=;
        b=WM4cy4QREwPZ4prvQdvOI3UIolfgr5JgBs+dQfb+LuFCaiVzkdEm5UxRe4EbrL5ZSd
         HdDnn5R+8eoVTinLKqG920yPo3xNR6el8TuiCiS5fs+D1+sdNy3EEpYfdpjhJqzUYAkW
         pVU1e/WmPcBBDtgmKP1xPuQE7aJ4gImGrjgdjiGzbEWktc0xlwdRSYS2OnUzjwdCMNEu
         0fzWHODsxHMkkFlfC22e8bsa4I+3tt5XYuZ3i8xwsejgU4OcY4hHXTpYEg4AK2rr1PfC
         NU+1dRq9QT5nsUkONSE6dswS3lRdk40OL7ru63vTwaMI5cbtPUjeXo00tvinKtnu+oqN
         5STQ==
X-Gm-Message-State: AKS2vOzfDfXk6gvwRl5iKw9MQO2We379G+EZTkMrxWfAWAljMEH3fN1F
        p6v8ZI+AxBxS69eBQYR3Q4Ls0jEmt38O
X-Received: by 10.159.36.147 with SMTP id 19mr8043050uar.152.1497702340339;
 Sat, 17 Jun 2017 05:25:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.80.214 with HTTP; Sat, 17 Jun 2017 05:25:39 -0700 (PDT)
In-Reply-To: <xmqqa857wqay.fsf@gitster.mtv.corp.google.com>
References: <20170616192837.11035-1-szeder.dev@gmail.com> <xmqqa857wqay.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Sat, 17 Jun 2017 14:25:39 +0200
Message-ID: <CAM0VKj=1DiPZzGot34Ar9SQR8VWV8ugvzFhAMibnZ8d-4F+1QA@mail.gmail.com>
Subject: Re: [RFC/PATCH 0/5] remote: eliminate remote->{fetch,push}_refspec
 and lazy parsing of refspecs
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 16, 2017 at 11:55 PM, Junio C Hamano <gitster@pobox.com> wrote:
> SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
>
>> 'struct remote' stores refspecs twice: once in their original string
>> form in remote->{fetch,push}_refspecs and once in their parsed form in
>> remote->{fetch,push}.  This is necessary, because we need the refspecs
>> for lazy parsing after we finished reading the configuration: we don't
>> want to die() on a bogus refspec while reading the configuration of a
>> remote we are not going to access at all.
>>
>> However, storing refspecs in both forms has some drawbacks:
>>
>>   - The same information is stored twice, wasting memory.
>
> True (but a few hundred bytes is nothing among friends ;-)

Indeed.  Even in my repos with close to 10k remotes the amount of
memory wasted by the duplicated refspecs is not an problem, there are
more pressing issues there.

>>   - remote->{fetch,push}_refspecs, i.e. the string arrays are
>>     conveniently ALLOC_GROW()-able with associated
>>     {fetch,push}_refspec_{nr,alloc} fields, but remote->{fetch,push}
>>     are not.
>
> This is a more real issue.
>
>>   - Wherever remote->{fetch,push} are accessed, the number of parsed
>>     refspecs in there is specified by remote->{fetch,push}_refspec_nr.
>>     This requires us to keep the two arrays in sync and makes adding
>>     additional refspecs cumbersome and error prone.
>
> You haven't told us which way you want to dedup.

Well, I actually did, right at the beginning.  The Subject:
specifically mentions which fields will be removed, and the first one
and a half line says in more usual terms what their roles are.

Anyway, made a note to use more natural language in the subjects (and
elsewhere) when we get there, maybe "remote.c: don't store refspecs as
strings in 'struct remote'" or something.

>  Are you keeping
> the original and removing the pre-parsed?  or are you only keeping
> the pre-parsed ones?  As long as you want ALLOC_GROW() ability, you
> need to maintain the invariants in three-tuple (foo, foo_alloc,
> foo_nr).
>
>>   - And worst of all, it pissed me off while working on
>>     sg/clone-refspec-from-command-line-config ;)
>
> Your feelings (or mine) do not count ;-).

Feelings have nothing to do with it, "it pissed me off" is a concise
way of saying "it made me waste quite some time debugging segfaults
and other nonsense resulting from ALLOC_GROW()ing remote->fetch,
misled by the previous point and the confusing order in which these
fields are listed in 'struct remote's definition".

> I do not think we would terribly mind if you only kept a list of
> pre-parsed form, with some mechanism to keep an "error" entry in
> that list with its original, so that an error can be reported with
> the refspec as the user originally gave us (which may mean the
> "error" entry may have to keep the original form, since it wasn't
> correctly parsable in the first place for it to trigger an error).
>
>> So here is my crack at getting rid of them.
>
> You still haven't told us what "them" are.  Parsed form, or the
> original?  Let's find out by reading on....
>
>> The idea is to parse refspecs gently while reading the configuration:
>> this way we won't need to store all refspecs as strings, and won't
>> die() on a bogus refspec right away.  A bogus refspec, if there's one,
>> will be stored in the remote it belongs to, so it will be available
>> later when that remote is accessed and can be used in the error
>> message.
>
> So normally we only have a list of parsed ones, but optionally there
> is a list of malformed originals that are before attempted (and
> failed) parsing used for error reporting?

For each remote there are two arrays of parsed refspecs, one for fetch
and one for push, and a single malformed original as string.

The reason for storing only a single malformed refspec per remote is
that I didn't want to noteworthily change the behaviour: the current
implementation die()s on the first malformed refspec it encounters
while parsing and reports only that one malformed refspec in the error
message.  This series essentially does the same as far as observable
behaviour goes, though it might happen that a different malformed
refspec is reported in the error message (if there are more than one,
depending on their order in the configuration).

Of course, if we want to, then this could be extended to record all
malformed refspecs while reading the configuration and report all of
them in the error message.  But that's a behaviour change which I
think should come on top as a separate patch.

>  That sounds sensible,
> especially given that we can recreate the original textual form from
> correctly parsed result (which allows us to report on other kinds
> of errors as necessary).
>
>> This applies on top of a merge of master and the fresh reroll (v5) of
>> sg/clone-refspec-from-command-line-config:
>
> Thanks.  Will take a look (but not immediately).
