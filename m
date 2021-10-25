Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58A9C433F5
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 16:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC7ED60E73
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 16:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbhJYQTw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 12:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233855AbhJYQTw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 12:19:52 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0406C061745
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 09:17:29 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id q6so12167942iod.7
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 09:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=c0f9u8QKuBs+wxQ+8uFy3YEZbzjT45yvPlhTXTALXZg=;
        b=BB57O4AF1sSZufxMCmVkJWICdm3IcHNXkyaPIWs2Jejf32UKYQN8jiRpgY+aUcav4Z
         wDeh+RfH8Ed2/7OJSV9iXGgHNDtyKKr1EberJ0UKieMFPLocZcocKmVf40OSwBQZIKJ9
         Gq1LR51gzKnJrBjSYpRHmNj/SS4qa34wD2I2Bjfp1TRCBGz7mU4hM8rrdFfUwRP5aFZV
         Eccz/nog8SrpDLWt14A/lQoMc6VZsc5n+baB+fnG2FCAeStQgNHUkRJGio/wPzvzX05b
         6g701PWgPWguLw87Od+cpJcgqaA8UFhOZ7KexwKMiVm5lEN5A6wWkYeGMwc95ar5egU5
         FDcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=c0f9u8QKuBs+wxQ+8uFy3YEZbzjT45yvPlhTXTALXZg=;
        b=Ru2hCADMXwKX5T96rXn6wfUPVriWEzHnD/C21HglHAim8EpOGUXEyjpa0GM1wKZIJw
         +/da/RP+uXScULiwSC1gaE8r+dZ3xfAJTqgMNOC9ZfrN3i87tpAud8rgA0n1suM/jP9n
         kJhW2xAE2vD0hjC1rrPB8bGQr5cxGRPMSlKd49s7J0hpHiKqbH4R68EYySjPf3r9PET/
         MCC0/hlnUQfYNqJFtxAxAIaU7r1blLtpFrmuX4pRmRWYjzXK7n7Io2ws+fe8q/qOqC6R
         wBQNY7+js2yDZu/JGggyrTut/durkJpIF14WiK18KvqBukZgaK+XidvsVkolYcRd1POZ
         BRZA==
X-Gm-Message-State: AOAM532ZncdoHRG4oaS0Mr27Amf+XGE6ZDW+LVWNNLeeopLA1VgC4MsM
        LCq4Tk/11TxNlYa/b91z+FA=
X-Google-Smtp-Source: ABdhPJyY9acUjqYl0JpMe1nEuBeQJvwsKdXh6aqNMZ6ImE2toObCrbozd4YedkfFhRyONQ4KTSStIQ==
X-Received: by 2002:a05:6638:3723:: with SMTP id k35mr11435458jav.104.1635178649100;
        Mon, 25 Oct 2021 09:17:29 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:b594:8626:d264:bb0? ([2600:1700:e72:80a0:b594:8626:d264:bb0])
        by smtp.gmail.com with ESMTPSA id w7sm7755529ilu.35.2021.10.25.09.17.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 09:17:28 -0700 (PDT)
Message-ID: <6ad1f4bc-25cc-8c0d-2bf2-900c94d717d9@gmail.com>
Date:   Mon, 25 Oct 2021 12:17:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v4 4/4] submodule: record superproject gitdir during
 'update'
Content-Language: en-US
To:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
References: <20211014203416.2802639-1-emilyshaffer@google.com>
 <20211014203416.2802639-5-emilyshaffer@google.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20211014203416.2802639-5-emilyshaffer@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/14/2021 4:34 PM, Emily Shaffer wrote:

> +			sm_gitdir="$(git -C "$sm_path" rev-parse --absolute-git-dir)"
> +			relative_gitdir="$(git rev-parse --path-format=relative \
> +							 --prefix "${sm_gitdir}" \
> +							 --git-dir)"
> +
> +			git -C "$sm_path" config --worktree \
> +				submodule.superprojectgitdir "$relative_gitdir"

This use of `--worktree` is good because it acts the same as `--local` if
config.worktree doesn't exist. If we discover it is too challenging to find
the correct config file in-core, then we could call this command as a subprocess
in patch 3.

Thanks,
-Stolee
