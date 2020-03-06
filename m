Return-Path: <SRS0=QY2u=4X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92956C10F00
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 14:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69C7D20848
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 14:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="EAtLSUiy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgCFOLb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Mar 2020 09:11:31 -0500
Received: from mout.gmx.net ([212.227.15.15]:57053 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726108AbgCFOLb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Mar 2020 09:11:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583503875;
        bh=dQ7gWRCcTbLk4KgJCQsR0cDrYU9QrZ3MUEvK7etS5zU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=EAtLSUiyG13MQ8xf7O6F37xY3ckNY7thbGHFveMvhOu8i8SlPVqU2IkGuP2yYcG0n
         CrntmuKqufE4F2CAyC6vjSOXvQt/Ni5kHDdmJ67kgJLz6CgfMKSxsAa7NT2gxwBOgo
         pzxBkncANV3Rirzny42mita/MM1zYzA8ZCbUYkqw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([213.196.212.208]) by mail.gmx.com
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MStCe-1imWz640Mw-00UK7k; Fri, 06 Mar 2020 15:11:15 +0100
Date:   Fri, 6 Mar 2020 15:11:14 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jacob Keller <jacob.keller@gmail.com>
cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Son Luong Ngoc <son.luong@booking.com>, git@vger.kernel.org,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Subject: Re: [PATCH 2/2] stash: remove the stash.useBuiltin setting
In-Reply-To: <CA+P7+xqVyMnG6FiyL4hngPfEEMi5CKz1qN5Cy1TMMpLg3CmsBw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2003061509530.46@tvgsbejvaqbjf.bet>
References: <61922A39-13DC-4B17-94FC-7F67DF308347@booking.com> <xmqq36ayob9a.fsf@gitster-ct.c.googlers.com> <20200302181832.GA1571684@cat> <20200302181924.GB1571684@cat> <CA+P7+xqVyMnG6FiyL4hngPfEEMi5CKz1qN5Cy1TMMpLg3CmsBw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:6004H9rbMEAFwp/q2m+qdmJEDR6JjqrDZcZiMx9zel4HrMyc6WM
 d/o5As9fU2D9op6zxOBeTjDozRNtBD+4xAna8g6oWN+Kbmmr6SbVYIYcO5FzIEhKcKF63qg
 Fie/4LQRWb6nOLnbuXablYpv6thulWkgSQsVptmZIu2Y2jQQZZ19wC9G9tQlicLDlJgbKVz
 0evL2U95H2kSuGPTEn3uw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VukIudlCq0s=:W0ZsapVtTKnAvB5ruJbM1d
 Dqj3okPnco5pk7xpWxFCSfYp8KsN0WJYoy0G5qoXv+F0RrSRNDQhIrZT6+XcZg/vzJzi0bkbq
 1ocUdZQ8v8kaUujdzMQepNFIu4Q8ZTL04DlLxMnl2ZkutKRFzhIKx8SdThsSaCCXPfga2V6j4
 RrM1w2QlRV002gfcc/SbizvA7zK7KoLxzqCIfLli2PFt3iE/L02Gae0V3jp15fKku+m3PAvjF
 6OWbkzhOjhNEEteTHaDJXrkUP7Nz5wkWMtLZHxZTlSwe1RdSYQhtLPPr/+wcRr4zLoyirgv3V
 9lDl6fnY3292OEKWW5n1tDYB5/eBjGVPCPrgkUIpIcG3CD+gK87Dn19vD5Nct91avn3Z3YAph
 ffpxrbikd/ORnUI6+dLHMjsgGMcXqeQjpRuimPg/iWxE4Z30SspIo6z9yERpsNtftu8MyXwri
 Q2o5QAhtlNPbejEWd4TqKOqQoofKzj40BU+u+6mQldrt+rFm10UO4lLuegfnnwzLAhyaqYrJj
 lYPXSXHFeTfOACQY0gWfLT4BexBeXa8dVxOgP7Pr9SQKJc1Ee71cBSi5dNzFSeact8plqAJay
 djJ/7Xky0d5IkSfdEFZKBoGxBOWeD8TZ3hHeO2Zu8bcr9RGUxhovtmPIYhzCH8CNgRvZsaLUV
 1t9zjB2eAlvMw8y+0Wk3YdIzw26da4jb5vCbyqwM1zx5q1NRkvZE4YNjCYn7hBfsnQt12vGqM
 Uml7DHuE7a8mwPxqCg+o+qQL0RrYqYHO4CL4FT8eNLFdHtdaBklb2YGqD+tXs/tPewqal5IIe
 epwFnuMwyFOzn0MICV9Bqzr0c49Mu9tNcscdhvMN3IzNCyittpB6XuNPtFYZTSLSEAMPmX7Wr
 pU9dsFJEwJW9oc7EBOfUGp8aRtIYOy4n//P5b4Juy+65zh0ytH9PR5eDE5i4GU3chxemyMuxU
 lP0aQIY1x2Q+liqpYbQC6YZhWUbefIJCLLAdjoEFTBIruoyPbP1e+2MwBQuyqVrKdqz7cyob5
 0ePTd0+en1qe49zSM13UkROLIwiS8WnZKsd5cekCTK99MgneOCpMorKdPV+JaC3RS/XTmnOZj
 Szbg+cHLOdkOTBSb1wT5Zw2enRSGoojU+QB/X2sg4HF0GZPOqENWgcWqIT1OW8fLEf7zBzzLo
 iNDPuH5RmT9kTdTSIUx/xily01B11oK2zladGFMXs8i1YtjHhFwczbk7S5OP2qYfFBy95ROQ6
 2ZRkels2sWKiuPXRQ
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jacob,

On Thu, 5 Mar 2020, Jacob Keller wrote:

> Sorry this is on phone and might not hit the list since Gmail forces
> html.... but the docs say git-rebase when you meant git-stash.
>
> I didn't want to forget this before I got to a desktop

Good point. You mean this part, right?

> On Mon, Mar 2, 2020, 10:20 AM Thomas Gummerer <t.gummerer@gmail.com> wro=
te:
>
> > diff --git a/Documentation/config/stash.txt
> > b/Documentation/config/stash.txt
> > index abc7ef4a3a..0f3db821f6 100644
> > --- a/Documentation/config/stash.txt
> > +++ b/Documentation/config/stash.txt
> > @@ -1,17 +1,9 @@
> >  stash.useBuiltin::
> > -       Set to `false` to use the legacy shell script implementation o=
f
> > -       linkgit:git-stash[1]. Is `true` by default, which means use
> > -       the built-in rewrite of it in C.
> > -+
> > -The C rewrite is first included with Git version 2.22 (and Git for Wi=
ndows
> > -version 2.19). This option serves as an escape hatch to re-enable the
> > -legacy version in case any bugs are found in the rewrite. This option=
 and
> > -the shell script version of linkgit:git-stash[1] will be removed in s=
ome
> > -future release.
> > -+
> > -If you find some reason to set this option to `false`, other than
> > -one-off testing, you should report the behavior difference as a bug i=
n
> > -Git (see https://git-scm.com/community for details).
> > +       Unused configuration Variable.  Used in Git versions 2.22 to
> > +       2.26 as an escape hatch to enable the legacy shellscript
> > +       implementation of rebase. Now the built-in rewrite of it in C
                              ^^^^^^


If so, I agree, that should be s/rebase/stash/.

Thanks for paying apparently more attention than I did!
Dscho

> > +       is always used. Setting this will emit a warning, to alert any
> > +       remaining users that setting this now does nothing.
> >
> >  stash.showPatch::
> >         If this is set to true, the `git stash show` command without a=
n
