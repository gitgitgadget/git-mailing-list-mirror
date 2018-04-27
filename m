Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 493DF1F404
	for <e@80x24.org>; Fri, 27 Apr 2018 07:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757498AbeD0HqW (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 03:46:22 -0400
Received: from mout.gmx.net ([212.227.17.22]:33419 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757444AbeD0HqW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 03:46:22 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MfEsY-1f0LLs25xC-00OsU1; Fri, 27
 Apr 2018 09:46:19 +0200
Date:   Fri, 27 Apr 2018 09:45:58 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     William Chargin <wchargin@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: In some rebases, `exec git -C ...` has wrong working directory
In-Reply-To: <CAFW+GMAJcCG4mKe4TxFXXrfdRhZKXv8ffC-rNShFLW2J1_FANA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804270939400.72@tvgsbejvaqbjf.bet>
References: <CAFW+GMAJcCG4mKe4TxFXXrfdRhZKXv8ffC-rNShFLW2J1_FANA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:r0bblLfCIxJWrfBVqE9/0Px+I2+v6Ve9NS94P2nOsfvE1Rq9C5O
 1muLrK33BspRyDLniF7/P92KbEW0G9GsNZ6Hj7IlOilUKhe8j/GUiBJ0TrF0uYmRKEX0Wbb
 qViDwMi78akALArv1B2dDjveifZaNXJmPocfyarPh72KoP85LxzWyiv6i4cOQwtI2gUuLiR
 zMMfjEt3LILfvl5pPJNEw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qupP+/+UAJU=:ir2PNlCSWnEKuil2ePlz9i
 racDVNU19vCJ/twRy7qANZGrU7fN8cncWg/TgiEnJYRSJ30zxLrznMe8AQ7ecCyIrfomlkg2p
 dWL86OYW6/DOM5bCvOGX0XDqChph0Qb+EJEKWrpftnlm+Ef5XdsdnCKDGOovBo2oBIEWLm03S
 4c78djIcmOCHIoCWC8lPAfQXys4F7iXFK38yFMnsRQdIKSw1Gt9b4s9x/p+5QWFHkdXdkGFPW
 hjQzHjEFQHfGMQt/D+ygGJJtNKl0cQ25G/FYGUYTIiAFSa3krxKtvSMWr5v6OKKWhDU6GxlRP
 DSGQ3zjTRLoXqJbic0S9njzrLPjbw94Gxsu3hcNQK74vT//6R2eUwIoTQL4ueJny+EGMH42wn
 EJypGekgnEK8oaRwInhfA6Za+jRYYE+ipIbUVDB8GqvHHN5d/Y+MOZ/6srC7nEZ48Jr/oMtXy
 QXqSUsVW+K95YqCcHPMLdujYRPm03Yiln1DmJJdBt5gFycSaXxPzzvQTjoDOs7QhfglmbneJh
 0eKUAS8vOo16UGVlcEOD4Ou8T3BjHem64MGUzjkjw4Y4IflBt93hj+NSYiwvjSpHRBqdjrKRg
 D7FhDmZ6HpieDOnlE6H8RRDIMXaFLAFGOOkZeqEVboLpQP6umsRl0Pzv5ikB6qiadcwURkEO0
 JUlq+Oq7rnPWJUPIbI8zylf55Bh89g9zeiE3bZOgkNoZIH9eJzs31r5WHrwms0QjbvWZ7Gqr+
 /Bn+yDlM+Id1PoqCoX6DOTbXXCjEJx/qRm+XDwaHnyu6pAK3O1CKY323FFuZp2W3Cbj7Wfd1t
 AksxmWk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi William,

On Thu, 26 Apr 2018, William Chargin wrote:

> Here is a repro script:
> 
>     #!/bin/sh
>     set -eux
>     git --version
>     tmpdir="$(mktemp -d)"
>     cd "${tmpdir}"
>     mkdir target repo
>     cd repo
>     git init
>     touch file; git add file
>     git commit -m "Initial commit"
>     git rebase HEAD --exec "git -C ${tmpdir}/target init"

We do take pains to pass the GIT_DIR to the exec'ed command, and it is the
GIT_DIR of the worktree in which the rebase runs.

> The end of this script prints something like
> 
>     Executing: git -C /tmp/tmp.gd2q51jO93/target init
>     Reinitialized existing Git repository in /tmp/tmp.gd2q51jO93/repo/.git/
>     Successfully rebased and updated refs/heads/master.

So that is actually what I expected.

I might even have one or two scripts relying on that feature, where
something like

	exec git -C /somewhere/else show HEAD:some-file >some-other-file

is executed, and works.

> But this is wrong: the repository should be initialized in `target`, not
> reinitialized in `repo`.
> 
> Notes:
> 
>   - This propagates to subprocesses: if you run `exec make test` and
>     your test suite ends up calling `git -C`, then the same problem
>     occurs.
> 
>   - Substituting `rebase --root` for `rebase HEAD` causes the problem to
>     go away.
> 
>   - The `rebase HEAD` exec context adds the `GIT_DIR` environment
>     variable, and this is sufficient to reproduce the problem:
>     running `GIT_DIR="$PWD" git -C /tmp/target init` puts the repo in
>     the current working directory. The `rebase --root` context adds no
>     such environment variable. (You can use `--exec 'env >tempfile'` to
>     verify these.)
> 
> My `git --version` is 2.16.2.

Even `pu` has the same behavior.

I do not think that we can sensibly *remove* GIT_DIR from the environment
variables passed to the exec'ed command, as we have been doing that for
ages, and some scripts (as demonstrated above) started relying on that
behavior. So if we changed it, we would break backwards-compatibility,
which is something we try to avoid very much in Git.

Maybe you could a contribute a patch to the documentation? Something that
tells people who use the `--exec` option that they want to prefix their
command with `unset GIT_DIR; ` when their command wants to work with a
different Git repository than the current one?

Ciao,
Johannes
