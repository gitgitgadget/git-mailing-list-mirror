Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D49C678D5
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 00:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjCHACc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Mar 2023 19:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjCHACV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2023 19:02:21 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB63DAF294
        for <git@vger.kernel.org>; Tue,  7 Mar 2023 16:02:03 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id cx12-20020a17090afd8c00b002366e47e91bso5744452pjb.7
        for <git@vger.kernel.org>; Tue, 07 Mar 2023 16:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678233723;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0ZWDydHCQiLaHZvdmNWWY9bJqCb4UAW8qSsCLXMaKFo=;
        b=Ae/Lm6c93jPGEX+QgKFdgA3G1BvYKIFU3dh5BbtJ5QB+s82P5P6SUpZgKFUTmZ4vWb
         45U5XbRf40Xys+ibPmUNK2NlIBpq4Y+JcQspaof7S37NpTWXE6h9cj+KvjQIXWcAag0G
         n3BX5d9uMmeJtdXOWlaY3a9ge37wlgaSSEelqGVbdA1aX63PbSTyYeQ+dGrbn5AfwDP6
         x9u1gFKx/hDb5gP3sBCaUZCtLFF6LLzArpj+qvIfCJ80DUnzh7UlD+pNHB7Oxn35oGcw
         HWOsbaT8YzcsPALD3KNDwKBCL3sSaxcqaVzjWDN12FwXjl9rJwPcDfk+5qXyyyQppXQs
         VSow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678233723;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ZWDydHCQiLaHZvdmNWWY9bJqCb4UAW8qSsCLXMaKFo=;
        b=b9o4dNav2oVyR7ulzdesTUoPg2Owm/Mm03LXFFgekdWFvQOV1e3VAcYhW4X8fGRrNC
         wORb4qVA+VLgu9OnadWg7vgAW0rH1a5SdtEBNr7PSJN6MGLDC7n3tVh2Ite1ByUlGGSH
         JD77exqplWVvRuLg3ONKI2rR25G7Jx8aRGFAcTkRXcNYADPaQyXNo56LhB5N19PWGVDQ
         40T3QRqCNptajPy9+YPbnF0G68HVyult9NP4Gi/0qrqLA+RxtXKZXc1ZE9iCDb+YZg9c
         qPxWPb7+CEMh2K5vxb6g5iLQ1lFHjDO4u9pReRopC/mkmNOyxZpmrYkEbpuCEKPr4c6D
         yysw==
X-Gm-Message-State: AO0yUKUVvn1UYCU+VMYevv6RZRdPO+IqFBn0evrRAwQMxdYCND0KX5ht
        lAZzWo3/pEhAYKJPDN3jCulUervhBVbVjQ==
X-Google-Smtp-Source: AK7set+0sTdObYFnZOCTYxiFXRGBxO2SycezFxbytWZI1I8IetTsE49fbCtvP7ZJz6bQ8y2IOzSgIbv7ciKi0w==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a17:903:492:b0:19b:456:63e8 with SMTP id
 jj18-20020a170903049200b0019b045663e8mr6235886plb.6.1678233723183; Tue, 07
 Mar 2023 16:02:03 -0800 (PST)
Date:   Tue, 07 Mar 2023 16:02:01 -0800
In-Reply-To: <20230305050709.68736-4-alexhenrie24@gmail.com>
Mime-Version: 1.0
References: <20230225180325.796624-1-alexhenrie24@gmail.com>
 <20230305050709.68736-1-alexhenrie24@gmail.com> <20230305050709.68736-4-alexhenrie24@gmail.com>
Message-ID: <kl6l7cvsi006.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v6 3/3] rebase: add a config option for --rebase-merges
From:   Glen Choo <chooglen@google.com>
To:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        tao@klerks.biz, gitster@pobox.com, newren@gmail.com,
        phillip.wood123@gmail.com, Johannes.Schindelin@gmx.de,
        sorganov@gmail.com, calvinwan@google.com, jonathantanmy@google.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> The purpose of the new option is to accommodate users who would like
> --rebase-merges to be on by default and to facilitate turning on
> --rebase-merges by default without configuration in a future version of
> Git.
>
> Name the new option rebase.rebaseMerges, even though it is a little
> redundant, for consistency with the name of the command line option and
> to be clear when scrolling through values in the [rebase] section of
> .gitconfig.

This rationale makes sense to me.

> In the future, the default rebase-merges mode may change from
> no-rebase-cousins to rebase-cousins.

I suspect a more likely future would be that the default is to rebase
'evil' merges instead of trying to recreate merge commits, but of
course, the important thing is that we promote the default, not what the
default will be...

>                                      Support setting rebase.rebaseMerges
> to the nonspecific value "true" for users who do not need or want to
> care about the default changing in the future. Similarly, for users who
> have --rebase-merges in an alias and want to get the future behavior
> now, use the specific rebase-merges mode from the config if a specific
> mode is not given on the command line.

so this rationale makes sense to me too :)

> @@ -278,6 +278,74 @@ test_expect_success 'do not rebase cousins unless asked for' '
>  	EOF
>  '
>  
> +test_expect_success '--rebase-merges="" is deprecated' '
> +	git rebase --rebase-merges="" HEAD^ 2>actual &&
> +	grep deprecated actual
> +'

I believe this used to be on 2/3, i.e.

  https://lore.kernel.org/git/20230225180325.796624-3-alexhenrie24@gmail.com/

but your cover letter suggests that it was removed. Mechanical error?

The rest of changes look good (besides what others have spotted).
