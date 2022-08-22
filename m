Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E61C28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 13:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbiHVNWw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 09:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234000AbiHVNWt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 09:22:49 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D81E29806
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 06:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661174557;
        bh=UIPwCkcQCaSFo42M0/X6/gUuBxLQOML//1CXxJpHVEg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=AE4xL4TZ0d8LciAUPRyKZZMnPgxet3WqzFnsmFJ4c+U6De/UIsa2Ys7a7PaG54Kel
         YxVJ2SG4aNoCO4m8dgYc2oGIfeoL0mkhX8ZG0aA7Ac3e99ZXBSL1bfwqKiSVEkLFhf
         qHb5xo1UZxALmbhHI5eg2bi8WL7LAUtOgFX8iqlU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.137.196] ([89.1.212.11]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MEFzr-1oZmR60Pun-00AG2l; Mon, 22
 Aug 2022 15:22:37 +0200
Date:   Mon, 22 Aug 2022 15:22:36 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH] fsmonitor: option to allow fsmonitor to run against
 network-mounted repos
In-Reply-To: <xmqqsflqlfjq.fsf@gitster.g>
Message-ID: <092oq98r-39q3-4s66-0n0p-r77po7pq8275@tzk.qr>
References: <pull.1326.git.1660855703816.gitgitgadget@gmail.com> <xmqqsflqlfjq.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:DKZg2OO+ACGeUMNNInKyDx5Vz5DkZTEiMl4nbLwNEgS55KuhMwR
 niBGPQnf/CcOyAkgOjm7xApHJfett7nHoT+bTmVUIVJz+6FNXDSzUnyQajvjAwIoXrsoshd
 mz4uWlZ6oMW63IhAuk+HEoO4UQnwM+jL/HVneD9fhPWLn6h69HNgouS/L6Jff6Xey8XWEB6
 21cio4ZUNNBa9dHJ/trcg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:I6mmL56hq/c=:iZhIAIhWu3hddeYT551Rfi
 smHa0OMd5BdRuTg35JFAj4r7lPMBCwhh08OsS/UsJGKDkc7pGheTIK8munMZedDKz9NR+5ZY2
 AN3C9ne6TGnnobRotu7RyxloFGCrCwlTosvOHNoiquQaOpjwtKQVQMrYv31rUZvZSQQvdgXNV
 TKOd1iUkWyYR9T/15FYPTW9HbaerQBO6tRy9D+S+LQNLXlhBfbbrfpNKq5jL3ucdEEqlBFCBK
 FyYsBikOR1oP4jmCOwY57W900d5E28s/YHOnM2P9xl9grndj2Kl+lF2gjZxYqnZwg3pQnjq7y
 v1tefdpp3ploGh85ZkKesSUUUOjyV6krXu43z/dj1NActC8euqEqZ2+NMbhRgBnPbZc5so8jg
 JkZwwvaOlozNYqokHNK0/LYbOfUqxHd9pLh0FWp7UEu98rve+ENsCBV3KuFXl9QH0bXUXFhTt
 TrQqCPDpNbD53X20VLXwA4a6p5rneSWr0qGx2uC2THnz0JUE3h5SxuLt5xO3m3sQMX+LQvmjR
 6xqA44Z9NEVJv8F+G1R2ioq9P9okLJZ8CAjkmthLlvIVUESLsJElZYbxwhlJGaCG/6ZvzFigY
 q6jsYK7U8TXelFJjklAci/504NMisVI+ckqu7/PwCX2VojARxMOjuOBTvVRNe9CO04bwKLM9A
 k+hmEI7AgLLCRfgCzTsN2fQILpAmteE/cEvfSWavZ+El73+VjY7AriwAkzu+lSWO+QlWlF1Tn
 nAExIpcuvA12z1lXx4jSg4Y77hZEWWWHn10v3OGGCLO2CdkE9iSEkbJvE2HYaEbIivK4DgWHY
 NJn+FQIQu8NS7KaezxweTwYkTTYSahR/Gw5jrSPcWnlX+na2PGmHkJv8MmTiZgO+y0MWMbNtP
 kSLZ8oDtBm4aOGVjF13ifNpmhKVxbse3+4zjM5Jae+f1W48jfw3jMuSEz8g8QdiA7rF4Idhy5
 OnloTXOxUBBIsBOfnCiS/AMFDdLwODlwMoVnjyZGKWa2pvC8ZD6nXnUJaPmN6fbF/wjLPtOay
 eTRto2ZJa60YBykcFXbQOBDJCMGxYQoWTwBZMdkjwWNU03hocbYu+ZDKgTc9+7NzvsqK9ojLb
 JV+kzCZbHrbfD7NB7/z3ULpTKxOQZXSXc+/2DFE14Z5bX6VfkPfDC0mtA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sat, 20 Aug 2022, Junio C Hamano wrote:

> > As a first step towards enabling fsmonitor to work against
> > network-mounted repos, a configuration option, 'fsmonitor.allowRemote'
> > was introduced for Windows. Setting this option to true will override
> > the default behavior (erroring-out) when a network-mounted repo is
> > detected by fsmonitor. In order for macOS to have parity with Windows,
> > the same option is now introduced for macOS.
>
> With this merged in, recent CI runs for 'seen'
>
> e.g. https://github.com/git/git/actions/runs/2892889122
>
> seems to break macOS jobs, letting them hog CPU forever and exceed
> 6hr or whatever the limit is.
>
> As an experiment I pushed out 'seen' but without this commit (not
> the entire topic is excluded, the Windows one is still included).
> As there is nothing specific to macOS between 'next' and 'seen',
> macOS jobs seem to pass, which is not very surprising.
>
> https://github.com/git/git/actions/runs/2896207171
>
> As the patch collected some review comments, I've already marked it
> in the "What's cooking" draft as expecting a reroll of that step;
> until that happens, let's keep it out of 'seen'.

It makes sense to keep it out of `seen`, and at the same time I would like
to encourage Eric to investigate what causes those time-outs.

When toggling timestamps (click on the wheel on the upper right) at
https://github.com/git/git/runs/7927812510?check_suite_focus=3Dtrue#step:4=
:1774,
it can be seen that at close to 1am, t9903 finished, but then nothing
happens until twenty past 6am.

I've downloaded the raw logs (also available via the wheel on the upper
right) to find out which test timed out:

	$ diff -u \
	  <(sed -n 's/.*\] \(t[0-9][^ ]*\).*/\1/p' <~/Downloads/17 | sort) \
	  <(git ls-tree upstream/seen:t | cut -c 54- | grep '^t[0-9].*-.*sh$')

	--- /dev/fd/63  2022-08-22 14:56:05.510269527 +0200
	+++ /dev/fd/62  2022-08-22 14:56:05.510269527 +0200
	@@ -794,6 +794,7 @@
	 t7524-commit-summary.sh
	 t7525-status-rename.sh
	 t7526-commit-pathspec-file.sh
	+t7527-builtin-fsmonitor.sh
	 t7528-signed-commit-ssh.sh
	 t7600-merge.sh
	 t7601-merge-pull-config.sh
	@@ -945,6 +946,7 @@
	 t9812-git-p4-wildcards.sh
	 t9813-git-p4-preserve-users.sh
	 t9814-git-p4-rename.sh
	+t9815-git-p4-submit-fail.sh
	 t9816-git-p4-locked.sh
	 t9817-git-p4-exclude.sh
	 t9818-git-p4-block.sh
	@@ -964,5 +966,8 @@
	 t9832-unshelve.sh
	 t9833-errors.sh
	 t9834-git-p4-file-dir-bug.sh
	+t9835-git-p4-metadata-encoding-python2.sh
	+t9836-git-p4-metadata-encoding-python3.sh
	 t9901-git-web--browse.sh
	+t9902-completion.sh
	 t9903-bash-prompt.sh

I have no idea what's up with t98* and t9902, but I would bet that they
were somehow "swallowed" by `prove` being terminated, and that the
actual test script that times out is t7527.

Eric: To investigate, you will want to reproduce the problem on a macOS
machine. If you have none available, you could create a temporary branch,
heavily edit the CI definition, and push it to GitHub. And by heavy edits
I mean something like this:

- Remove all non-macOS jobs from `.github/workflows/main.yml` (that means
  removing all but the `regular` job, removing all but at least one
  `macos` matrix entry, and removing the the `needs: ci-config` and
  corresponding `if:` line.

- Edit `t/Makefile` to define `T =3D t7527-builtin-fsmonitor.sh` instead o=
f
  running all the tests.

- Edit `.github/workflows/main.yml` so that the step that causes the
  time-out has a chance of timing out much sooner (and the subsequent
  steps then have a chance to upload the relevant logs):
  https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-g=
ithub-actions#jobsjob_idstepstimeout-minutes

If this does not shed any light into the issue, please let me know, I have
a couple more aces up my sleeve.

Ciao,
Dscho
