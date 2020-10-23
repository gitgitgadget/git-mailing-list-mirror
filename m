Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336E3C4363A
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 17:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C954A21527
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 17:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfcTiykv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753668AbgJWRkk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 13:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S462038AbgJWRkk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 13:40:40 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29001C0613CE
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 10:40:40 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id j6so585919oot.3
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 10:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zYuKDdC6fJf36mARsm7uTUkOLMPL8ye9TGtboHZ4vP0=;
        b=GfcTiykvNwy3kGnZgE3+E2QqvJL5lgKcffz9AggKYod1085hG02uc4JMu+IrKcN5Ox
         nTTg9mtpNofKga9b8E56V0bL3YvGjX+sAALppEb416DWCGXuG1OemQqSwu5Ud6Uv8yCl
         EN3+aSbwNunZe195c2gHil/Hz1qRM+/fXtfBD8pRkUG5beqQrlTfxqkpjmfAwL9IhcUu
         jwtWIQ3yOMkOpPi81MRDiBiU9LEaMPcJulSeDH2klEUpCf0Ao0JXxsrR8OgQ0rUArnTj
         N+PBaSkWk7NKGqMlb4JbwWMc/Cc9TNC1xVaB3SCY5nxIkZ/946A+4A6TZ3OAbpDyG4MZ
         rJPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zYuKDdC6fJf36mARsm7uTUkOLMPL8ye9TGtboHZ4vP0=;
        b=tV8eFkQb618lo4mWcRaZla/GmSq4hQL3xZDpGwvlJXedoTDtNbXnDabXjZD8+loK/U
         Qa88p3h8fEZDELXoCcbxRq36Kisy9H7FVxw+uTduPtr301uLJH7oI7F6KvGJrjANGHi/
         AmBMl7mUgiGezP9Ohn70kIbFR6m8KZAkjcdRreLPlF0Mfuhukb89phKkK0WmBfVx91rd
         GmHw7bWizQyEyoMw4dnr4MxkR7dU5JN9R1OdR9P05rNn1Ab/fUMVGyUqsUkR2wcq3Xhm
         i+J1X8yn1PnF2u5kntR30YLtNeMQM3C0DjquOHrU0xj29Wb54mDbEzAEtZ7Sl1j98lAy
         CPhg==
X-Gm-Message-State: AOAM533Znk88BLWH70JEGTB6I/FVBXf6+8NeseRdj0E5p5qpXERYe+Zm
        atzdN55RGxbB1BkgTiJstCxmwRas9ZOeA12hK10TA2ericN0lw==
X-Google-Smtp-Source: ABdhPJy06gDfT4k9eus/yzgwxY32NEjRgYVrPs73aWPVhTJQOI97tzNDK0ahokAfyPdhJCfsEh/gVBTiL2Z+KVTl7Po=
X-Received: by 2002:a4a:b443:: with SMTP id h3mr2607779ooo.45.1603474839469;
 Fri, 23 Oct 2020 10:40:39 -0700 (PDT)
MIME-Version: 1.0
References: <pull.769.git.1603468885.gitgitgadget@gmail.com> <9394d526f1425fcf6b8865b53b737ba81c11dd80.1603468885.git.gitgitgadget@gmail.com>
In-Reply-To: <9394d526f1425fcf6b8865b53b737ba81c11dd80.1603468885.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 23 Oct 2020 10:40:28 -0700
Message-ID: <CABPp-BEhjecB7_juP3cSuF7MUHKbPXqAxKgKstPZw2ezHXputw@mail.gmail.com>
Subject: Re: [PATCH 2/9] merge tests: expect improved directory/file conflict
 handling in ort
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 23, 2020 at 9:01 AM Elijah Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Elijah Newren <newren@gmail.com>
>
> merge-recursive.c is built on the idea of running unpack_trees() and
> then "doing minor touch-ups" to get the result.  Unfortunately,
> unpack_trees() was run in an update-as-it-goes mode, leading
> merge-recursive.c to follow suit and end up with an immediate evaluation
> and fix-it-up-as-you-go design.  Some things like directory/file
> conflicts are not well representable in the index data structure, and
> required special extra code to handle.  But then when it was discovered
> that rename/delete conflicts could also be involved in directory/file
> conflicts, the special directory/file conflict handling code had to be
> copied to the rename/delete codepath.  ...and then it had to be copied
> for modify/delete, and for rename/rename(1to2) conflicts, ...and yet it
> still missed some.  Further, when it was discovered that there were also
> file/submodule conflicts and submodule/directory conflicts, we needed to
> copy the special submodule handling code to all the special cases
> throughout the codebase.
>
> And then it was discovered that our handling of directory/file conflicts
> was suboptimal because it would create untracked files to store the
> contents of the conflicting file, which would not be cleaned up if
> someone were to run a 'git merge --abort' or 'git rebase --abort'.  It
> was also difficult or scary to try to add or remove the index entries
> corresponding to these files given the directory/file conflict in the
> index.  But changing merge-recursive.c to handle these correctly was a
> royal pain because there were so many sites in the code with similar but
> not identical code for handling directory/file/submodule conflicts that
> would all need to be updated.
>
> I have worked hard to push all directory/file/submodule conflict
> handling in merge-ort through a single codepath, and avoid creating
> untracked files for storing tracked content (it does record things at
> alternate paths, but makes sure they have higher-order stages in the
> index).
>
> Since updating merge-recursive is too much work and we don't want to
> destabilize it, instead update the testsuite to have different
> expectations for relevant directory/file/submodule conflict tests.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>

Perhaps I should also mention that these changes to directory/file
conflict handling were discussed previously in the thread at
https://lore.kernel.org/git/xmqqbmabcuhf.fsf@gitster-ct.c.googlers.com/.
I just never got around to a complete implementation within
merge-recursive.c, but did implement it in merge-ort.c

I still haven't gotten around to fixing up git-mv and git-rm as
suggested by Junio in that thread; but at least I've finally gotten
the merge machinery side written...
