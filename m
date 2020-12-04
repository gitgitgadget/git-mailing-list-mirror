Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10B3C4361B
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 16:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7DAC229C9
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 16:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbgLDQqq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 11:46:46 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:60273 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726330AbgLDQqp (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 4 Dec 2020 11:46:45 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 600D55C021D;
        Fri,  4 Dec 2020 11:45:38 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute1.internal (MEProxy); Fri, 04 Dec 2020 11:45:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sudoforge.com;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type:content-transfer-encoding; s=fm2; bh=N8
        XGF8kp3kJkMV3CKfYMGr6DjmP3cT4htzv9ylSXoWk=; b=AVEuIZiKwbcEdtS+YR
        dydR8NvUXgdolsn3eurraNsr6fWRtGOacRRn+6bd2pGWAeT9L9Z+5IHBbqTXNVPg
        u6USGYWGY/XOOXfIcsm/VOY6nZX4IYD+pdrsYGi7HEgnpfXxQyqELEZ5QMqhOQXX
        pL8MamTII5GGcyXgCCqST2P+ii+bgAFj/GRv0+aJ7Xrw9iXkz81sEPhqDr/4Z26P
        Wjn+IMsk6FYf2KmzNXzt/jeCWT/O2jABgD9eJW6IGa84NX3FfDR+3dhgK6sR5/ce
        5SumgncrDPgEPRiBQzBbnei5vpS9qZJMXKBgOv+PDMPDyo6FlfhzrMtEt0gey9wz
        jr2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=N8XGF8kp3kJkMV3CKfYMGr6DjmP3cT4htzv9ylSXo
        Wk=; b=BhqbHv+zDZ6a7cykUpKAgsimqkXdE+W8oLlkeFhswl1uZYK7U/bQkU0zb
        WaGRU2PUaQ8Rq2hsQcFzeqnO+oPzkt7SK/+Qx3hLf+lXFOOicDvPfgy+Lz0bBLTn
        UKt6RGLxQOWXhgri71nxo3WJfBPsrd6uzryowuRVnVRpb2+iJvqugBiK/MzA7xr+
        aIYz8zftWIgBVVmt0dqV6pmL9UjxBOmyO3M9gcewMw9Buhr0TIvB2vxrUw20e6LY
        8h9dhYbxUR8GjxiMh1GJTZx/evf+j9ImhZZyLhhY/b+zKkpyyFTUx5H3aTGQZ+SW
        UGd4x14Qn355gzKaUOUTrsTAyPu1A==
X-ME-Sender: <xms:smfKX2mK0APVVnGCeFqx6UsDTM9Pj65H4caaV-TAPUQIUWjOpJG_lA>
    <xme:smfKX91g5-rNqXxmWgcEOPaQXdf1SJ0N-ENDGap-YyYtGkzf2aKcGDHaILhboZp6O
    Bf53wvwh6c1F43Kpg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeikedgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvufgtgfesth
    hqredtreerjeenucfhrhhomhepfdeuvghnucffvghnhhgrrhhtohhgfdcuoegsvghnsehs
    uhguohhfohhrghgvrdgtohhmqeenucggtffrrghtthgvrhhnpeffffeuvdeviefhledtfe
    dvffeljeffveeigfffjeevtdekhedvfeeftddvheeugfenucffohhmrghinhepghhithhh
    uhgsrdgtohhmpdhfohhordgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvnhesshhuughofhhorhhgvgdrtghomh
X-ME-Proxy: <xmx:smfKX0okp84JdkkS-pqNx2j3NFcL2Thbur1w4QKoCj_y34XT8-_57g>
    <xmx:smfKX6lb4Aw2QG8bzKQHoPkpa43FJ_KZLN8NK5T0HexaNgK5GbvCzw>
    <xmx:smfKX02h8Fc1hlGf6jHPM_ouIkz6aypoYOO-zsTgQfpufl7TDkFG-A>
    <xmx:smfKX1jysa9f5Cald3Q9Kvzba8J6VpDOJWyBdYfODOOtZPG30Ln_JA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 332BFE00BF; Fri,  4 Dec 2020 11:45:36 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-622-g4a97c0b-fm-20201115.001-g4a97c0b3
Mime-Version: 1.0
Message-Id: <112958f6-0eca-453d-86f3-52e7054a88f9@www.fastmail.com>
In-Reply-To: <X8oL190Vl03B0cQ/@coredump.intra.peff.net>
References: <a4ae4e1a-b457-4b35-878c-2714ebfc415f@www.fastmail.com>
 <X8oL190Vl03B0cQ/@coredump.intra.peff.net>
Date:   Fri, 04 Dec 2020 09:45:17 -0700
From:   "Ben Denhartog" <ben@sudoforge.com>
To:     "Jeff King" <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: Unexpected behavior with branch.*.{remote,pushremote,merge}
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I assume you mean "merge =3D refs/heads/main" from your examples

You're correct; I manually rewrote `master` to `main` in my initial emai=
l and missed that one instance.

>   - instead of branch.*.pushremote, I usually set remote.pushdefault, =
so
>     that it covers all branches (i.e., I'd never want to push to the
>     upstream remote, which I do not even have access to).
>=20
>   - in a workflow like this, I generally have push.default set to
>     "current"
>=20
>   - I make frequent use of @{push} to refer to the matching branch on =
my
>     remote (e.g., after doing some local work, I might use "git
>     range-diff upstream @{push} HEAD" to examine the changes before
>     pushing them up).

This makes sense. I rarely actually write `FETCH_HEAD` manually; in my e=
mail, I expanded the value of aliases I use. Specifically, my "get every=
thing up-to-date" alias [0] uses `FETCH_HEAD` -- changing this to `@{u}`=
 makes a lot of sense.

[0]: https://github.com/sudoforge/dotfiles/blob/trunk/git/.config/git/co=
nfig#L104

> > however `git-pull --rebase=3Dtrue` [works]
>=20
> That is running a new git-fetch under the hood, which will overwrite
> FETCH_HEAD (and will only fetch from upstream, since that's what's in
> branch.main.remote).

D'oh -- I wasn't focusing on the fact that this would only fetch the bra=
nch's configured remote; I blame it on tunnel vision.

To the rest of your message:

I did not understand the behavior of `fetch --all`; what you've describe=
d makes sense to me (although I would agree that it sounds like there's =
a bug). Between the following steps I'll take, I think my fork workflow =
is "fixed":

* Refactor away from usage of FETCH_HEAD
* Set `remote.pushdefault =3D origin`
* Set `push.default =3D current` (instead of `simple`, and is what my gl=
obal config sets this to)

I appreciate your insight and the identification of the problem.


--=20
  Ben Denhartog
  ben@sudoforge.com

On Fri, Dec 4, 2020, at 03:13, Jeff King wrote:
> On Thu, Dec 03, 2020 at 06:26:15PM -0700, Ben Denhartog wrote:
>=20
> > I have a few repositories on my system that exist primarily as local=
 copies of remote repositories, in that I normally just want to track an=
d follow the upstream project (however, I periodically contribute back u=
pstream so they are technically forks -- origin is my remote, upstream i=
s theirs).
> >=20
> > In these repositories, I set the following configuration:
> >=20
> > ```
> > [remote "origin"]
> >   url =3D https://git.foo.com/me/bar.git
> >   fetch =3D +refs/heads/*:refs/remotes/origin/*
> > [remote "upstream"]
> >   url =3D https://git.foo.com/them/bar.git
> >   fetch =3D +refs/heads/main:refs/remotes/upstream/main
> >   tagopt =3D --no-tags
> > [branch "main"]
> >   remote =3D upstream
> >   pushRemote =3D origin
> >   merge =3D refs/heads/master
> >   rebase =3D true
> > ```
>=20
> I use a similar setup myself, and it works well for this kind of
> triangular flow. A few notes:
>=20
>   - I assume you mean "merge =3D refs/heads/main" from your examples
>=20
>   - instead of branch.*.pushremote, I usually set remote.pushdefault, =
so
>     that it covers all branches (i.e., I'd never want to push to the
>     upstream remote, which I do not even have access to).
>=20
>   - in a workflow like this, I generally have push.default set to
>     "current"
>=20
>   - I make frequent use of @{push} to refer to the matching branch on =
my
>     remote (e.g., after doing some local work, I might use "git
>     range-diff upstream @{push} HEAD" to examine the changes before
>     pushing them up).
>=20
> > Based on my understanding of the branch configuration options, this
> > should effectively force my local `main` branch to track against
> > `upstream/main`, but push to `origin/main`. I notice what I believe =
to
> > be odd behavior when fetching: that FETCH_HEAD doesn't resolve to
> > `upstream/main` as I would expect:
> >=20
> > =E2=9E=9C git fetch --all
> > Fetching origin
> > Fetching upstream
> > remote: Enumerating objects: 23, done.
> > remote: Counting objects: 100% (23/23), done.
> > remote: Total 32 (delta 23), reused 23 (delta 23), pack-reused 9
> > Unpacking objects: 100% (32/32), 12.97 KiB | 949.00 KiB/s, done.
> > From https://git.foo.com/them/bar
> >    63f7159..e65b80e  main     -> upstream/main
>=20
> The culprit here is using "git fetch --all". It triggers the sub-fetch=
es
> with --append, so they'll each add to FETCH_HEAD instead of overwritin=
g
> it.  We do truncate it before the first one, so after this completes i=
t
> should have the complete set of refs fetched from both remotes (even i=
f
> it was a noop to fetch one of them, anything mentioned in the refspecs=

> shows up in FETCH_HEAD).
>=20
> Which is what you're seeing here:
>=20
> > =E2=9E=9C cat .git/FETCH_HEAD
> > 23e6881719f661c37336d9fcf7a9005a7dfce0cf        not-for-merge   bran=
ch 'main' of https://git.foo.com/me/foo
> > e65b80edd2a2162f67120a98e84bb489f15fcf97                branch 'main=
' of https://git.foo.com/them/foo
>=20
> FETCH_HEAD is not just a ref, but contains some magic instructions tha=
t
> get interpreted by git-pull. But when programs besides git-pull try to=

> resolve it to a single object, they just pick whichever value is first=
.
>=20
> So I do think there's a bug there, or at least something not
> well-thought-out in the way that "fetch --all" appends. Normally fetch=

> tries to put the merge branch (or branches) first in the file, exactly=

> so this naive "take the first one" lookup will do the most sensible
> thing. But when running multiple fetches that all append, we get their=

> individual outputs in the order of fetch (which in turn is the same as=

> the order in the config file).
>=20
> Perhaps the parent "git fetch --all" triggering the sub-fetches should=

> reorder FETCH_HEAD after they've all finished (to pull any merge heads=

> up to the top, regardless of which remote they came from).
>=20
> But an obvious workaround, if you know you'll always be merging from
> upstream, is to just reorder your config stanzas so that it's fetched
> first (likewise you can run "git fetch --multiple upstream origin" to
> specify the order manually, or define a group with remotes.<group>).
>=20
> One reason I suspect nobody has come across this before is that there'=
s
> not much reason to use FETCH_HEAD in this setting. If you know you wan=
t
> to rebase again upstream/main, then there are a number of ways you can=

> refer to that:
>=20
>   - upstream/main
>=20
>   - upstream, if your refs/remotes/upstream/HEAD is set up (if you
>     didn't clone, you may want to run "git remote set-head upstream -a=
")
>=20
>   - @{upstream}, if it's configured as your upstream (which it is here=
)
>=20
>   - @{u}, a shorter synonym
>=20
>   - nothing at all, since rebasing against the upstream is the default=

>     for git-rebase these days
>=20
>   - you can say that (or even just "upstream", if your
>     refs/remotes/origin/HEAD is set up)
>=20
> > Curiously, `git rebase FETCH_HEAD` seems to think the local branch i=
s
> > up to date (erroneously),
>=20
> That's what I'd expect, since it is doing the naive "what is the first=

> one in the file" lookup.
>=20
> > however `git-pull --rebase=3Dtrue` [works]
>=20
> That is running a new git-fetch under the hood, which will overwrite
> FETCH_HEAD (and will only fetch from upstream, since that's what's in
> branch.main.remote).
>=20
> > `git-merge FETCH_HEAD` both work as expected and merge/rebase with
> > `upstream/main`.
>=20
> I think git-merge, like git-pull, understands the magic FETCH_HEAD
> format.
>=20
> > Am I going about this incorrectly? The main purpose behind configuri=
ng
> > my "mostly just a fork" repository is that it simplifies tracking
> > against an upstream remote for projects which I do not work on
> > actively. Of course, you might argue that I don't need to keep my
> > remote around for this purpose and can just use a straightforward
> > `git-clone` here -- but I'd rather not, and would prefer responses
> > addressing the perceived bug rather than suggesting this particular
> > alternative workflow.
>=20
> I think your workflow is perfectly reasonable.
>=20
> -Peff
>
