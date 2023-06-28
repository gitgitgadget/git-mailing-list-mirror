Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE07EB64D9
	for <git@archiver.kernel.org>; Wed, 28 Jun 2023 00:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjF1AOd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 20:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjF1AOb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 20:14:31 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D138FE6C
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 17:14:30 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-56942442eb0so66942627b3.1
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 17:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687911270; x=1690503270;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6HocJWMDKq+9dO4GRixPU/ofD/x7ALm3sK8BeSF98do=;
        b=CzEzfwviR+i32rPjaZQJpDCwI+10sWFwc3m4Zf1+Hc7ZYK6S6kgIrcJElpmmxlI6rE
         5wTMOyMbob/04nvW8MFxvJvw+IFAH7gIkIXP2Nboj8ZcCJVPoGE0qgzBLWYvRrDJgQ+S
         xzLM3/cUQ5+5IqEHad8cRaEhCZEC0X74Kt0Z8xizKOrcYeLhqdTPVp3Gi/0l21jVWjfD
         eKwpuhe6Mmbb/nN0ZWPQ85XagklIl1nsyZUtm2Jy/AeMI9xwmAS6KZWbxN41bqeou6HT
         C+lZ0ETBLiVm5tUizfPf1FkDNxuUWr0kI/E9Z6x7vsC+G9oqVKWRIonaGWL2s3ay4306
         ZELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687911270; x=1690503270;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6HocJWMDKq+9dO4GRixPU/ofD/x7ALm3sK8BeSF98do=;
        b=l6uvWImwL0tHYrhY3BCkga1JEcYCLel657Iz65eY+dPHCeg89o9GUvNHqcrEJr1eg9
         BdQJjEpfU9Xpg1oysiMb2cwkPIj5UbHBdZgD0Ht2DBXb2c/31/ap0wU9n12gLY0lYt70
         68qvP/Xe+iOgN2Nx873RHesMnRNIWl0RbjuvlQc6ZTfWeBv4CIwNhFhE6XcOgB8ZvfRF
         P2+hm5jrugvWikM+7H62un6Sdep6LxZOMfsh19YizbpNQCSXi1hy2bhy7NL5EqAqgCh2
         a6lT+m6OlyAC15YfNEB5JBj3lNc/CeDoyLhSDcDGHvBys8/QjTiBpeos6TV3Kz5wh7Fe
         Snlg==
X-Gm-Message-State: AC+VfDyDkidwcVWEXxU+S8fMfPcnkaE0acRT+/QyFYpP7vHJZChj/JI7
        Kz8ji6XDKKwdCx+iPn72Rg6bKW05LQo2VQ==
X-Google-Smtp-Source: ACHHUZ4jGFqMJ/aQA5WyIlm61NC3fP1dC7jumM7fZli23WAVx/1gp8BCM6/92YptBdSfAvDuOJRtclwDhggZFA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a81:af59:0:b0:573:3897:c925 with SMTP id
 x25-20020a81af59000000b005733897c925mr11234183ywj.6.1687911270093; Tue, 27
 Jun 2023 17:14:30 -0700 (PDT)
Date:   Tue, 27 Jun 2023 17:14:28 -0700
In-Reply-To: <20230627195251.1973421-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230627195251.1973421-1-calvinwan@google.com>
Message-ID: <kl6lzg4kqw7v.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [RFC PATCH 0/8] Introduce Git Standard Library
From:   Glen Choo <chooglen@google.com>
To:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, nasamuffin@google.com,
        johnathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I see that this doesn't apply cleanly to 'master'. Do you have a base
commit that reviewers can easily apply this to?

Calvin Wan <calvinwan@google.com> writes:

> Before looking at this series, it probably makes sense to look at the
> other series that this is built on top of since that is the state I will
> be referring to in this cover letter:
>
>   - Elijah's final cache.h cleanup series[2]
>   - my strbuf cleanup series[3]
>   - my git-compat-util cleanup series[4]

Unfortunately, not all of these series apply cleanly to 'master' either,
so I went digging for the topic branches, which I think are:

- en/header-split-cache-h-part-3
- cw/header-compat-util-shuffle
- cw/strbuf-cleanup

And then I tried merging them, but it looks like they don't merge
cleanly either :/

(Btw Junio, I think cw/header-compat-util-shuffle didn't get called out
in What's Cooking.)

> [2] https://lore.kernel.org/git/pull.1525.v3.git.1684218848.gitgitgadget@gmail.com/
> [3] https://lore.kernel.org/git/20230606194720.2053551-1-calvinwan@google.com/
> [4] https://lore.kernel.org/git/20230606170711.912972-1-calvinwan@google.com/
