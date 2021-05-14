Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531B8C433B4
	for <git@archiver.kernel.org>; Fri, 14 May 2021 12:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DEE66008E
	for <git@archiver.kernel.org>; Fri, 14 May 2021 12:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbhENMba (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 08:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233190AbhENMbT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 08:31:19 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C36C061574
        for <git@vger.kernel.org>; Fri, 14 May 2021 05:30:07 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id v22so23418820oic.2
        for <git@vger.kernel.org>; Fri, 14 May 2021 05:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=NLr7D/WJhpsB9KVj75X5rUxT3vLsajeC+EOHjnHs5hE=;
        b=ZKRj1DP4ZN34s8qBsK6Wgze9ClFiEs4iZOvxRFBeqb5F7CviPvYN7dK8X5kfqmVRHU
         Sbxvhl+oGYySGoZIrXcNu9bBlh23WFuD034UgW78SuJBzaaF9hfU8biHtgBnOOuo1alB
         Z4Zhbh0xF1qeH34B9/I3s0FJPWM80OoFmAoLDj3QhhqWU4bs09hxfL+hBduOb4AYOHus
         bAYel3kVMFKXSDRxgDxdw+fumF6bYI1PSQnW1Ff2g2FY/LNbky/PofJncfAkZGxhpIff
         m0zVj+TlYMsSHkkjsP21IsII6K/fPBwdWcaWqgJyOyXjmAgBTa/HuPE41lIJ6MZvz6Ed
         WHPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=NLr7D/WJhpsB9KVj75X5rUxT3vLsajeC+EOHjnHs5hE=;
        b=jXCMzCKTErvTAlEiEe0XDZVjrz5+ZcI/6fshhKsiop27MHbYIXGs2FbZ8jTpSpJHyD
         J2uhVEFTsEhda10HO3JwHGASE4Kb/TyOUhZ4lfLNyYO7Iw+1zFeGBbY1thEMG05srRu/
         0Ni+E5xkTnyoQoDphF9XzJ0XYa3eIoiT9Q7aIAOPFg+XLWOFLPL6dQfKxlp8IfydDflx
         ZkO+oxsLfGkXzXr6vmRwm+ZQiER52ogY9UwDFyd17l+CkOBz6DA0TqfS1AQ6ISPsU7uh
         W9/WoGAG/KaUEP8/LlulwHaehdoRyU83RhnVS3uUWTWyFsxujmCzMpjJQ0mqMqlrmeEB
         9JPA==
X-Gm-Message-State: AOAM5304EI+v/wdRqpMFSsjt7rd1yTPZ9/ZkYfd0JlAGZZ6mJvQyZkvi
        flVjos/jNosrcHePJIPvoLg=
X-Google-Smtp-Source: ABdhPJxttNW3Pb5X55G+nbFOnRJ2GMpe5xFlqVeup/f2NQl1U2A6RBvwv8jbw6aOnuthTFHwopEVxQ==
X-Received: by 2002:aca:d68a:: with SMTP id n132mr6369306oig.105.1620995407011;
        Fri, 14 May 2021 05:30:07 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id c18sm1298275otm.1.2021.05.14.05.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 05:30:06 -0700 (PDT)
Date:   Fri, 14 May 2021 07:30:05 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Message-ID: <609e6d4d67f90_4312720862@natae.notmuch>
In-Reply-To: <CAN0heSqsrUU=GYsckhZT7Dvx=Rh3aWMMTMBLBfy2XuDWYpQPFg@mail.gmail.com>
References: <cover.1620928059.git.martin.agren@gmail.com>
 <f2a78267fd0f424c5cfa6969c891597af4d5171f.1620928059.git.martin.agren@gmail.com>
 <xmqqzgwy8faq.fsf@gitster.g>
 <CAN0heSqsrUU=GYsckhZT7Dvx=Rh3aWMMTMBLBfy2XuDWYpQPFg@mail.gmail.com>
Subject: Re: [PATCH 3/6] git-check-ref-format.txt: avoid single quote
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren wrote:
> On Fri, 14 May 2021 at 00:00, Junio C Hamano <gitster@pobox.com> wrote:=


> > The proposed log message did not explain why you wanted to avoid
> > double-quote pair on the "cat-file" line.  Is this meant as a
> > workaround for the "single quotes are shown around git cat-file"
> > issue?
> =

> Hmm, I've somehow tended to think that it's 'git foo' the tool and `git=

> foo --bar baz` the actual invocation. SQs for the former, backticks for=

> the latter. Like, `git cat-file` is not a correct invocation of 'git
> cat-file'. But I think I'm starting to see the error in my ways --
> CodingGuidelines says to use backticks around command names, so it
> really should be `git cat-file`. And changing that might just happen to=

> avoid the issue that triggered this patch.

Hmmm. `git status`, `git branch`, `git diff`, `git log`.

All these are both "tools" **and** invocations. In fact, you an pretty
much "invoke" any thing: `git checkout` might not do anything... But it
runs.

-- =

Felipe Contreras=
