Return-Path: <SRS0=sf8h=ZQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DC6C432C0
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 18:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F514207DD
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 18:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=thelayzells-com.20150623.gappssmtp.com header.i=@thelayzells-com.20150623.gappssmtp.com header.b="w3YP6QBW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfKXSbV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Nov 2019 13:31:21 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46142 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbfKXSbU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Nov 2019 13:31:20 -0500
Received: by mail-lf1-f68.google.com with SMTP id a17so9160364lfi.13
        for <git@vger.kernel.org>; Sun, 24 Nov 2019 10:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thelayzells-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y4oSajjmjfV39avthrNELJ2miBhuhv1Upf67fPFuCSQ=;
        b=w3YP6QBWsYIm73hH4+tKuCtaCFVDxZKDrSpfQObEg5RcxqJj6R2wCS5i+/iiYvZENg
         NOXZz9ozXj4JL4Z/Ibt+L6IE2dyyimIs5KpU1MXp6K6IxqO4v7f/mXGKX2hEt5/HyC36
         O/+A7pf/ITlhj148Nmn3j0qlHoBpqp8IXqtqP5syjpbsiZGnetEUn+GaKRbgDYz+OV2j
         EQsrIVK4xXUisSnepAaxQJXT4nk8dIYlBC37C2JxH5rxg4/qSsLXyJqLdBLhBYMZxCxL
         HP6y/mxTU0TfzAF6hgzARsOlBi9UPojiLOb7dNnMrQszfj6zMmSxMorQXAZEmDfAZBDi
         vFsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y4oSajjmjfV39avthrNELJ2miBhuhv1Upf67fPFuCSQ=;
        b=QZ7Roead7gkbpch+zl59q3TTk7cUz/ogWeDVO8bQAXoCZYwLdUfh2m0GZNpNbrUU7U
         spwaE1W8X8I/L3XrNUrxG6AOvAble7/s5B0esClz9g56YMxOLAuKw4Zl9FAR3tybTkAp
         6Z3HXcX9JoXQbBdy4idbD484VzU2ytpYUEMSBOnbN+Hl1xT+XoXD0dWsU8AYVxxdgxQK
         /K8+G5nnct+KzV0HMHK8311zykbGgycPVSn5GeaTNYJelOmdgPO9NVOB+C1iF6tzPjXn
         QC9Kt1GDWSa1mxVIjUPbozwo1i1MeOjvx7lB2ceQjpRq2zyCOOFLHTywQ3ssBwsDLFk5
         YIIA==
X-Gm-Message-State: APjAAAXFzokXLoUrd7RKMaRmblhvZXvH54N8btvpktJXqUoRBbkhAPwA
        g/b/nL2JZ0gbSrq0gLY7oxoHS/ojx0ta7Z56zxPJVQ==
X-Google-Smtp-Source: APXvYqxgQ7snCMZHmnKsHgFTPjZcfEIw1thZViHN0kS+BkFkhP9iTKV7EGWgKaWB55B11siwWYgyZlVC15ktM8mJM3s=
X-Received: by 2002:a19:f606:: with SMTP id x6mr17416875lfe.160.1574620277101;
 Sun, 24 Nov 2019 10:31:17 -0800 (PST)
MIME-Version: 1.0
References: <pull.474.git.1574538937.gitgitgadget@gmail.com>
 <338c2777f711ac21a30a7f890a8a11708e9a4fa6.1574538937.git.gitgitgadget@gmail.com>
 <xmqq4kyt250e.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq4kyt250e.fsf@gitster-ct.c.googlers.com>
From:   Nika Layzell <nika@thelayzells.com>
Date:   Sun, 24 Nov 2019 13:31:06 -0500
Message-ID: <CACwGqKgPYMEHhfOnAEuCA3sNiuV0Wk_JQwU+c=vF7Wkhf=V9iQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] reset: parse rev as tree-ish in patch mode
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Nika Layzell via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 24, 2019 at 12:54 AM Junio C Hamano <gitster@pobox.com> wrote:
> I notice that under the patch mode after this part of the code, we
> do not even use the oid computed in these pieces of code at all.
> Presumably, run_add_interactive() function would also be sanity
> checking the incoming "rev" and giving an appropriate error message
> when it is not of expected type.
>
> Which means that perhaps a cleaner fix may be
>
> -       if (unborn) {
> +       if (patch_mode) {
> +               /* do not compute or check &oid we will not use */
> +               ;
> +       } else if (unborn) {
>                 ...
>
> right?

I tried to make this change, however it has unfortunate side-effects. The
"git-add--interactive" script does produce an error if it is not of the
expected type, but it exits with a successful "0" status.

$ $(git --exec-path)/git-add--interactive --patch=reset HEAD~:README.md --
error: Bad tree object HEAD~:README.md
No changes.
$ echo $?
0

Given that the add--interactive script is undergoing a C rewrite, I am
inclined to continue validating the argument in reset.c to avoid changes to
the perl script.

> This only tests a positive (i.e. "see what my change now allows you
> to do") without checking a negative (i.e. "I started allowing a
> tree, but I didn't inadvertently started allowing a blob or an
> object that does not exist"), which is an anti-pattern.  Please have
> another test to ensure that the parser fails when it should, too.

I have added negative tests for the next version of the patch.

Thanks,
Nika

PS. Apologies for the duplicate email. I accidentally sent a non-plain-text
version previously which was rejected from the mailing list.
