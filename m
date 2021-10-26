Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C69C433EF
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 11:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 654B160F9B
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 11:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233778AbhJZLQU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 07:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbhJZLQT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 07:16:19 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A38C061745
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 04:13:55 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id e12so18521985wra.4
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 04:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=XuLayEDMzEqJ20jAlEQJQ9J0haczWj0LToXjmkTfp+A=;
        b=WUv7Ols/7uu3vgDnQxMj4jR5rIgTUJ9GBTmWy2haBioGYRbpchVfAZhusJUOYTWybe
         tO6VWPWx9IqViOa8woUBzsrqaId8AKm/Zyhj48PTwNDehht2kzjLFPWRORIaSDhX6nGc
         U9gWevNrHZ3Ui2wnAOP3tDOu/cIhVepkX3Obi96kn53jwJAlmcT+luNXBjP3qBz+Lyvx
         8/ivbyNbZ2mNDAp3IqltbsbgWepY3OTfff2o+GV3I1sO24fEj+G9tZIlhg56dIzOc4PV
         xp5dIRa+n5jWDuYRGdmyru6WJ03hHodx7Eo/wMR+ZFYhE7c+1R3xUnx7axjkkHzj0K7X
         CSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=XuLayEDMzEqJ20jAlEQJQ9J0haczWj0LToXjmkTfp+A=;
        b=ugnw/rt2rb5kfKk37kmaZPAmhrZllogfJmU+ZrkJh9JzJFewZyt7GrldhFLimyXtdB
         hKJOK9LpM3AK3kzB/YHlF8NnxXf6yUlXBivbn9q7j827FS+piZiv44EBPfAcX81Gchyh
         UIBevM1iqcRQRe2zkvKfnK8o90rtVD9XOxNQFjOaOr2YISjRCypYxf9YbPn6WyMhZRes
         zGnuafsas2CneC+6nk0CrjHn9FFDegGaEqpfSxUH7wodJjQC5aRb+su1Zy3vpfGwxCye
         lo1A1vqpikMpk4Pe38VlnITVUhUJ9PA9AagpFwK/1MsFU4fH+EQRoXeUZzISH+D5etoV
         S6pA==
X-Gm-Message-State: AOAM531dWzjvdSpm/VvY00WSqdLebt/mVisGrOkEjgBqwNpq5oMxDbxb
        EbPTm2tC0540cYo3TLFXdIJ3LX+C19It3g==
X-Google-Smtp-Source: ABdhPJxFbM88Aqckmf4OYvSbfIbRlI6RJD+BgDFlbnXNq5ipJthsRcXtcy3Yjj1C95Zh9YeD/n0v3Q==
X-Received: by 2002:a05:6000:1689:: with SMTP id y9mr30792366wrd.52.1635246833981;
        Tue, 26 Oct 2021 04:13:53 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id c13sm1660665wrq.46.2021.10.26.04.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 04:13:52 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mfKOt-001m0v-VP;
        Tue, 26 Oct 2021 13:13:51 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>
Subject: pre-v2.34.0-rc0 regressions: t7900-maintenance.sh broken due to
 'systemd-analyze' (was: What's cooking in git.git (Oct 2021, #06; Mon,
 25))
Date:   Tue, 26 Oct 2021 13:02:15 +0200
References: <xmqq5ytkzbt7.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <xmqq5ytkzbt7.fsf@gitster.g>
Message-ID: <211026.8635oo11jk.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 25 2021, Junio C Hamano wrote:

[Spinning off some "before rc0" threads]

> The fifteenth batch of topics are in 'master'.  I expect that this
> is more-or-less what we can expect in the -rc0, unless there is a
> hotfix to what's already merged.

I reported a breakage with $subject in [1], which I see L=C3=A9na=C3=AFc tr=
ied to
fix in [2], but which I managed to miss. Sorry about that.

On that machine (gcc135, on the GCC farm) it's still breaking, relevant
trace output:
=20=20=20=20
    ++ printf '%s\n' 'prerequisite SYSTEMD_ANALYZE ok'
    prerequisite SYSTEMD_ANALYZE ok
    ++ return 0
    ++ test_set_prereq SYSTEMD_ANALYZE
    ++ test -n ''
    ++ case "$1" in
    ++ satisfied_prereq=3D' POSIXPERM BSLASHPSPEC EXECKEEPSPID REFFILES COL=
UMNS_CAN_BE_1 PERL PTHREADS PYTHON GETTEXT XMLLINT SYSTEMD_ANALYZE '
    ++ lazily_tested_prereq=3D'EXPENSIVE XMLLINT SYSTEMD_ANALYZE '
    ++ total_prereq=3D1
    ++ case "$satisfied_prereq" in
    ++ satisfied_this_prereq=3Dt
    ++ case "$satisfied_this_prereq,$negative_prereq" in
    ++ ok_prereq=3D1
    ++ test 1 =3D 1
    ++ systemd-analyze verify systemd/user/git-maintenance@.service
    Failed to open /dev/tty0: Permission denied
    Failed to load systemd/user/git-maintenance@.service: Invalid argument
    error: last command exited with $?=3D1
    not ok 34 - start and stop Linux/systemd maintenance

I haven't looked into it, presumably easy-ish to fix, just moving on now
and checking for other regressions...

1. https://lore.kernel.org/git/874ka618n4.fsf@evledraar.gmail.com/#t
2. https://lore.kernel.org/git/20210927213016.21714-2-lenaic@lhuard.fr/
