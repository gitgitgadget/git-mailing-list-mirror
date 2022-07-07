Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49842C43334
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 09:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235027AbiGGJCg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 05:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234243AbiGGJCe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 05:02:34 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96194286CE
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 02:02:33 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-31caffa4a45so91962387b3.3
        for <git@vger.kernel.org>; Thu, 07 Jul 2022 02:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7xm+1WtAaeTFsnpZ5WEJwCnmWwFrgOlfaPfFk9PAjOk=;
        b=RYjF/unOUCvSmnqfKOUT03ilNxe2iLJzP0D93audKdX8BIQIzwhVys9GFMlhBikKnL
         i0jsz//Ar5MZPXMojQ872oMz4VhsNgVarkTUQkXaBrB9IM2sqL4B+JO1F2SjRFM2eGgN
         B+pza2p3EYYW3cTovsTahI3RgVSil0W+hhmB6aMxGqF1w8QQveijU5hYK8x2xbuVYfDM
         tUozlTz/jYFShTn9qMlPFMyv0QK17mr0mHa0euHpJAF4ss+Cj3kHMC6DGNACC6lnsD0L
         /RsPKG5oYwvOSv0DMYHAdF1fpqfuFDwEm7f1vce6qITDcmZcOR78a0BxyrRmpH/E7sJ+
         KdPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7xm+1WtAaeTFsnpZ5WEJwCnmWwFrgOlfaPfFk9PAjOk=;
        b=aCYGsudrc/90I0oGu6CYHVdQqC26zP/QgG8q2/RKKXQy76PNSVrkGfVC0pEBZsOdI3
         7zXnmaSgNZ7F4+6xdvZv4jgSSDeJ5tLytDcgKo+cXMx0ZbfXVGiUJvt6x3riXqzC+eSu
         zbrHGzrFdukAKJ1UaJ+Qg/2/hZyFV/tVp0VGRUSASKmFa8qiJEIFUDSQbrOK+rrY2fEm
         Ljj67WeBBY3mh+/C9FSt9DDnEXroceSmpGNVaUwDWupFL2N1zdZoJ7UWv8uKfu7eQP4+
         n/J75OCBUvMeDNH3v6EuYWYb9Vn+E8gpxaaFtBFDXI+rlUMLlYyxYnxAwJ79wBXIrh/H
         DeQQ==
X-Gm-Message-State: AJIora9w3cDA9D7qmN//88r9OWyXn3h4AstBxuxOHYNQF1pmGMHGvD6P
        aiaUa3AMcEfulwTcnZqirsVingZtpkNY5/z3i3I=
X-Google-Smtp-Source: AGRyM1tFSAOO8HEhObHsbmZ4htspUMzpFd/Zssy9sL3nYzrDY5SD2Zs+LSzlq5A5xGh5ynqULio+1Bw7Yu+8p2V3/vg=
X-Received: by 2002:a81:23c4:0:b0:31c:8bf8:af81 with SMTP id
 j187-20020a8123c4000000b0031c8bf8af81mr26360656ywj.340.1657184552549; Thu, 07
 Jul 2022 02:02:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220630142444.651948-1-siddharthasthana31@gmail.com>
 <20220630142444.651948-4-siddharthasthana31@gmail.com> <220701.86sfnlbu0j.gmgdl@evledraar.gmail.com>
In-Reply-To: <220701.86sfnlbu0j.gmgdl@evledraar.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 7 Jul 2022 11:02:21 +0200
Message-ID: <CAP8UFD13MfoMqWSfZfucfdbQL5ypbcYNuHfm1QS8uhmQYq4_VA@mail.gmail.com>
Subject: Re: [PATCH 3/3] cat-file: add mailmap support
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Siddharth Asthana <siddharthasthana31@gmail.com>,
        git <git@vger.kernel.org>, John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 1, 2022 at 1:39 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
> On Thu, Jun 30 2022, Siddharth Asthana wrote:
>
> > git cat-file is not a plumbing command anymore, especially as it gained
> > more and more high level features like its `--batch-command` mode. So
> > tools do use it to get commit and tag contents that are then displayed
> > to users. This content which has author, committer or tagger
> > information, could benefit from passing through the mailmap mechanism,
> > before being sent or displayed.
> >
> > This patch adds --[no-]use-mailmap command line option to the git
> > cat-file command. It also adds --[no-]mailmap option as an alias to
> > --[no-]use-mailmap.
>
> I think I know the answer, but I think it would be helpful to discuss
> the underlying motivations too. I.e. an obvious alternative is "why not
> just get this information out of git show/log then?".
>
> The "I think I know the answer" being that I suspect this is to cater to
> gitaly having persistent "cat-file" processes around, whereas for "git
> log" it would entail spinning up a new process per-request.
>
> But maybe I'm missing something :)

No, you are not missing anything :)

> So not as a blocker for this change, which I think can be made small
> enough to be justified in cat-file, but just for context: If "git log"
> had a similar --batch mode, would there be a need for this change,

One nice thing with `git cat-file` is that it works for any kind of
git object. But yeah we could perhaps use `git show` if it had a
--batch mode, or a mix of `git cat-file` for blobs and trees, and `git
log --batch` for commits and tag objects.

> or is
> this just adding a common case to "cat-file" to "tide us over" (as it
> were) while that sort of thing doesn't exist yet (and maybe never will
> :()?

By the way there have been 2 GSoC contributors working on adding
ref-filter formating support to `git cat-file` and that hasn't
succeeded yet, mostly for performance reasons. So another way would be
to wait until ref-filter formats support everything that pretty
formats support, which Jaydeep is currently working on, including %aN
(author name respecting .mailmap) and %aE (author email respecting
.mailmap), and then wait until `git cat-file`'s --batch formats
support ref-filter formats.

But yeah, we hope the change can be made small enough to be justified
in cat-file.
