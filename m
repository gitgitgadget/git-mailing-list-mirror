Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD60C433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 04:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238053AbiBWEA4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 23:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbiBWEAy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 23:00:54 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51156654B9
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 20:00:27 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id bg10so49274650ejb.4
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 20:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GpQz8pY1G7g9xCIPmtb8E6yGZHHg6ZBqcD6Raascrx4=;
        b=UpM1Xe8rQGjkBpCQyCV0coj4YR2oqCfd/AacKT97zLwSja9JsmeLjzPs9x8sJfTTLe
         iI+QjmH+SnIIqugyljK0QxKGrSmsAIJ/5iEvXb39NHjE/qzj9DD+GfXAl36lGlNIt3ip
         cjfZNniC2c9RDzF0al24dM8xqKZhBUf6JVh7oSsPbnUogYsdIFLbysuopwJ0ziACS7US
         aEyQEGUdz5+2mt5SdPIshKbUabfSDGJ43m5vzGywh2L9mkCW2cksVEWILTRoi/Z645vR
         5IQeyICeveWTAiBaeqyy8xtD0yvWI/r4dev+TCUvmuiRO0ZcEKQ6ocu7NznI1OZK05jn
         lHsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GpQz8pY1G7g9xCIPmtb8E6yGZHHg6ZBqcD6Raascrx4=;
        b=2krYnvyzMkBd6PhURN9+0hXiccHb9yJobVBv/zLM0YmG3G1W3dfEm9gLpMKXbjfXB9
         VDFjRW3iyM2ZX0hdpWNkKdaBtszgDw6HW93YzZo+gmHcDD/QsYu5FplrB7ac75/hxIfl
         fvWqhRqZ8MQZOv1YRVshC/kzAhFADog/pkkSulZ1qWmeuJFxJ20MCz51LPn9bXTHKlF/
         hlbexpd/SXZd+xE9kyFqmJB48Gm8OBefGMCUnu8Viqs3ZISyBWgGRyqmGkOGInnarQgL
         HspOzQhQtC0UXxLqP34qdZAIvYrsSonbgwqfnSMs0Mak6b+0zEcwl7CnqsQxxu9o/sLg
         cX6w==
X-Gm-Message-State: AOAM531OypcCnqz0GV96dDTuAjFcLBQPhcpfPSBFJMpQ0vSMWTRXTxUj
        pQqtuHqOTdr718TX5a5CpMgKfkNJaGim60qVuyo=
X-Google-Smtp-Source: ABdhPJz5azL0ObPIXYXcjcyi8BdKiPfug1ooV9osp02m9ZmITNhodc599P6y+26L+QP9Tv8U/fuJpRld3MAtCJYfvrg=
X-Received: by 2002:a17:906:350d:b0:6b9:5871:8f34 with SMTP id
 r13-20020a170906350d00b006b958718f34mr21209991eja.493.1645588825790; Tue, 22
 Feb 2022 20:00:25 -0800 (PST)
MIME-Version: 1.0
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
 <35e0ed9271a0229fe2acd2385a7e4171d4dfe077.1642888562.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2201281744280.347@tvgsbejvaqbjf.bet> <CABPp-BG2rMEYBLuBW=0wtpJe4aUFGCFa8D0NTSKz9Sm+CkXPxw@mail.gmail.com>
 <0d7ba76c-9824-9953-b8ce-6abe810e2778@kdbg.org> <CABPp-BERtRDeyF3MhOQhAFwjoykOKwXoz6635NK7j2SEKp1b3A@mail.gmail.com>
 <nycvar.QRO.7.76.6.2202050009220.347@tvgsbejvaqbjf.bet> <CABPp-BGCL0onSmpgKuO1k2spYCkx=v27ed9TSSxFib=OdDcLbw@mail.gmail.com>
 <nycvar.QRO.7.76.6.2202211059430.26495@tvgsbejvaqbjf.bet> <220221.86y224b80b.gmgdl@evledraar.gmail.com>
In-Reply-To: <220221.86y224b80b.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 22 Feb 2022 20:00:14 -0800
Message-ID: <CABPp-BFc=hcWz1BMW7fAR=Zp3fQ3vxvBtnSYESreYwef_v1K5g@mail.gmail.com>
Subject: Re: machine-parsable git-merge-tree messages (was: [PATCH 08/12]
 merge-ort: provide a merge_get_conflicted_files() helper function)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 21, 2022 at 6:37 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Mon, Feb 21 2022, Johannes Schindelin wrote:
>
> [I sent out an empty reply to this earlier by mistake, sorry about that]
>
> > [...]
> > Which brings me to the next concern: since `merge-tree` is a low-level
> > tool meant to be called by programs rather than humans, we need to make
> > sure that those messages remain machine-parseable, even if they contain
> > file names.
> >
> > Concretely: while I am not currently aware of any web UI that allows to
> > resolve simple rename/rename conflicts, it is easily conceivable how to
> > implement such a thing. When that happens, we will need to be able to
> > teach the server-side code to discern between the cases that can be
> > handled in the web UI (trivial merge conflicts, trivial rename/rename
> > conflicts) as compared to scenarios where the conflicts are just too
> > complex.
> >
> > Here's an excerpt from t4301:
> >
> > -- snip --
> > Auto-merging greeting
> > CONFLICT (content): Merge conflict in greeting
> > Auto-merging numbers
> > CONFLICT (file/directory): directory in the way of whatever from side1;=
 moving it to whatever~side1 instead.
> > CONFLICT (modify/delete): whatever~side1 deleted in side2 and modified =
in side1.  Version side1 of whatever~side1 left in tree.
> > -- snap --
> >
> > This is the complete set of messages provided in the `test conflict
> > notices and such` test case.
> >
> > I immediately notice that every line contains at least one file name.
> > Looking at https://github.com/git/git/blob/v2.35.1/merge-ort.c#L1899, i=
t
> > does not seem as if the file names are quoted:
> >
> >               path_msg(opt, path, 1, _("Auto-merging %s"), path);
> >
> > (where `path` is used verbatim in a call to `merge_3way()` before that,
> > i.e. it must not have been quoted)
> >
> > I would like to register a wish to ensure that file names with special
> > characters (such as most notably line-feed characters) are quoted in th=
ese
> > messages, so that a simple server-side parser can handle messages start=
ing
> > with `Auto-merging` and with `CONFLICT (content): Merge conflict in `, =
and
> > "throw the hands up in the air" if any other message prefix is seen.
> >
> > Do you think we can switch to `sq_quote_buf_pretty()` for these message=
s?
> > For the `Auto-merging` one, it would be trivial, but I fear that we wil=
l
> > have to work a bit on the `path_msg()` function
> > (https://github.com/git/git/blob/v2.35.1/merge-ort.c#L630-L649) because=
 it
> > accepts a variable list of arguments without any clue whether the
> > arguments refer to paths or not. (And I would be loathe to switch _all_
> > callers to do the quoting themselves.)
> >
> > I see 28 calls to that function, and at least a couple that pass not on=
ly
> > a path but also an OID (e.g.
> > https://github.com/git/git/blob/v2.35.1/merge-ort.c#L1611-L1613).
> >
> > We could of course be sloppy and pass even OIDs through
> > `sq_quote_buf_pretty()` in `path_msg()`, knowing that there won't be an=
y
> > special characters in them, but it gets more complicated e.g. in
> > https://github.com/git/git/blob/v2.35.1/merge-ort.c#L1648-L1651, where =
we
> > pass an `strbuf` that contains a somewhat free-form commit message.
> >
> > I guess we could still pass those through `sq_quote_buf_pretty()`, even=
 if
> > they are not paths, to ensure that there are no special characters in t=
he
> > machine-parseable lines.
> >
> > What do you think?
>
> That sounds like a rather nasty hack, this is too, but demonstrates that
> we can pretty easily extract this in a machine-readable format with just
> a few lines now):
>
> diff --git a/merge-ort.c b/merge-ort.c
> index 8a5f201d190..a906881f9b3 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -633,7 +633,7 @@ static void path_msg(struct merge_options *opt,
>                      int omittable_hint, /* skippable under --remerge-dif=
f */
>                      const char *fmt, ...)
>  {
> -       va_list ap;
> +       va_list ap, cp;
>         struct strbuf *sb, *dest;
>         struct strbuf tmp =3D STRBUF_INIT;
>
> @@ -650,7 +650,9 @@ static void path_msg(struct merge_options *opt,
>
>         dest =3D (opt->record_conflict_msgs_as_headers ? &tmp : sb);
>
> +       va_copy(cp, ap);
>         va_start(ap, fmt);
> +
>         if (opt->priv->call_depth) {
>                 strbuf_addchars(dest, ' ', 2);
>                 strbuf_addstr(dest, "From inner merge:");
> @@ -659,6 +661,15 @@ static void path_msg(struct merge_options *opt,
>         strbuf_vaddf(dest, fmt, ap);
>         va_end(ap);
>
> +       va_start(cp, fmt);
> +       trace2_region_enter_printf("merge", "conflict/path", opt->repo, "=
%s", path);
> +       trace2_region_leave("merge", "conflict/path", opt->repo);
> +       trace2_region_enter_printf("merge", "conflict/fmt", opt->repo, "%=
s", fmt);
> +       trace2_region_leave("merge", "conflict/fmt", opt->repo);
> +       trace2_region_enter_printf_va("merge", "conflict/msg", opt->repo,=
 fmt, cp);
> +       trace2_region_leave("merge", "conflict/msg", opt->repo);
> +       va_end(cp);
> +
>         if (opt->record_conflict_msgs_as_headers) {
>                 int i_sb =3D 0, i_tmp =3D 0;
>
> You can run that with one of the tests added in this series to get the
> output as JSON, e.g.:
>
>      GIT_TRACE2_EVENT=3D/dev/stderr GIT_TRACE2_EVENT_NESTING=3D10 ~/g/git=
/git merge-tree --write-tree --no-messages --name-only --messages side1 sid=
e2 2>&1|jq -r .| grep '"msg"'
>       "msg": "whatever~side1"
>       "msg": "CONFLICT (file/directory): directory in the way of %s from =
%s; moving it to %s instead."
>       "msg": "CONFLICT (file/directory): directory in the way of whatever=
 from side1; moving it to whatever~side1 instead."
>       "msg": "whatever~side1"
>       "msg": "CONFLICT (modify/delete): %s deleted in %s and modified in =
%s.  Version %s of %s left in tree."
>       "msg": "CONFLICT (modify/delete): whatever~side1 deleted in side2 a=
nd modified in side1.  Version side1 of whatever~side1 left in tree."
>       "msg": "numbers"
>       "msg": "Auto-merging %s"
>       "msg": "Auto-merging numbers"
>       "msg": "greeting"
>       "msg": "Auto-merging %s"
>       "msg": "Auto-merging greeting"
>       "msg": "greeting"
>       "msg": "CONFLICT (%s): Merge conflict in %s"
>       "msg": "CONFLICT (content): Merge conflict in greeting"
>
> A "proper" fix for this doesn't sound too hard, we'd just instrument the
> path_msg() function to pass along some "message category", see
> e.g. unpack_plumbing_errors in unpack-trees.c for one example of such a
> thing, or the "enum fsck_msg_id".
>
> Then we'd just allow you to emit any of the sprintf() format itself, or
> the expanded version, the path, or an id like "CONFLICT:file/directory"
> or "auto-merging" etc.

I don't see how this helps solve the problem Dscho was bringing up at
all.  Your reference to "the path" means you've missed his whole
complaint -- that with more complex conflicts (renames, directory/file
conflicts resolved via moving the file out of the way, mode conflicts
resolved by moving both files out of the way, etc) there are multiple
paths involved and he's trying to determine what those paths are.
He's particularly focusing on rename/rename cases where a single path
was renamed differently by the two sides of history (which results in
a conflict message only being associated with the path from the merge
base in order to avoid repeating the same message 2-3 times, but that
one message has three distinct paths embedded in the string).

Also, the additional paths is not part of the API to path_msg; it's
merely embedded in a string.  (And, in case it bears repeating: as
mentioned elsewhere, we cannot assume there will only be one
path_msg() call per path, and we at least currently can't assume that
each path_msg() call is for a separate logical conflict; there might
be two for a single "conflict".)

I agree that parsing these meant-for-human-consumption (and not
promised to be stable) messages is not a good way to go, but
pretending the current API has enough info to answer his questions
isn't right either.

> I think that would be particularly useful in conjuction with the
> --format changes I was proposing for this (and hacked up a WIP patch
> for). You could just have a similar --format-messages or whatever.
>
> Then you could pick \0\0 as a delimiter for your "main" --format, and
> "\0" as the delimiter for your --format-messages, and thus be able to
> parse N-nested \0-delimited content.

To be honest, the --format stuff is sounding a little bit like a
solution in search of a problem.
