Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF51C433F5
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 23:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235992AbiBUXLu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 18:11:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbiBUXLu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 18:11:50 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF32245B2
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 15:11:25 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id hw13so36867729ejc.9
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 15:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=njhDoVaXrr0b+2UTm9aKAi26U7PWcLwLy/qwBDmcXoE=;
        b=GpXoVLinXJreerDmSflcDDjAaQ+51oVzXa4cld9KROKqEas5ovObS3cnxSCKh5FqRf
         g39VLwLgQjqfvqPszXvjLeRIaLu5Kz2lGh/RYhff1m1Un8+cb5SfjmoQT53tMpk2NXvM
         by58Xzib8LvGIl7s8bZCD8ywHoGLJ739DnYAPd0pytOmtiYS8dBv3LMsf1tmonw3T4Dq
         VzkLVu3abtDgdjZdbqDpEpkgB81iTb/qcpYHeg1wLHnNbzWDqoT3sT8+CcX2qACsmzXh
         BYloZm9zaNup7sSy1KHVn8hE3DbERcYKrb02Wrk4rQZxYUOhf6+C2u6LOqLfRa1JlKg9
         2uSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=njhDoVaXrr0b+2UTm9aKAi26U7PWcLwLy/qwBDmcXoE=;
        b=2pgymareEAR8Pdrbljnv9lrlu+kzidMuHDMepidAofVx/eCuhE1yjFEAAhiObafqoJ
         pAgnjbTZzzslwaE+nEqBXLel/c9uoV2jSFylhffn9Ztfe+3c8OhOu58ao5XyWV3zAP8T
         hP9zqjERRQDcsKTjxNrd564rOW6zRKjDcWr0oFMBJZOf/wmPhwsrU9K4LEK/5yQzG658
         4xFQAX6FsoZijuCLZiLuzY/ez0TuZSK4Zy/B7HK6B0wu8368PTNwu2wp7hixYt4+VIoU
         2ZJXwjeX3lPF05lTBgLN6tN4Bfnj/Mq2tUhoJjwGSHUCOq8U+LgQR3EULW08Xb4XJXjs
         hKzA==
X-Gm-Message-State: AOAM533uFpmDvE80I7YAOe5GBqd3tEwKwkggJLfkaaC2rDVqpuk8HIyR
        xFdusYjk597/jQh7wCcgR5k=
X-Google-Smtp-Source: ABdhPJz73NWGnBIJBuHTJna+bwupaKFrj82lO1CxubpO+vpPK6z7lFHKRZzWZOSoW7JhgN3JDYZuAw==
X-Received: by 2002:a17:906:cb83:b0:6d0:fbb0:f75f with SMTP id mf3-20020a170906cb8300b006d0fbb0f75fmr9852111ejb.543.1645485083931;
        Mon, 21 Feb 2022 15:11:23 -0800 (PST)
Received: from szeder.dev (84-236-78-183.pool.digikabel.hu. [84.236.78.183])
        by smtp.gmail.com with ESMTPSA id l9sm3428319eds.9.2022.02.21.15.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 15:11:23 -0800 (PST)
Date:   Tue, 22 Feb 2022 00:11:21 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v4 3/3] test-lib.sh: remove "BASH_XTRACEFD"
Message-ID: <20220221231121.GB1658@szeder.dev>
References: <cover-v3-0.2-00000000000-20211210T100512Z-avarab@gmail.com>
 <cover-v4-0.3-00000000000-20211213T013559Z-avarab@gmail.com>
 <patch-v4-3.3-8b5ae33376e-20211213T013559Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v4-3.3-8b5ae33376e-20211213T013559Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 13, 2021 at 02:38:36AM +0100, Ævar Arnfjörð Bjarmason wrote:
> Stop setting "BASH_XTRACEFD=4" to direct "-x" output to file
> descriptor 4 under bash.
> 
> When it was added in d88785e424a (test-lib: set BASH_XTRACEFD
> automatically, 2016-05-11) it was needed as a workaround for various
> tests that didn't pass cleanly under "-x".
> 
> Most of those were later fixed in 71e472dc43 (Merge branch
> 'sg/test-x', 2018-03-14), and in the preceding commits we've fixed the
> final remaining and removed the "test_untraceable" facility.

Those commits made the test suite pass with '-x' without BASH_XTRACEFD
only when all went well, but during development that's often not the
case.  So let's not forget about c5c39f4e34 (test-lib: fix interrupt
handling with 'dash' and '--verbose-log -x', 2019-03-13), before which
dash was not really suitable to run tests involving daemon processes
with '-x' during development.  If dash were to announce redirections
in its '-x' trace, like many not as quite as popular shells do, then
the workaround in that commit wouldn't work at all.

In general, between POSIX leaving a lot of things explicitly
unspecified, or, worse, silently unspecified, shells not conforming to
POSIX, being buggy, and/or implementing their own extensions, I am
actually quite surprised that it works as well as it does with so many
shell.  At least as far as we know it, and I wouldn't at all be
surprised if there were unknown issues lurking in some corner cases
and/or with some more exotic shells.

> We could retain "BASH_XTRACEFD=4" anyway, but doing so is bad because:
> 
>  1) Since we're caring about "-x" passing in CI under "dash" on Ubuntu
>     using "BASH_XTRACEFD=4" will amount to hiding an error we'll run
>     into eventually. Tests will pass locally with "bash", but fail in
>     CI with "dash" (or under other non-"bash" shells).

This is not "bad", this is exactly what we use CI for.  This is the
smae case as when the test suite passes on a developer's Linux box,
but breaks on OSX or Windows in CI.

Furthermore, while I fully agree that keeping the whole test suite
passing with '-x' without BASH_XTRACEFD is desirable, I do think it's
a bad idea to forbid developers from using it while hacking away to
scratch their itches.  I for one sometimes deliberately use various
bashisms in my tests, including 'test_cmp'-ing the stderr of loops and
functions, because they make writing tests then and there easier, when
at that point I'd rather focus my attention on getting the C changes
right, and clean them up eventually when I deem the changes worthy for
submission.


Overall I consider this patch as a cleanup solely for cleanup's sake,
without any benefits at all.


I'm kind of low on time myself as well, at least to argue about this
any further.  Therefore, as the one who did the vast majority of work
to make '-x' work even without BASH_XTRACEFD, I leave here my firm:

  Not-Acked-By: SZEDER Gábor <szeder.dev@gmail.com>

to any patch that attempts to remove support for BASH_XTRACEFD.

