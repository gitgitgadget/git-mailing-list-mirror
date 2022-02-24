Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB1CC433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 21:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbiBXVnY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 16:43:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbiBXVnX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 16:43:23 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE8B1E5001
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 13:42:53 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id iq13-20020a17090afb4d00b001bc4437df2cso3116631pjb.2
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 13:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=EJtmS5Q0sLZlScD2acDOkR2Tr9QldHgpNVfJ46Qxl6U=;
        b=e3iI54D8nqd6MMF7OVQ0TvcxkQOFwmcRhNU2JdC590E514F6SA1WwwVNkfltfTtEBS
         G+3jWzXvKAmy1RfXvbd8Yo6hfyHiv9poePYVGzmz3YglrFSFasyqtSE+pO3To/ubVmzl
         uRCusladqIRkW4odfsKoaNXBzHGYOp20QNRfcZGtP8WR1q3Vh4oQZOm2/vimE0Gzm4v2
         VApXoHSSCJawLn4BLRRwS1ixldDjTjgN0hQhYm61fflf43MXvRxso3g6ejcdagy5hlaR
         yFTv9Dy5uQk8RfjbYhborVQlGJpvIMI2SltbEMOtZrTx5zVZlXFyfjIKIHDoUdATcdKa
         sQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EJtmS5Q0sLZlScD2acDOkR2Tr9QldHgpNVfJ46Qxl6U=;
        b=JMG6OF7M14ZfAaOhxN7fcfJf97h4XCUsiItWRt6tqCILTTkOdh6RfrxsM/VLSIDAU3
         otJaTW9hhWTNCzuJMuw5S8CSqT00L9UMW1PPGT7fn6LXwgoIBaDfrVHZF7jtOzRpHmfc
         Q3iudYsSLmXk3TmQ4fnCO9EsRzLNmlUNpDm8NNcVmtMFT6HEvMvkFqWL81WCyj+IrlqT
         1ZpqtnCNAeldijP6BIGkt1f7kAODe78fhRJ/6D3MGC9MS/dCUa3H1CrWhk8ezBMBzPaI
         AiO5CMJ+UgIzGs8xZxGkloIPtr9mxOtuiai+4JZwrwRe4oDf4vAqWYPCLQRv/MsV2fc8
         gFnA==
X-Gm-Message-State: AOAM530B9l/6EYj/Mz+beZi9vP/ZW9tzPzpT94p3KAxwl0sDAR4gEBZc
        vNDDuZtJvjB118xbwkO0r7YK0cE44JvY
X-Google-Smtp-Source: ABdhPJwqoJiKk0up7tFkf1CDo9PLUA2Szx3qNaHRII03tkgq6Xq0PAOklKEKV6c0enqsq55UxOP8qQ==
X-Received: by 2002:a17:90b:2243:b0:1b9:e528:5496 with SMTP id hk3-20020a17090b224300b001b9e5285496mr93283pjb.240.1645738973024;
        Thu, 24 Feb 2022 13:42:53 -0800 (PST)
Received: from [192.168.0.102] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id q22-20020a17090a2e1600b001b9c387d0f5sm7202695pjd.28.2022.02.24.13.42.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 13:42:52 -0800 (PST)
Message-ID: <46428e01-ee6e-36c8-8bbd-1119d9ee2975@github.com>
Date:   Thu, 24 Feb 2022 13:42:50 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH 1/7] sparse-index: prevent repo root from becoming sparse
Content-Language: en-US
To:     Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.1157.git.1645640717.gitgitgadget@gmail.com>
 <90da1f9f33a1383ba199f9b11e9890bc67e56edf.1645640717.git.gitgitgadget@gmail.com>
 <ee861471-d870-f2e4-4f3b-3aea467d8415@github.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <ee861471-d870-f2e4-4f3b-3aea467d8415@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee wrote:
> On 2/23/2022 1:25 PM, Victoria Dye via GitGitGadget wrote:
>> From: Victoria Dye <vdye@github.com>
> 
> Aside: It looks like you have the same "mailto:" email addresses in the
> CC similar to a mistake I made. The root cause of my issue was that I
> copy-pasted from the rendered description of another PR instead of
> copying the plaintext available by clicking the "Edit" button. Perhaps
> this is worth extending GGG to prevent this issue in the future.
> 
>> Prevent the repository root from being collapsed into a sparse directory by
>> treating an empty path as "inside the sparse-checkout". When collapsing a
>> sparse index (e.g. in 'git sparse-checkout reapply'), the root directory
>> typically could not become a sparse directory due to the presence of in-cone
>> root-level files and directories. However, if no such in-cone files or
>> directories were present, there was no explicit check signaling that the
>> "repository root path" (an empty string, in the case of
>> 'convert_to_sparse(...)') was in-cone, and a sparse directory index entry
>> would be created from the repository root directory.
>>
>> The documentation in Documentation/git-sparse-checkout.txt explicitly states
>> that the files in the root directory are expected to be in-cone for a
>> cone-mode sparse-checkout. Collapsing the root into a sparse directory entry
>> violates that assumption, as sparse directory entries are expected to be
>> outside the sparse cone and have SKIP_WORKTREE enabled. This invalid state
>> in turn causes issues with commands that interact with the index, e.g.
>> 'git status'.
>>
>> Treating an empty (root) path as in-cone prevents the creation of a root
>> sparse directory in 'convert_to_sparse(...)'. Because the repository root is
>> otherwise never compared with sparse patterns (in both cone-mode and
>> non-cone sparse-checkouts), the new check does not cause additional changes
>> to how sparse patterns are applied.
> 
> Good catch! I agree with everything said here.
> 
>> +	if (!strlen(path) ||
> 
> Instead of a full strlen(), could we just check "if (!*path ||" to
> look for the nul byte?
> 
> Thanks,
> -Stolee

I'll reroll with corrected CC's & make the `strlen` -> `*path` change.
Thanks!
