Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED43CC6FD18
	for <git@archiver.kernel.org>; Wed, 19 Apr 2023 12:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbjDSMb6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Apr 2023 08:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232894AbjDSMbt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2023 08:31:49 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E80615467
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 05:31:32 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 592FB32005C1;
        Wed, 19 Apr 2023 08:31:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 19 Apr 2023 08:31:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1681907489; x=1681993889; bh=0lOs8wgjF0QzhakC8j+m/qivr
        o67PNUwSsNZ7cWIry4=; b=ofsAbSN4h3soa3MeGUOtQ5JvNqTzYzkd3ZtVfPWf1
        3vMJccQCX9cHPyrlFaeTONwzbjwlOW4bDWqnBvq4S+p2cqyXA4fFj85kMzfL4/CS
        VXbNWe7AXypWjOarIHlUcFY4tqqI9Ma6ECvPe1sfEvVA9CRwh1wCwXS5iKNPmR+E
        3a9wiCRc/i4GHxTyXGbn6I1vAH8/nizzV8OgISfg9CepECTBx5kRO6WbbmWn8N61
        R4SlZeXKyVotznWxnnpj5HsCdSM2kdeYTS8+bCvdRj2ki4N3C7WqGqerD5NfhUG8
        qPzUVJ8uBDmtnclwGre4BhHkZdT9rOnE9GZnxYKBQc11A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1681907489; x=1681993889; bh=0lOs8wgjF0QzhakC8j+m/qivro67PNUwSsN
        Z7cWIry4=; b=S3ce2lTftiH9FOJQ44MJuc3rriEXvq0UswAM7x7+piCmbt+i4Zv
        EZ6HQpGSi7LUYgqYGX76CQPim+J3EjiwaAQeF1McMFHpfW9Q/Yp9ZXb3Lf9T0yDP
        V8AcWxdrMTQl5iP9BlMbGPSInacGDCQDax4IKWdo5fEmmKzIW4A2fpYgLd01kUV1
        56tSR3P30TU1GP20YYH6zWNnXqpOjyqE+QYqXJExcSowAUl3mInD2T0P8ArfwqGB
        VaMhRW4ZF0TkLwh4MODDMP8FSN+n4HArSVq5V731HHt7ZMnO/Yug37DSHyS+BFlL
        OLcL1UmIAv7BrS999urg5tjkGqB08GbFDjQ==
X-ME-Sender: <xms:Id8_ZGn_i1wmhNq7czJ9iVOTZ1H-Gidi23xvPNYHXbJU0RPEzgvT6w>
    <xme:Id8_ZN0x1vnrUXGgDygBvRtj1w7nvSlzQyxZLRJ4cVy0wbc988g3VidQKtQGiMXPX
    4wOMpYzCQHqR7AHIQ>
X-ME-Received: <xmr:Id8_ZEohHGa6CbWfezx9KqH6JuLnhWSVgSW3zyKX3VfjK6y8dHNpagpSOyeRTIUXiw8YhsGMqdh4UoUF5TQtWYuu3szIdvEo7FvyBRFtwFlcLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedttddgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfggtggusehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeeugfeutdeuieehteelveegudejkeejheelje
    ejhffhgffhvefgkeeukeejtdeijeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:Id8_ZKkU_uCs1ezaUNL42aGZKIiN1tNJADlsKlR9DOC7OUXOpPGg_A>
    <xmx:Id8_ZE1mzug_WXtsbXJGSv0BGGiVZWIkSmyNeq2UawO59M88etCApA>
    <xmx:Id8_ZBtZrSU4cyl49EptqxVCS9x8UfvirUIYMdWx5P4ps1bCohADxA>
    <xmx:Id8_ZJ9dTJC0TSXtW2N5D4PwOEOG87Cgus9oAovKPZZ5GZhQWqKbOw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Apr 2023 08:31:28 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 2d396e64 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 19 Apr 2023 12:31:11 +0000 (UTC)
Date:   Wed, 19 Apr 2023 14:31:22 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 0/8] fetch: introduce machine-parseable output
Message-ID: <cover.1681906948.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="80RiOQtIqEGazlpI"
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--80RiOQtIqEGazlpI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second part of my quest to introduce a machine-parseable
output for git-fetch(1) after the initial refactorings that have been
merged via e9dffbc7f1 (Merge branch 'ps/fetch-ref-update-reporting',
2023-04-06).

Parsing the output of fetches is mostly impossible. It prettifies
reference names that are about to be updated, doesn't print the old and
new object IDs the refs are being updated from and to, and prints all of
that information in nice columns. In short, it is designed to be read by
humans rather than machines.

This makes it hard to use in a script way though, e.g. to learn about
which references actually have been updated or which have not been
updated. This patch series intends to fix that by introducing a new
machine-parseable interface:

```
$ git fetch --output-format=3Dporcelain --no-progress
  fff5a5e7f528b2ed2c335991399a766c2cf01103 af67688dca57999fd848f051eeea1d37=
5ba546b2 refs/remotes/origin/master
* 0000000000000000000000000000000000000000 e046fe5a36a970bc14fbfbcb2074a487=
76f6b671 refs/remotes/origin/x86-rep-insns
* 0000000000000000000000000000000000000000 bb81ed6862b864c9eb99447f04d49a84=
ecb647e5 refs/tags/v6.3-rc4
* 0000000000000000000000000000000000000000 83af7b1468c0dca86b4dc9e43e73bfa4=
f38d9637 refs/tags/v6.3-rc5
* 0000000000000000000000000000000000000000 ab3affb8ed84f68638162fe7e6fd4055=
e15bff5b refs/tags/v6.3-rc6
* 0000000000000000000000000000000000000000 1c8c28415e8743368a2b800520a6dd0b=
22ee6ec2 refs/tags/v6.3-rc7
```

The series is structured as following:

    - Patches 1 and 2 improve test coverage for output formats.

    - Patch 3 fixes a bug with the current output format.

    - Patch 4 to 6 perform some preliminary refactorings.

    - Patch 7 introduces a new `--output-format=3D` option for
      git-fetch(1) that allows the user to configure the output more
      directly.

    - Patch 8 introduces the new "porcelain" output format.

Patrick

Patrick Steinhardt (8):
  fetch: split out tests for output format
  fetch: add a test to exercise invalid output formats
  fetch: fix missing from-reference when fetching HEAD:foo
  fetch: introduce `display_format` enum
  fetch: move display format parsing into main function
  fetch: move option related variables into main function
  fetch: introduce new `--output-format` option
  fetch: introduce machine-parseable "porcelain" output format

 Documentation/config/fetch.txt  |   4 +-
 Documentation/fetch-options.txt |   5 +
 Documentation/git-fetch.txt     |  17 +-
 builtin/fetch.c                 | 406 +++++++++++++++++++-------------
 t/t5510-fetch.sh                |  53 -----
 t/t5574-fetch-output.sh         | 209 ++++++++++++++++
 6 files changed, 475 insertions(+), 219 deletions(-)
 create mode 100755 t/t5574-fetch-output.sh

--=20
2.40.0


--80RiOQtIqEGazlpI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQ/3xkACgkQVbJhu7ck
PpRlXw//f6FviEjWZ/5Ldac3j5PvbkV2RYhPL0+/ZPcXcEk8LTJgUrZrDrbyjI1A
duqg6dmXNcCw3gKE8AfhJ3ZOPYTKAVLhtwxAQcIpg75fKy7pbvnwCINEgijQSKTP
drwUQHk/fZYDWkwUEysSHX4r1KtSYyELP9biy9Srq26taHwE6hJFDfxuB1QnBxYb
5/TEiXSKZlIHcBSyDBhAwu6xeg/kLArs/EtzK+uKJPYkkYE5psKyuG2SHbwUoPxB
wKZ6Fuo49uOKtBWGS5k/Yr5eEdYOZ5+o/Bon4cu8zJGclvk/VSBpNBO+1iDwXXfv
GHQWA3ajeFYjQymU54fj+cDguub2CyH4d2KIdpRYwcp5M6Dkwo10ieJTGcZYIrDF
/MVlemvOstvLVR4uWgPBu78M+vQoVOergSexkTvTJbJgu7AxQxpQ8gbm1kIJ8+3X
pYyxZ+0d/NmsrmCiGJ/ExAQeg3/edC3VacRAT+3m6EBbdjpyqVBHyMIaYBhNk9ql
+Y67nakSoK7XXYcrkjiwYx/GVxYmf4ySFWDk5F4KIR+dbLFXxdla3ZYXa+oJdJzG
OeE8vByfCISR3aEAO4bSotdCaBom78/odyDr+VcHlQFvQnaXxXc3YWqIgZtVysa6
oHaJ4/+X4r3NzLMR2idLOw4oBZVcBmbtu2X2Mho7np1BZ4d/LGE=
=mJql
-----END PGP SIGNATURE-----

--80RiOQtIqEGazlpI--
