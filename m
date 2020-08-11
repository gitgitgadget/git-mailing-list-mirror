Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670E9C433E0
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 05:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 343CB20756
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 05:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgHKFBk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 01:01:40 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:33513 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgHKFBj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 01:01:39 -0400
Received: by mail-wr1-f47.google.com with SMTP id p20so10201585wrf.0
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 22:01:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uU80EhMpHUwhMNsF+nLOWwrb8xuL9pesmAZ80R0NVx4=;
        b=JS6qpT805WjxF4WnOrtDYjpqOAwh4QHTE0WXlv8q/UHLdFAms+H6mOJyzLKKmD3Q2v
         Xr+WJDWjA70I1JZdH1Rd4pcGF86rwm+GDUYI4wshX4b6ZKwr620H/laUcfIyeaaIHIUl
         do9xaevLIh0P2foTUvabDk0/YEk3lUpQgRqtZ8N3RNyqfZhDgkWgtfy79qmZncpbjHtS
         6QiBVXmzHprPf/E92gRBgUPqk4e6R0mqEuTLnZzreSvk8vEODjr2IYYktdKR+atlxZt7
         Fo26PGoxg34OPf9+CMMUDJpPjXqagbLsju4GkSUTjux03mvjKAUfLlrWNyMeWrqEgQNW
         e8ig==
X-Gm-Message-State: AOAM530IhvlzRFxDs4XZ62M1G0gq0Q8MZH0LoZiWW8ap3jCesiTnZekn
        6K1QkCpYxkm/TMfLENMdz1h4GdhuxmalP/IjRMQ=
X-Google-Smtp-Source: ABdhPJyYTfilVyN5kSw3HepK5mm/Uv7QBKAhzEBKBesxxnN5fz2sllIFeROr5eC323H2je0JEB52V8UwqsSHsz3IRjg=
X-Received: by 2002:a5d:540c:: with SMTP id g12mr26848464wrv.120.1597122098073;
 Mon, 10 Aug 2020 22:01:38 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqsgcub811.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqsgcub811.fsf@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 11 Aug 2020 01:01:27 -0400
Message-ID: <CAPig+cRtS3iMp3zLRKBOvEchrDPrCmozndbFpWtjiosk5nqGew@mail.gmail.com>
Subject: Re: What's cooking in git.git (Aug 2020, #02; Mon, 10)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 10, 2020 at 3:45 PM Junio C Hamano <gitster@pobox.com> wrote:
> * es/init-no-separate-git-dir-in-bare (2020-08-10) 1 commit
> - init: disallow --separate-git-dir with bare repository
>
> "git init --separate-git-dir" can be used in an existing repository
> with a working tree to move its .git/ directory away from the
> working tree. Even though this re-init feature makes no sense in
> an existing bare repository, it was not erroring out. Now it does.

This description is a bit misleading since it focuses only on existing
repositories, however, --separate-git-dir is intended for use with
both new and existing repositories. So, perhaps the description could
be rewritten something like this:

    The purpose of "git init --separate-git-dir" is to initialize a
    new project with the repository separate from the working tree,
    or, in the case of an existing project, to move the repository
    (the .git/ directory) out of the working tree. It does not make
    sense to use --separate-git-dir with a bare repository for which
    there is no working tree, so disallow its use with bare
    repositories.
