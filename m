Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9FDC4708C
	for <git@archiver.kernel.org>; Fri, 28 May 2021 17:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5BB9613B4
	for <git@archiver.kernel.org>; Fri, 28 May 2021 17:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235671AbhE1RMA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 13:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236940AbhE1RL4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 13:11:56 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2BFC061574
        for <git@vger.kernel.org>; Fri, 28 May 2021 10:10:19 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 36-20020a9d0ba70000b02902e0a0a8fe36so4117525oth.8
        for <git@vger.kernel.org>; Fri, 28 May 2021 10:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=rT6AgbS2VS4QxYMuLkA2qwG5h5igYe5D/yJVwrjw80c=;
        b=ryfx/msbEsSsjySKzTBZxo17PXqSPHtMKq9aH6g2kBmAQbZTsSKrw0dCxMTzMYcU/S
         BOb50kpNi29mPWS24v4IyKg+LixrUB7eapyen/JS2DJfECN8Wt9UH9dAmayVY1ezFDtK
         5LKCQTXtX1i2+ujmwtoTCPDoMHcNEjgz9jgcXR5PmMcxK93uGami77j1GXtDKzF/I/b+
         M+8IGvKtuLA0pQrqsJWZq+gtaqxY2PiHZryuOVHhQ0rpeB7zCQvRWvI/QNvouo3NGw7o
         +iL3qpfDuyciILDWrZcGINpQxCtjfeX30FsY6hMTlb16i43oSMUKa/ZYcLblwaLTd6tF
         siMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=rT6AgbS2VS4QxYMuLkA2qwG5h5igYe5D/yJVwrjw80c=;
        b=MuhYuV06euLU0bPANuFr7NHFhGVgBmXefQ23LjLOBz9fKnG0tGZOo1zMchpxYItn//
         dfr9ck/t1SxiHmuHoTog+r2PinzaRZlQIFG4UqUxKxG9G3sxPZSrYd3MtbkfFRfMSmut
         PaYcz5gPx4N7bT1NHNZSGmxBl5bUu3by34/n6YfDIhfQg+uI/6Qd/oHGCR3ustO/wVVc
         4pMy6Ojtzj8iAX9nqtNJKO0KjWyBXHjkb4CT0kC5VONfBf0Qpz2kWi8fFGBbK0wSIbIs
         YBDwJ4ssmThY+8uB26VC2f7O7I8MhZzKzxiWofrqZXbXwY9bz0VnVvti/21LqRcN3jTW
         YXCA==
X-Gm-Message-State: AOAM533XBtWAS2nwTdKYdSL1aPEiy3fy76JDdVzf5OUnimLPW1Mb5H8s
        I0OFqTkKg2y8es37eIaeyqDdDXv1HuIQPw==
X-Google-Smtp-Source: ABdhPJxciulRtfkGqCWZj6fPQYAcjnfhJD/txQon0o0cI2jvZ5URazUg2JqH8shM54tDgr1OEXkdhw==
X-Received: by 2002:a9d:3d4:: with SMTP id f78mr7770438otf.224.1622221818484;
        Fri, 28 May 2021 10:10:18 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id 65sm1258916otj.17.2021.05.28.10.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 10:10:17 -0700 (PDT)
Date:   Fri, 28 May 2021 12:10:16 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Mathias Kunter <mathiaskunter@gmail.com>, git@vger.kernel.org
Message-ID: <60b123f8b0586_5190820868@natae.notmuch>
In-Reply-To: <fcf30899-8e64-5417-f478-14d6aca72544@gmail.com>
References: <3b9bc214-a30a-ba49-af96-7eeaf37b7bbd@gmail.com>
 <fcf30899-8e64-5417-f478-14d6aca72544@gmail.com>
Subject: RE: git push doesn't use local branch name as default
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mathias Kunter wrote:
> Felipe,
> 
> thanks for your reply.
> 
> > Sounds like you want to change the default to `push.default=current`.
> 
> Yes, but shouldn't `simple` pushing also work? The documentation says 
> about `push.default=simple`:
> 
> > When pushing to a remote that is different from the remote you normally
> > pull from, work as `current`.
> 
> If there is no upstream, then there also is no "remote I normally pull 
> from",

If there's no upstream the remote is "origin".

> and thus, according to the doc, `simple` should actually work 
> like `current` in this case. Am I wrong here?

Only if you are not pushing to "origin".

> If `simple` pushing is used, it doesn't seem to make sense for me to 
> fallback to `current` on branches which *do* have an upstream, but to 
> error out on branches which do *not* have an upstream.

That is not the criteria. It depends whether or not you are in a
triangular workflow [1].

If you pull from kernel.org, but push to github.com, then you are in a
triangular workflow and the name of the branch is not checked.

The oposite is a centralized workflow, where you pull and push to the
same repository, then git adds an extra check.

If you don't want to set `push.default`, you can alternatively rename
your remote to something other than "origin", then your branches with no
upstram truly would have nowhere to fetch from.

But then `git fetch` without arguments will not do anything.

Cheers.

[1] https://felipec.wordpress.com/2014/05/11/git-triangular-workflows/

-- 
Felipe Contreras
