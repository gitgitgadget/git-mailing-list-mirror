Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06130C77B7A
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 13:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235437AbjFBNCi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 09:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235196AbjFBNCh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 09:02:37 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF7019A
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 06:02:35 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 8711A5C00D3;
        Fri,  2 Jun 2023 09:02:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 02 Jun 2023 09:02:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1685710954; x=1685797354; bh=MQhWXWSdEtS18IYY0cQSbf/xI
        1vRIJGqNciN7b2g53I=; b=dAk296bcx+ZT3lsmdALxoFoF7NfisLHwD4WAM2V07
        OhCgnT6EnS4+PsCdZ/ODWO0I1VP91QNBpBzxQjq1ze+WXbON0ss+HyiSlj6Ad8wZ
        FCe7aXCBEkZ6hjPf2wGtGd5NCVTsmKESTNTSrk2knCkunh8Xp62v63XmWUZayZWa
        pttA1WyNT2Tp4Ly6CP5MQWSeY414C+WYfukHSyctV9+QSuA18yDaMpy07pWWa/sZ
        Skf28mpjPNLyrvfoK5T8BbyYwVPakDRMRWXJR30WMYadXKBN0wxo7Hs/j0MbHOrq
        XrfvA/lv3GzNQEZ9z1porrAqLVhM5ecLmgbs46MaLzYnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1685710954; x=1685797354; bh=MQhWXWSdEtS18IYY0cQSbf/xI1vRIJGqNci
        N7b2g53I=; b=XqwW1NA3tWAPo8x0N7hzmHSfRUfh/VUt4SMk0mvywIHHNbatWG1
        zYc1Y1zKyWhIjIA9VjwItCgIVDaZ+vvGt1iUi1egIaoh9cILGCs6l0u+8wFmF+uu
        u2jvEIxsfGyvkFUK6SOUrItl4jXLldF6ENu39ErcV0aJbxY16MyO+CCutJO8ILa3
        tCAuGLvyEhS6IrM8GR0m99kz0EbyutSrOeH+9/k3FOUR8BfSK8/06xTcTDfqYKBf
        hChrhH1gXfeaCCU34WtsuCTHiomG4FuuAW0pwzHNpleb2C68Kl0eRf89suc4Lkhg
        UuXF6lRc+Waj3ZD9JlMJEvd0b1DA926elpA==
X-ME-Sender: <xms:aeh5ZKSmkKhS0xfTMDo_vipqsA9K7hDENjW5S2z5urZOQIVRq2C4Ag>
    <xme:aeh5ZPxndNpiEqaDp8Mne8khatIMrMB9kvVK_5zBT6YN0EnuBVwiUUqUk6I6QtwYF
    5QmkN_Pnh7bESC-RA>
X-ME-Received: <xmr:aeh5ZH0GrfRnqiHNMfT9JYO8PzQ-T9Dv-7OI7x-Rm7o9IhQWou5zSmfcwZicZ5BEPZljgai5lpjzNn0gWiHT0urNBow8nV6az__SAR51SFsgOg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeelfedgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkgggtugesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epuefguedtueeiheetleevgedujeekjeehleejjefhhffghfevgfekueekjedtieejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:aeh5ZGB9n0cdVM79wCICW3ZZYTjPpuj5HI_DUSe72CJ_KnkIdoRt-g>
    <xmx:aeh5ZDhmUNp6aFLF_AOOYIR9dI6QP6vlAD-IRgEHYFm9q_b11Wphcw>
    <xmx:aeh5ZCpymHwimy7VYQK7qMYQEFREnNxSPHn3a7lGCsdogawi5xX4Fw>
    <xmx:auh5ZAszSTpze4dUcE1mPfv5-7JaF_KXa-HnTQ4QL9iV7ppGERL_8A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Jun 2023 09:02:31 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 2e67e400 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 2 Jun 2023 13:01:33 +0000 (UTC)
Date:   Fri, 2 Jun 2023 15:02:26 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/5] cat-file: introduce NUL-terminated output format
Message-ID: <cover.1685710884.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FYzoyfwhlOXhe1SN"
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--FYzoyfwhlOXhe1SN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

with Git v2.38.0, we have introduced the `-z` option to git-cat-file(1)
that causes it to read NUL-terminated queries from standard input
instead of the newline-terminated queries. This fixes issues when the
query themselves contains a newline, like it can happen if e.g. we need
to pass a path-scoped revision with embedded newlines.

Unfortunately, this change is causing a new problem. When the object
cannot be looked up, then we print an error message that echoes the
input:

```
$ echo does-not-exist | git cat-file --batch
does-not-exist missing
```

Now if the input itself contains newlines then the output can become
inherently unparsable:

```
$ printf "7ce4f05bae8120d9fa258e854a8669f6ea9cb7b1 blob 10\n1234567890\n\n\=
commit000" |
    git cat-file --batch -z
7ce4f05bae8120d9fa258e854a8669f6ea9cb7b1 blob 10
1234567890

commit missing
```

Ideally, `-z` should have also switched the output to be NUL-terminated.
But it didn't, and we cannot change this issue now without doing a
backwards incompatible change. Instead, this series introduces a new
`-Z` mode that switches both input and output to be NUL-terminated to
fix the issue.

Note that Toon has sent a patch series for this issue to address the
same issue, see the thread starting at [1]. I've collaborated with him
internally at GitLab to arrive at this new patch series which thus
effectively supersedes the patches he has sent. The approach is also
different: while his patches start quoting the output, the approach
chosen by my series only changes the lines to be NUL terminated. This
should make it easier to use for scripted purposes compared to having to
de-quote the input.

I've put all folks that participated in the original thread into Cc.

Patrick

[1]: <20221209150048.2400648-1-toon@iotcl.com>

Patrick Steinhardt (5):
  t1006: don't strip timestamps from expected results
  t1006: modernize test style to use `test_cmp`
  strbuf: provide CRLF-aware helper to read until a specified delimiter
  cat-file: simplify reading from standard input
  cat-file: Introduce new option to delimit output with NUL characters

 Documentation/git-cat-file.txt |  13 +-
 builtin/cat-file.c             |  85 +++++------
 strbuf.c                       |  11 +-
 strbuf.h                       |  12 ++
 t/t1006-cat-file.sh            | 249 +++++++++++++++++++++------------
 5 files changed, 232 insertions(+), 138 deletions(-)

--=20
2.40.1


--FYzoyfwhlOXhe1SN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmR56GEACgkQVbJhu7ck
PpTgUg/+OyA6op1DwPzx2NIziAfd5B6P+enf+0yFMIcXl+Y6nunXzc0v0qF+lkJt
6qsyAHE/efQZCBL0Gg+gLSSf9xgrwlLVcU1YFgK6AX8FW40VhP+VilDmapBnF/md
ilnpZiqDeuv4U3s+ltbapvN0buJYAxQ8MukiDorq0XRIyRRkuvxS+LBUU75N5kBk
rCnEkDJuk0KXFrU9YuiKT1aGcbKu6wsjqOounnprfqYWIeT1FJlYmPQ+ULIZxXwA
eQbhocH6DrOeVIqKku6Zxt3AZKtJScqLnMTrA24Jp9zCchOfNTkgE2nTAU2Az853
tLq1jNu8t/FIKIguXDwxvVcEjUmxywOP269yKmMg07qtosUkrx/8vFhq2MpQf5Pk
lk/wCcbvuztZhh3JRoJtB7aF3eDCnjoRPJWn1yKC/E3c8h362Q7qFZmQyQKw4GPl
QZ4VFhnVdUGqGg9h4jOq0FZAPnzFuP12//Oe460tNpCfOwuu+Z++aeY+UuJKxrj6
a/UV2hx7y520fweEsMcfVAuBnZ0PsaulZktjOR3/fRjOR1rRPSR54bpIugovL75g
ll0N9XdZSq7ZovNiy4Mi76/f8jHpWgn/mLsc6z5vAFODhTCZwyv200TJRpHVbjYV
ioPskAXiKAhwhlWfcy93eeJDK5y8EGBhp/MEh6xv1bRidpzj0+Q=
=s2/I
-----END PGP SIGNATURE-----

--FYzoyfwhlOXhe1SN--
