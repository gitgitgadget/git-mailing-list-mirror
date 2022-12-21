Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4048EC4332F
	for <git@archiver.kernel.org>; Wed, 21 Dec 2022 13:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbiLUNq3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Dec 2022 08:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiLUNq0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2022 08:46:26 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E52F6304
        for <git@vger.kernel.org>; Wed, 21 Dec 2022 05:46:26 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id v3so10434136pgh.4
        for <git@vger.kernel.org>; Wed, 21 Dec 2022 05:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rqPiFrZqLLs4TZ2xEID8GfImzLZuFeBSb8PY+j5kJ0o=;
        b=lb2utCERRGvvZmlI47kGv8N8NkmY/a1sWyWbwFaYWmBLEz7LghkAExK9NrcarXEQc4
         4RSlSqXi+XR5mEN2Lm9RHvz10BWHTbidNaCq0wxQ1FSgElF8WUq09a8oNH+OfLjhB1ro
         GJ8cY9QRY4cnjffQuhF613tjdM/JpMGPF2nXGEp7clqev1/+2MTtK7Gqbqt/qomuWiXV
         Zx4le56bxpkg93DCNIjmgoh5whYPTxeELsedtO8xEexKa/avUuh6qapR8O6jhJbS77I3
         op/poYO7G9kzF/cDZpijxK4oong4eavKqP5MW23/5WEXgj9DCltrCuWJSdob3S5sRztq
         LICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rqPiFrZqLLs4TZ2xEID8GfImzLZuFeBSb8PY+j5kJ0o=;
        b=mbzn2FmpCH+y8svUJG7epdaQArRLcwzbGjQIBUI0eZNEPK+nvBCH3X0cVe+1m+WUS7
         J9AyxbpxFP99asI1iVEZn6cAOMe4E0iyIwR32Xcm3PXj6WZhgX/JSN+g/VrfzQCR/nVy
         B9zXr7s6PRVwb2PMJfVYNcCaXP9cTk8ZJhnEAvvKOlfhndDa48tDilwZxC+soOvu4JiI
         zGTSKViC0xSfF3lEPgd467EuScl7YkA2bUe3UzwGjvVSuiUCgLZeo19oRTvPmz4tWrJ1
         LOtp1p3UICRAAEUQB4iCzfRxWCiBBKYDC4TtAT3jr143WDN9PNF+ZGICgkxMwkWDFzqw
         r5Cg==
X-Gm-Message-State: AFqh2kosEanmy4WuUvDcdy78/pHABBkDR/xNO5Zefhf8asiuoEA5kAWq
        1lfEH3blD/2N3kpiKgJBL+/+a9qk3qY=
X-Google-Smtp-Source: AMrXdXsTRXMxxJYmlQiBMQYp7ocjLv+70KH0T5RFXia9yqks2ui8Ce0DdFGVRuxpCfFZsyDfnfY6bA==
X-Received: by 2002:a05:6a00:1485:b0:575:b783:b6b3 with SMTP id v5-20020a056a00148500b00575b783b6b3mr3157415pfu.28.1671630385526;
        Wed, 21 Dec 2022 05:46:25 -0800 (PST)
Received: from localhost ([2001:ee0:50c6:3450:b0ce:46ff:fe04:76aa])
        by smtp.gmail.com with ESMTPSA id w82-20020a627b55000000b005781f4577e0sm10553632pfc.108.2022.12.21.05.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 05:46:24 -0800 (PST)
Date:   Wed, 21 Dec 2022 20:46:21 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Chris Webster <chris@webstech.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/3] ci (check-whitespace): suggest fixes for errors
Message-ID: <Y6MOLVoo/NtJy1C9@danh.dev>
References: <pull.1444.git.1671179520.gitgitgadget@gmail.com>
 <pull.1444.v2.git.1671496548.gitgitgadget@gmail.com>
 <a2b5f3e87d6ef62d8005cff5568ad3afc4af3771.1671496548.git.gitgitgadget@gmail.com>
 <Y6Fle8gzVU5si3T/@danh.dev>
 <CAGT1KpV0igMKk4FvapuZCdJ7kFS+_cNe2ouczQsomheOGhgLZg@mail.gmail.com>
 <Y6JnEQY2VWU8gSZX@danh.dev>
 <CAGT1KpWBVcmxCJf=j7ks7azrX=oj3zLqbrThOjjPLqKu+8rBAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGT1KpWBVcmxCJf=j7ks7azrX=oj3zLqbrThOjjPLqKu+8rBAg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-12-20 22:08:58-0800, Chris Webster <chris@webstech.net> wrote:
> On Tue, Dec 20, 2022 at 5:53 PM Đoàn Trần Công Danh
> <congdanhqx@gmail.com> wrote:
> > Yes, I think, a patch to move the whole block into a script, maybe in
> > ci/ folder.
> 
> Maybe before the next patch or someone could create a check-whitespace
> workflow action.  Can this patch move forward?  A script would involve
> validating parameters or env variables that are just workflow context
> expressions now (ie more complexity).

I would say, we can just check an environment variables specific to
GitHub Action, and print a warning if it's missing. Other than that,
just process as normal.

> > > I am not sure what you mean.
> >
> > I mean we can write:
> >
> >         echo 'Run `git rebase ...` to correct the problem'
> >
> > With single quote, we need less escape.
> 
> What about ${lastcommit}?  Yes, there is more than one way to do it.

Ah, I misread that part. Sorry.

-- 
Danh
