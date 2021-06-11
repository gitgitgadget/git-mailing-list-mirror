Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39C3C48BD1
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 09:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3C18613DD
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 09:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhFKJv2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 05:51:28 -0400
Received: from mout.gmx.net ([212.227.15.18]:57903 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229480AbhFKJvX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 05:51:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1623404960;
        bh=Z2ysDBDAxHYbdEyhk1b1BXlbGMUT+NxIurA8H25Qiqc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=IzhzYwmn3KuBXDTGHvgpJC1Png0xfTddkNfRHqjYqcDDOnSDYiJ/E8B4mZ+LY0rc3
         XiPzKo9BAAjRhCzxAUdbdWqStgBK5+xEhOZRpYcfi4WH2euL7uM/j1wT7xxcaOacDN
         mK2J2qmEJ3n8L7pPF+PvXosxtFF3a0hj82/wTFng=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.14.142] ([89.1.213.18]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MsYv3-1l2R110js3-00txuX; Fri, 11
 Jun 2021 11:49:20 +0200
Date:   Fri, 11 Jun 2021 11:49:18 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Tao Klerks <tao@klerks.biz>
cc:     git <git@vger.kernel.org>, Jeff Hostetler <jeffhost@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: Windows: core.useBuiltinFSMonitor without core.untrackedcache
 - performance hazard?
In-Reply-To: <CAPMMpog7bNNPm3suZKu6OppHA+KDYgCfmaxW4HqTAr7_tTVAPQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2106111122010.57@tvgsbejvaqbjf.bet>
References: <CAPMMpog7bNNPm3suZKu6OppHA+KDYgCfmaxW4HqTAr7_tTVAPQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:1rYFziaITrqcCoZzUnwo4OBlkIbXHsu5G23zu9BMVZzFVlkIHa6
 1qdOD6a9OjrxN0b6xVYHWw3zhLl53qSEWRbcNSw5j9VujfFmVvGLA1wgAw7oJdAQ2skJpX7
 F7N90AXeQffNJUvmdgwskvte0F0/EF/JoUuya58v2a2IVJtN/fX0UILfjUFUNdxLgWEgXFo
 7QTBrQ8eCsr/67VYUkWOg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YkCiz18+Rik=:wisodtFDUuqN6x+eWyrM1b
 osOaFZuXu7yiyqxPwwbxVWV3IrlBC13bSGjMzMRZtha+2odowVdhUf/KQi0Wa/G4FqdCsPI2I
 ilufkJm9lVsmj4SAVgTw74kIX5D5DGd417yIbPkfFfvGiHtQ1PqAcvMij3HQ4StsTgFouQr8T
 6VUcuP0qOmY0f75DcKfizDqnaeybLdP1oRG77vx3aA6uk2V8gUmK5GSSQ05W89kclzSQ5NFwt
 zJacZJvkPBi58fcVZsDDTnSLOAKAO8YYHSrFpy0i0w/ZdI8GZ0PCZrlQdzb7xZ+W7UfdkYnmz
 aKNAzNZuXFTUCBF48/3UYZ62V5828u3QBJrv3BGUz0iOXne0q4bT8fuHMJZ3kOJs2nzDaFPON
 BGU4yu0gpPCmpCmr5s1v/EAf++AXQbdijLG8UAgC1/0flhb4l/xNT2B8rotDzjEkyRHpdgkwT
 7o6x4Y7dG+0GjBVHNOlPYjik09IDJt/Syui7n0Q/1YdlH8V4P2nZ78F8x2BvNUrmluY8lhtEh
 zKRbotOpwLl1w2sstJoV7Zryfi9J8lNF+TnbnZv+T2PsvueE4fSMK2inSxH9li5+PKi9pL2Qj
 mSRQCSkpkIq/Gl5AMDNevpkPj7TYIZkfZspP+5XIONy600fB+6eWQR5l8xB9PK2KgwApYJ38R
 OuV+/x3u/SMo7yVV1fsWyoC59I0nWYEwYvbmBb6Ezo+pHuixnDjXeknqxS0bnRk9l0M4FKCN5
 XJpeQxrXsVN0E47X91FWmnPFFKVj9aXeGT9lxiLaY5s4+iqwTsdjzGrqngwhiIT8hUKJF5xIg
 OZTkIPG403QILoamh3iqpxDkIa8CV6JNmWEt8N79houVnTJ27FxEZaTAcC9qLOnQIw/jkb3ke
 FHjrD707/NHI0Aw/wqDDM9DG0aD5LR+a+gtV2gToH3On0JvI7QDSufNQ/3wEPkAOA8clrq99t
 wTQpFhSg2h65a+s7pGC3YDdYa9uMtx8Ske5ILXdOQVs1uWQiB4dMu66L2zGWXA0zwqxxoH2GK
 7lBEjD0+6yAYjDJ0s6KR99T8xAiQDHB6zyjTHgTUBftJNg1HN1fZqNocQCsgUR13MHVubR4Pe
 kNvBl5/Bzj4pwdTff2hKLJ13enS1iqVU62mDgya4Ezofw44h+ysMO/Iqg==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Tao,

thank you for chiming in! It is good to see that more people are dabbling
with the built-in FSMonitor.

On Thu, 10 Jun 2021, Tao Klerks wrote:

> With the new "core.useBuiltinFSMonitor" support in the Windows
> installer, I think this subject is worth calling out explicitly (and
> my apologies if I missed prior discussion):
>
> TL;DR:
>  - I believe "core.untrackedcache" should be enabled by default in
> Windows (and it does not appear to be)

Stolee indicated something similar that matches your observation:
https://lore.kernel.org/git/af7a671c-fa32-6d9a-7d75-65582fdbcf24@gmail.com=
/

	Interestingly, the untracked cache extension makes a big
	difference here. The performance of the overall behavior is much
	faster if the untracked cache exists (when paired with the builtin
	FS Monitor; it doesn't make a significant difference when FS
	Monitor is disabled).

>  - If a user enables "core.useBuiltinFSMonitor" (eg in the installer)
> in the hopes of getting snappy "git status" on a repo with a large
> deep working tree, they will be *unnecessarily* disappointed if
> "core.untrackedcache" is not enabled

Yes.

And. Unfortunately, there is an "and". I recently got a chance to work
with the Functional Tests of Scalar ("an opinionated repository management
tool" on top of Git, see https://github.com/microsoft/scalar#readme for
more details). Essentially, you can think of that test suite as
integration tests for Git in a large-scale context. And there, I ran into
trouble with the untracked cache on Windows (where it really provides the
most benefit).

The gist of it is that _sometimes_, the mtime of a directory seems not to
be updated immediately after an item in it was modified/added/deleted. And
that mtime is precisely what the untracked cache depends on.

The funny thing is: while the output of `git status` will therefore at
first fail to pick up on, say, a new untracked file, running `git status`
_immediately_ afterwards _will succeed_ to see that untracked file. So
there is something fishy going on with updating things (it might even be a
foul interaction between the FSCache and the untracked cache, but I have
no evidence to back that up or to disprove it).

It is one of my big TODOs to look into that. If you have any insights, or
time to investigate, I woud be really interested.

>  - There is also a lingering "problem" with "git status -uall", with
> both "core.useBuiltinFSMonitor" and "core.fsmonitor", but that seems
> far less trivial to address

Interesting. I guess the untracked cache might become too clunky with many
untracked files? Or is there something else going on?

> Detail:
>
> I just started testing the new "core.useBuiltinFSMonitor" option in
> the new installer, and it's amazing, thanks Ben, Alex, Johannes and
> Kevin!

Not to forget Jeff Hostetler, who essentially spent the past half year on
it on his own.

> However, when I first enabled it, I was getting slightly *worse* git
> status times than without it... and those worse git status times were
> accompanied by a message along the lines of:
> ---
> It took 5.88 seconds to enumerate untracked files. 'status -uno' may
> speed it up, but you have to be careful not to forget to add new files
> yourself (see 'git help status').
> ---
>
> For context, this is in a repo with 200,000 or so files, within 40,000
> folders (avg path depth 4 I think?), with a reasonably-intricate set
> of .gitignore patterns. Obviously that's not "your average user", but
> I would imagine it matches "the target audience for
> 'core.useBuiltinFSMonitor'" pretty well.

Right. I had a somewhat similar setup, with Git for Windows' SDK, which
consists of ~160k files in ~8k directories.

My `.gitignore` consists of only ~40 heavily commented lines (containing
five lines with wildcards), but I do have a `.git/info/exclude` that
contains a set of generated file/directory lists, i.e. without any
wildcards. This `exclude` file is ~26k lines long.

A cold-cache `git status` takes ~24sec, a warm-cache one ~10sec (with the
built-in FSMonitor daemon now active).

My guess is that the amount of work to match the untracked vs ignored
files is dominating the entire operation, by a lot.

> After a little head-scratching, I recalled an exchange with Johannes
> from last year:
> https://lore.kernel.org/git/CAPMMpohJicVeCaKsPvommYbGEH-D1V02TTMaiVTV8ux=
+9z9vkQ@mail.gmail.com/
>
> I never did understand the relevant code paths in much detail, but the
> practical conclusions were:
>  - Without "core.untrackedcache" enabled, git ends up iterating
> through the entire path structure of the working tree *even if
> "core.fsmonitor" (and now "core.useBuiltinFSMonitor") is enabled*,
> looking for untracked files to report
>  - Even with "core.untrackedcache" enabled, if "core.fsmonitor" (and
> now "core.useBuiltinFSMonitor") is enabled, git iterates through the
> entire path structure of the working tree *single-threaded* when the
> "--untracked-files" mode is set to "all" (by config or command-line)
>
> Now, I imagine that addressing/improving these behaviors is very
> non-trivial, but the impact could be reasonably limited if:
>  - core.untrackedcache were defaulted to "true", at least under
> Windows, at least when the installer is asked to set
> core.useBuiltinFSMonitor

As soon as I can fix the flakiness of the untracked cache on Windows, I
will do that!

>  - The "It took N.NN seconds to enumerate untracked files" message
> were to include a hint about core.untrackedcache, at least when the
> "--untracked-files" mode is set to "normal".
>
> Final note: I personally would love to see "core.useBuiltinFSMonitor
> actually makes things slower, when --untracked-files=3Dall is specified"
> behavior be addressed,

Yes, we need to spend some quality time with some perf tools there.

> because common windows git integrations or front-ends like Git
> Extensions or IntelliJ IDEA commonly use those options, and therefore
> "suffer" a performance degradation on at least some operations when
> core.useBuiltinFSMonitor is enabled.
>
> I don't know whether this is the right place to report Windows-centric
> concerns, if not, my apologies.

I would not necessarily call them "Windows-centric", even if yes, at the
moment the built-in FSMonitor is most easily enabled on Windows (because I
added that experimental option in Git for Windows' installer, after
integrating the experimental feature).

Instead, I consider this more the type of feedback concerning large
worktrees, and what Git can do to support that use case better.

In particular the built-in FSMonitor, which already supports Windows and
macOS, and hopefully we will find volunteers to work on the Linux side
soon, too. In my mind, the built-in FSMonitor, the untracked cache, and
`git maintenance` are _crucial_ tools to allow Git to scale up.

So: thank you for your wonderful feedback!

Ciao,
Dscho
