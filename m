Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1084C433F5
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 10:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAD3F61039
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 10:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbhJYKLF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 06:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbhJYKK7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 06:10:59 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4170BC061745
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 03:08:37 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 84-20020a1c0457000000b003232b0f78f8so12562577wme.0
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 03:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZMEqP+ANJiKnV6dVraQg/K8We/PepyUHf2BmDJWmL1M=;
        b=B7qw0CiszX6aT2fmoiifjkUzcyoI0sFQ7Prm+M4uYXSbe0R67lK7eXjgKi0azaKARf
         Q3Rb/4b24XhFb91AXveaedjPZ9/W0zCySXNrB8IED+ls+k+uxrX6wI6bPpC9aVmaQOOM
         RmvCk3geVwEu/x8h5t+o2aYI91bzdEy3AYE3KFpO5kRVITZl+h8OCZFMnw8bBpDryq8M
         7w5/kDOaEQ2ct5E/93KuYYaUNlltjBUtIFYN6298/gnyQcueLIm6K678TtBp+CzVfgd/
         OaGnDsDG2CuNl8Sma/OMAYW4WF7vJDBXhC0S8G3nyoD/62UGZ2YWAkDKsw1E5ge/0OVI
         csBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZMEqP+ANJiKnV6dVraQg/K8We/PepyUHf2BmDJWmL1M=;
        b=GOfF91tqV+BSDmnMh34hc9YFTywoR7JtqAzdMbBEXpcztBQrilLkILJQuHDNFonh+Z
         daBSdGvCfQ8tIx4y8CTX1huj8cuuO2TKiICdHUWOWYGo1lqN+D3acwRhAgwtG4o2Ee7B
         LsUDvjEMAHYfvRiEuaJXiKZ530BgDzxdyDMqNvvylD19lnok81q3Pwq3ydf9NT2uMk7/
         nO8yMlPnryXWf/XoNJd70MH6ZI/1IJUIYTMcDX7Zd1WEiA22K8G82SgfzXlhSXnpwv6m
         Va0gB7U8B//pGD/PVbFQQRW7FoQsdkf1YbLVuUFU3Z5PYp5acwKqFk9VJO6u3mOBhnKF
         z/lQ==
X-Gm-Message-State: AOAM532TFSWffuWh60UtRgo/LJHLzPJ2GhJAa5NrGrApdlHTFN9g9z5t
        /ETrk4TdQcZ4mjBA5+xhghc=
X-Google-Smtp-Source: ABdhPJygsHJ2fDWgEIAiP2s8r0tE32OKM8eIvUstksxRhiglaw5MD/AGmb1sQHMta3Df2DN7Kjd6iQ==
X-Received: by 2002:a7b:c144:: with SMTP id z4mr19500608wmi.13.1635156515852;
        Mon, 25 Oct 2021 03:08:35 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id a134sm7843817wmd.9.2021.10.25.03.08.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 03:08:35 -0700 (PDT)
Message-ID: <47c45a9e-649d-89cc-3d7e-3dcea54bccb5@gmail.com>
Date:   Mon, 25 Oct 2021 11:08:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Unified workflow for `git add/checkout --patch`?
Content-Language: en-US
To:     Timothy Eccleston <timothy.perisho.eccleston@gmail.com>,
        git@vger.kernel.org
References: <CACYzLDcFjwaJkgVUemD_KqkoGhV_5OYrECddDuxa-o5FpZ6XMA@mail.gmail.com>
 <CACYzLDcO4OATYYZ6AtJnJTKS9EKUKNRJY5_Rb=y62gWFFwoDhg@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CACYzLDcO4OATYYZ6AtJnJTKS9EKUKNRJY5_Rb=y62gWFFwoDhg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Tim

On 21/10/2021 23:19, Timothy Eccleston wrote:
> Hi,
> I really like both these features:
> - git add -p
> - git checkout -p
> 
> My typical workflow
> I like to use them after a long and complex coding sessions where I
> want to double-check my work, making edits and adding sets of patches
> into sequential commits to keep related changes together topically.
> 
> In the process of using git add -p to grab some patches, I may notice
> other patches I don't want (especially after I've used the "e" command
> in `git add -p` to edit a patch - I usually want to drop the
> remaining, unstaged version of the patch right then). But, instead, I
> have to go through git add -p and then git checkout -p and likely back
> and forth several times, each time skipping through all the same
> undecided or postponed patches I am waiting on for later.
> 
> Note: I recently discovered the "j" and "J" subcommands which are
> useful to postpone decisions on certain patches, but only if I
> restrict myself to just git add or git checkout. If I want to do both,
> I still have to cycle back through from the top each time. I suppose I
> could use stash -p to really hide patches I'm saving for later, but I
> still have to exit my workflow and start another command, requiring
> multiple passes. OTOH, a unified git add/checkout/stash --patch would
> be amazing!
> 
> My request
> It would be really nice if there were a unified command workflow where
> I could add or checkout patches or even partial patches (after editing
> a patch in git add), on a case by case basis in a single pass.

I think I kind of see what you want but I'm a bit confused as how it 
could be implemented. To clarify do you want to checkout the index to 
discard the changes in the worktree or checkout HEAD (the later would be 
difficult as 'add -p' shows the differences between the index and the 
worktree)? Have you any thoughts on how the user would select whether to 
add a change to the index or discard it from the worktree? It gets a bit 
tricky if you want to stage an edited version of a hunk and discard the 
unstaged portion from the worktree but I guess we could apply the 
reverse of the original hunk to discard all the changes and then apply 
the staged version of the hunk to get just the changes the user wants. I 
think the main challenge would be with the user interface.

Best Wishes

Phillip

> Does anyone know a way to do this or do you think it's worth making a
> new feature in git to handle it?
> 
> Thanks!
> Tim
> 

