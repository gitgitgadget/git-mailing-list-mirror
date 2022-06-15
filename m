Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E1AC433EF
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 00:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234820AbiFOA3S (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 20:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbiFOA3R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 20:29:17 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC0230F5D
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 17:29:16 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id a15-20020a65604f000000b00401a9baf7d5so5742700pgp.0
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 17:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=IxzqRTqgzkSiFPwjUpfEppTcuqB0Dx8cfd/9xrUHF8k=;
        b=A1GVxRhOyOo+yNTV+YYxWxwfyzHgHWMjSlhf8mKlz1hGm4edfFQCu1z1/Uef3XRCgc
         K2/3siwYenteAwFbu0UL7lLW3c52RNJPkjDjtEpbiZQQW/njeRDOY1i5m4Iep1ADSZGU
         ITRFrOe6eEY1DPVkA1NwWN7NjBIidXMr2jDnoaRa2qBFepvWUI77tEkcMMaIZ9SqJxEU
         dOwYbwZatKDEmKHEk2nzXJ5XX8FdLs6y1uws1TT5L+QJFejORB5xJh6ZU3pd2bJ49BLm
         iK8zG6XZfd0+vzUEKXRjbuipcVngzfU+WFAQPbus/zvGywY/8eAKN8HN5UrtATMR1oRB
         Mpjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=IxzqRTqgzkSiFPwjUpfEppTcuqB0Dx8cfd/9xrUHF8k=;
        b=vJvdMMr0NZjDZDvdP3sNIcl2LqGgQpomQ9ZwwZTq0gCJ4Fmwh0N0+CbuTurnYkYOwv
         VM1AsZNKZBRVfQJC1PrGuc4TuHlYfCEVzpXb7kuzjbYxWAHeIzm2TE00TgVks4Rqmo4f
         N1iSH9sviRU/eJiiunlqyCw3mzpYyS1CQPyCkTiHU9G8WLefk+RDh4UtVAoPJfhAIFHX
         2JZAE1acjAzqc/ca5MQvR7bi8HWfXCLwMkoy4WeL0E0evctrJ1kDIwTW8TTYXzq3xH37
         pICbiuiTGmD12QXkD0D/H8sLCVRhkJnD7lQNhNWw2JaRuCFjCALi5yLv8ogbMWnpVA4d
         Z64w==
X-Gm-Message-State: AJIora8+u9P/iZOz+ylONQ1DHqoXqgSjF3WiwVRY/s6QjTdnmuxKu+yh
        9PiXPF8eOOZdc7OUiUYvvBLDsMZxEgtqCg==
X-Google-Smtp-Source: AGRyM1sVT0Ik5JRCS6nIVDMHGzBJxYh9+C66hk9Q2C3+HnGOg//9CzIuDNi0TPrqzu3SnEWiNXtsy6lRr41tZg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:1a81:b0:1e8:866c:6f78 with SMTP
 id ng1-20020a17090b1a8100b001e8866c6f78mr7202145pjb.44.1655252956222; Tue, 14
 Jun 2022 17:29:16 -0700 (PDT)
Date:   Tue, 14 Jun 2022 17:29:14 -0700
In-Reply-To: <patch-v2-06.12-025694644fc-20220613T220150Z-avarab@gmail.com>
Message-Id: <kl6lilp26a79.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <kl6lzgig5qmc.fsf@chooglen-macbookpro.roam.corp.google.com>
 <cover-v2-00.12-00000000000-20220613T220150Z-avarab@gmail.com> <patch-v2-06.12-025694644fc-20220613T220150Z-avarab@gmail.com>
Subject: Re: [PATCH v2 06/12] submodule update: remove "-v" option
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> The only in-tree user has been this test added in
> 3ad0401e9e6 (submodule update: silence underlying merge/rebase with
> "--quiet", 2020-09-30), it wasn't per-se testing --quiet, but fixing a
> bug in e84c3cf3dc3: It used to set "GIT_QUIET=3D0" instead of unsetting
> it on "-v", and thus we'd end up passing "--quiet" to "git
> submodule--helper" on "-v", since the "--quiet" option was passed sing
> the ${parameter:+word} construct.

Ah, that explains why we have a test for something that seemed so
unnecessary. Note to self to dig a little more in the future.

> Furthermore, even if someone had used the "-v" option they'd only be
> getting the default output. Our default in both git-submodule.sh and
> "git submodule--helper" has been to be "verbose", so the only way this
> option could have matter is if it were used as e.g.:
>
>     git submodule --quiet update -v [...]
>
> I.e. to undo the effect of a previous "--quiet" on the command-line.
>
> Signed-off-by: Glen Choo <chooglen@google.com>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

The additional motivation looks great, and I think it's changed
sufficiently that you should be the author instead of me.
