Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADC8286D4D
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 00:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790296289; cv=none; b=CskkhYNoHtkHPFrZZMMGtjKYF6x7liFymZzltgHqxy7yTSDjqMXbqA2p165bP+tbwGQxyeb7Gg4z3TPVY4igvKqMNZu0Z1EUiK2MAov5O7EII2zDqoDNAgEP+Y14S144m1fsi2jmGD318U0G99L0JDehJgfgID/nnQDrQw8GrUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790296289; c=relaxed/simple;
	bh=nLGVQ3WWvx39W3zx8NdLFxSKmf5XJtXigCAqY6XVIBk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=qLvZ6Y7OYcOxWRbVxlPItKv88c+vyioairOuLUjfEFgDWE7UuPpb6uRmddAiMDIMwn9tcGv163klcM1+h9+FA08bbXiKAtPdVXOBE19Qsk0n7/56VOup661myIhRfQFkGmpdPHfQ8P03nRneyRFHylReSzOWPE6YN8QfCdJYj0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=g4bQyfbZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K513Mn4L; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="g4bQyfbZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K513Mn4L"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E886D7A007A;
	Thu, 24 Sep 2026 20:31:25 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Thu, 24 Sep 2026 20:31:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1790296285; x=1790382685; bh=cJ
	Ud30NWI7Wjj2j+awqbXIktSDzU8IxZP5sUvhMO474=; b=g4bQyfbZQnvjmUmmwp
	gs1JoUpnU1MJ/SO3bWpVeHEcazgVrAoKyXmZGfduMbhOuUJ0Z6IA8Yo0x42PH7oe
	EDrPZuX9dbCkGEmgpwTw9WcXO4R4k7cNOg5rHiV0BFjc+z10exHRWUF1EqaQrnwq
	ZFOPkh8xfIT+vhdNOGQIdW3HvhFnUHo/6OHctVj6PwsIbMo1WuTkKzNWipw3bQTk
	aDmHyGKs8eNEwmiVsd0or/P7vXhWbIehY2SoCb2UbJ1DZYxW2HUG6ON/aq1wSDKq
	KeQXamE3A3D4Pa/W4AcKfbBoUtcRGCjQp8lnaq4Rv0LGkEKxvKAZIdZCoXTDz2Px
	fMiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1790296285; x=1790382685; bh=cJUd30NWI7Wjj2j+awqbXIktSDzU
	8IxZP5sUvhMO474=; b=K513Mn4LserDOQZdD/8db9+kDxKII8jrhluLZKT8QRC2
	/kfIbFNSn9nWpo6Ah9Ete5Sn3Ecd+cc/DP3fx0cHW1WY67CUzo96TO+MGguefFnG
	hXlAy2bx5mV6sr3IFQHif4ft9yEVx8TotDwtWR6zp3VRauYioCcwBRCopgroKITu
	GIDalZqKvI80XPq6ReW89ZyANVg/UL2i5633umln0HZvDCCCD+RasI8VjiT3TJ9P
	UedUY/TGiqgnPrkVukQDUbZzEznnOZlnynhU2clcMeMkM1nwlxiwHH18/qdPGq9G
	oND9f+5/Fq4+YUR9tpA9mpBduplxJbKQzt9v6DHQ8g==
X-ME-Sender: <xms:2sC1aoGhzEeqg_aAQX77JzsETKiNr3SxPOHlLKcuGbx3DG6aI-OIQNI>
    <xme:2sC1asJ9tQcz6afWQjmI-4300Z5GNLjeQlOg3RH8-lcOaOind0ePciLrxr0lbgdEK
    vubGRHePSmz22z-6pF4_16fNhM22Ex1lzgzyJ8I6yIt6968xfdJ8Kk>
X-ME-Proxy-Cause: dmFkZTGmy4WV6WkQwFgioUhEumg69I8/O/MmpQlznA8Gw/ireTHiWX/LgUUMXptM72Tkhd
    Z1rxzYNdB4ZPc3vlO/tgVjHoECukeyePE/MDwntWvFOpKHyHTpub7O5MlLuOSJbkmi6wIS
    /T7orXB336zXDyJA8MJDrXyxp0t+foE38HKfNYk7khidTUHEb4xfcEeF5Wj34rx/2cm4iB
    PcEJTmpriqW3PpEo4MesW8G7BoSrhp4TO131VYuCYas22XJ0MOTnEBPgUFbNPZGYpZ3fhr
    k1WcncuCO8T/psirbu2p9XKVAMgQcAsgEDtGBZAjHTV/rhkEDAF1TFW1gN3sFQNsV123JU
    U7Uv+4eqVCEuupxItutWLNl4N8uQRXemoRlSY77blvayOQhk3Wnvo3Avc8uHguxCxrfQK3
    +vAEsfv45hEF4KymyS3sOTImw0V1FWZANMahr8vAAyMq/MdRCfMrUI2XhBlKHv5wQNvwfR
    pPeV5rEXYs2DZARc6o5WF6pIC99enfwQB8gmeO1WZqMuO5o57oearH7lROJPV1K83Zpeul
    wpdTqrxkge6BqGQwjvtwFcUbVAYa8s/ii6v+Ar3hRG/EwoDiuzaDNMma66/b5CsFB7YMcd
    z4pLNt3tcKje8whZtIEwNvDfP6ULytbWR5+aVjmJ09bGiHAsvZz0oCvcWRuw
X-ME-Proxy: <xmx:28C1auxq9l0fhrlwe7Dgp-joci6DFgOHT3CcOwj9dC10X4tGw7r7ew>
    <xmx:28C1aoPXZccZUqwMPW9ggpbntGWrRlG66iz_mdPa3cGmD5DT0LgRRA>
    <xmx:28C1an7yhpaz-4kkQIGiRUeBEl8DoQb8V-1PN2Z0ypAS8iXZn-Lbog>
    <xmx:28C1ahNfEsPyGY_T8E_ODevIB1tRxPOlXaI64DmQ6IqxlmwI-siFrQ>
    <xmx:3cC1amn6BnsaS3oQ9YPm5nkSwpD4Ii9-aKynLm_yrvwJOwrP8yjTB1H6>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id B516A22C008B; Thu, 24 Sep 2026 20:31:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 25 Sep 2026 02:28:57 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: git@vger.kernel.org
Cc: "Jeff King" <peff@peff.net>
Message-Id: <74796901-ffb1-4cf3-bd63-7294328f70bc@app.fastmail.com>
Subject: =?UTF-8?Q?[BUG]_revision:_premature_free-and-null_causes_=E2=80=9Cunknow?=
 =?UTF-8?Q?n_option_`(null)`=E2=80=9D?=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

(the subject is my preliminary speculation)

     Thank you for filling out a Git bug report!
     Please answer the following questions to help us understand your
     issue.

     What did you do before the bug happened? (Steps to reproduce your
     issue)

```
git shortlog -n --not-an-option master
```

Note that you need a real option like `-n` before the
`--not-an-option`. Or else it will work correctly.

    What did you expect to happen? (Expected behavior)

This error:

```
error: unknown option `--not-an-option'
[usage printout]
```

    What happened instead? (Actual behavior)

This error:

```
error: unknown option `(null)'
[usage printout]
```

    What's different between what you expected and what actually
    happened?

I expected it to print the option in quotes. Instead it printed `(null)`
which I think is the placeholder for when the `%s` arg is `NULL`.

    Anything else you want to add:

I have tested and reproduced on:

=E2=80=A2 master: 0f8e75ab (Revert "Merge branch
  'en/no-amend-during-conflicts'", 2026-09-23)
=E2=80=A2 seen: e844e042 (Merge branch 'je/doc-merge-conflicts' into see=
n,
  2026-09-24)
=E2=80=A2 next: d58861e6 (Revert "Merge branch 'gg/http-ssl-verify-statu=
s' into
  next", 2026-09-23)

I have bisected this to cd439487 (revision: manage memory ownership of
argv in setup_revisions(), 2025-09-19).

Note that the recent topic jk/rev-info-argv-to-free fixes issues caused
by commit cd439487, but that topic does not change how this option
handling behaves; the topic is part of `master` now which I tested. I
also tested on top of the topic and got the same `(null)' result.

    Please review the rest of the bug report below.
    You can delete any lines you don't wish to share.

[System Info]
git version:
git version 2.55.0.793.gc667de3f2c5
cpu: x86_64
built from commit: c667de3f2c5e43830a8dfaa79a27d5d1f106f0ab
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
rust: enabled
feature: fsmonitor--daemon
gettext: enabled
libcurl: 7.81.0
OpenSSL: OpenSSL 3.0.2 15 Mar 2022
zlib: 1.2.11
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
default-ref-format: files
default-hash: sha1
uname: Linux 6.8.0-138-generic #138~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC F=
ri Aug  7 13:43:15 UTC  x86_64
compiler info: gnuc: 11.4
libc info: glibc: 2.35
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
commit-msg
post-applypatch
post-checkout
post-commit
sendemail-validate

--=20
  Kristoffer Haugsbakk
  kristofferhaugsbakk@fastmail.com
