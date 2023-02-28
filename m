Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D37C64EC7
	for <git@archiver.kernel.org>; Tue, 28 Feb 2023 20:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjB1UEp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Feb 2023 15:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjB1UEn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2023 15:04:43 -0500
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677A52FCD8
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 12:04:36 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-172334d5c8aso12127316fac.8
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 12:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677614675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UTtf288QjMgI2R3wbYxu+0MrHbxCC2Wf1pWtUyre/ag=;
        b=bgBVaIn32z0Caqn0bs+BstfwViO7KNIS2C8+KfQIPZWLOgIm/R7Ir1IaT4HbOGXv7V
         7ev2+HlUKqhpjAvZKezSS00j+3kr0eK4gpaMF3oYbH+qwGbvp2lz6TWkeldAgZw5BsdV
         QgiPpBmo9VuM/nzwxxp2FmiNvUe7fg/V0IZBNhiK/NQXBuF6hiLIm6tDqs6wUHVSxbs7
         iKrfYXw+QZpUY5OfLhzay46EuDdr9dZ7pviwzk90fCQdp6ZWuoEkcwPnvJfu+780wPHd
         4p1+q17sMrjcgCGeXKmx0p/VxEzdhIRChcMbOs+9azmK0ocNAsp6uMNJH/Pwne2lvTry
         U2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677614675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UTtf288QjMgI2R3wbYxu+0MrHbxCC2Wf1pWtUyre/ag=;
        b=rXTWRQQuMLyV/JrVz0yX88eTpWc3zGg/vsvnERgEGdmMdjYDeKv7TI9Gr4an9XXcJI
         4nzRhRQlH2po3M4riXYyWiqo1yWPPSeupqv1oE2beogVOknqHWzWi6Mg647DzN5GMB4s
         3M1Ow9m2q+MMxO1bYzKJ92WrJTSrxD43Rp79xv7mkIHSN8dTuKTBTCSJoqEMdcq5grvo
         CdwHLNyBD6glSPBXaTsc8gr6sXENVeuF8h3t5tyHjlEJOAvWy/loXjaaP8FEzu9Ch85Q
         GT957QhNgI2WhnqtNoWD5AmeXSw5UhqmsjLX4d1CzxT5hJejrzOH4QkhxcjPmuxs+gvP
         9d1Q==
X-Gm-Message-State: AO0yUKUjxcv276kDbjzbHM5z5/O3ZJW2fKbeBicrF2AFNs4W1cIEIISA
        iI8m2awKRdfpnHXMAzpW6kgoWY5/Y964iVBEJJk=
X-Google-Smtp-Source: AK7set9EA4n0MHbVinbDKkW7fYUxzvi8KEecwSwvS+0cSfGQm3Uvg4jzo7y7lxbKmzWiMm+mEA788lP+OxMCNKkCsvY=
X-Received: by 2002:a05:6870:f80e:b0:169:ce1c:d7c2 with SMTP id
 fr14-20020a056870f80e00b00169ce1cd7c2mr6118735oab.5.1677614675669; Tue, 28
 Feb 2023 12:04:35 -0800 (PST)
MIME-Version: 1.0
References: <pull.1474.git.1675614276549.gitgitgadget@gmail.com>
 <CAMMLpeTPEoKVTbfc17w+Y9qn7jOGmQi_Ux0Y3sFW5QTgGWJ=SA@mail.gmail.com>
 <CAPMMpogFAR6cvcR8T5fx+AoytAJ7TsPpSeOjHNzW4Gmkuq7FLQ@mail.gmail.com> <CAMP44s1_Oy8GzoALnvQMJEVRkDB3EBmn4drTyY6T+9BatRpjUA@mail.gmail.com>
In-Reply-To: <CAMP44s1_Oy8GzoALnvQMJEVRkDB3EBmn4drTyY6T+9BatRpjUA@mail.gmail.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Tue, 28 Feb 2023 13:04:19 -0700
Message-ID: <CAMMLpeRCKMqVNYvL9i0HGTEKvaACaEyCWCotzKfo-OQW2y_BpQ@mail.gmail.com>
Subject: Re: [PATCH] pull: conflict hint pull.rebase suggestion should offer
 "merges" vs "true"
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Tao Klerks <tao@klerks.biz>,
        Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 28, 2023 at 7:13=E2=80=AFAM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> On Thu, Feb 16, 2023 at 7:33=E2=80=AFAM Tao Klerks <tao@klerks.biz> wrote=
:
> > On Thu, Feb 16, 2023 at 4:22 AM Alex Henrie <alexhenrie24@gmail.com> wr=
ote:
>
> > > Now, this is not to say that there's no room for improvement. I like
> > > the rebase=3Dmerges option and I wish everyone knew about it because
> > > there are situations where it really is the best option. I suggest
> > > leaving the existing text alone, but adding an additional paragraph,
> > > something like:
> > >
> > > Note that --rebase or pull.rebase=3Dtrue will drop existing merge
> > > commits and rebase all of the commits from all of the merged branches=
.
> > > If you want to rebase but preserve existing merge commits, use
> > > --rebase=3Dmerges or pull.rebase=3Dmerges instead.
> >
> > My primary motivation with this pull request is to reduce the
> > incidences, out there in the world, of people copy-pasting "git config
> > pull.rebase true" into their command-line, and causing themselves
> > major headaches days or weeks later. The "--rebase=3Dinteractive" part
> > is secondary (to my concerns), because it's much less copy-pastable.
>
> That's because the whole approach to the pull.rebase configuration is
> wrong. I explained why multiple times in countless discussions and git
> developers did not listen.
>
> What we need is a pull.mode configuration that is *orthogonal* to
> pull.rebase, then everything just works.
>
> For example, you could have this configuration.
>
>     git config pull.mode merge
>     git config pull.rebase merges
>
> Then doing `git pull --rebase` would do a merges rebase.
>
> This is not possible with the current approach, which I objected to.
>
> Then there's no problem with telling the users to do pull.mode=3Drebase
> (or whatever), since that doesn't override pull.rebase=3Dmerges.
>
> I programmed and explained this precise interaction with rebase=3Dmerges
> more than two years ago [1], but nobody listened. For an example of
> how such configuration would look like, see the patches I just sent
> [2].
>
> Cheers.
>
> [1] https://lore.kernel.org/git/20201218211026.1937168-14-felipe.contrera=
s@gmail.com/
> [2] https://lore.kernel.org/git/20230228140236.4175835-1-felipe.contreras=
@gmail.com/T/#t

I think everybody agrees that the current situation is kind of a mess.
For better or for worse, there was no consensus to get away from the
current set of config options and introduce something more
straightforward, so we keep making incremental evolutionary changes
within the current framework.

I didn't include it in my list of things to do, but your email made me
realize that the problem with `git pull` not being able to do an
interactive rebase that rebases merge commits is also something that
needs to be fixed before flipping on "rebase merges" by default. If we
add that to the list, I guess it would be step 2.25. It's going to be
confusing if `git pull -r` rebases merges but `git pull -ri` does not.
One way to solve that would be to make -ri/--rebase=3Dinteractive on the
command line work with pull.rebase=3Dmerges instead of overriding it,
and add a separate --(no-)rebase-merges command line option for if the
user really does want to override it.

On top of that, either before or at the same time as when the default
behavior of `git pull --rebase` changes to rebase merges, the behavior
of branch.autoSetupRebase needs to change to match.

-Alex
