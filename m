Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03BF81F5A1
	for <e@80x24.org>; Wed, 13 Nov 2019 19:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfKMTZk (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Nov 2019 14:25:40 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52802 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfKMTZj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Nov 2019 14:25:39 -0500
Received: by mail-wm1-f65.google.com with SMTP id l1so3222978wme.2
        for <git@vger.kernel.org>; Wed, 13 Nov 2019 11:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NIpQt0Ee7OKdoCuXd2cfxiIIkmlMIyi2JjwRq8klpyg=;
        b=KVGc4iLySCgX3sr8aLZoH+pjYTGU3ITXZCbyRBr2MuDG5ycRlD4Rbmol08T8rQJU+4
         EYLSm4ok6lD6mY280sxXwKWO9nEWlP6suEWRx7Fm4H35TwvFxRX5Sxk5U275aXPkq/YZ
         9PiNC8zOEMmAWaH1i5prSlUkiIpDtxJQLSQ1f5urEE0vNLz88lDI1ae54+SYKqm3dQKT
         us35py+fx5ZAtUp9D1onXE71+ZAOnjUKNKj4Yl3/xf4loH4rN2lC5Gf5c94szsbMYk/3
         NzltX+cCG9fhDXDUom9pvImNYLW2fmzBA6fF6HjfIsuMCgGLvrqykeYy940VH8F8Vs+n
         IzYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NIpQt0Ee7OKdoCuXd2cfxiIIkmlMIyi2JjwRq8klpyg=;
        b=k9ZFPti3A+WMx8JKAH5nXAnXoIWO5qWdTcf5wA29VJ88AwCiYU1uA1JYaztM+NNDc1
         rZQkQOKHG+l8cTsre4VqY/4LQs+l78JcGcCV3XwMb6lp621uWarEdi/N4HDwxUwHJxvL
         D+72hW8CeAMgeq1i5a1kD/wjofvGJ7EEL/swoysY/FsQSnw1wVWh32zLzPhI9HQ/4+u5
         tps8o2PQ5oOZ5vjKoRLpl3Tk0uzuHtwCmhgAIHxaZ8nihBYnGhJA0wSnDs6L5fn2PE+8
         wqbvTAtROjJawMa4pD86MnOdFC7/WWN71pqr9ZCUa+e7Use8PlE1CArXIzuCzMedbcvo
         1VEQ==
X-Gm-Message-State: APjAAAXaIyf309wJsqOgZrgnJZpq1RSBQ3sziVhjwtiOUaIm+zL1/NeH
        ycM+wzrDaSWoEwENyBl/CuQ6G0b+LjWgH+jQQ7vkB0Co
X-Google-Smtp-Source: APXvYqxMqFSuOCQ7YE4dGU2O/qs4e+ii2swRTimRqfSgWfpNVhUveeBCHa7ea1WjMt5BlMBExIPJ2yx3pU6u98icUoE=
X-Received: by 2002:a1c:9804:: with SMTP id a4mr4140057wme.57.1573673135493;
 Wed, 13 Nov 2019 11:25:35 -0800 (PST)
MIME-Version: 1.0
References: <20190919214712.7348-1-szeder.dev@gmail.com> <20191112103821.30265-1-szeder.dev@gmail.com>
 <nycvar.QRO.7.76.6.1911122012050.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1911122012050.46@tvgsbejvaqbjf.bet>
From:   Sebastiaan Dammann <triadsebas@gmail.com>
Date:   Wed, 13 Nov 2019 20:25:24 +0100
Message-ID: <CAE7Eq9g9-rbUxMTrGVOGGDAa+onQjshVSZkA_7FDbcB8QXboxQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] name-rev: eliminate recursion
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

The patch works very well on Windows.

Tested it on a repository with 146823 commits and for every commit a note.

Groeten,
Sebastiaan Dammann

On Tue, 12 Nov 2019 at 20:18, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi,
>
> [Cc:ing Sebastian, as they indicated in
> https://public-inbox.org/git/CAE7Eq9hEiVf1rMNdWx55_nQsz2gVv0N%2Bs1KckK1ev=
tmruqcHyA@mail.gmail.com/t/#u
> that they would be interested in testing this]
>
> Sebastian, could you test this patch series? Since you are on Windows,
> you should be able to do so by
>
> - installing Git for Windows' SDK
>   (https://gitforwindows.org/#download-sdk)
> - `sdk cd git` (possibly `sdk init git`, although that should be
>   implied)
> - `sdk init build-extra` followed by
>   `/usr/src/build-extra/apply-from-public-inbox.sh
>   https://public-inbox.org/git/20191112103821.30265-1-szeder.dev@gmail.co=
m/`
> - `sdk build`
>
> The result should include a `git.exe` in `/usr/src/git/` that you can
> copy to your server and test via `/path/to/git.exe name-rev ...`.
>
> Ciao,
> Johannes
>
> On Tue, 12 Nov 2019, SZEDER G=C3=A1bor wrote:
>
> > 'git name-rev' is implemented using a recursive algorithm, and,
> > consequently, it can segfault in deep histories (e.g. WebKit), and
> > thanks to a test case demonstrating this limitation every test run
> > results in a dmesg entry logging the segfaulting git process.
> >
> > This patch series eliminates the recursion.
> >
> > Patches 1-5 are while-at-it cleanups I noticed on the way, and patch 6
> > improves test coverage.  Patches 7-11 are preparatory refactorings
> > that are supposed to make this series easier to follow, and make patch
> > 12, the one finally eliminating the recursion, somewhat shorter, and
> > even much shorter when viewed with '--ignore-all-space'.  Patch 13
> > cleans up after those preparatory steps.
> >
> > Changes since v1:
> >
> >   - Patch 12 now eliminates the recursion using a LIFO 'prio_queue'
> >     instead of a 'commit_list' to avoid any performance penalty.
> >
> >   - Commit message updates, clarifications, typofixes, missing
> >     signoffs, etc., most notably in patches 6 and 12.
> >
> >   - Updated ASCII art history graphs.
> >
> >   - Replaced the strbuf_suffix() cleanup in patch 3 with Ren=C3=A9's
> >     suggestion; now that patch needs his signoff.
> >
> >   - Dropped the last two patches plugging memory leaks; Ren=C3=A9's pla=
n
> >     to clean up memory ownership looked more promising, and that
> >     would make these two dropped patches moot anyway.
> >
> > v1: https://public-inbox.org/git/20190919214712.7348-1-szeder.dev@gmail=
.com/T/#u
> >
> > Ren=C3=A9 Scharfe (1):
> >   name-rev: use strbuf_strip_suffix() in get_rev_name()
> >
> > SZEDER G=C3=A1bor (12):
> >   t6120-describe: correct test repo history graph in comment
> >   t6120-describe: modernize the 'check_describe' helper
> >   name-rev: avoid unnecessary cast in name_ref()
> >   name-rev: use sizeof(*ptr) instead of sizeof(type) in allocation
> >   t6120: add a test to cover inner conditions in 'git name-rev's
> >     name_rev()
> >   name-rev: extract creating/updating a 'struct name_rev' into a helper
> >   name-rev: pull out deref handling from the recursion
> >   name-rev: restructure parsing commits and applying date cutoff
> >   name-rev: restructure creating/updating 'struct rev_name' instances
> >   name-rev: drop name_rev()'s 'generation' and 'distance' parameters
> >   name-rev: eliminate recursion in name_rev()
> >   name-rev: cleanup name_ref()
> >
> >  builtin/name-rev.c  | 147 +++++++++++++++++++++++++++++---------------
> >  t/t6120-describe.sh |  72 +++++++++++++++++-----
> >  2 files changed, 153 insertions(+), 66 deletions(-)
> >
> > Range-diff:
> >  1:  673da20e3d !  1:  8d70ed050d t6120-describe: correct test repo his=
tory graph in comment
> >     @@ t/t6120-describe.sh
> >      -test_description=3D'test describe
> >      +test_description=3D'test describe'
> >      +
> >     -+#       ,---o----o----o-----.
> >     -+#      /   D,R   e           \
> >     -+#  o--o-----o-------------o---o----x
> >     -+#      \    B            /
> >     -+#       `---o----o----o-'
> >     -+#                A    c
> >     ++#  o---o-----o----o----o-------o----x
> >     ++#       \   D,R   e           /
> >     ++#        \---o-------------o-'
> >     ++#         \  B            /
> >     ++#          `-o----o----o-'
> >     ++#                 A    c
> >     ++#
> >     ++# First parent of a merge commit is on the same line, second pare=
nt below.
> >
> >      -                       B
> >      -        .--------------o----o----o----x
> >  2:  05df899693 =3D  2:  3720b6859d t6120-describe: modernize the 'chec=
k_describe' helper
> >  3:  7b0227cfea !  3:  ad2f2eee68 name-rev: use strip_suffix() in get_r=
ev_name()
> >     @@
> >       ## Metadata ##
> >     -Author: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> >     +Author: Ren=C3=A9 Scharfe <l.s.r@web.de>
> >
> >       ## Commit message ##
> >     -    name-rev: use strip_suffix() in get_rev_name()
> >     +    name-rev: use strbuf_strip_suffix() in get_rev_name()
> >
> >     -    Use strip_suffix() instead of open-coding it, making the code =
more
> >     -    idiomatic.
> >     +    get_name_rev() basically open-codes strip_suffix() before addi=
ng a
> >     +    string to a strbuf.
> >
> >     +    Let's use the strbuf right from the beginning, i.e. add the wh=
ole
> >     +    string to the strbuf and then use strbuf_strip_suffix(), makin=
g the
> >     +    code more idiomatic.
> >     +
> >     +    [TODO: Ren=C3=A9's signoff!]
> >          Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> >
> >       ## builtin/name-rev.c ##
> >     @@ builtin/name-rev.c: static const char *get_rev_name(const struct=
 object *o, stru
> >      -                int len =3D strlen(n->tip_name);
> >      -                if (len > 2 && !strcmp(n->tip_name + len - 2, "^0=
"))
> >      -                        len -=3D 2;
> >     -+                size_t len;
> >     -+                strip_suffix(n->tip_name, "^0", &len);
> >                       strbuf_reset(buf);
> >      -                strbuf_addf(buf, "%.*s~%d", len, n->tip_name, n->=
generation);
> >     -+                strbuf_addf(buf, "%.*s~%d", (int) len, n->tip_nam=
e,
> >     -+                            n->generation);
> >     ++                strbuf_addstr(buf, n->tip_name);
> >     ++                strbuf_strip_suffix(buf, "^0");
> >     ++                strbuf_addf(buf, "~%d", n->generation);
> >                       return buf->buf;
> >               }
> >       }
> >  4:  40faecdc2a =3D  4:  c86a2ae2d0 name-rev: avoid unnecessary cast in=
 name_ref()
> >  5:  c71df3dadf =3D  5:  4fc960cc05 name-rev: use sizeof(*ptr) instead =
of sizeof(type) in allocation
> >  6:  1dcb76072f !  6:  1493cb4484 t6120: add a test to cover inner cond=
itions in 'git name-rev's name_rev()
> >     @@ Commit message
> >          looks like this:
> >
> >            if (parent_number > 1) {
> >     -        if (generation > 0)
> >     -          // do stuff #1
> >     -        else
> >     -          // do stuff #2
> >     +          if (generation > 0)
> >     +              // branch #1
> >     +              new_name =3D ...
> >     +          else
> >     +              // branch #2
> >     +              new_name =3D ...
> >     +          name_rev(parent, new_name, ...);
> >            } else {
> >     -         // do stuff #3
> >     +          // branch #3
> >     +          name_rev(...);
> >            }
> >
> >          These conditions are not covered properly in the test suite.  =
As far
> >     @@ Commit message
> >          command's output, because the repository used in that test scr=
ipt
> >          contains several branches and tags pointing somewhere into the=
 middle
> >          of the commit DAG, and thus result in a better name for the
> >     -    to-be-named commit.  In an early version of this patch series =
I
> >     -    managed to mess up those conditions (every single one of them =
at
> >     -    once!), but the whole test suite still passed successfully.
> >     +    to-be-named commit.  This can hide bugs: e.g. by replacing the
> >     +    'new_name' parameter of the first recursive name_rev() call wi=
th
> >     +    'tip_name' (effectively making both branch #1 and #2 a noop) '=
git
> >     +    name-rev --all' shows thousands of bogus names in the Git repo=
sitory,
> >     +    but the whole test suite still passes successfully.  In an ear=
ly
> >     +    version of a later patch in this series I managed to mess up a=
ll three
> >     +    branches (at once!), but the test suite still passed.
> >
> >          So add a new test case that operates on the following history:
> >
> >     -        -----------master
> >     -       /          /
> >     -      A----------M2
> >     -       \        /
> >     -        \---M1-C
> >     -         \ /
> >     -          B
> >     +      A--------------master
> >     +       \            /
> >     +        \----------M2
> >     +         \        /
> >     +          \---M1-C
> >     +           \ /
> >     +            B
> >
> >     -    and names the commit 'B', where:
> >     +    and names the commit 'B' to make sure that all three branches =
are
> >     +    crucial to determine 'B's name:
> >
> >     -      - The merge commit at master makes sure that the 'do stuff #=
3'
> >     -        affects the final name.
> >     +      - There is only a single ref, so all names are based on 'mas=
ter',
> >     +        without any undesired interference from other refs.
> >
> >     -      - The merge commit M2 make sure that the 'do stuff #1' part
> >     -        affects the final name.
> >     +      - Each time name_rev() follows the second parent of a merge =
commit,
> >     +        it appends "^2" to the name.  Following 'master's second p=
arent
> >     +        right at the start ensures that all commits on the ancestr=
y path
> >     +        from 'master' to 'B' have a different base name from the o=
riginal
> >     +        'tip_name' of the very first name_rev() invocation.  Curre=
ntly,
> >     +        while name_rev() is recursive, it doesn't matter, but it w=
ill be
> >     +        necessary to properly cover all three branches after the r=
ecursion
> >     +        is eliminated later in this series.
> >
> >     -      - And M1 makes sure that the 'do stuff #2' part affects the =
final
> >     -        name.
> >     +      - Following 'M2's second parent makes sure that branch #2 (i=
.e. when
> >     +        'generation =3D 0') affects 'B's name.
> >     +
> >     +      - Following the only parent of the non-merge commit 'C' ensu=
res that
> >     +        branch #3 affects 'B's name, and that it increments 'gener=
ation'.
> >     +
> >     +      - Coming from 'C' 'generation' is 1, thus following 'M1's se=
cond
> >     +        parent makes sure that branch #1 affects 'B's name.
> >
> >          Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> >
> >       ## t/t6120-describe.sh ##
> >     -@@ t/t6120-describe.sh: test_expect_success 'describe complains ab=
out missing object' '
> >     -         test_must_fail git describe $ZERO_OID
> >     +@@ t/t6120-describe.sh: test_expect_success 'name-rev a rev shortl=
y after epoch' '
> >     +         test_cmp expect actual
> >       '
> >
> >     -+#   -----------master
> >     -+#  /          /
> >     -+# A----------M2
> >     -+#  \        /
> >     -+#   \---M1-C
> >     -+#    \ /
> >     -+#     B
> >     -+test_expect_success 'test' '
> >     ++# A--------------master
> >     ++#  \            /
> >     ++#   \----------M2
> >     ++#    \        /
> >     ++#     \---M1-C
> >     ++#      \ /
> >     ++#       B
> >     ++test_expect_success 'name-rev covers all conditions while looking=
 at parents' '
> >      +        git init repo &&
> >      +        (
> >      +                cd repo &&
> >     @@ t/t6120-describe.sh: test_expect_success 'describe complains abo=
ut missing objec
> >      +                git checkout master &&
> >      +                git merge --no-ff HEAD@{1} &&
> >      +
> >     -+                git log --graph --oneline &&
> >     -+
> >      +                echo "$B master^2^2~1^2" >expect &&
> >      +                git name-rev $B >actual &&
> >      +
> >  7:  bdd8378b06 =3D  7:  fc842e578b name-rev: extract creating/updating=
 a 'struct name_rev' into a helper
> >  8:  ce21c351f9 !  8:  7f182503e2 name-rev: pull out deref handling fro=
m the recursion
> >     @@ Commit message
> >          Extract this condition from the recursion into name_rev()'s ca=
ller and
> >          drop the function's 'deref' parameter.  This makes eliminating=
 the
> >          recursion a bit easier to follow, and it will be moved back in=
to
> >     -    name_rev() after the recursion is elminated.
> >     +    name_rev() after the recursion is eliminated.
> >
> >          Furthermore, drop the condition that die()s when both 'deref' =
and
> >          'generation' are non-null (which should have been a BUG() to b=
egin
> >     @@ Commit message
> >
> >          Note that this change reintroduces the memory leak that was pl=
ugged in
> >          in commit 5308224633 (name-rev: avoid leaking memory in the `d=
eref`
> >     -    case, 2017-05-04), but a later patch in this series will plug =
it in
> >     -    again.
> >     +    case, 2017-05-04), but a later patch (name-rev: restructure
> >     +    creating/updating 'struct rev_name' instances) in this series =
will
> >     +    plug it in again.
> >
> >          Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> >
> >  9:  c8acc6b597 !  9:  0cdd40b75b name-rev: restructure parsing commits=
 and applying date cutoff
> >     @@ Commit message
> >          name_rev() and name_rev() itself as it iterates over the paren=
t
> >          commits.
> >
> >     -    This makes eliminating the recursion a bit easier to follow, a=
nd it
> >     -    will be moved back to name_rev() after the recursion is elimin=
ated.
> >     +    This makes eliminating the recursion a bit easier to follow, a=
nd the
> >     +    condition moved to name_ref() will be moved back to name_rev()=
 after
> >     +    the recursion is eliminated.
> >
> >          Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> >
> > 10:  c731f27158 ! 10:  e1733e3c56 name-rev: restructure creating/updati=
ng 'struct rev_name' instances
> >     @@ Commit message
> >          At the beginning of the recursive name_rev() function it creat=
es a new
> >          'struct rev_name' instance for each previously unvisited commi=
t or, if
> >          this visit results in better name for an already visited commi=
t, then
> >     -    updates the 'struct rev_name' instance attached to to the comm=
it, or
> >     +    updates the 'struct rev_name' instance attached to the commit,=
 or
> >          returns early.
> >
> >          Restructure this so it's caller creates or updates the 'struct
> >     @@ Commit message
> >          parameter, i.e. both name_ref() before calling name_rev() and
> >          name_rev() itself as it iterates over the parent commits.
> >
> >     -    This makes eliminating the recursion a bit easier to follow, a=
nd it
> >     -    will be moved back to name_rev() after the recursion is elimin=
ated.
> >     +    This makes eliminating the recursion a bit easier to follow, a=
nd the
> >     +    condition moved to name_ref() will be moved back to name_rev()=
 after
> >     +    the recursion is eliminated.
> >
> >          This change also plugs the memory leak that was temporarily un=
plugged
> >          in the earlier "name-rev: pull out deref handling from the rec=
ursion"
> > 11:  ba14bde230 ! 11:  bd6e2e6d87 name-rev: drop name_rev()'s 'generati=
on' and 'distance' parameters
> >     @@ Commit message
> >          'taggerdate' and 'from_tag' parameters as well, but those para=
meters
> >          will be necessary later, after the recursion is eliminated.
> >
> >     -    Drop name_rev()'s 'generation' and 'distance' parameters.
> >     +    Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> >
> >       ## builtin/name-rev.c ##
> >      @@ builtin/name-rev.c: static struct rev_name *create_or_update_na=
me(struct commit *commit,
> > 12:  2d03ac11f3 ! 12:  0cf63c6d64 name-rev: eliminate recursion in name=
_rev()
> >     @@ Commit message
> >          segfault when processing a deep history if it exhausts the ava=
ilable
> >          stack space.  E.g. running 'git name-rev --all' and 'git name-=
rev
> >          HEAD~100000' in the gcc, gecko-dev, llvm, and WebKit repositor=
ies
> >     -    results in segfaults on my machine.
> >     +    results in segfaults on my machine ('ulimit -s' reports 8192kB=
 of
> >     +    stack size limit), and nowadays the former segfaults in the Li=
nux repo
> >     +    as well (it reached the necessasry depth sometime between v5.3=
-rc4 and
> >     +    -rc5).
> >
> >          Eliminate the recursion by inserting the interesting parents i=
nto a
> >     -    'commit_list' and iteratating until the list becomes empty.
> >     +    LIFO 'prio_queue' [1] and iterating until the queue becomes em=
pty.
> >
> >     -    Note that the order in which the parent commits are added to t=
hat list
> >     -    is important: they must be inserted at the beginning of the li=
st, and
> >     -    their relative order must be kept as well, because otherwise
> >     -    performance suffers.
> >     +    Note that the parent commits must be added in reverse order to=
 the
> >     +    LIFO 'prio_queue', so their relative order is preserved during
> >     +    processing, i.e. the first parent should come out first from t=
he
> >     +    queue, because otherwise performance greatly suffers on mergy
> >     +    histories [2].
> >
> >          The stacksize-limited test 'name-rev works in a deep repo' in
> >          't6120-describe.sh' demonstrated this issue and expected failu=
re.  Now
> >     -    the recursion is gone, so flip it to expect success.
> >     -
> >     -    Also gone are the dmesg entries logging the segfault of the gi=
t
> >     -    process on every execution of the test suite.
> >     -
> >     -    Unfortunately, eliminating the recursion comes with a performa=
nce
> >     -    penaly: 'git name-rev --all' tends to be between 15-20% slower=
 than
> >     -    before.
> >     +    the recursion is gone, so flip it to expect success.  Also gon=
e are
> >     +    the dmesg entries logging the segfault of that segfaulting 'gi=
t
> >     +    name-rev' process on every execution of the test suite.
> >
> >          Note that this slightly changes the order of lines in the outp=
ut of
> >          'git name-rev --all', usually swapping two lines every 35 line=
s in
> >     @@ Commit message
> >
> >          This patch is best viewed with '--ignore-all-space'.
> >
> >     +    [1] Early versions of this patch used a 'commit_list', resulti=
ng in
> >     +        ~15% performance penalty for 'git name-rev --all' in 'linu=
x.git',
> >     +        presumably because of the memory allocation and release fo=
r each
> >     +        insertion and removal. Using a LIFO 'prio_queue' has basic=
ally no
> >     +        effect on performance.
> >     +
> >     +    [2] We prefer shorter names, i.e. 'v0.1~234' is preferred over
> >     +        'v0.1^2~5', meaning that usually following the first paren=
t of a
> >     +        merge results in the best name for its ancestors.  So when=
 later
> >     +        we follow the remaining parent(s) of a merge, and reach an=
 already
> >     +        named commit, then we usually find that we can't give that=
 commit
> >     +        a better name, and thus we don't have to visit any of its
> >     +        ancestors again.
> >     +
> >     +        OTOH, if we were to follow the Nth parent of the merge fir=
st, then
> >     +        the name of all its ancestors would include a correspondin=
g '^N'.
> >     +        Those are not the best names for those commits, so when la=
ter we
> >     +        reach an already named commit following the first parent o=
f that
> >     +        merge, then we would have to update the name of that commi=
t and
> >     +        the names of all of its ancestors as well.  Consequently, =
we would
> >     +        have to visit many commits several times, resulting in a
> >     +        significant slowdown.
> >     +
> >          Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> >
> >       ## builtin/name-rev.c ##
> >     +@@
> >     + #include "tag.h"
> >     + #include "refs.h"
> >     + #include "parse-options.h"
> >     ++#include "prio-queue.h"
> >     + #include "sha1-lookup.h"
> >     + #include "commit-slab.h"
> >     +
> >      @@ builtin/name-rev.c: static struct rev_name *create_or_update_na=
me(struct commit *commit,
> >                       return NULL;
> >       }
> >     @@ builtin/name-rev.c: static struct rev_name *create_or_update_nam=
e(struct commit
> >      -                parse_commit(parent);
> >      -                if (parent->date < cutoff)
> >      -                        continue;
> >     -+        struct commit_list *list =3D NULL;
> >     ++        struct prio_queue queue;
> >     ++        struct commit *commit;
> >     ++        struct commit **parents_to_queue =3D NULL;
> >     ++        size_t parents_to_queue_nr, parents_to_queue_alloc =3D 0;
> >      +
> >     -+        commit_list_insert(start_commit, &list);
> >     ++        memset(&queue, 0, sizeof(queue)); /* Use the prio_queue a=
s LIFO */
> >     ++        prio_queue_put(&queue, start_commit);
> >      +
> >     -+        while (list) {
> >     -+                struct commit *commit =3D pop_commit(&list);
> >     ++        while ((commit =3D prio_queue_get(&queue))) {
> >      +                struct rev_name *name =3D get_commit_rev_name(com=
mit);
> >     -+                struct commit_list *parents, *new_parents =3D NUL=
L;
> >     -+                struct commit_list **last_new_parent =3D &new_par=
ents;
> >     ++                struct commit_list *parents;
> >      +                int parent_number =3D 1;
> >      +
> >     ++                parents_to_queue_nr =3D 0;
> >     ++
> >      +                for (parents =3D commit->parents;
> >      +                                parents;
> >      +                                parents =3D parents->next, parent=
_number++) {
> >     @@ builtin/name-rev.c: static struct rev_name *create_or_update_nam=
e(struct commit
> >      -                        distance =3D name->distance + 1;
> >      +                        if (create_or_update_name(parent, new_nam=
e, taggerdate,
> >      +                                                  generation, dis=
tance,
> >     -+                                                  from_tag))
> >     -+                                last_new_parent =3D commit_list_a=
ppend(parent,
> >     -+                                                  last_new_parent=
);
> >     ++                                                  from_tag)) {
> >     ++                                ALLOC_GROW(parents_to_queue,
> >     ++                                           parents_to_queue_nr + =
1,
> >     ++                                           parents_to_queue_alloc=
);
> >     ++                                parents_to_queue[parents_to_queue=
_nr] =3D parent;
> >     ++                                parents_to_queue_nr++;
> >     ++                        }
> >                       }
> >
> >      -                if (create_or_update_name(parent, new_name, tagge=
rdate,
> >      -                                          generation, distance,
> >      -                                          from_tag))
> >      -                        name_rev(parent, new_name, taggerdate, fr=
om_tag);
> >     -+                *last_new_parent =3D list;
> >     -+                list =3D new_parents;
> >     ++                /* The first parent must come out first from the =
prio_queue */
> >     ++                while (parents_to_queue_nr)
> >     ++                        prio_queue_put(&queue,
> >     ++                                       parents_to_queue[--parents=
_to_queue_nr]);
> >               }
> >     ++
> >     ++        clear_prio_queue(&queue);
> >     ++        free(parents_to_queue);
> >       }
> >
> >     + static int subpath_matches(const char *path, const char *filter)
> >
> >       ## t/t6120-describe.sh ##
> >      @@ t/t6120-describe.sh: test_expect_success 'describe tag object' =
'
> > 13:  1ef69550ca ! 13:  316f7af43c name-rev: cleanup name_ref()
> >     @@ builtin/name-rev.c: static struct rev_name *create_or_update_nam=
e(struct commit
> >      -                int from_tag)
> >      +                int from_tag, int deref)
> >       {
> >     -         struct commit_list *list =3D NULL;
> >     +         struct prio_queue queue;
> >     +         struct commit *commit;
> >     +         struct commit **parents_to_queue =3D NULL;
> >     +         size_t parents_to_queue_nr, parents_to_queue_alloc =3D 0;
> >      +        char *to_free =3D NULL;
> >      +
> >      +        parse_commit(start_commit);
> >     @@ builtin/name-rev.c: static struct rev_name *create_or_update_nam=
e(struct commit
> >      +                return;
> >      +        }
> >
> >     -         commit_list_insert(start_commit, &list);
> >     -
> >     +         memset(&queue, 0, sizeof(queue)); /* Use the prio_queue a=
s LIFO */
> >     +         prio_queue_put(&queue, start_commit);
> >      @@ builtin/name-rev.c: static int name_ref(const char *path, const=
 struct object_id *oid, int flags, vo
> >                       if (taggerdate =3D=3D TIME_MAX)
> >                               taggerdate =3D commit->date;
> > 14:  9d513b3092 <  -:  ---------- name-rev: plug a memory leak in name_=
rev()
> > 15:  8489abb62e <  -:  ---------- name-rev: plug a memory leak in name_=
rev() in the deref case
> > --
> > 2.24.0.388.gde53c094ea
> >
> >
