Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874E0C433F5
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 14:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241442AbiCGOK0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 09:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbiCGOKZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 09:10:25 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CF16A014
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 06:09:31 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id d194so2307880qkg.5
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 06:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=S2M8XkqAhi+iWkWoTL90TmzL4/A8xKVC5Jg2LEMnbRY=;
        b=Dyp2brjwGNBq83L7B1o5AdaHP9qHJKhu/qBtNt5W8uKEP41y3nJjYf8AAE/3qxDNAs
         lj+G1Sgtsj3jbuoJXoaI3xkt33zs2YfeW+Uk61Pxs/0BtVHtCxPwN42L/U8UIt9yxVMM
         z0jDrCHhNY9oQLrGn5zPCDAT9nEdYd1jYTwP/f63Iu1KYhXJYPvhBtdy7K5nWZ4v3KNZ
         SotqYBH0Rqz0DuiWd0ZkBj5vvmTXPyHGntfW1nA5UmKlLW8m8tlNCg7mX/xf6/SED0R4
         TlqArs/XJqaWk+ybIKUGUa/GVvfOvqe+s9+sRs+1iQSEF/TJxl7+liDx2+GPpCnAAWJ/
         WVJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=S2M8XkqAhi+iWkWoTL90TmzL4/A8xKVC5Jg2LEMnbRY=;
        b=RgNpwwn+jjtaFehGlaqsbyLBJkY8OOEu0AeEsXH1z2Jid3lEUYYfPSmFo8/73WQyrI
         RZBiIex/xLjxCEsYd7DG9zKVZYZqmWniHNZXmt4hCTDKszj1IVF2fhjfpheHY1ZYNaqU
         ajs588MY36yDe2s6RzDleRHroJL5+fnzCQ8boFgoXyUer0YZezqiNLy33Sq7de8E0Dte
         4sU/XuZe62jJSOEwXG3tvBAAPDjM19L+ly+1tgB2UoE+sf1ERMKnkTfpriCWVsI3PWaM
         gbqN2DaORCT0Cm4fp7zXx+3sXuD0AhpgLLoJp/12Ps4oqbJx0wnjbzaHA+V0tmIbu1bc
         Jl+Q==
X-Gm-Message-State: AOAM530+ACeSQOK6yNfYkDbYB5zguiS8lBxqJ31eVAfNzJvn7FlEwgSS
        C9EAh7ueNPS54bxoWvvisJvkIvc0e2hl
X-Google-Smtp-Source: ABdhPJzCO1eLw5HRPXSciU8TpEA85oY+Q/OEYFxaVHZYAT8UVJFWkc1JZq3Vk4kQoESuoB2WN5Drzg==
X-Received: by 2002:a05:620a:45ab:b0:67a:ee5a:470e with SMTP id bp43-20020a05620a45ab00b0067aee5a470emr6546655qkb.418.1646662170654;
        Mon, 07 Mar 2022 06:09:30 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id p68-20020a378d47000000b006491d2d1450sm6295018qkd.10.2022.03.07.06.09.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 06:09:30 -0800 (PST)
Message-ID: <934e76db-e85b-7d62-e98c-0d1a8450bdaf@github.com>
Date:   Mon, 7 Mar 2022 09:09:29 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 07/11] bundle: safely handle --objects option
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com, avarab@gmail.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
 <1476a9495c53a165e6971afe75205889524fe7ca.1645638911.git.gitgitgadget@gmail.com>
 <83bfbce4-3c79-031a-5961-429145910409@jeffhostetler.com>
 <xmqqilstxr3o.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqilstxr3o.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/4/2022 5:58 PM, Junio C Hamano wrote:
> Jeff Hostetler <git@jeffhostetler.com> writes:
> 
>> On 2/23/22 12:55 PM, Derrick Stolee via GitGitGadget wrote:
>>> From: Derrick Stolee <derrickstolee@github.com>
>>> Since 'git bundle' uses setup_revisions() to specify the object
>>> walk,
>>> some options do not make sense to include during the pack-objects child
>>> process. Further, these options are used for a call to
>>> traverse_commit_list() which would then require a callback which is
>>> currently NULL.
>>> By populating the callback we prevent a segfault in the case of
>>> adding
>>> the --objects flag. This is really a redundant statement because the
>>
>> Nit: I stumbled over "...because the bundles are constructing..."
>> Is there a better wording here??
> 
> "... because the command is constructing ..." should be sufficient,
> I hope?

That works for me. Thanks!
-Stolee
