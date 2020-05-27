Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CB1C433E0
	for <git@archiver.kernel.org>; Wed, 27 May 2020 19:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1142A207D3
	for <git@archiver.kernel.org>; Wed, 27 May 2020 19:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=chello.nl header.i=@chello.nl header.b="nunSyqx3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgE0Tb5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 15:31:57 -0400
Received: from smtpq3.tb.mail.iss.as9143.net ([212.54.42.166]:38878 "EHLO
        smtpq3.tb.mail.iss.as9143.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725306AbgE0Tb4 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 27 May 2020 15:31:56 -0400
Received: from [212.54.42.134] (helo=smtp10.tb.mail.iss.as9143.net)
        by smtpq3.tb.mail.iss.as9143.net with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <eaw.janssen@chello.nl>)
        id 1je1mL-0006dW-Fd; Wed, 27 May 2020 21:31:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=chello.nl;
         s=202002corplgsmtpnl; h=Subject:To:From:Date;
        bh=Zr/xjpCppG69TmZdra2Npz24Z3XyBqGjgkJ+DUYx2PM=; b=nunSyqx33y+xKjtPRala6/2rWZ
        igUE/XiSqeaQbHk9X6JFyL4FiSIG1/e/byApC23d9VAymcilf1hEqBY0xjPlRtOVhgEddwQ0L+cRQ
        1FdbTfEhELeKTfarW8qke6ckZcltjzLbQ/cN0iBFTs/wYPKrX2pKZYbQolZW9eRIXBh+JmTL064lJ
        nomfst6AZPXmAS34DxbWi50OwXAD442hg0L833BXhanPG9f5sOHGwVODgbysQlNrERZ4gNDjkzDCM
        mrJ4yCnt68tUocizJ7Re3Ru1hLTVHNOtK2F7h1qPUs5ZJvePjkiyJ9/bNnCNT7EwesdD/h40X2c3b
        RhG7rSFg==;
Received: from outbound-10.tb.mail.iss.as9143.net ([212.54.41.173] helo=oxbe10)
        by smtp10.tb.mail.iss.as9143.net with esmtp (Exim 4.90_1)
        (envelope-from <eaw.janssen@chello.nl>)
        id 1je1mL-0003Nl-Bq; Wed, 27 May 2020 21:31:53 +0200
Date:   Wed, 27 May 2020 21:31:53 +0200 (CEST)
From:   Erik Janssen <eaw.janssen@chello.nl>
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= 
        <congdanhqx@gmail.com>
Message-ID: <1983783029.127560.1590607913242@mail.ziggo.nl>
In-Reply-To: <021801d63433$3f0c5e80$bd251b80$@nexbridge.com>
References: <1098602171.79502.1590528083387@mail.ziggo.nl>
 <20200527124445.GB2013@danh.dev>
 <021801d63433$3f0c5e80$bd251b80$@nexbridge.com>
Subject: RE: [Feature request] Add -u option to git rm to delete untracked
 files
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev70
X-Originating-IP: 178.85.216.109
X-Originating-Client: open-xchange-appsuite
X-Authenticated-Sender: eaw.janssen@chello.nl (via webmail)
X-Ziggo-spambar: /
X-Ziggo-spamscore: 0.0
X-Ziggo-spamreport: CMAE Analysis: v=2.3 cv=INuZ9jnG c=1 sm=1 tr=0 a=9+rZDBEiDlHhcck0kWbJtElFXBc=:19 a=ra8t5kwndXoA:10 a=IkcTkHD0fZMA:10 a=sTwFKg_x9MkA:10 a=O45WepMlw8oA:10 a=Dx4yW56zAAAA:8 a=VwQbUJbxAAAA:8 a=-x0kH7OMmkFaufFYKnsA:9 a=QEXdDO2ut3YA:10 a=X_u8qhY6y2Nm79co_leF:22 a=AjGcO6oz07-iQ99wixmX:22
X-Ziggo-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello All,

Thanks for the responses!
I was not aware of the alias option, but it gave me the following idea that=
 seems to work:
git config --global alias.rmclean '!git rm -r -f $1; git clean -f $1'

A dir with a untracked file 'file1' will give:
git rmclean file1
fatal: pathspec 'file1' did not match any files
Removing file1
but effectively the file is gone.

A dir with a tracked file 'file2' will give:
git rmclean file2
rm 'file2'

alternatively, ignore the errors:
git config --global alias.rmclean '!git rm -r -f $1 2>/dev/null; git clean =
-f $1 2>/dev/null'

some setup as above, untracked file1, tracked file2 in one go:
git rmclean .

gives:
rm 'file2'
Removing file1

So I think I solved my own question :-)

Kind regards,
Erik.


> Op 27 mei 2020 om 16:29 schreef "Randall S. Becker" <rsbecker@nexbridge.c=
om>:
>=20
>=20
> On May 27, 2020 8:45 AM, =C3=90o=C3=A0n Tr?n C=C3=B4ng Danh wrote:
> > To: Erik Janssen <eaw.janssen@chello.nl>
> > Cc: git@vger.kernel.org
> > Subject: Re: [Feature request] Add -u option to git rm to delete untrac=
ked
> > files
> >=20
> > On 2020-05-26 23:21:23+0200, Erik Janssen <eaw.janssen@chello.nl> wrote=
:
> > > Would it be feasible to add a -u option to git rm to specify that I
> > > also want a file deleted if it is not tracked by git?
> > > Currently, git rm -f can remove files in whatever state it seems,
> > > except when it is untracked.
> > > By allowing a -u option (-u: also delete untracked files) I would be
> > > sure that the file is gone while it would also make sure that it
> > > doesn't break past behaviour where people perhaps rely on git rm to
> > > leave untracked files alone.
> >=20
> > I _think_ remove untracked file is pretty much risky operation, and it =
should
> > be done separately/independently (via git-clean(1)).
>=20
> A git alias could easily be set up to do this, of course dangerous becaus=
e of what git-clean does without any arguments:
>=20
>     git config --global alias.rmu 'clean -f --'
>=20
> > Let's assume we have -u|--untracked,
> > nothing (probably) can stop our users from:
> >=20
> > =09git rm -u src
> > =09git rm -u .
> >=20
> > Even git-clean(1) requires either --force or --interactive because it's=
 too
> > much risky to begin with.
> >=20
> > If we think Git as a FileSystem, its rm should only care about its trac=
ked file. I
> > prefer to just rm(1) instead of "git-rm -u".
>
