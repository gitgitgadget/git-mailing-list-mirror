Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C165C433EF
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 01:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345062AbiA1B2q (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 20:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241608AbiA1B2p (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 20:28:45 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2470BC061714
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 17:28:45 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id x11so8765634lfa.2
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 17:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KR5RA0drFT5zP/L9Ef6VHFBt29p7YFh2AlqPGV5YBU4=;
        b=OaxXMgjOs4cTQVMXWfkX6WVoQwKqd43989sQoIPYNCJK00PgXmZV7Bai8b/xEOZcBl
         wt0U89eFBpZdF/m8i2YyJLMpMGBfzQ1nXUkbRSWQAeTzsIe8o7vK4CGWYwVDk64D2LJD
         hE+KwKWUlu4myhWb3uS2FGdDfUh0uzRQJ0MDUojYJUsOAIn4zCbUGFfbT87Xhu8CebZZ
         eo8/AQUQzyZZ9+3+xb90+xipLNIQFHW8EsLUmgN8QAt0xrJ5dWHcnPGLhVCevek2IOIl
         kwRS77lBu9P/h2U6iKKGCUfARC+pu29XMtVKZZeQJYMw0VvDnNlwyHr72+O1YwGpDDCm
         B2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KR5RA0drFT5zP/L9Ef6VHFBt29p7YFh2AlqPGV5YBU4=;
        b=BZIUKoOH3gFJKKEQT5Csq8plcWMCBRb+odImiXmZgPeisRKPxSZNmCETbKFfPNHMNo
         pXp3oLNyDEo9NKMneX4xu2wSZtDsieeuSU8zNPlKNjO9/fUtyGx1XFToQXrvN9ha2tY3
         U0RAESTaT6UWMdjmW5kIheENnv7ZjVjvP697Ce6tBy+T3s7J8aALC121EGhEaWbl0ZoO
         IYrt9ZumMDvyOsHCautoBvLSTo5V6nlkptcJ89FBiithjVDHSp2iFavTo9dRU237INT3
         SfuG8bH29/Fj8WAHYWW0onfqrk2jGh9BQwV60uYYTiuXlb04wuL8iJyd+cpJzyhEBiod
         B9HQ==
X-Gm-Message-State: AOAM533oF2XpmUYrp2KziglzOOXpvomd3v2SITm9yfSy9ncQSH+4Q33v
        cXEpvV/4LSKI5M39K7qtHg0CprDOdL1fZAMWBVY=
X-Google-Smtp-Source: ABdhPJwaOltZB9PYrM73svAPazCAntBAVmC3jRp9AwUYiDGPdsNkN2JYDD0KelaAvtCes/uYOUyVZ3kfENTJwvTg4MI=
X-Received: by 2002:a05:6512:110c:: with SMTP id l12mr4650202lfg.120.1643333322781;
 Thu, 27 Jan 2022 17:28:42 -0800 (PST)
MIME-Version: 1.0
References: <pull.1093.git.1638588503.gitgitgadget@gmail.com>
 <pull.1093.v2.git.1638845211.gitgitgadget@gmail.com> <ff80a94bf9add8a6fabcd5146e5177edf5e35e49.1638845211.git.gitgitgadget@gmail.com>
 <211207.86wnkgo9fv.gmgdl@evledraar.gmail.com> <CANQDOdfX2KaosPwLM4hS4rp+FH9V7VUxUh_md43FfZ9NG4iroQ@mail.gmail.com>
 <211208.86ee6nmme5.gmgdl@evledraar.gmail.com> <CANQDOddkKbUC-g97JOf40nS28Yv1KACvbjW9gtQZemfBMutPCw@mail.gmail.com>
 <211209.86bl1ql718.gmgdl@evledraar.gmail.com> <CANQDOdchh3mfC8S6ouWAQbtWzZUkmTzF1p5D9dg4muoBu4N1Fg@mail.gmail.com>
 <220119.8635ljoidt.gmgdl@evledraar.gmail.com>
In-Reply-To: <220119.8635ljoidt.gmgdl@evledraar.gmail.com>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Thu, 27 Jan 2022 20:28:31 -0500
Message-ID: <CANQDOdep6VAGbK-Wh+MFOCHV4pgxgCU55=KV5Jux26=OZKfWfw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] core.fsync: introduce granular fsync control
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Neeraj Singh <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 19, 2022 at 10:27 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Wed, Dec 08 2021, Neeraj Singh wrote:
>
> [Sorry about the late reply, and thanks for the downthread prodding]

I also apologize for the late reply here.  I've been dealing with a
hospitalized parent this week.

>
> > On Wed, Dec 8, 2021 at 8:46 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:
> >>
> >>
> >> On Wed, Dec 08 2021, Neeraj Singh wrote:
> >>
> >> > On Wed, Dec 8, 2021 at 2:17 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmaso=
n <avarab@gmail.com> wrote:
> >> >>
> >> >>
> >> >> On Tue, Dec 07 2021, Neeraj Singh wrote:
> >> >>
> >> >> > On Tue, Dec 7, 2021 at 5:01 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarm=
ason <avarab@gmail.com> wrote:
> >> >> >>
> >> >> >>
> >> >> >> On Tue, Dec 07 2021, Neeraj Singh via GitGitGadget wrote:
> >> >> >>
> >> >> >> > From: Neeraj Singh <neerajsi@microsoft.com>
> >> >> >> >
> >> >> >> > This commit introduces the `core.fsync` configuration
> >> >> >> > knob which can be used to control how components of the
> >> >> >> > repository are made durable on disk.
> >> >> >> >
> >> >> >> > This setting allows future extensibility of the list of
> >> >> >> > syncable components:
> >> >> >> > * We issue a warning rather than an error for unrecognized
> >> >> >> >   components, so new configs can be used with old Git versions=
.
> >> >> >>
> >> >> >> Looks good!
> >> >> >>
> >> >> >> > * We support negation, so users can choose one of the default
> >> >> >> >   aggregate options and then remove components that they don't
> >> >> >> >   want. The user would then harden any new components added in
> >> >> >> >   a Git version update.
> >> >> >>
> >> >> >> I think this config schema makes sense, but just a (I think impo=
rtant)
> >> >> >> comment on the "how" not "what" of it. It's really much better t=
o define
> >> >> >> config as:
> >> >> >>
> >> >> >>     [some]
> >> >> >>     key =3D value
> >> >> >>     key =3D value2
> >> >> >>
> >> >> >> Than:
> >> >> >>
> >> >> >>     [some]
> >> >> >>     key =3D value,value2
> >> >> >>
> >> >> >> The reason is that "git config" has good support for working wit=
h
> >> >> >> multi-valued stuff, so you can do e.g.:
> >> >> >>
> >> >> >>     git config --get-all -z some.key
> >> >> >>
> >> >> >> And you can easily (re)set such config e.g. with --replace-all e=
tc., but
> >> >> >> for comma-delimited you (and users) need to do all that work the=
mselves.
> >> >> >>
> >> >> >> Similarly instead of:
> >> >> >>
> >> >> >>     some.key =3D want-this
> >> >> >>     some.key =3D -not-this
> >> >> >>     some.key =3D but-want-this
> >> >> >>
> >> >> >> I think it's better to just have two lists, one inclusive anothe=
r
> >> >> >> exclusive. E.g. see "log.decorate" and "log.excludeDecoration",
> >> >> >> "transfer.hideRefs"
> >> >> >>
> >> >> >> Which would mean:
> >> >> >>
> >> >> >>     core.fsync =3D want-this
> >> >> >>     core.fsyncExcludes =3D -not-this
> >> >> >>
> >> >> >> For some value of "fsyncExcludes", maybe "noFsync"? Anyway, just=
 a
> >> >> >> suggestion on making this easier for users & the implementation.
> >> >> >>
> >> >> >
> >> >> > Maybe there's some way to handle this I'm unaware of, but a
> >> >> > disadvantage of your multi-valued config proposal is that it's ha=
rder,
> >> >> > for example, for a per-repo config store to reasonably override a
> >> >> > per-user config store.  With the configuration scheme as-is, I ca=
n
> >> >> > have a per-user setting like `core.fsync=3Dall` which covers my t=
ypical
> >> >> > repos, but then have a maintainer repo with a private setting of
> >> >> > `core.fsync=3Dnone` to speed up cases where I'm mostly working wi=
th
> >> >> > other people's changes that are backed up in email or server-side
> >> >> > repos.  The latter setting conveniently overrides the former sett=
ing
> >> >> > in all aspects.
> >> >>
> >> >> Even if you turn just your comma-delimited proposal into a list pro=
posal
> >> >> can't we just say that the last one wins? Then it won't matter what=
 cmae
> >> >> before, you'd specify "core.fsync=3Dnone" in your local .git/config=
.
> >> >>
> >> >> But this is also a general issue with a bunch of things in git's co=
nfig
> >> >> space. I'd rather see us use the list-based values and just come up=
 with
> >> >> some general way to reset them that works for all keys, rather than
> >> >> regretting having comma-delimited values that'll be harder to work =
with
> >> >> & parse, which will be a legacy wart if/when we come up with a way =
to
> >> >> say "reset all previous settings".
> >> >>
> >> >> > Also, with the core.fsync and core.fsyncExcludes, how would you s=
pell
> >> >> > "don't sync anything"? Would you still have the aggregate options=
.?
> >> >>
> >> >>     core.fsyncExcludes =3D *
> >> >>
> >> >> I.e. the same as the core.fsync=3Dnone above, anyway I still like t=
he
> >> >> wildcard thing below a bit more...
> >> >
> >> > I'm not going to take this feedback unless there are additional vote=
s
> >> > from the Git community in this direction.  I make the claim that
> >> > single-valued comma-separated config lists are easier to work with i=
n
> >> > the existing Git infrastructure.
> >>
> >> Easier in what sense? I showed examples of how "git-config" trivially
> >> works with multi-valued config, but for comma-delimited you'll need to
> >> write your own shellscript boilerplate around simple things like addin=
g
> >> values, removing existing ones etc.
> >>
> >> I.e. you can use --add, --unset, --unset-all, --get, --get-all etc.
> >>
> >
> > I see what you're saying for cases where someone would want to set a
> > core.fsync setting that's derived from the user's current config.  But
> > I'm guessing that the dominant use case is someone setting a new fsync
> > configuration that achieves some atomic goal with respect to a given
> > repository. Like "this is a throwaway, so sync nothing" or "this is
> > really important, so sync all objects and refs and the index".
>
> Whether it's multi-value or comma-separated you could do:
>
>     -c core.fsync=3D[none|false]
>
> To sync nothing, i.e. if we see "none/false" it doesn't matter if we saw
> core.fsync=3Dloose-object or whatever before, it would override it, ditto
> for "all".
>
> >> > parsing code for the core.whitespace variable and users are used to
> >> > this syntax there. There are several other comma-separated lists in
> >> > the config space, so this construct has precedence and will be with
> >> > Git for some time.
> >>
> >> That's not really an argument either way for why we'd pick X over Y fo=
r
> >> something new. We've got some comma-delimited, some multi-value (I'm
> >> fairly sure we have more multi-value).
> >>
> >
> > My main point here is that there's precedent for patch's current exact
> > schema for a config in the same core config leaf of the Documentation.
> > It seems from your comments that we'd have to invent and document some
> > new convention for "reset" of a multi-valued config.  So you're
> > suggesting that I solve an extra set of problems to get this change
> > in.  Just want to remind you that my personal itch to scratch is to
> > get the underlying mechanism in so that git-for-windows can set its
> > default setting to batch mode. I'm not expecting many users to
> > actually configure this setting to any non-default value.
>
> Me neither. I think people will most likely set this once in
> ~/.gitconfig or /etc/gitconfig.
>
> We have some config keys that are multi-value and either comma-separated
> or space-separated, e.g. core.alternateRefsPrefixes
>
> Then we have e.g. blame.ignoreRevsFile which is multi-value, and further
> has the convention that setting it to an empty value clears the
> list. which would scratch the "override existing" itch.
>
> format.notes, versionsort.suffix, transfer.hideRefs, branch.<name>.merge
> are exmples of existing multi-value config.
>

Thanks for the examples.  I can see the benefit of mutli-value for
most of those settings, but for versionsort.suffix, I'd personally
have wanted a comma-separated list.

> >> > Also, fsync configurations aren't composable like
> >> > some other configurations may be. It makes sense to have a holistic
> >> > singular fsync configuration, which is best represented by a single
> >> > variable.
> >>
> >> What's a "variable" here? We call these "keys", you can have a
> >> single-value key like user.name that you get with --get, or a
> >> multi-value key like say branch.<name>.merge or push.pushOption that
> >> you'd get with --get-all.
> >
> > Yeah, I meant "key".  I conflated the config key with the underlying
> > global variable in git.
>
> *nod*
>
> >> I think you may be referring to either not wanting these to be
> >> "inherited" (which is not really a think we do for anything else in
> >> config), or lacking the ability to "reset".
> >>
> >> For the latter if that's absolutely needed we could just use the same
> >> trick as "diff.wsErrorHighlight" uses of making an empty value "reset"
> >> the list, and you'd get better "git config" support for editing it.
> >>
> >
> > My reading of the code is that diff.wsErrorHighlight is a comma
> > separated list and not a multi-valued config.  Actually I haven't yet
> > found an existing multi-valued config (not sure how to grep for it).
>
> Yes, I think I conflated it with one of the ones above when I wrote
> this.
>
> >> >> >> > This also supports the common request of doing absolutely no
> >> >> >> > fysncing with the `core.fsync=3Dnone` value, which is expected
> >> >> >> > to make the test suite faster.
> >> >> >>
> >> >> >> Let's just use the git_parse_maybe_bool() or git_parse_maybe_boo=
l_text()
> >> >> >> so we'll accept "false", "off", "no" like most other such config=
?
> >> >> >
> >> >> > Junio's previous feedback when discussing batch mode [1] was to o=
ffer
> >> >> > less flexibility when parsing new values of these configuration
> >> >> > options. I agree with his statement that "making machine-readable
> >> >> > tokens be spelled in different ways is a 'disease'."  I'd like to
> >> >> > leave this as-is so that the documentation can clearly state the =
exact
> >> >> > set of allowable values.
> >> >> >
> >> >> > [1] https://lore.kernel.org/git/xmqqr1dqzyl7.fsf@gitster.g/
> >> >>
> >> >> I think he's talking about batch, Batch, BATCH, bAtCh etc. there. B=
ut
> >> >> the "maybe bool" is a stanard pattern we use.
> >> >>
> >> >> I don't think we'd call one of these 0, off, no or false etc. to av=
oid
> >> >> confusion, so then you can use git_parse_maybe_...()
> >> >
> >> > I don't see the advantage of having multiple ways of specifying
> >> > "none".  The user can read the doc and know exactly what to write.  =
If
> >> > they write something unallowable, they get a clear warning and they
> >> > can read the doc again to figure out what to write.  This isn't a
> >> > boolean options at all, so why should we entertain bool-like ways of
> >> > spelling it?
> >>
> >> It's not boolean, it's multi-value and one of the values includes a tr=
ue
> >> or false boolean value. You just spell it "none".
> >>
> >> I think both this and your comment above suggest that you think there'=
s
> >> no point in this because you haven't interacted with/used "git config"
> >> as a command line or API mechanism, but have just hand-crafted config
> >> files.
> >>
> >> That's fair enough, but there's a lot of tooling that benefits from th=
e
> >> latter.
> >
> > My batch mode perf tests (on github, not yet submitted to the list)
> > use `git -c core.fsync=3D<foo>` to set up a per-process config.  I
> > haven't used the `git config` writing support in a while, so I haven't
> > deeply thought about that.  However, I favor simplifying the use case
> > of "atomically" setting a new holistic core.fsync value versus the use
> > case of deriving a new core.fsync value from the preexisting value.
>
> If you implement it like blame.ignoreRevsFile you can have your cake and
> eat it too, i.e.:
>
>     -c core.fsync=3D core.fsync=3Dloose-object
>
> ensures only loose objects are synced, as with your single-value config,
> but I'd think what you'd be more likely to actually mean would be:
>
>     # With "core.fsync=3Dpack" set in ~/.gitconfig
>     -c core.fsync=3Dloose-object
>
> I.e. that the common case is "I want this to be synced here", not that
> you'd like to declare sync policy from scratch every time.
>
> In any case, on this general topic my main point is that the
> git-config(1) command has pretty integration for multi-value if you do
> it that way, and not for comma-delimited. I.e. you get --add, --unset,
> --unset-all, --get, --get-all etc.
>
> So I think for anything new it makes sense to lean into that, I think
> most of these existing comma-delimited ones are ones we'd do differently
> today on reflection.
>
> And if you suppor the "empty resets" like blame.ignoreRevsFile it seems
> to me you'll have your cake & eat it too.
>

I really don't like the multiple `-c core.fsync=3D` clauses.  If I want
to do packs and loose-objects as a single config, I'd have to do:
        * multi-value: `git -c core.fsync=3D -c core.fsync=3Dpack -c
core.fsync=3Dloose-object`
        * comma-sep `git -c core.fsync=3Dpack,loose-object`

Multi-valued configs are stateful and more verbose to configure.
Last-one-wins with comma-separated values has an advantage for
achieving a desired final configuration without regard for the
previous configuration, which is the way I expect the feature to be
used.

> >> E.g.:
> >>
> >>     $ git -c core.fsync=3Doff config --type=3Dbool core.fsync
> >>     false
> >>     $ git -c core.fsync=3Dblah config --type=3Dbool core.fsync
> >>     fatal: bad boolean config value 'blah' for 'core.fsync'
> >>
> >> Here we can get 'git config' to normalize what you call 'none', and yo=
u
> >> can tell via exit codes/normalization if it's "false". But if you inve=
nt
> >> a new term for "false" you can't do that as easily.
> >>
> >> We have various historical keys that take odd exceptions to that,
> >> e.g. "never", but unless we have a good reason to let's not invent mor=
e
> >> exceptions.
> >>
> >> >> >> > Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
> >> >> >> > ---
> >> >> >> >  Documentation/config/core.txt | 27 +++++++++----
> >> >> >> >  builtin/fast-import.c         |  2 +-
> >> >> >> >  builtin/index-pack.c          |  4 +-
> >> >> >> >  builtin/pack-objects.c        |  8 ++--
> >> >> >> >  bulk-checkin.c                |  5 ++-
> >> >> >> >  cache.h                       | 39 +++++++++++++++++-
> >> >> >> >  commit-graph.c                |  3 +-
> >> >> >> >  config.c                      | 76 ++++++++++++++++++++++++++=
++++++++-
> >> >> >> >  csum-file.c                   |  5 ++-
> >> >> >> >  csum-file.h                   |  3 +-
> >> >> >> >  environment.c                 |  1 +
> >> >> >> >  midx.c                        |  3 +-
> >> >> >> >  object-file.c                 |  3 +-
> >> >> >> >  pack-bitmap-write.c           |  3 +-
> >> >> >> >  pack-write.c                  | 13 +++---
> >> >> >> >  read-cache.c                  |  2 +-
> >> >> >> >  16 files changed, 164 insertions(+), 33 deletions(-)
> >> >> >> >
> >> >> >> > diff --git a/Documentation/config/core.txt b/Documentation/con=
fig/core.txt
> >> >> >> > index dbb134f7136..4f1747ec871 100644
> >> >> >> > --- a/Documentation/config/core.txt
> >> >> >> > +++ b/Documentation/config/core.txt
> >> >> >> > @@ -547,6 +547,25 @@ core.whitespace::
> >> >> >> >    is relevant for `indent-with-non-tab` and when Git fixes `t=
ab-in-indent`
> >> >> >> >    errors. The default tab width is 8. Allowed values are 1 to=
 63.
> >> >> >> >
> >> >> >> > +core.fsync::
> >> >> >> > +     A comma-separated list of parts of the repository which =
should be
> >> >> >> > +     hardened via the core.fsyncMethod when created or modifi=
ed. You can
> >> >> >> > +     disable hardening of any component by prefixing it with =
a '-'. Later
> >> >> >> > +     items take precedence over earlier ones in the list. For=
 example,
> >> >> >> > +     `core.fsync=3Dall,-pack-metadata` means "harden everythi=
ng except pack
> >> >> >> > +     metadata." Items that are not hardened may be lost in th=
e event of an
> >> >> >> > +     unclean system shutdown.
> >> >> >> > ++
> >> >> >> > +* `none` disables fsync completely. This must be specified al=
one.
> >> >> >> > +* `loose-object` hardens objects added to the repo in loose-o=
bject form.
> >> >> >> > +* `pack` hardens objects added to the repo in packfile form.
> >> >> >> > +* `pack-metadata` hardens packfile bitmaps and indexes.
> >> >> >> > +* `commit-graph` hardens the commit graph file.
> >> >> >> > +* `objects` is an aggregate option that includes `loose-objec=
ts`, `pack`,
> >> >> >> > +  `pack-metadata`, and `commit-graph`.
> >> >> >> > +* `default` is an aggregate option that is equivalent to `obj=
ects,-loose-object`
> >> >> >> > +* `all` is an aggregate option that syncs all individual comp=
onents above.
> >> >> >> > +
> >> >> >>
> >> >> >> It's probably a *bit* more work to set up, but I wonder if this =
wouldn't
> >> >> >> be simpler if we just said (and this is partially going against =
what I
> >> >> >> noted above):
> >> >> >>
> >> >> >> =3D=3D BEGIN DOC
> >> >> >>
> >> >> >> core.fsync is a multi-value config variable where each item is a
> >> >> >> pathspec that'll get matched the same way as 'git-ls-files' et a=
l.
> >> >> >>
> >> >> >> When we sync pretend that a path like .git/objects/de/adbeef... =
is
> >> >> >> relative to the top-level of the git
> >> >> >> directory. E.g. "objects/de/adbeaf.." or "objects/pack/...".
> >> >> >>
> >> >> >> You can then supply a list of wildcards and exclusions to config=
ure
> >> >> >> syncing.  or "false", "off" etc. to turn it off. These are synon=
ymous
> >> >> >> with:
> >> >> >>
> >> >> >>     ; same as "false"
> >> >> >>     core.fsync =3D ":!*"
> >> >> >>
> >> >> >> Or:
> >> >> >>
> >> >> >>     ; same as "true"
> >> >> >>     core.fsync =3D "*"
> >> >> >>
> >> >> >> Or, to selectively sync some things and not others:
> >> >> >>
> >> >> >>     ;; Sync objects, but not "info"
> >> >> >>     core.fsync =3D ":!objects/info/**"
> >> >> >>     core.fsync =3D "objects/**"
> >> >> >>
> >> >> >> See gitrepository-layout(5) for details about what sort of paths=
 you
> >> >> >> might be expected to match. Not all paths listed there will go t=
hrough
> >> >> >> this mechanism (e.g. currently objects do, but nothing to do wit=
h config
> >> >> >> does).
> >> >> >>
> >> >> >> We can and will match this against "fake paths", e.g. when writi=
ng out
> >> >> >> packs we may match against just the string "objects/pack", we're=
 not
> >> >> >> going to re-check if every packfile we're writing matches your g=
lobs,
> >> >> >> ditto for loose objects. Be reasonable!
> >> >> >>
> >> >> >> This metharism is intended as a shorthand that provides some fle=
xibility
> >> >> >> when fsyncing, while not forcing git to come up with labels for =
all
> >> >> >> paths the git dir, or to support crazyness like "objects/de/adbe=
ef*"
> >> >> >>
> >> >> >> More paths may be added or removed in the future, and we make no
> >> >> >> promises that we won't move things around, so if in doubt use
> >> >> >> e.g. "true" or a wide pattern match like "objects/**". When in d=
oubt
> >> >> >> stick to the golden path of examples provided in this documentat=
ion.
> >> >> >>
> >> >> >> =3D=3D END DOC
> >> >> >>
> >> >> >>
> >> >> >> It's a tad more complex to set up, but I wonder if that isn't wo=
rth
> >> >> >> it. It nicely gets around any current and future issues of decid=
ing what
> >> >> >> labels such as "loose-object" etc. to pick, as well as slotting =
into an
> >> >> >> existing method of doing exclude/include lists.
> >> >> >>
> >> >> >
> >> >> > I think this proposal is a lot of complexity to avoid coming up w=
ith a
> >> >> > new name for syncable things as they are added to Git.  A path ba=
sed
> >> >> > mechanism makes it hard to document for the (advanced) user what =
the
> >> >> > full set of things is and how it might change from release to rel=
ease.
> >> >> > I think the current core.fsync scheme is a bit easier to understa=
nd,
> >> >> > query, and extend.
> >> >>
> >> >> We document it in gitrepository-layout(5). Yeah it has some
> >> >> disadvantages, but one advantage is that you could make the
> >> >> composability easy. I.e. if last exclude wins then a setting of:
> >> >>
> >> >>     core.fsync =3D ":!*"
> >> >>     core.fsync =3D "objects/**"
> >> >>
> >> >> Would reset all previous matches & only match objects/**.
> >> >>
> >> >
> >> > The value of changing this is predicated on taking your previous
> >> > multi-valued config proposal, which I'm still not at all convinced
> >> > about.
> >>
> >> They're orthagonal. I.e. you get benefits from multi-value with or
> >> without this globbing mechanism.
> >>
> >> In any case, I don't feel strongly about/am really advocating this
> >> globbing mechanism. I just wondered if it wouldn't make things simpler
> >> since it would sidestep the need to create any sort of categories for
> >> subsets of gitrepository-layout(5), but maybe not...
> >>
> >> > The schema in the current (v1-v2) version of the patch already
> >> > includes an example of extending the list of syncable things, and
> >> > Patrick Steinhardt made it clear that he feels comfortable adding
> >> > 'refs' to the same schema in a future change.
> >> >
> >> > I'll also emphasize that we're talking about a non-functional,
> >> > relatively corner-case behavioral configuration.  These values don't
> >> > change how git's interface behaves except when the system crashes
> >> > during a git command or shortly after one completes.
> >>
> >> That may be something some OS's promise, but it's not something fsync(=
)
> >> or POSIX promises. I.e. you might write a ref, but unless you fsync an=
d
> >> the relevant dir entries another process might not see the update, cra=
sh
> >> or not.
> >>
> >
> > I haven't seen any indication that POSIX requires an fsync for
> > visiblity within a running system.  I looked at the doc for open,
> > write, and fsync, and saw no indication that it's posix compliant to
> > require an fsync for visibility.  I think an OS that required fsync
> > for cross-process visiblity would fail to run Git for a myriad of
> > other reasons and would likely lose all its users.  I'm curious where
> > you've seen documentation that allows such unhelpful behavior?
>
> There's multiple unrelated and related things in this area. One is a
> case where you'll e.g. write a file "foo" using stdio, spawn a program
> to work on it in the same program, but it might not see it at all, or
> see empty content, the latter being because you haven't flushed your I/O
> buffers (which you can do via fsync()).
>

For stdio you need to use fflush(3), which just flushes the C
runtime's internal buffers.  You need to do the following to do a full
durable write using stdio:
```
FILE *fp;
...
fflush(fp);
fsync(fileno(fp))
```

> The former is that on *nix systems you're generally only guaranteed to
> write to a fd, but not to have the associated metadata be synced for
> you.
>
> That is spelled out e.g. in the DESCRIPTION section of linux's fsync()
> manpage: https://man7.org/linux/man-pages/man2/fdatasync.2.html
>
> I don't know how much you follow non-Windows FS development, but there
> was also a very well known "incident" early in ext4 where it leaned into
> some permissive-by-POSIX behavior that caused data loss in practice on
> buggy programs that didn't correctly use fsync() , since various tooling
> had come to expect the stricter behavior of ext3:
> https://lwn.net/Articles/328363/
>
> That was explicitly in the area of fs metadata being discussed here.
>
> Generally you can expect your VFS layer to be forgiving when it comes to
> IPC, but even that is out the window when it comes to networked
> filesystems, e.g. a shared git repository hosted on NFS.
>

Everything in the fsync(2) DESCRIPTION section is about what data and
metadata reaches the disk (versus just being cached in-memory).  I've
become a bit familiar with the ext3 vs ext4 (and delayed alloc)
behavior while researching this feature.  These behaviors are all
around the durability you get in the case of kernel crash,
power-failure, or other forms of dirty dismount.

NFS is a complex story.  I'm not intimately familiar with its
particular pitfalls, but from looking at the Linux NFS faq
(http://nfs.sourceforge.net/), it appears that a given single NFS
client will remain coherent with itself. Multiple NFS clients
accessing a single Git repo concurrently are probably going to see
some inconsistency.  In that kind of case, fsync would help, perhaps,
since it would force NFS clients to issue a COMMIT command to the
server.

> >> That's an aside from these config design questions, and I think
> >> most/(all?) OS's anyone cares about these days tend to make that
> >> implicit promise as part of their VFS behavior, but we should probably
> >> design such an interface to fsync() with such pedantic portability in
> >> mind.
> >
> > Why? To be rude to such a hypothetical system, if a system were so
> > insanely designed, it would be nuts to support it.
>
> Because we know that right now the system calls we're invoking aren't
> guaranteed to store data persistently to disk portably, although they do
> so in practice on most modern OS's.
>
> We're portably to a lot of platforms, and also need to keep e.g. NFS in
> mind, so being able to ask for a pedantic mode when you care about data
> retention at the cost of performance would be nice.
>
> And because the fsync config mode you're proposing is thoroughly
> non-standard, but is known to me much faster by leaning into known
> attributes of specific FS's on specific OS's, if we're not running on
> those it would be sensible to fall back to a stricter mode of
> operation. E.g. syncing all 100 loose objects we just wrote, not just
> the last one.
>
> >> > While you may not personally love the proposed configuration
> >> > interface, I'd want your view on some questions:
> >> > 1. Is it easy for the (advanced) user to set a configuration?
> >> > 2. Is it easy for the (advanced) user to see what was configured?
> >> > 3. Is it easy for the Git community to build on this as we want to a=
dd
> >> > things to the list of things to sync?
> >> >     a) Is there a good best practice configuration so that people ca=
n
> >> > avoid losing integrity for new stuff that they are intending to sync=
.
> >> >     b) If someone has a custom configuration, can that custom
> >> > configuration do something reasonable as they upgrade versions of Gi=
t?
> >> >              ** In response to this question, I might see some value
> >> > in adding a 'derived-metadata' aggregate that can be disabled so tha=
t
> >> > a custom configuration can exclude those as they change version to
> >> > version.
> >> >     c) Is it too much maintenance overhead to consider how to presen=
t
> >> > this configuration knob for any new hashfile or other datafile in th=
e
> >> > git repo?
> >> > 4. Is there a good path forward to change the default syncable set,
> >> > both in git-for-windows and in Git for other platforms?
> >>
> >> I'm not really sure this globbing this is a good idea, as noted above
> >> just a suggestion etc.
> >>
> >> As noted there it just gets you out of the business of re-defining
> >> gitrepository-layout(5), and assuming too much in advance about certai=
n
> >> use-cases.
> >>
> >> E.g. even "refs" might be too broad for some. I don't tend to be I/O
> >> limited, but I could see how someone who would be would care about
> >> refs/heads but not refs/remotes, or want to exclude logs/* but not the
> >> refs updates themselves etc.
> >
> > This use-case is interesting (distinguishing remote refs from local
> > refs).  I think the difficulty of verifying (for even an advanced
> > user) that the right fsyncing is actually happening still puts me on
> > the side of having a carefully curated and documented set of syncable
> > things rather than a file-path-based mechanism.
> >
> > Is this meaningful in the presumably nearby future world of the refsdb
> > backend?  Is that somehow split by remote versus local?
>
> There is the upcoming "reftable" work, but that's probably 2-3 years out
> at the earliest for series production workloads in git.git.
>
> >> >> >> > diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> >> >> >> > index 857be7826f3..916c55d6ce9 100644
> >> >> >> > --- a/builtin/pack-objects.c
> >> >> >> > +++ b/builtin/pack-objects.c
> >> >> >> > @@ -1204,11 +1204,13 @@ static void write_pack_file(void)
> >> >> >> >                * If so, rewrite it like in fast-import
> >> >> >> >                */
> >> >> >> >               if (pack_to_stdout) {
> >> >> >> > -                     finalize_hashfile(f, hash, CSUM_HASH_IN_=
STREAM | CSUM_CLOSE);
> >> >> >> > +                     finalize_hashfile(f, hash, FSYNC_COMPONE=
NT_NONE,
> >> >> >> > +                                       CSUM_HASH_IN_STREAM | =
CSUM_CLOSE);
> >> >> >>
> >> >> >> Not really related to this per-se, but since you're touching the=
 API
> >> >> >> everything goes through I wonder if callers should just always t=
ry to
> >> >> >> fsync, and we can just catch EROFS and EINVAL in the wrapper if =
someone
> >> >> >> tries to flush stdout, or catch the fd at that lower level.
> >> >> >>
> >> >> >> Or maybe there's a good reason for this...
> >> >> >
> >> >> > It's platform dependent, but I'd expect fsync would do something =
for
> >> >> > pipes or stdout redirected to a file.  In these cases we really d=
on't
> >> >> > want to fsync since we have no idea what we're talking to and we'=
re
> >> >> > potentially worsening performance for probably no benefit.
> >> >>
> >> >> Yeah maybe we should just leave it be.
> >> >>
> >> >> I'd think the C library returning EINVAL would be a trivial perform=
ance
> >> >> cost though.
> >> >>
> >> >> It just seemed odd to hardcode assumptions about what can and can't=
 be
> >> >> synced when the POSIX defined function will also tell us that.
> >> >>
> >> >
> >> > Redirecting stdout to a file seems like a common usage for this
> >> > command. That would definitely be fsyncable, but Git has no idea wha=
t
> >> > its proper category is since there's no way to know the purpose or
> >> > lifetime of the packfile.  I'm going to leave this be, because I'd
> >> > posit that "can it be fsynced?" is not the same as "should it be
> >> > fsynced?".  The latter question can't be answered for stdout.
> >>
> >> As noted this was just an aside, and I don't even know if any OS would
> >> do anything meaningful with an fsync() of such a FD anyway.
> >>
> >
> > The underlying fsync primitive does have a meaning on Windows for
> > pipes, but it's certainly not what Git would want to do. Also if
> > stdout is redirected to a file, I'm pretty sure that UNIX OSes would
> > respect the fsync call.  However it's not meaningful in the sense of
> > the git repository, since we don't know what the packfile is or why it
> > was created.
>
> I suggested that because I think it's probably nonsensical, but it's
> nonsense that POSIX seems to explicitly tell us that it'll handle
> (probably by silently doing nothing). So in terms of our interface we
> could lean into that and avoid our own special-casing.
>
> >> I just don't see why we wouldn't say:
> >>
> >>  1. We're syncing this category of thing
> >>  2. Try it
> >>  3. If fsync returns "can't fsync that sort of thing" move on
> >>
> >> As opposed to trying to shortcut #3 by doing the detection ourselves.
> >>
> >> I.e. maybe there was a good reason, but it seemed to be some easy
> >> potential win for more simplification, since you were re-doing and
> >> simplifying some of the interface anyway...
> >
> > We're trying to be deliberate about what we're fsyncing.  Fsyncing an
> > unknown file created by the packfile code doesn't move us in that
> > direction.  In your taxonomy we don't know (1), "what is this category
> > of thing?"  Sure it's got the packfile format, but is not known to be
> > an actual packfile that's part of the repository.
>
> We know it's a fd, isn't that sufficient? In any case, I'm fine with
> also keeping it as is, I don't mean to split hairs here.
>
> It just stuck out as an odd part of the interface, why treat some fd's
> specially, instead of just throwing it all at the OS. Presumably the
> first thing the OS will do is figure out if it's a syncable fd or not,
> and act appropriately.
>

I'll put the following comment in pack-objects.c:
/*
* We never fsync when writing to stdout since we may
* not be writing to a specific file. For instance, the
* upload-pack code passes a pipe here. Calling fsync
* on a pipe results in unnecessary synchronization with
* the reader on some platforms.
*/

> >> >>
> >> >> >> > [...]
> >> >> >> > +/*
> >> >> >> > + * These values are used to help identify parts of a reposito=
ry to fsync.
> >> >> >> > + * FSYNC_COMPONENT_NONE identifies data that will not be a pe=
rsistent part of the
> >> >> >> > + * repository and so shouldn't be fsynced.
> >> >> >> > + */
> >> >> >> > +enum fsync_component {
> >> >> >> > +     FSYNC_COMPONENT_NONE                    =3D 0,
> >> >> >>
> >> >> >> I haven't read ahead much but in most other such cases we don't =
define
> >> >> >> the "=3D 0", just start at 1<<0, then check the flags elsewhere.=
..
> >> >> >>
> >> >> >> > +static const struct fsync_component_entry {
> >> >> >> > +     const char *name;
> >> >> >> > +     enum fsync_component component_bits;
> >> >> >> > +} fsync_component_table[] =3D {
> >> >> >> > +     { "loose-object", FSYNC_COMPONENT_LOOSE_OBJECT },
> >> >> >> > +     { "pack", FSYNC_COMPONENT_PACK },
> >> >> >> > +     { "pack-metadata", FSYNC_COMPONENT_PACK_METADATA },
> >> >> >> > +     { "commit-graph", FSYNC_COMPONENT_COMMIT_GRAPH },
> >> >> >> > +     { "objects", FSYNC_COMPONENTS_OBJECTS },
> >> >> >> > +     { "default", FSYNC_COMPONENTS_DEFAULT },
> >> >> >> > +     { "all", FSYNC_COMPONENTS_ALL },
> >> >> >> > +};
> >> >> >> > +
> >> >> >> > +static enum fsync_component parse_fsync_components(const char=
 *var, const char *string)
> >> >> >> > +{
> >> >> >> > +     enum fsync_component output =3D 0;
> >> >> >> > +
> >> >> >> > +     if (!strcmp(string, "none"))
> >> >> >> > +             return output;
> >> >> >> > +
> >> >> >> > +     while (string) {
> >> >> >> > +             int i;
> >> >> >> > +             size_t len;
> >> >> >> > +             const char *ep;
> >> >> >> > +             int negated =3D 0;
> >> >> >> > +             int found =3D 0;
> >> >> >> > +
> >> >> >> > +             string =3D string + strspn(string, ", \t\n\r");
> >> >> >>
> >> >> >> Aside from the "use a list" isn't this hardcoding some windows-s=
pecific
> >> >> >> assumptions with \n\r? Maybe not...
> >> >> >
> >> >> > I shamelessly stole this code from parse_whitespace_rule. I thoug=
ht
> >> >> > about making a helper to be called by both functions, but the amo=
unt
> >> >> > of state going into and out of the wrapper via arguments was
> >> >> > substantial and seemed to negate the benefit of deduplication.
> >> >>
> >> >> FWIW string_list_split() is easier to work with in those cases, or =
at
> >> >> least I think so...
> >> >
> >> > This code runs at startup for a variable that may be present on some
> >> > installations.  The nice property of the current patch's code is tha=
t
> >> > it's already a well-tested pattern that doesn't do any allocations a=
s
> >> > it's working, unlike string_list_split().
> >>
> >> Multi-value config would also get you fewer allocations :)
> >>
> >> Anyway, I mainly meant to point out that for stuff like this it's fine
> >> to optimize it for ease rather than micro-optimize allocations. Those
> >> really aren't a bottleneck on this scale.
> >>
> >> Even in that case there's string_list_split_in_place(), which can be a
> >> bit nicer than manual C-string fiddling.
> >>
> >
> > Am I allowed to change the config value string in place? The
> > core.whitespace code is careful not to modify the string. I kind of
> > like the parse_ws_error_highlight code a little better now that I've
> > seen it, but I think the current code is fine too.
>
> I don't remember offhand if that's safe, probably not. So you'll need a
> copy here.
>
> >> > I hope you know that I appreciate your review feedback, even though
> >> > I'm pushing back on most of it so far this round. I'll be sending v3
> >> > to the list soon after giving it another look over.
> >>
> >> Sure, no worries. Just hoping to help. If you go for something differe=
nt
> >> etc. that's fine. Just hoping to bridge the gap in some knowledge /
> >> offer potentially interesting suggestions (some of which may be dead
> >> ends, like the config glob thing...).

Thanks again for the review, I'll send an updated PR soon.

Thanks,
Neeraj
