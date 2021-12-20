Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B594DC433EF
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 15:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237951AbhLTP7b (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 10:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbhLTP7a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 10:59:30 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBAA4C06173E
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 07:59:29 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id q14so10136481qtx.10
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 07:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hKLDsPSQbuvW3AhOrbhXOT/YHqjb/nuGvZ489PRa5Vk=;
        b=idA9ZIpJNCUpBSGd4gcCvo8Tk17yASUPB1Mn7fpzDNLIqBgRkgpdAW6lDI1bCH3Typ
         tAGD7xEIYDyYs+bwFX1vuNQHUCyT5s2mRTlNXD+fHl/2czuaGhHeWgA7osx4qsIr2ehl
         2GP644ObJ88hkp40968Cvhobne0rrpgQwK00np1tb2m2BgHAGoLrH+2gG/WYTUsLMgHT
         aqdnG1gxFMuar4kGlmxbCI+KKZd19BAgYXUD14+XaCyCcJW5l6BnVv2RFDGqDAe0acnk
         4fjlrfU2bm//zYqgb0XlK5jnTmjP4cMoIIhFjCWhjeh/VPqhz83felE6Ggh+a241o0dm
         964Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hKLDsPSQbuvW3AhOrbhXOT/YHqjb/nuGvZ489PRa5Vk=;
        b=ezR7eqmA6jkegvFGpEWwnnWfItiBKY6DMKbvoutZcKlwDweI19zBKE/5ro/pLb+7+J
         8mWTxSlsUUOO/eoZJlSq28yYj8B5vx/noCOWhEZA8Ez27F52UyEnhMe2tLfnqBLrq/Ky
         bhsik6RuLACFB98h+qReijqoFYXb+4iyH6tJyl7cN312UdNHztrOhkdqiWk7He6RwUQx
         vbi72ahOZfWMQXKxLaANLIx83R75XDeqHmfA87SkFPDqlX3b7RX4uBMs+blNAmQ/eX/M
         +/ZTH165TupwDzASh0mWK2tDGSoi65a25IM070/y+WoSvAlabjTza7hAuo/eV+gNPCUl
         /OEQ==
X-Gm-Message-State: AOAM531ooFs32194zn3r+fCeaqDrFeuhLMKZRI8toEq1vxw3DTUyQjvE
        zYhot+x/bjbo9RO7GfqzX8c=
X-Google-Smtp-Source: ABdhPJykhfoN50L29wCWkGRQOVyILTYWUCLGPJTFE8dmMN3qp46Sx1Z1jzAELxMB8+bpzJ4aVDkKwQ==
X-Received: by 2002:ac8:5aca:: with SMTP id d10mr2036888qtd.469.1640015968915;
        Mon, 20 Dec 2021 07:59:28 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:1dd9:8fb3:37da:4055? ([2600:1700:e72:80a0:1dd9:8fb3:37da:4055])
        by smtp.gmail.com with ESMTPSA id w10sm12210647qkp.121.2021.12.20.07.59.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 07:59:28 -0800 (PST)
Message-ID: <db6f47a3-0df3-505b-b391-6ca289fd61b5@gmail.com>
Date:   Mon, 20 Dec 2021 10:59:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 03/13] init: unconditionally create the "info" directory
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Adam Spiers <git@adamspiers.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <cover-00.13-00000000000-20211212T201308Z-avarab@gmail.com>
 <patch-03.13-784b7947512-20211212T201308Z-avarab@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <patch-03.13-784b7947512-20211212T201308Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/12/2021 3:13 PM, Ævar Arnfjörð Bjarmason wrote:
> In preceding commits the test suite has been taught to run without a
> template directory, but in doing so we needed to fix code that relied
> on the "hooks" and "branches" directories.
> 
> The "hooks" code was all specific to our own test suite. The
> "branches" directory is intentionally created, but has been "slightly
> deprecated" for a while, so it's not created when not using the
> default template.
> 
> However "info" is different. Trying to omit its creation would lead to
> a lot of test suite failures. Many of these we should arguably fix,
> the common pattern being to add an exclude to "info/excludes".

This would be painful to add because of the impact on the test suite.
That I understand.
 
> But we've also grown a hard dependency on this directory within git
> itself. Since 94c0956b609 (sparse-checkout: create builtin with 'list'
> subcommand, 2019-11-21) released with v2.25.0 the "git
> sparse-checkout" command has wanted to add exclusions to
> "info/sparse-checkout". It didn't check or create the leading
> directory, so if it's omitted the command will die.

> Even if that behavior were fixed we'd be left with older versions of
> "git" dying if that was attempted if they used a repository
> initialized without a template.

This, I don't understand. Why can't we add a
safe_create_leading_directories() to any place where we try to
create a sparse-checkout file?

This would fix situations where older versions were init'd with a
different template or if the user deleted the info dir. The change
you've made here doesn't fix those cases, which is what you are
claiming is the reason to not do the other fix that seems like it
would.

What am I misunderstanding here?

> So let's just bite the bullet and make the "info" directory mandatory,
> and document it as such. Let's also note that in the documentation
> that this doesn't apply to the "hooks" and "branches" directories.

I have no objection to this approach, but we should still do the
other thing.

Thanks,
-Stolee
