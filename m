Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56A3C433DB
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 22:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87B4B22C9F
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 22:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbhAXWZU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jan 2021 17:25:20 -0500
Received: from mail2.pdinc.us ([67.90.184.28]:38634 "EHLO mail2.pdinc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726445AbhAXWZQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jan 2021 17:25:16 -0500
Received: from blackfat (nsa1.pdinc.us [67.90.184.2])
        (authenticated bits=0)
        by mail2.pdinc.us (8.14.4/8.14.4) with ESMTP id 10OMOInT008049
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 24 Jan 2021 17:24:18 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mail2.pdinc.us 10OMOInT008049
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pdinc.us; s=default;
        t=1611527058; bh=RQ5fmcGp4v/04p5uCSn6czWKdkPJRO7Mr6CzTtw6doA=;
        h=Reply-To:From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=BDnZgfUPa79m21Nrm5DcSQzj3TK8HUApH0NdgyQyHvczKsr7GecF/lp33sv7xUXAj
         Fkt6YUOcPM/cSmE9gLL1NhIhl+ioec7RE5NeaqFJhZQdEd8l0Zd17nKvRP/f5Bhm+2
         83hHQwo4YeRoNIZW38s3u7XhPOpLl2m69elBi6dsdGtug+OqgFB+73R91FVhC9iAHO
         mVDWO/kcUNEr8kH3lGURYDdSyuXCffPOWtQZZSRb1NThuTwsAj0RuFiE2fjOmgSXGZ
         yGCrBZwts/F1mEhJekFeQtRu2eAU4FGV8v9lSyFAD/LV8nCtHAkGnLA5I25rMhq70s
         bfDnqvqDecMmA==
Reply-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
          <brooke@alchemists.io>, <git@vger.kernel.org>
From:   "Jason Pyeron" <jpyeron@pdinc.us>
To:     <git@vger.kernel.org>
Cc:     "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        <brooke@alchemists.io>
References: <B6DFB74D-A722-4DBD-A4B2-562604B21CCB@alchemists.io> <022601d6f27a$58a97200$09fc5600$@pdinc.us> <YA3nwFcYz4tbhrlO@camp.crustytoothpaste.net>
In-Reply-To: <YA3nwFcYz4tbhrlO@camp.crustytoothpaste.net>
Subject: RE: How to Verify Git GPG Signed Downloads?
Date:   Sun, 24 Jan 2021 17:24:28 -0500
Organization: PD Inc
Message-ID: <06be01d6f29f$ae6450a0$0b2cf1e0$@pdinc.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQE5lIx8gYb1u2GHCPlnvQhQ03cLXwFWwEnmAkA9tUSrVV0+MA==
Content-Language: en-us
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> From: brian m. carlson
> Sent: Sunday, January 24, 2021 4:34 PM
>=20
> On 2021-01-24 at 17:57:13, Jason Pyeron wrote:
> > $ gpg --recv-keys 96AFE6CB
> > gpg: requesting key 96AFE6CB from hkp server keys.gnupg.net
> > gpg: key 713660A7: "Junio C Hamano <gitster@pobox.com>" 59 new =
signatures
> > gpg: key 713660A7: "Junio C Hamano <gitster@pobox.com>" 2 new =
subkeys
> > gpg: no ultimately trusted keys found
> > gpg: Total number processed: 1
> > gpg:            new subkeys: 2
> > gpg:         new signatures: 59
> >
> > $ gpg --verify -v git-2.30.0.tar.sign git-2.30.0.tar.gz
> > gpg: Signature made Mon Dec 28 01:12:30 2020 EST using RSA key ID =
96AFE6CB
> > gpg: NOTE: signature key 96AFE6CB expired Sun Jul 26 13:41:24 2020 =
EDT
> > gpg: NOTE: signature key B3F7CAC9 expired Sun Jul 26 13:41:42 2020 =
EDT
> > gpg: using subkey 96AFE6CB instead of primary key 713660A7
> > gpg: NOTE: signature key 96AFE6CB expired Sun Jul 26 13:41:24 2020 =
EDT
> > gpg: NOTE: signature key 96AFE6CB expired Sun Jul 26 13:41:24 2020 =
EDT
> > gpg: NOTE: signature key B3F7CAC9 expired Sun Jul 26 13:41:42 2020 =
EDT
> > gpg: using PGP trust model
> > gpg: BAD signature from "Junio C Hamano <gitster@pobox.com>"
> > gpg: binary signature, digest algorithm SHA256
>=20
> The signature is bad because it's over the uncompressed .tar, not the
> .tar.gz.  There is also a .tar.xz and the signature is the same.  You
> therefore need to uncompress it first with gunzip.

Silly me, but maybe there should be a README in that directory, along =
with the signatures.asc. If not, then it should easily be found on the =
git-scm site.

$ gpg --verify  git-2.30.0.tar.sign git-2.30.0.tar
gpg: Signature made Mon Dec 28 01:12:30 2020 EST using RSA key ID =
96AFE6CB
gpg: Good signature from "Junio C Hamano <gitster@pobox.com>"
gpg:                 aka "Junio C Hamano <junio@pobox.com>"
gpg:                 aka "Junio C Hamano <jch@google.com>"
gpg: Note: This key has expired!
Primary key fingerprint: 96E0 7AF2 5771 9559 80DA  D100 20D0 4E5A 7136 =
60A7
     Subkey fingerprint: E1F0 36B1 FEE7 221F C778  ECEF B0B5 E886 96AF =
E6CB

>=20
> > $ gpg --list-keys -v 96AFE6CB
> > gpg: using PGP trust model
> > gpg: NOTE: signature key 96AFE6CB expired Sun Jul 26 13:41:24 2020 =
EDT
> > gpg: NOTE: signature key B3F7CAC9 expired Sun Jul 26 13:41:42 2020 =
EDT
> > pub   4096R/713660A7 2011-10-01
> > uid                  Junio C Hamano <gitster@pobox.com>
> > uid                  Junio C Hamano <junio@pobox.com>
> > uid                  Junio C Hamano <jch@google.com>
> > sub   4096R/96AFE6CB 2011-10-03 [expired: 2020-07-26]
> > sub   4096R/833262C4 2011-10-01
> > sub   4096R/B3F7CAC9 2014-09-20 [expired: 2020-07-26]
> >
> > It is possible that Junio forgot to push his refreshed public key.
>=20
> Yes, I think that's the case.


