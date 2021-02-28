Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34976C433E6
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 11:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00F7D64E04
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 11:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhB1LYg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Feb 2021 06:24:36 -0500
Received: from mout.web.de ([212.227.15.14]:33077 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230045AbhB1LYg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Feb 2021 06:24:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1614511361;
        bh=FBJXTKwTeoDJzypnvzSIOEiytzW+YYunp3tDDrIEmxU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=jWqt6nM+xTYlXGp9UHp0lngNRl23hh5J0D22pzu/SjyI5NEaUMgrGFM57pzb/2Qe5
         j0L6hr3gxNapF8NSmgOPYhGzdbx8t/qTlQbCZde3P90uvQEQnIJUL5+X0johEu1oH7
         IiTpMYY6iBeZY0MbFNMUMZ4UmCtp+aZLIraNIs3c=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.24.70]) by smtp.web.de
 (mrweb005 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MMp8K-1lYwyL2uIO-00Il3B; Sun, 28 Feb 2021 12:22:41 +0100
Subject: Re: [PATCH 2/2] pretty: add merge and exclude options to %(describe)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eli Schwartz <eschwartz@archlinux.org>, git@vger.kernel.org
References: <7418f1d8-78c2-61a7-4f03-62360b986a41@archlinux.org>
 <5561d11b-08c3-bcf7-5d37-a7d6c6bfb715@web.de>
 <b7bd37c4-ab13-0297-da46-716e26de10d6@web.de> <xmqqsg5uletz.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe=2e?= <l.s.r@web.de>
Message-ID: <878d2515-a937-f6d7-9d77-45c38f547893@web.de>
Date:   Sun, 28 Feb 2021 12:22:40 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <xmqqsg5uletz.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:o4EGQQG6+Od+SABQGusZ3dsf5LvZTpYNftmuj4veNKqdT/vmAyf
 G3quUkUg2iSIlkiv0Ota9OM0HwNjNdfr643zd4+0zGNjTqu23JN6DUbViF7jlUibUcwWcrQ
 xi1KOwoJs3epEb6dMphIWnZ5yRmaIIkOj5YffPPb6evio15h7tCYuVzcnEHik52Usw0dLFW
 Kpythh350yRSJdPJDmUZw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3W2pnFt2TO4=:0cLUxRvv1TuFeTPBATs59O
 4z9c+103Ca2rPq8fr4UWmtb1n44YPSbonhMLTFNxuJKcBhSF/MllP2MmPw4RHn5vHUtju5U0a
 xusurh5n4MPTvQB3YP6dwcVm9hivcKTB9pnjrgWMKO39f3CYnW8GLMuT4USa6iBpvTpGUbvgB
 /GuX/0wKroxDt2GeV6vmUe0cnalHcG8d9y7NnHVasgpBXEQ8/2VRKugyZgreuCCRmSTpF96I3
 q0myYkSjKDOXS2vrN7xrvu3OVwGUvXiWCu52AmVWo0NRfTfa3pCcswcf6W72t4vPpnoIvdHyY
 UG+Zx530jSEVJlp+2To8hkiueXtwPaK6faD52GJupD6OjxrXWQ8+sgEWv6nQNsvU2+aFMRIej
 L9CAoc7GyT+q8yYJCzUrBUjQwHWC+7zmNDyIY0Zh3gNJQj66G2iXhgey/F2OAOYY5gXfOEEoy
 ithcegFa0kRLLNMHC/6S1IFB0RYQ/ILAyt0PRUlBr8nGLEgMc4gNypU52NzqSS8eJ2VgXTuy/
 N5OyZlGdo6uU8NGJviw9ZHsc7aLoXISnf8AKGpU7hlGxt0AE5dkywk507uzyMkkp3Rl+1Wf3n
 5iGUORM+Law8HH8C9IvwN/iMhLVWyM8EPPjMst79WNf84yCxqQDSZoCPClPtatRFZOKY6yzjy
 c4hVb1xXD8TOVLCc6K8dkegdjglHj5VkN25N09QfFH47aKdSfDk6wZfj9Tq4wmf46LWurarP2
 nKYHF47zSIfcNfWyHO2bZzgBCSbZC1XF/5TAhRiczF8UdGUz1DVWvFbZnEk8sQDcJXgctMh6r
 wGxcne/CiOjL76Ve16+ddo502ak0Qj0A84lpKlRoEdbDg38HiBp3O87SRkvsfYPNLTCnjEvpf
 Ox33Fw1gc6FQmNmGzpQw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.02.21 um 19:38 schrieb Junio C Hamano:
> I wonder, in addition to "match" and "exclude", if we want to allow
> "always" as well.

I added "match" because that describe option is used by GIT-VERSION-GEN,
so I imagine it's generally useful for version names in spec files.  Not
sure why I misspelled it "merge" in the subject, though. o_O

"exclude" is not in there, but I threw it in anyway, as the example in
77d21f29ea (describe: teach describe negative pattern matches,
2017-01-18) made sense to me.  It complements "match" nicely.

I had "always" in proof-of-concept patch because I hadn't decided what
to do with commits that git describe doesn't find a description for,
and wanted to check the full output of git log --pretty=3D'%(describe)'.
For a release tarball of a repo that lacks tags it would be easier to
use %h instead of %(describe:always) -- or tag the release.

That's why I didn't include "always" in the latest patches, but if it
turns out to be useful for someone then I wouldn't them adding it.

> Also, looking further into the future, I wonder if we should aim to
> eventually unify %h and %H as well as %(describe) into one,
> i.e. various ways to spell a commit object name, given that there is
> a separate effort underway to unify pretty and for-each-ref format
> strings.
>
> E.g. %(objectname) is the same as %H, and %(objectname:short) is the
> same as %h, so this might be %(objectname:describe), or something
> along the line.

According to the glossary and object name is:

        The unique identifier of an object.  The
        object name is usually represented by a 40 character
        hexadecimal string.  Also colloquially called SHA-1.

And that's how I understand it as well.  The object layer with it's
hashes on one hand and descriptions based on refs and commit relations
on the other are separate things in my mind.  %(describe) falling back
to %h when :always is given makes sense to me; %(objectname) "falling
forward" to show describe output feels like a layering violation.

Ren=C3=A9
