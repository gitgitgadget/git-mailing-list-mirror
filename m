Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0105C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 19:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE6C3613D0
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 19:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbhHWTKb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 15:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbhHWTKb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 15:10:31 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF5AC061575
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 12:09:48 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id mw10-20020a17090b4d0a00b0017b59213831so173600pjb.0
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 12:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WwycvYnmD6Q1PAkJFQEniIbQHHa5/yLdaMF+gBsD6Qc=;
        b=pBIa7AodwEBNGtyaf+6pGphxqtsOD/y7kg6Du/GQJdhViAmKVzCefNGSE1SMw6gHpE
         vQZP+pfA+FD5Yq1KAO3A9v4oQ060/8/3mDEt09zaE1vF3QzY2+nTJwAPaatocG3vuHCG
         O43ZhqwIC6Chv78zWnsIcYsQj6+hOeaJH2NA9BhPZES6Kl4oIRZSn6p/ai54mbw3FLD/
         KO9T4CpVAFP6rYjN765Pkw5fP0qAHzlsU9QA/bLHgSCihabFjMt3gvGz9gDgPIwDEFuE
         IYzWbOMYNyu2achhxOHRwmq7EubtvoXY6BuUUCFTe/LR/Gqe8PLzNdCksAHxupu+ntws
         qlFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WwycvYnmD6Q1PAkJFQEniIbQHHa5/yLdaMF+gBsD6Qc=;
        b=DOJ1EUBUH0KMjILbcoXQqr3yBJyOkebbJ/vVnGn91l5q1DiyNAqgUGkU9UfcRt0OFz
         pSS8TNE1Ohrz+/Zy39rxdzYFYrzghJ65hvY3KUxhHGf910gKMtKDU15r0xQDjJuhaiqi
         569JGZ07BulULvoPWCXuBTzXRm+PDd3AnWAn43xSxZh/gQUsbpyQowsK1Kqq3NQWZaa3
         9tp2Nd2tbBqEeP0nr/L9NZ6riFPjm5Iq5XVc4iGlGJeyw/jHoJJ+P3IYSLbsI4nH2v1H
         JIeH6bvMUS/yW/3hZjV0qme62SP38GQwFb5BqUxNFqVpQ2zbm8nIa9IXGanLKm5tYGzC
         ZO3g==
X-Gm-Message-State: AOAM533vEZOWjSSSmMORqtoXlVtuDWJVv93/+RCxWXhJKPFBouaLOTUa
        5pJVu9/RwMOQdyPsDNoKOlYwkCRoyohKxGAgVgI=
X-Google-Smtp-Source: ABdhPJxm1qFDM2o0t7UugYMz7jumsaW3jE44cwouOdmBkMqdtXOh9YZ88S/Xbe0Hret9NDp6Etd5joyCqcmLi+J5c6k=
X-Received: by 2002:a17:902:aa89:b029:12c:17dc:43b0 with SMTP id
 d9-20020a170902aa89b029012c17dc43b0mr29546047plr.81.1629745787871; Mon, 23
 Aug 2021 12:09:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAMJzOtxMjEuAy2B3oJqOZEnipmC4OBWxhQLx_baXDHcQ1C7-+g@mail.gmail.com>
 <YSPuq/HmF3tnYHCA@coredump.intra.peff.net>
In-Reply-To: <YSPuq/HmF3tnYHCA@coredump.intra.peff.net>
From:   Nikita Bobko <nikitabobko@gmail.com>
Date:   Mon, 23 Aug 2021 21:10:33 +0200
Message-ID: <CAMJzOtz_h0iEL1VQCFvvLzw3XnL+qM=f+BvkmsTU=ps+0VA7RA@mail.gmail.com>
Subject: Re: git read-tree doesn't accept tree-ish
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yes, now I see. Thanks!

I was trying to read state of a particular directory/file from a
particular revision into my index but so far didn't manage to do it
reliably.

I was using `git read-tree <hash>:<path>` and it doesn't work for
files (because they are blobs not tree-ish as you elaborated it to me)
and for directories, in my cases, it fails with not so helpful
message:
```
error: Entry '<path>/<subpath>' overlaps with '<path>/<subpath>'.  Cannot bind.
```

`git checkout <hash> -- <path>` also doesn't work in my case because
if any file is removed in `<hash>` but not in my HEAD then `git
checkout` doesn't remove the file in my HEAD

On Mon, Aug 23, 2021 at 8:53 PM Jeff King <peff@peff.net> wrote:
>
> On Mon, Aug 23, 2021 at 07:31:29PM +0200, Nikita Bobko wrote:
>
> > ```
> > git init
> > echo foo > foo
> > git add --all
> > git commit -m 'foo'
> >
> > echo bar > foo
> > git add --all
> > git commit -m 'bar'
> >
> > git read-tree HEAD~:foo
> > ```
> > EXP: Read information about file `foo` into index
> > ACT: `fatal: failed to unpack tree object HEAD~:foo`
> >
> > I expect it to work because manpage says that `git-read-tree` accepts
> > `<tree-ish>`
>
> In your example, "foo" is a blob, not a tree. And thus HEAD~:foo
> is not a tree-ish. Just "HEAD~" would be.
>
> What are you trying to do?
>
> -Peff
