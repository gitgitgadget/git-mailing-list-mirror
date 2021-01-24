Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF3FC433E0
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 17:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83A5E22581
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 17:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725918AbhAXR54 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jan 2021 12:57:56 -0500
Received: from mail.pdinc.us ([67.90.184.27]:40992 "EHLO mail1.pdinc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbhAXR5z (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jan 2021 12:57:55 -0500
Received: from lovegrove (nsa1.pdinc.us [67.90.184.2])
        (authenticated bits=0)
        by mail1.pdinc.us (8.14.4/8.14.4) with ESMTP id 10OHv4KS028076
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 24 Jan 2021 12:57:04 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mail1.pdinc.us 10OHv4KS028076
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pdinc.us; s=default;
        t=1611511024; bh=QDGwid/PwLj6MdW05ZuDKcGuYMlwpvLG8De+E6LduXI=;
        h=Reply-To:From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=rfGgGthIr2Hp6B9cmy+c/1a71oJ6HYHuiVFKOT2Nj9K4O22U01MbZNx14A6dxSgr5
         KtqSiY9eRpSFsiVc8A1XrnoBwot+FqOVmfoPowVw7rdZym7zDt1aNqL0vcqWIojHum
         dqJ6ynZPFxTlwEYNW1+SPnm9SF/kbDTa+H2HLUnqHG2FIzDIiS9jX4C1P+G5HxfNbM
         6L81eljGIk7B9MgK63OVGNphXN2wfwE3OdIQMnk8jTm801gIfPIaucbEVdeGWk0MrS
         /yI9pvQWIYJ/wM6ZB2LhYfr1RfVXLLedkPEGbimR2NmfabpS1K3QJIUurPSHtOcP6O
         uYvD24UmCcDpQ==
Reply-To: <brooke@alchemists.io>, <git@vger.kernel.org>
From:   "Jason Pyeron" <jpyeron@pdinc.us>
To:     <git@vger.kernel.org>
Cc:     "'Brooke Kuhlmann'" <brooke@alchemists.io>
References: <B6DFB74D-A722-4DBD-A4B2-562604B21CCB@alchemists.io>
In-Reply-To: <B6DFB74D-A722-4DBD-A4B2-562604B21CCB@alchemists.io>
Subject: RE: How to Verify Git GPG Signed Downloads?
Date:   Sun, 24 Jan 2021 12:57:13 -0500
Message-ID: <022601d6f27a$58a97200$09fc5600$@pdinc.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Content-Language: en-us
Thread-Index: AQE5lIx8gYb1u2GHCPlnvQhQ03cLX6txwjpw
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> From: Brooke Kuhlmann
> Sent: Sunday, January 24, 2021 11:49 AM
>=20
> Hello, I'm trying to figure out how to obtain the public key used to=20
> encrypt=20

Do you mean sign?

> the Git file
> downloads. I put together a gist that explains the problem and =
question in detail here:
>=20
> https://gist.github.com/bkuhlmann/684b74d25d83d52df8d0caeb6219aa15

Please don=E2=80=99t post links to questions, pasting your content =
inline here:

> Problem
> When attempting to download a Git version, it would be nice to verify =
the signature of the download by running the following:
>
> curl --remote-name =
https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.30.0.tar.gz
> curl --remote-name =
https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.30.0.tar.sign
> gpg --verify git-2.30.0.tar.sign git-2.30.0.tar.gz
> Only problem is that the last line of the above throws the following =
error:
>
> gpg: Signature made Sun Dec 27 23:12:30 2020 MST
> gpg:                using RSA key =
E1F036B1FEE7221FC778ECEFB0B5E88696AFE6CB
> gpg: Can't check signature: No public key
> I tried using the following solutions to no avail:

$ gpg --recv-keys 96AFE6CB
gpg: requesting key 96AFE6CB from hkp server keys.gnupg.net
gpg: key 713660A7: "Junio C Hamano <gitster@pobox.com>" 59 new =
signatures
gpg: key 713660A7: "Junio C Hamano <gitster@pobox.com>" 2 new subkeys
gpg: no ultimately trusted keys found
gpg: Total number processed: 1
gpg:            new subkeys: 2
gpg:         new signatures: 59

$ gpg --verify -v git-2.30.0.tar.sign git-2.30.0.tar.gz
gpg: Signature made Mon Dec 28 01:12:30 2020 EST using RSA key ID =
96AFE6CB
gpg: NOTE: signature key 96AFE6CB expired Sun Jul 26 13:41:24 2020 EDT
gpg: NOTE: signature key B3F7CAC9 expired Sun Jul 26 13:41:42 2020 EDT
gpg: using subkey 96AFE6CB instead of primary key 713660A7
gpg: NOTE: signature key 96AFE6CB expired Sun Jul 26 13:41:24 2020 EDT
gpg: NOTE: signature key 96AFE6CB expired Sun Jul 26 13:41:24 2020 EDT
gpg: NOTE: signature key B3F7CAC9 expired Sun Jul 26 13:41:42 2020 EDT
gpg: using PGP trust model
gpg: BAD signature from "Junio C Hamano <gitster@pobox.com>"
gpg: binary signature, digest algorithm SHA256

$ gpg --list-keys -v 96AFE6CB
gpg: using PGP trust model
gpg: NOTE: signature key 96AFE6CB expired Sun Jul 26 13:41:24 2020 EDT
gpg: NOTE: signature key B3F7CAC9 expired Sun Jul 26 13:41:42 2020 EDT
pub   4096R/713660A7 2011-10-01
uid                  Junio C Hamano <gitster@pobox.com>
uid                  Junio C Hamano <junio@pobox.com>
uid                  Junio C Hamano <jch@google.com>
sub   4096R/96AFE6CB 2011-10-03 [expired: 2020-07-26]
sub   4096R/833262C4 2011-10-01
sub   4096R/B3F7CAC9 2014-09-20 [expired: 2020-07-26]

It is possible that Junio forgot to push his refreshed public key.

>
> gpg --locate-keys torvalds@kernel.org gregkh@kernel.org =
committer@example.com discord@example.net gitster@pobox.com
> gpg --import <file> # <=3D Need a file to import but where does one =
obtain the public key?
> I also tried importing only the public keys from the Git repository =
via the following files without any luck either:
>
> t/lib-gpg/keyring.gpg
> contrib/credential/netrc/test.git-config-gpg
> contrib/credential/netrc/test.netrc.gpg
> contrib/credential/netrc/test.command-option-gpg
> Question
> How does one figure out how to obtain the public keys for which the =
Git downloads were signed?
>=20
> If anyone has any advice on how to make this possible, it would be =
greatly appreciated.
>=20
> Thanks,
> Brooke
>=20


