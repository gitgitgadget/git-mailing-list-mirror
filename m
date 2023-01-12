Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B043C54EBC
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 16:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjALQYx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 11:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjALQY0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 11:24:26 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90857E097
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 08:20:55 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id v2so7603369wrw.10
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 08:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w9BVdilKvH5OXifeloRhwAbNOF/3NnIdDZZyPL9M6aw=;
        b=SLZYDFaJp7UkUZfYSIreV8R0+sYsDWdpy5DYFpcGxhFgXrb8Co8en7jfbnw222Ke4E
         3Yyyb/HGhfc/cOCwSG5S4hn9XUS3mkxvGcd9OYLneyzOaAcTpV8MFDqsZ8MjOm1Liqoq
         bU+tc6HHr8wR8RQDjz5f8O18E7+kjkNd9EEhYLuH2DTa0Uuz72Fo86ramTkHOyBnD+IL
         9yP6pif1JJEUeTLSfh6jcU+bnfr62mdZQO5SvgrrL0KT6BsSqRc2r5PkuO6c8WXEFRY2
         iflUAu/P0Ud4MjJZFFG/GJYK7EP5DrXILdOPGZn5+trtVaRQiA172U2kT9LRZAkIASDC
         Yuzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w9BVdilKvH5OXifeloRhwAbNOF/3NnIdDZZyPL9M6aw=;
        b=OJV9azkSrmQYmZpVvTDqcTyJjeuqspLV0acKc+Lm01W293Nx9uIBXAEnwDNu0QlVeR
         c4/IDWws/6sn5N6DestLo3JsAiH3HdyEHhpvIaHdFXGF54wSZOBygDHfHPrcRnzY78iP
         XkPvFU8mvYIdT6JF70hJHh5c/02ksq8+aYP+5zuhsWjr2Ez2V7fN4kjBM7qAdWQz2Qgv
         4LrWbrv/sk07LsobcSs5Zzfw7EiT3kXiYleVI0Zzms/8HCyRO/OZo6TYNgUeSvPI0bVL
         JPKouH6q+fliF5g5dBAvCil1PR3btZ7g9BIJXJtBQ9cB56sXv9zvYwPXT9DUzA9TM4DI
         cLRg==
X-Gm-Message-State: AFqh2kp8rNa3/7awAcR2Ik0YPQVR+LkfOMp13H4u66dtVYNNMVlmiDJ4
        IeTH7U26nczOYUxb2MHyjwc=
X-Google-Smtp-Source: AMrXdXsWPRcFPJT+Dtsg3ZzWzGeYjIGnaj8VvDmmU+ZcAFlvOU5WiBvpG7xkQzmKBLUFoQ0mTisZAQ==
X-Received: by 2002:a5d:5a85:0:b0:264:ae8b:7dcd with SMTP id bp5-20020a5d5a85000000b00264ae8b7dcdmr51507170wrb.24.1673540454058;
        Thu, 12 Jan 2023 08:20:54 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id bw28-20020a0560001f9c00b002421888a011sm16524993wrb.69.2023.01.12.08.20.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 08:20:53 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <4e2bb2da-0c42-ae9c-2a05-9b23db55c2ce@dunelm.org.uk>
Date:   Thu, 12 Jan 2023 16:20:53 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase -i: allow a comment after a "break" command
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Olliver Schinagl <oliver@schinagl.nl>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <pull.1460.git.1673519809510.gitgitgadget@gmail.com>
 <230112.86pmbk0vvj.gmgdl@evledraar.gmail.com>
In-Reply-To: <230112.86pmbk0vvj.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/01/2023 12:25, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Jan 12 2023, Phillip Wood via GitGitGadget wrote:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
>> index f9675bd24e6..511ace43db0 100644
>> --- a/Documentation/git-rebase.txt
>> +++ b/Documentation/git-rebase.txt
>> @@ -869,7 +869,9 @@ the files and/or the commit message, amend the commit, and continue
>>   rebasing.
>>   
>>   To interrupt the rebase (just like an "edit" command would do, but without
>> -cherry-picking any commit first), use the "break" command.
>> +cherry-picking any commit first), use the "break" command. A "break"
>> +command may be followed by a comment beginning with `#` followed by a
>> +space.
> 
> You're missing a corresponding edit here to the help string in
> append_todo_help(), as you note you're making "break" support what
> "merge" does, and that help string documents that "merge" accepts a
> comment, after this we don't do that for "break", but should one way or
> the other (see below).

Thanks, Andrei has already mentioned that, I'll update the todo help 
when I re-roll
> I like this direction, but I don't see why we need to continue this
> special-snowflakeness of only allowing specific commands to accept these
> #-comments.
> 
> Why not just have them all support it? It started with "merge", which as
> 4c68e7ddb59 (sequencer: introduce the `merge` command, 2018-04-25) note
> can be used for:
> 
> 	merge -C baaabaaa abc # Merge the branch 'abc' into master
> 
> As Olliver points out we should probably support "#" without the
> following " ", which seems to be an accident of history &
> over-strictness.

It's not an accident, labels and commit names can begin with '#' so we 
need to support

	merge #parent1 #parent2

For "break" we could just not require '#' at all as we do for "reset 
<label>" where anything following the label is ignored. That would mean 
we couldn't add an argument to break in the future though (I'm not sure 
that is really a problem in practice). If we're going to require '#' 
then we may as well following the existing rules.

> But in this commit you extend it to "break", but we're going out of or
> way to e.g. extend this to "noop".

I'm struggling to see why "noop" would need a comment - it only exists 
to avoid an empty todo list and is not meant for general use (it's not 
in the help added by append_todo_help() for this reason)

For "pick", "edit", "reword", "fixup" & "squash" we don't need a comment 
mechanism as we ignore everything after the commit name. For "reset" we 
ignore everything after the label. For "label" we could add support for 
comments but I'm not sure it is that useful and we'd need to be careful 
not to interpret a bad label name as a label + comment.

> So I'd expect that just like the first for-loop in "parse_insn_line()"
> we'd check if strchr(bol, '#') returns non-NULL, and if so set eol to
> that result.

That would break labels and commit names that contain a '#'

If we think we're never going to want "break" to take an argument then 
maybe we should just make it ignore the rest of the line like "reset 
<label>".

Best Wishes

Phillip

> The "just like" being that we may want to explicitly forbid this or
> handle it specially for some, e.g. I didn't check but do the "label" and
> "reset" perhaps support arbitrary non-'\n' (probably by accident, and we
> could support commments there too).
> 
> For "pick" we probably need to explicitly exclude it, although I can't
> remember if we do anything useful with the part of the line after the
> OID (maybe not...).
