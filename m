Return-Path: <SRS0=SopW=7V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FC4C433DF
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 19:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 919B82068D
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 19:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIPvJ086"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgFHTIe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Jun 2020 15:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgFHTIe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jun 2020 15:08:34 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8B0C08C5C2
        for <git@vger.kernel.org>; Mon,  8 Jun 2020 12:08:34 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id w18so11117400iom.5
        for <git@vger.kernel.org>; Mon, 08 Jun 2020 12:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sWFvQ9xgASHNPGarMi7wTi5uCJ1/RlCdxmv+G/I2iZo=;
        b=dIPvJ08632iFTOS+WN4ASSQtXgX68uTJ6qN7vN0Xubh5MYlpr3rc3RE9hyzrd+MhY/
         1lBkkv4Og+UxddRbWCR7MD3uU0OROUqESat1IaP4BVM2D+kUCKQy8RJo3dQLZarGsb7a
         fZeNv6dtTzXDm4B9Ldyst2vPUTv57a9KjHONZZZrGVIGI5wAFUz/XqzGnM/9PIsdI65v
         O/F4TPn2OymVniD0nJhSpbScb7w25/6nObKBKd37JK04nZy+euayjv52UgYHmTBw2TxD
         yq6dBBF5vyRt6EV/0M0/5O9qZoGL0eFmJiTzo+L13qKebVbv87ueySYu63BP7n0K9sVc
         wZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sWFvQ9xgASHNPGarMi7wTi5uCJ1/RlCdxmv+G/I2iZo=;
        b=pATw7PKvk4IFkdzcKP3JwWTM2YmvlKS4cWhZo9KIFdqR2tg0vxMUMWCMff7MIT7ZTc
         qWqQIXm5ijIoYn1oXiS22K60rECBsg7rsIslCHK/S52OCHvzx+i3BNsQmWQ6Z5LBMPwv
         JbSPgnN3E2pI7kFGuHlc/fnMb6UbDAMaTDaGSftBrnAX/lskn9GKsoeMsO0Br23MVRQ2
         qy+wFLNAj27D5OzSnhMLZ/iR7pE0599jln44otVXakDz+KIpTwJGKClrK1wGXwlsstFL
         8kZdAdNd1beJBSUgpGPtip4ELN0qSj9Hr1gxMHfZfCfkznInl1fmd9qYM/vFCWch4Mwh
         07UA==
X-Gm-Message-State: AOAM530mbTA4zU3PgD2IMFXpj0mubIePd7T2mX8FncHKs6EyNBkaye/i
        97SspixhNL24bK04NuoCY174Z/+nO+U1rLb1bD8=
X-Google-Smtp-Source: ABdhPJyUwp9N7G2yX43xMt4MxKxHsW1h6QSkRUIvekk0TI8/Y4QNXdkRGMxJpMux0EEJl6a5nxTYgiFeRKtFLOEQUiY=
X-Received: by 2002:a5d:8458:: with SMTP id w24mr3032827ior.65.1591643313074;
 Mon, 08 Jun 2020 12:08:33 -0700 (PDT)
MIME-Version: 1.0
References: <CACNAnaG19QD1PbVS93nFm3XY70CZCrRosmVq-_3j+puAKSPj9Q@mail.gmail.com>
 <xmqqd06an6wf.fsf@gitster.c.googlers.com> <CACNAnaHBPeg1SMMGUdErKnn12bGo8t3O7LU6Yktw40B7bKfBGA@mail.gmail.com>
 <xmqqlfkxlbn4.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqlfkxlbn4.fsf@gitster.c.googlers.com>
From:   Brandon Casey <drafnel@gmail.com>
Date:   Mon, 8 Jun 2020 12:08:21 -0700
Message-ID: <CA+sFfMcQ+HQPk3SMsBhWjfLiVLzfhHSv9OpzPHAJt5b50TEPeQ@mail.gmail.com>
Subject: Re: fread reading directories
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Kyle Evans <kevans@freebsd.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 8, 2020 at 10:18 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> It may make sense to do one of the two things:
>
>  - The lighter weight one is to rename the macro to the reflect the
>    trait we are trying to capture more faithfully: "fopen opens
>    directories" and leave the code and performance characteristics
>    as-is.
>
>  - Heavier weight one is to audit callers of fopen() and only let
>    those that know they do not have a directory directly call
>    fopen().  The other callers would call our wrapper under a
>    different name.  This way, the former won't have to pay the
>    overhead of checking for "you gave me a directory but I only take
>    a file" error twice.  This is what Brandon proposed in the
>    thread.
>
> Doing neither would leave this seed of confusion for later readers,
> which is not ideal.  I am tempted to say that we for now should do
> an even lighter variant of the former, which is to give a comment.
>
> Thoughts?

I'd suggest a medium weight approach which would be to introduce a new
function with an appropriate name (fopen_file_only()?) that behaves
the way we want it to, and replace every existing fopen() call with
this new function.  We could introduce a new macro, which I think
would only be used on Windows, to say "fopen already fails to open
directories" (FOPEN_FAILS_ON_DIRECTORIES?) so that fopen_file_only
could be simplified to just a bare fopen there. That way it's clear to
the reader, at the callsite, that the call does not have the standard
behavior of fopen.

Then, FREAD_READS_DIRECTORIES could be removed from all but the 1 or 2
platforms that it was originally set for. I'd imagine that we'd
basically just promote the git_fopen() function from compat to become
the implementation of the first tier fopen_file_only() function.  On
the FREAD_READS_DIRECTORIES platforms, a bare fopen would also become
fopen_file_only(). The call to fopen() within fopen_file_only() would
obviously need to take this into account to ensure that it calls the
real fopen().

I think this would put the pieces in place for someone to audit all of
the existing uses of fopen_file_only() and potentially replace them
with a straight fopen() if appropriate. And it would allow future code
to explicitly make the choice between fopen_file_only() or just
fopen().

None of this would produce any functional change on any of our
platforms, but I think it would make things more clear.

-Brandon
