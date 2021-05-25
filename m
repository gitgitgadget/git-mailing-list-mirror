Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C65C2B9F8
	for <git@archiver.kernel.org>; Tue, 25 May 2021 06:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34FF86140F
	for <git@archiver.kernel.org>; Tue, 25 May 2021 06:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbhEYGRR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 May 2021 02:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbhEYGRQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 May 2021 02:17:16 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65953C061574
        for <git@vger.kernel.org>; Mon, 24 May 2021 23:15:47 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id b17so34741998ede.0
        for <git@vger.kernel.org>; Mon, 24 May 2021 23:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=cr+9aLorDKkJR9mKJKhxhTK5CwyGIMoKoAAXdwYT3rM=;
        b=HjJq3A3zmB8boYbReqdXobiQNjhnnjnjO2xKIQOpHw+b4Fp8UNqfssbxlpcsR3OUuw
         hy2c0FmPZfpU53JWvzXaLD9Y0QQlu3SFW/6EGyimI4+EEfSYphW/e6pho9m+HWPsmesW
         Yh7tKMSKORNzRNh8aKGAb8YY708uBii9rY0h7WyfnJcEjMJ4vE3mKLQcrr6BGn7PBHqk
         u8a5Qcgi7JGS4wIX85bU20Sq5CRYeNMqMqd6d4opLT5ThOlJsg3KO07+w2UPqFxQA6W1
         gs1Y67+n77S7LCoo+BTN/udC0OnJ1iOmfiNOfBZFbhLZ0c6oUSmftQV/Er4fWdzGbCNl
         4f2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=cr+9aLorDKkJR9mKJKhxhTK5CwyGIMoKoAAXdwYT3rM=;
        b=Z/8MwCXlh2V14CQbSN0nYSUxYJaCR82kiwWR4pkYH5RSCMIrn4vNITnUdFY0Z5K8Pb
         2RvXCORwVVc4QuYjzkoqHZL5OfJ6Plg01rm6fQF7v7W6tDdDJHdUpY6crgZCtSsk3F0s
         JDXE6vlTujcGkfFoWWuIsLMla5TgR9nNXHQhotAnMB0H/ilbxpVQr+pgwKk2QGKgOSLQ
         jJpx0gF02mnuI1iq00i3MXQ9f5mn7g7J2BP8DFRR/5TIjacFtEqp/KoLuwEH37SWuot/
         hWsSUr/9rGWdJ134+PTxBU3yqOnHnCuP/yHfuVLRbRP65ec+QiE51evbZHlhyX1BIQLi
         5AEQ==
X-Gm-Message-State: AOAM530rO+x1R1ts6c/FIgFmaTRzNLh1CBhEI8H27+xKNF12uGfXlXnn
        bQgSGzoq7xO4CEa/WcSlMf8=
X-Google-Smtp-Source: ABdhPJy01BwoEt047U0MVqo19xq1+/9cePyPsGVV6LOXsUlSuXjWcAmpbElGlocffzmgQdia8K3TmA==
X-Received: by 2002:a05:6402:2064:: with SMTP id bd4mr29183374edb.96.1621923345997;
        Mon, 24 May 2021 23:15:45 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id m2sm8970841edv.7.2021.05.24.23.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 23:15:45 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Robert Foss <robert.foss@linaro.org>
Subject: Re: [PATCH 2/2] send-email: don't needlessly abs_path() the
 core.hooksPath
Date:   Tue, 25 May 2021 08:13:52 +0200
References: <bb30fe2b-cd75-4782-24a6-08bb002a0367@kdbg.org>
 <cover-0.2-00000000000-20210524T231047Z-avarab@gmail.com>
 <patch-2.2-d097e7b0b81-20210524T231047Z-avarab@gmail.com>
 <xmqqh7iripzg.fsf@gitster.g> <874kerny0e.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <874kerny0e.fsf@evledraar.gmail.com>
Message-ID: <871r9vnxtb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 25 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Tue, May 25 2021, Junio C Hamano wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>>
>>> In c8243933c74 (git-send-email: Respect core.hooksPath setting,
>>> 2021-03-23) we started supporting core.hooksPath in "send-email". It's
>>> been reported that on Windows[1] doing this by calling abs_path()
>>> results in different canonicalizations of the absolute path.
>>
>> I see the author of that patch CC'ed; the change in question
>> explains why we switched from "the hooks directory immediately under
>> $repo->repo_path()" to "ask 'rev-parse --git-path hooks'", but it
>> does not say why we call abs_path() on the result.  I guess that is
>> because $repo->repo_path() has always been a result of applying the
>> abs_path() function to something, so it was to safeguard the callers
>> that expect an absolute path coming back from hooks_path?
>>
>> And that makes this change dubious, especially as a band-aid for a
>> breakage immediately before the final release, doesn't it?  Are we
>> convinced that the callers are OK with seeing sometimes relative
>> paths?  Certainly the cases the tests J6t fixed are not negatively
>> affected, but is that sufficient?  To what directory is the
>> configuration variable supposed to be relative to, and are we sure
>> that the user will always invoke "git send-email" from that
>> directory?
>
> The one caller is git-send-email.perl is fine with it, at least on *nix,
> this fix still needs testing on Windows.
>
> The repo_path() function was introduced in c8243933c74, so it's never
> been in a release, thus I think it's fine to alter its behavior.
>
> The code here doesn't need to concern itself with what needs to be
> relative to what, you run send-email in some working tree directory (or
> top-level), and depending on core.hooksPath we'll either return a
> relative path to the .git/hooks or an absolute one, the system()
> invocation will accept either.

...I think the one issue with my 2/2 is that it doesn't go far enough,
we should just remove the repo_path() from Git.pm and instead use its:

    $self->command_oneline('rev-parse', '--git-path', 'hooks')

...in the one user in git-send-email.perl, as discussed in other
serieses Git.pm is "public", so stuff we stick in there we can't
alter. In this case we're doing so before a release, and nobody wanted
this except git-send-email.perl.

That caller is likely to just go away if and when Emily's "git hook run"
lands, so I think it would be best (but not strictly needed for the
pre-rc fix) to just remove that API.

What do you / Robert Foss think (maybe he wanted this for something
else...)?
