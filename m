Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8065AC433F5
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 14:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356772AbiCPOuq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 10:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356896AbiCPOul (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 10:50:41 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4865A0BC
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 07:49:26 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id z92so2072003ede.13
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 07:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=etsH2Z2FQ4/k6Hm8S85g0OU8GjhZVqeMmdg39ne3B5w=;
        b=JRBQlhOKJrBSg3vQNbAQIGEK0g8f5IvDDzuFwBIf/5z41D1obomXQXTvR/gWP05qAh
         QUImdD57citCuRrZ18imCHCVNsK/mJRyX+ev404EDCocK6TY9Ol9CdLcLlPbtj5PEEf3
         mH7N1miPY7dy0fSqYdhI+/8s2Rag+ah4xoq1Tt5hwPIQ15KQkyLgZPS9P3+ZrKAcusKM
         ksD2wF81geFIi+ENytzo/xUNyFU3n/hQckh+NTj+tQ/Rbe33vdmTKHqgpT/dCoshlgUg
         XZSg71ZC1SHgbS+iePzhaOSd3b/I1Vwq9KvMbLJhlmJkVNk4M18dFnJJB1JF503C/+5M
         iAwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=etsH2Z2FQ4/k6Hm8S85g0OU8GjhZVqeMmdg39ne3B5w=;
        b=nXCR/cmoqKILEnc+PdOcaATpdbkH4hyvd2l5RjXCSh6iAOhCAhmo24hussp3RRkhwd
         MkC7ksaI/vwz+/6Zr5E3Hg+RpoCXr9Wz5oHOySiVBvVc2W4kSvNPuGmRr8OP3cVJxA6v
         ohcFSPbKnME9ZlPy2skONTWocdtgu71gGIn3OMnqJuFVPhACHVS4vXgco3qXY3mBHVcw
         o+kIeQsQqdv/czzCjvVkyADXKUmFyDoe3JOvAu24ioGzabdUUiWLZX9v8qzXZNzYOSi+
         rhPHPBelNNx2Vhtw8rcbTFh4fZjTFwQt+Or4vsS7n0+ckK8tjOfxW8xMEn4Lp646ccs/
         fMlg==
X-Gm-Message-State: AOAM531gLscI0+0oFCjATyJ5KZ/P6NW3lY7G5leG8Vn+thY/UoDMq7pL
        1sdU6H6rouyqjTa055Fim74YUZZl3Lk=
X-Google-Smtp-Source: ABdhPJzdu+HmWN9xB6BhBLHydFV0EBu8OobJhE8AIU4KLRGvvV8FroqtoVkanopkBY9JPh4hsFTuKQ==
X-Received: by 2002:aa7:d74d:0:b0:418:e883:b4e1 with SMTP id a13-20020aa7d74d000000b00418e883b4e1mr2988581eds.56.1647442164979;
        Wed, 16 Mar 2022 07:49:24 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id qk32-20020a1709077fa000b006df6bb30b28sm961122ejc.171.2022.03.16.07.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 07:49:24 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nUUxn-001T7S-Kq;
        Wed, 16 Mar 2022 15:49:23 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elia Pinto <gitter.spiros@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 2/2] git-curl-compat.h: addition of all symbols defined
 by curl
Date:   Wed, 16 Mar 2022 15:47:17 +0100
References: <20220316140106.14678-1-gitter.spiros@gmail.com>
 <20220316140106.14678-3-gitter.spiros@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20220316140106.14678-3-gitter.spiros@gmail.com>
Message-ID: <220316.86czimdkb0.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 16 2022, Elia Pinto wrote:

Per the comment on v1 I really think we should not do this...

> This file was produced from a modified version of symbols.pl
> (https://github.com/curl/curl/blob/master/docs/libcurl/symbols.pl) and
> by manually adding the previous comments describing the dates of release
> of some curl versions not currently reported in the symbols-in-versions.
>
> To do this the symbols are listed in the order defined in the file
> symbols-in-versions rather than as they were previously inserted based
> on release dates.
>
> Most of these symbols are not used by git today. However, inserting
> them all starting from an automatic tool makes it largely unnecessary
> to update this file and therefore reduces the possibility
> of introducing possible errors in the future.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>

But more generally, re your reply on v1:

    In the end I did not understand if you think it is worthwhile that i
    do a reroll of  the patch[...]

Better than a re-roll is replying to outstanding concerns about your
patches. I.e. this, which still applies here
https://lore.kernel.org/git/220315.86pmmndmre.gmgdl@evledraar.gmail.com/
