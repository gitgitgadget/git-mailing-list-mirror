Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B531C433B4
	for <git@archiver.kernel.org>; Fri, 14 May 2021 06:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA9BF61028
	for <git@archiver.kernel.org>; Fri, 14 May 2021 06:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbhENGik (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 02:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbhENGii (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 02:38:38 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D922DC061574
        for <git@vger.kernel.org>; Thu, 13 May 2021 23:37:25 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id z9so41663147lfu.8
        for <git@vger.kernel.org>; Thu, 13 May 2021 23:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=n4V7y3LwplNVJf3S2auf+oi/IGVuxk3qqJAkv8y9nAY=;
        b=tlRZWQz6sPoGpGtGc6fCk0Vn2IbkrozJ9iqian1nLyYy9NniUa8NT5q+3T7h/c1TTd
         nykUO0KN3t+gNU/SDifw08GUR5cKgM2YTB1WA5pLmnTlwKr/U4QgANT4tsf5rJfYdqQH
         lKMEZuh4x4txICcFCfOKt70QVEZY13ID/LdJS0Sq64czdpikIGjkuCfOD2BCW5I/8ye2
         O/RvUOe15Ka+yfvElNvEgV7gDAvyfue/bjvFp1ag8JQTApgGAOayBj7Cn2RhLF+rodcM
         JAMJkvdjkgMotSTRgp+DH+T6spNlq3Lwf7iGXBTQoRcszTOalv3zDvY+GthyiYkA/bdM
         3z3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=n4V7y3LwplNVJf3S2auf+oi/IGVuxk3qqJAkv8y9nAY=;
        b=JmQ4FAJ1hKBh4XY8ZWXDx19cgplcwNVufZii0S/m9QLme0bBgdzdPsmsQLEN1kJqJm
         SHuecCk2tHrxMA0eF5hzPqcmoEHavUwGzldZ7S/WctQW8gLyg7wytnMG+UehzNbuT1A5
         qI5zIUtjCbjJu2tuvFZeNo9PFacJkNtALVy4wjOUSkQzRD7m0W9hmbDoUym0Nxa0ZFEy
         uS8zR41l5BAE/MLN5gHOoGYJI9KuGaIrmHGzJwyirrhYHo2j3yv0IMJZYaIC5Py/FkZ0
         5Eh5jaIN/M9diAHikcmg+aQbDtvArRU0oxgTJ87pEtthxL304l/65Rouwtcw++a6XZbk
         f60w==
X-Gm-Message-State: AOAM530lCn2pEeT0hMUFeRxxXMQHPI+RCDcvAORhByHQ11ovC12uaW2x
        DbvW/o5sXkNNdN4R2wDCTjYzBahxzgo=
X-Google-Smtp-Source: ABdhPJxjBDYB516N6NyMe9FZbe7AMUvBRZthJI6QeGN/vqf0mHC7049UbqfGHd1DLTMPeVvxwAec1g==
X-Received: by 2002:ac2:5fe5:: with SMTP id s5mr29090293lfg.364.1620974244107;
        Thu, 13 May 2021 23:37:24 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id a20sm824006ljk.29.2021.05.13.23.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 23:37:23 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: Rebase options via git pull
References: <87r1iakbyn.fsf@osv.gnss.ru>
        <CAMMLpeQ8_isyDtP34p+_tEK3JAasfro7dJbVrTVPZ7C4q0kT6w@mail.gmail.com>
        <YJ3LJ++lsAuSkCUJ@danh.dev>
Date:   Fri, 14 May 2021 09:37:22 +0300
In-Reply-To: <YJ3LJ++lsAuSkCUJ@danh.dev> (=?utf-8?B?IsSQb8OgbiBUcuG6p24g?=
 =?utf-8?B?Q8O0bmc=?= Danh"'s message of
        "Fri, 14 May 2021 07:58:15 +0700")
Message-ID: <875yzlu8gt.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Đoàn Trần Công Danh <congdanhqx@gmail.com> writes:

> On 2021-05-13 18:49:03-0600, Alex Henrie <alexhenrie24@gmail.com> wrote:
>> On Thu, May 13, 2021 at 7:23 AM Sergey Organov <sorganov@gmail.com> wrote:
>> >
>> > Hello,
>> >
>> > Is there a way to specify additional options for "git rebase" when it's
>> > invoked via:
>> >
>> >   git pull --rebase
>> >
>> > ? What if rebase is used implicitly due to "pull.rebase" being set
>> > accordingly?
>> >
>> > In particular, I'd like to be able to:
>> >
>> >   git pull --rebase --no-fork-point
>> >
>> > but it doesn't work.
>> 
>> It would be cumbersome, but you could run `git config rebase.forkPoint
>> false` before pulling and `git config rebase.forkPoint true` after.
>
> Or, for this *specific* case:
>
> 	git -c rebase.forkpoint=false pull --rebase

That's nice, thanks! Doesn't solve entire issue, but definitely better
than nothing.

Probably add generic cmd.<cmd>.opts config support, so that I can say:

  git -c cmd.rebase.opts="--no-fork-point --empty=keep" pull --rebase

Thoughts?

Thanks,
-- Sergey Organov
