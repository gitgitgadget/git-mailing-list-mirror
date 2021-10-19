Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87441C433F5
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 12:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63B1D61378
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 12:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbhJSMcO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Oct 2021 08:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhJSMcN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Oct 2021 08:32:13 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBC1C06161C
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 05:30:01 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id u69so4664401oie.3
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 05:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bPyLOvr/t8W+mwRLo3mYI4QD+BHHiNErY5nXXQ8YHaM=;
        b=Yw/ndjahH4vjVD4CuJzcFAmY5K1oZiugyNSc6zg+UwwVDp3Lr2l+bvM9u1KbNyADJK
         AUbi25serTuXXJXoKgj3EfU/dnzQdJ8h4V/E/7agKi2RlYv/299r7cHTS5nZEzdUMZ5Y
         xe8+T8PXUFlZB8Wm2kwBXduQHfeP7zA2EsPdT/OKXlLmVEJxckpY3Tm9XUwD6nkRAv94
         N9cbrMNbQvCvG/CdHrreV5qwGracfd5/vT7barZbiOisb4fF2iv76lB09TrhL3GQ+Tzj
         AQJF5EZQYY3IVg9OATUD7G3yvKOACze7fYuKCm/Em6wZLoNF+4BhoabSuDT8Ad/7YkdS
         1v/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bPyLOvr/t8W+mwRLo3mYI4QD+BHHiNErY5nXXQ8YHaM=;
        b=u55li5bc10P8a7Lyl62WLlGekY/4g9iUgxSjLp5S8gakF7XjBIs8NlSsyF62Wfv27r
         m+5Dym14WBZLb1YYC0iKbeWAsIpx6b5tJveCFsqed7Lt/llTHLKNASi/oY1c0SWkWRL2
         qHbNpe1u+Qr1dHAxX1xdMHdNf6dWC5jdPbFgjgxr0zZsQCxn624ho/L0rk7E1jvvOTdW
         Mn8OmwD8QDSgsVFxrBtsI6d1QAErv7NIJcfMAqq4/MOKPUiXTpCIjxj/2Rd1kqF45P4g
         thXQbb2MGbTmNWgl7KsSLDcbWHRlFBafijttM/Dqnc2tsuLf8S1Tsic05d1pUH8X2kJB
         hWqw==
X-Gm-Message-State: AOAM530OcWdxGoLNXJv8axHt9sXdP0gVVC1qMPYxe7BJ+WiHE/EZcRWr
        J9gTYb4hKX67EO3xL319QG0=
X-Google-Smtp-Source: ABdhPJy21E8WnBvnPjMNSLzgS9bEGp1bOQW3dHRT8Cf0LRZeIhf6N6ztA2Uuo/BmaHFmgkyQUsNs6w==
X-Received: by 2002:a05:6808:bc5:: with SMTP id o5mr3797854oik.129.1634646600381;
        Tue, 19 Oct 2021 05:30:00 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:9145:f5c3:60a6:a1c8? ([2600:1700:e72:80a0:9145:f5c3:60a6:a1c8])
        by smtp.gmail.com with ESMTPSA id 103sm3668316otj.44.2021.10.19.05.29.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 05:29:59 -0700 (PDT)
Message-ID: <00188c99-386f-8d4f-08f6-11a49d31184c@gmail.com>
Date:   Tue, 19 Oct 2021 08:29:58 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 00/14] Sparse-checkout: modify 'git add', 'git rm', and
 'git add' behavior
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, gitster@pobox.com,
        matheus.bernardino@usp.br, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
 <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
 <YW3nAKAUj/HF15OR@google.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <YW3nAKAUj/HF15OR@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/18/2021 5:28 PM, Sean Christopherson wrote:
> On Sun, Sep 12, 2021, Derrick Stolee via GitGitGadget wrote:
>> This series is based on ds/mergies-with-sparse-index.
>>
>> As requested, this series looks to update the behavior of git add, git rm,
>> and git mv when they attempt to modify paths outside of the sparse-checkout
>> cone. In particular, this care is expanded to not just cache entries with
>> the SKIP_WORKTREE bit, but also paths that do not match the sparse-checkout
>> definition.
> 
> I suspect something in this series broke 'git add' and friends with "odd" sparse
> definitions (I haven't actually bisected).  git 2.33.0 rejects attempts to add
> files with the below sparse-checkout and modified files.  There appears to be a
> discrepancy in the query vs. checkout logic as the rejected files are checked out
> in the working tree, e.g. git sees that the local file was deleted, yet will not
> stage the deletion.

Are you using v2.33.0? This change is not in that version.

However, mt/add-rm-in-sparse-checkout [1] was introduced in v2.33.0 and
introduced these advice suggestions.

[1] https://github.com/git/git/compare/a5828ae6b52137b913b978e16cd2334482eb4c1f...d5f4b8260f623d6fdef36d5eaa8a0c2350390472

The series you are commenting on goes even farther in restricting adds to
be within the sparse-checkout definitions, even for unstaged files or files
that removed the skip-worktree bit due to a merge conflict. It also creates
an override '--sparse' option that allows you to ignore these protections.

> There's also arguably a flaw in the "advise" trigger.  AFAICT, the help message
> is displayed if and only if the entire path is excluded from the working tree.
> In my perfect world, git would complain and advise if there are unstaged changes
> for tracked files covered by the specified path.
>> Note, my sparse-checkout is very much the result of trial and error to get the
> exact files I care about.  It's entirely possible I'm doing something weird, but
> at the same time git itself is obviously confused.
> 
> Thanks!
> 
> $ cat .git/info/sparse-checkout
> !arch/*
> !tools/arch/*
> !virt/kvm/arm/*
> /*
> arch/.gitignore
> arch/Kconfig
> arch/x86
> tools/arch/x86
> tools/include/uapi/linux/kvm.h
> !Documentation
> !drivers

Have you tried using 'arch/x86/' and 'tools/arch/x86/' to specify
that these are directories? Just a thought.

> $ git read-tree -mu HEAD
> 
> $ rm arch/x86/kvm/x86.c
> 
> $ git commit -a
...
> 	deleted:    arch/x86/kvm/x86.c

This is certainly odd. Worth more investigation that I don't have
time for at this moment.

Thanks,
-Stolee
