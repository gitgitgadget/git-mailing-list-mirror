Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D96EA201A9
	for <e@80x24.org>; Mon, 20 Feb 2017 12:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752581AbdBTM0p (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Feb 2017 07:26:45 -0500
Received: from mail-oi0-f44.google.com ([209.85.218.44]:33081 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752297AbdBTM0o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2017 07:26:44 -0500
Received: by mail-oi0-f44.google.com with SMTP id 2so13002399oif.0
        for <git@vger.kernel.org>; Mon, 20 Feb 2017 04:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TbQhRn2jJIps3rW/U9dlmIxNPgCOdaxGixbXam0NzPA=;
        b=BajBYO5u13a+LhjGjNYhpoGv1JTxhGQ0d5mjXokCUaeZXkT04zLqfFb7aijiy7YQkQ
         GMNnmtajZ4lYFSwjKmFOPsSnK8aDd1h6tTzUN2BZn2+hMnKHYSiMFtJFuBdXdoXvTSso
         xQVt4Xe3/ndQuz0U++dA1Nza6sv1kE3zB38+4IMlm3DhKY0MmvxbljD2v+CXrtKhUdy1
         CE/RVLpe/XcLkKjGp8+PnZkGpFVuGZxSIkAjti4bdxuomla16KbmlHz57Xj729iLMWTe
         0WXxoi++MnSk6nQkIQsluvrXvchiOiTtrVRFNTn6WwREC3x9yvq3GReRanif3vDMqgJ0
         agYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TbQhRn2jJIps3rW/U9dlmIxNPgCOdaxGixbXam0NzPA=;
        b=ZdWoPaU6CZMCOXdulF73t7MnBx+oNv4ErFjFEdqOGXImIh8EuZGnXWwQKlOliqsUEd
         6XENvf10qd28IFVDAZfpp69pC4CUzMt+mSt96e4gWbCJXaQoNoYAEqLDrR9zXD7KHeMB
         VcI8XMdlD+q43M4/O3LJM1JrnV2CI14kltz4a1Vtj+RVHmqQ4kf8K8b68ntEToKZl0Vo
         scmmqmzg5vpvToRE9wH3c3djTfxJd4vocsIBR4FM1lJzR9J4Tv/qWFKTUM6WP4x7bpeh
         C9G4xrivrRutKdedAnbgffqNhGe+OxLJ3EuPsLVEL0m0ZNDfMEpvoWp1lsMjD1fI7+WN
         SFvg==
X-Gm-Message-State: AMke39kJAAlulsf/UxlJyolKZXFw17W5flFKyqh6rIXIjlz3kwLbFoVS4Qe+Kq+oQ0Y8hQIzS4LVJTFv30HK2A==
X-Received: by 10.202.207.134 with SMTP id f128mr1013298oig.55.1487593580523;
 Mon, 20 Feb 2017 04:26:20 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Mon, 20 Feb 2017 04:25:50 -0800 (PST)
In-Reply-To: <330bfd35-ec00-92a2-a221-c7be9f0199e5@alum.mit.edu>
References: <20170213152011.12050-1-pclouds@gmail.com> <20170216114818.6080-1-pclouds@gmail.com>
 <20170216114818.6080-5-pclouds@gmail.com> <330bfd35-ec00-92a2-a221-c7be9f0199e5@alum.mit.edu>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 20 Feb 2017 19:25:50 +0700
Message-ID: <CACsJy8AJuosFnamsJT8BWGcicFpZF=5gdifhazAigrdQ7R2vXA@mail.gmail.com>
Subject: Re: [PATCH v2 04/16] files-backend: replace *git_path*() with files_path()
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
        Stefan Beller <sbeller@google.com>,
        David Turner <novalis@novalis.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 20, 2017 at 6:23 PM, Michael Haggerty <mhagger@alum.mit.edu> wr=
ote:
> On 02/16/2017 12:48 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>> This centralizes all path rewriting of files-backend.c in one place so
>> we have easier time removing the path rewriting later. There could be
>> some hidden indirect git_path() though, I didn't audit the code to the
>> bottom.
>
> Almost all of the calls to `files_path()` [1] take one of the following
> forms:
>
> * `files_path(refs, &sb, "packed-refs")`
> * `files_path(refs, &sb, "%s", refname)`
> * `files_path(refs, &sb, "logs/%s", refname)`
>
> (though sometimes `refname` is not the name of a reference but rather
> the name of a directory containing references, like "refs/heads").
>
> This suggests to me that it would be more natural to have three
> functions, `files_packed_refs_path()`, `files_loose_ref_path()`, and
> `files_reflog_path()`, with no `fmt` arguments. Aside from making the
> callers a bit simpler and the implementation of each of the three
> functions simpler (they wouldn't have to deal with variable argument
> lists), at the cost of needing three similar functions.
>
> But I think the split would also be advantageous from a design point of
> view. The relative path locations of loose reference files, reflog
> files, and the packed-refs file is kind of a coincidence, and it would
> be advantageous to encode that policy in three functions rather than
> continuing to spread knowledge of those assumptions around.
>
> It would also make it easier to switch to a new system of encoding
> reference names, for example so that reference names that differ only in
> case can be stored on a case-insensitive filesystem, or to store reflogs
> using a naming scheme that is not susceptible to D/F conflicts so that
> we can retain reflogs for deleted references.

I agree. I didn't see it clearly at the beginning (and made several
mistakes in earlier iterations) but as you have seen files_path() the
separation is pretty clear there. I was going to do it when
introducing the "linked worktree" backend. But since you pointed it
out, I'll update it in this series too.

> Michael
>
> [1] The only exception I see is one call `files_path(refs, &sb,
> "logs")`, which is a prelude to iterating over the reflog files. This is
> actually an example of the code giving us a hint that the design is
> wrong: if you iterate only over the directories under `git_path(logs)`,
> you miss the reflogs for worktree references.

Oh yes, I had to fix the reflog iterator [1] exactly for that :)

[1] https://public-inbox.org/git/20170217141908.18012-14-pclouds@gmail.com/=
T/#u
--=20
Duy
