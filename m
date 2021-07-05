Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55343C07E99
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 13:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33E5A61222
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 13:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbhGEN5Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 09:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbhGEN5Y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 09:57:24 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C166EC061574
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 06:54:47 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id t14-20020a05600c198eb029020c8aac53d4so3613788wmq.1
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 06:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MgtV0M9z6NaOEa1C6ObDlLKXMzDVj5OgI7nUjXm+R+A=;
        b=FNRgNBE7BEIv/x7u82l43Y1Q7GIKYt/S+gVO2mmppDM45L8Qe0rgEz3tmwvmUhpiTU
         ZX2neKvut4fCRaCkLA5xg9ujJxdPAjGkPWmpgTNYL2OxDC0uWCUXaMHRPZSsi/5vZxYb
         PXkxMb+eALQS6RTVOdZgOi5q4JrhuxVZsGo5bZJEF0WVOcDKMILR9coBosltR4lw+EZi
         iN5G3gPQFMpEK3BM3PoN50mm+aN7dD8pjxinpgRQZJE3WFfklm+WI5dSORAaDJRpNMSE
         a6lJ348+c2fy9xgjYwjrmRS4soS4UG58O2hleyty+IZI80w0OlR3EhLwfCWUrbDt9cNb
         VL9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=MgtV0M9z6NaOEa1C6ObDlLKXMzDVj5OgI7nUjXm+R+A=;
        b=DYob/GyoeGsSEoCIX69gmajItMqoahJ+dI4ewh/VuHC7rR2QpFzALYmR0FSGdV0/+G
         mJPdGwd4l8SOCFAwEHlxTN7EhCwx6slH6CQ338qOuGPfOXCP3veCFQQ0UrGkNh6Xd6xN
         0kpn5VFhu3lRPrDVAiHL9RcKCIM6t7Lw0QajJxY8Fs67XlDhzLzgiLbDE/SRamvrq247
         QYa9NVGjfK7TvPC7ZPIDHXCr8LaOQ54WOCmwUct+IiVNN6yDueLxa/DfsqqzVvVrIe0w
         fZGLcSXESg84GqpgSuCsFsiqVdsYOO9V4PgSb/4dVYSEf9Th39c/9eMkEtJ6OfrUF1+z
         21jQ==
X-Gm-Message-State: AOAM531gyfdNvyJ0lh6bRN0BrOf8QT4XOOhJ7YdEddiFqmUQRY+9kAGh
        lRxnoqWBYY6IiqDvlXDwbj8=
X-Google-Smtp-Source: ABdhPJyWbfIVIOpveYAJIDwHzQe9TJSuKcmlPqNw7v3aWAKoPNytULa/BG/2zFiOfBYGavnLxEATjg==
X-Received: by 2002:a05:600c:ace:: with SMTP id c14mr15026539wmr.110.1625493286426;
        Mon, 05 Jul 2021 06:54:46 -0700 (PDT)
Received: from [192.168.1.240] (118.22.198.146.dyn.plus.net. [146.198.22.118])
        by smtp.gmail.com with ESMTPSA id f9sm13626451wrm.48.2021.07.05.06.54.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jul 2021 06:54:46 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH RFC] rebase: respect --ff-only option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        newren@gmail.com
References: <20210705044505.666977-1-alexhenrie24@gmail.com>
 <349748b4-3c48-7ca7-eb0f-e859a15cab0f@gmail.com> <xmqq8s2lnkta.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <41852b7c-6ac7-3a3b-9f2d-6e537f52cd2a@gmail.com>
Date:   Mon, 5 Jul 2021 14:54:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <xmqq8s2lnkta.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 05/07/2021 10:58, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> As I understand it the motivation for this change is to have 'git -c
>> pull.rebase=true pull --ff-only' actually fast forward. Why cant we
>> just change pull not to rebase in that case?
>> ...
>> Is there a use for this outside of 'git pull --ff-only'? I'm far from
>> convinced we want this new option but if we do end up adding it I
>> think it should error out in combination with '-i' or '-x' as '-i'
>> implies the user wants to change the existing commits and '-x' can end
>> up changing them as well.
>>
>> I think this patch addresses a valid problem but it seems to me that
>> the approach taken pushes complexity into rebase to handle a case when
>> pull does not need to invoke rebase in the first place.
> 
> I share the sentiment, but my conclusion would be different.
> 
> Even though we explain that "pull" is _like_ "fetch" followed by
> "merge" (or "rebase"), at the conceptual level, "pull --ff-only"
> should not have to invoke merge or rebase backend.  If the branch
> fast-fowards to the fetched tip, "pull" should be able to just
> update the branch and check it out, and if it doesn't, "pull" should
> just be able to fail.
> 
> Similarly, "pull --ff" (i.e. fast-forwading allowed) should be able
> to just update the branch and check it out when the current tip of
> the branch can be fast-forwarded to the fetched tip.
> 
> But as you said, pull.rebase=interactive will break such a clean
> separation of concerns.  You can leave "pull" oblivious of what
> "rebase -i" wants to do when seeing a fast-forwardable history by
> teaching "rebase" (and "merge") backend to take "--ff-only", "--ff",
> and "--no-ff" options and having "pull" pass them through.

My main concern with the new rebase option was about a user invoking 
'git rebase -i --ff-only' directly.

If a user has pull.rebase=interactive and runs 'git pull --ff-only' then 
I'm not clear what they expect to happen. Assuming we can fast-forward 
would they expect pull to run 'rebase -i' which would open their editor 
with the todo list or would they expect that '--ff-only' means "I just 
want to fast-forward, I don't want to run 'rebase -i'". If it is the 
latter then we can just invoke 'git merge --ff-only' (so long as we 
don't mind running the post-merge hook in this case) and not worry about 
adding more complexity to 'git rebase'

The relevant section of the pull man page only talks about merging in 
relation to --ff-only

     --ff, --no-ff, --ff-only
	Specifies how a merge is handled when the merged-in history
         is already a descendant of the current history.  --ff is the
         default unless merging an annotated (and possibly signed)
         tag that is not stored in its natural place in the
         refs/tags/ hierarchy, in which case --no-ff is assumed.

         With --ff, when possible resolve the merge as a fast-forward
         (only update the branch pointer to match the merged branch;
         do not create a merge commit). When not possible (when the
         merged-in history is not a descendant of the current
         history), create a merge commit.

	With --no-ff, create a merge commit in all cases, even when
	the merge could instead be resolved as a fast-forward.

	With --ff-only, resolve the merge as a fast-forward when
	possible. When not possible, refuse to merge and exit with a
	non-zero status.

> We can teach "pull" that certain backends (namely "rebase -i" in
> this case) want to handle "ff logic" [*] themselves, and other
> backends (i.e. "rebase" and "merge") do not mind if "pull" handles
> "ff logic" for them, but that will break the abstraction (e.g. do we
> really want to teach "pull" that "rebase -i" wants to rewrite all
> the commits even when the history fast-forwards?) and will become a
> source of duplicated logic.
> 
> Another thing to worry about are hooks.  post-rebase 

There is no post-rebase hook. There is the post-rewrite hook, I haven't 
checked if we invoke it with no input of skip it entirely when we 
fast-forward.

> or post-merge
> operations would want to be carried out even when the history would
> fast-forward, and making "pull" to perform the fast-forwarding and
> know which hooks should be called with what parameter so that we
> could pretend as if the "merge" or "rebase" backend was indeed ran,
> breaks the abstraction.
> 
> So, even though I wish that the world was simpler and we could
> handle "ff logic" inside "pull", I am not sure if it is a realistic
> wish.

I think if we decide that 'pull --ff-only' always implies merging then 
the world stays fairly simple. On the other hand if we want to somehow 
combine rebasing with --ff-only it will be more complicated. If we go 
for the latter then unless someone comes up with a good use for 'rebase 
--ff-only' in another context I would prefer the new rebase option to be 
marked with PARSE_OPT_HIDDEN and that we also avoid making incidental 
changes the existing rebase options.

Best Wishes

Phillip

> 
> [Footnote]
> 
> * By "ff logic", I am referring to what should happen in the 3x2=6
>    matrix when one of ("--ff", "--ff-only", or "--no-ff") is given
>    and the history (does or does not) fast-forward.
> 
