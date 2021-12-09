Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A86FC433F5
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 06:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbhLIGVw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 01:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbhLIGVv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 01:21:51 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51805C061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 22:18:18 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id u22so7361052lju.7
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 22:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EPa7hc9VQIwpBYRQX1n7VZGKNlyZBHJi+vBjBiZwmHg=;
        b=fUHGRJgOtMPyiUacLIQIA2PZ7BdqSK+bsrEntba1s5yHq4UOYNBuz4LwuQcopZuKw1
         ImNteYg86HYpmO6x1EThBLjWJKXf1qsOGE/AZpGzsCxGsL/hArJ5F+azi5jD7gxAE45q
         qgFa9ZQZPD2KZifwu/rXlddUqKCd5u5uXAEf2xWaa6XBVq/5It77WDvfeYL0Bqkmkabn
         YrvUMIGhUh6Zm2IyR9awkwRVbXn38p+gf+e6q0mAHc+BItxlz8XTY8geEEAQb2l/f6FE
         p0PCE5yB+UNJoVTF1cEoaVpP38T3Bt8P4ItowtrkT/qWXa3RfkBXYdTuwdqm+l+pnIk9
         L1cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EPa7hc9VQIwpBYRQX1n7VZGKNlyZBHJi+vBjBiZwmHg=;
        b=wzmRu4RIqYIFt7sfydKns0m9C2lgBLO42UuW6R61IVmGnZZijc1f/yIBv7Gr2KBG+W
         65+NX9HfSCxLhCAPNyYfq5qEfpO4IOC5F7pjeEopQPVh4XmQOOBBmyX9m433dod6xIFV
         iBs9B2Kl2ZXMKiyFFjx0ym2TvKN/b24ym2rgIU7arJBdnhHn8eXMSL/acyuCaYkezsvP
         LDtlBNs/dsjHbelRTJB8mhwMKrjCmTEaBJimmswvlrScA/KudZ/Tq2hhb/5F+H9fouZP
         drOr+X5t7ZK3i64SP++Z6CNhu2UxCLj+igfuCVq7I7A6Qsn74daunqdhpImGZqPNJihl
         x2ZQ==
X-Gm-Message-State: AOAM530xGHexRnavHCsRTnyTPRRikD8vzj0IqEVsXNSOmihiV9uEAIOQ
        sDBTILGLLPwreeO1+Gp4f1H6Ilydjbe9Spe9zNs=
X-Google-Smtp-Source: ABdhPJy1kGN0wMz0lE7SQit/eI6DtD933JzC+qNxa5BNJqtQjCdTqbm31dAiFUeQfFesUxjxslMCSgOnVUoYVuozynM=
X-Received: by 2002:a2e:9718:: with SMTP id r24mr4317245lji.406.1639030696083;
 Wed, 08 Dec 2021 22:18:16 -0800 (PST)
MIME-Version: 1.0
References: <pull.1093.git.1638588503.gitgitgadget@gmail.com>
 <pull.1093.v2.git.1638845211.gitgitgadget@gmail.com> <ff80a94bf9add8a6fabcd5146e5177edf5e35e49.1638845211.git.gitgitgadget@gmail.com>
 <211207.86wnkgo9fv.gmgdl@evledraar.gmail.com> <CANQDOdfX2KaosPwLM4hS4rp+FH9V7VUxUh_md43FfZ9NG4iroQ@mail.gmail.com>
 <211208.86ee6nmme5.gmgdl@evledraar.gmail.com> <CANQDOddkKbUC-g97JOf40nS28Yv1KACvbjW9gtQZemfBMutPCw@mail.gmail.com>
 <211209.86bl1ql718.gmgdl@evledraar.gmail.com>
In-Reply-To: <211209.86bl1ql718.gmgdl@evledraar.gmail.com>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Wed, 8 Dec 2021 22:18:03 -0800
Message-ID: <CANQDOdchh3mfC8S6ouWAQbtWzZUkmTzF1p5D9dg4muoBu4N1Fg@mail.gmail.com>
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

On Wed, Dec 8, 2021 at 8:46 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
>
> On Wed, Dec 08 2021, Neeraj Singh wrote:
>
> > On Wed, Dec 8, 2021 at 2:17 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:
> >>
> >>
> >> On Tue, Dec 07 2021, Neeraj Singh wrote:
> >>
> >> > On Tue, Dec 7, 2021 at 5:01 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmaso=
n <avarab@gmail.com> wrote:
> >> >>
> >> >>
> >> >> On Tue, Dec 07 2021, Neeraj Singh via GitGitGadget wrote:
> >> >>
> >> >> > From: Neeraj Singh <neerajsi@microsoft.com>
> >> >> >
> >> >> > This commit introduces the `core.fsync` configuration
> >> >> > knob which can be used to control how components of the
> >> >> > repository are made durable on disk.
> >> >> >
> >> >> > This setting allows future extensibility of the list of
> >> >> > syncable components:
> >> >> > * We issue a warning rather than an error for unrecognized
> >> >> >   components, so new configs can be used with old Git versions.
> >> >>
> >> >> Looks good!
> >> >>
> >> >> > * We support negation, so users can choose one of the default
> >> >> >   aggregate options and then remove components that they don't
> >> >> >   want. The user would then harden any new components added in
> >> >> >   a Git version update.
> >> >>
> >> >> I think this config schema makes sense, but just a (I think importa=
nt)
> >> >> comment on the "how" not "what" of it. It's really much better to d=
efine
> >> >> config as:
> >> >>
> >> >>     [some]
> >> >>     key =3D value
> >> >>     key =3D value2
> >> >>
> >> >> Than:
> >> >>
> >> >>     [some]
> >> >>     key =3D value,value2
> >> >>
> >> >> The reason is that "git config" has good support for working with
> >> >> multi-valued stuff, so you can do e.g.:
> >> >>
> >> >>     git config --get-all -z some.key
> >> >>
> >> >> And you can easily (re)set such config e.g. with --replace-all etc.=
, but
> >> >> for comma-delimited you (and users) need to do all that work themse=
lves.
> >> >>
> >> >> Similarly instead of:
> >> >>
> >> >>     some.key =3D want-this
> >> >>     some.key =3D -not-this
> >> >>     some.key =3D but-want-this
> >> >>
> >> >> I think it's better to just have two lists, one inclusive another
> >> >> exclusive. E.g. see "log.decorate" and "log.excludeDecoration",
> >> >> "transfer.hideRefs"
> >> >>
> >> >> Which would mean:
> >> >>
> >> >>     core.fsync =3D want-this
> >> >>     core.fsyncExcludes =3D -not-this
> >> >>
> >> >> For some value of "fsyncExcludes", maybe "noFsync"? Anyway, just a
> >> >> suggestion on making this easier for users & the implementation.
> >> >>
> >> >
> >> > Maybe there's some way to handle this I'm unaware of, but a
> >> > disadvantage of your multi-valued config proposal is that it's harde=
r,
> >> > for example, for a per-repo config store to reasonably override a
> >> > per-user config store.  With the configuration scheme as-is, I can
> >> > have a per-user setting like `core.fsync=3Dall` which covers my typi=
cal
> >> > repos, but then have a maintainer repo with a private setting of
> >> > `core.fsync=3Dnone` to speed up cases where I'm mostly working with
> >> > other people's changes that are backed up in email or server-side
> >> > repos.  The latter setting conveniently overrides the former setting
> >> > in all aspects.
> >>
> >> Even if you turn just your comma-delimited proposal into a list propos=
al
> >> can't we just say that the last one wins? Then it won't matter what cm=
ae
> >> before, you'd specify "core.fsync=3Dnone" in your local .git/config.
> >>
> >> But this is also a general issue with a bunch of things in git's confi=
g
> >> space. I'd rather see us use the list-based values and just come up wi=
th
> >> some general way to reset them that works for all keys, rather than
> >> regretting having comma-delimited values that'll be harder to work wit=
h
> >> & parse, which will be a legacy wart if/when we come up with a way to
> >> say "reset all previous settings".
> >>
> >> > Also, with the core.fsync and core.fsyncExcludes, how would you spel=
l
> >> > "don't sync anything"? Would you still have the aggregate options.?
> >>
> >>     core.fsyncExcludes =3D *
> >>
> >> I.e. the same as the core.fsync=3Dnone above, anyway I still like the
> >> wildcard thing below a bit more...
> >
> > I'm not going to take this feedback unless there are additional votes
> > from the Git community in this direction.  I make the claim that
> > single-valued comma-separated config lists are easier to work with in
> > the existing Git infrastructure.
>
> Easier in what sense? I showed examples of how "git-config" trivially
> works with multi-valued config, but for comma-delimited you'll need to
> write your own shellscript boilerplate around simple things like adding
> values, removing existing ones etc.
>
> I.e. you can use --add, --unset, --unset-all, --get, --get-all etc.
>

I see what you're saying for cases where someone would want to set a
core.fsync setting that's derived from the user's current config.  But
I'm guessing that the dominant use case is someone setting a new fsync
configuration that achieves some atomic goal with respect to a given
repository. Like "this is a throwaway, so sync nothing" or "this is
really important, so sync all objects and refs and the index".

> > parsing code for the core.whitespace variable and users are used to
> > this syntax there. There are several other comma-separated lists in
> > the config space, so this construct has precedence and will be with
> > Git for some time.
>
> That's not really an argument either way for why we'd pick X over Y for
> something new. We've got some comma-delimited, some multi-value (I'm
> fairly sure we have more multi-value).
>

My main point here is that there's precedent for patch's current exact
schema for a config in the same core config leaf of the Documentation.
It seems from your comments that we'd have to invent and document some
new convention for "reset" of a multi-valued config.  So you're
suggesting that I solve an extra set of problems to get this change
in.  Just want to remind you that my personal itch to scratch is to
get the underlying mechanism in so that git-for-windows can set its
default setting to batch mode. I'm not expecting many users to
actually configure this setting to any non-default value.

> > Also, fsync configurations aren't composable like
> > some other configurations may be. It makes sense to have a holistic
> > singular fsync configuration, which is best represented by a single
> > variable.
>
> What's a "variable" here? We call these "keys", you can have a
> single-value key like user.name that you get with --get, or a
> multi-value key like say branch.<name>.merge or push.pushOption that
> you'd get with --get-all.

Yeah, I meant "key".  I conflated the config key with the underlying
global variable in git.

> I think you may be referring to either not wanting these to be
> "inherited" (which is not really a think we do for anything else in
> config), or lacking the ability to "reset".
>
> For the latter if that's absolutely needed we could just use the same
> trick as "diff.wsErrorHighlight" uses of making an empty value "reset"
> the list, and you'd get better "git config" support for editing it.
>

My reading of the code is that diff.wsErrorHighlight is a comma
separated list and not a multi-valued config.  Actually I haven't yet
found an existing multi-valued config (not sure how to grep for it).

> >> >> > This also supports the common request of doing absolutely no
> >> >> > fysncing with the `core.fsync=3Dnone` value, which is expected
> >> >> > to make the test suite faster.
> >> >>
> >> >> Let's just use the git_parse_maybe_bool() or git_parse_maybe_bool_t=
ext()
> >> >> so we'll accept "false", "off", "no" like most other such config?
> >> >
> >> > Junio's previous feedback when discussing batch mode [1] was to offe=
r
> >> > less flexibility when parsing new values of these configuration
> >> > options. I agree with his statement that "making machine-readable
> >> > tokens be spelled in different ways is a 'disease'."  I'd like to
> >> > leave this as-is so that the documentation can clearly state the exa=
ct
> >> > set of allowable values.
> >> >
> >> > [1] https://lore.kernel.org/git/xmqqr1dqzyl7.fsf@gitster.g/
> >>
> >> I think he's talking about batch, Batch, BATCH, bAtCh etc. there. But
> >> the "maybe bool" is a stanard pattern we use.
> >>
> >> I don't think we'd call one of these 0, off, no or false etc. to avoid
> >> confusion, so then you can use git_parse_maybe_...()
> >
> > I don't see the advantage of having multiple ways of specifying
> > "none".  The user can read the doc and know exactly what to write.  If
> > they write something unallowable, they get a clear warning and they
> > can read the doc again to figure out what to write.  This isn't a
> > boolean options at all, so why should we entertain bool-like ways of
> > spelling it?
>
> It's not boolean, it's multi-value and one of the values includes a true
> or false boolean value. You just spell it "none".
>
> I think both this and your comment above suggest that you think there's
> no point in this because you haven't interacted with/used "git config"
> as a command line or API mechanism, but have just hand-crafted config
> files.
>
> That's fair enough, but there's a lot of tooling that benefits from the
> latter.

My batch mode perf tests (on github, not yet submitted to the list)
use `git -c core.fsync=3D<foo>` to set up a per-process config.  I
haven't used the `git config` writing support in a while, so I haven't
deeply thought about that.  However, I favor simplifying the use case
of "atomically" setting a new holistic core.fsync value versus the use
case of deriving a new core.fsync value from the preexisting value.

> E.g.:
>
>     $ git -c core.fsync=3Doff config --type=3Dbool core.fsync
>     false
>     $ git -c core.fsync=3Dblah config --type=3Dbool core.fsync
>     fatal: bad boolean config value 'blah' for 'core.fsync'
>
> Here we can get 'git config' to normalize what you call 'none', and you
> can tell via exit codes/normalization if it's "false". But if you invent
> a new term for "false" you can't do that as easily.
>
> We have various historical keys that take odd exceptions to that,
> e.g. "never", but unless we have a good reason to let's not invent more
> exceptions.
>
> >> >> > Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
> >> >> > ---
> >> >> >  Documentation/config/core.txt | 27 +++++++++----
> >> >> >  builtin/fast-import.c         |  2 +-
> >> >> >  builtin/index-pack.c          |  4 +-
> >> >> >  builtin/pack-objects.c        |  8 ++--
> >> >> >  bulk-checkin.c                |  5 ++-
> >> >> >  cache.h                       | 39 +++++++++++++++++-
> >> >> >  commit-graph.c                |  3 +-
> >> >> >  config.c                      | 76 +++++++++++++++++++++++++++++=
+++++-
> >> >> >  csum-file.c                   |  5 ++-
> >> >> >  csum-file.h                   |  3 +-
> >> >> >  environment.c                 |  1 +
> >> >> >  midx.c                        |  3 +-
> >> >> >  object-file.c                 |  3 +-
> >> >> >  pack-bitmap-write.c           |  3 +-
> >> >> >  pack-write.c                  | 13 +++---
> >> >> >  read-cache.c                  |  2 +-
> >> >> >  16 files changed, 164 insertions(+), 33 deletions(-)
> >> >> >
> >> >> > diff --git a/Documentation/config/core.txt b/Documentation/config=
/core.txt
> >> >> > index dbb134f7136..4f1747ec871 100644
> >> >> > --- a/Documentation/config/core.txt
> >> >> > +++ b/Documentation/config/core.txt
> >> >> > @@ -547,6 +547,25 @@ core.whitespace::
> >> >> >    is relevant for `indent-with-non-tab` and when Git fixes `tab-=
in-indent`
> >> >> >    errors. The default tab width is 8. Allowed values are 1 to 63=
.
> >> >> >
> >> >> > +core.fsync::
> >> >> > +     A comma-separated list of parts of the repository which sho=
uld be
> >> >> > +     hardened via the core.fsyncMethod when created or modified.=
 You can
> >> >> > +     disable hardening of any component by prefixing it with a '=
-'. Later
> >> >> > +     items take precedence over earlier ones in the list. For ex=
ample,
> >> >> > +     `core.fsync=3Dall,-pack-metadata` means "harden everything =
except pack
> >> >> > +     metadata." Items that are not hardened may be lost in the e=
vent of an
> >> >> > +     unclean system shutdown.
> >> >> > ++
> >> >> > +* `none` disables fsync completely. This must be specified alone=
.
> >> >> > +* `loose-object` hardens objects added to the repo in loose-obje=
ct form.
> >> >> > +* `pack` hardens objects added to the repo in packfile form.
> >> >> > +* `pack-metadata` hardens packfile bitmaps and indexes.
> >> >> > +* `commit-graph` hardens the commit graph file.
> >> >> > +* `objects` is an aggregate option that includes `loose-objects`=
, `pack`,
> >> >> > +  `pack-metadata`, and `commit-graph`.
> >> >> > +* `default` is an aggregate option that is equivalent to `object=
s,-loose-object`
> >> >> > +* `all` is an aggregate option that syncs all individual compone=
nts above.
> >> >> > +
> >> >>
> >> >> It's probably a *bit* more work to set up, but I wonder if this wou=
ldn't
> >> >> be simpler if we just said (and this is partially going against wha=
t I
> >> >> noted above):
> >> >>
> >> >> =3D=3D BEGIN DOC
> >> >>
> >> >> core.fsync is a multi-value config variable where each item is a
> >> >> pathspec that'll get matched the same way as 'git-ls-files' et al.
> >> >>
> >> >> When we sync pretend that a path like .git/objects/de/adbeef... is
> >> >> relative to the top-level of the git
> >> >> directory. E.g. "objects/de/adbeaf.." or "objects/pack/...".
> >> >>
> >> >> You can then supply a list of wildcards and exclusions to configure
> >> >> syncing.  or "false", "off" etc. to turn it off. These are synonymo=
us
> >> >> with:
> >> >>
> >> >>     ; same as "false"
> >> >>     core.fsync =3D ":!*"
> >> >>
> >> >> Or:
> >> >>
> >> >>     ; same as "true"
> >> >>     core.fsync =3D "*"
> >> >>
> >> >> Or, to selectively sync some things and not others:
> >> >>
> >> >>     ;; Sync objects, but not "info"
> >> >>     core.fsync =3D ":!objects/info/**"
> >> >>     core.fsync =3D "objects/**"
> >> >>
> >> >> See gitrepository-layout(5) for details about what sort of paths yo=
u
> >> >> might be expected to match. Not all paths listed there will go thro=
ugh
> >> >> this mechanism (e.g. currently objects do, but nothing to do with c=
onfig
> >> >> does).
> >> >>
> >> >> We can and will match this against "fake paths", e.g. when writing =
out
> >> >> packs we may match against just the string "objects/pack", we're no=
t
> >> >> going to re-check if every packfile we're writing matches your glob=
s,
> >> >> ditto for loose objects. Be reasonable!
> >> >>
> >> >> This metharism is intended as a shorthand that provides some flexib=
ility
> >> >> when fsyncing, while not forcing git to come up with labels for all
> >> >> paths the git dir, or to support crazyness like "objects/de/adbeef*=
"
> >> >>
> >> >> More paths may be added or removed in the future, and we make no
> >> >> promises that we won't move things around, so if in doubt use
> >> >> e.g. "true" or a wide pattern match like "objects/**". When in doub=
t
> >> >> stick to the golden path of examples provided in this documentation=
.
> >> >>
> >> >> =3D=3D END DOC
> >> >>
> >> >>
> >> >> It's a tad more complex to set up, but I wonder if that isn't worth
> >> >> it. It nicely gets around any current and future issues of deciding=
 what
> >> >> labels such as "loose-object" etc. to pick, as well as slotting int=
o an
> >> >> existing method of doing exclude/include lists.
> >> >>
> >> >
> >> > I think this proposal is a lot of complexity to avoid coming up with=
 a
> >> > new name for syncable things as they are added to Git.  A path based
> >> > mechanism makes it hard to document for the (advanced) user what the
> >> > full set of things is and how it might change from release to releas=
e.
> >> > I think the current core.fsync scheme is a bit easier to understand,
> >> > query, and extend.
> >>
> >> We document it in gitrepository-layout(5). Yeah it has some
> >> disadvantages, but one advantage is that you could make the
> >> composability easy. I.e. if last exclude wins then a setting of:
> >>
> >>     core.fsync =3D ":!*"
> >>     core.fsync =3D "objects/**"
> >>
> >> Would reset all previous matches & only match objects/**.
> >>
> >
> > The value of changing this is predicated on taking your previous
> > multi-valued config proposal, which I'm still not at all convinced
> > about.
>
> They're orthagonal. I.e. you get benefits from multi-value with or
> without this globbing mechanism.
>
> In any case, I don't feel strongly about/am really advocating this
> globbing mechanism. I just wondered if it wouldn't make things simpler
> since it would sidestep the need to create any sort of categories for
> subsets of gitrepository-layout(5), but maybe not...
>
> > The schema in the current (v1-v2) version of the patch already
> > includes an example of extending the list of syncable things, and
> > Patrick Steinhardt made it clear that he feels comfortable adding
> > 'refs' to the same schema in a future change.
> >
> > I'll also emphasize that we're talking about a non-functional,
> > relatively corner-case behavioral configuration.  These values don't
> > change how git's interface behaves except when the system crashes
> > during a git command or shortly after one completes.
>
> That may be something some OS's promise, but it's not something fsync()
> or POSIX promises. I.e. you might write a ref, but unless you fsync and
> the relevant dir entries another process might not see the update, crash
> or not.
>

I haven't seen any indication that POSIX requires an fsync for
visiblity within a running system.  I looked at the doc for open,
write, and fsync, and saw no indication that it's posix compliant to
require an fsync for visibility.  I think an OS that required fsync
for cross-process visiblity would fail to run Git for a myriad of
other reasons and would likely lose all its users.  I'm curious where
you've seen documentation that allows such unhelpful behavior?

> That's an aside from these config design questions, and I think
> most/(all?) OS's anyone cares about these days tend to make that
> implicit promise as part of their VFS behavior, but we should probably
> design such an interface to fsync() with such pedantic portability in
> mind.

Why? To be rude to such a hypothetical system, if a system were so
insanely designed, it would be nuts to support it.

> > While you may not personally love the proposed configuration
> > interface, I'd want your view on some questions:
> > 1. Is it easy for the (advanced) user to set a configuration?
> > 2. Is it easy for the (advanced) user to see what was configured?
> > 3. Is it easy for the Git community to build on this as we want to add
> > things to the list of things to sync?
> >     a) Is there a good best practice configuration so that people can
> > avoid losing integrity for new stuff that they are intending to sync.
> >     b) If someone has a custom configuration, can that custom
> > configuration do something reasonable as they upgrade versions of Git?
> >              ** In response to this question, I might see some value
> > in adding a 'derived-metadata' aggregate that can be disabled so that
> > a custom configuration can exclude those as they change version to
> > version.
> >     c) Is it too much maintenance overhead to consider how to present
> > this configuration knob for any new hashfile or other datafile in the
> > git repo?
> > 4. Is there a good path forward to change the default syncable set,
> > both in git-for-windows and in Git for other platforms?
>
> I'm not really sure this globbing this is a good idea, as noted above
> just a suggestion etc.
>
> As noted there it just gets you out of the business of re-defining
> gitrepository-layout(5), and assuming too much in advance about certain
> use-cases.
>
> E.g. even "refs" might be too broad for some. I don't tend to be I/O
> limited, but I could see how someone who would be would care about
> refs/heads but not refs/remotes, or want to exclude logs/* but not the
> refs updates themselves etc.

This use-case is interesting (distinguishing remote refs from local
refs).  I think the difficulty of verifying (for even an advanced
user) that the right fsyncing is actually happening still puts me on
the side of having a carefully curated and documented set of syncable
things rather than a file-path-based mechanism.

Is this meaningful in the presumably nearby future world of the refsdb
backend?  Is that somehow split by remote versus local?

> >> >> > diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> >> >> > index 857be7826f3..916c55d6ce9 100644
> >> >> > --- a/builtin/pack-objects.c
> >> >> > +++ b/builtin/pack-objects.c
> >> >> > @@ -1204,11 +1204,13 @@ static void write_pack_file(void)
> >> >> >                * If so, rewrite it like in fast-import
> >> >> >                */
> >> >> >               if (pack_to_stdout) {
> >> >> > -                     finalize_hashfile(f, hash, CSUM_HASH_IN_STR=
EAM | CSUM_CLOSE);
> >> >> > +                     finalize_hashfile(f, hash, FSYNC_COMPONENT_=
NONE,
> >> >> > +                                       CSUM_HASH_IN_STREAM | CSU=
M_CLOSE);
> >> >>
> >> >> Not really related to this per-se, but since you're touching the AP=
I
> >> >> everything goes through I wonder if callers should just always try =
to
> >> >> fsync, and we can just catch EROFS and EINVAL in the wrapper if som=
eone
> >> >> tries to flush stdout, or catch the fd at that lower level.
> >> >>
> >> >> Or maybe there's a good reason for this...
> >> >
> >> > It's platform dependent, but I'd expect fsync would do something for
> >> > pipes or stdout redirected to a file.  In these cases we really don'=
t
> >> > want to fsync since we have no idea what we're talking to and we're
> >> > potentially worsening performance for probably no benefit.
> >>
> >> Yeah maybe we should just leave it be.
> >>
> >> I'd think the C library returning EINVAL would be a trivial performanc=
e
> >> cost though.
> >>
> >> It just seemed odd to hardcode assumptions about what can and can't be
> >> synced when the POSIX defined function will also tell us that.
> >>
> >
> > Redirecting stdout to a file seems like a common usage for this
> > command. That would definitely be fsyncable, but Git has no idea what
> > its proper category is since there's no way to know the purpose or
> > lifetime of the packfile.  I'm going to leave this be, because I'd
> > posit that "can it be fsynced?" is not the same as "should it be
> > fsynced?".  The latter question can't be answered for stdout.
>
> As noted this was just an aside, and I don't even know if any OS would
> do anything meaningful with an fsync() of such a FD anyway.
>

The underlying fsync primitive does have a meaning on Windows for
pipes, but it's certainly not what Git would want to do. Also if
stdout is redirected to a file, I'm pretty sure that UNIX OSes would
respect the fsync call.  However it's not meaningful in the sense of
the git repository, since we don't know what the packfile is or why it
was created.

> I just don't see why we wouldn't say:
>
>  1. We're syncing this category of thing
>  2. Try it
>  3. If fsync returns "can't fsync that sort of thing" move on
>
> As opposed to trying to shortcut #3 by doing the detection ourselves.
>
> I.e. maybe there was a good reason, but it seemed to be some easy
> potential win for more simplification, since you were re-doing and
> simplifying some of the interface anyway...

We're trying to be deliberate about what we're fsyncing.  Fsyncing an
unknown file created by the packfile code doesn't move us in that
direction.  In your taxonomy we don't know (1), "what is this category
of thing?"  Sure it's got the packfile format, but is not known to be
an actual packfile that's part of the repository.

> >>
> >> >> > [...]
> >> >> > +/*
> >> >> > + * These values are used to help identify parts of a repository =
to fsync.
> >> >> > + * FSYNC_COMPONENT_NONE identifies data that will not be a persi=
stent part of the
> >> >> > + * repository and so shouldn't be fsynced.
> >> >> > + */
> >> >> > +enum fsync_component {
> >> >> > +     FSYNC_COMPONENT_NONE                    =3D 0,
> >> >>
> >> >> I haven't read ahead much but in most other such cases we don't def=
ine
> >> >> the "=3D 0", just start at 1<<0, then check the flags elsewhere...
> >> >>
> >> >> > +static const struct fsync_component_entry {
> >> >> > +     const char *name;
> >> >> > +     enum fsync_component component_bits;
> >> >> > +} fsync_component_table[] =3D {
> >> >> > +     { "loose-object", FSYNC_COMPONENT_LOOSE_OBJECT },
> >> >> > +     { "pack", FSYNC_COMPONENT_PACK },
> >> >> > +     { "pack-metadata", FSYNC_COMPONENT_PACK_METADATA },
> >> >> > +     { "commit-graph", FSYNC_COMPONENT_COMMIT_GRAPH },
> >> >> > +     { "objects", FSYNC_COMPONENTS_OBJECTS },
> >> >> > +     { "default", FSYNC_COMPONENTS_DEFAULT },
> >> >> > +     { "all", FSYNC_COMPONENTS_ALL },
> >> >> > +};
> >> >> > +
> >> >> > +static enum fsync_component parse_fsync_components(const char *v=
ar, const char *string)
> >> >> > +{
> >> >> > +     enum fsync_component output =3D 0;
> >> >> > +
> >> >> > +     if (!strcmp(string, "none"))
> >> >> > +             return output;
> >> >> > +
> >> >> > +     while (string) {
> >> >> > +             int i;
> >> >> > +             size_t len;
> >> >> > +             const char *ep;
> >> >> > +             int negated =3D 0;
> >> >> > +             int found =3D 0;
> >> >> > +
> >> >> > +             string =3D string + strspn(string, ", \t\n\r");
> >> >>
> >> >> Aside from the "use a list" isn't this hardcoding some windows-spec=
ific
> >> >> assumptions with \n\r? Maybe not...
> >> >
> >> > I shamelessly stole this code from parse_whitespace_rule. I thought
> >> > about making a helper to be called by both functions, but the amount
> >> > of state going into and out of the wrapper via arguments was
> >> > substantial and seemed to negate the benefit of deduplication.
> >>
> >> FWIW string_list_split() is easier to work with in those cases, or at
> >> least I think so...
> >
> > This code runs at startup for a variable that may be present on some
> > installations.  The nice property of the current patch's code is that
> > it's already a well-tested pattern that doesn't do any allocations as
> > it's working, unlike string_list_split().
>
> Multi-value config would also get you fewer allocations :)
>
> Anyway, I mainly meant to point out that for stuff like this it's fine
> to optimize it for ease rather than micro-optimize allocations. Those
> really aren't a bottleneck on this scale.
>
> Even in that case there's string_list_split_in_place(), which can be a
> bit nicer than manual C-string fiddling.
>

Am I allowed to change the config value string in place? The
core.whitespace code is careful not to modify the string. I kind of
like the parse_ws_error_highlight code a little better now that I've
seen it, but I think the current code is fine too.

> > I hope you know that I appreciate your review feedback, even though
> > I'm pushing back on most of it so far this round. I'll be sending v3
> > to the list soon after giving it another look over.
>
> Sure, no worries. Just hoping to help. If you go for something different
> etc. that's fine. Just hoping to bridge the gap in some knowledge /
> offer potentially interesting suggestions (some of which may be dead
> ends, like the config glob thing...).

Thanks,
Neeraj
