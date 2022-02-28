Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73269C433EF
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 16:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237781AbiB1QKu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 11:10:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235612AbiB1QKt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 11:10:49 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CB750E26
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 08:10:09 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id l2-20020a7bc342000000b0037fa585de26so125362wmj.1
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 08:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=t6g2Gq7rgwS9Octl2p6zD6y4Mfe5SUYf77DdTdc7pu0=;
        b=AQ5rY5993kBoB0gCLYhqkO2Z8t3IKW745yT0oC+Id8wG+mWeyShy3115CrAEEW8/hX
         /5+Pvijy4AzUkmljbW8soD2nZ6tugRmYDib+bEZamsuZ8XT/qXBrkbD88gWHf4v3jQDe
         4bdUzyetqFj92ZJjakeya2awo6PrlN3LAciYvZrKN9iTkMTNSCLF6F7vOJnrRM+7UIDL
         886o6eZI0I16FUiZPyL/RVZkNRhTr29aWs/1yMPRFMjojJLRyzqKozSHl1dHBEHmCHV8
         0ueqDlmHCPCexUrLrB45XxozgndC0hnTPpTyUp9Avg7Sryty0gNGzvxkrfk+ux1pr7nM
         RvAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=t6g2Gq7rgwS9Octl2p6zD6y4Mfe5SUYf77DdTdc7pu0=;
        b=5sw0bNlFycO7jOQAFrwViCpFvZO+pGp0U0eIfHuzHlVMAP6Djln8cxUpEN+L9VplJV
         oKJkBQFJ+xbhUUQoMdvHAUJ7axrMY4pSjCBgR+tcuVLwKj8d/FhZdG28EYyK2GBJSGT+
         /s3KudOJBTPZFnu51WUF97CCfqhcA9qWyIDmv1gWbZ3mU21UxIiNQZ92bHEqasoyhHy3
         sUG1pTfAYQZtNmF5FCYhzf3dU8nXop1x2/67hgu3FY8rJw0BxnFcq3vZx8R6EzeUE0pI
         c7b0nGQs/Q2JpA9vSSi+WLnp9N3uQPEnucyKp375XuomKoDEDjIcuk2InGE8xvFY7hQf
         tTyw==
X-Gm-Message-State: AOAM531r0yQhopR8gbgNmMOg7UzkJIsR1Rk0BC7ImrpnfGePK40qI1Ao
        wl0ttAR1gU91xg3g2pDWofcL2okj3y8=
X-Google-Smtp-Source: ABdhPJz6p3uQqPWvfrssHP78fUT/XhZb1BVQwMGbgyzg4BqNxwa89ZrcAfIWbpJRFBypgZRu9LRV5Q==
X-Received: by 2002:a1c:4604:0:b0:381:139:e54e with SMTP id t4-20020a1c4604000000b003810139e54emr13770735wma.151.1646064607933;
        Mon, 28 Feb 2022 08:10:07 -0800 (PST)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id g20-20020a05600c4ed400b003811fab7f3esm13298298wmq.30.2022.02.28.08.10.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 08:10:07 -0800 (PST)
Message-ID: <bb17e9ee-d92f-40df-3069-bd86fc79c3cf@gmail.com>
Date:   Mon, 28 Feb 2022 16:10:06 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] worktree: add -z option for list subcommand
Content-Language: en-US
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1164.git.1645801727732.gitgitgadget@gmail.com>
 <xmqqh78mesj6.fsf@gitster.g>
 <CAPig+cQF3y64bPN8h4XvAYGX-g0LZedh-cAM+JLKdW_DPAWJaw@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAPig+cQF3y64bPN8h4XvAYGX-g0LZedh-cAM+JLKdW_DPAWJaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/02/2022 08:35, Eric Sunshine wrote:
> On Fri, Feb 25, 2022 at 12:59 PM Junio C Hamano <gitster@pobox.com> wrote:
>> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>> +-z::
>>> +     When `--porcelain` is specified with `list` terminate each line with a
>>> +     NUL rather than a newline. This makes it possible to parse the output
>>> +     when a worktree path contains a newline character.
>>
>> This makes it sound as if it were impossible.  As the changes this
>> patch makes to the documentation and the code indicate, we were
>> already doing quote_c_style(), so it is not quite correct to say so.
>>
>> Perhaps "makes it easier" is more accurate?
>>
>> Unless the original wasn't using quote_c_style() correctly and
>> wasn't quoting its output, that is?
> 
> That's the case. It is impossible without this patch since `git
> worktree list --porcelain` does not call quote_c_style() for the
> worktree path; it only calls quote_c_style() for the lock reason.
> Fixing this oversight for the worktree path for non-`-z` mode has
> potential backward-compatibility concerns. I had argued[1] that we
> might be able to sell it as a pure bug fix, but Phillip was
> concerned[2] that it might break existing tooling. (I also share that
> concern, but to a lesser degree, perhaps, since worktrees with oddball
> names containing newline or a leading double-quote must be exceedingly
> rare.)

If the user has not set core.quotePath to false then any unicode paths 
will be quoted unless we only quote paths with newlines and leading 
double quotes which would mean the quoting would not match all the other 
git commands. In general I think it is easier to use nul termination 
rather than having to unquote path names. In this case it is not obvious 
to me what command one would feed a quoted directory name into either 
(it's not like doing "git diff | sed ... |git update-index --stdin" or 
something like that).

Best Wishes

Phillip

> [1]: https://lore.kernel.org/git/CAPig+cQq_RnanDQ3jHfNz_L58WyzmsUJBhtdrLxa=H0v_io+WA@mail.gmail.com/
> [2]: https://lore.kernel.org/git/936f9b7c-6d54-00bc-f136-4cb4c2836eb6@gmail.com/
> 
>>> +             if (line_terminator) {
>>> +                     quote_c_style(reason, &sb, NULL, 0);
>>> +                     reason = sb.buf;
>>> +             }
>>> +             printf("locked %s%c", reason, line_terminator);
>>
>> OK.  I suspect write_name_quoted() may be a better fit that does not
>> require us to have our own strbuf, but this should be OK.
> 
> Nice suggestion.

