Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79AF3C636D3
	for <git@archiver.kernel.org>; Sun, 12 Feb 2023 14:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjBLOMq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Feb 2023 09:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjBLOMm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Feb 2023 09:12:42 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653501205E
        for <git@vger.kernel.org>; Sun, 12 Feb 2023 06:12:41 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id h24so11138776qta.12
        for <git@vger.kernel.org>; Sun, 12 Feb 2023 06:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3rKM+aE55tUyU8z+BJZ0i4i5FTJo0VcvuK7kQYfJXLA=;
        b=bwEz1UHYSr07Nsg6c3yVwaTrbC/edIWVlCpQ4LZGhAh/LXPflberGJ5kyDJZamBE6I
         ID1IJN82unlsEbolkhzOtnP8nVv36hUXuRsYbNRGq6QwD3zgqzi09Yvooo9knDvU48w7
         S1dZWKgmbzGAK/K9RPcEXdDJdDKUfgXqXPKIL+9C+3a87G+r/qAiQ99Trp2n8AsKc+Rw
         BJfzjCCBivj1+AWLY4usaDIgvZxzEy3cj6VhMy9rImMS/oQLRdb7Kw0+qyNZsNlQpS9V
         TOWWt6HPYxzvuBwEFxjgOF5LHy4bpGMKK0w0RgKVcqJJchdgUUks4K1nNuqA/zD/HimI
         xGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3rKM+aE55tUyU8z+BJZ0i4i5FTJo0VcvuK7kQYfJXLA=;
        b=FiffGYMAIepRSZFce+hTj2i7GYeam5HgCyA6sU2I/FSi6TJk/IbHynoF0AXxRsk4QG
         gBzOCVpAttfwF9CkC2IUHPcFKh4GMfcuDX/Ff7wKmEDFJdIKCkIOJHYlwtF5iV4lUBoz
         zfaMuJ3vRApROt4XmqJKf7S/Ll2IWE/umekOS+mfjcQxcrU6gSIgHH9aeae+LidB0iz5
         aKJ8SW7DrGk0MrnbopA96L89NjbTIEn1AoOzGBPNvebjwRx2gs4ZgWtS3QZJfXkq3CTy
         FvOpwJuZmpvuhoFiDrKqMjr1jzu6FralApb1x6DMK02V253yqU9lyjeITiAK5xACyVY4
         7zkA==
X-Gm-Message-State: AO0yUKVcXtoUz5KtlZlG5+NQEhoW8It+I5qtvS0wDPjAOJsvfx5qlv8z
        XDe0P4BmMkdspDsnnNHJFEDxWDpJyZHeGEWVuxk=
X-Google-Smtp-Source: AK7set8Tf1vMYJeAkRq78Oz7zSNw+3UYUQTWN5XTv0h6eEPCLmnG2enEtI/iJeb2GyefuwSrSvOaLjfr2+JV8HK31sw=
X-Received: by 2002:ac8:5fd2:0:b0:3ab:6b5f:664d with SMTP id
 k18-20020ac85fd2000000b003ab6b5f664dmr2833041qta.396.1676211160431; Sun, 12
 Feb 2023 06:12:40 -0800 (PST)
MIME-Version: 1.0
References: <CA+tAvojz0u7AbcNnY1qyy3VznKhYTiAO1dL+rfOD3O6mOtsa8A@mail.gmail.com>
 <20230211222353.1984150-1-andy@halogix.com> <CAL3xRKdCkAAR0r3jyKFy+TtUi65LQcHaste=2WCqYHtwi8cUhw@mail.gmail.com>
In-Reply-To: <CAL3xRKdCkAAR0r3jyKFy+TtUi65LQcHaste=2WCqYHtwi8cUhw@mail.gmail.com>
From:   Son Luong Ngoc <sluongng@gmail.com>
Date:   Sun, 12 Feb 2023 15:12:29 +0100
Message-ID: <CAL3xRKcw5KD2xE2Z1hEc-j8WMWknoMTJwfdEVa=h5sGb=SmhNQ@mail.gmail.com>
Subject: Re: [RFC PATCH] upload_pack.c: make deepen-not more tree-ish
To:     wansink@uber.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Re-send to the Git mailing-list as setting a font on gmail switched
plain-text to HTML and thus, got blocked by mailing-list.

On Sun, Feb 12, 2023 at 3:09 PM Son Luong Ngoc <sluongng@gmail.com> wrote:
>
> Hi Andrew,
>
> On Sat, Feb 11, 2023 at 11:49 PM Andrew Wansink <andy@halogix.com> wrote:
> >
> > This unlocks `git clone --shallow-exclude=<commit-sha1>`
> >
> > git-clone only accepts --shallow-excude arguments where
> > the argument is a branch or tag because upload_pack only
> > searches deepen-not arguments for branches and tags.
> >
> > Make process_deepen_not search for commit objects if no
> > branch or tag is found then add them to the deepen_not
> > list.
> >
> > Signed-off-by: Andrew Wansink <wansink@uber.com>
> > ---
> >
> > At Uber we have a lot of patches in CI simultaneously,
> > the CI jobs will frequently clone the monorepo multiple
> > times for each patch.  They do this to calculate diffs
> > between a patch and its parent commit.
> >
>
> I used to manage a CI system that support monorepo use cases not so long ago.
> We had several hosts(VM/Baremetal) on which we spin up containers for CI to run.
>
> We maintain a bare copy of the monorepo on the host level (cron job / systemd / DaemonSet) and mount this as read-only into each of the CI containers.
>
> Each of the CI containers would attempt to clone/fetch the monorepo with `--reference-if-able ./path/to/read-only-mount/repo.git` (1)
> So that most of the needed objects are already on disk in the shared bare repo.
>
>
> +-----------+  +-----------+  +-----------+
> | container |  | container |  | container |
> +-----------+  +-----------+  +-----------+
>              \       |       /
>       (mount) \      |      /
>               +------------+                 +--------+
>               | bare-repo  | <-------------- | Remote |
>               +------------+   (git-fetch)   +--------+
>                     |
>                     | (maintain)
>                     |
>               +----------+
>               | cron-job |
>               +----------+
>
> (forgive my horrible drawing)
>
> With this setup, we did not have a need to shallow clone any longer,
> and our git-clone in each container is simply a combination of git-ls-remote and a very light-weighted git-fetch.
> In some cases, such as a job in the later stages of a CI pipeline,
> the host would already download all the needed objects into the bare copy of the repository.
> This lets us skip git-fetch entirely when the CI container executes.
>
> Compared to the shallow clone approach,
> our "local cache" approach sped up the clone speed drastically
> while allowing developers to interact with git history inside tests a lot easier.
>
> > One optimisation in this flow is to clone only to a specific
> > depth, this may or may not work, depending on how old the
> > patch is.  In this case we have to --unshallow or discard
> > the shallow clone and fully clone the repo.
> >
> > This patch would allow us to clone to exactly the depth we
> > need to find a patch's parent commit.
>
> Hope it helps,
> Son Luong.
>
> (1): https://git-scm.com/docs/git-clone#Documentation/git-clone.txt---reference-if-ableltrepositorygt
