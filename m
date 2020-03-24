Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BAFC18E5B
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 22:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED672070A
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 22:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="LitRlcQ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbgCXW3M (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Mar 2020 18:29:12 -0400
Received: from mout.gmx.net ([212.227.17.22]:54531 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728227AbgCXW3L (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Mar 2020 18:29:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585088943;
        bh=DJzg0W6cx2VawU7G9VwT/JIJyHJCPpi9GWuKEEo+Z4s=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=LitRlcQ0Xsh1Fc9i4YRMsVQWj7tmJYoPX57y03fghVvhZwTHAsnVgJ5i+XNzBipNz
         AKDhiHXn3L9GFRgpGryc/63o4bhQJGM3XVQIrA49qheS14gxG9VKZk9dxOkEtJRt/p
         Z5gJ9pxtyD8nmRkOpQ+g8HZehycSQGkhiSmohjwc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([213.196.213.32]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MfYLQ-1jjL6d0ivQ-00g4Rp; Tue, 24 Mar 2020 23:29:03 +0100
Date:   Tue, 24 Mar 2020 23:29:02 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Danh Doan <congdanhqx@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 7/8] t4124: fix test for non-compliant diff(1)
In-Reply-To: <20200324034025.GE11801@danh.dev>
Message-ID: <nycvar.QRO.7.76.6.2003242328380.46@tvgsbejvaqbjf.bet>
References: <cover.1584838148.git.congdanhqx@gmail.com> <10f39c3d30d13e9141f081f985a0620954cc7493.1584838148.git.congdanhqx@gmail.com> <nycvar.QRO.7.76.6.2003231456200.46@tvgsbejvaqbjf.bet> <20200323150449.GC11801@danh.dev> <xmqq8sjq4wyf.fsf@gitster.c.googlers.com>
 <20200324034025.GE11801@danh.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:5/KTGamerPs8ifzUj/6WuShX/3Tm0XA1YUKsQHnjqpXsNpOm2Qr
 Xofa6lcOqR3ZuulcdL+cAzq08kxgkFQxshWTFw9qw16dx5tpq46J5wJfZEo4IipV84pK8OD
 7+fE5ofwRhXxmPBkzIgSGpAc5Nlej6Mat3cdW9RGaoesR5kj/JATxBO6liL/fiQcnKfoxyu
 s2OiTpqnYKIx75pAhVh4A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:r6qBCEk+sI4=:GcidY3hBIZLIa79esW9CTK
 CTJE0I4ULoPjEZ33WsfBWc4bCjorL00KHYbdwZBrG/8Lba+Uafh4xBcgxDj2h4D8e/jegs/jq
 9NFfM/qa65zfCYsk/EkcFKsILaJVVd0Ririkfv5QLnz4yIwZOIaLaaqDis1vmZKsxSzqUn4Qp
 N2jQeQsW3WqKFvY+uuswlIsMLK33elf6l+zBe8VB2UTt+mCbkHXUSLnYmtGnJx0CYH0TgXpZX
 vpp6o+ggrdEdv1z4UqyQNe+TErIMUl/ct/o8daTZ7FpMpmEnvtDbNHGrsk0V6OH1AzZNSb4VS
 SDdnjWFTSIsMEeVdxoogAzPItalkmCN8/TNxfw0GolAeWFqNn/gcoBcYChfKXRMTNzLKwCOdx
 IzkQj4koJdhBshAF2HCvUUTcc7MoBvBJ6/N6SBkbRB6ZDRCOyT2saBTNyBohyoEeykGqExgy9
 1x5EHZQWzKr2FzA4Cxrst7DMPDTgUmJ5W/GX6aFThAO+tiqkz7bPU9Z9WogVtkVp/ddvYgIHg
 6hwvd4LAXLzh7WcTfUJ7jqcQkWdZ80VZd7g2FFQyMitgn6R9SHXl90uoiB8LDArYM36CEBH/f
 NuGawpslSJCNrg73EmHztsnqRViopCoCq98+2eV+N3TapP8mwV6t2xTLigb6gwReOMdkXIl3T
 Vv8QTlmHslcjFnPhxiBdJNigW0qFctRU0f0Zd1OW+u0HZDRZSjhqG62b3LAlqEBj5PU66fyFe
 pJ/Imx/CRj6UuABuTGiwoM4fLBFPm1K2IMhkkGyYV1nGzA/LkgVMp/wJEwCToIDTKu8UhAJ2U
 x4eM+d2qxjXLEnylrPSPFrYpj38GbJGsDtUuBbOdHzHO6zsSRarSSE3rlbXoTmx/LKX+U/aYL
 +gctDKTYY3KjrtdhJMsl9tDFAuFwgBwLYEam84u+0kuyiNsfowwDFOSG/E/Snoi9Gq5w+2zQD
 o4ZloPFjq4f8sU073wrmTs2O3orGz+p+/KXfSwNcpDR7sEDztPHqkRrIj15Ezthkb+YO329Sg
 bSTnw1C/CppuCz0hnxV6tqAXZL251hPUJq0a4gU3gzHPwY/OPptEcmzJBzmUx8434111PVyWX
 bwY0HaaJhd/E39uVWcGWzF1MiNZsGJJ7978aBgpkBRcxSZuJr4PR8smfJygPv+VAJpKv6hbUG
 QNx4PWd7LrDiCT8c2QrPvv38nhqHY9j21r8uysfhZuDOotVEwjIcV2IfL3/z9K7LzyT4mLSje
 hc1nCKQZ6WgfnJ9GI
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 24 Mar 2020, Danh Doan wrote:

> On 2020-03-23 13:50:48-0700, Junio C Hamano <gitster@pobox.com> wrote:
> > Danh Doan <congdanhqx@gmail.com> writes:
> >
> > > A comment in test-lib-functions::test_cmp mentions that
> > > there _is_ a diff out there that doesn't understand "-u".
> >
> > That came from 82ebb0b6 (add test_cmp function for test scripts,
> > 2008-03-12).
> >
> > The change history at the end of the page:
> >
> >   https://pubs.opengroup.org/onlinepubs/9699919799/utilities/diff.html
> >
> > suggests that POSIX did not require "diff -u" until Issue 7, so it
> > is not surprising that the lack of "diff -u" to cause test_cmp to
> > fail was of real concern back in March 2008, as the application of
> > the errata have been only an year and half old, according to:
> >
> >   https://www.opengroup.org/austin/docs/austin_325.txt
> >
> > I vaguely recall that some open source projects only took the copied
> > context diffs and not unified ones the last time I checked, but
> > admittedly (1) that "last time" was a long time ago and (2) our
> > popularity and the fact that we do not understand copied context
> > [*1*] may have forced people to move away from "-c" and adopt "-u"
> > at the same time.
> >
> > So it might be OK to write off any system that does not understand
> > "diff -u" as an unusable trash these days ;-)
>
> From the setting in "config.mak.uname", it's likely those systems
> don't understand "diff -u":
>
> - Solaris 5.6, 5.7, 5.8, 5.9: both of them are un-supported version
>   by their vendor
> - AIX, only AIX 5.3 doesn't understand "-u",
>   the end-of-support AIX 6.1's diff(1) understand "-u" (1)
> - HP-UX: From what I can collect, HP-UX still conforms to UNIX-03, and
>   its diff(1) doesn't understand "-u"
>
> Hence, if we're going to drop support for system that doesn't
> understand "diff -u", we're going to:
> - remove support for those variables:
>   + GIT_TEST_CMP_USE_COPIED_CONTEXT
>   + GIT_TEST_CMP
> - drop support for:
>   + Solaris 5.{6,7,8,} and AIX 5.3, which will be fine
>   + HP-UX: which needs to be discussed
>
> [1]: https://public.dhe.ibm.com/systems/power/docs/aix/61/aixcmds2_pdf.p=
df page 133(143)

With this explanation, I totally agree that your patch is better than
mine.

Thanks,
Dscho
