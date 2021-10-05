Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9631CC433EF
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 10:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8094661251
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 10:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbhJEKzf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 06:55:35 -0400
Received: from mout.gmx.net ([212.227.15.15]:38109 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234160AbhJEKzf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 06:55:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1633431223;
        bh=5F/RJrbUA22kJ0+KNkKdSaR4K3xo3kGcjuXS2oMa3/s=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=QpE9sDMrjVeEAwNbJoX4PqHsQO51+e7xlbT1ExFNZJRf/XjfB+a9H/v2dhC8vG9Qn
         gbP/HACR10OvlNrgg36ztcYu7TcVCQEXaNuJqGLJwIXKCrhmERESzRgWpcU8NMMLkC
         fR2sAbUcdx25MOZrz3BusBqm7kZpvSJbSqyT9PJ8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.23.42] ([89.1.214.13]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGQnP-1mZ3Vq2ntt-00GouM; Tue, 05
 Oct 2021 12:53:43 +0200
Date:   Tue, 5 Oct 2021 12:53:42 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Philip Oakley <philipoakley@iee.email>
cc:     Git List <git@vger.kernel.org>
Subject: Re: Trimming 'deadheads' (TREESAME 2nd parent) from revision
 walks?
In-Reply-To: <01fe28d8-2887-bc42-c91b-c3237b5186a7@iee.email>
Message-ID: <nycvar.QRO.7.76.6.2110051244000.395@tvgsbejvaqbjf.bet>
References: <01fe28d8-2887-bc42-c91b-c3237b5186a7@iee.email>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:8Mi7HE2/d6PFagJSqJapbDth77i9m8Xfs3YHKsUoL7ZfODEvFLx
 T0iPhr0+cla3wgkbEEgNy+PGoyUCsiBwF0//kx54mEnjaKK8Pxqsc1fzOMzce8lcFy1mF3T
 CoZL1hRRq/vii/kCVNBcfDZ6iOxTiLsfPgLjz5qu+nazC+sftB55agpFa1sefM+8JvlkYq9
 eiOnhh5xrw6Lc7Y15hcIA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EQumEYvcRhI=:8xIH3gT0I+qGOiMbX2/HBo
 8oaTwMFaI9St5cGnnyJYAvNT9DWvoXTq5m+nH0HehNI+cz1wOWqrv/TZGdVrM8b4//gbAqLA7
 b4n15b2LRrSTPfHHomM/hCJhu/wRtx5nk/4Ee+jJIO02w4Iuc6pC2wWu1TcgfH1PyVzcCjy4U
 EM25HHhBTqvqrwYmKakdPbp/NVhOTD0UE2JRr2c20a8DQAr/8M/qTGdJvt3HZsbo8VJKm850m
 /dUJTkgRuh3kOWonAUbKDDH40kWTJ6f3B4r+X2AXtiym/EYHuj2u2Qiy1EFsaeymal62nJ9ex
 2aLGSM9MoYIwGco+fxn6WVlgDTE/HvE7C18n0hzlCzanKtrPtsKO2y8I1nA47xgvBOC67Y3mi
 +efoq8zKzoLnTuy/1YW3iBBcqoUN2rbZ0TDS30Ec8yRTkJ2rT6eXbw0uygXNKuCp4WpJg4YW6
 xR8RUxqu31f1cpkCYw3KezW/1YxX/aWh4L0T5AKfY0frXHso6iYvlhXzt9YAERLLyr5SG6buu
 Zm9f6qtW+iM9e6JIr+URubeWiTthPA87o7OeaA/gmFn+8JEIU2gyNS8zdclFT3QGrdNYpeT6x
 tcEKNXVTxxGQcwv3byOJXGGsxD260xxuKXI+Le8dRZu+Ziv3SjkVtW3BpzXoaCEtI3Elq5qwI
 UW8z7KIMGyYhG7WdkFqWuZ57VMmsrPLQirmtvOoVVxMpiNEMH8dGfbefj282Ns9uj6nmctLQz
 0y5C/iVUx2MJngdcg2I2zrDPj7e2MrwuiBZwEbh60hcXPNzjyRqfZsqrHvhy0oz+OQ/A3wehe
 6q6YBiPiyrOpdDGSnSZwNHfxh95nY/pS9ge1OkPYxhKvW7PVzC+WGXZC7aWFAVNgqi109oGY+
 LXF/YAnDrSYIHqGorJBlYUilNgi++Pxx0ufSitDCayQi9Tt6v8w1OuhchUgWJra0toWtWj0PJ
 6/I5OdScpuhWWA1EXjePoUxqqISfwlanlQ1dKYd9vXbAQc8NXpHMrN8pIKsgcwmJuK61Dz1qR
 Oe9oi/R8Q97xdOwK31aK3WDIco5JR63ZtbOjoeP35P2Hhdr9My2Ho6WlONlrNXwz8+1FXIGGV
 To1bppdf7zrirM=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip,

On Sat, 18 Sep 2021, Philip Oakley wrote:

> Is there a method within `git rev-list` to trim side branch merges where
> the merge's tree is identical to the first parent's commit-tree?

Yes, there is, but it is not as easy as a command-line option: `git
replace`.

For example, to pretend that the most recent merging-rebase in Git for
Windows was (almost) a regular rebase, you replace the "Start the
merging-rebase" commit with a graft that only keeps its first parent:

	git replace --graft HEAD^{/^Start.the} HEAD^{/^Start.the}^

(Of course, you still have to find out the first-parent-treesame merge
commits that you want to replace.)

If you want to do that only temporarily, you can use a throw-away
namespace instead of the refs/replace/ one:

	export GIT_REPLACE_REF_BASE=refs/philipoakley/
	git replace --graft HEAD^{/^Start.the} HEAD^{/^Start.the}^

Before:

	[...]
	| > | | 23e09ef1080 Merge 'remote-hg-prerequisites' into HEAD
	|/| | |
	| > | | 0221569db1c Always auto-gc after calling a fast-import transport
	| > | | f189282dcfc remote-helper: check helper status after import/export
	| > | | 158907ceb87 transport-helper: add trailing --
	| > | | 6e34e54050c t9350: point out that refs are not updated correctly
	|/ / /
	> | |   7b2b910b080 Start the merging-rebase to v2.33.0
	|\ \ \
	| |_|/
	|/| |
	| > |   508bb26ff90 (tag: v2.33.0-rc2.windows.1) Merge pull request #3349 from vdye/feature/ci-subtree-tests
	[...]

After:

	[...]
	| > | | 23e09ef1080 Merge 'remote-hg-prerequisites' into HEAD
	|/| | |
	| > | | 0221569db1c Always auto-gc after calling a fast-import transport
	| > | | f189282dcfc remote-helper: check helper status after import/export
	| > | | 158907ceb87 transport-helper: add trailing --
	| > | | 6e34e54050c t9350: point out that refs are not updated correctly
	|/ / /
	> | / 7b2b910b080 (replaced) Start the merging-rebase to v2.33.0
	| |/
	|/|
	> | 225bc32a989 (tag: v2.33.0, upstream/maint, mirucam/maint, gitgitgadget/snap, gitgitgadget/maint) Git 2.33
	[...]

You can always clean up _all_ replace objects via `git replace -d $(git
replace -l)`.

Ciao,
Dscho
