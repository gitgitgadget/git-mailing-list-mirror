Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC888C432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 16:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CB4960FC0
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 16:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242595AbhHZQry (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 12:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232835AbhHZQrx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 12:47:53 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B717C061757
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 09:47:06 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id m19so2488189vsj.10
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 09:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ArZmPaYZ2j6chi2VGjREYX4AYxiEnYRg2VVulqUBoWQ=;
        b=tGaisUAnpLjIVeeidPJ9kFE+71L0mimmbwys84QuJeT8rFpe3KPoxUBeatAo78tSE/
         +V8bszCe56tUJ9lwFmbducfqs++8fMQsEMRNwvyUEA4s3BVAY1WfljVa46hUqSQn/VM6
         t4A0RdN6S/xx8rqDTf3vnFtUswyfJVy0vtT9QpDNeMbySmU+LowbtC9JQGLzlwAvdRgS
         gx47W0NSw5P1scGv1SREGR6jtBOfrrEVnuPLnviw2+NxPG52jGL2CNiwRXc4zerp1TMP
         rMMcm/zhEjdmfgeOQfwIXd16YEimgUKj5w+5yKpDF9kj/JOfQtiEDYzeM/dPxgvLBuZy
         xzww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ArZmPaYZ2j6chi2VGjREYX4AYxiEnYRg2VVulqUBoWQ=;
        b=eC4MQ1r7dcPQfkWNRvxStISGZRJE7PYsXcdrNP4K6Bm6yML+GiMbJRagtnaL+w01HF
         2Xq0qBjp0VNsyBnadw88v1c1s3sbgsx2eO7aoNxDMcTdFbMfnTtU9WPoDcPT5l76/rLt
         EdAvkxnVg6RFkfZjeCGef6ukXqn71WBKbbhxkVIg/NrgkBDackto5wVJ0BSbERvxos7m
         A/GMmaumRRuuLboJYE/xR6chGZYEhu61dBA9NIpDMcjQBGMM8xQvUcM7J/fLYO/cZ4fb
         yt/Qr1DZUDlvMD76go7iFw07mDA/aoYU9U+G0VaLNwZAfxW6CdGcfcUNS6zbJS0E+7Zc
         MaNQ==
X-Gm-Message-State: AOAM530t5obW1Lv+UV0L2iElzHBDijbj5fTJEfpkbk2qzq0W4nZBp95d
        rzwEUXiCYJ8CniGqm1x/7guuKmK3CHzh+QTbsKKjXzdV0isgQQ==
X-Google-Smtp-Source: ABdhPJy2JBSn/bkAGXzS6Njywh3hCwOxC0rJbvP1pT7zCEHM2M7XbyJzDj83IKoqrmJg6jnXk+N1ZPttewN/uf43yMQ=
X-Received: by 2002:a67:f70d:: with SMTP id m13mr3395050vso.32.1629996425120;
 Thu, 26 Aug 2021 09:47:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1629933380.git.jonathantanmy@google.com> <9187eab52552630863285ef5743a107ccc555495.1629933380.git.jonathantanmy@google.com>
In-Reply-To: <9187eab52552630863285ef5743a107ccc555495.1629933380.git.jonathantanmy@google.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 26 Aug 2021 18:39:41 +0200
Message-ID: <CAFQ2z_PKKZJY1kC1QJo8Zwq_yNh5QNGc3S5bq1jBfSfK3vQwRQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] refs: make _advance() check struct repo, not flag
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 26, 2021 at 1:23 AM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> Currently, ref iterators access the object store each time they advance
> if and only if the boolean flag DO_FOR_EACH_INCLUDE_BROKEN is unset.
> (The iterators access the object store because, if
> DO_FOR_EACH_INCLUDE_BROKEN is unset, they need to attempt to resolve
> each ref to determine that it is not broken.)
>
> Also, the object store accessed is always that of the_repository, making
> it impossible to iterate over a submodule's refs without
> DO_FOR_EACH_INCLUDE_BROKEN (unless add_submodule_odb() is used).
>
> As a first step in resolving both these problems, replace the
> DO_FOR_EACH_INCLUDE_BROKEN flag with a struct repository pointer. This
> commit is a mechanical conversion - whenever DO_FOR_EACH_INCLUDE_BROKEN
> is set, a NULL repository (representing access to no object store) is
> used instead, and whenever DO_FOR_EACH_INCLUDE_BROKEN is unset, a
> non-NULL repository (representing access to that repository's object
> store) is used instead. Right now, the locations in which
> non-the_repository support needs to be added are marked with BUG()
> statements - in a future patch, these will be replaced. (NEEDSWORK: in
> this RFC patch set, this has not been done)

from a design perspective, it would be nice if the ref backend
wouldn't need to know about the object store. Can't this be hidden in
the layer in refs.c that calls into the backends?

If they have to know about the object store, have you considered
passing the repository pointer
in xxx_ref_store_create() ? Then there is no possibliity to mismatch
the repository pointers and with the ref store.

> - Making all ref stores not access the object store during their
>   _advance() callbacks, and making ref_iterator_advance() be responsible
>   for checking the object store - thus, simplifying the code in that the
>   logic of checking for the flag (current) or the pointer (after the
>   equivalent of this commit) is only in one place instead of in every
>   ref store's callback. However, the ref stores already make use of this
>   flag for another reason - for determining if refs are resolvable when
>   writing (search for "REF_STORE_ODB"). Thus, I decided to retain each

I looked, but I couldn't figure out how this flag is used.
-- 
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Han-Wen Nienhuys
Google Munich
hanwen@google.com
