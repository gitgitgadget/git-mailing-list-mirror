Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC60C43334
	for <git@archiver.kernel.org>; Tue,  7 Jun 2022 11:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242279AbiFGLBa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 07:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242410AbiFGK77 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 06:59:59 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB440205E0
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 03:56:16 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-e5e433d66dso22651545fac.5
        for <git@vger.kernel.org>; Tue, 07 Jun 2022 03:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MiAAAW83mLXa/XieumqYwzb2WJ6w2BVEy/cOt5TPL88=;
        b=bkR68Wuh2VPtLFAUzrdZGpVgg9vltSXLKBc56tPSSxufh8lQTD7hrf658gIieYcWHp
         bIoVYegqboLhGU68Q3xuvSc70WZ03/6kMm34aL6p8QpJqZc8vpbQhKp0HF4XiQc7uuSq
         bdjOerEPfW+DbHiDMigQnXEjje0RsYAmjKVxnIcivIw/4+QjKNf5fTlt9ZPCvE/CEgPW
         yigx7TP8okWvkd0kEHrm+z9LKdhixWfblIDp5B0pJNRQIj62CoCK/4CQMkRJIm1DAlED
         jLyWsWP0T/NwUOniyhRerFCc8BPgNSXNGltvHSEEG+rY+nm1AwBjjnKcjgbQqmBhOzYm
         sycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MiAAAW83mLXa/XieumqYwzb2WJ6w2BVEy/cOt5TPL88=;
        b=WKqeyZMB9J4Jojz08XQpgG0nLIuliEatXIuVshS8sVrv4V7cBNVC8oLehamBrYs2jH
         0gCE+HA9Gj7l0zsV7Eq7NyarYMnUKkwkezzbqAH6Hsu/65EnHWCoAErg4Y+E0pYeLlqf
         NMOF2ixsXT1RVroWMNlQkYiEJINMm6mIzXb2HM5tO9pYH9EUCJfGW/9DL3/Kn06D301X
         Ss8rSH732Lgq1iWXuRoGAU8/mUwtHSlueyhwTvraOJD584/y2kSAxnVjbNFnksIoThIf
         dxugN1q6SnGu4zIJJjzwWouOi+U1Cx1ieL3RGbIvraAG+kOBwNaJBI3SH6UjTUIPKfoZ
         VpUw==
X-Gm-Message-State: AOAM531BymzXC/BlaDLoRbA0Wclb2hesPop0LdcgqsBkIX3AYNwB1Woz
        y9rM0YAjMRZ53owxS3qCeDxYNd5dgPNCsTnF7fs=
X-Google-Smtp-Source: ABdhPJxr+L4wquhPU8xtQnMrnZC3xtcgIwGO053QTcHBBUIq0xj3QhHXxVZAOd+9avBhBU/o9VPzGEeDtlLprZA3A0Y=
X-Received: by 2002:a05:6870:428b:b0:f5:e294:4352 with SMTP id
 y11-20020a056870428b00b000f5e2944352mr15944133oah.261.1654599376091; Tue, 07
 Jun 2022 03:56:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220607075425.39510-1-sluongng@gmail.com> <220607.86ilpcvp89.gmgdl@evledraar.gmail.com>
In-Reply-To: <220607.86ilpcvp89.gmgdl@evledraar.gmail.com>
From:   Son Luong Ngoc <sluongng@gmail.com>
Date:   Tue, 7 Jun 2022 12:56:05 +0200
Message-ID: <CAL3xRKev_KHvAFuviG7RxsxA_786K4QY5F08a8D23M9MLM81+g@mail.gmail.com>
Subject: Re: [PATCH] fsmonitor: query watchman with right valid json
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi =C3=86var,

On Tue, Jun 7, 2022 at 10:42 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Tue, Jun 07 2022, Son Luong Ngoc wrote:
>
> > In rare circumstances where the current git index does not carry the
> > last_update_token, the fsmonitor v2 hook will be invoked with an
> > empty string which would caused the final rendered json to be invalid.
> >
> >   ["query", "/path/to/my/git/repository/", {
> >           "since": ,
> >           "fields": ["name"],
> >           "expression": ["not", ["dirname", ".git"]]
> >   }]
> >
> > Which will left user with the following error message
> >
> >   > git status
> >   failed to parse command from stdin: line 2, column 13, position 67: u=
nexpected token near ','
> >   Watchman: command returned no output.
> >   Falling back to scanning...
> >
> > Hide the "since" field in json query when "last_update_token" is empty.
> >
> > Signed-off-by: Son Luong Ngoc <sluongng@gmail.com>
> > ---
> >  templates/hooks--fsmonitor-watchman.sample | 21 +++++++++++++--------
> >  1 file changed, 13 insertions(+), 8 deletions(-)
> >
> > diff --git a/templates/hooks--fsmonitor-watchman.sample b/templates/hoo=
ks--fsmonitor-watchman.sample
> > index 14ed0aa42d..b4ee86dfc4 100755
> > --- a/templates/hooks--fsmonitor-watchman.sample
> > +++ b/templates/hooks--fsmonitor-watchman.sample
> > @@ -79,6 +79,12 @@ sub watchman_query {
> >       or die "open2() failed: $!\n" .
> >       "Falling back to scanning...\n";
> >
> > +     my $query =3D <<" END";
> > +             ["query", "$git_work_tree", {
> > +                     "fields": ["name"],
> > +                     "expression": ["not", ["dirname", ".git"]]
> > +             }]
> > +     END
>
> Wouldn't a more minimal & obvious patch here be....
>
> >       # In the query expression below we're asking for names of files t=
hat
> >       # changed since $last_update_token but not from the .git folder.
> >       #
> > @@ -87,15 +93,14 @@ sub watchman_query {
> >       # output to file names only. Then we're using the "expression" te=
rm to
> >       # further constrain the results.
> >       if (substr($last_update_token, 0, 1) eq "c") {
> > -             $last_update_token =3D "\"$last_update_token\"";
>
> To just change this to be:
>
>         # same as now:
>         $last_update_token =3D "\"$last_update_token\"";
>         $last_update_line =3D qq["since": $last_update_token,];
>
> Of course having declared the new $last_update_line variable earlier, the=
n:
>

Yup, I think this is a sensible suggestion.
I will fixup and send a V2 shortly.

> > +             $query =3D <<"            END";
> > +                     ["query", "$git_work_tree", {
> > +                             "since": "$last_update_token",
> > +                             "fields": ["name"],
> > +                             "expression": ["not", ["dirname", ".git"]=
]
> > +                     }]
> > +             END
> >       }
> > -     my $query =3D <<" END";
> > -             ["query", "$git_work_tree", {
> > -                     "since": $last_update_token,
>
> Just change this line to:
>
>         $last_update_line
>
> I.e. you don't need to duplicate the whole query just to omit/include a
> single line in it, or am I missing something?
>
> (This suggestion *would* include a redundant line, but I'm assuming
> JSON/watchman deals with that just fine...).

I think we can remove that redundant line by adding '\n' before
$last_update_line.
I will be including this into the next version.

Thanks,
Son Luong.
