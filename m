Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321A2C4332F
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 19:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbiKVTBv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 14:01:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234127AbiKVTBt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 14:01:49 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F198E8CB8E
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 11:01:47 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-36810cfa61fso146112447b3.6
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 11:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eInI+OH6Q9h8DNWFU+u2LhSFCHqVvb4BqO3BpixqeP8=;
        b=c9wveoJ5aF/cuuOKkmEdsPTOKSE8PQA5ufFKe2wNmt9w45rnkuF1077FBshwJ1PKrA
         rnD1XKBg+yZDgcgnPtR0DcDJfl4bdubYJA38HNJ3WL2SkPUSO5+dHQE6Y/D4XE85CcWT
         ZOWYDIKgehscrUAIX2RhQhCC0O2Ewf/kWxCVVaA3yeNqlhlewYUWRwqMhyutCGGQ99ej
         mCQH9Wxrt6WFWaJoBrX34KDExYXULf0FTnLjWDQOLiWbiJ76imNLlOQRAschuD61ZyZb
         U3eyngqUnB1wAmatMn8rX3scqtfYHmd0l+4p8AWS6qFirtEvoe9eX2nXGmSrIrHXAayV
         bNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eInI+OH6Q9h8DNWFU+u2LhSFCHqVvb4BqO3BpixqeP8=;
        b=hYP9PJCkJlI/JloEkubPyNzYyNX9aBUnchVaS58szMmUpxnN37DBvVlYqk+nv0NOhT
         vXQU6v2uMMgpbaZmhc+LVlvZljiCNmdAWN9bjX9aJu4PL2411d5UOxkX+Yd2VYVbHILt
         vgoltaTouDqxjH2DKrkRms6uLKUIWvTMpeUBnMkFZcQIKFLSIZAx6vrgdC5QdoYpGcwC
         LSo30bqg/KumLb7rOhhODgZ8QKLdPWMpmx/a1g6lfAJAhY2EAJE2/mUugLzCvQAyUpL0
         w8oEGaWfLf+eJDdK5pjX7/cNvU9SBqBBJUBMYpsVgQENzUlpwTV/d624/hWv/A6tLBay
         hglA==
X-Gm-Message-State: ANoB5pmVcGK6zjcT+VAt1zfdOnTCOIlgIhE0WJPUGFB+om4nbYaEUIdH
        KVSJnwaRrM/8bYlrwIL/bF3fwuu2fee/JQ==
X-Google-Smtp-Source: AA0mqf7LmOk01W6K7mlDW+NME1NVd/VJxyJANilj1rs9NZ0DluASs/h+oE3Ofs599Ncnn1hndK4alU8E7JZ6iQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a81:f8a:0:b0:345:4844:163a with SMTP id
 132-20020a810f8a000000b003454844163amr5459888ywp.319.1669143707245; Tue, 22
 Nov 2022 11:01:47 -0800 (PST)
Date:   Tue, 22 Nov 2022 11:01:30 -0800
In-Reply-To: <xmqqfseargo4.fsf@gitster.g>
Mime-Version: 1.0
References: <xmqqfseargo4.fsf@gitster.g>
Message-ID: <kl6lk03merud.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: gc/resolve-alternate-symlinks (Re: What's cooking in git.git (Nov
 2022, #05; Tue, 22))
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> * gc/resolve-alternate-symlinks (2022-11-22) 1 commit
>  - object-file: use real paths when adding alternates
>
>  Resolve symbolic links when processing the locations of alternate
>  object stores, since failing to do so can lead to confusing and buggy
>  behavior.
>
>  Will merge to 'next'.
>  source: <pull.1382.v2.git.git.1669074557348.gitgitgadget@gmail.com>

I plan to do another reroll based off =C3=86var's feedback (thanks!), let's
hold off on merging until then?

Separately, I'd also prefer to hear from Peff regarding my reading of
37a95862c6 (alternates: re-allow relative paths from environment,
2016-11-07) and whether we want to continue 'supporting' broken paths in
the environment. I doubt it, but since he initially suggested it in his
fixup patch [1], his opinon would be reassuring :)

[1] https://lore.kernel.org/git/Y3aBzbzub7flQyca@coredump.intra.peff.net/
