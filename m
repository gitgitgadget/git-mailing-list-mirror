Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E93C77B71
	for <git@archiver.kernel.org>; Sun, 16 Apr 2023 03:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjDPDIF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Apr 2023 23:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjDPDHh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2023 23:07:37 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99CF3A9C
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 20:05:46 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id h8so7108280ljf.3
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 20:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681614345; x=1684206345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygJNDVLhqtZphUL7mnpIEUuondPqoJFd5ji5xVnfoxM=;
        b=rVs64OsYG13gTLnVpKSgWT60VtrXjUi6F8aZTSd0cWa89Z6b2zwypGmNOMqsMpdzs8
         ppkpqLU4j9MRSweQdMENGuEsdr3n3xqHHtNaL8b4h23eNsZda0oud5l0obPvgWhCgLoN
         cWk527PGy8vv/uvMo2z+6A1QXarLAgl/itGU9/QuiiNNHLtJpmtRq5zHru0lznPBenlo
         XltopURwqhSQ3FUdEE69ZqB5cC9MTgxQoUQ0vP20WMVQTDIT9oMRIS1+KpjM4pShibpp
         0vEMqyNULbaxDvkLZ3Jz7znD+7ebn0ec0QHjypHHpxrEsszKr4kdSXTrUvYTDrs51FeS
         geVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681614345; x=1684206345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ygJNDVLhqtZphUL7mnpIEUuondPqoJFd5ji5xVnfoxM=;
        b=k0PFaZPegLHkRTe1ijzDjRyuEaqmnSlgLUaxWxnxqY+wzA8s5GPdF71D+nwx5LSaFX
         vIwvqFg6UN07Tlf6mnPQ0TZt2kQPRv4Y1DHpjg80g2tsxWE/66UE2eVfsl08lR65elDZ
         qQC+sfz3/k4gAmMAhO7FdlwEgQaJLgkQxvEagjoVSVPi5ThMpLtNELZzIRjPUBmd7zkS
         RIUkn7WG7SWZLe4MaruMJuJEpzC+M4JQWFg3tkW00SXmBtlOeOFdU+Zz0+Q6RuksOJfI
         58wmr913lpL9jwE3y6h4gDTi5Dge1TmjArwjWuiniGqKj2vwJqmmoWRUt4h6BOp1I2OC
         gtHg==
X-Gm-Message-State: AAQBX9d9z6rh15O+6gSoETHacQ2mwxXj0f1BiXCs4uoIac57LVsuxk3J
        0zqxd8AaXnfC6q1qfAJWKg8u9bVmA6pCyl9h49I=
X-Google-Smtp-Source: AKy350YtPD8hC/6xZjBlaIOLO/ApuAJ+QjbEXHRMtljCYBW0CCSHDOw+YHpzYlBN5mtUTSdIgsSfFcONRFlMARqvMJs=
X-Received: by 2002:a2e:9811:0:b0:2a7:adf7:1788 with SMTP id
 a17-20020a2e9811000000b002a7adf71788mr3269695ljj.1.1681614344779; Sat, 15 Apr
 2023 20:05:44 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1515.git.1681495119.gitgitgadget@gmail.com>
 <0cdd4ab3d739e07357ea9efef2cdece633db6ebb.1681495119.git.gitgitgadget@gmail.com>
 <CAPig+cQQVby2g+_kfucbYdwOZW5_CEyyyOex=4hXoCJt7TkjeA@mail.gmail.com>
 <CABPp-BH=LQdjn4yjtCJrPZVHLAZPC0895NYpyUfE92+TKcUsbg@mail.gmail.com> <CAPig+cSYJw3_eJSLr0ygPDj21vcdVK5NT1h_g1PrhA4vM+uiOA@mail.gmail.com>
In-Reply-To: <CAPig+cSYJw3_eJSLr0ygPDj21vcdVK5NT1h_g1PrhA4vM+uiOA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 15 Apr 2023 20:05:32 -0700
Message-ID: <CABPp-BHyPEb1DGDy8OFq90G6QhAihZAnxsJorbxUDe+AMeJ2DA@mail.gmail.com>
Subject: Re: [PATCH 4/5] Documentation: document AUTO_MERGE
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 15, 2023 at 1:55=E2=80=AFAM Eric Sunshine <sunshine@sunshineco.=
com> wrote:
>
> On Sat, Apr 15, 2023 at 3:08=E2=80=AFAM Elijah Newren <newren@gmail.com> =
wrote:
> > On Fri, Apr 14, 2023 at 10:08=E2=80=AFPM Eric Sunshine <sunshine@sunshi=
neco.com> wrote:
> > > On Fri, Apr 14, 2023 at 2:13=E2=80=AFPM Philippe Blain via GitGitGadg=
et
> > > <gitgitgadget@gmail.com> wrote:
> > > > +Notice that the diff shows we deleted the conflict markers and bot=
h versions,
> > > > +and wrote "Goodbye world" instead.
> > >
> > > Some grammatical problem here. Perhaps s/and both/in both/, or maybe
> > > just drop "and both versions"?
> >
> > It reads correctly as-is to me.  There were five lines dropped:
> >   * Three were lines starting with '<', '=3D', and '>' characters,
> > referred to as the conflict marker lines.
> >   * Two were lines containing content from each of the sides ("Hello
> > world", and "Goodbye")
> > and one line added.
> >
> > Thus, the diff shows we deleted the conflict markers (the 1st, 3rd and
> > 5th lines) and both versions (lines 2 and 4), and wrote "Goodbye
> > world" instead.
>
> Yes, upon rereading it, I can interpret it in the way it was intended.
> On my initial read-through, it sounded wrong. Perhaps, had it said
> "and both versions of the content line" or such, it wouldn't have
> tripped me up.

That suggestion reads well to me too.
