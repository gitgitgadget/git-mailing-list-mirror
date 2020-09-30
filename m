Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9944C4727F
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 13:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83D192071E
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 13:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="CqMN6IRJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730168AbgI3Ngr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 09:36:47 -0400
Received: from mout.gmx.net ([212.227.15.18]:46193 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727997AbgI3Ngr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 09:36:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601473003;
        bh=3FDpQsofU0Cawzr+ICmP6uiFpsc5MrjlqvdHWHojlGU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=CqMN6IRJJYaL0I46oYbMYhjLHzisSACpWi6p6iyZ6hg8yR49o/d17I1C3ikexxLgx
         ZFGTqbdipfCav+taR5nPYh0h9ktsVXUH+ZGtqQrdq7tJiHCI++dCK0sJMvKQiwnFkw
         K2hM71e5ZuK+JzH2JVjdBBUzxuD4ckkNCaAwKAMk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.113.174] ([213.196.213.65]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3UUy-1kOAW111Kk-000fNs; Wed, 30
 Sep 2020 15:36:43 +0200
Date:   Wed, 30 Sep 2020 15:36:40 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: jt/keep-partial-clone-filter-upon-lazy-fetch, was Re: What's cooking
 in git.git (Sep 2020, #08; Tue, 29)
In-Reply-To: <xmqqv9fwgrvg.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2009301536070.50@tvgsbejvaqbjf.bet>
References: <xmqqv9fwgrvg.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:wz+g5Q+CxsghiBjM8jDSBQRrwm/VxswNr79FfUfVUcMIL9Eoigw
 cVdmjVOSuDDzmuicuMejEH08fHdoqtSP7dqHNB3QFo2ZDk/mxlrNh1jKk3ahbiZf6vi4agq
 81awaC1c9eyLjuRblEzJ5Q2XwiMAimQShlfh1V9HbTBs3dxAxvb83fKvjWGpbl9zDq0WO4z
 +mtRxgHtH01ESE2Lfjn2w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TbggCEKxPVA=:kk5S4rD53T7LfgggH42eU1
 SrGhLOqRYQWXElMU7dwsihtVt3UZ0T70wlWYlALnIhoa4un5KN/oJmWV/LlDLHt4bptdGyb9g
 UMkmxIkRoC55pwtJF/AFVDNdM5pxXT8br2v0EhApo+Y4OcIX3Eo9oZNblCf6wBcXycYHSmna9
 NOUkhsCgXAz/aOGM+PSpV4veL0upEYahEu0ifJPuOnTVAdu285tRrvddokQA3B2TOqob32mlX
 oJOwcTYQ0n18IK9LTaeEWdGHl1jpolbjkWQNTGg3v0QVAf0/LcfDnuqS0OknWRUKXnHlf/cQj
 Y2NSBsCTl1gOFHwnA0eRbttz3ZVyavETXTULU8Co1Bgro+YPxLvirbhprxSfabac1CZQvXn5L
 aQgLTcClIne6M3mg8Nt6s+JfhQDZCyOJLoB9Wt2UZZnxJM2NK9GchP+TQZhuepPXqx4xv5WpH
 nlVOxeLtCIEDyDBhg1r0dTDAr1bdbsBLHhLin132LJFkSOYP0sMgTCYaVtvmN9oDmnYiaSEOm
 H2fK72xSSPorkuLWhQ/fIzagV5CB56DRtslRjjxkeB/Yf5Vauj9gQOXwXGNz8T+fV+tDZ+pGl
 3W1tWzVJeRUQrvC5bpMS8KTZ0CFBJU2IR3tRX1sZRJX/i1Ui5PIrN8AnrZpSKts0q+jAkjpPG
 WvJU9DNZlOWmCBZ8Gn6quacx2kz+E6sJzuKKFu6/gkTi36j2ruVeDsaWmnVFuwvvv05QhLICV
 zgq/qyPoYbRkk/+1GF/1MzVQ7cyh5cVlNA7sYncv/Y8LicuI+NLJx4R2VjGNlqFGHBwLFa1dm
 a4WJ7z+q+7d3v3pKOz8Ro7O5EEIjGhK3EBPVGi+m2UW5zxuvnJIbwuyUADks6LS/du31MeUxH
 rhz7eRvNeAcBZEG5pAp+yDF3lBKe4L+DbnsC4oU9zq7X5KpKAh8nNUM2HzPKcWKuKdaDPqdji
 3PONjXQ/uGofuV2ND9wJRYOhDR7po7rlPviFHG0/rlbH7MCARy5Z675bDip8rHB9FQ1LlRb2Q
 BeKRy36/PqDyZ/PymILrzEVaITLNi8Xw1Y+3KDUx6Xkzz6GF5NMcWxm7GbV90AlOCZ3/8D3vq
 bXB4m0h9Jh8TUdPPyg+ELsP2fKc/fKSCodqzux07wig8o+w9SKJbiOyW+GeBfQbDHF9DB2cGr
 xvk7PctSzlf1ejTQHhgxtu5Q9YBBa01zmVhVYUcotm+YUIzfFOysmiU2h2ifdnK5pN4cl8ttI
 x+e7tCzjqnautIs6C59250o2HkxJV52JVbVc2ig==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 29 Sep 2020, Junio C Hamano wrote:

> * jt/keep-partial-clone-filter-upon-lazy-fetch (2020-09-28) 2 commits
>  - fetch: do not override partial clone filter
>  - promisor-remote: remove unused variable
>
>  The lazy fetching done internally to make missing objects available
>  in a partial clone incorrectly made permanent damate to the partial

s/damate/damage/, I assume?

Thanks,
Dscho

>  clone filter in the repository, which has been corrected.
