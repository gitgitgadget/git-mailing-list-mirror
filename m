Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F86C2D0E4
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 00:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 613522463D
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 00:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZOPOq8W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbgKRASR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 19:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbgKRASR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 19:18:17 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F2BC0613CF
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 16:18:15 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id p22so807596wmg.3
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 16:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DkXSlwu4BYtUF43wHdzxpvMQ/eJJa6lHG/sWNpib7o4=;
        b=VZOPOq8WGwwjoBZG6cFDJ1esdIosqXGiQcMuSjPL7MXpVGO96dMEgYuK+hYW84eax8
         qyQBVsGXRWkqk2ZEdLxAEsccvaTlBYtwdnLSFq+fKk2Mnc1E0G0vQ5JJXet0+EGCHgJ4
         5idupPKnx1mH7kUcvxfzo0fAyYzNPWw4tG+YdQhJLCQ/LJjOotuVIvjo7rGPxzJ0po7L
         0wbe3aJMUq0vscxOcG6pwFAVk/taEPE/VPVa1C5jUhnIVllrhimQz/dR3TPctJoJf6DQ
         Q2kdDnTyo/AKt9rRNMqWCJv7fe0rspUpKC04Ig03E414lwHOd+LfLZf8S+TXnhTNO2Ou
         NnpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DkXSlwu4BYtUF43wHdzxpvMQ/eJJa6lHG/sWNpib7o4=;
        b=LJoLs2YcMYCW8MEmvcDkmS/PoQhhC2uWmcsCi1iN96Lo6q8VY2NhzoI4tW2TsnMX/C
         wUB+Svk++uInQ8YM/CRREz4HIQCKr1LzyXKWJYjKpc+OlKdEJ+N9wWKQYjL/k7rNmntA
         +ZlSJgjH/Qsm4OwwAOcWLlFqEFnpWrlWCAzFEvkdgAfgb8+ieYuxuzmQgOMBCGK9A19u
         TdEPuwqhDfH9nTHb5ceuqH91Olg5NbPZ4AQ30ZXgHQ3EhSWe4vzX/2mR5dj610dTOho6
         1N/31ktAINWRYT0otocB/pxTCzkS3Ba3W2YPdqzJRy2IZKeVNqhQyE14676D+GiVdzbM
         6MVA==
X-Gm-Message-State: AOAM532v0nEzkMOlV88iA1vazQNZgYlrNkA8JfAY+Ib3eqFsU6rPbvc+
        vqeTc6OPLjxpL+gOO25Ydxun0z8wJclgU1+JQRETRgSfU4ZFSw==
X-Google-Smtp-Source: ABdhPJzCqGZLh9rH4lhLYd8pmOiHKk9LeTxEN29iXZJtuShK3dK2j2DQGSFkPJ8dwpHw9hsJ+uzFKLbQU1LbL9RBhTA=
X-Received: by 2002:a7b:c3d5:: with SMTP id t21mr1444220wmj.37.1605658694223;
 Tue, 17 Nov 2020 16:18:14 -0800 (PST)
MIME-Version: 1.0
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
 <87r1oraewl.fsf@x220.int.ebiederm.org> <CAMP44s2VJOd3N2zaj8YPv0iLOqTF7vWyZ=zPd9vd0+qO1DbEVA@mail.gmail.com>
 <20201117233313.GB642410@coredump.intra.peff.net>
In-Reply-To: <20201117233313.GB642410@coredump.intra.peff.net>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Tue, 17 Nov 2020 18:18:03 -0600
Message-ID: <CAMP44s1HhiDYfji9L2sj3QbCDmsb9dnrLCS6cQJPbmS1F3vKoQ@mail.gmail.com>
Subject: Re: [PATCH 00/28] Use main as default branch name
To:     Jeff King <peff@peff.net>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 17, 2020 at 5:33 PM Jeff King <peff@peff.net> wrote:
> On Tue, Nov 17, 2020 at 04:47:56PM -0600, Felipe Contreras wrote:

> > This should be easy to do if we make "origin" be a pseudo ref that
> > points to "origin/HEAD" (and we could introduce "origin/@").
>
> Didn't we already do this long ago? refs/remotes/%s/HEAD is special in
> the dwim_ref() lookup:
>
>   $ git rev-parse --symbolic-full-name origin
>   refs/remotes/origin/master

Hmmm. For some reason none of my remotes do have a HEAD.

If I do "git remote add", and then fetch, the HEAD doesn't seem to be present.

-- 
Felipe Contreras
