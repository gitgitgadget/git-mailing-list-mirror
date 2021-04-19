Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F0BC433B4
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 15:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79B5A6128C
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 15:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241463AbhDSPz4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 11:55:56 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:33955 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241383AbhDSPzy (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Apr 2021 11:55:54 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id C05B3FCF;
        Mon, 19 Apr 2021 11:55:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 19 Apr 2021 11:55:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=RiNj+dlrUouRf9EQSaYZXlCudQy
        Ep3xGtXhRTaEhOVw=; b=PL/NmXS/nxy2wH6+1fWR0celRAcwoRro5QFf5u7lJ4g
        w9CIIX9rJOeyVsvGtzQzrNWekvCxj22yDcfWrWg+8VI4ueUZYsxMkXxOhw/maHks
        XBdrK/vvvCBongh6vLGC/3NMybYI+eM1OGoepImmMwQzSypbcO7fVKJR1S1cjamc
        XoTBZtX7Qfv0qiy/C3oaLOZU6KZcQ3ow9YsQWLI/gWLm6N4lXDeUAWjbxyx63IqV
        V0B8jkDIi2yoXPVCuMwNVAh8YPw+DFGYXF8GtZJBGu8y45KSh0fn/wS7LiwR+Cox
        Mu86cKPtapdu9kZfxX8EYmn8DF/Jhdn0VagOdzJBBPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=RiNj+d
        lrUouRf9EQSaYZXlCudQyEp3xGtXhRTaEhOVw=; b=bHAU+7pKNM66O2XsZ2rbc+
        FX9zmDdDVFJbt+HejTkEuWjZD8tJhJCCH90IqfwnnizYTOIMLJlkkveJcqSVq3ss
        8C0foQLJetta8fAnlaiFd9eF80z0zR9OP35lmKox93N/HiVr8dDlzSiPPqy6T2ki
        ZyFZ5t4IAnZxZp3KAANtFtJHzJPwmDYYYrP0BhLE9kUheyGtDUJq5q9ZNNFSNprZ
        wIBpls83tq9cblYXygYqOp043G4aja0UIRPDYZlEcpsjIFNEIGEC1gKLF84fKL75
        bbjLRN2qz1oxAcD8aayG2eXhBCSeS8inGqZVydNijxWd/hR7G3nc+CkYtAIHFq4A
        ==
X-ME-Sender: <xms:7Kd9YCss8c7DuzdozVtMAMGimjnET5CYxpvR0hbp0LWfVNKkh7xQ7Q>
    <xme:7Kd9YBh77GTxLvzu-6tzrdpw2cItBk5bub9XezBtHM38RBEQ9nC0NKHxiC9SBVd86
    IFE63WKlWszKNIo8Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddtgedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtudenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnheptdffjeeiudduleehvdfgteeifeelheejte
    dvteduiedttedvtdffffefhfdvgffgnecukfhppeejjedrudeluddrieekrdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhm
X-ME-Proxy: <xmx:7Kd9YCtFEscxndw1NtTikXNMxO7tJXFduVDTXQORsi7wTjS8nRZlVg>
    <xmx:7Kd9YE_4fbRWP4opudOtBv7m3FjmCqkL-bTSZNuzF8MEFglbIxgswA>
    <xmx:7Kd9YAanUw9iR3Qou3Xg4qf156U-AjdrYBHg9aJJ3FMDlRz2iK8vLg>
    <xmx:7Kd9YBGwFS20Encp7Jmudqd-3FgYt_8dfnx0eprrRCMGxsZoSStGQw>
Received: from vm-mail.pks.im (x4dbf4450.dyn.telefonica.de [77.191.68.80])
        by mail.messagingengine.com (Postfix) with ESMTPA id ABC1E24005C;
        Mon, 19 Apr 2021 11:55:23 -0400 (EDT)
Received: from localhost (tanuki [10.192.0.23])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 86788e5f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 19 Apr 2021 15:55:22 +0000 (UTC)
Date:   Mon, 19 Apr 2021 17:56:50 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH 1/2] git.txt: fix synopsis of `--config-env` missing the
 equals sign
Message-ID: <08049f3b1088a301ea87db9a69454a2516b9525b.1618847606.git.ps@pks.im>
References: <cover.1618847606.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Z752L4XYgiAGA8Zo"
Content-Disposition: inline
In-Reply-To: <cover.1618847606.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Z752L4XYgiAGA8Zo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When executing `git -h`, then the `--config-env` documentation rightly
lists the option as requiring an equals between the option and its
argument: this is the only currently supported format. But the git(1)
manpage incorrectly lists the option as taking a space in between.

Fix the issue by adding the missing space.

Reported-by: =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com>
Signed-of-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 3a9c44987f..ba5c8e9d98 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -13,7 +13,7 @@ SYNOPSIS
     [--exec-path[=3D<path>]] [--html-path] [--man-path] [--info-path]
     [-p|--paginate|-P|--no-pager] [--no-replace-objects] [--bare]
     [--git-dir=3D<path>] [--work-tree=3D<path>] [--namespace=3D<name>]
-    [--super-prefix=3D<path>] [--config-env <name>=3D<envvar>]
+    [--super-prefix=3D<path>] [--config-env=3D<name>=3D<envvar>]
     <command> [<args>]
=20
 DESCRIPTION
--=20
2.31.1


--Z752L4XYgiAGA8Zo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmB9qEEACgkQVbJhu7ck
PpQb/Q//QjClaGi1WScFvQ8VuRcS8VUJBzb3iLhSsUdT88Z8gPI8K7IJqXOcy/w7
7SkbzfDhqpx2bChu4IihiJ4C21tSvm7YUpM9/Tp7+6zJ7GG7kKWIx0tbB9eKq3XP
ryTw4MCffGglo4RRZsy9ZX007uH+4Fw73YD3/ZNcYqOJXEzBG6OtpVAOUIt7zb1s
amsLLk6oCFfq2WqY9lvaN9K4tP5TRP/1F/jsdzKMUELvvtKerZw7kInhgETqAO2I
gdb21ccR6ZRC6xdr4TuonK2OS+TAzBvbaF2o5RmCspG+/UG2z8lahQMOPCjGsB49
cNVtL+yqXXk4JtmYokzKqVcSrA687O1Pb9/rYMVbFXIIE6Cfrd2CAr2MCS0HC6Xn
BhPt9UzGAkVYIDFtw22zgVKQCpcqN0u7Kb6Gt3daJGZOT9+yWWMxLt/+S4kLFshF
zBP+2L+JDZ6FJXc+jNXJBuUI7KOpDJ7BwbtsqUeNUI2GENUNpH/OZI7WJi+MBLk5
/1yyPKCxeb/JlPYVOn2syWn32Cqd+uaz0SAsZ0xbl86jD+5jGNv+bb1KDUrTVnVl
vbcuYOOr6hMXjnl+6aGQYaZTnwJKyV2mSwP+BBkR8np7o3w6qT38fnLi6kLkXMyY
HSb0VGe8nzyuyJB5tivbZOku58ceSMTnlyjWk4XguTR4wbRm0uI=
=s2TU
-----END PGP SIGNATURE-----

--Z752L4XYgiAGA8Zo--
