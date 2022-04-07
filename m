Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90200C433F5
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 18:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244339AbiDGSkr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Apr 2022 14:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232900AbiDGSkq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 14:40:46 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E189181D99
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 11:38:45 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id o18so1668911qtk.7
        for <git@vger.kernel.org>; Thu, 07 Apr 2022 11:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yvhz9OPcA7FLr+8PjNwOHY1tinAMCvpGWBNiBKnXDaU=;
        b=DA9gOo/jFfmRfdVAuvpurTv5SU0ulSx25OqsABXL8eb77dFOOUB2OC9E5t6Jf0KDig
         FR7IibZXPz4tjQDHLZcPhlOPjCtBLEUNbbbXO+r3QBh/KMTCPJVSqmw/9q/zI7ylq3kU
         KwVGY3G2p7Pn+NpoQ8F+Y/7vuxqbJfFEgWewe0XjNsF/SWpdmOPLPaJVZe3/XaDco7wR
         3iQiCxgSf2tomJRzIoWX6/i50Z44KVpS1UTbIOMgxLRTWwNoTpybO20oFHGF8vGmIBcr
         zFwSXo+zFHhqnIW/oituMC27xmcO3l3HAnLwJImdDskTNcoUfHCMBeiTSlzqNQA4PRWt
         i7TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yvhz9OPcA7FLr+8PjNwOHY1tinAMCvpGWBNiBKnXDaU=;
        b=xh4xe7DCNBvHw7DlvXyNWeAIot3a+htivGc58i43Z3u8aV4gdtOH4r2uJhWgic4zdW
         gpLSs5k7iE+gx3oNdIA/eb1YO2Robp5UPDIsAfGjKoxt6+72UcFSgXRdzMK0qMFrVDZc
         MQkktGr9FOAL8f35RABEjSVdSmc6CAQyjhTTKACdMl6raO6PRohZmHLzGzEkw8y14MqE
         8/nDVSKZkeXlylcIsYdgT9TDH8GCfZurkTkj7OFPuPLrot0G9HxP5MArtPIt0/SyuCeT
         2bXgF6rpCGky+umlI/XlJGkFT2w7t42Uvl5StBo/QeCmo3HjEEneyeFQA7fCmtGlirY1
         saHA==
X-Gm-Message-State: AOAM530zj1mRoDry43VxvodDt+vS5s1E0Qr+Aj83ILcpa3HpUWdCiZ0y
        J1tyzqknsEmovJW41zgXYHU=
X-Google-Smtp-Source: ABdhPJyVx/bf8mLzzvq3H75rCMraJk/T8Q6LNKeoZHKAGKOmssfOaS9QsB64rzMw2UVvtowC1Hs6pw==
X-Received: by 2002:ac8:5743:0:b0:2e1:cee6:f15 with SMTP id 3-20020ac85743000000b002e1cee60f15mr12951412qtx.634.1649356722960;
        Thu, 07 Apr 2022 11:38:42 -0700 (PDT)
Received: from [10.37.129.2] (ool-ad03998c.dyn.optonline.net. [173.3.153.140])
        by smtp.gmail.com with ESMTPSA id v9-20020a05620a0a8900b0067db9cc46a9sm11577588qkg.62.2022.04.07.11.38.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Apr 2022 11:38:42 -0700 (PDT)
From:   John Cai <johncai86@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        justin@justinsteven.com, Taylor Blau <me@ttaylorr.com>
Subject: Re: Bare repositories in the working tree are a security risk
Date:   Thu, 07 Apr 2022 14:38:41 -0400
X-Mailer: MailMate (1.14r5852)
Message-ID: <FF4B21A6-A8B6-4142-B325-B9C9193BD885@gmail.com>
In-Reply-To: <kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com>
References: <kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Glen,

This is an interesting find. Thanks for writing it up.

On 6 Apr 2022, at 18:43, Glen Choo wrote:

> Hi all,
>
> My Google colleagues and I would like to address what we think is a sec=
urity
> risk - namely that Git repositories can contain valid bare repositories=
 in their
> working trees. This is based on an excellent article by Justin Steven [=
1] (CC-ed
> here).
>
> Below is a discussion of:
>
> * The risky behavior - what Git does and why it is risky
> * Possible responses to this risk
> * A proposed approach
>
> The proposed changes are nontrivial, so I=E2=80=99d really appreciate a=
ny feedback here.
> Unfortunately, I will be out of the office and won=E2=80=99t respond to=
 emails for the
> next 7 days or so, but there will still be at least one Google Git team=
 member
> keeping tabs on the discussion :)
>
> =3D TL;DR
>
> Git repositories should not be allowed to contain bare repositories in =
their
> working trees because:
>
> * Such bare repositories can have maliciously crafted config files that=
 cause
>   `git` to execute arbitrary code.
> * Git itself can distribute the malicious repo via `git clone`; no need=
 to
>   distribute repos out of band e.g. via tarballs [2].
> * Many `git` commands can be affected by malicious config files, and ma=
ny users
>   have tools that will run `git` in the current directory or the subdir=
ectories
>   of a repo. Once the malicious repo has been cloned, very little socia=
l
>   engineering is needed; the user might only need to open the repo in a=
n editor
>   or `cd` into the correct subdirectory.
>
> =3D Background
>
> (This section is primarily a summary of [1]. I highly, highly recommend=
 reading
> that as it describes the issue in much more detail and is extremely rea=
dable
> regardless of Git experience.)
>
> Certain Git configuration options are particularly enticing targets for=

> attackers, e.g. core.fsmonitor can execute arbitrary commands and is in=
voked
> on many innocuous-looking `git` commands (like `git status`). This is e=
ven more
> risky when one considers that many tools (like shell prompts and IDEs) =
will run
> `git` opportunistically inside a repository - so many users won't even =
need to
> explicitly run `git` to be affected [3].
>
> Since config files are such an enticing target for attackers, Git inten=
tionally
> avoids distributing config files with repos - a user shouldn't be able =
to `git
> clone` a repo with a config file (or really, any files inside .git). Ho=
wever,
> one can 'trick' Git into doing this by embedding a bare repository insi=
de of
> another, containing repository: a repository can contain subdirectories=
 that are
> valid bare repositories, and any `git` operations run in such a subdire=
ctory
> will then use the bare repository=E2=80=99s config file instead of the =
"main"
> repository=E2=80=99s.
>
> An attack might look like this:
>
> * Attacker creates a repository where subdirectory "Documentation/" is =
a bare
>   repository i.e. it contains "HEAD", "refs/" and "objects/" [4]. Attac=
ker
>   also adds "config" with a malicious setting for core.fsmonitor.
> * Attacker convinces User to read their project's documentation by `git=

>   clone`-ing their repository and inspecting the "Documentation/" direc=
tory.
> * User cd-s into "Documentation/" and their shell prompt runs `git stat=
us`,

This might be obvious to most reading this, but for those trying this out=
 at home,
you'll need to create a worktree that points to the bare repository and t=
hen run
`git status` in there.

>   executing the core.fsmonitor command defined by Attacker.

This is easily reproduceable.

>
> =3D What can we do about it?
>
> Each subsection is an alternative and an analysis (+/- are pros/cons).
>
> =3D=3D 1. Prevent users from checking out bare repos
>
> This is similar to an existing mitigation where we prevent repository e=
ntries
> that can be confused for ".git" (like ".GIT"). but it requires checking=
 multiple
> entries instead of a single entry. I suspect that we could accomplish t=
his in
> one of two ways:
>
> a. Prevent bare repos from entering the index.
> b. Prevent writing bare repos to the working tree.
>
> + Relatively robust protection - because the malicious repo never enter=
s the
>   working tree, we even protect other tools (e.g. JGit) from doing dang=
erous
>   things in the embedded repo (provided the checkout is done with `git`=
, of
>   course).
> - This breaks some 'valid' workflows (e.g. someone embedding a bare rep=
o as a
>   more convenient alternative to submodules), but it seems reasonable t=
o let
>   users opt out of this behavior.
> - (1a) is difficult to do in practice because many code paths add entri=
es to
>   the index, and checking a combination of new entry and existing entri=
es is
>   much trickier than checking just the new entry.
> - (1b) might also be difficult, though not as difficult as 1a because w=
e
>   already have a complete list of entries we will write. I don=E2=80=99=
t think there
>   are existing facilities that do this sort of checking of multiple ent=
ries.
>
> =3D=3D 2. Detect and reject bare repos using `git fsck` and `transfer.f=
sckObjects`.
>
> This entails checking for the markers of a bare repository (HEAD, refs/=
,
> objects/) in tree objects. This shares a precedent with (1), since `git=
 fsck`
> will also detect ".GIT".
>
> + Most reputable hosting sites set `transfer.fsckObjects`, which allows=
 them to
>   detect and prevent this kind of transmission.
> + Confers some protection to users even without them doing anything.
> + Easy to visualize and to write.
> - This won=E2=80=99t directly protect most users because they don=E2=80=
=99t typically set
>   `transfer.fsckObjects` (in fact, `transfer.fsckObjects` will render m=
any
>   projects, like linux.git, uncloneable without additional config)
> - Won=E2=80=99t guard against malicious/poorly configured hosts.
>
> =3D=3D 3. Detect that we are in an embedded bare repo and ignore the em=
bedded bare
>  repository in favor of the containing repo.
>
> For example, if setup.c detects that we are in a bare repo, it could th=
en walk
> up the directory hierarchy to see if there is a containing repo that tr=
acks the
> bare one. If so, setup.c chooses to use the containing repo instead.
>
> + Extremely robust; this even protects against a checkout by an earlier=
 Git
>   version.
> + Users who don=E2=80=99t use bare repos won=E2=80=99t even notice the =
difference.
> - The change in rules breaks some legitimate workflows e.g. a user with=
 a repo
>   at HOME and bare repos underneath.
> - Potentially very expensive for bare repo users because setup.c will l=
ikely
>   walk up to the root directory; we=E2=80=99d be essentially *forcing* =
those users to
>   set GIT_CEILING_DIRECTORIES.
> - Doesn=E2=80=99t protect users who use other tools e.g. JGit.
>
> =3D=3D 4. Educate users about this risk without making code changes.
>
> Some risks fall into this category e.g. "Avoid unarchiving repositories=
 because
> .git/config might be poisoned." [2].
>
> + We don=E2=80=99t break any users.
> - Breaks the trust that users have in `git clone`.
> - IMO "Inspect every repo in its entirety before cloning it" is too muc=
h of a
>   burden to put on users.
>
> =3D Next steps
>
> I propose that we prevent repositories from containing bare repositorie=
s by
> doing the following (in order):
>
> * Implement (2) by adding a new fsck message "embeddedBareRepo".
>   * When this is done, hosting sites can hopefully use this capability =
to
>     prevent transmission, and help us understand the prevalence of such=
 attacks.
> * Implement (1b) by teaching unpack_trees.c to check whether the tree c=
ontains
>   an entire bare repo, and die() if so. This will be guarded by a
>   defaults-to-true config value.
>   * This would only block a bare repo from being written in a single op=
eration.
>     It wouldn=E2=80=99t stop a user from writing a bare repo entry-by-e=
ntry using "git
>     checkout <path>", but the amount of social engineering required pro=
bably
>     renders this attack infeasible.
>   * As I noted earlier, I foresee some difficulty actually implementing=
 this
>     because I don=E2=80=99t think we have facilities for checking multi=
ple tree entries
>     at once.
>
> I am particularly interested in hearing feedback about (1b), namely:
>
> * How to actually teach unpack_trees.c to detect bare repos.
> * Whether preventing bare repos in unpack_trees.c is a good enough miti=
gation
>   (e.g. Are there other code paths that should block bare repos? Should=
 we be
>   checking the index instead of the tree?).
>
> I have a patch that does (2); I will send that out and we can leave fee=
dback on
> that separately.
>
> =3D Demonstration
>
> This is based on a script by Taylor Blau (thanks!). [1] also contains a=

> demonstration that runs in Docker.
>
>   #!/bin/sh
>
>   rm -fr malicious cloned &&git init malicious &&
>
>   (
>   cd malicious &&
>
>   mkdir -p bare &&
>   cd bare &&
>
>   echo 'ref: refs/heads/main' >HEAD &&
>   cat >config <<-EOF
>   [core]
>   repositoryformatversion =3D 0
>   filemode =3D true
>   bare =3D false
>   worktree =3D "worktree"
>   fsmonitor =3D "echo pwned >&2; false"
>   EOF
>
>   mkdir objects refs worktree &&
>   touch worktree/.gitkeep &&
>
>   git add . &&
>   git commit -m ".gitkeep" &&
>
>   cd .. &&
>   git add bare &&
>   git commit -m 'initial commit'
>   ) &&
>
>   git clone --no-local malicious cloned &&
>   cd cloned/bare &&
>   git status # pwned
>
> =3D Footnotes
>
> [1] https://github.com/justinsteven/advisories/blob/main/2022_git_burie=
d_bare_repos_and_fsmonitor_various_abuses.md.
> [2] Archived repositories with malicious .git directories are a known r=
isk. See
>  https://lore.kernel.org/git/20171003123239.lisk43a2goxtxkro@sigill.int=
ra.peff.net/
>  for an on-list discussion. This is also described in
>  https://blog.sonarsource.com/securing-developer-tools-git-integrations=

>  (referenced in [1]).
> [3] We even ship such a tool - contrib/completion/git-prompt.sh. A user=
 can pwn
>  themselves with tab completion even if they don=E2=80=99t have a promp=
t configured
> [4] Any directory containing these entries will be recognized as a bare=
 repo, so
>  an attacker could add arbitrary entries to the directory to obfuscate =
the fact
>  that it is a bare repo.
> [*] https://offensi.com/2019/12/16/4-google-cloud-shell-bugs-explained-=
bug-3/ is
>  similar to [1], but uses hooks instead of core.fsmonitor.
