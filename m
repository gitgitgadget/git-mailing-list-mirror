Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779EDC4332F
	for <git@archiver.kernel.org>; Fri,  9 Dec 2022 07:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiLIHun (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Dec 2022 02:50:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiLIHul (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2022 02:50:41 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964BF50D41
        for <git@vger.kernel.org>; Thu,  8 Dec 2022 23:50:40 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d82so3101245pfd.11
        for <git@vger.kernel.org>; Thu, 08 Dec 2022 23:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w9PLSvuQP0gINO0gwH9wZh2EtFWcOJdi0RSoXzO2Vc0=;
        b=PSpJJKrOQHIhS0oPqt/x2Ip6qw3R2TUjodY6KJFmtsvtPtKYEnpV3JLoiI6sB2fMMW
         nA2mjFZUyfdwWswzAMaXBDxLv/85sCQ2zmQjyol2xoHQkOa/QY4eFDlgiqMpgQ7vAZXL
         YpkxlMWaNlRZe1hsEaGHqI5s8YGCE29HxunIwoSY6CQVidC3j1zRZK4ArHSkaBFLD9L+
         PuPH/GkMw8c6aaZnx17q3oi++lIcgC1AilyskNl6Wx1ZvMABG0repzgUEIgDb3CZ/6Ms
         H3YoVM55erNvyokqEY7JLKvPf6dB4nFTfDlrHENXii0XNETwE7V2F7ItJGqfLzCiW9Ud
         NOKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w9PLSvuQP0gINO0gwH9wZh2EtFWcOJdi0RSoXzO2Vc0=;
        b=zJap7jTeUuprjn+wi/F/z7KSErn9y+7r3fRj8oLtFBizrBPpkviLM/HbZiKmqmvVFv
         PihAcJyQyoR4UB5ZWp3RrfmZWA/hMP8a+9pV4w/4ROQbC6sxUEcvZyEQUbgTeXDIQbr4
         BU9u65CV4V83D0Pl9zvYUnsD84BFE/RohOnvqU4BkOD47U0ATgcv1NImH/xE4HfW1QNu
         S2w1kXzE56CM/kRQDqutS9Y06Rkc7eL6/HNt6lKf6go3kCap1LMbDWllUhDvnpHrosAX
         Uz40uqLsjbD9FpO+/NhvwezcPoCDqMTcksP+4y+eOHgcTxWC/MvsDJ6PYiOd36o1pen5
         irpA==
X-Gm-Message-State: ANoB5pnoOBVTxCZqcTS/2M0ZbRu2ABcRAXcc9xh4uqrG5Osx153xAvSD
        jquRei3Fwsg5RLrpXD4D9DKPXTTv8K6i7QI=
X-Google-Smtp-Source: AA0mqf5zyPZNfVPW2/EzHLe1D3sXENUHGOyujc8czVzGxXm65PmpIkcQbqeSn3DoF+MFCqh6v8Df+A==
X-Received: by 2002:a62:6d46:0:b0:56c:f87e:64c with SMTP id i67-20020a626d46000000b0056cf87e064cmr5425854pfc.21.1670572240004;
        Thu, 08 Dec 2022 23:50:40 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id y14-20020aa793ce000000b0056ba7ce4d5asm659542pff.52.2022.12.08.23.50.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 23:50:39 -0800 (PST)
Message-ID: <8edcef4f-4438-e07a-a6fb-698b6179fcc4@github.com>
Date:   Thu, 8 Dec 2022 23:50:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: rebase update-refs can delete ref branch
Content-Language: en-US
To:     Eric Musser <eric.musser@snowflake.com>, git@vger.kernel.org
References: <CAGW=zr_BD=7d5dZi+yO4cpufFi=jEjH=wQoTndDLfTi14UresQ@mail.gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <CAGW=zr_BD=7d5dZi+yO4cpufFi=jEjH=wQoTndDLfTi14UresQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric!

> [I am presented]:
> pick 2dd4408 commit 2 # empty
> update-ref other-branch
> 
> pick 39f626e commit 3 # empty
> 
> [I deleted first two lines and submitted]:
> pick 39f626e commit 3 # empty
> 
> Successfully rebased and updated refs/heads/working-branch.
> Updated the following refs with --update-refs:
> refs/heads/other-branch
> $ git rev-parse other-branch
> other-branch
> fatal: ambiguous argument 'other-branch': unknown revision or path not
> in the working tree.
> Use '--' to separate paths from revisions, like this:
> 'git <command> [<revision>...] -- [<file>...]'

I believe this is the same bug as one reported back in October [1], where
deleting all 'update-ref' lines from the 'rebase-todo' inadvertently causes
the rebase to delete those refs. The bug was fixed in 44da9e0841 (rebase
--update-refs: avoid unintended ref deletion, 2022-11-07), so you shouldn't
see the issue anymore in Git that's built from newer revisions (e.g., the
latest pre-release v2.39.0-rc2 or the upcoming final v2.39.0).

I hope that helps!
- Victoria

[1] https://lore.kernel.org/git/CAFzd1+5F4zqQ1CNeY2xaaf0r__JmE4ECiBt5h5OdiJHbaE78VA@mail.gmail.com/

> [System Info]
> git version:
> git version 2.38.0
> cpu: aarch64
> built from commit: 3dcec76d9df911ed8321007b1d197c1a206dc164
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> uname: Linux 5.16.13-generic #2 SMP Fri Mar 11 12:48:38 UTC 2022 aarch64
> compiler info: gnuc: 10.2
> libc info: glibc: 2.17
> $SHELL (typically, interactive shell): /bin/bash
> 
> 
> [Enabled Hooks]
> pre-commit

