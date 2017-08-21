Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98E341F667
	for <e@80x24.org>; Mon, 21 Aug 2017 10:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753343AbdHUKcw (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 06:32:52 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:22397 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753095AbdHUKcv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 06:32:51 -0400
Received: from [192.168.2.201] ([92.22.15.146])
        by smtp.talktalk.net with SMTP
        id jk0mdOU5C3CyHjk0mdyQi2; Mon, 21 Aug 2017 11:32:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1503311569; bh=0urOlnKpealASeBx5RscrzBVPfyE1wrt9lcU5CQLG28=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Qr4r/8AMemz+JyrY/KPnVgRRNYv7f+XFRqslDOOEkg5veehIqQrBDeWwHmY2TTk4b
         6ov5kT9xxA6Iarm5evzjUvwqAFqfT7y0vQTjiDafv7sS8irmUZiIVWvVCFVBIH2i+g
         Qd0lrjZ892vE1aesO8VG/p3xJSDvmQrl4UQT5BSs=
X-Originating-IP: [92.22.15.146]
X-Spam: 0
X-OAuthority: v=2.2 cv=Zo+dE5zG c=1 sm=1 tr=0 a=PRKyDR6jJsLBrgZYJ8A23w==:117
 a=PRKyDR6jJsLBrgZYJ8A23w==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=tUlwUKWfvoB4Jb2F0MAA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH 0/5] Add option to autostage changes when continuing a
 rebase
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20170726102720.15274-1-phillip.wood@talktalk.net>
 <xmqqa83rrrdu.fsf@gitster.mtv.corp.google.com>
 <xmqqa83qq2uf.fsf@gitster.mtv.corp.google.com>
 <xmqq60eeq24l.fsf@gitster.mtv.corp.google.com>
 <8cdda835-0b4f-6ffb-31bf-6192999818be@talktalk.net>
 <6a71f802-b20c-f6bc-7bb5-8d81db3353d8@talktalk.net>
 <xmqqpocloqcp.fsf@gitster.mtv.corp.google.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <a3b7af29-8b3a-5253-21da-957920212a6e@talktalk.net>
Date:   Mon, 21 Aug 2017 11:32:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <xmqqpocloqcp.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfFBDNBioGeaxeCvkPpbJs80L1iUXCh1zXkoh3WT3sg/hbz6ZnlsnJr2WlovgYCEjnJ8KSYQj0Dvl9/m4o/48d41GeFlXj3BdUt7FWlWEp1Add5OUf4ma
 apiBPYGXWJD2bg3s/ZhyKsVn+CPhDAfKC002vv1BUxTzQori9eKnTXUCqmC4ZFgC2jmbMgmH7SjP0tY0PZ8t5WMtqSABnDJwub6Abqcc2WsZde9CXX5Txsfj
 hlghnGo09kBOc3Xj4T3ibTl7UVjPayM3YTxSAdHzF2o=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/07/17 16:24, Junio C Hamano wrote:
> Phillip Wood <phillip.wood@talktalk.net> writes:
> 
>>> On 26/07/17 23:12, Junio C Hamano wrote:
>>>> I think
>>>> you are already 80% there without adding a yet another option,...
>>> ...
>>> I'm interested in the 20% as it's about 100% of my rebase conflicts.
> 
> OK, then at least a fixed --rerere-autoupdate would hopefully limit
> the scope of the additional 20%; I'd suspect that a new option would
> also internally turn on --rerere-autoupdate, so that the remaining
> changes you would see upon --continue would be limited to what the
> user had to manually resolve (and edit without having textual conflict,
> aka evil merge to resolve semantic conflicts).

I can see the logic in that but I was imagining (and the patches
implement) that the --autostage option would be passed to 'rebase
--continue' not when the rebase was started by which time it is too late
to turn on --rerere-autoupdate for the current conflicts. I prefer
having to pass --autostage with --continue so that it is a concious
decision by the user to stage unstaged changes when they continue rather
than rebase just doing it each time it continues.

> I am *not* opposed to an option to tell the command to blindly take
> such remaining changes, as long as it stays optional---the use of
> the option can then be taken as a strong signal that the user is OK
> with the local changes in the working tree, even if the user may not
> have marked them as resolved with "git add".

I agree it definitely needs to be optional (possibly with a config
option to have it on by default but I'm not wedded to that as it is easy
to set up a git or shell alias)

What is the best way forward on this? The patches I posted add a
'--autostage' option to be passed with '--continue' which means that
staging all the unstaged changes remains optional but does not allow
--rerere-autoupdate to be automatically enabled. I'm not sure about the
check for merge markers, as it is implemented it also checks for
whitespace errors which is really the domain of the pre-commit hook. If
we go for an explicit --autostage without the config key to make it on
by default then maybe it is OK to drop the check, but it keeping it
could be a useful safety measure. I don't think it would be too much
work the change diff to allow '--check=merge-markers' as internally the
whitespace and marker checks are implemented separately.

Best Wishes

Phillip

>>>> And from the
>>>> workflow point of view, encouraging them to "git add" their manual
>>>> resolution after they are satisified with their changes by not doing
>>>> "git add" blindly for all changes, like your --autostage" does, is
>>>> probably a good thing.
>>
>> Git allows 'git commit -a' to complete a conflicted merge which I
>> think is much the same thing as I'm proposing....
> 
> "-a" is a strong enough sign that the user is OK with all the paths;
> "git commit" without an option does not.  So it is OK for a new
> option (perhaps "--all-autoupdate", which does more than the
> existing "--rerere-autoupdate") to become the signal that the user
> is OK with all the local changes.
> 
> This is a tangent, but concluding a merge with "commit -a" (or "add
> -u && commit -a") has always been discouraged among Git expert
> users, and it will stay to be so.  If you search the list archive,
> you would find a good explanation by Linus on this, but a short
> version is that this is because it is normal to start a merge in a
> dirty working tree where the user has local changes that the user
> knows will not interfere with the merge.  
> 
> Because "rebase" refuses to work in a dirty working tree, the
> analogy with "merge" does not quite hold.  Doing "add -u" before
> telling it to "--continue" would be much safer.
> 
> Thanks.
> 
> 
> 

