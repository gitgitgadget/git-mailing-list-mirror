Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91721C4338F
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 11:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54133611B0
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 11:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245382AbhHFLRA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 07:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235696AbhHFLQ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 07:16:59 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E6EC061798
        for <git@vger.kernel.org>; Fri,  6 Aug 2021 04:16:44 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id s22-20020a17090a1c16b0290177caeba067so22294503pjs.0
        for <git@vger.kernel.org>; Fri, 06 Aug 2021 04:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=z/EgcsDVBi9YIV0NAfwjLsU/2pRkdrNRQ5NtQl+mttw=;
        b=AaK48eY20QB89BaG7KzqAQscDGfFbxyVfJ42fxV2UNtMhSzwDKUbziE6uWNq8AQrqP
         sCO7hjsPaxymXipoxKe83jXReDA3fEQBgMsAQsSbDXE8K7sR0b5rD77mGQMvfo7ejFu7
         7B2csqpy+pv8lP3qB/wxt6tLiPJNBiF9YM7yN3HyQUrR4N5qHou1qC7E02Ga9vdIthHE
         UnTYuUdoku2eHh4pahdPPopborfsVgcCMnbC1MELYMWrYNvq09qxHpfHQ3Lepbqh7Nl6
         dLelnC75BMBau4IuAqTzsyyDD3QCOokWSWK65MCYeZH4n9MwhmBpzBpOse7/UEozSGeD
         NgpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=z/EgcsDVBi9YIV0NAfwjLsU/2pRkdrNRQ5NtQl+mttw=;
        b=uT+UAFmosJE8nj99jWW5Y1INGxO+yQq8PFVqzeifwxSdt5zQuX2WwxbDxlaaqK9F/g
         Q08pmPlJ7siblW8xFc0O23FF5A415OLYtU7JwTn1IUQecGjZ5TptA0YwY+g6nqG3YShy
         JrjinEeipKlaOQCe6hV2oPpyIH12OEz9p+8VpiaDQuQM9CzoPaYebVOcvjp+NGrbq0/t
         kgSlB45/QsZJNFSq/QT221uDs97c49jbTNv5Mh7lS1vikfGaCVyusS9gUuHmpi3qkNd5
         8rQ+UcsLUzjglnZfPSnVL814NHQPJUzDKkYZnhaADILIiyO29zMuTluwK86zMz8Ni/pA
         0Zgg==
X-Gm-Message-State: AOAM531dyZywol7vncLHhQj6b5mSpp+QbTiGGGtE2K6Sdw19L/c26maa
        6CopVu7mKR2ryNjWVvOpt7c=
X-Google-Smtp-Source: ABdhPJzCflgMu4TCmqcZZJM596qg3ebnv0OvXjIT2S/Hbv6qFGbjxcHAImr9+cYy/1n0D4dGHVbNjg==
X-Received: by 2002:a63:4c0e:: with SMTP id z14mr287712pga.427.1628248603332;
        Fri, 06 Aug 2021 04:16:43 -0700 (PDT)
Received: from atharva-on-air ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id o10sm8039853pjg.34.2021.08.06.04.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 04:16:43 -0700 (PDT)
References: <20210805071917.29500-1-raykar.ath@gmail.com>
 <20210805074054.29916-1-raykar.ath@gmail.com>
 <20210805074054.29916-6-raykar.ath@gmail.com> <xmqqeeb7k4kl.fsf@gitster.g>
User-agent: mu4e 1.4.15; emacs 27.2
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     avarab@gmail.com, christian.couder@gmail.com, congdanhqx@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, jrnieder@gmail.com,
        kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com, rafaeloliveira.cs@gmail.com,
        sunshine@sunshineco.com
Subject: Re: [GSoC] [PATCH v2 5/9] submodule--helper: remove constness of
 sm_path
In-reply-to: <xmqqeeb7k4kl.fsf@gitster.g>
Message-ID: <m2zgtuu8kq.fsf@gmail.com>
Date:   Fri, 06 Aug 2021 16:46:37 +0530
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Junio C Hamano <gitster@pobox.com> writes:

> Atharva Raykar <raykar.ath@gmail.com> writes:
>
>> This is needed so that it can be modified by normalize_path_copy() in
>> the next patch.
>
> This is a hard-to-judge change.  With this alone, we cannot tell if
> somebody has already looked at the member (and possibly saved the
> pointer elsewhere) before "the next patch" starts modifying the
> member in the struct.  It probably should be done in a single patch
> to demonstrate why it is needed and how existing users of the field
> are OK with this change.

Okay, I will move this to the next patch.
