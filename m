Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B5E01F462
	for <e@80x24.org>; Thu, 21 Feb 2019 17:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbfBURDN (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 12:03:13 -0500
Received: from mail-io1-f53.google.com ([209.85.166.53]:40894 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbfBURDM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 12:03:12 -0500
Received: by mail-io1-f53.google.com with SMTP id p17so2245874iol.7
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 09:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=xqPTwTG0EiUuK1w9UUF5t5dOUrhxT3fR0pAH1jkJkww=;
        b=k2tD4YIM0MrBLCQpIt7YZmGIBKwQ1AxpBaUeLklceDqPav22sodk0qq6/uvP4FU/K0
         ebSdSVU2G0949VArEVtG7OCRGYwksy+InKg1YVMBokH924nQ1rkXmqPZyXtdHVbohYdV
         VyWLgqcmBd21G3mRx/lWF3J+Rr78A7T+nVKOeH4aHnsU0a8paHQBvjHiBfW95teh6JCX
         N+mkZBWgf2x+PeU8a/EXKb1B8L2rjRxrpFOc8Uxs5s8HFPsLKqpPG8gtvdgZjkW0Pfom
         S6cBH0iu4cqPfbTKdeepqeY4GgL+IkUuLkL7wA3oC5ukLZ6u86nqe6IfrRvKMOqCo1VD
         0+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=xqPTwTG0EiUuK1w9UUF5t5dOUrhxT3fR0pAH1jkJkww=;
        b=jIJGsv3/lC+UqK/zsia3IMjY6Q3C8BqSDNy8vw3WMO3L6nOiL1V/K1xZM/tmlFCW2A
         puO+Qh6TE3RC3xajLconH4w8+x+rhQtgJPjXQKFK56AqwJTkfTf+gDTgoZV+Mo6hEHIa
         gsPNznaEpwIJfwZWhe4wUCR0dvQyee4/LjihuspdC/d2vXyrcdItHV9jP/KqY7j359P0
         w+V7bM/A5b+LGleb0eOF+3fiughunS7b67oNNafGhV8omXdPowGqttCi1VzsFXQreWYJ
         l/jYlrk9VHVjkveCLS2EGTTXDFUflbNArfhljvC/fmF2DGQEqj4ltqPDUQKBExFYokNL
         aH+Q==
X-Gm-Message-State: AHQUAubmeMIaQfnGUUBwRUpcMeZzoug3RaJ+U/sdqIf/okXPQthX8081
        bfQ/N9eI4k2umVVPqouuchYFfhDh02VJBE0F8RajaMq/pHQ=
X-Google-Smtp-Source: AHgI3IbFw/Y6uXTiBH4uLPUDQRvujWba8aPS3tl9oXzwk+976Qn5July5cKX9PxDAGVxmYQoCcJJNlE6y8ZjBcDmaTQ=
X-Received: by 2002:a05:660c:44e:: with SMTP id d14mr8000579itl.99.1550768591123;
 Thu, 21 Feb 2019 09:03:11 -0800 (PST)
MIME-Version: 1.0
From:   Dominik Salvet <dominik.salvet@gmail.com>
Date:   Thu, 21 Feb 2019 18:02:54 +0100
Message-ID: <CAEXP2g92_pnbh4_V8VOgzzdUv6w5eDhCsXf=+NOdsRwyjQUb5A@mail.gmail.com>
Subject: Fetching master branch with tags associated with it
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git community,
For quite some time I am trying to solve a problem with fetching the
master branch from a remote with tags that are pointing only to the
master branch.

Cloning the master branch of a repository with tags only pointing to
that branch is working, though. In this case, the following command
will do the work: `git clone --branch master --single-branch <url> .`

Now, I want to refresh the repository the same way - fetching only
commits from the master branch and tags that are pointing to the
master branch and also refresh those tags as well in case of their
target commit change at the remote (you can expect that it always
points to a master commit). Nevertheless, I don't really know how to
do it. The closest I got, are the following commands:

```sh
git fetch --tags origin master &&
git merge FETCH_HEAD
```

However, there obviously are some problems with this solution. The
`--tags` flag will cause to fetch tags from all branches. Furthermore,
it will fetch also their commits, which is absolutely what I don't
want to.

I have Git 2.17.1 (on Ubuntu 18.04.2) and in its `git fetch --help` is
stated, if I understood it correctly, that without passing neither
`--tags` nor `--no-tags`, it will do exactly what I want.
Nevertheless, without using any of the mentioned flags, it behaves
more like using `--no-tags`.

Am I missing something? Do you want any additional information? I
would really appreciate your help.

Thank you for all your effort
-- 
Dominik Salvet
