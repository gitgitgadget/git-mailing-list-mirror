Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A163C433B4
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 06:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E84EA60231
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 06:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbhDKGMX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 02:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbhDKGMW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 02:12:22 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587F9C06138B
        for <git@vger.kernel.org>; Sat, 10 Apr 2021 23:12:06 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id z9so8240340ilb.4
        for <git@vger.kernel.org>; Sat, 10 Apr 2021 23:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7xCXjCNeJFxhBmwpBlVoOtRAf4gw3r0PgKLaHhNqy+4=;
        b=nEQSTle4mKXa0H0ExYLJkmTAjwyBYSc2G0Ip/z3txWp5o1GQn7cmBUDBYfC2LAA+dR
         BMkKFZwT005mwRaXMfV3BxSbLioFB8pFjC+j0fFvD447qcdkaB2OLTQkq2WzLvbkXJpn
         JxP+/RvB/HEcwHolVnB3IJbYW5JqG7GmK3xhAtHi0hLvkxovx/qkBXpYEAzABl2RBkxV
         n2G6xqnycg38nneneVQ6fDcDFrKVuHl0IL61yGwwMPWey1D0rx71N4VEEDLIXO/+W42k
         4sHydmjNPqG5P6yZKWv1wD1xd7ALgMu4E9iLuH4E1V59DJvke/FVgSBHN1sTM0F7RArS
         IwoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7xCXjCNeJFxhBmwpBlVoOtRAf4gw3r0PgKLaHhNqy+4=;
        b=LlrZjXPYX/5VsfPn2J3AQIbJPUCXdk8jlAP5am3/iEzbz/sIEuzHM1BXNvLwK42zi5
         4eL8ggInJfsuDIZfScVsknJbrfO+TkUh2S0+QvGcEkt81pzv3NOTtGSP2QbWGFgJvNpm
         dVZc8FirlpmK+T//EOQa39PgQDe9I70iZAcKT7gv5eRHNCQsQbIi0mNZOHTtSGP6O+j0
         WTrvnSpsbulZxeozGks66uN2pYav9lmveDv+uY6NuVOVika1NjuesIRkn8fX3JFANsSb
         IRdXAg1MWHd+r6pKdkJjHOEK64c3yra6Au47fcdt8N7KxAr2s0DBNErAVnG/F44AfMc3
         va3Q==
X-Gm-Message-State: AOAM532Gz97Gbx95Ks4bDKydHMJG0yDDEFHfCnWUcsmhlCeNQmSkk5gM
        aEOZnNrux9mAd3dYmGPFeLj1xEdvlf3ta28ulMl2TOIdowyb09Wi
X-Google-Smtp-Source: ABdhPJxmUaz2m1JmJLK7M/DHZTwl0P+Es4NutK988slgypJyLEqT0o7VrxuEH2b6l59a6NieOrWWTBV4l/sN08hIRJ0=
X-Received: by 2002:a92:d308:: with SMTP id x8mr18150213ila.301.1618121525085;
 Sat, 10 Apr 2021 23:12:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8RfE4nn5NnjZh7xuF09-5=+K+_j_2kP0327HVdR4x_wAQ@mail.gmail.com>
In-Reply-To: <CAOLTT8RfE4nn5NnjZh7xuF09-5=+K+_j_2kP0327HVdR4x_wAQ@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 11 Apr 2021 14:11:49 +0800
Message-ID: <CAOLTT8RTA0inxgxbd3qDToKYxwgXGKvJikXWsXg7oQ4asFj+HQ@mail.gmail.com>
Subject: Re: GSoC Git Proposal Draft - ZheNing Hu
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom verma <hariom18599@gmail.com>,
        Jeff King <peff@peff.net>,
        Shourya Shukla <periperidip@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Jiang Xin <worldhello.net@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is my GSoC 2021 Proposal draft v2.
And website version is there :
https://docs.google.com/document/d/119k-Xa4CKOt5rC1gg1cqPr6H3MvdgTUizndJGAo=
1Erk/edit
Welcome any Comments and Correct :)

-------8<---------
Use ref-filter formats in git cat-file

About Me

Name ZheNing Hu
Major Computer Science And Technology
Mobile no. +86 15058356458
Email adlternative@gmail.com
IRC adlternative (on #git-devel/#git@freenode)
Github https://github.com/adlternative/
Blogs https://adlternative.github.io/
Time Zone CST (UTC +08:00)

Education & Background

I am currently a 2nd Year Student majoring in
computer science and technology in Xi'an University
of Posts & Telecommunications (China). In my freshman
year,I joined the XiYou Linux Group of the university
and learned how to use Git to submit my own code to GitHub.
I have learned C, C++, Python and shell in two years,
I know how to use gdb debugging, and I am familiar with
relevant knowledge of Linux System Programming and Linux
Network Programming. I started learning Git source code
and made contributions to Git from December of 2020.


Me & Git

Around last November, I found a couple of projects on
GitHub[1] teaching me how to write a simple Git, the mechanics
of Git are very interesting:
1. There are four types of objects in Git: blob, tree, commit, tag.
2. The (loose)objects(with SHA-1 hash algorithm) are stored in
".git/objects/sha1[0-1]/sha1[2-39]" with the sha1 value of the object
data as the storage address.
3. All branches are just references to commits.
...
Then I read =E3=80=8APro Git=E3=80=8B and Jiang Xin's =E3=80=8AGit Authorit=
ative Guide=E3=80=8B,
learned the use of most Git subcommands.
Later, I started learning some of the Git source code, I found Git has
at least 200,000 lines of C code and 200,000 lines of shell script code,
which leaves me a little confused about where to start. But then, after I
submitted my first patch, a lot of people in the Git community came over an=
d
gave me very enthusiastic guidance, which gave me the courage to learn the
Git source code, and then I started making my own contributions, You can fi=
nd
them here:[2][3]
And These patches are in Git master branch:
[master]
difftool.c: learn a new way start at specified file
https://lore.kernel.org/git/pull.870.v6.git.1613739235241.gitgitgadget@gmai=
l.com/

ls-files.c: add --deduplicate option
https://lore.kernel.org/git/384f77a4c188456854bd86335e9bdc8018097a5f.161148=
5667.git.gitgitgadget@gmail.com/

ls_files.c: consolidate two for loops into one
https://lore.kernel.org/git/f9d5e44d2c08b9e3d05a73b0a6e520ef7bb889c9.161148=
5667.git.gitgitgadget@gmail.com/

ls_files.c: bugfix for --deleted and --modified
https://lore.kernel.org/git/8b02367a359e62d7721b9078ac8393a467d83724.161148=
5667.git.gitgitgadget@gmail.com/

builtin/*: update usage format
https://lore.kernel.org/git/d3eb6dcff1468645560c16e1d8753002cbd7f143.160994=
4243.git.gitgitgadget@gmail.com/

format-patch: allow a non-integral version numbers
https://lore.kernel.org/git/pull.885.v10.git.1616497946427.gitgitgadget@gma=
il.com/

[GSOC] commit: add --trailer option
https://lore.kernel.org/git/pull.901.v14.git.1616507757999.gitgitgadget@gma=
il.com/

And These patches are working:
[wip]
gitk: add right-click context menu for tags
https://lore.kernel.org/git/pull.866.v5.git.1614227923637.gitgitgadget@gmai=
l.com/

[GSOC] trailer: add new .cmd config option
https://lore.kernel.org/git/3dc8983a47020fb417bb8c6c3d835e609b13c155.161797=
5462.git.gitgitgadget@gmail.com/

[GSOC] docs: correct descript of trailer.<token>.command
https://lore.kernel.org/git/505903811df83cf26f4dd70c5b811dde169896a2.161797=
5462.git.gitgitgadget@gmail.com/

[GSOC] ref-filter: get rid of show_ref_array_item
https://lore.kernel.org/git/pull.927.v2.git.1617809209164.gitgitgadget@gmai=
l.com/

Proposed Project

Current situation
Git used to have an old problem of duplicated implementations of some logic=
.
For example, Git had at least 4 different implementations to format command
output for different commands. E.g. `git cat-file --batch=3D=E2=80=9C%(obje=
ctname)=E2=80=9D`,
`git log --pretty=3D=E2=80=9C%aN=E2=80=9D`, `git for-each-ref --format=3D=
=E2=80=9C%(refname)=E2=80=9D`.

Which implementations have been merged together?

2018 ~ 2019
Olga Telezhnaia: Reuse ref-filter formatting logic in `git cat-file`
Olga Integrate some `git cat-file` logic into the `ref-filter`, now almost
all format atoms in the `git cat-file` are available in the `git for-each-r=
ef`,
e.g. `git for-each-ref --format=3D=E2=80=9C%(objectsize:disk) %(deltabase) =
=E2=80=9D`.

2020 ~ 2021
Hariom Verma: Unify ref-filter formats with other --pretty formats
Hariom migrated some of the '--pretty' logic to the 'ref-filter',
e.g. `git for-each-ref --format=3D"%(trailers:key=3DSigned-off-by)"`
or ` git for-each-ref --format=3D"%(subject:sanitize)"`.

What=E2=80=99s git cat-file?
`git cat-file` is a Git subcommand used to see information about a
Git object.
`git cat-file --batch` can read objects from stdin and print each
object information and contents to stdout.
`git --batch-check` can read objects from stdin and print each
object information to stdout.
`--batch-all-objects`  will show all objects info in the git repo
with `--batch` or `--batch-check`.
`--batch-check` and `--batch` both accept a custom format that can
have placeholders like the following, refer to here[4]:

%(objectname) The full hex representation of the object name.
%(objecttype) The type of the object.
%(objectsize) The size, in bytes, of the object.
%(objectsize:disk) The size, in bytes, that the object takes up on disk.
%(deltatbase) If the object is stored as a delta on-disk, this expands to
the full hex representation of the delta base object name.
Otherwise, expands to the null OID (all zeroes).
%(rest) If this atom is used in the output string, input lines are
  split at the first whitespace boundary. All characters before
that whitespace are considered to be the object name; characters
after that first run of whitespace (i.e., the "rest" of the line)
are output in place of the `%(rest)` atom.

What=E2=80=99s the original design of git cat-file --batch?
1. First time use `expand_format()` in `batch_objects()` is used to
parse format atoms, this will determine what data we need to capture.
2. Read the object name from standard input,and use it to get the
object's oid from `get_oid_with_context()`.
3. In `batch_object_write()`, `oid_object_info_extended()` will obtain
the object information which we need.
4. Second time use `expand_format()` in `batch_object_write()`, will
formatting actual items, and store it in a string buffer, eventually
the contents of this buffer will be printed to standard output.


What are the disadvantages in git cat-file --batch?
atom format-parsing stage and formatting actual items stage are not
separated yet. This limits the ability of `git cat-file --batch` to
support richer formats like `git for-each-ref` or `git log --pretty`.


Why is Olga=E2=80=99s solution rejected?
1. Olga's solution is to let `git cat-file` use the `ref-filter` interface,
the performance of `cat-file` appears to be degraded due "very eager to
allocate lots of separate strings" in `ref-filter` and other reasons.
2. Then Olga adopted the method of optimizing `ref-filter`, but the
performance of `git cat-file` is still not as good as the previous method.
3. Too long patch series, difficult to adjust and merge.
4. Is =E2=80=9C%(rest)=E2=80=9D worth migrating? =E2=80=9C%(rest)=E2=80=9D =
is for `git cat-file --batch`
which will be read from the terminal, anything after the space on each line
will continue to be printed, this option is quite unnecessary for
`git for-each-ref`, which does not require standard input.


My possible solution
1. Analyze how to get data which `oid_object_info_extended()` can't
get directly, analyze the minimum amount of data required for each
step of atom format parsing.
2. Find a uniform way to parse format, like `%an` in `log --pretty`
or `%(authorname)` in `ref-filter`(might it can learn something from
`git config` or can try using abstract syntax trees for format atoms parsin=
g).
3. Apply the new interface to 'git cat-file', and then we could add
richer options for `git cat-file`.
4. (Optional optimization) Change the strbuf allocate strategy of `ref-filt=
er`:
Use a single strbuf for all refs output. Improving its performance, reducin=
g the
overhead of allocating large numbers of small strbuf.
5. (Optional optimization) In addition, if we migrate `cat-file` to `ref-fi=
lter`
only with improved performance of `ref-filter`, we need to isolate
some atoms that
are not applicable to `cat-files`. For example, `refname` is not useful for
`git cat-file`, we can exit the program by using `die()` or just print
error messages.

Are you applying for other Projects?

No, Git is the only one.

Blogging about Git

In fact, while I am studying Git source code, I often write some
blogs[5] to record
my learning content, this helps me to recall some content after
forgetting it. Most
of the blogs were written in Chinese previously, but during the GSoC,
I promise all
my blogs will be written in English.


Time Line

May 18 ~ June 18
1. Learn the details of atom format parsing in `ref-filter.c` and `pretty.c=
`.
Think about how to combine two different atom formats in a parsing way.
(For example, how can we use abstract syntax trees to organize different at=
oms)
2. Analyze and optimize `ref-filter` performance.
3. Discuss with mentors about a reasonable solution about uniform
formatting parsing,
and then start coding it.
June 18 ~ July 18
1. Continue to integrate the atom format parsing and apply it to `pretty.c`=
 and
`ref-filter.c`.
2. Make sure that the performance of `git for-each-ref` and `git log --pret=
ty`
are better than the previous methods under the new format parsing interface=
.
July 18 ~ August 17
1. Let `git cat-file` use the new and better formatting parsing interface.
2. Support more options for `cat-file --batch` and ensure isolation from th=
ose
different types of atoms.

Availability

I have plenty of time before and after my final exam, I have enough
energy to complete
daily tasks. I'm staying active on the Git mailing list, you can find
me at any time as
long as I am not sleeping. :)

Post GSoC

I love open source philosophy, willing to spread the spirit of
openness, freedom and
willing to research technology with like-minded people.
In my previous contact with the Git community in the past few months,
many people in the
Git community gave me great encouragement. I hope I can keep my
passion for Git alive,
contribute my own code, and pass this cool thing on. I am willing to
contribute code to
the Git community for a long time after the end of GSoC.
I hope the Git community can give me a chance to participate in GSoC.
I sincerely thank
GSoC and the Git community!


________________
[1] https://github.com/danistefanovic/build-your-own-x#build-your-own-git
[2] https://github.com/gitgitgadget/git/pulls?q=3Dis%3Apr+author%3Aadlterna=
tive+
[3] https://git.kernel.org/pub/scm/git/git.git/log/?qt=3Dgrep&q=3DZheNing+H=
u
[4] https://github.com/gitgitgadget/git/blob/89b43f80a514aee58b662ad606e635=
2e03eaeee4/Documentation/git-cat-file.txt#L189
[5] https://adlternative.github.io/tags/git/
