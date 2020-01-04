Return-Path: <SRS0=9bkr=2Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4142CC32771
	for <git@archiver.kernel.org>; Sat,  4 Jan 2020 21:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 130C521734
	for <git@archiver.kernel.org>; Sat,  4 Jan 2020 21:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="jxISBqVI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbgADV3v (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jan 2020 16:29:51 -0500
Received: from mout.gmx.net ([212.227.17.21]:50681 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726135AbgADV3v (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Jan 2020 16:29:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578173386;
        bh=IGyjfKLUdXGna4dPYFEYSJJEexLzp+6HHuu0yryw3Hw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=jxISBqVID5ckuQxQ5xUPne0+MNa5ARicbrPthpPjy3VyhLXCdCgFaLf3CKdYPk81U
         nfd74cFkf1vPJWheyyKeOtyveyJXmLQddVpgAZnnV63pscAt11QPzsvyezX1Ao5vOn
         QqJymgrvL5AMPumnPavI5qCjlmmZT/uFK6PDZImM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MmDEm-1jW1Ri1r7Y-00iC4q; Sat, 04
 Jan 2020 22:29:46 +0100
Date:   Sat, 4 Jan 2020 22:29:31 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jonathan Nieder <jrnieder@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] mingw: only test index entries for backslashes, not
 tree entries
In-Reply-To: <20200104015749.GE130883@google.com>
Message-ID: <nycvar.QRO.7.76.6.2001042225080.46@tvgsbejvaqbjf.bet>
References: <pull.682.git.git.1577382151.gitgitgadget@gmail.com> <4a120fd0b32d2d6492eac6b0494ad6b1bc2ba500.1577382151.git.gitgitgadget@gmail.com> <20191226200316.GD170890@google.com> <nycvar.QRO.7.76.6.1912262221000.46@tvgsbejvaqbjf.bet> <20191226214245.GA186931@google.com>
 <nycvar.QRO.7.76.6.2001022053530.46@tvgsbejvaqbjf.bet> <20200104015749.GE130883@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:lmjHwAVJa60LI7c9fNHfvGwTq/Dm4dOjSo7D41VKn/fTgkrvVZk
 5hmtsqc8EldQDRrfC9H3z2wk4LvdVjBd+YYwBt8RSS8kaZyHyNoRQjLBpHOm03jO166sh0E
 To3vdyDXSt4XXb+IeOrwy5+2IQNsVOTQpF65RG/h/qXMN8PBADZvyazVtM0Ov4tnUGj1dGT
 Tls2zeNmrjcwqQY8xl4rQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y5Yza+Mguq0=:jkogk3oD8IScSceP/zj96B
 Ui/ohi7n0VgVcNqlXHoMj2Dsaw/eEdp6UqTaQfhyouRaGZFHyiQ4dZyGAYlxFc465YAClKiif
 c1wxxd2zom8chDfeFuVuvjYAKlljIVbcA6+oQd3DEByTzpVnRv3zl7JS6qPdp8i7e/cC2YMVv
 D71TWDSAkDbWBdFsoefwevqa6oEWwkGhQ3qf/MxC6p5t67NA63cpA0QRo/+RU7Fyh8VJHdy9F
 gBTWLvaqK05ZtJ8HU9s8lXgzkrj/xOcpUp/FO8gHZlZwhEvOPSd3GzF5NzjXp/6SIOGMAu7nO
 5xT8HGfAorsxvvtxHAchATXPR4FJkOhR96i0S4B+z27vjBvsQDF5vBKgtq5R2kptSVlqMJSCB
 nL1cDC1zLNYbO1RdZLbOktnx2zUFf7/4G66jLeA8ul+p9LWcgc31Fl/au99i0aUpBfR/ScDA0
 J9f0+Azl0Dr9BzppKEtGIwSHZhJjkXPbNDtN7WtgrX8JB8+5fyi1YkbGXsM7DO2264nLYoBe7
 vdMC9A+2en3bquDzESnyc+oCzWxujndJkOQu1kxh6y9Jlv0kc91V4vxoLyjOCBpIPIxGAwC9C
 p630+s1+WglPiSiVQWqPxGA6KMwPAQAOO6xzKVvOoOrIx7YBpeRlwK+94fNPJkGmMx2GIKiqq
 ZQgKXpDtcEXqqq2Fr6Ao5sWEgPf9ZVJShPOceDGIYUD+BUmPJz+rIiWHKfUCqpuTQdSk0if7M
 c4V616ZEGrFqG7qi6n6VkGOiIVNbornFHXO4VdVGOOxXDRr7LGvDsnyUWtKv6GKd1cHFe44Mb
 e2kfJOKN4GC0qbAD4WoUOBiuKz7dKh2QAvgK1Ml6jXU+/yyt0kCqGe/Oci7bHF5dPY5/MnIsB
 JxIJgyHk/tDyL2bHfduOCbBX+G5PxnulypIq7CGDcyru8WDO+kWUkELX/mhmBFwvhdjzLzE/L
 sG5tM6N3B6STBSWcg8KAfhZWinim15piVH7HHtkl5GQWlyzwzRDtLl+YN1HgGsRp+hfQJ3YTa
 zOx6QUT6Cz8oRoyhtjlGOv6JVt+0jtvJgXv49ixQb23ip687dT/a1fSkVc9PshVWDT6VOkBLB
 gjeW2rU3eH7IXv2BpY5YvCn2o0HMZtzceo8+3mwj20OGhAGSb0YF6hsr6Z1ymoJd3nbwfaMxc
 F1D6RSr8zHGVb13RtdMz+aOahaF+/UKJz/NdbHam8BsbwqllqmTrsKm0d85pwKyRAXT5YKfm/
 KLSmNq6pZQs/Es18KPSlMTW4l1SOaQ0rUM1CU6sJuxgbZduAQbk4xuNfkRE4=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Fri, 3 Jan 2020, Jonathan Nieder wrote:

> Johannes Schindelin wrote:
>
> > As mentioned above, the idea is to prevent Git from attempting to crea=
te
> > files with illegal file name characters.
> [...]
> > On Thu, 26 Dec 2019, Jonathan Nieder wrote:
>
> >> Is there anything we can or should do to prevent people checking in
> >> new examples of paths with backslash in them (on all platforms)?
> >
> > As mentioned in my reply to Junio, I don't think that it would be wise=
 to
> > even try to warn about backslashes in the file names. There are _so_ m=
any
> > Git users out there, I am convinced that at least some of them have va=
lid
> > use cases for file names with backslashes in them.
>
> Thanks for the quick answers.  It helps.
>
> I think allowing people to clone
> https://github.com/zephyrproject-rtos/civetweb but not to check out
> the problematic historic revision is a reasonable choice, especially
> since it's still possible to get the data from there using
>
> 	git checkout <rev> -- . ':!bad-paths'
>
> [...]
> > Or maybe you know of a code path in the `unpack_trees()` machinery tha=
t
> > does _not_ go through `add_index_entry()`? I would be very interested =
to
> > learn about such code paths.
>
> Every once in a while someone (e.g., in #git) has wanted "git checkout
> --skip-index <rev> -- <paths>", and that would be the natural way to
> implement such a thing.  But no one has done it yet. :)
>
> We'll just have to keep a watchful eye as people make new
> contributions.

Right.

As to my patch, in the meantime I wondered whether I should simply extend
`verify_path()` to take a `flags` parameter where I can specify whether
this is intended for checkout, and handle the backslashes _there_. That
would cover e.g. uses of `make_transient_cache_entry()`, too.

The only reason why I would want to introduce `flags` is that `git apply`
has this `--unsafe-paths` option where `verify_paths()` is called on the
file names in the diff, and I was unsure whether there are legitimate use
cases with diffs containing DOS-style paths (I suspect that there are
legitimate scenarios where this is desirable).

What do you think of that?

Ciao,
Dscho
