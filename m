Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B3EC61DA4
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 10:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbjBBK3v (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 05:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbjBBK3u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 05:29:50 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18332E81C
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 02:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1675333785; bh=SGHMSTS58mSmzmxaxZGcdHwImCrfOFoQm3i4L364FsA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ekTUDZZO67iVL3oWUoufbixuyJpKt+lrzpx0iADxfej65Ttj2THuwVr+Hp96t4OAJ
         HQhrNKND/tpiziXECOUdJruXIakTvGvmoRhjTy4vDzuS1S4XI0hvkB1tUaRs+qqplW
         6Yo7EQRXKgIp00iLwULqA23lvTY8tSjMxaZOf7gxt2RYu/QC9j3gle5pMVo1IjybOj
         WeVUpAqvnAnFRRCEVQrMg3KZ4VGfhPjkijHnFeQuNLkuHC9gLLspgmhqNApjuUdj1Y
         UnwcYvaOVmbDL2zJGjkDQ6RNMJr83M3xAePwyNmwLJxPS+Z4yOepi+fs/Qw4C8owRH
         oFtnvGhlkaI5Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.128.75] ([89.1.215.7]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYeR1-1p9au20Uvj-00Ve1K; Thu, 02
 Feb 2023 11:29:45 +0100
Date:   Thu, 2 Feb 2023 11:29:43 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: rebase --merge vs --whitespace=fix, was Re: [PATCH v5 00/10] rebase:
 fix several code/testing/documentation issues around flag
 incompatibilities
In-Reply-To: <pull.1466.v5.git.1674619434.gitgitgadget@gmail.com>
Message-ID: <49581695-e072-ee3e-1748-f0b8112545ff@gmx.de>
References: <pull.1466.v4.git.1674367961.gitgitgadget@gmail.com> <pull.1466.v5.git.1674619434.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:xhYMM3Zn685TbZopXLNZg0OfhATnDg/l5TsPDfBkwqaDIQGkcA1
 yQIOc4vwyf66KIfBT5Sg8wNzeCh3iP604e0KwT6eZx3U+tNeD+6sb54QZIIQbiFwWt5pZnh
 Hla+WqmwKQcrIbj4My5FPD3oVliD0LyfapKnBQM4sUMrC5lDxg0M1pb1zdafTlBHqJlDoAQ
 83siQymiEdOU3qwLkinPg==
UI-OutboundReport: notjunk:1;M01:P0:9nlby5bZ3+A=;GTSV4GEK/8R2jvnUy0NrxrUX+BZ
 s3J+Qb1Nk46bV8FE9oIDdqggLDUhu50y6vOjZlir/deJ5Dq86r6RkK+jIvjDeDVOwo7WkhMBP
 SsCagm+1R5nbcWAh+obQujoqbFwT8XexxUgXbIAy9+Y8hHyv5J/AP1c+LEEvcYvusHNLjivHN
 97BSawh/MqDGCExa/4vQZrzUwEhE3HqSng6xk730LOMM7fc6+Hsi9sHlQ7eQkxA7yJ+GqNM+A
 M+XxAfRXVBTxGiBkNHxxPBK09CMed5ibLPqSMlS/GQa9ss4447cPmlxbHDqeJag53F/wurlPu
 4fHjyh6m+b2AUG0glRxBPXpJrQ/+/38Xoux/aXXWW8BsUO5V6iMxw702pWg4fVD6crGOINs+Z
 ut9ACjihIdydOEgtBYo+HlsJz5t1kY9n1lT3FKQfwIZdeX+5bNq9p0rHPF4KvZRJv/Q/vYCBl
 QpwuBvRHfs04zaagitUOSdK33EkWGQt0c1ncoMIPULieVNQjH14kLd3bSoU33hyRBJl+AGlFY
 IznTdmwvJ7ga8McTbQ4iUITwC1J37U3uljAftSpEmrnufAi2wzx+8QBB14fcj5QZD3CWym7Ra
 q0M7fViBK52E1sBKpSEAYYJooPrN1S+Oo0Wi5StuL7V7dycyPgMOaFHCuyfDeVaLc2FCFZIKc
 UuEtu4I+RLSHiZ40o1dEVXznbzeT9T0c8GIp2L8E1Mqn6yBa82z8Ot2rxO7apLosc0vZmpBZ/
 rBgyNDaH11gfqayYZwaHFo1teqKvjJAQL7eDfWCu2N0QakCuIoE2jT76urTaDkcj2VG4saHI6
 ZvBwqmAVtIPoDdIweisssBPWe4vI042bwbuw7bPh3E922yYPkJ5vZeUDn8+jvxGHlIBuuuK4H
 nb96ZFl8/71QczbYcKzING4tOQDsBlRxF/SAwgMXdRB9yJ3DvY9iI3ldaVPqzHFn9j7x2luds
 B7fk+2GsRWqOMIWv9TY6eeuwKdI=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Wed, 25 Jan 2023, Elijah Newren via GitGitGadget wrote:

> We had a report about --update-refs being ignored when --whitespace=fix
> was passed, confusing an end user. These were already marked as
> incompatible in the manual, but the code didn't check for the
> incompatibility and provide an error to the user.

Thank you for working on this!

FWIW this report (and your patch series) made me wistful about that Google
Summer of Code project that I hoped would bring about the trick to combine
`--whitespace=fix` with interactive rebases. But in that GSoC project,
this goal was treated as a "bonus feature" and pushed so far back that we
did not even get to analyzing the complexity of the task, let alone any
details.

So I sat down and started that analysis. The result is
https://github.com/gitgitgadget/git/issues/1472 where you can see that
addressing the incompatibility is definitely outside of trivial. It does
seem doable, if Outreachy/GSoC project-sized.

Ciao,
Johannes
