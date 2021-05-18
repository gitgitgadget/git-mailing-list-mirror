Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C50C433B4
	for <git@archiver.kernel.org>; Tue, 18 May 2021 03:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F048161285
	for <git@archiver.kernel.org>; Tue, 18 May 2021 03:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240043AbhERDTl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 23:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237929AbhERDTl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 23:19:41 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FF6C061573
        for <git@vger.kernel.org>; Mon, 17 May 2021 20:18:22 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id a11so4302389plh.3
        for <git@vger.kernel.org>; Mon, 17 May 2021 20:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dAWc0H/Oe5cbfEiOloOcd/wbxSFYz3lUPdCEmHgVxbU=;
        b=P5H9jihLYEMGb4ryGvGgTaYBJ+GQeLA0wFb874PNsMk9bbd3btP1HN9UvYMTG6I6co
         jyFzAZ1jyR0Mv7qTPmykIuSNzp1Gl8FwdUufFZCtbE8pQ6gPHb9Bklc9muSO2ZqeCjK9
         aj5jq2URv9Fo0eW7hrGFHUaJ8RY2dwE3GU3AzJP7qjxVtnW+LMMOZAFUp+iPf58GnA39
         kZEe557hbdCbvWfx1WE7vS1LXVsIB1KEaQQdc1i/yqHknN4ESSlavRBRDtYw0m1PZGu2
         B8oZTXbf94nJ8sJtJ+6ChjanUEzQYf1HZGcbvvUCB+TImQ+xL0ShpIUArSs83kI4phng
         fZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dAWc0H/Oe5cbfEiOloOcd/wbxSFYz3lUPdCEmHgVxbU=;
        b=Fsj74d7Xj2DWBpPd2qcZqrilDeqtIEKmOc4WAGTobbEEMcyvA3qIvWm0DvXME6m0/A
         xL7WIxHH9oTSS3zah3QYJgc5pRJy0NtD0GTpOmfBK1ZBAjnXfCzVL5LDW3WEusJf77Cz
         iaFd3ORmO+KqF+r8JJjTOhZ92Mo9BALJNyVU7CslnWkbW8ZIzjfdLDJxArjUrPCkYDmU
         XCofeNaEZifoJMzE3svSse9VtELup0Uex1Czy64pDzXubFNH8d1pMSMY2XqcBrQxgNgC
         iaIDBZGIvcyB9KuqeKf0TFkSFmDz9L7iqC4/auqR8ksHuEmp1pAsQT6iaAoBGtEpd1ci
         U/1g==
X-Gm-Message-State: AOAM5325Mhh/h5uzYFPTmH48Hol1gGd6Bs+qFxCmt7NKdbMCqT0NCwIW
        ufJtKrKcHYGvl1Zl8rVNmbZDjTLcvQR91e3f
X-Google-Smtp-Source: ABdhPJw39DMtCZ8pkXhOBfUhD9DoJ+ZF6x2Z/J/WViFKVT9MeiBKWLtXgLtfrk37JDwvJO6aPnn/sw==
X-Received: by 2002:a17:90a:29c4:: with SMTP id h62mr3089829pjd.177.1621307902199;
        Mon, 17 May 2021 20:18:22 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-88.three.co.id. [180.214.232.88])
        by smtp.gmail.com with ESMTPSA id v22sm10761586pff.105.2021.05.17.20.18.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 20:18:21 -0700 (PDT)
Subject: Re: [PATCH v1 0/9] diff-merges: let -m imply -p
To:     Sergey Organov <sorganov@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
 <20210517155818.32224-1-sorganov@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <321ca7e8-0ccb-20dd-e2de-2f3c2845e515@gmail.com>
Date:   Tue, 18 May 2021 10:18:17 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210517155818.32224-1-sorganov@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17/05/21 22.58, Sergey Organov wrote:
> Fix long standing inconsistency between -c/--cc that do imply -p, on
> one side, and -m that did not imply -p, on the other side.
> 

The commas are unnecessary.

> Only the last patch is the actual functional change. The reset of
> patches are additional tests and refactorings that are not expected to
> alter existing behaviors.
> 

Oops, s/reset/rest/.

> After these patches
> 
>    git log -m
> 
> will start to produce diffs without need to provide -p as well, that
> improves both consistency and usability. It gets even more useful if
> one sets "log.diffMerges" configuration variable to "first-parent" to
> force -m produce usual diff with respect to first parent only.
> 

Better say "After this patch series, git log -m produces diffs (implies
-p)".

> These patches don't change behavior when specific diff format is
> explicitly provided on the command-line, so that commands like
> 
>    git log -m --raw
>    git log -m --stat
> 
> are not affected.
> 

Better say "This series, however, don't change behavior...".

> Exact historical semantics of -m is still provided by
> --diff-merges=separate.
> 

Better say "Previously, the -m semantics is same as --diff-merges=separate".

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
