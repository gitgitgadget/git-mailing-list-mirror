Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC0311F404
	for <e@80x24.org>; Wed, 31 Jan 2018 17:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752808AbeAaR67 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 12:58:59 -0500
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:65461 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752097AbeAaR66 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 12:58:58 -0500
Received: from [192.168.2.201] ([92.28.135.202])
        by smtp.talktalk.net with SMTP
        id gwetew4LHAp17gweteJgUC; Wed, 31 Jan 2018 17:58:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1517421536;
        bh=4u89g6Que6nQrb7FPLIrXM2swXTgEmMc1qN1KLopqd8=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=FwSHGvdggQeMz5Tfe7+uhdkEB2fsdwFdkaG6Ny9J7nksoU9waTxRUt1Du2TgT4uW3
         lbYcf68z3UXo4eV3CbfU629LPC3aEDhfPgm/F6g2SC//xezLrFHfehDvk3+tl3GJGt
         ypvpIHkNX+HYMClMm5/KariQm9CgPP24LudkHTE4=
X-Originating-IP: [92.28.135.202]
X-Spam: 0
X-OAuthority: v=2.2 cv=EsGilWUA c=1 sm=1 tr=0 a=+9ZQAP2FB+pNrrgMTYJMPA==:117
 a=+9ZQAP2FB+pNrrgMTYJMPA==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=JsibEsFsbGGb-LjSmmgA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/8] sequencer: introduce the `merge` command
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jacob Keller <jacob.keller@gmail.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
 <647382ac70bfb7035345304a32d08f4e7b51cd40.1516225925.git.johannes.schindelin@gmx.de>
 <b3b37af6-4b65-5a44-a395-6f75a4adc98e@talktalk.net>
 <CA+P7+xr4KtR4q8Y=-+pv2TzvP009zRVR6a_zh2GOZXt_LXrFOg@mail.gmail.com>
 <nycvar.QRO.7.76.6.1801292230550.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <nycvar.QRO.7.76.6.1801311441430.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <640c350d-090c-ad0f-e6be-fc577bd184c2@talktalk.net>
Date:   Wed, 31 Jan 2018 17:58:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1801311441430.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfGGL+iT061FYXjLy+ouD9deIuZZuim784HnjR/qRGMrdajP8nNN29rawzE/yZhv0pg6cQkRMd/fchZ7I4iCvkeTvQhonScQ5NM7XxLF5lZmb/vwVu46a
 ugz2fpRVg6MEaGwY9/bg7t2BEq8tolUtjGvtRWrrPvK8HWxsPGIgjAjTJvV4VtVXg6s9BtnXpL+iZlTpqjn/KIkzrdmVP3NFnnFZhuj5wllrAMlX+xB4SeKH
 MHLNPuHELrN2EVbXweyQtS52PkhK+IM5Jp3Z0qU46QPATem9E1KYXd2jY/aT04m+yDmeT3yXXa6Jb2Alg4KFsJNEEQ59hCj8/FOsnwnNAlShpnar75iA/+YG
 JGJMc3PV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 31/01/18 13:48, Johannes Schindelin wrote:
> Hi Jake & Phillip,
> 
> On Mon, 29 Jan 2018, Johannes Schindelin wrote:
> 
>> On Sat, 20 Jan 2018, Jacob Keller wrote:
>>
>>> On Fri, Jan 19, 2018 at 6:45 AM, Phillip Wood <phillip.wood@talktalk.net> wrote:
>>>> On 18/01/18 15:35, Johannes Schindelin wrote:
>>>>>
>>>>> This patch adds the `merge` command, with the following syntax:
>>>>>
>>>>>       merge <commit> <rev> <oneline>
>>>>
>>>> I'm concerned that this will be confusing for users. All of the other
>>>> rebase commands replay the changes in the commit hash immediately
>>>> following the command name. This command instead uses the first
>>>> commit to specify the message which is different to both 'git merge'
>>>> and the existing rebase commands. I wonder if it would be clearer to
>>>> have 'merge -C <commit> <rev> ...' instead so it's clear which
>>>> argument specifies the message and which the remote head to merge.
>>>> It would also allow for 'merge -c <commit> <rev> ...' in the future
>>>> for rewording an existing merge message and also avoid the slightly
>>>> odd 'merge - <rev> ...'. Where it's creating new merges I'm not sure
>>>> it's a good idea to encourage people to only have oneline commit
>>>> messages by making it harder to edit them, perhaps it could take
>>>> another argument to mean open the editor or not, though as Jake said
>>>> I guess it's not that common.
>>>
>>> I actually like the idea of re-using commit message options like -C,
>>> -c,  and -m, so we could do:
>>>
>>> merge -C <commit> ... to take message from commit
>>
>> That is exactly how the Git garden shears do it.
>>
>> I found it not very readable. That is why I wanted to get away from it in
>> --recreate-merges.
> 
> I made up my mind. Even if it is not very readable, it is still better
> than the `merge A B` where the order of A and B magically determines their
> respective roles.
> 
>>> merge -c <commit> ...  to take the message from commit and open editor to edit
>>> merge -m "<message>" ... to take the message from the quoted test
>>> merge ... to merge and open commit editor with default message
> 
> I will probably implement -c, but not -m, and will handle the absence of
> the -C and -c options to construct a default merge message which can then
> be edited.

That sounds like a good plan (-c can always be added later), I'm really
pleased you changed your mind on this, having the -C may be a bit ugly
but I think it is valuable to have some way of distinguishing the
message commit from the merge heads.

> The -m option just opens such a can of worms with dequoting, that's why I
> do not want to do that.
> 
> BTW I am still trying to figure out how to present the oneline of the
> commit to merge (which is sometimes really helpful because the label might
> be less than meaningful) while *still* allowing for octopus merges.
> 
> So far, what I have is this:
> 
> 	merge <original> <to-merge> <oneline>
> 
> and for octopus:
> 
> 	merge <original> "<to-merge> <to-merge2>..." <oneline>...
> 
> I think with the -C syntax, it would become something like
> 
> 	merge -C <original> <to-merge> # <oneline>
> 
> and
> 
> 	merge -C <original> <to-merge> <to-merge2>...
> 	# Merging: <oneline>
> 	# Merging: <oneline2>
> 	# ...
> 
> The only qualm I have about this is that `#` really *is* a valid ref name.
> (Seriously, it is...). So that would mean that I'd have to disallow `#`
> as a label specificially.
> 
> Thoughts?

As ':' is not a valid ref if you want a separator you could have

	merge -C <original> <to-merge> : <oneline>

personally I'm not sure what value having a separator adds in this case.
I think in the octopus case have a separate comment line for the subject
of each merge head is a good idea - maybe the two head merge could just
have the subject of the remote head in a comment below. I wonder if
having the subject of the commit that is going to be used for the
message may be a useful prompt in some cases but that's just making
things more complicated.

Best Wishes

Phillip

> Ciao,
> Dscho
> 

