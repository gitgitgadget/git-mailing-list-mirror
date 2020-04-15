Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C12C2BA19
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 22:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA39B206E9
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 22:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etUHU9s/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731803AbgDOWTQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 18:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731098AbgDOWTL (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 15 Apr 2020 18:19:11 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B098C061A0F
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 15:19:11 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id c17so4993663ilk.6
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 15:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sPqVrwh1DyB4xHqwqrlp34Iklo4e1n7XGCpE2Xh0iP4=;
        b=etUHU9s/5hP1UWRgC3dqaaRU9Z/EwN8NSh/jP+bLvplB3XtGUjxSgqKaxC+TiUdJse
         m9qk6WvdmdJvbayF08PbT/JzkYBNdef7quVIDTo0EF/CxHMRu2vQHwfDHkt8qUaGKQlA
         840DrghRncTk3pbT0gOup/1jr52k9Utw+qnCmUSYatHJmjrQ2ObMxNdNpYnh7LPMxaXE
         LstfIX7sv91PgIAmKgGAsByECa8Znaup0bMpaYs2O0f0c85Xxunw8jku2htyfZOQGRt8
         qFJCJPzDW8JC9yUT5/FYIsuprBAcVeLY4V+SRweRHL4MlVC43U0rBScP9WiaW1BtN4jM
         tW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sPqVrwh1DyB4xHqwqrlp34Iklo4e1n7XGCpE2Xh0iP4=;
        b=J4BpqwY+cNLc2pazIFe5vAMYYmyHjUYIN3pg5INBLcjmBU+jHsj1racHDnZ1jeqzRd
         dxEX4jGIvHI17DXfdqUkM2TOdHDkcM3DDPgOPGFs5p4iqXM0tfGepUvlyoyD7iN+NPyC
         gUCrxBGLLYb5yyWsVp4LrZAGjPl8kfaOCyWuOq5TxHDppUFCouETxgYzQ7Ibk+Xah5VD
         wcT6b5IxzeFMdW1Dv4nrfpvXeWLGaD0uFra4t0SoU5N+CjvZNtz4RVg9Ted2pELgZSEv
         Dth7qoblg8wThb1I9OvOdnZR9DOXaQGS53JwBiwRrBk0wRLSTUBCWE/ExeA6ykPzdYx7
         huXg==
X-Gm-Message-State: AGi0Pua5bz+AzHmivATeDjdCByUSVzJSWn2eqHqBXQUlcTW1FP0VhXym
        xrdmBYKyyOQLho8yu59YFGJNkLtWlX3cE6oxGWQ=
X-Google-Smtp-Source: APiQypInYBJKPSmKfoJSJYDXZ0DDDwZdqg5q0o1q/C6JI/xJkGHPgO5bfyK1fAz3JVpreg/Q6fVjsN0gsQsxKf6VHQc=
X-Received: by 2002:a92:bbd8:: with SMTP id x85mr7982533ilk.23.1586989150688;
 Wed, 15 Apr 2020 15:19:10 -0700 (PDT)
MIME-Version: 1.0
References: <pull.609.git.1586566981.gitgitgadget@gmail.com>
 <9cc31c289aa785f026eec84452ed68e80505d95e.1586566981.git.gitgitgadget@gmail.com>
 <xmqqeesthfbf.fsf@gitster.c.googlers.com> <44ce43e2-6cf0-0e48-18eb-f02543d81bf4@gmail.com>
 <xmqqmu7d9b6j.fsf@gitster.c.googlers.com> <f57c7908-55ae-deae-e9ea-1909549e628c@gmail.com>
 <99e0ae2c-6b65-24e4-3d2b-1dff619a5daa@gmail.com>
In-Reply-To: <99e0ae2c-6b65-24e4-3d2b-1dff619a5daa@gmail.com>
From:   =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Date:   Thu, 16 Apr 2020 00:18:33 +0200
Message-ID: <CANQwDwdcM-hc+Nyc0nBnp79W0BuH2PfdgM6WLqET3sPn1GYc-A@mail.gmail.com>
Subject: Re: [PATCH 1/3] revision: complicated pathspecs disable filters
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Garima Singh <garimasigit@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 15 Apr 2020 at 20:37, Derrick Stolee <stolee@gmail.com> wrote:
[...]
> -->8--
> From 89beb9598daabb19e3c896bbceeb0fc1b9ccc6ca Mon Sep 17 00:00:00 2001
> From: Derrick Stolee <dstolee@microsoft.com>
> Date: Wed, 15 Apr 2020 18:04:25 +0000
> Subject: [PATCH] bloom: compute all Bloom hashes from lowercase
>
> The changed-path Bloom filters currently hash path strings using
> the exact string for the path. This makes it difficult* to use the
> filters when restricting to case-insensitive pathspecs.
>
> * I say "difficult" because it is possible to generate all 2^n
>   options for the case of a path and test them all, but this is
>   a bad idea and should not be done. "Impossible" is an appropriate
>   alternative.
>
> THIS IS A BREAKING CHANGE. Commit-graph files with changed-path
> Bloom filters computed by a previous commit will not be compatible
> with the filters computed in this commit, nor will we get correct
> results when testing across these incompatible versions. Normally,
> this would be a completely unacceptable change, but the filters
> have not been released and hence are still possible to update
> before release.
>
> TODO: If we decide to move in this direction, then the following
> steps should be done (and some of them should be done anyway):
>
> * We need to document the Bloom filter format to specify exactly
>   how we compute the filter data. The details should be careful
>   enough that someone can reproduce the exact file format without
>   looking at the C code.
>
> * That document would include the tolower() transformation that is
>   being done here.

Why not modify the BDAT chunk to include version of
case folding transformation or other collation algorithm
(other transformation).that is done prior to computing
the Bloom filter key? Though that might be unnecessary
flexibility...

For example the value of 0x00 in such field of BDAT
chunk header would mean no transformation, while
the value of 0x01 would mean per-character tolower()
or Unicode equivalent of it.

Best,
--=20
Jakub Nar=C4=99bski
