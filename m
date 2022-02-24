Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50921C4332F
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 16:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiBXQtX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 11:49:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbiBXQtP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 11:49:15 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6041AF8E0
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 08:48:43 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id ba20so4665884qvb.1
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 08:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bLZRCRDgJTW6QX3ddwzJahDB7tQihr52Ug1p/WJeBec=;
        b=MLfeYRu+QS7d2EzU4274PYHbVPIQUdjKVJ9k0XWt/CjaIg8tup7uN8udA4yS5JYr3D
         2MEtzQZi4yyAqhVtCSyTcP7kNt4SKFnB9IQI0Ol0+apdOJPxH5VaDa4CuydQT9FSGtsR
         SZiF3OlTCoCKqNnzaiBG5q9VH1KCEcuCeZ1PVEeQf+bbtfJw5ZeGtpzvq7elI/OJfucK
         11OPM2d9WY+MMIa1mF3gzDJsZ2Vvy/0n0z9HWtHTMIsNaWiClIv2UHT+CENNleJpnw7W
         Gk+JwCRFX3w0yxsh32EXHfES++fHvAh3XUmbQF/MYztjzJ2orztqjxSnqfmgln8xmuvT
         54Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bLZRCRDgJTW6QX3ddwzJahDB7tQihr52Ug1p/WJeBec=;
        b=dX2zAWsdjtl/zwuN0Wfz0tylEuu9k5Sc86DHAoj5+TDsndVEhT0UPVHC6KIJVwxXYQ
         AABPacQrenk2Qi3HDzvmcY9cdOxgF0AphzrpiMEd7pZmSGil3iRND/HfjQMfZfRS3U0+
         nnKXxHpdNkZE9TngOFszoUW5rbeLbowS8Sw2WDF19YrtUvMQrOeGNf4Z42uWjwmzl0GI
         7cEmvrhnxYSQ+wH5UJf0nwZjsNHCuHagKOOWu+ZjfgykAnxaFSFs3rxeWMWAMDwLxk6Y
         rx+HOxkNiPCeFVsa7VAJqiUOlWnKc6oMKTFGXArL46r9DSW774lpjhI/t9O0jINYtWER
         OA1g==
X-Gm-Message-State: AOAM5333q3/SxzH0YYIf5sBtqNXzQoV+HN5YVuVU4If0TTJaPjMhZp1+
        q5+70U8LGTFE5pjaYtkCBV1EXDBCYUUj
X-Google-Smtp-Source: ABdhPJw+4BhUQ8FEfMXo0dfeH95eFqpB3Nc2rwSsP8JXvzdwi7Ht4zbDZMdQRr5OMEhGYYAdInGGkg==
X-Received: by 2002:a05:622a:94:b0:2de:88ff:438a with SMTP id o20-20020a05622a009400b002de88ff438amr3181309qtw.60.1645721322304;
        Thu, 24 Feb 2022 08:48:42 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id s11sm1925472qta.74.2022.02.24.08.48.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 08:48:42 -0800 (PST)
Message-ID: <ee861471-d870-f2e4-4f3b-3aea467d8415@github.com>
Date:   Thu, 24 Feb 2022 11:48:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 1/7] sparse-index: prevent repo root from becoming sparse
Content-Language: en-US
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>, Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.1157.git.1645640717.gitgitgadget@gmail.com>
 <90da1f9f33a1383ba199f9b11e9890bc67e56edf.1645640717.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <90da1f9f33a1383ba199f9b11e9890bc67e56edf.1645640717.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/23/2022 1:25 PM, Victoria Dye via GitGitGadget wrote:
> From: Victoria Dye <vdye@github.com>

Aside: It looks like you have the same "mailto:" email addresses in the
CC similar to a mistake I made. The root cause of my issue was that I
copy-pasted from the rendered description of another PR instead of
copying the plaintext available by clicking the "Edit" button. Perhaps
this is worth extending GGG to prevent this issue in the future.

> Prevent the repository root from being collapsed into a sparse directory by
> treating an empty path as "inside the sparse-checkout". When collapsing a
> sparse index (e.g. in 'git sparse-checkout reapply'), the root directory
> typically could not become a sparse directory due to the presence of in-cone
> root-level files and directories. However, if no such in-cone files or
> directories were present, there was no explicit check signaling that the
> "repository root path" (an empty string, in the case of
> 'convert_to_sparse(...)') was in-cone, and a sparse directory index entry
> would be created from the repository root directory.
> 
> The documentation in Documentation/git-sparse-checkout.txt explicitly states
> that the files in the root directory are expected to be in-cone for a
> cone-mode sparse-checkout. Collapsing the root into a sparse directory entry
> violates that assumption, as sparse directory entries are expected to be
> outside the sparse cone and have SKIP_WORKTREE enabled. This invalid state
> in turn causes issues with commands that interact with the index, e.g.
> 'git status'.
> 
> Treating an empty (root) path as in-cone prevents the creation of a root
> sparse directory in 'convert_to_sparse(...)'. Because the repository root is
> otherwise never compared with sparse patterns (in both cone-mode and
> non-cone sparse-checkouts), the new check does not cause additional changes
> to how sparse patterns are applied.

Good catch! I agree with everything said here.

> +	if (!strlen(path) ||

Instead of a full strlen(), could we just check "if (!*path ||" to
look for the nul byte?

Thanks,
-Stolee
