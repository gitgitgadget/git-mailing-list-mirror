Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.1 required=3.0 tests=BAYES_00,BODY_8BITS,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,NUMERIC_HTTP_ADDR,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42F1A1F404
	for <e@80x24.org>; Thu, 22 Feb 2018 22:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751542AbeBVWrZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 17:47:25 -0500
Received: from hosted.mailcow.de ([5.1.76.202]:53360 "EHLO hosted.mailcow.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751379AbeBVWrY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 17:47:24 -0500
X-Greylist: delayed 356 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Feb 2018 17:47:24 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=childno.de; s=default;
        t=1519339281;
        h=from:sender:reply-to:subject:date:message-id:to:cc:mime-version:content-type:content-transfer-encoding:resent-to:resent-cc:resent-from:resent-sender:resent-message-id:in-reply-to:references:list-id:list-owner:list-unsubscribe:list-subscribe:list-post;
        bh=f+nfloi+oQpybU01AkYGstegjUquJ4VseNq/O0bA//A=;
        b=Xr5OLK+V5gXhBT2Ys5VCvapaZBYvyT93xNi6mWPK2b0qTadq47HSWW/WH/owCGo50h1xR5
        94WgD70aOy4ys1Q6wjCPxxPjOdtW3qSOS1lHnm1Y6xOTj9FkaGeXnUst2JSBRhzZVGm1fR
        DYx6M2EAM6Y12CSBkfaP9LcN8fJkxQA=
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: marcel@traut.cloud)
        by hosted.mailcow.de (Postfix) with ESMTPSA id A143B5C0F76
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 23:41:21 +0100 (CET)
From:   =?utf-8?B?Ik1hcmNlbCAnY2hpbGROb82hLmRlJyBUcmF1dHdlaW4i?= 
        <c0d3+gitscm@childno.de>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: [BUG] [git 2.16.1] yeeek ... my files are gone .. by git pull
 <otherRepositoryUrl>
Message-Id: <741A56BF-93C0-41EA-856F-C1170803F0A7@childno.de>
Date:   Thu, 22 Feb 2018 23:41:20 +0100
To:     git@vger.kernel.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=childno.de;
        s=default; t=1519339281;
        h=from:sender:reply-to:subject:date:message-id:to:cc:mime-version:content-type:content-transfer-encoding:resent-to:resent-cc:resent-from:resent-sender:resent-message-id:in-reply-to:references:list-id:list-owner:list-unsubscribe:list-subscribe:list-post;
        bh=f+nfloi+oQpybU01AkYGstegjUquJ4VseNq/O0bA//A=;
        b=QLiWNbIDwvlwMmmp4sBdNd2AjEJTIdZ5fBoLsKxnmRhclXJgZx2Qx0y6kQq+jPf8yDdyEA
        JOkN3XKdUokCZRFhYLHz+/BkI2Ghibo6BUBb4ROUi69cU8tvCMMDjZ5UmFsYdLpUyi3D3C
        01Tmj6dy0nqQLbgs0nGh3Yrg6R/jjoE=
ARC-Seal: i=1; s=default; d=childno.de; t=1519339281; a=rsa-sha256;
        cv=none;
        b=SENa/J1pCg6eHbkuA3T/YWS7PQnKMG8uoRQ7T506D/vGzipuUVB3MdM7iQMh+LWEjllpp4aiPSp7wZuD563v2ohK/2FPlK1TsqNf0Uzp68GbX4yqxO1Q/eoPRcEZtARyOkj96gCWWau4ip69tOF8brMlY+JgiCjCWnrnob23SqQ=
ARC-Authentication-Results: i=1; auth=pass smtp.auth=marcel@traut.cloud
        smtp.mailfrom=c0d3@childno.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I think we have a problem =E2=80=A6 or at least I had
and I=E2=80=99m not quite sure if this is =E2=80=9Eworking as =
designed=E2=80=9C
but I=E2=80=99m sure it =E2=80=9Eshould not work as it did=E2=80=9C.

Because? It pruned a lot of files and even the local repository.
by pull
by giving another repository URL instead of a known remote

While working in a subpath of my homedir
(that is a git repository itself, without any changes in worktree or =
index: https://bitbucket.org/childnode/marcel/ )
I wanted to clone another repository =E2=80=A6 but yeah =E2=80=A6 it=E2=80=
=99s late for me today and I put
in s.th. `git pull =
git@private.gitlab.instance.example.com:aGroup/repository.git`

next =E2=80=A6 all committed files are zapped and the repository given =
has been checked out in my home directory =F0=9F=A4=AF=F0=9F=91=BB

what? Shouldn=E2=80=99t this just fail? Why can I pass another remote to =
pull?

=F0=9F=99=8F god any untracked / ignored files are still alive

a, yeh, I=E2=80=99m on a mac=20
(for any git configuration =E2=80=A6 have a look in my repository=20
=
https://bitbucket.org/childnode/marcel/src/88ff8d0c28bb90dfde3aea9e6c39bb5=
51bea8ca8/.gitconfig?at=3Dmaster&fileviewer=3Dfile-view-default

the console out was:
```
-bash:$ git pull =
git@private.gitlab.instance.example.com:aGroup/repository.git
Warning: Permanently added the ECDSA host key for IP address '10.1.2.3' =
to the list of known hosts.
warning: no common commits
remote: Counting objects: 2301, done.
remote: Compressing objects: 100% (710/710), done.
remote: Total 2301 (delta 1040), reused 2239 (delta 1004)
Receiving objects: 100% (2301/2301), 405.41 KiB | 635.00 KiB/s, done.
Resolving deltas: 100% (1040/1040), done.
=46rom private.gitlab.instance.example.com:aGroup/repository
 * branch            HEAD       -> FETCH_HEAD
Fetching submodule .shapps/willgit
Fetching submodule .vim
Fetching submodule .vim/autoload/pathogen
warning: redirecting to https://github.com/tpope/vim-pathogen.git/
Fetching submodule .vim/bundle/ack
warning: redirecting to https://github.com/mileszs/ack.vim.git/
Fetching submodule .vim/bundle/colors-solarized
warning: redirecting to =
https://github.com/altercation/vim-colors-solarized.git/
Fetching submodule .vim/bundle/flake8
Fetching submodule .vim/bundle/fugitive
warning: redirecting to https://github.com/tpope/vim-fugitive.git/
Fetching submodule .vim/bundle/kwbdi
warning: redirecting to https://github.com/vim-scripts/kwbdi.vim.git/
Fetching submodule .vim/bundle/markdown
warning: redirecting to https://github.com/tpope/vim-markdown.git/
Fetching submodule .vim/bundle/nerdtree
warning: redirecting to https://github.com/scrooloose/nerdtree.git/
Fetching submodule .vim/bundle/unimpaired
warning: redirecting to https://github.com/tpope/vim-unimpaired.git/
Fetching submodule =
gists/bitbucket/childnode/2015-06-16_G4pLy_prevent-empty-version-comment-i=
n.git
Fetching submodule =
gists/bitbucket/childnode/2015-06-21_kyAAM_plasticscm-addcurrentworkdir-ba=
tch-task
Fetching submodule =
gists/github/childnode/18de20f4448692257aa3e99c8319b70d
Fetching submodule gists/github/childnode/295dbd6e_hasSize.regex
Fetching submodule =
gists/github/childnode/4a0de936_gradle_buildSrc_dogfood
Fetching submodule gists/github/childnode/66d4b982_git.rebaseAllBranches
Fetching submodule =
gists/github/childnode/6df6d14c_ideaGradleProjectSetupForAdditionalSourceS=
ets
Fetching submodule =
gists/github/childnode/81ae6468_build_jar_manifest.gradle
Fetching submodule =
gists/github/childnode/85958ff8_extendedHelp.gradle_secret
Fetching submodule =
gists/github/childnode/88304258_git_deleteAllRemoteBranches.sh
Fetching submodule =
gists/github/childnode/8f100f90_dockerSaveAllImages.sh
Fetching submodule =
gists/github/childnode/9741c4d1_idea.warnGenerateWorkspace.gradle_secret
Fetching submodule =
gists/github/childnode/a175d954_ext.props.gradle_secret
Fetching submodule =
gists/github/childnode/d15cd5e9_atlassian-confluence-config
Fetching submodule =
gists/github/childnode/d35cf810dd28775ac5c0e491107215fd
Fetching submodule =
gists/github/childnode/da08e8a6f989ce0f94077ae1a6b1573b
Fetching submodule gists/github/childnode/e7ef876c_html2ical_secret
Fetching submodule =
gists/github/childnode/eb3199790f2f82785f62c3150f352ede
Successfully rebased and updated refs/heads/master.

```

trying to fix this up by doing another pull failed:
```
-bash:$ git remote -v
origin	git@bitbucket.org:childnode/marcel.git (fetch)
origin	git@bitbucket.org:childnode/marcel.git (push)

-bash:$ git pull
fatal: refusing to merge unrelated histories

-bash:$ git pull git@bitbucket.org:childnode/marcel.git
=46rom bitbucket.org:childnode/marcel
 * branch            HEAD       -> FETCH_HEAD
fatal: refusing to merge unrelated histories

```

these messages and the fact that it doesn=E2=80=99t work backward let me =
think I ran into
a collision? really?

revlog looks a bit strange too
```
04f3066 (HEAD -> master) HEAD@{0}: pull =
git@private.gitlab.instance.example.com:aGroup/repository.git: checkout =
04f3066d03e09323c7341c472be4c45ea5e3a4ff: returning to refs/heads/master
04f3066 (HEAD -> master) HEAD@{1}: pull =
git@private.gitlab.instance.example.com:aGroup/repository.git: checkout =
04f3066d03e09323c7341c472be4c45ea5e3a4ff
88ff8d0 (origin/master, origin/HEAD) HEAD@{2}: pull --rebase=3Dpreserve: =
checkout 88ff8d0c28bb90dfde3aea9e6c39bb551bea8ca8: returning to =
refs/heads/master
```

where 88ff8d0 was the latest from marcel.git
and logs look like the pulled repository is like an orphan aside my =
original one.=20

~Marcel

P.S: I reverted by `$ git reset 88ff8d0 && git checkout -- .`=
