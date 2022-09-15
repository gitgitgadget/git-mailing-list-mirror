Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D297ECAAA1
	for <git@archiver.kernel.org>; Thu, 15 Sep 2022 14:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiIOOtJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Sep 2022 10:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiIOOtI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2022 10:49:08 -0400
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F1B63F04
        for <git@vger.kernel.org>; Thu, 15 Sep 2022 07:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1663253337; bh=Hf3WACCn3OaPCm3ixaKb7YE7VDyvIFGHHEIS+adNsE0=;
        h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
        b=VMF4BgldB3ERIgAD5eLBUBx/tMgIvVFdKRH0ko3bDL6cpmjmUzanq8Js7D9DJVo/Q
         xnREzF2KgIngMcZEdsW+LXVhFD+Ha8L1BvRjCX69I96pxzmsR9wJ1CbfnkmGkvbWQD
         esC2Brcpz0yY/saNYLekNTlm1SQqLTZyqgUv1MbsO6VTLNmzlFJrZytIYV73yvCuKW
         l94+Q88fV6VHOulxCPbuyZ9cTrO3ElvKDUBM4Xw+OfkoE6Gr+rZKaSQEsy456oSmaR
         Ix+RLyDhpSt+CRlxamj6ZXdSjWAOPnYUZfSASaXnPslf0H984w5/yXuNTFbJM0CgHR
         Kx1QlIDdGfeew==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.24.217]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MjgSv-1p0hoQ2Skd-00kvQr; Thu, 15
 Sep 2022 16:48:57 +0200
Message-ID: <ba6eea28-fb3a-b376-2529-351727c02f1a@web.de>
Date:   Thu, 15 Sep 2022 16:48:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Content-Language: en-US
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Tim Jaacks <tim.jaacks@garz-fricke.com>,
        Chris Torek <chris.torek@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 0/6] revision: fix order of revs for ^!
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:B1+j0Ws43QApSKKhvH3p5I54xYoe+9RN6nm+RpqLhQcOuEaBtr2
 IUR1JHjFfOrY/tIrp/LNuJdUOdkbm8vaVZPgmiqvEymVTTF5NMWHzzfbHSHiIQKPibxLke8
 Ten60cprXg5fwiRzCX2uMM7aB4h8QbOq5B4CKEXHw1iBD9Jvqkr8k7ude64W0gmIAuG5LMA
 Otwf6ir6oG7TRg5qcjlwQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:o1ilC1utu3E=:7kijhHgDpW+SORdTwDPx92
 LTv6K2CAK2WZNc/5BSpRJNwxqe7i69BTV8YrdV/8/NR9IrrYS4gdy+O22Vn7IbrdDVSknhLHw
 JQ6gsNdlEL0h9LHGnTWpt9UbG612GkTmjwHi4h3t9GCyShRP7OJBRJ6Sd8ToUcmaT/VXRi9H6
 uNp8camg8a79kqqnN11UFo5liNK8ry2dG8pnx0idiXXitv9g25N7d3Ec18RUaUok825J79LDf
 zbR4tBJQOcTp0hWH7F7TlmZcfVetfZfzxYPwFuCpQCcHaDC2B1t6SJbhB02Vnxerin+JAfRE+
 wt6OC3YGIv4+f/T6dzHSSrdZqs8OjoOd1a+UjmIR1/5q/V+BBRBYKMegNLO7mdnBfSHnaTfpU
 anSAicpWcoo0oUV35AhS5X3Tca1RnAKkXe23Ns72lIxBakR1NF5bnyBFgMcKt3lZ6/UKUxu0n
 1nenCgZ1mDBprB9awG8oKqwbi/t3oZv5RoJ+ikVHoBp9+/Z/uRQzJPUKQGG35kL1dcVnC7nRm
 iPTLfeSazDok+ME5LP9YYB523fcJ/qorvXhmhiEK9sOMrCjSzAggY27oiemfB4foMAjWs3T3E
 nejSpO+SUgXdkkvsjsbWKK4vhs9mSuvfMBswnhX9NCdqnHZlI/Gm3eTervCPUbBSYi4w2+Nmf
 QyPOGRusqtz1l1ue3ndZCgvodKHmg+wAz+TPEZykTtXhn9Mf9VUlvjlEEj5pSnHbOQkPf73V0
 UVzwK2G/CY5oGp4zRfs8+h2KIOFPh1bBqSJsYol15NLEosXbFTxj1mMGUHG7nT2liKmPS/8io
 FoxP9Ey16azqFSOVPDFmhiePA3Zwm7dxqEkaQZh0otBtOCq3tgfO/sp44bY1LMgmoJ/1LHMMo
 5GiRKgXjE4po+ESmlBF5ce3CHa8f2BmIQWZWlqRDgyHPvjHYiXZY8kvfWo9wFT+dHlkwK5HZd
 w8n7vReCb5afuhafRsbJZ45PYI3iMqSGytepI+qej3oGO/Ea8q9OT5krIV1AsgjZ+FJXmtDLQ
 ViqHDh5tABWw6fTcarMRS5fn55qjBohkKyRn7Pd6AfoVw+kaPp+plTmQIHmmTMlGRvZPIq9a3
 vXMP1rOHYvUMLiWMdW9zqxqJmxh+4WcCcj41JMTgWE6WCwWISBWbVjxk5MjhPE0+6xm1bZ1R0
 HEg8s=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

According to gitrevisions(7), "R^!" is the same as "R ^R^1 [^R^2...]",
but handle_revision_arg_1() instead resolves it to "^R^1 [^R^2...] R".
This ordering affects git diff, which expects the child to be given
before its parents when asked to produce a combined diff of a merge.

This series reverses that order and makes "git diff R^!" consistent
with "git show R^!".  First an unrelated cleanup in the vicinity:

  revision: use strtol_i() for exclude_parent

Then dissolve add_parents_only() to gain the necessary flexibility.  I
may have overdone it:

  revision: factor out get_commit()
  revision: factor out add_parent()
  revision: factor out add_parents()
  revision: rename add_parents_only() to add_nth_parent()

Finally the actual change of order:

  revision: add parents after child for ^!

 revision.c               | 87 ++++++++++++++++++++++++++--------------
 t/t4038-diff-combined.sh | 10 +++++
 2 files changed, 68 insertions(+), 29 deletions(-)

=2D-
2.37.3
