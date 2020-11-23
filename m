Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D38BC2D0E4
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 19:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0992F20721
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 19:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9eF59FK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730315AbgKWTkv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 14:40:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729940AbgKWTku (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 14:40:50 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E44AC0613CF
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 11:40:50 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id t4so6863697wrr.12
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 11:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GztBu3BYkrjMM24cNYLXf5HO7PeEHVkFHNedbAyuF1k=;
        b=H9eF59FK4VLOYgJ4L/p8QcJRqeulHJDVCr1wrrx1xn9qcQPoWDTYgtPGNtUkTY1I9j
         LjcZ2xNjTOBHOXj/+V1CUHhbg8t0AwmoYDZqNtzw9CK15dqlMPUoVVUprqVNRh5aWHVM
         LEreevAXdsIH/w7O7iYJHnM2rWJ8XXVt3fUmCxeKm4v/4LGbeaoeD0rcnZWQUKJlGy0b
         j0ujp93kvwLJqXK4sQZ1SdD0CvqJUK1rtVRf4ESLiROVH7pjCSEl/VGOnrD6/T7JAwUV
         wsfvfsPPbsqCGoq0MvlAYI5CtQ6FbMTk+EN4SRRcO4esxUr+wDMxkr6RQL7EsP8p09hT
         WAig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GztBu3BYkrjMM24cNYLXf5HO7PeEHVkFHNedbAyuF1k=;
        b=EJ56TbZD/bVTGCHTmqic5nbgRQPjjWXHfafxpv9K43nwIR4kpNAazZe+sC8hCb2fmC
         rNj0P/mUSwDZs6HAJbAmIIO2kHApU1afPpKkxDvR7EYUn7yP7V6fiAxcFI9pjnV45ISq
         0Z/kH3Mh1mkotiWHZU5LbG2dv/9SChHdoqjQqEkIqC6PzDOlmf/hoDxgzCTwGn3hoEAT
         y8UqKv3ffXHfTx2jloPDcuxGsXBx9o95caj4NR7G/r1wUtnlhHfEomSNQSwzNafLhC//
         FobUtQQLrL2LHv4AQuCJmX1jutJnQ8PDVtxH4M/sgWtLkwC3Cvp4ghidghXkwuobJlSx
         afbA==
X-Gm-Message-State: AOAM533stRNYmafnfGk5Jo8h6atx+SkKOKFrUSy9cWa9cflvxdsPBHvH
        DWQNhykgEEzPRPy/xr+8rWK2fHPyJMpYrsCIUNqEpB+RgaGazA==
X-Google-Smtp-Source: ABdhPJwSTDZ0KWWL/hxyJJ7riiP6lFhs3qntm384Jysf1z7Zno9vltF5VhNgAWs0i90g3qV9IIwnPnDN5kGd4VFkIn8=
X-Received: by 2002:adf:e788:: with SMTP id n8mr1331173wrm.84.1606160449226;
 Mon, 23 Nov 2020 11:40:49 -0800 (PST)
MIME-Version: 1.0
References: <742df4c2-2bc5-8a4b-8de1-cd5e48718398@redhat.com>
 <CAMMLpeRLsE=zNDjCRKmEMFxJBYcnTOdDGxEL9cZuVhuDMF=sLg@mail.gmail.com> <20201123191355.GA132317@mit.edu>
In-Reply-To: <20201123191355.GA132317@mit.edu>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Mon, 23 Nov 2020 13:40:38 -0600
Message-ID: <CAMP44s3cKVxKa0gOPfi3XRKbGbV=DweFE5pL0HM+v0kECFyPWA@mail.gmail.com>
Subject: Re: Pick the right default and stop warn on `git pull`
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 23, 2020 at 1:17 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:

> If your repository is effectively a leaf repo, then rebasing may be
> harmless, although there are still who don't like rebasing because it
> invalidates your previous testing.  My personal preference is to do a
> git fetch, followed by a git merge --ff-only, and if that errors out,
> then I know I need to take a bit more care before deciding what to do
> next.

Which is why I suggested to make fast-forward-only the default:

https://lore.kernel.org/git/1398988808-29678-1-git-send-email-felipe.contreras@gmail.com/

In what case would that default not be what most people want?

-- 
Felipe Contreras
