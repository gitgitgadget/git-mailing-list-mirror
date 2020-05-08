Return-Path: <SRS0=7OUv=6W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94702C47254
	for <git@archiver.kernel.org>; Fri,  8 May 2020 13:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 733BD2497C
	for <git@archiver.kernel.org>; Fri,  8 May 2020 13:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWxaTFiR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbgEHNrn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 May 2020 09:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728248AbgEHNrm (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 8 May 2020 09:47:42 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E02C05BD43
        for <git@vger.kernel.org>; Fri,  8 May 2020 06:47:41 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id 50so1390479wrc.11
        for <git@vger.kernel.org>; Fri, 08 May 2020 06:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=O1Om61e3w8P6STv2d907gb8AxtyDsM6l071nC2Kkh5U=;
        b=XWxaTFiRWpWBAY/eNk2Ls0RD0yA+HAcO61TowM/bkHYBcN1qGlPTeTipzkAc8pD5mh
         nJSj1DQ5LbKbIcx9ixr7+NZz+FkSlgv5usxLUYQ0PEubgfnfgTE1aQbx+PgYTVncxhFM
         oWr0YMwODr0a+cCd2wmyQBSMQ2YGkLl8rYfbbCl3UDSRsWvEMDWvaJORf4/hcuAdHuNk
         YJZzCSmrXYMwIuvA2YhepwCGzO7mhbqCcsks2YG7pWK+cDgbkY0SOR2D6NBPcQb0iSJ0
         IJbdUYuw735czl1m3XHUm3t4WiqR47dAHO8YH7HX3fLsmJg+8GGNUDHnqDOxDSI4BVVs
         WPtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O1Om61e3w8P6STv2d907gb8AxtyDsM6l071nC2Kkh5U=;
        b=K99ruetfUqZnUK/XjXCAvdFmRgA1dWejAtUad1oQ2NR6EWhJhwAWXi3wJOIiJrc/Ws
         d7MUrRUhbJIY7AjxIGGsxASzCRAKqLUq0PPEGB9DLVY5tRWEF/WyCQqm2BRXncoVXih/
         YhOmvMZJo7oBb/Mg0o8GnE4S92IQ8oReMXtRZvdMc5p2VskEnLLQsulG44/QTGA7MqeW
         IEKdUpK7HopovU2F40D+S/rySsD3akTGTWcQWhOtRN066NjaLeED9n2wKsaOiHGBW1kK
         uKeHiIV2bMtmCeAmBgTI0G2gZ3oigYYxZAGQisVJMtEAGf1fJFoxbF0hg/bECYA8ePxp
         dIuQ==
X-Gm-Message-State: AGi0PuYEKH5haSCSsZATyMuVlhh4QCmleQCHSUznzC3Tkm59dio1dz5U
        ER+nm0uFgPiM7QJjhFStOn9BYxOi
X-Google-Smtp-Source: APiQypK/vRJdCTEKEJueG7FLlSaVX61lCfwnBENnEHf8BCOFS3mqv1SebpJucP8O/ov69QRGsR+isw==
X-Received: by 2002:a5d:56c6:: with SMTP id m6mr3043588wrw.78.1588945654728;
        Fri, 08 May 2020 06:47:34 -0700 (PDT)
Received: from [192.168.1.240] (155.20.198.146.dyn.plus.net. [146.198.20.155])
        by smtp.gmail.com with ESMTPSA id s11sm3060192wrp.79.2020.05.08.06.47.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2020 06:47:34 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: git apply -3 doesn't work
To:     Konstantin Kharlamov <hi-angel@yandex.ru>, git@vger.kernel.org
References: <d9d549eb-e888-c930-1aeb-38cd3aad1b3b@yandex.ru>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <bf5fab9b-78f0-8c8c-dcf6-e6672014412f@gmail.com>
Date:   Fri, 8 May 2020 14:47:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d9d549eb-e888-c930-1aeb-38cd3aad1b3b@yandex.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Konstantin

On 08/05/2020 11:35, Konstantin Kharlamov wrote:
> As description says. To check that the 3-way merge should actually work 
> subsitute `git apply -3` with `git am -3` in the following steps. This 
> way it works.
> 
> # Steps to reproduce
> 
>      $ git init
>      Initialized empty Git repository in /tmp/foo/.git/
>      $ echo hello > file1 && git add file1 && git commit -m "initial 
> commit"
>      [master (root-commit) 8334093] initial commit
>       1 file changed, 1 insertion(+)
>       create mode 100644 file1
>      $ git checkout -b mybranch
>      Switched to a new branch 'mybranch'
>      $ echo bye > file1 && git add file1 && git commit -m "change file1 
> text"
>      [mybranch 1807900] change file1 text
>       1 file changed, 1 insertion(+), 1 deletion(-)
>      $ git format-patch -1 --stdout > 1.patch
>      $ git checkout master
>      Switched to branch 'master'
>      $ mv file1 file2
>      $ git add -u && git add file2 && git commit -m "renamed file1 to 
> file2"
>      $ git apply -3 1.patch
>      error: file1: does not exist in index

Judging from the error message it never gets as far as trying the 3 way 
merge because it first tries to apply the patch which modifies file1 but 
file1 does not exist in the index. If it were to try a 3 way merge in 
this case then on one side of the merge you've modified file1 and on the 
other side it has been deleted so there would be a merge conflict. The 
reason 'git am' succeeds is that the rename detection kicks in and so it 
applies the patch to file2 rather than file1

Best Wishes

Phillip

> 
> ## Expected
> 
> Git apply successfully returns
> 
> ## Actual
> 
> It prints
> 
>      error: file1: does not exist in index
> 
> # Versions
> 
> git 2.26.2
