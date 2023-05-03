Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64235C77B7F
	for <git@archiver.kernel.org>; Wed,  3 May 2023 20:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjECUis (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 16:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjECUir (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 16:38:47 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185C21BFA
        for <git@vger.kernel.org>; Wed,  3 May 2023 13:38:45 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-74e3531b971so30340185a.1
        for <git@vger.kernel.org>; Wed, 03 May 2023 13:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683146325; x=1685738325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BM3Cm1VQjfq79IgxwdlTL54sA0zhiZ3tXPcVIkUo/7k=;
        b=Yu4UirpB/w+heQ0UM2RmLZMqrFJDN06IG6DcLJsSuqjzcGZ/Hk0FPbPo2wt3Cjpo7y
         ZOM47j7MgGdL/R0jAWjB0UDuctr/dNkI95YSYrCzS6pc6pB/y2TLA2Srr2rrTzmrhp1W
         47U8CbDlbS2v4+I9+7cPmlWCyqSouvEzuLf8wqb1xhYGkZinXVEH2sIyz5KKSYAUFd8H
         +jKYuWEEBexYCdZ9dvk8Ug0mb6fbZ11fBIllIWCd4aEppoOsTmJ+rPrFnSeIDn2hDWU/
         BAxs7U0NkF6QMccLr8G1MXSLqEh9Hwnzy1Oz2RDQkj1wLFaJ5PyzyKKDWGJg7vrjhs9y
         fP7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683146325; x=1685738325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BM3Cm1VQjfq79IgxwdlTL54sA0zhiZ3tXPcVIkUo/7k=;
        b=Ml3WMxbDKs53gV2EM0UmSVJVohSHRWlJ3EKsXOHxJs+YLYRvU450v5ayzvUkdQHYe0
         95Ey084Ssh3satm36qw46z2CbZnxf8PP5O5Da1yHoVjNjvS31jQzR2uNHZQEICvpcy1g
         4jJV8ePqswauuPwyvauuZox27Dzm/TciHVDj0jA183LSFTiZSrbxjVdgI0gAS+sj9yqS
         KaeXS6Z0J/cVHmB2mBEZFSbjW0MsYpo1udjULX56JLAX+8pBYlC3nKi8CBIR2oPSuzvv
         0Hr2pGEND24blqtvevTDpg0C7KJmrlfgXn188+tGYO0Qh1UThMlGPb8EiwMoG4ejb3ol
         n2+A==
X-Gm-Message-State: AC+VfDxdHosRJvANcbosHlN7c25XOShmc3GgyVmLDWsNvAHIlsd8fARA
        uTKNbIGo8VXILJzT56h321w=
X-Google-Smtp-Source: ACHHUZ5PUeQOPGl0EBmd6+90a6CYjeSXoyKUgU3Tbudp5MuDgVgRfpggJ9VCOG7Xm+/6EeA4bGzNzw==
X-Received: by 2002:a05:622a:30d:b0:3ef:4a8e:cb84 with SMTP id q13-20020a05622a030d00b003ef4a8ecb84mr28972326qtw.2.1683146324839;
        Wed, 03 May 2023 13:38:44 -0700 (PDT)
Received: from localhost (pool-74-105-67-34.nwrknj.fios.verizon.net. [74.105.67.34])
        by smtp.gmail.com with ESMTPSA id k4-20020ac80744000000b003edf043048bsm11839311qth.9.2023.05.03.13.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 13:38:44 -0700 (PDT)
Date:   Wed, 3 May 2023 16:38:43 -0400
From:   johncai86 <johncai86@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2023, #01; Tue, 2)
Message-ID: <20230503203843.34xwgjdsnifnmzbf@pop-os>
References: <xmqqcz3ixsas.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqcz3ixsas.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/05/02 03:49PM, Junio C Hamano wrote:
> Here are the topics that have been cooking in my tree.  Commits
> prefixed with '+' are in 'next' (being in 'next' is a sign that a
> topic is stable enough to be used and are candidate to be in a future
> release).  Commits prefixed with '-' are only in 'seen', and aren't
> considered "accepted" at all and may be annotated with an URL to a
> message that raises issues but they are no means exhaustive.  A
> topic without enough support may be discarded after a long period of
> no activity.

> --------------------------------------------------
> [New Topics]
> 
> * jc/attr-source-tree (2023-05-01) 1 commit
>  - attr: teach "--attr-source=<tree>" global option to "git"
> 
>  "git --attr-source=<tree> cmd $args" is a new way to have any
>  command to read attributes not from the working tree but from the
>  given tree object.
> 
>  Will merge to 'next'?
>  source: <pull.1470.v4.git.git.1682822352360.gitgitgadget@gmail.com>

Christian sent some more feedback on this one. Latest version: https://lore.kernel.org/git/pull.1470.v5.git.git.1683144574158.gitgitgadget@gmail.com/

thanks
John
