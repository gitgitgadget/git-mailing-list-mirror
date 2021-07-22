Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36ECDC63793
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 14:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22E3061353
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 14:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbhGVNhL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 09:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbhGVNhJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 09:37:09 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AC4C061575
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 07:17:43 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id dt7so8570428ejc.12
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 07:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=O8FYcKAZenyWDLMh8npXBq47bRV0F5Q0tesy08dDBII=;
        b=qZa3C8muRL/t91FHUmjlxlf7zckmUBLQwhHSKxMMnQsEfVnrFrMdztQKlCf7Jy5332
         Mx4AaJByTrq5uDz0sYA5yo/89As/Rwdf1yehIIhetFnJ8fMRywy9BXKzLopVBd1jpIvX
         iqHSm2OoBRIufOfFwlfXm3TUEOMUllpufRZ4kiqRR2uEGnCKh7KxFwRtV5VfGJCBun7n
         NxdjX2g1T1MHxO8V3XJyIZCq+q9gjmOnz7mBqmhA8ae+6s9gCZLgG+RgmJYj7oOvNu+u
         +5V9JysiiMHzfAh+pSFJl+Pklx9GSNmyFgFiPCZ7qT/RedASHaTY473bPTz5QGXLBJrt
         20Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=O8FYcKAZenyWDLMh8npXBq47bRV0F5Q0tesy08dDBII=;
        b=PRF3I694SGVlv7Fq6blekjk3YAynx1U/jIpQdfcJtaQ5DcEwL05nJaMY+T/HmZcTO/
         IWNvAc62MarNEJ38F75gC+gxW7PmPDQDO0a+PeBTxImXTyKRmIqqdaOgE2iw/id7MAsq
         ZZEPUx2nLCMBqguoVIEepGQnJf0zEaxpF3ghLGaJcKtSrF87SHlLqETt6HXeCCl3GcjN
         9Jfp+gWRsKBf4B9LTEhJ5f8UKoGKfCS2oHnLO/OYdB/zKcgeHrx8oO8vAHRaf5mBtN/1
         SPWCs5Nqiejrflra5jZx4HYUUXsYKz7QTDfKmplpuEuEzNOlCtBQm2whtkmxmm4s+WuF
         eEcA==
X-Gm-Message-State: AOAM531KDXeNk/fIs4iwgIeTydKLo1ZbfVj05+aEaBu+kCGXSht/roZ6
        fSEYlZKC49t/nqY3R/h68QA=
X-Google-Smtp-Source: ABdhPJx8XwNsh968JIKZnOT3eCXkVvnHDeQCHvkx3Zfql4lIvb3C+WnQ9iHLsx2d5W9h//sO9/+gPw==
X-Received: by 2002:a17:906:1cd5:: with SMTP id i21mr127642ejh.478.1626963461468;
        Thu, 22 Jul 2021 07:17:41 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id v16sm11897678edc.52.2021.07.22.07.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 07:17:41 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     BENTZ Sylvain <sylvain.bentz@md6.fr>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Bug: Commit a merge resolution with non-closed conflict markers
 leads to errs, segfault
Date:   Thu, 22 Jul 2021 16:17:28 +0200
References: <bdb6c03f290c49bb96e6c0a3d9742a52@md6.fr>
 <60f9477d9cd3a_3fba2082@natae.notmuch>
 <66af2662ae884fff81f51a4eb5ac1dd1@md6.fr>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <66af2662ae884fff81f51a4eb5ac1dd1@md6.fr>
Message-ID: <87pmvatoti.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 22 2021, BENTZ Sylvain wrote:

> Oh I wasn't aware of this when I initialized my MWE repo, from git-config[1]:
>
>   By default, git-rerere[1] is enabled if there is an rr-cache directory under
>   the $GIT_DIR, e.g. if "rerere" was previously used in the repository.
>
> The correct MWE requires to enable rerere:
>
>   git config rerere.enabled true

I think the patch I posted at the end of
https://lore.kernel.org/git/87v96p4w3f.fsf@evledraar.gmail.com/ should
might catch this, i.e. the "could not copy" error.
