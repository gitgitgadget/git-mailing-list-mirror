Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20951C48BE5
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 20:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 020EF613B1
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 20:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbhFOUSo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 16:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbhFOUSo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 16:18:44 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D853C061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 13:16:39 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 66-20020a9d02c80000b02903615edf7c1aso109566otl.13
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 13:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jul23+X+1SMZHMt26YO8A/as/51UJoBM+L6nRwbCFBU=;
        b=E36wgZ1JKsi3tpbn3m61ZIzdCbst4TixpABnIoD1VfV+dNehelYzojK41jUAZUVXQG
         G/InODu2IUW+R41x3q5E/z2jaNYJ6V8gZTViHo9EdGCbozracaPXetAna45Ksf670Yg9
         Y0ePM9inC6VXpgtOGmuCb1okx9oJJfltBSwQCzreFhs6UeDyQ94ke1IGCvGuJJuHS9ru
         UF8vSQrPhDcLUNrR0imKFS95mCYoRt6nnHZHRwvX4IRGS1T06wzMYcMz7Rp9/NT5gsbI
         2L6afg2RJUE0qyMy3XAwoBOpfdPNhoaf4CWb2FoXmmanXM4lIEy4rmBX2x+P7fOAV/Zr
         nbEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jul23+X+1SMZHMt26YO8A/as/51UJoBM+L6nRwbCFBU=;
        b=ThXKZeB6i+KPILKoAf9HlhIJ6EuMpLlj1EggLWLTLDeDtVxBHs4oV2We6E4QPWSxTt
         fAy6DaU3fv6AJuYrrCJnWwVhAdqHLw+vrYKzVVnFjszYJ+HCMSIPM1Cg7pmhxqsX2huh
         kQ8nHriko04FaTbUyULLa5xxoVSa8TK0X4zxmuqcrLYMK5hRCIGNw8L0B9DM120iCqOP
         rLl2GakKGX4XiC8QAXKKs5lmbE6EwqZFDkYZlD1tjb+seGb+njLIep9FA+ebeimP8tgh
         Mfgr91bVpQ2yXRXgTF7Hqc4Pv5jmwn2Phl4k7OBfvRCBWhJtkyzV2aIBqZSNVZdO+ECN
         Dmeg==
X-Gm-Message-State: AOAM532OGYAPbkBflCdeTMa9IQ6wfxhokRjXRmASV6bLNZmXCFUBlERM
        3TrTuUYGBO+BcqhJ1lytRGhpkVWCyafA6GTQ7ZM=
X-Google-Smtp-Source: ABdhPJzufytMLB/48Mx2aOWTcIWWk4i/uGqwAVMGjqBEMMNUx7ujYA0BeO6lRJfM0UzgYCRmigO473DEA3NQrqRSJXE=
X-Received: by 2002:a9d:1a8:: with SMTP id e37mr796430ote.316.1623788198609;
 Tue, 15 Jun 2021 13:16:38 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqmtrrv8sd.fsf@gitster.g>
In-Reply-To: <xmqqmtrrv8sd.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 15 Jun 2021 13:16:27 -0700
Message-ID: <CABPp-BEP2ct7ikBJyvFuzkq+HZ1q-OMW3sKMphbkTZ82F7+dzg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jun 2021, #05; Tue, 15)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 15, 2021 at 1:24 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> * ds/status-with-sparse-index (2021-05-22) 14 commits
>  - fsmonitor: integrate with sparse index
>  - wt-status: expand added sparse directory entries
>  - status: use sparse-index throughout
>  - status: skip sparse-checkout percentage with sparse-index
>  - dir.c: accept a directory as part of cone-mode patterns
>  - unpack-trees: be careful around sparse directory entries
>  - unpack-trees: compare sparse directories correctly
>  - unpack-trees: preserve cache_bottom
>  - t1092: add tests for status/add and sparse files
>  - t1092: expand repository data shape
>  - sparse-index: include EXTENDED flag when expanding
>  - sparse-index: skip indexes with unmerged entries
>  - Merge branch 'mt/add-rm-in-sparse-checkout' into ds/status-with-sparse-index
>  - Merge branch 'ds/sparse-index-protections' into ds/status-with-sparse-index
>
>  "git status" codepath learned to work with sparsely populated index
>  without hydrating it fully.
>
>  Waiting for reviews.

I reviewed each of the rounds except v4 (v5 is the latest), and
generally like the series but I highlighted a few issues in v5.
Stolee reported he's planning to send a re-roll (see e.g.
https://lore.kernel.org/git/2784d29b-b22a-2bf6-2450-7b4a0a72df54@gmail.com/),
so I think this can be updated to "expecting a reroll"?
