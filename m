Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2677E1F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 17:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388539AbfAORwA (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 12:52:00 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40196 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388536AbfAORv7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 12:51:59 -0500
Received: by mail-wm1-f67.google.com with SMTP id f188so4141700wmf.5
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 09:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=bPOeZjWHAhC5rqSwcFwkxQS8dlAwDmY5J+AjzUz21Sc=;
        b=CIvvKxSPGxd1mvppcRyelZlLdCXCZkcPXU62F+IQJwyQ/CInhA5+OYQJfRYur4nL5r
         Tq17CPeFDID8AMjTKp3/QPi6WQtI2YVnRRdy527usOVzIO2iqWKOGGzM0YvmEnNtiAYF
         A4L7BddZPPUAsJWF6gmpSlTuH3M3zMs1YJQaxlP2wArag1k8foeqsc9VR/4VgRuizWM7
         IXk/UwrYE0VGOYdcKoMVjMo6VcVNzVZVDhBp7OpTixGLgiFEvEgkX1QA5Evw9bTSpQOg
         obeZNOnST6be/CAyZN4PWq5fvOgimf1JMvwxr2tugG7v8YY7Ug5tngqPvhuBnznGHl15
         5Cdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=bPOeZjWHAhC5rqSwcFwkxQS8dlAwDmY5J+AjzUz21Sc=;
        b=YWFkm3K9CLDqwS3P5F3Dw5Gg9jhfjTXwgBn2S8Gg6Cnkp4OGwsmornrU/7CpNdwSDs
         SCHcaWw42V54q7rj74/pw1ZQcniOl05tiGSE9InwQCtRPtB9dGUrFbgA7rFn53UgP89q
         N/vAi6g+eW40GW3y9fYeW5blUPVJvLpuu8UJyOKG0mEHUp99a1lEQkZZS2WM9fenoRfN
         BSoN9HDRnspOeJ7Ipb9WF1HW790b26BBYcRGpqfrb+ys+7y/MSb+IUHQXb09k7n160+Q
         K0fpOPwjTkThABUT05dWe6mSO0vQESoIIfgoB/p46EHLWsGavDN0/rZYQrUzRqEgwmXu
         IgEA==
X-Gm-Message-State: AJcUukeoqKMB0+0N4gIgxWaB3x9zOfvSAwfBPX0dAKxQ7E7nHh9LQP3g
        BWtEYVRQSJa02vt2Wbk31xU=
X-Google-Smtp-Source: ALg8bN6HgswI/zBmpmOce6qdDiWqMtIylJTAxjWfh2GrjyxlXdL4EPS5Fwr1MUiD+oJGH7jwMoq6vQ==
X-Received: by 2002:a1c:67c2:: with SMTP id b185mr4008776wmc.96.1547574717282;
        Tue, 15 Jan 2019 09:51:57 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id o82sm29875128wmo.29.2019.01.15.09.51.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 09:51:54 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/5] tree-walk object_id refactor
References: <CAN0heSqLUWpwRdeUvYj2KnDX-QxSOnWOdKWz77RjHKJ3AFUGEQ@mail.gmail.com>
        <20190115003946.932078-1-sandals@crustytoothpaste.net>
Date:   Tue, 15 Jan 2019 09:51:54 -0800
In-Reply-To: <20190115003946.932078-1-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Tue, 15 Jan 2019 00:39:40 +0000")
Message-ID: <xmqq8szlu7ut.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> There are a small number of places in our codebase where we cast a
> buffer of unsigned char to a struct object_id pointer. When we have
> GIT_MAX_RAWSZ set to 32 (because we have SHA-256), one of these places
> (the buffer for tree objects) can lead to us copying too much data when
> using SHA-1 as the hash, since there are only 20 bytes to read.

Thanks.  And thanks for a pleasant-to-follow discussion during the
review of the previous round.

> Changes from v1:
> * Use hashcpy instead of memcpy.
> * Adopt Peff's suggestion for improving patch 3.
>
> brian m. carlson (5):
>   tree-walk: copy object ID before use
>   match-trees: compute buffer offset correctly when splicing
>   match-trees: use hashcpy to splice trees
>   tree-walk: store object_id in a separate member
>   cache: make oidcpy always copy GIT_MAX_RAWSZ bytes
>
>  builtin/grep.c                     |  8 ++++----
>  builtin/merge-tree.c               | 20 ++++++++++----------
>  builtin/pack-objects.c             |  4 ++--
>  builtin/reflog.c                   |  4 ++--
>  cache-tree.c                       |  4 ++--
>  cache.h                            |  2 +-
>  contrib/coccinelle/object_id.cocci | 30 ------------------------------
>  delta-islands.c                    |  2 +-
>  fsck.c                             |  4 ++--
>  http-push.c                        |  4 ++--
>  list-objects.c                     |  6 +++---
>  match-trees.c                      | 27 ++++++++++++++++++++-------
>  notes.c                            |  4 ++--
>  packfile.c                         |  2 +-
>  revision.c                         |  4 ++--
>  tree-diff.c                        |  6 +++---
>  tree-walk.c                        | 21 ++++++++++++---------
>  tree-walk.h                        |  9 ++++++---
>  tree.c                             | 10 +++++-----
>  unpack-trees.c                     |  6 +++---
>  walker.c                           |  4 ++--
>  21 files changed, 85 insertions(+), 96 deletions(-)
