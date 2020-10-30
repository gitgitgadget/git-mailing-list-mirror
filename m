Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD2DC2D0A3
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 00:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1351A20704
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 00:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=atlassian-com.20150623.gappssmtp.com header.i=@atlassian-com.20150623.gappssmtp.com header.b="PyzOnX/5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgJ3Acd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 20:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgJ3Acc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 20:32:32 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB71C0613CF
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 17:32:31 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id p7so5748377ioo.6
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 17:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LGdU4am96tWwWy1SqbkuwWikEGM07EgICBKljRyAII4=;
        b=PyzOnX/5TBZaqdP5IBw//YzO4GlRaj+qGajxP69Yqu6cGXnIXDNKG/B9hpaJEd+TFC
         ox1/iXWbBvW0JXyrYfM1UXmndjTd+srz5ZKssA5TjwDLdnQFd9vwKrnwUalhG/4WFWLM
         zmOt8x9+lIV0eRQZNUHkOqFvxQlqVdea3d0Prddyimbu5HRGFyT12mze9L3DKoM8xfuT
         fnbogfeeVKLtEe4t3nMzuhQKpJxdgAyNlc1tmrqJucKWfShs44RTWEfqXjAmXcwM3B8z
         Kbn6SJ8ZMszzjbo1caH4xzp4743C2RHppT9xKH7fmBqM6AQvKoqyuEoLydEt6ZGeRxfG
         0Q+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LGdU4am96tWwWy1SqbkuwWikEGM07EgICBKljRyAII4=;
        b=U3draRwemo7QvDP4+YbooYjb0kuKUs20SYkYMCN6Reg9h0gXcpKzn2N5bwUdnzylCz
         e5OeTHbEO3mZqTBlZEt6j8YenUl5uqjNIzDjjmOxZJpCbkHq7/uc4PoHheXqN4noNJAc
         1EM0m7nNZKOUtQAkyXDus5ril+imq4xmhS3qetOy0SLECn04Vqf5i2e40rrQqE9Apf+u
         u/N8C9MplFP6dgdU41bYhiC5O1gj5batn2UeaXaRU8KfCmlKsUtoAc5BUk7IsaT7PLQ/
         miQttcC9KuzcjIsPL1ES3+A8yAs2AD2fIotkzyA9Yrn2Ol2OPHT7UVztDv615hHUqzR9
         hvJA==
X-Gm-Message-State: AOAM530Q7NvUo6UFmCPEmVu1Iku5Vme7/Rh1bRY8uDYQKOURLL9DesEF
        QHeJupQ1nLh7K0aPMZSc2RbqG1ZxJZItdUa8C5tQez6X8/I=
X-Google-Smtp-Source: ABdhPJzVaU3eExMTrEiOeZ4uwvv6Pu4zFOQQGvxnGdZABeWZVUmxA0l4gkwuxRnqt8CetBuPOcZ+m29UzdAZjEfq4nY=
X-Received: by 2002:a02:c547:: with SMTP id g7mr4108335jaj.88.1604017951208;
 Thu, 29 Oct 2020 17:32:31 -0700 (PDT)
MIME-Version: 1.0
References: <CANo+1gtVRj30-JNPFpqc_m3BSEFzcb8-T+-uJTFvnNuBZYYxQQ@mail.gmail.com>
In-Reply-To: <CANo+1gtVRj30-JNPFpqc_m3BSEFzcb8-T+-uJTFvnNuBZYYxQQ@mail.gmail.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Thu, 29 Oct 2020 17:32:20 -0700
Message-ID: <CAGyf7-HOkt3bCkJ+qshb0AFZSt2f=NmvHb3Gh1m2dzLWpYHozQ@mail.gmail.com>
Subject: Re: [PATCH] Fix upload-pack EOF death in normal stateless negotiation
To:     Daniel Duvall <dan@mutual.io>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 29, 2020 at 4:53 PM Daniel Duvall <dan@mutual.io> wrote:
>
> Hi there,
>
> I noticed while debugging an issue in Phabricator where shallow git
> fetches over HTTP were failing with 500 errors that `git-http-backend`
> seemed to exit abnormally after the first request even though the
> response was otherwise correct=E2=80=94and when the error is not surfaced=
 to
> the client, the packfile negotiation via `git-remote-curl` seems to
> continue normally.[1]
>
> I think this patch fixes the issue by having `upload-pack` gently
> handle EOFs at a specific point in negotiation=E2=80=94after shallow/unsh=
allow
> lines have been returned to the client (followed by flush) but before
> the client sends its haves.
>
> This is my first contribution here so hopefully I'm understanding the
> packfile negotiation protocol correctly and included my test in the
> right place.

Have you read Documentation/SubmittingPatches? It has some guidelines
(like submitting patches inline, rather than as attachments) you'll
want to ensure you've followed.

>
> Kindly,
> Daniel
>
> [1] https://discourse.phabricator-community.org/t/git-fetches-with-depth-=
over-http-results-in-500-errors/4317
