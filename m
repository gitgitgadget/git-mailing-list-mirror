Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C122C77B7A
	for <git@archiver.kernel.org>; Mon, 29 May 2023 17:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjE2Rxb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 May 2023 13:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjE2Rxa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2023 13:53:30 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35ED91
        for <git@vger.kernel.org>; Mon, 29 May 2023 10:53:28 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-30af20f5f67so333907f8f.1
        for <git@vger.kernel.org>; Mon, 29 May 2023 10:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685382807; x=1687974807;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IBUUPsjb7UYqJEhlXwCnTsE/hZBiaOQDgpLM4TIPzUU=;
        b=FLggXpqD4xmhbV2uUijV5Anwzcrq7Q57XpSCo/DmaOV4srIo5xK349B0d2ttowvXes
         IAciwjwyci1yk5eviW/hIZup/PCiIL+mZVESWZ1gDUfqE2BnwcV2ftmaPpZMZosPUQKX
         8Xf6hbNeP9LXZMt5TCmj3lejDXIEon/FFNyNcyWA8BQbcJuQaYsoWNQJLv3Z7FSA/zkH
         zUg96y5zZX0d6z9eGeNq946rbhRvuhO9PZ7uNekYDGvN6Autu3x5UYAbPe8+llWYpaP+
         CcUx0WrzXbXRNIAd1UC0NbeUMe/tgw72D60XAvns3pgAfdnsrmW63mjh+FeKRihrGkFX
         ZLFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685382807; x=1687974807;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IBUUPsjb7UYqJEhlXwCnTsE/hZBiaOQDgpLM4TIPzUU=;
        b=Nk5TL7oL9oq/h6hcgNFzxlZWrwL2x4USAUIaLgG5wendlA4Zhm5crctZghbo9HOyuC
         J7QxSgJUx3y+82tnThTcHL9CfsnHXOv4FUu9gy1WBDGkEjMX9kBZDaQebN2jmhyREbqk
         CoR2miyrHi3YeEgud7UcGAKJSLtQNLv1/gJH60hD2oHuddoP9gXRgaAb1U0zc0zI7v41
         olhIaE+YrmO0KRcUpjw5HqQXFiRW2fFD1C/GConsGKoONfCB6y0+BpZfSbKYdgvWc+4n
         n53MGrKTlbHfDdhK3gN8H3BjyLpQ1PATvJq6mLpbGWaC/SS9U1bovLlIlhY+BhdDNKof
         nkdQ==
X-Gm-Message-State: AC+VfDzkbWCLJqbyKWHApSdvivC1/niSRbsxRq/bYC2YD+kaWb/ebThi
        6bGtKlWe5khxeUlS6Mw/A/iHRpzCD4A=
X-Google-Smtp-Source: ACHHUZ651ELpJvXvwjvF5CK3pUew5A2JJD8iPTY34Fij4X+NMkyoBS247gvi9WPR2mIhIm+zGgUK6A==
X-Received: by 2002:a05:6000:909:b0:307:9702:dfc8 with SMTP id cw9-20020a056000090900b003079702dfc8mr9924803wrb.48.1685382806905;
        Mon, 29 May 2023 10:53:26 -0700 (PDT)
Received: from [192.168.1.195] ([90.255.142.254])
        by smtp.googlemail.com with ESMTPSA id z1-20020a05600c220100b003f508115b25sm15110287wml.4.2023.05.29.10.53.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 10:53:26 -0700 (PDT)
Message-ID: <198eea19-fc40-de0c-8854-3cdc94925f32@gmail.com>
Date:   Mon, 29 May 2023 18:53:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Automatically re-running commands during an interactive rebase or
 post commit
Content-Language: en-US
To:     Paul Jolly <paul@myitcv.io>, git@vger.kernel.org
References: <CACoUkn7TmZ=trtDKcQm0SG5qCqK=-+YxrDV-7xYnLH_XK7K7og@mail.gmail.com>
 <CACoUkn6F_=JR5SYBWL2sVDxDVAZbxcV5Ruif6wLba-_q_QNiZg@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CACoUkn6F_=JR5SYBWL2sVDxDVAZbxcV5Ruif6wLba-_q_QNiZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Paul

On 29/05/2023 17:02, Paul Jolly wrote:
>> I would appreciate some advice on the best way to solve the following problem.
> 
> Replying to self with some updates based on further investigations.
> 
> The lack of pre-commit like hook during a rebase is documented in a
> few places (https://adamj.eu/tech/2022/11/07/pre-commit-run-hooks-rebase/
> to list one). The -x flag provides a means by which I can
> retrospectively amend the "previous" commit if that is not clean. Not
> ideal, but a solution of sorts.
> 
> However, the main problem appears to be the lack of "hook" to do
> something when git rebase detects conflicts.

I think you could get around this by using a script that wraps "git 
rebase". Something like

while true
do
     if test -d "$(git rev-parse --git-path rebase-merge)"
     then
	git rebase --continue
     else
	git rebase "$@"
     fi
     if test $? -eq 0
     then
	exit 0
     fi
     # Handle conflicts here

     if automatic-conflict-resolution-failed
     then
         exit 1
     fi
done


You can get a list of the files that have conflicts with

	git diff-index --name-only --diff-filter=U HEAD --

or by parsing the output of

	git status --porcelain

I did wonder if you could use a custom merge driver (see man 
gitattributes) for the file with the checksums but that would be run 
before all the other files have been merged. Another alternative might 
be to use a custom merge strategy that runs "git merge-ort" and then 
cleans up the conflicts in the checksum file. You can specify a custom 
strategy by naming your script "git-merge-foo" and passing "-s foo" to 
git rebase.

Best Wishes

Phillip

> Ideally, I would like to have a hook be called when git rebase detects
> a conflict, a hook in which I could attempt to "recover" the
> situation. If that hook failed to fully recover the situation, git
> rebase would fail as it currently does. Otherwise, it would be able to
> continue as normal.
> 
> My use of git is pretty basic, so part of me feels like I can't be the
> first person to run into this problem!
> 
> As ever, any pointers are greatly appreciated.

