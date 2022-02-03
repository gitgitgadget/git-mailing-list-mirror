Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA930C433F5
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 15:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344987AbiBCPyb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 10:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234764AbiBCPya (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 10:54:30 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9017C061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 07:54:29 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id o1-20020a1c4d01000000b0034d95625e1fso7465359wmh.4
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 07:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=1qmk3+wVENvaibILocwV8tbaxaXpAMFX/0uXZ2NhPpw=;
        b=kQZ4rzIDK5lkY1sqNcSR5iEjd0bodGYXGwlBrZT9b1jPgzaC0gTjGpdFXxcv2ak3dA
         rBSlKsgZfMTdiRRXHbsFaWl48eWPailNK73yt6Rlp3KuNG5hq6pzgYpF0gp+6RS+sqC3
         Wxhi60PsZYxhJyBrQ7bfVvQY6Kn8FLMAMY6O/2nAKZjcBItwTA7rLXuS9bWUbAsHlleH
         Zhgrlp/lRzY2TmzdB00NiGludQu19jInrHEDHFEoH7NId3W6nD6fB/nSuuamSWBpeigG
         wzBWK4AKGFXOAgNg+iKCK9kfQEgmTnIdw5JYxjIPHJTbFDP3s0tpF38+LMPMNQ4GXJMm
         gMTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=1qmk3+wVENvaibILocwV8tbaxaXpAMFX/0uXZ2NhPpw=;
        b=DF85FRfHCtI1OkbyJb+cxzfOz/gXGQruvu6Ppcg7WMvTfGhR3sVYPDt/7QdSaP/yRi
         zOV9wc1bAgBWffz9FBZcTxdP5JpubZMWIXCD+4hS4rsCZv/m8R2tXz7PkaL2AhGh407z
         MPuneEaNueBqfkONN3ZB22tkivUMQKUtGP+Uu4WGb0sBVPHWkN4RhjcRo55Go/EstXxW
         y2WaIktMR0efO7NyFN5nekptu1pZMjTRSoGqq6eV3fZGqGHPlCr1RapzOa3WRBDVqtd9
         qiss4DxVOMqSM/DJw1+PLQvuk9nbok2dAi771lC5L5ofI3ynXvaY0qmeuGyjnQ9Dn/4e
         2JLQ==
X-Gm-Message-State: AOAM531EB1AFrEZ+QfdkeRZ2dc7XIni8jcIp1IFEX7QX1GSn3Xp5WBZt
        g0iIIWkEHr+PZTfKoGj+um4=
X-Google-Smtp-Source: ABdhPJxMQAqeUh38zOug/sXhESLQQomDhf2OdJkEhNO2GNJ89MVSndqvLb6yVYQ/aNNNkjzh/zPULg==
X-Received: by 2002:a1c:ed09:: with SMTP id l9mr5610587wmh.142.1643903668372;
        Thu, 03 Feb 2022 07:54:28 -0800 (PST)
Received: from [192.168.1.240] ([31.185.185.186])
        by smtp.gmail.com with ESMTPSA id k20sm8537468wmi.36.2022.02.03.07.54.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 07:54:28 -0800 (PST)
Message-ID: <0b8222c2-7337-7e8f-33d1-7926462daac1@gmail.com>
Date:   Thu, 3 Feb 2022 15:54:23 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: git-checkout doesn't seem to respect config from include.path
Content-Language: en-GB-large
To:     Greg Hurrell <greg@hurrell.net>, git@vger.kernel.org
References: <ee1dd453-e698-440a-911b-d14389e33715@beta.fastmail.com>
Cc:     "Brian M. Carlson" <sandals@crustytoothpaste.net>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <ee1dd453-e698-440a-911b-d14389e33715@beta.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Greg

On 02/02/2022 16:04, Greg Hurrell wrote:
> Hi,
> 
> Not sure if this is confined specifically to `git-checkout`, but that's
> the command I noticed the issue with:
> 
> With the release of the v2.35.0 and the "zdiff3" setting for
> "merge.conflictStyle", I find myself wanting to use "zdiff3" on machines
> running the new version, and falling back to "diff3" on machines with an
> older version.
> 
> To this end, I have a ~/.gitconfig that contains:
> 
>      [merge]
>      	conflictStyle = zdiff3
>      [include]
>      	path = ~/.gitconfig.local
> 
> The idea is that I can use the same `~/.gitconfig` on every machine I
> use, but on machines that only have an older Git version, I drop in a
> ~/.gitconfig.local with overrides like this:
> 
>      [merge]
>      	conflictStyle = diff3
> 
> `git config --get merge.conflictStyle` correctly reports that my setting is
> "diff3" on such machines, and `git config --get-all merge.conflictStyle`
> shows:
> 
>      diff3
>      zdiff3
> 
> In other words, it knows that I have multiple values set, but it uses
> a last-one-wins policy.
> 
> However, when I try to run a command like `git checkout -b something`,
> Git dies with:
> 
>      fatal: unknown style 'zdiff3' given for 'merge.conflictstyle'

I think what is happening is that git parses each line of the config 
file as it reads it so the old version of git sees "zdiff3" and errors 
out before it reads the include line. I'm afraid I don't have any useful 
suggestions for avoiding this other than switching the include around so 
that it contains zdiff3 and is only included by newer versions of git.

> So, it looks like something in `git-checkout`'s option processing is
> causing it to disregard the override set via "include.path". In fact, it
> even disregards a value passed in with `-c` like this:
> 
>      git -c merge.conflictStyle=diff3 checkout -b something

I think the values passed with -c are parsed after all the config files 
so the override works. What we really want in this case is to store the 
string value for each config option as we read each config source and 
then parse those values at the end, unfortunately I think that would 
break multi-valued config keys.

Best Wishes

Phillip

> Does this sound like a bug, or are my expectations off? I'd be happy to
> look into fixing this, but first would like to know whether it is
> expected behavior.
> 
> Cheers,
> Greg
