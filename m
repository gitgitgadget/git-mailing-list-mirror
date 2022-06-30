Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330A2C433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 20:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237262AbiF3Upv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 16:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233355AbiF3Upu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 16:45:50 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148D545519
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 13:45:50 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id a10-20020a170902ecca00b0016a50049af0so206854plh.10
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 13:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8COaSrJsacmLZ6k/7KrYaK3PGkccaUXi4/zw4uPagHQ=;
        b=JUiainzOwB9J5QfzInN0fSrpI+4bmvFNRaHTGetxzgbnqowJHN06Ty6FyY8wQYdGXY
         K1NqUNAwIyAH6yh0fXaJP25m+Pa4G+9p9viekN8hKYDC0MIPPTrMGfreXvxNOLeP+Rz6
         nt+vZlCPYXBAN+ZViOd8Ox/EG1s1PUSLDDbX1iazT7Zkkis4m+9VzuuRN5IGpPgouhMj
         fktN6ki19TcAe7wOX+FYRazxzahK23Xmiif4R8BkDMcpJ6blS57O23DjxQiPQJmem2G3
         sFIf849qsZYCRWseyJUNuqH3aMA0tqvpIW8oS7beyZ++pGzbPYQBaUt50B4D6IgjyaNq
         hZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8COaSrJsacmLZ6k/7KrYaK3PGkccaUXi4/zw4uPagHQ=;
        b=qfMiJ0B7qSBs2nndmlAjB6q5+HRi7JdyfLd2y7Xm1C7vAa8g3/zd8/FmK9LUbgYlE8
         k9ao+yENZkXH05kmOuFF/axANvcTi9tDoC2YDqWFTMiM9OIVfxMfWExA3Mcq2iiDI1BV
         wgKvdXDpwjVX5NTgDFRuwuaH5DcLTv1aTxNK1f4tlB+ooFzJMpOZCW7nq4Uz5rD/G9dX
         xwrYxvR1YmIMsHnAdAFbeI6ZWS0Sm/iSkDuHctA7lMHVnxnJkBIltGd/KcfBsr/jV8VC
         ysXF4UA7KwSO+wwQg0BenHA8bqVh2cmi/tG381M159wRnRYUjDzySvzPF4Ei03hbZPyG
         MdRg==
X-Gm-Message-State: AJIora8h1ybwmg+BNzbImqRQRWmzrlZLPRDZUdb0Na6kDjNJu7igAxQ0
        dcQdlS2ZuwziznDUnKNOjMx76DuzaH6C9Q==
X-Google-Smtp-Source: AGRyM1uAvb1ypcYJQGY1OFWXiSpas/5W5cOxahGSlhIch60UX0WmLMjyuPqserIL8exHNObsxp4VjrhraF2poQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a63:3184:0:b0:40d:7801:e7e with SMTP id
 x126-20020a633184000000b0040d78010e7emr9082438pgx.333.1656621949646; Thu, 30
 Jun 2022 13:45:49 -0700 (PDT)
Date:   Thu, 30 Jun 2022 13:45:42 -0700
In-Reply-To: <kl6l35flubx8.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-Id: <kl6lzghtsww9.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220629224059.1016645-1-calvinwan@google.com> <kl6l35flubx8.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v3] submodule merge: update conflict error message
From:   Glen Choo <chooglen@google.com>
To:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, levraiphilippeblain@gmail.com,
        Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Hi! I have a suggestion for the output text; I haven't looked closely at
> the code changes.
>
>> If git detects a possible merge resolution, the following is printed:
>>
>> --------
>>
>> Failed to merge submodule sub, but a possible merge resolution exists:
>>     <commit> Merge branch '<branch1>' into <branch2>
>>
>>
>> If this is correct simply add it to the index for example
>> by using:
>>
>>   git update-index --cacheinfo 160000 <commit> "<submodule>"
>>
>> which will accept this suggestion.
>>
>> CONFLICT (submodule): Merge conflict in <submodule>
>> Recursive merging with submodules is currently not supported.
>> To manually complete the merge:
>>  - go to submodule (<submodule>), and either update the submodule to a possible commit above or merge commit <commit>
>>  - come back to superproject, and `git add <submodule>` to record the above merge 
>>  - resolve any other conflicts in the superproject
>>  - commit the resulting index in the superproject
>> Automatic merge failed; fix conflicts and then commit the result.
>>
>> --------
>
> I'm hesitant to recommend a plumbing command like "git update-index" to
> the user, especially if the user is one who needs help resolving a
> submodule merge conflict. I also believe this would be the first time we
> recommend "git update-index".
>
> To do this using only porcelain commands, maybe:
>
>    git -C <submodule> checkout <commit> &&
>    git add <submodule>
>
> (Though this might need to be broken up into two commands because I'm
> not sure if we ever include "&&" in a help message. I'm guessing we
> don't for portability reasons?)

Gah, ignore everything I said here. I should have read the thread
closer:
- The update-index suggestion didn't come from you; it had already
  existed prior to this series.
- Both Philppe and Elijah have already suggested the exact same thing.

