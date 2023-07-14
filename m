Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24618C001DC
	for <git@archiver.kernel.org>; Fri, 14 Jul 2023 14:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236144AbjGNOoQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jul 2023 10:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236139AbjGNOoN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2023 10:44:13 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08A02691
        for <git@vger.kernel.org>; Fri, 14 Jul 2023 07:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1689345848; x=1689950648; i=l.s.r@web.de;
 bh=d8STkzKhZOKzVM/DwhyL5o6ATmfDMNX9IjBwaGKu9/U=;
 h=X-UI-Sender-Class:Date:From:Subject:To:Cc:References:In-Reply-To;
 b=hL1reTQY0G6dEG5GJhS9huGbcPlesLFqPNLYVtZLGF0xYdJMFWVRSn36/peEJ9KuHqzGlId
 TEuY3u9dFKQ87kMMVGmFN1N6SuKe1LGO5aH0YoHfQay/ENhJTeT8DwlHev7HcN+I94g8VJtmL
 rL3jkUz7Z72RBAjBgEI2CwIasrPaoowt0gU4rxW3EIheUSwCse6ZdExg4VYe9KN1UkVr5duIp
 iSIORx/5mkAGoj6MEeQK5dNzr9aJumdgPOigbgq2OY6vGXqzvyAB3+LCbf/OVDXOr3gus9gvE
 4KWbE1Vohs2n10t4Zsuj3odiO5IpOONbTeWsI0G5bC69jfEEvhAA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.157.22]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MXoca-1qRxP21bvY-00YZ8J; Fri, 14
 Jul 2023 16:44:08 +0200
Message-ID: <279beaea-d332-0d88-3cd0-b935ef6bc5eb@web.de>
Date:   Fri, 14 Jul 2023 16:44:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH] t4002: fix "diff can read from stdin" syntax
To:     "D. Ben Knoble via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     "D. Ben Knoble" <ben.knoble+github@gmail.com>,
        John Cai <johncai86@gmail.com>
References: <pull.1545.git.git.1689341410476.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.1545.git.git.1689341410476.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8bxUatHxG4J6lJWwk6GRm5+a86zcEGIbnJFUE8N0dd0K7iPo2rZ
 7idMvb8MKB+x86vLdchXOnEWwMiXogt/18ilF89gsYiT9dH6Q9PpRnwdUM8GeKhHr7dNHvT
 r0rKKkTpxWZmHRg5WcjYfQYClNxTuBGs5B5St7fN75B5L2X/MZu214+h++HjNL4TNm6TmaE
 mMO0eXbLcBXBmMs7byZ/w==
UI-OutboundReport: notjunk:1;M01:P0:SpglK7XBlJw=;7NuQnDTiVVb6u/XGq6/mauwmttU
 Ix51OS3ES7iKKLXIbRNS5e7tMKQPfSNyvMoSlqtJoBoNlBRSxgg54cBa4bSZtP2dWk0q5NLGS
 4vuc9VE/sw3f2xf1WHe4GndOUNNYvoThar6z3IMgUnb0L6f1b32X9Z6FecdVk4T6+xN+UxdIL
 pk26SS1c6Vlj1pSyrJmzBBSesZytyTMwNfORSOLghLNhstWvq8tqv59ulKh+oCB2RYaiT/vT5
 KRXkXPX8lPqHnVJwJdgGlLRRbb/lD5wA6oXQpa5/Bo9eeCMr3hBERdcD9LojoumyYzu7G4B6e
 ZfUxaTnBDVtQnQS0Y4T/KHsjk0kXldivVaYARq/m+J8hu26YShDBQ33JmcK3RoVUrf8nC399E
 6kon1zTaY6TN7NYS8azUwcwpcG/gZy/gvuugiNKqWQl7S/eVpi1JPIfYFKgrZukJ5UtDiaxSe
 0y+zQjyyYgY+jYdW3NEHPog8P1Vee/xFt2QA/xNGFZVAXqBIQVpxQxseWPjsmTYDL6eN5Aw45
 JgjPv7dkO0EopFY5Mr1xbAu/XvXmle7L92j08NJcz5qpycUMv3f8WldizQPy59+mWQtiFOD7v
 jXRTtnRPeQFe/iFT5XMGb0Dk2uhYVMlPOT/uZ5i7YU4fmvZFUNSD2KlSXAEp973u1hquYMFjA
 vd5pJe9fD8s/x8b3i0w2TJ7+B7sZk6PoGovwT7tz7Ev+TXhuFk6sUqnAjthCIAbXRhOLYWJUN
 O8OUQUy91yzeU4gNLmKApoKcqUzc1OuwiJ+r7OJo+a7IUaJeo/kqaRIFgLXHireat28rDxSEV
 UceFoA8epUvAl4r3JcBnICG6bKBSD0h6FzO83SY2HMk7yEKdz2cSpUseQrzrabSlgMsPWFHSe
 LLr0mzHoEfbabH32lC5E7CJe/Z+rpN9osZU9c7o3lg6Z7WnV817NkU0of5hk6KQNU7AJzMIq/
 dbFpGF1o+3s7O5b1ZoJb9X8COtE=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 14.07.23 um 15:30 schrieb D. Ben Knoble via GitGitGadget:
> diff --git a/t/t4002-diff-basic.sh b/t/t4002-diff-basic.sh
> index d524d4057dc..7afc883ec37 100755
> --- a/t/t4002-diff-basic.sh
> +++ b/t/t4002-diff-basic.sh
> @@ -403,7 +403,7 @@ test_expect_success 'diff-tree -r B A =3D=3D diff-tr=
ee -r -R A B' '
>  	git diff-tree -r -R $tree_A $tree_B >.test-b &&
>  	cmp -s .test-a .test-b'
>
> -test_expect_success'diff can read from stdin' '
> +test_expect_success 'diff can read from stdin' '
>  	test_must_fail git diff --no-index -- MN - < NN |
>  		grep -v "^index" | sed "s#/-#/NN#" >.test-a &&
>  	test_must_fail git diff --no-index -- MN NN |
>

Good find!  Introduced by 9cfcbcc095 (t4002-diff-basic: modernize test
format, 2023-05-18).  Perhaps an automatic formatter would have avoided
it?  E.g. some sed(1) scripting, or shfmt (https://github.com/mvdan/sh)?
(Just discovered shfmt, never used it.)

Ren=C3=A9
