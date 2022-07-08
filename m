Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CB4C433EF
	for <git@archiver.kernel.org>; Fri,  8 Jul 2022 21:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239273AbiGHVia (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jul 2022 17:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiGHVi2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jul 2022 17:38:28 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FB7B24
        for <git@vger.kernel.org>; Fri,  8 Jul 2022 14:38:27 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id i15-20020a17090a2a0f00b001ef826b921dso1561081pjd.5
        for <git@vger.kernel.org>; Fri, 08 Jul 2022 14:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=S9b3hX0LCbF76j5InClxRxUGnssIcwDlDd0ew/L88/U=;
        b=rbvdkUHpTFIBK/BSSW//HtNsOH5YX6S94yyynaHZdLOpZMpzR27WVwAqTx1BOUOi6a
         EHcTefPkXQNZQEFSHobSVl+oCyZgwZinENDFlqfFcgubV8KmiOJdPEnefB8PGS8ykQ/Z
         iSlqoWUylK6IR8k6Uu6/+hMR529ceWHQfcMqQMYGwhK5ZjutHS5aPQn/xqcSm8jNr3NK
         a3EwGIMKwNvl3ktO2jchH3XYpOX9Vvd38trJyZDJpUuMhBm79uRc5wFZxelmy7cBY+An
         6mj/1YuwKvoqFXtJ84Y3/RS3Q5578tmesERGVhGH2hDFefEiSl1os5IFVHabFjo0POyA
         jiFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=S9b3hX0LCbF76j5InClxRxUGnssIcwDlDd0ew/L88/U=;
        b=IZEf3e7ApU9dicyNsjj68ZVVN6Zi6RniwRnZIITH5Dxqw6XAcmV7K8bM3laoea6FI5
         VOgvF0Zab0rnvIkJUxIKtKVMeOg/3OJybBfHlcWo1SZ4Dui7sIEiBTJABPCh2qQnOXGO
         XxDYckhkFxD/ivIzlMb3Qv9Btv29M459/TRSg8q1z5vwVjhRWGNO6oEYLa898utBzXHO
         GBwxFHsOygjWa+gfSVrvmJgW2LWp0cah10RgoDLyHjqjk2wDdn5SACKeyntZVx14Q8/l
         yW0SdMRy7y+xGQqncYgte9zudJnfoV1zX4DtQtr647nEp/GqTnGQ5kHcmMtPo2ak0OKu
         dXRg==
X-Gm-Message-State: AJIora8l7wDQ9BTg7tAuD7tevjFkojM0cl9pVzPk/+I7VKOEvuGyy3zm
        nDozcE4mmsVKrksivGdqxC4T3Rg4xUuEFA==
X-Google-Smtp-Source: AGRyM1tw0kYOoQ1vfquv9T0b1A6jS9jxVm6NzMBqGgmAXouuGUQGivIqLyjHPusXp+WbieFb+E5AeINqsbYf5w==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:114c:b0:528:2c7a:6302 with SMTP
 id b12-20020a056a00114c00b005282c7a6302mr5685269pfm.37.1657316306815; Fri, 08
 Jul 2022 14:38:26 -0700 (PDT)
Date:   Fri, 08 Jul 2022 14:38:19 -0700
In-Reply-To: <xmqq1quvwhsd.fsf@gitster.g>
Message-Id: <kl6ly1x35lpw.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1261.v6.git.git.1656612839.gitgitgadget@gmail.com>
 <pull.1261.v7.git.git.1657234914.gitgitgadget@gmail.com> <5c58db3bb2189f3b4193a682aa3b43f3bfa95796.1657234914.git.gitgitgadget@gmail.com>
 <xmqq4jzsxze4.fsf@gitster.g> <kl6l5yk77d4b.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqq1quvwhsd.fsf@gitster.g>
Subject: Re: [PATCH v7 1/5] Documentation/git-config.txt: add SCOPES section
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Glen Choo <chooglen@google.com> writes:
>
>> Thanks! Shall I apply your suggestions, or were you planning to apply
>> them yourself?
>
> Definitely not the latter ;-)

;) Ok, I'll give others some time to weigh in before rerolling.
