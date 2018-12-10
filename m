Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B317D20A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 18:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbeLJShg (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 13:37:36 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:52738 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727593AbeLJShf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 13:37:35 -0500
Received: by mail-it1-f193.google.com with SMTP id g76so18890305itg.2
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 10:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uAd0+fDarpeE6VC3lPmKulCr0jSN6FAzOyMPcE5HgL4=;
        b=F3hNqresQN5FwjE+AJy7LUUV7Y+NG1B4+W+T18q0ZcIv82hKdvf9JT4NUD5vnxx0IT
         w7ft9uMcBbNSclHKDoqMdVIudjX/sCYMq7yKrPRfHxg/yqMxNzl7nAyvkh7rUaZhcM1Y
         gTEpiaQBMbOgJ78aZOqvxg0sXHSdiBClxegeXIDjgSAoffE88t4nlTJMvTZ5aG52f5Wi
         g9RYqj9gpx7aid23uUYU0ZC4Px6WVif3f6hp8g7z+iZLbcP3sBm6rEktT3Hrw7ghwffw
         ePHb+FAYBq5P6PRLtgx1tAk57pDYZ3UKj7xKBVbn2x+tLIIR/Ko9PiJ0X61lodK0IeVK
         jBXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uAd0+fDarpeE6VC3lPmKulCr0jSN6FAzOyMPcE5HgL4=;
        b=rWfF3Q5kGERhRgMAYxOXM/AC1FEiH0xFRxQE7bvgnCWI+UXqhVIXpdAqKDJQNhEvdK
         S7V/eblhL17Uz6wVHgHESZ1dZUua7Us1Uxf485hDplHRhHViUwvojNKdHDYGiWGDAV5+
         Wnq4CBhoB85f3pznl92ooljL5tPfh1GAY+ougHU1kS32c9KnrZ6EurgiLPJaVDQGhj04
         mmPIrm+vkUa6Bq/XqAG+UuoJb+I0UHsIWZ55JCy1KqrGGLN3MvTMFSVsdvza0aWMNHGC
         peMV85Bp4dMWfsU8S+mSJkF3mGPlCAYhXW5ucZvYZCTGFWIALY27hdS8CVwqhF0IDBEn
         VX/Q==
X-Gm-Message-State: AA+aEWZdUt6m0Zai8Jv7FP4weIDuzwVEOWKITBpQkxxSjMjFyllApO3N
        7nTHGWQBtZhKiuphhoZbUwd21EHXM52wh5ZM6jQ=
X-Google-Smtp-Source: AFSGD/WVGCtE4JlRczJomBJsGs2jJ2v8OkAxiTKYqWvlzg2ACQEhHXm/gwY0/G4umdWgvi+jkd+UE50N5QjYkhZWJBk=
X-Received: by 2002:a24:4606:: with SMTP id j6mr10413094itb.10.1544467054329;
 Mon, 10 Dec 2018 10:37:34 -0800 (PST)
MIME-Version: 1.0
References: <20181209200449.16342-1-t.gummerer@gmail.com> <CABPp-BFaWtDiBPuGQVU_+VGQtDkemDKnvjHhz+h1sbUGssffmQ@mail.gmail.com>
In-Reply-To: <CABPp-BFaWtDiBPuGQVU_+VGQtDkemDKnvjHhz+h1sbUGssffmQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 10 Dec 2018 19:37:08 +0100
Message-ID: <CACsJy8B63jwP4115B8vdTU+tmij8gA7jw-D5iS2Litph9jE1nQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] introduce no-overlay and cached mode in git checkout
To:     Elijah Newren <newren@gmail.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 10, 2018 at 6:18 PM Elijah Newren <newren@gmail.com> wrote:
> > The final step in the series is to actually make use of this in 'git
> > stash', which simplifies the code there a bit.  I am however happy to
> > hold off on this step until the stash-in-C series is merged, so we
> > don't delay that further.
> >
> > In addition to the no-overlay mode, we also add a --cached mode, which
> > works only on the index, thus similar to 'git reset <tree-ish> -- <pathspec>'.
>
> If you're adding a --cached mode to make it only work on the index,
> should there be a similar mode to allow it to only work on the working
> tree?  (I'm not as concerned with that here, but I really think the
> new restore-files command by default should only operate on the
> working tree, and then have options to affect the index either in
> addition or instead of the working tree.)

In the context of restore-files, --target=<worktree|index|both> is a
very good candidate because "restore-files --from=foo --target=index"
is almost like saying "restore files in the index from "foo"". For
checkout, probably not as good. But then we can have different option
names for the two commands. So if "git checkout" is going to never
have "update worktree only" mode, then --cached is a still good way to
go.
-- 
Duy
