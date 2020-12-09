Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,LOTS_OF_MONEY,
	MAILING_LIST_MULTI,MONEY_NOHTML,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36AB9C4361B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 13:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F03F823B45
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 13:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732042AbgLINeU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 08:34:20 -0500
Received: from mout.gmx.net ([212.227.17.21]:39149 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732025AbgLINeT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 08:34:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607520762;
        bh=XA1RlOIA4OMA8ts9UXyom+zGI340FBE/KSibXTiGQho=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=OY1KYFzXq2lb+Mxi1w3SIOZv3juGiLEKemfWrD3OIj5W0whrKFRtgI0qJmkX0z5gv
         9FYoNjhBjF5Lnzad+rrJ5poToeP3UcWovlHHT5IXt8TWVXIii83AIa5//vz6w3b6Cy
         dcNZELrPnlDAqtN2tiM5CFE/szsTfwXGG6+sur/I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.88.62] ([89.1.212.111]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M9nxt-1kjxB13GSb-005oLI; Wed, 09
 Dec 2020 14:32:42 +0100
Date:   Wed, 9 Dec 2020 11:01:41 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v3] t7064: avoid relying on a specific default branch
 name
In-Reply-To: <xmqq360f6hlt.fsf_-_@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2012091059480.25979@tvgsbejvaqbjf.bet>
References: <pull.811.git.1607264857628.gitgitgadget@gmail.com> <pull.811.v2.git.1607354380671.gitgitgadget@gmail.com> <xmqq360f6hlt.fsf_-_@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:AamKMRito8Dui+fTLe8/a2/wtjp8RvjZrQhYtztxTRhhz2ZfJJq
 QLGlYSwNgYIDiXgl7+g95Q4KuRqq4PLX+6frPybjkoZL4WoE9UW3lcpvN9kcapmwUqT+f7v
 7gVSQ+J+rLH46A942I09AzZmgizi+R4gLUb/W92VcJRtQdcKpmOTj5SNZF5UNv7pb3LMhdJ
 0qjJmiep1t4XF4FiZmV3g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SMNooJAxNVM=:0vf99o0empzyHgq5bnfwfR
 t/wgUEBbVVTx71HnlsR+coSsyQq3qCzw0VI9kpNHOu5W7aDVU9yfsiTgSGx8uoIEh5PL8Pvli
 xeEuY8ffOMWsweblgKmZ4v+BRxNvQVO2mgVNCbEelAPiNjTbAPs0q5QtFlSBcKdugf1UPenUn
 sPe7YvXEVdeiGXUG8pOzbVNuarrR3/lKYPt7I34w1Hv6XbZoFmVZCTHRopdNEEqAokPNka4J4
 2b9H8ynWexzlJjcVX0Mnah8/IySiE8ndi2iFbBlJoNPxcnrByRT8YtmkNX4rvQ+IarnN2Xspj
 +Q8w/J+v/ggGL+oueqtKtzvpfd+qe//TO6uHhjXuIHCOFTqzkSqyriRPxPtE5jFoXkrtELzSF
 HgtUIphzxuiYeiL/l6Do3wyA1IeGKANMg9Cy/dYZSyyKJoWR3I1HVjbvyeL6d9ZtFF56mDhMD
 NesvqYLikzWY4pdHkdFSyboVzeCl/x7kMWQC8kzUsqKAT0NKenjaT82mnnQ2sEwZsQO9F32f2
 Fr6Yl6ZLWfCCPsQhy2DFdZSvLx4d7U4wRsMwk9yd0g+aXCvqB9rdjcB20uyXJUNo/kvV3j4XW
 QkGoppZs6DPONaQjMwOlqILBIpIxDoawwzMm1KgQ96Ja3PnFbnlFScXhqrTlun9TCB+FoL34N
 h5ByrTa0CgPPXdEjGk1ddicyB385zBBcJik85jDPP5KhOjj6FUUzrFcoGLZizH38s1bfXBMPd
 Y9XF7awItYXoL71ngr6jC6hI4PX+hyfOcfQtAnM15c1aPFYQU+ZHLgXj+bIce/yHdXPd/aSwq
 ouJakMfpcVrs4T5+ZhKjlPU0iiN4StayiqwMKkHsrGzUCELN1Jr+WLwWB3KRLkLA2SZWQ7DVd
 JbgSVMfm50vkqy7yZLJ7WRpQl3pvmWxaswg+OKNyU=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 8 Dec 2020, Junio C Hamano wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> To allow us to consider a change in the default behavior of `git init`
> where it uses a more inclusive name for the initial branch, we must
> first teach the test suite not to rely on a specific default branch
> name. In this patch, we teach t7064 that trick.
>
> To that end, we set a specific name for the initial branch. Ideally, we
> would simply start out by calling `git branch -M initial-branch`, but
> there is a bug in `git branch -M` that does not allow renaming branches
> unless they already have commits. This will be fixed in the
> `js/init-defaultbranch-advice` topic, and until that time, we use the
> equivalent (but less intuitive) `git checkout -f --orphan`.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  * v2 used to depend on an older round of a topic that is not in
>    'next' (sj/untracked-files-in-submoduledirectory-is-not-dirty).
>    As the topic stopped touching this test, I rebased the patch on
>    top of 3a0b884c (Tenth batch, 2020-12-02)

Thank you. By doing that, I figure you increased the chances of this patch
making it through the integration branches quicker. BTW just for curious
lurkers, here is the range-diff:

1:  1d5591c69a5 ! 1:  e8003bfeee7 t7064: avoid relying on a specific defau=
lt branch name
    @@ t/t7064-wtstatus-pv2.sh: test_expect_success 'untracked changes in =
added submodu
      		# branch.ab +0 -0
      		1 A. N... 000000 100644 100644 $ZERO_OID $HMOD .gitmodules
      		1 AM S..U 000000 160000 160000 $ZERO_OID $HSUB sub1
    -@@ t/t7064-wtstatus-pv2.sh: test_expect_success 'untracked changes in=
 added submodule (A. S...) (untracked i
    -
    - 		cat >expect <<-EOF &&
    - 		# branch.oid $HSUP
    --		# branch.head master
    --		# branch.upstream origin/master
    -+		# branch.head initial-branch
    -+		# branch.upstream origin/initial-branch
    - 		# branch.ab +0 -0
    - 		1 A. N... 000000 100644 100644 $ZERO_OID $HMOD .gitmodules
    - 		1 A. S... 000000 160000 160000 $ZERO_OID $HSUB sub1
     @@ t/t7064-wtstatus-pv2.sh: test_expect_success 'staged changes in ad=
ded submodule (AM S.M.)' '

      		cat >expect <<-EOF &&
    @@ t/t7064-wtstatus-pv2.sh: test_expect_success 'staged and untracked =
changes in ad
      		# branch.ab +0 -0
      		1 A. N... 000000 100644 100644 $ZERO_OID $HMOD .gitmodules
      		1 AM S.MU 000000 160000 160000 $ZERO_OID $HSUB sub1
    -@@ t/t7064-wtstatus-pv2.sh: test_expect_success 'staged and untracked=
 changes in added submodule (AM S.M.) (
    -
    - 		cat >expect <<-EOF &&
    - 		# branch.oid $HSUP
    --		# branch.head master
    --		# branch.upstream origin/master
    -+		# branch.head initial-branch
    -+		# branch.upstream origin/initial-branch
    - 		# branch.ab +0 -0
    - 		1 A. N... 000000 100644 100644 $ZERO_OID $HMOD .gitmodules
    - 		1 AM S.M. 000000 160000 160000 $ZERO_OID $HSUB sub1
     @@ t/t7064-wtstatus-pv2.sh: test_expect_success 'commit within the su=
bmodule appears as new commit in super

      		cat >expect <<-EOF &&

Thanks,
Dscho
