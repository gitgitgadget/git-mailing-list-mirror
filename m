Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08EDC678D5
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 00:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjCHAsW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Mar 2023 19:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjCHAsV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2023 19:48:21 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E2A5D45F
        for <git@vger.kernel.org>; Tue,  7 Mar 2023 16:48:19 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id g9-20020a17090a300900b0023a8d6e327dso168176pjb.9
        for <git@vger.kernel.org>; Tue, 07 Mar 2023 16:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678236499;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zg8KF180sFfzUknfKCCzV9AGQeJAFOe6fBbrIoUflw0=;
        b=k6YXLZ7SqHIqqe4dDuDpSe5oKhRXnTuqxhATQCU7dmSxOA2d3i0ALF6CL14xWMmW2E
         +8aD7iKEFU20py2xH9h1qpg/RLEb08K+VsjhLqe9WtrDMaUO7WS+QRXXmlYcAzyPzRWx
         xtdTBFdMAQQ+Y5e9RLOV2vepaRCY0MBWx9uugASmC3UFM96uRkXgVRq9+3UPR3+S2HTi
         K7z4HkQlKhKQAtymfikrkiiLLRNuY1LhaiH5Lzxt6GEalc7K+qcrliHWugns8eESvAbl
         /l724XS0k7t6OufNA4r4JV8BPu8VrGQqf6gt98x75imna6CC9IpOSd9WJ2Nudy1g2pRM
         hROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678236499;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zg8KF180sFfzUknfKCCzV9AGQeJAFOe6fBbrIoUflw0=;
        b=2B7QvYZrSQqnG5T+3KiIouk/W2DpwDqTyeCfLQfh7G8f7F0t520skT8AbvAaOIWcur
         ++FoygoeSo5+4AJHRwDT3VI244QYyx3LqXkhjjGnnwhEERx5SF1C0ftsswd5eRvZoP1R
         G0pInuCy7DXB/1bf3y3vGy0DGCB7HiObyMGjPZXSkM5YrWs33FEubw5MVExxrcXvKcAa
         tVhylCdF8WrVdyWDk5vvH6eVLv42DxGLJUYfP5lUe/fFsuUX6pkX7PUNmUWJlbwIFEDZ
         C6kHCXlEz1Wbl9ZOy84OuQ+AoqbXcySMdbyUz0P1bfQA1rOctxjUn2RDCQh6qLxMkMpw
         /Xsg==
X-Gm-Message-State: AO0yUKWyhZMHsHNSi2ILXEprZVp5PbY4xmnusuDxiSxAFK77bO5OkuSs
        4SsHVw9XmVzmY4GSe7S+htu3zulNhuoBvw==
X-Google-Smtp-Source: AK7set+rcSGnugYY0OfG08M5I/mmsxkxOIWDpJM99Tk4VtIqng0OJXPPeaXNvU35RfItKr1mJ3talYCUuPZAyA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a63:7242:0:b0:507:3e33:43e3 with SMTP id
 c2-20020a637242000000b005073e3343e3mr3417856pgn.7.1678236499335; Tue, 07 Mar
 2023 16:48:19 -0800 (PST)
Date:   Tue, 07 Mar 2023 16:48:17 -0800
In-Reply-To: <cover-v6-0.9-00000000000-20230307T180516Z-avarab@gmail.com>
Mime-Version: 1.0
References: <cover-v5-00.10-00000000000-20230207T154000Z-avarab@gmail.com> <cover-v6-0.9-00000000000-20230307T180516Z-avarab@gmail.com>
Message-ID: <kl6lwn3sgjam.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v6 0/9] config API: make "multi" safe, fix segfaults,
 propagate "ret"
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "SZEDER =?utf-8?Q?G=C3=A1b?= =?utf-8?Q?or?=" <szeder.dev@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>, raymond@heliax.dev,
        zweiss@equinix.com,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Range-diff against v5:
>  1:  cefc4188984 =3D  1:  43fdb0cf50c config tests: cover blind spots in =
git_die_config() tests
>  2:  91a44456327 =3D  2:  4b0799090c9 config tests: add "NULL" tests for =
*_get_value_multi()
>  3:  4a73151abde =3D  3:  62fe2f04e71 config API: add and use a "git_conf=
ig_get()" family of functions
>  4:  382a77ca69e =3D  4:  e36303f4d3d versioncmp.c: refactor config readi=
ng next commit
>  5:  8f17bf8150c !  5:  e38523267e7 config API: have *_multi() return an =
"int" and take a "dest"
>     @@ config.c: void git_die_config(const char *key, const char *err, ..=
.)
>       }
>     =20
>       ## config.h ##
>     -@@ config.h: int git_configset_add_parameters(struct config_set *cs)=
;
>     +@@ config.h: int git_configset_add_file(struct config_set *cs, const=
 char *filename);
>       /**
>        * Finds and returns the value list, sorted in order of increasing =
priority
>        * for the configuration variable `key` and config set `cs`. When t=
he
>  6:  b515ff13f9b <  -:  ----------- config API: don't lose the git_*get*(=
) return values
>  7:  8a83c30ea78 =3D  6:  3a87b35e114 for-each-repo: error on bad --confi=
g
>  8:  d9abc78c2be =3D  7:  66b7060f66f config API users: test for *_get_va=
lue_multi() segfaults
>  9:  65fa91e7ce7 =3D  8:  0da4cdb3f6a config API: add "string" version of=
 *_value_multi(), fix segfaults
> 10:  4db3c6d0ed9 =3D  9:  627eb15a319 for-each-repo: with bad config, don=
't conflate <path> and <cmd>

I haven't reread the series in its totality yet (I should get to it in
the next few days), but a small-ish thing that jumps out from
the range-diff is that this version doesn't revert the commit message
changes in the previous version (v5 CL [1]) that referred to the ejected
06/10. I.e. v5 said that we were changing the return values of the
*_get_*() functions so that the new function is not a special snowflake,
and those commit messages haven't been changed.

1. https://lore.kernel.org/git/cover-v5-00.10-00000000000-20230207T154000Z-=
avarab@gmail.com/
