Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1ADDC05027
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 00:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbjBOAfB convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 14 Feb 2023 19:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBOAfA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 19:35:00 -0500
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB222449A
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 16:34:59 -0800 (PST)
Received: by mail-pg1-f173.google.com with SMTP id 78so11411280pgb.8
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 16:34:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WYrOUZ7eJYHw2h9rJ3UUUd34Wy75mGg+0yWqvZh/3rA=;
        b=Nv7Bt2MfHr1qFqaG+JtR4sVg+FJsfZeUo60qexcapqUZS77VGuhRXIpgqt/zL5sI2g
         Fh2rGJHWmKMZ0kDi+zl6Tu6/aUV65L66+tlJzSUCbNNFTU/O08AEtEfja7YmgBWF4vwC
         kB40mK3040H8LiJXF4rNPdotvLIdT7SYYdM+e27m6HAnPf1SdOeL6ShvFF1xLs1GyLPx
         1akJGb2OPqPAtZQvWuCk+BY7MPnC5eGxV89jrWiQayMewf5dXdiajBItoCZvsnrekdsh
         Pt1hanHYXkXXKhzvKY5hWDDqPdp+m+y5gV0kidnpHNFXuVsyZi5RwaT7wC4BMvPn7Mmc
         jrSg==
X-Gm-Message-State: AO0yUKU9OZTnhjkMRyT8sOGxhP14xKKCGtUjUL1nTYQrAgGadPTfAVD0
        kZ7rnUXQfUfIgxXWferDJzJEYZtxamFGp7O1mmoxhtkO
X-Google-Smtp-Source: AK7set9aT5Og0kiJYVYjhvaY7tkAxOEW08JKJStY9CsVWRk2fgT/lSwsVYYE7liNRpiiGnI8Sq9wbvg5w3IBKTWNdiw=
X-Received: by 2002:a63:3ec1:0:b0:4da:9fda:ef19 with SMTP id
 l184-20020a633ec1000000b004da9fdaef19mr48694pga.10.1676421298554; Tue, 14 Feb
 2023 16:34:58 -0800 (PST)
MIME-Version: 1.0
References: <20230205145245.11078-1-cheskaqiqi@gmail.com> <20230206211823.8651-1-cheskaqiqi@gmail.com>
 <20230206211823.8651-4-cheskaqiqi@gmail.com> <xmqqlela2z3p.fsf@gitster.g>
 <CAMO4yUGmQ371hLCSTODQct+CzY2mqywfLzZO6fsgqN2=1cWGrw@mail.gmail.com>
 <230207.86h6vx51x3.gmgdl@evledraar.gmail.com> <CAMO4yUEcweeGZDCBm-y51TQ0fgze_geKr95RXBpEEpH4AyYJuQ@mail.gmail.com>
 <230208.865ycc1tqc.gmgdl@evledraar.gmail.com>
In-Reply-To: <230208.865ycc1tqc.gmgdl@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 14 Feb 2023 19:34:46 -0500
Message-ID: <CAPig+cTMBpau+G6bJSbYScOT38CU9BCi8RQ554jZYMUd+TheTQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] t4113: put executable lines to test_expect_success
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Andrei Rybak <rybak.a.v@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 8, 2023 at 2:57 AM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> In this case the syntax you're trying to get working is something we
> usually try to avoid in either case, i.e. even if it involves an
> external process we usually do:
>
>         cat >out <<-\EOF
>         a
>         b
>         c
>         EOF
>
> Rather than:
>
>         echo "a
>         b
>         c" >out

The here-doc (<<-\EOF) form is definitely a good idea when the code is
part of an indented test body, whereas the multi-line double-quoted
string will be problematic since lines "b" and "c" will be indented
with TAB, which is undesirable here.

Even better for such a simple case would be:

    test_write_lines a b c >out &&

In fact, Junio made this suggestion in the form of a code snipped much
earlier in this thread.

> If you are using "echo" I saw another change of yours had e.g.:
>
>         echo x >f &&
>         echo y >>f &&
>         echo z >>f
>
> It's better to e.g. (assuming use of "echo", or other built-ins or
> commands):
>
>         {
>                 echo x &&
>                 echo y &&
>                 echo z
>         } >f

This is also an improvement, though test_write_lines would (again) be
even better for such a simple case:

    test_write_lines x y z >f &&
