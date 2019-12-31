Return-Path: <SRS0=sBbF=2V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2062C2D0CE
	for <git@archiver.kernel.org>; Tue, 31 Dec 2019 22:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 692E7206DA
	for <git@archiver.kernel.org>; Tue, 31 Dec 2019 22:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="fRzsxVlp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfLaWv4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Dec 2019 17:51:56 -0500
Received: from mout.gmx.net ([212.227.17.22]:43913 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727054AbfLaWv4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Dec 2019 17:51:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1577832710;
        bh=aB5Mt5rBzPyszbarACqXzBmOuqYWDwUESFN/5XFCNYk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=fRzsxVlpO/3kBMYmSYvbs3n+5JU7ceuNTVfs5uEN6lNGR8rvgMSH3e9rt2NlPtRtf
         OLuOCM0feKDGCcceMuK+zaiorLY8LbvKc+GY9VkIuIOQsx9svGeKVEWNuzOXlHo6Qn
         m9nomgHl7btu0u9itV8j4ldqUDDw5MjpHrkCP8l0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MBlxM-1iuAfq2PSG-00C9cW; Tue, 31
 Dec 2019 23:51:50 +0100
Date:   Tue, 31 Dec 2019 23:51:35 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] mingw: only test index entries for backslashes, not
 tree entries
In-Reply-To: <xmqqblruk9lz.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1912312329480.46@tvgsbejvaqbjf.bet>
References: <pull.682.git.git.1577382151.gitgitgadget@gmail.com> <4a120fd0b32d2d6492eac6b0494ad6b1bc2ba500.1577382151.git.gitgitgadget@gmail.com> <20191226200316.GD170890@google.com> <nycvar.QRO.7.76.6.1912262221000.46@tvgsbejvaqbjf.bet> <20191226214245.GA186931@google.com>
 <xmqqfth6kaqi.fsf@gitster-ct.c.googlers.com> <xmqqblruk9lz.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Fz1ObAEU4EseQa7tjlExvDYyMwNloL5t/NRVv6oYFh+QlMlxd3k
 uqtLgaMZlmIIrLpgIebMoD/Y0zexdJjrBq1Mk292k2hF2u1mia7ExLtOuhWfX+n0clzfLd6
 QXKAWUse9u4In0oWwy7KbGPzCP/nkyxtVMmldfPLV2lS4AUHxF03/C1nfgrNds3sf0FPnBQ
 3cxX6ajxNiN6442ZXDNdw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:g1C2Ov0prwo=:3LKhhSGryY2Ez1vraK5eDa
 6e0c/gPuIMoV8D+azQeUucTVtjtyFWgkZsWZn0sDJsEiI/1dkH2T+G1O/H8eEb1tjQ2uxa9/Q
 WNzjB4BUbHQUTnQxhErYN+anJ5dms/jQZXiSfhS5DwBTUdV5A1/m5zljAL/mUsrmWnIxGibVZ
 Z/nB+jWNPBi0RbNe7lQjo2GuwiOj+whSOHCrp25L0VyctlbPZuTbtCr9QnkuGvA8sWRW0rgs/
 t+RMqrjLNJ1TaBuZCoJb1E7SLoq05fQnZ56Hcn8jiNWFqASJ/LHvWf0wRGC4Ko1A1MjaR1x0i
 CTUcTMHGSBxcgiVs7IT/18rkjrppYrEtS3YnUAD39b1T9BjYhJ0tXEdHq9FSo1OQ2H1h0t7zj
 vxfbUN1jUg0k9YkwtVF5LVyzSfX0muQg+91SA9yWEPJL8k26aCh0CkWtOB2CnOw3WzmGfxW3N
 hSbRQ2U/XVcKAotjzpyCFcw2E2pb0veapa68lb90eQDiCPRNHc366lC8B5/fnhdcndFfG5y26
 Z9iK5lNa3RKzb4NKMuZsjWUF+xRNuhX+jaurLEgWTVek9MQsrmj24xZZTGpto0YBnYNuGDksF
 XT4RayBYXpOpzToImcq3aYzdNUIoXsrmP/CpitbNKmWGFzfi0b9R3fCdEQ5JTEGD9IjC9mqDZ
 rIhpMOycB6Vjj18Z50/aCY6TzAsZLSiGs2KmItys0EUOsgz4pIFWKuXa5FrSjUW4qSflp+krt
 g9+LLOVOWDNcWis2wfh3MZtVbmdqHU8cyX0Wo8sd+l/IY1iIko2j8j347M9UC0et6GiSlQe4w
 S3Vh9MzVmueqp1FlXZGXQ1vsHmggT3Cpft05cySL1J58iWu6I4PPIZfwRkXBLaa0FqZGOafTL
 wIjQUqAgxjw3kAc15+PKObk4lrFbSt3zDomCRgBJdQfRqlLjUMiSpAbs4xGe+GgtbNlF5few8
 ijtHgHXSpxxsDyBURWD+duOOxxunTNQGMIyAhKRCtMXZIjqcqvXKE8FFYvgWoaBHTRPyMF2rY
 JB9rVqcf5kOJU3XelTefUa4MO+s90lmXx4MpUXVuEMRKFdB/LD3J2iD19EdfNOKkVsmqJlF1V
 zpowbZdmj0PLxHTWcEhBFwxt8AaztGQIPu8ZY1RV+Gc+cKtoi1wXU7gL852oQbdTFhsjYQsfb
 tV9AfFTWdsiKrhZNA7bqPGTbSPGuVklOpVQFSK+2MmL3po1JDzHMT3KEmiLgh93bNCxzlrxxR
 2Z1b3xbVPWgCNJjv0pK6YUQZrJlpBNnSZK64GJpr8/h/IEkti5STSEi+X0Is=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio & Jonathan,

On Thu, 26 Dec 2019, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
> > Jonathan Nieder <jrnieder@gmail.com> writes:
> >
> >> Is there anything we can or should do to prevent people checking in
> >> new examples of paths with backslash in them (on all platforms)?
> >
> > I obviously won't dictate what should happen on Windows, but I think
> > the overall principle for paths recorded in a tree object that can
> > be problematic on some of the platforms ought to be:
> >
> >  * fsck and transfer.fsckobjects should be taught to notice
> >    offending characteristics (e.g. has a backslash in it, is one of
> >    the "reserved names" on some platform like LPT1).

Agree. This is on my radar, but so far not too-high priority, as the
`fsck` checks are not (yet?) standard practice in PR builds (and warnings
on the server side are prone to be ignored).

> >  * if paths with the offending characteristics are *so* obviously
> >    useless in real life and are possible only in a crafted path that
> >    is only useful to attack users, the check in fsck should default
> >    to "reject" to help the disease spread via hosting sites.

I don't think that reserved names such as `aux`, nor names containing
backslashes should be rejected _always_. While I cannot think of _any_
instance where I would want to have a backslash in a file name, I am sure
that just like `aux.c`, there _must_ be somebody out there who thought of
a file name that contains a backslash and makes at least some sort of
sense.

> >  * otherwise, the check should be to "warn" but not "reject", so
> >    that projects can keep using paths that may problematic on
> >    platforms that do not matter to them.

Yes, it should be "warn".

> > I think LPT1 and friends fall into the "warning is fine" category,
> > and a path component that contains a backslash would fall into the
> > "this is an attack, just reject" category.
>
> I guess I should have stepped back a bit.
>
> In the message I am responding to, I focused solely on how tree
> objects that originate elsewhere should be treated, but there are
> two more data paths we need to worry about:
>
>  * A new path gets introduced to the system, via "update-index",
>    "add", etc., to the index and then "write-tree" to form tree
>    objects in the local repository.

Right, that's what I had in mind when I wrote this patch. The path gets
added to the index, we detect a backslash, and on Windows (under
`core.protectNTFS`) fail with an error.

>  * A path in the index, either created locally via "update-index",
>    "add", etc., or read from a tree object, gets written to the
>    local filesystem, resulting in an attempt to create a path that
>    the local filesystem cannot represent (or worse---behaves badly,
>    like "sending random garbage to the printer").

Happily, my patch seems to catch this code path, too: when reading from a
`tree` object into the index, we use `add_index_entry()` (called via
various code paths in the `unpack_trees()` machinery). That's exactly the
patched function.

Or maybe you know of a code path in the `unpack_trees()` machinery that
does _not_ go through `add_index_entry()`? I would be very interested to
learn about such code paths.

> I think we should apply the same principle as the one I outlined for
> the tree objects.  The fsckobjects mechanism may not be reusable to
> catch violations in add_index_entry_with_check() as-is, but we need
> to aim for as much reuse of logic and code as possible so that our
> checks at various layers all behave consistently.

I am afraid that we won't be able to reuse code paths for checking the
backslash here, but for reserved names I am planning on refactoring the
code accordingly.

Thanks,
Dscho
