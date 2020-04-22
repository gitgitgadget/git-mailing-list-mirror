Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D07C54FCB
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 22:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7539A21655
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 22:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="OXr9utxz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgDVW1R (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 18:27:17 -0400
Received: from mout.gmx.net ([212.227.15.15]:34659 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbgDVW1P (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 18:27:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587594419;
        bh=ReRUflBD/mOP48EyLBH9qbna3lSji8QCXIBz+ViUkHo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=OXr9utxzWQLBWRem7GiHkMth1Y+4LaBGzIW4WVNX7788rmOd/zPKNoPcrXH5HW94T
         YyxXmEnj81ewQ2ZQJjyM34zBKsyDgK/syGRkHK4CGDxYGEuN5MtPsFWHtuy/SeeGs9
         NFBAmsNvYGhrw+//+CNRcGso0b6K/Q9XaWYyuupY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([213.196.213.165]) by mail.gmx.com
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1M5wPh-1jYpwn3lIR-007YKj; Thu, 23 Apr 2020 00:26:59 +0200
Date:   Thu, 23 Apr 2020 00:26:57 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Ilya Tretyakov <it@it3xl.ru>
Subject: Re: [PATCH 0/3] credential: handle partial URLs in config settings
 again
In-Reply-To: <20200422221334.GA571740@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2004230019170.18039@tvgsbejvaqbjf.bet>
References: <pull.615.git.1587588665.gitgitgadget@gmail.com> <20200422221334.GA571740@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:2Ds+4DWkY+frsk1pRFwKAM6O3Wr/1Ejk3p2GtYufOwO4B/dua1c
 2UxYa9defQpEYmjQ3426JKcTHZz8g7GqMFRUD4WngetPHEnOrGatytxfQHcdGChI//TeC7H
 saVF3HLlRwaLY2KIZC75TSvW5+J6GCkYlgbHPAMST/o2IV8WG+FUGPLl4RE83Qgpe6rL7Gy
 NIJd+IZf5RjC/hZaKmqVw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1gtUzQzUpHc=:xUtSbL3t1hWxVjDdx9wM3S
 FOWIvlxUZRY3vpj9ClkXLApnjfmtHsC3fbcaG6Qnsly24G0Ovyi0FVOSQ9Gd826YZrKZq/tiz
 A790CIDEtf/pf3pDcADRAp2r/RP8Y5VQogvAXcAeNhhiNAcb4+i739qaPSgaGdBYTjG2u7k0a
 /FdS90XSYy/qx1QNCWpPVNzU0gzQ2yku1uSXR3Uv2vAX8rcLWElOG3HuxwaMY7kjYH1h0VBCw
 TkFp6N8psaUGOsXye1QCPXY+e3uWqVBGgMxaUycSPdWwHCzqiUDOZP6SgO71opTyWNfosrKex
 AU3AHFfKjuFQ5qmP70p38r3yjPRp/wo55dCWN0qytIWBob9oTeFzTFykmzgpfp7qH0JgoEVZb
 bm6I7A40cYHVB0OHOHbivQFOf85Z/qo/hgTNgLBCjWq0vopgJNfYMu++pTgySQJTDI6bOrDqK
 ZPziGlvJ2iyu3kOJi4FmHq/kNC3frrlI/wx7qaN4OjIvSaOULMIa8RFlaASW9ibiOeMLLIe04
 VdWVusyIsma4EQMTbt9EukvNAdfCE35d5U3XBGndeVZJt9oA0IYcyjh5lyYJddgepAAK/iQpk
 6XfY5geMBo/Ss8iF+X+4bO8DpKQBAa2WPFaxrC+KEQlvxinwzgsiEgdKlnn7mJ3vfDDMN4SD6
 QBaKRWTMjdyUTCA+9OnoLFsHBNybIXpiE1PqUfxztULDfr6P3nRPrRm1qej8c/TY9pCjnG60J
 G9f1LeOnAowoqWiLtcphmyu98G5K6nBxjIsx6WDFqLXviYwqDCrcpfQXBs6VzkJa8kG9qUoo+
 Wsek6okYQDvEL7ixz74p+Nw6TXjMxEpR8MI/mfBqCST/Epo41dG2ISqfou6iCFfRN1s/asTbo
 T1ARA7z6EseFxCX6asKXvC+lEeV0QGyY1jZj4NRSMrdqL3ryl8gmfTw9sGa95ZtZhVo1+yVvP
 40Xwh6CuesNFeE5PdREz4FXJm64Hn68uliEZLJiNBArjO2W8x3z2benVVtRQ9RHXtOoYoi6+T
 WLTNKZs2/exUu9s7295v20AEH7ujVtBLDHnrMfjd7jWK8VeEmCX8ZmwOkLUGlcIlnMeg17fv4
 JQLH7IWoxkp7ptKbIyyemSk5PPf821tR/k2lv1w1Y3Kr/zhsdWgjJQRlpA6K+tIisrfSOItd6
 FiKFSllqIdmFc94BZH/n1Uo7UlGAxvmlIWHquqgd+MBX4yIweDl1B1EsPKQDCPtpjwISo6Xxb
 Kdq1+VcbifwADN87k
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Wed, 22 Apr 2020, Jeff King wrote:

> On Wed, Apr 22, 2020 at 08:51:02PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
>
> > This fixes the problem illustrated by Peff's example
> > [https://lore.kernel.org/git/20200422040644.GC3559880@coredump.intra.p=
eff.net/]
> > , in maint-2.17:
> >
> >   $ echo url=3Dhttps://example.com |
> >     git -c credential.example.com.username=3Dfoo credential fill
> >   warning: url has no scheme: example.com
> >   fatal: credential url cannot be parsed: example.com
> >
> > The fix is necessarily different than what was proposed by brian
> > [https://lore.kernel.org/git/20200422012344.2051103-1-sandals@crustyto=
othpaste.net/]
> > because that fix targets v2.26.x which has 46fd7b390034 (credential: a=
llow
> > wildcard patterns when matching config, 2020-02-20).
> >
> > This patch series targets maint-2.17 instead (and might actually not b=
e able
> > to fix maint due to that wildcard pattern patch; I haven't had the tim=
e to
> > check yet).
>
> Yes, this will remove the die() in all versions, but in v2.26.0 and up,
> that config would be silently ignored (and your new test will fail).

Thanks for testing!

> > Please note that Git v2.17.4 will not do what we would expect here: if=
 any
> > host name (without protocol) is specified, e.g. -c
> > credential.golli.wog.username =3D boo, it will actually ignore the hos=
t name.
> > That is, this will populate the username:
> >
> >   $ echo url=3Dhttps://example.com |
> >     git -c credential.totally.bog.us.username=3Dfoo credential fill
>
> That seems scary. What if it is not .username, but:
>
>   [credential "example.com"]
>   username =3D foo
>   helper =3D "!echo password=3Dbar"
>
> ? (Or you can imagine a helper that is pulling from a read-only store,
> like "pass"). That would send the credential to the wrong host.

It would. But I am not aware of any implications regarding `.gitmodules`
(for some reason I now expect every bug to open an attack vector via
submodules, I wonder why that is), so that's at least good.

There do seem to be a few projects that set a
`credential.<hostname>.useHTTPPath` as part of their build, but I doubt
that that could be exploited.

> I think any fix we do here needs to make sure we are not any
> reintroducing wrong-host problems (though I do admit that the usage like
> my example above is probably way less common than vanilla helpers that
> do the host-selection themselves).

Yes. For the record, I tried to be very careful here. The _only_ code path
that is affected by this change is the config reading. Reading
`.gitmodules` (also in `fsck.c`) should behave identically to the way
v2.17.5 behaves: they should not allow empty protocol or hostname. If you
spot any difference in behavior in this regard, please do let me know:
that would be a bug.

And I do not think that these patches could re-introduce the problems you
fixed: the `credential_match()` tries to work against a `struct
credential` that has been sent to `credential_apply_config()` and as per
your fixes, this function now verifies that neither protocol nor hostname
are unset.

But again, I would love another pair of eyes on this, to confirm my
analysis.

Thanks,
Dscho
