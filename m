Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCA1C433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 01:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1371360F36
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 01:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbhINBce (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 21:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhINBcd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 21:32:33 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7B7C061574
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 18:31:17 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id w144so16670121oie.13
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 18:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KrluGCqAZGahtCdJ3Ib1XO+a2q57NTNezcRYt2KnTFc=;
        b=l9GsXwtXFqrzQxpbyrj7urihiD92OhqC2vJ1jqi3UTWL7TJPSqrbOZyqK25DxFfmW8
         wpcUwv1WN6Ap5FQZ9YU7s9j1KM7nXYbexRlPcj22wfkNrcgw33udDzbyC5QLQvsKSxjt
         Mjehv9emq0k04evB72fCaGzkmooIExMq3vQOsbnvSwea/SxjM0sPBKeU1YtD8Xe4OKQb
         HasOu8GOLUTOXtKRcn4od3SbyUeEzx3wuO203KFfU+BxkurrwjmebzpDAS1trhEfQ1dr
         qBPsu7CeoU6PopGViCYDwd/uOi4RaRBfUcUF3HlLLnPMkTCrWJBd6YwVq7mtVeKFb+73
         OUUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KrluGCqAZGahtCdJ3Ib1XO+a2q57NTNezcRYt2KnTFc=;
        b=f6z/qK1umBRBENj/OwJg8QsAUq9WKH3bhMvIC2/s9FV4smpwEtJQ9EbOggk7DUnQpm
         78l80o6xF/v17qigVLmMTUmvUmYkEyocfQhn/QnJCFQ+1Ey4ahoECAfeCom3cnHyvycP
         ug8dp7QVwasYlyyQeCT/WtUU3YFWm8ZaDBfytqZCqIh6f7oea1+WCwLBPG/83YyswVrX
         yAzUrkcd8THZKmDEvQ3gn+tBWf8fnTSRc9C2/cHOvkk/+85f/lF/cQA4N6Tq8sszLfDM
         W8guAtKTbjWyhSmCL0ZH0x7SG+3CM+SO9fV//JrFy7rN9hD+WTfTnn0zUzyiVImLdGAO
         z77A==
X-Gm-Message-State: AOAM531DdDCpUmO9jNdAiixXsAB7jdo40Kxp2EwTjHmb1d4RlZxPrRw7
        bCd6pp8EHYUnB9gf9eExs9gkhR430UyxKCqwskU=
X-Google-Smtp-Source: ABdhPJy7yc3H38WIxV5lNyL6InSqmH9nkhq1dyUgdsUWzGKU2JOtksiI79AnVBFHWpw/Va383w6vo79ht0SAnesT/rY=
X-Received: by 2002:aca:bfc6:: with SMTP id p189mr9864905oif.167.1631583076367;
 Mon, 13 Sep 2021 18:31:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631123754.git.jonathantanmy@google.com> <cover.1631212893.git.jonathantanmy@google.com>
In-Reply-To: <cover.1631212893.git.jonathantanmy@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 13 Sep 2021 18:31:04 -0700
Message-ID: <CABPp-BFrDgh02gOmX9SPrF8nXkQ8uyBkvt-cKyLUGtrfsx4HKg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] More add_submodule_odb() cleanup in merge code
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 9, 2021 at 11:50 AM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> This is on jt/grep-wo-submodule-odb-as-alternate (unlike version 1)
> because that branch introduces another usage of repo_submodule_init(),
> and I need to update it.
>
> The main change from version 1 is that I have introduced a patch (patch
> 2) that teaches repo_submodule_init() to support submodules with
> unabsorbed gitdirs, which means that I no longer need the original patch
> 1 that updated t6437 to absorb all git dirs.
>
> Once again, all these patches work under
> GIT_TEST_MERGE_ALGORITHM=recursive and GIT_TEST_MERGE_ALGORITHM=ort (and
> when that envvar is unset, for good measure).
>
> I have also tested it with the "DO NOT SUBMIT" patch 3 from version 1.

While I don't yet know the details of repositories and submodules, I
know the merge-recursive and merge-ort side of things and those
changes all look reasonable to me.  So here's an Ack for that side of
patch 3.

Despite not being familiar with the repository and submodule storage
parts of the code, I took a look over the remainder of the 3 patches
to look for anything that might stand out and look amiss.  I didn't
spot anything; it all looks reasonable to me.
