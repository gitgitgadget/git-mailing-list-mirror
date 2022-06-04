Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EDEC43334
	for <git@archiver.kernel.org>; Sat,  4 Jun 2022 15:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237706AbiFDP2r (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jun 2022 11:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233426AbiFDP2q (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Jun 2022 11:28:46 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657BA31226
        for <git@vger.kernel.org>; Sat,  4 Jun 2022 08:28:44 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id d14so4880190wra.10
        for <git@vger.kernel.org>; Sat, 04 Jun 2022 08:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=C57EOsQD1Hj3vucysrC8hSJodcPHBVjhsdXkoHs+j1I=;
        b=LH8duiaKWUiEnBL0duK5UMEVcT+DDWl69r1OznCCB1Ec1eMTOONX32pTzOoUCdn6DL
         9c/k/Sa1nEHjIddik1M0dW+NgOnWtwrFFZqIK01YLUV/CfVg9xkEcrr2mm95ogOxMWYT
         Au4x7h2r7lIM/cMvTYMGyBISsML4MmHlIkMqcPQNNUK+ZwRlLuzlMvfCMHBTeZnXdzsk
         txjxlF94HfyAWipTXYL1Hgq4uY3XGAq+nRzV35sRJ23cbSS+I+iD9SEjIa9C5vk7eawb
         ALt7VQWCzNaSY1xiGodhYaus7E0XnBGi0A4s6q/mBoM7P11YTc/GdyKbXjwTODlhlvLR
         Cjnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=C57EOsQD1Hj3vucysrC8hSJodcPHBVjhsdXkoHs+j1I=;
        b=rZj9gmA7oZKP36au81BxF//INF4AsmYH22ZTHOWWAtxFR3DFtRIijb6uSKQzPrLjQj
         tO4ywsOm5mewyEfiww7OEKJfKgILklJ0MUrtZ4ke3EZaeyemth35gNf0alLi6QFfvRWJ
         9Ti169OHh22F7ryjmBzHxsgA0cTqSX7knw7TLs3OHnEYlcGpy36zi4EW18/KYRG4hdeZ
         pjMk8qULDfFy+en2dMzytZG67cLIYZpAM3GInjVHcRusZkNOdGnVAAJlTEIiSR18o7Un
         DswNUKJ7bzGS3B11R+hZc1PjIRnrSHx7sLoa1aExWlNDY9ZL9nuUNhuQ9tnkCrQJtXoq
         9IZw==
X-Gm-Message-State: AOAM5300qKCRX7KAgDNQ7RlWamWnUYytecDd0Xpu0QFtMFM4cQ+FWdqF
        Plpt088J6oFHuFxZ3CGHqmE=
X-Google-Smtp-Source: ABdhPJzRnlGPH6BpbiodqdgG8T/xf/RXaLNHf8uhPxEJCDdKbhWfqbg7ThkkOqvqVI6uUFFDdLnIDg==
X-Received: by 2002:a5d:594f:0:b0:213:d715:cec7 with SMTP id e15-20020a5d594f000000b00213d715cec7mr7904248wri.44.1654356522838;
        Sat, 04 Jun 2022 08:28:42 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.192])
        by smtp.gmail.com with ESMTPSA id m19-20020a05600c4f5300b003942a244f2esm17334637wmq.7.2022.06.04.08.28.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Jun 2022 08:28:41 -0700 (PDT)
Message-ID: <a63cba6e-d25a-ee6d-57f0-9562b6235d3b@gmail.com>
Date:   Sat, 4 Jun 2022 16:28:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/4] rebase: update branches in multi-part topic
Content-Language: en-GB-large
To:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1247.git.1654263472.gitgitgadget@gmail.com>
 <YppSl4rOvVciLuXE@nand.local>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <YppSl4rOvVciLuXE@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/06/2022 19:27, Taylor Blau wrote:
> On Fri, Jun 03, 2022 at 01:37:48PM +0000, Derrick Stolee via GitGitGadget wrote:
>> This is a feature I've wanted for quite a while. When working on the sparse
>> index topic, I created a long RFC that actually broke into three topics for
>> full review upstream. These topics were sequential, so any feedback on an
>> earlier one required updates to the later ones. I would work on the full
>> feature and use interactive rebase to update the full list of commits.
>> However, I would need to update the branches pointing to those sub-topics.
> 
> This is really exciting. I'm glad that you're working on it, because I
> have also wanted this feature a handful of times over the years.

Yes, thank you Stolee. I agree this will be useful, but I wonder if 
users will be confused that --update-refs only updates the branch heads 
that happen to be in the todo list, rather than updating all the 
branches that contain a rewritten commit. I think the latter is 
something we should try to add in the future and so we should take care 
to design this topic so that is possible.

> This definitely would have come in handy when writing MIDX bitmaps,
> where I was often editing a local branch pointing at the final topic,
> and then trying to reconstruct all of the intermediate branches after
> each rebase. Not ever having to do that again sounds like a delight ;-).
> 
>> pick 2d966282ff3 docs: document bundle URI standard
>> pick 31396e9171a remote-curl: add 'get' capability
>> pick 54c6ab70f67 bundle-uri: create basic file-copy logic
>> pick 96cb2e35af1 bundle-uri: add support for http(s):// and file://
>> pick 6adaf842684 fetch: add --bundle-uri option
>> pick 6c5840ed77e fetch: add 'refs/bundle/' to log.excludeDecoration
>> exec git update-ref refs/heads/bundle-redo/fetch HEAD 6c5840ed77e1bc41c1fe6fb7c894ceede1b8d730
> 
> But I wonder if we can or should delay these update-refs as long as
> possible. In particular: what happens if I get past this "exec" line (so
> that I've already updated my bundle-redo/fetch branch to point at the
> new thing), but decide at some later point to abort the rebase?

Absolutely! There is also the question of what to do if a user skips a 
commit that is a branch head. It is not obvious if they just want to 
drop that commit from the branch or if they want to skip updating the 
ref as well (I guess they can edit the todo list for the latter case).

> I think users will expect us to restore bundle-redo/fetch to where it
> was before if we end up in that case. Recovering from it manually sounds
> like kind of a headache.
> 
> What if instead we created labels here, and then delayed all ref updates
> to the end by replacing this with:
> 
>      label bundle-redo/fetch

Instead of using 'label' and 'exec' I'd prefer a new todo list command 
('update-ref' or 'update-branch'?) used in place of 'label' that takes a 
branch name and updates the branch ref at the end of the rebase. That 
would make it easy to do all the updates in a single transaction as you 
suggested. Adding exec lines to do this makes the todo list messy and we 
have been trying to stop rebase forking all the time.

Best Wishes

Phillip

> and then at the end of the todo list we'd add:
> 
>      exec git update-ref refs/heads/bundle-redo/fetch refs/rewritten/bundle-redo/fetch
> 
> If we do all of those ref updates in a single transaction at the end, it
> should be much easier to roll back from if desired, and we'd avoid the
> aborted-rebase problem entirely.


> Thanks,
> Taylor

