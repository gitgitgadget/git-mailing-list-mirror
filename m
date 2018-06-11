Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 270961F403
	for <e@80x24.org>; Mon, 11 Jun 2018 15:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752128AbeFKP7Z (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 11:59:25 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:8099 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751255AbeFKP7Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 11:59:25 -0400
Received: from [192.168.2.240] ([92.22.39.132])
        by smtp.talktalk.net with SMTP
        id SPE2fBXfDpXFjSPE3f2xrN; Mon, 11 Jun 2018 16:59:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1528732763;
        bh=pK0e8touGagq7mHfDA7BdVqYSzqf5cfh0PfCjyIgaR0=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=VobMlukD0/Mu1HmlrRxJTP0MJSXhSEStRw+HhKMAEYVinFcYd29Npbw3WLrqqtC8c
         SHIbjU2FNbzAI7+t8qWm1UM9qsQnIqRCAJSrxX+/Av4oWIhd7Qkf0rmh/dfEP2BOPV
         d7xRCTa0oyXG/M+4l/qOL/kbq5XAK6kwareYq/fs=
X-Originating-IP: [92.22.39.132]
X-Spam: 0
X-OAuthority: v=2.3 cv=Ob228CbY c=1 sm=1 tr=0 a=AATg4WxWBR3MjRzlB3y0Ow==:117
 a=AATg4WxWBR3MjRzlB3y0Ow==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=103lQiJv96_jc_RleG8A:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/2] git-rebase: error out when incompatible options
 passed
To:     Elijah Newren <newren@gmail.com>, phillip.wood@dunelm.org.uk
Cc:     Git Mailing List <git@vger.kernel.org>
References: <CABPp-BGxaroePB6aKWAkZeADLB7VE3y1CPy2RyNwpn=+C01g3A@mail.gmail.com>
 <20180607050654.19663-1-newren@gmail.com>
 <20180607050654.19663-2-newren@gmail.com>
 <cec770a8-28ee-d546-8c27-905d2fcdb0c8@talktalk.net>
 <CABPp-BG7sR6NvHf4=ZOwxRh-KKR8QEVwB=D5p9DE_h1oDgRvoA@mail.gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <560d4128-e088-6028-9f39-5cfcb3e329b8@talktalk.net>
Date:   Mon, 11 Jun 2018 16:59:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BG7sR6NvHf4=ZOwxRh-KKR8QEVwB=D5p9DE_h1oDgRvoA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfO2drJxWsKuE+X356Wim4MfefG/7hPxSgxaK2WDFVD58PneYteIFm/pIHWlulRorSltlI0SXaUfr2cZXKssb8dVslOK6NGTrJcSHEcVeBdx7VQeAHtA0
 u7iizUYHCGldRx8VqfgYWunlOZcd6f21kb07EDHNbMn5IpV8N0F2w7Sx+mNh3AVxDoisR+60FRlRPJhJj+twHR3mVLdD4Ty9zLVngg9b3LOOWKK6Cejlp7Rk
 zQGskVZSPe7W90+qMrnc3w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/06/18 16:19, Elijah Newren wrote:
> Hi Phillip
> 
> On Sun, Jun 10, 2018 at 12:40 PM, Phillip Wood
> <phillip.wood@talktalk.net> wrote:
> 
>>>    Documentation/git-rebase.txt           | 15 +++++++++++++--
>>>    git-rebase.sh                          | 17 +++++++++++++++++
>>>    t/t3422-rebase-incompatible-options.sh | 10 +++++-----
>>>    3 files changed, 35 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
>>> index 0e20a66e73..451252c173 100644
>>> --- a/Documentation/git-rebase.txt
>>> +++ b/Documentation/git-rebase.txt
>>> @@ -243,6 +243,10 @@ leave out at most one of A and B, in which case it
>>> defaults to HEAD.
>>>    --keep-empty::
>>>          Keep the commits that do not change anything from its
>>>          parents in the result.
>>> ++
>>> +This uses the `--interactive` machinery internally, and as such,
>>> +anything that is incompatible with --interactive is incompatible
>>> +with this option.
>>>      --allow-empty-message::
>>>          By default, rebasing commits with an empty message will fail.
>>> @@ -324,6 +328,8 @@ which makes little sense.
>>>          and after each change.  When fewer lines of surrounding
>>>          context exist they all must match.  By default no context is
>>>          ever ignored.
>>> +       Incompatible with the --merge and --interactive options, or
>>> +       anything that implies those options or their machinery.
>>
>>
>> struct replay_opts has an allow_empty_message member so I'm not sure that's
>> true.
> 
> I think you were confused by the way the patch broke up.  The jump to
> line 328 means that this comment is about the -C option, not the
> --allow-empty-message option.

Ah you're right, I missed the hunk header

> However, I probably should add a comment next to the
> --allow-empty-message option, to not the reverse is true, i.e. that
> it's incompatible with am-based rebases.  (git-rebase--am.sh ignores
> the allow_empty_message variable set in git-rebase.sh, unlike
> git-rebase--interactive.sh and git-rebase--merge.sh)

That sounds like a good idea

>>>    -f::
>>>    --force-rebase::
>>> @@ -355,13 +361,15 @@ default is `--no-fork-point`, otherwise the default
>>> is `--fork-point`.
>>>    --whitespace=<option>::
>>>          These flag are passed to the 'git apply' program
>>>          (see linkgit:git-apply[1]) that applies the patch.
>>> -       Incompatible with the --interactive option.
>>> +       Incompatible with the --merge and --interactive options, or
>>> +       anything that implies those options or their machinery.
>>
>>
>> I wonder if it is better just to list the incompatible options it might be a
>> bit long but it would be nicer for the user than them having to work out
>> which options imply --interactive.
> 
> That could work.  Would this be done at the end of the 'OPTIONS'
> section of the manpage?  Should I create an 'INCOMPATIBLE OPTIONS'
> section that follows the 'OPTIONS' section?

I think that would be the best way of doing it, maybe with a note in the 
description of the am options to check in that section to see what they 
can be safely combined with.

>>>    --committer-date-is-author-date::
>>>    --ignore-date::
>>>          These flags are passed to 'git am' to easily change the dates
>>>          of the rebased commits (see linkgit:git-am[1]).
>>> -       Incompatible with the --interactive option.
>>> +       Incompatible with the --merge and --interactive options, or
>>> +       anything that implies those options or their machinery.
>>>      --signoff::
>>>          Add a Signed-off-by: trailer to all the rebased commits. Note
>>> @@ -400,6 +408,9 @@ The `--rebase-merges` mode is similar in spirit to
>>> `--preserve-merges`, but
>>>    in contrast to that option works well in interactive rebases: commits
>>> can be
>>>    reordered, inserted and dropped at will.
>>>    +
>>> +This uses the `--interactive` machinery internally, but it can be run
>>> +without an explicit `--interactive`.
>>> ++
>>
>> Without more context it's hard to judge but I'm not sure this adds anything
>> useful
> 
> Hmm, yeah.  I noted that --exec had similar wording, noted that
> --preserve-merges had something along the same lines but as a warning,
> and didn't see the similar wording for --rebase-merges -- I somehow
> missed the paragraph right above where I added these lines.  Oops.
> Anyway, I'll pull it out.

If we can get a good description of which options are compatible with 
what then hopefully we can remove the existing references to implicit 
interactive and am, the user should only have to worry about which 
options are compatible.

>>>    It is currently only possible to recreate the merge commits using the
>>>    `recursive` merge strategy; Different merge strategies can be used only
>>> via
>>>    explicit `exec git merge -s <strategy> [...]` commands.
>>> diff --git a/git-rebase.sh b/git-rebase.sh
>>> index 40be59ecc4..f1dbecba18 100755
>>> --- a/git-rebase.sh
>>> +++ b/git-rebase.sh
>>> @@ -503,6 +503,23 @@ then
>>>          git_format_patch_opt="$git_format_patch_opt --progress"
>>>    fi
>>>    +if test -n "$git_am_opt"; then
>>> +       incompatible_opts=`echo "$git_am_opt" | sed -e 's/ -q//'`
>>
>>
>> I think the style guide recommends $() over ``
> 
> Will fix.
> 
> 
> Thanks for taking a look!

Thanks for working on this, it should make things simpler for user's to 
understand

Best Wishes

Phillip
> Elijah
> 

