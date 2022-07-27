Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA49C04A68
	for <git@archiver.kernel.org>; Wed, 27 Jul 2022 19:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236192AbiG0TR2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jul 2022 15:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236149AbiG0TRM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jul 2022 15:17:12 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69842BAC
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 12:07:11 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id v28so13935097qkg.13
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 12:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Fxhm1b+AAZgv9mzfW2cGTHeJ97hkmbEBeQw96rUl8xI=;
        b=jLwS0lwjRjzMh3j8DL+8LhZ9WShwC2wnJ2OtO0HfVVSkW6nSzqDVeprsk1gsHdHpMJ
         sUwlXJa5CFbVZCs9pHzGTyUGx3iF4UYkRpMV6iG2Vd/eZL1M+tyro0WVJJ5hJaR0lc9p
         JAv40rasixU8sj5A2ET5bNwHfeXL9JnV2ghje7+H2kwbPveDFk1zTbqJ9gt7X37Ztt87
         1R0oAdzmNC9X2gy8cpKvz8+57XUsmLsfcvAp21SQiHx2nE4OsS4FaXWKjoyhw2CyW8FF
         i1uxvSHWlOxwv2tB5dEmvqQbXoBHPWXZJb8/swJUnH8n3IFtEVFdoFNttVnbnXwewrEI
         gKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Fxhm1b+AAZgv9mzfW2cGTHeJ97hkmbEBeQw96rUl8xI=;
        b=UF61K+0/VcKatYMsMYzuhhSxw1N23rnAosMl5lg0yx2kL7JNMqplALzihZAgdlc2Bs
         RWlLm8qSIPKW6NaTatYR0EPuD4JgdP/tU3jyPxMuCyGOS0M3aFzAdTjQdZXkGTSr/CZg
         8BeZPruMf+QG+gXgX3AFIMJCWbOUXmAG1AKamZp6s4hS5W9tVFwJVqs5K+pe10e4XgXu
         rFLUnw0hKUowpJtRqBTpR4U+9Fys5uaPXGFEvNpQkYThtGPpI5d3rZpQc6d+4ciXcnf3
         X61dDFo4uPmZJb0mkyDp13yrh0xP6S+7BYmKnbxUvg/yhOldO7tf7wpwpyvYxzfHORrf
         Ag3Q==
X-Gm-Message-State: AJIora/9sorbKtIKLKqKE2Rgapy6cwy1yWndqszjOBImCmUyvYbH7JqM
        3Y7goZbFbVdILo0KoqXpP/jz
X-Google-Smtp-Source: AGRyM1uc3Mh5QfqIHw2xjBMoTw9ro2oKfU8tpCD3ibh1oWAD+oWQndIOvobVz0py48bvr1uM554P1Q==
X-Received: by 2002:a37:98c3:0:b0:6b5:f2a1:ab4b with SMTP id a186-20020a3798c3000000b006b5f2a1ab4bmr17473412qke.210.1658948830478;
        Wed, 27 Jul 2022 12:07:10 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:a5d3:2acc:90cc:94f4? ([2600:1700:e72:80a0:a5d3:2acc:90cc:94f4])
        by smtp.gmail.com with ESMTPSA id z14-20020ae9c10e000000b006a6c552736asm12832640qki.119.2022.07.27.12.07.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 12:07:09 -0700 (PDT)
Message-ID: <e437576e-537c-ecfb-9143-6e440f3bb893@github.com>
Date:   Wed, 27 Jul 2022 15:07:08 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/3] log: add default decoration filter
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, vdye@github.com,
        steadmon@google.com
References: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
 <6b40b84773c70244bb13204ec566b713f1bdf865.1658844250.git.gitgitgadget@gmail.com>
 <xmqqczdqtxro.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqczdqtxro.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/27/2022 10:50 AM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Derrick Stolee <derrickstolee@github.com>
>>
>> When a user runs 'git log', they expect a certain set of helpful
>> decorations. This includes:
>>
>> * The HEAD ref
> 
> OK.
> 
>> * Branches (refs/heads/)
> 
> OK.
> 
>> * Notes (refs/notes/)
> 
> Questionable.  None of the notes commits are on the primary history,
> so it is unlikely to be even used for decoration, so it would not
> hurt to have them as part of possible decoration sources, but on the
> other hand, the value of using them is dubious.

I had originally left this out of the filter, but then noticed that test
4013.102 (git log --decorate --all # magic is (not used)) includes an
instance of refs/notes/. Perhaps this is just old test cruft and could be
changed.

I could remove this from the filter and change the old test to match the
new behavior.

>> * Stashes (refs/stash/)
> 
> Questionable, for the same reason as 'notes'.

I had also left this out initially, but t4207-log-decoration-colors.sh
fails, and it's because 'stash' is one of the supported "slots" in the
color.decorate.<slot> config option. This elevates the importance of the
stash refs. (Notes are not a slot in this config option, for instance.)

The other slot that isn't included in my list is "grafted". This includes
grafts _and_ replace-objects.  Grafts appear to add decorations in a
different path that side-steps this filter, but replace-objects are
subject to this filter. Things are a bit more complicated here because of
the GIT_REPLACE_REF_BASE environment variable.

I'll add replace-objects in the next re-roll using the value of
GIT_REPLACE_REF_BASE to construct the filter. I'll add some tests to keep
the existing behavior, too, especially around color.decorate.grafted.

>> * Tags (refs/tags/)
> 
> Abolutely useful.
> 
>> * Remote branches (refs/remotes/)
> 
> Ditto.

Thanks,
-Stolee
