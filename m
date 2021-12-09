Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C046C433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 23:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbhLIXqi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 18:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbhLIXqh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 18:46:37 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D4CC061746
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 15:43:03 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id f16-20020a170902ce9000b001436ba39b2bso3123363plg.3
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 15:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=2rKRwrrwP9/0/dPH176FlKHS7TxPNEOEUMbfbSOPrBw=;
        b=MNJcom0EpTpQIj94cZi3kq4Zif7zW/I40ZHFxKx2FJZHORgL5/uSH8n26R+yUyIS5W
         F4R/jwKWcA2qi5WVlKfAXGTMTwbkvqJHZADFICW3W4MRUJWXJzi4l6eV4qazACNpz60Q
         zqaBGhi6g1lhbx6AocVsL+QB5gcQjtKNhX0idr1awXbRPbYqj2Ovz4tNHdT8f19TNtG+
         LGkXGGtZqrt4tkTqpCjVLqdCfm+UMCHK5Ftlx9P1NZyc1d1Fm+TqeEKWmAwD80rQmWRK
         E+nK3rnpYagQ3MovBnDLO87BuX5CIYqqpMC5NrQANqtBJDFc1A/s0PZmuFLwTvE2WcQu
         bZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=2rKRwrrwP9/0/dPH176FlKHS7TxPNEOEUMbfbSOPrBw=;
        b=TwV2mgaQg10l/oXcRD/K3MMCgKIQbPKJMcpS4CcxwtM1W3OLlPQW7F0o/vAX3E+ZbH
         SCEX1us3TcyBkN+lHBRu64zwKMeXx021gZuZL/PJ8q+Ip21o4GRMD7Wq4ytOkUeuhHvo
         MV2gFkxHIEDEdW1WrRbzJF5m07oIAPRQUqPw8a2GcQeb3Yu9lWfTimUpuWtF/ndOAYAF
         k9wbZQc/5Q8nc0NrfP0FyVJFYmicSDHkRy3fWqeFw0phe+xWYwuI1zQbNuM/pf2RuaJu
         i+5RUudbaOiPuMKmRcSrZODiw6lF+9Fh83tGW2Bp6+yjNsgX/Y3lHwH04W3J1dMI0eat
         hTsA==
X-Gm-Message-State: AOAM530zYPwnS1P0HN4vml2vQ8hflwsQe7Y75GgAau/hVJVI4yFYyEOX
        pXw/qXDbNpyX2XQ9SM5Jz176q6LURnScWg==
X-Google-Smtp-Source: ABdhPJzWTzy6J6TIOYwoKk+nsy6SpilKDsr6Jscz8aXz23CvIYwsNJsxv7WSMMEn1OM9yoGwOMURKzw8t705/A==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:3508:: with SMTP id
 ls8mr19576113pjb.51.1639093382830; Thu, 09 Dec 2021 15:43:02 -0800 (PST)
Date:   Thu, 09 Dec 2021 15:43:00 -0800
In-Reply-To: <YbKH6CSmfBOsTajW@google.com>
Message-Id: <kl6l5yrx9wfv.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
 <cover.1638859949.git.steadmon@google.com> <ba7d557725e70f2ae8f10ae5992c8168eb97f2fc.1638859949.git.steadmon@google.com>
 <kl6lr1amac23.fsf@chooglen-macbookpro.roam.corp.google.com>
 <kl6lo85qabch.fsf@chooglen-macbookpro.roam.corp.google.com> <YbKH6CSmfBOsTajW@google.com>
Subject: Re: [PATCH v5 1/2] branch: accept multiple upstream branches for tracking
From:   Glen Choo <chooglen@google.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, emilyshaffer@google.com,
        avarab@gmail.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

>> > We print ref_string, which is a strbuf. This causes t/t3200-branch.sh =
to
>> > segfault on my mac + clang, but inconsistently! With -O2, it doesn't
>> > always segfault, but the wrong memory is read:
>> >
>> >   Branch 'my3' set up to track remote branch local from 'Branch '%s' s=
et up to track remote branch %s from '%s'.'.
>>=20
>> I forgot to mention this earlier but in this example, the test *passes*
>> even though the stderr message is obviously wrong. I don't see any
>> coverage of the help message in t3200, which is a bit worrying to me.
>>=20
>> After this series is done, is it worth adding test coverage of the help
>> message?
>
> Yeah, I caught this earlier while reworking this section based on =C3=86v=
ar's
> review, but thank you for pointing it out. I'm unsure about checking
> formatting of message strings in tests; it would certainly have caught
> this bug but it seems that more often they're just "change detectors"
> rather than good tests.

I agree, although such a test might still be beneficial on the whole if
the change detector is easy to update.

> But I could be swayed if you or others feel it's important.

Because this is rather "change detector"y, I don't think it's important
either, but I'm also open to being convinced.
