Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B36CC77B61
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 11:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjDMLRT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 07:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbjDMLQ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 07:16:59 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103139777
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 04:16:41 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 7084E5C0143;
        Thu, 13 Apr 2023 07:16:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 13 Apr 2023 07:16:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681384600; x=1681471000; bh=2w
        GOYkw5nzkZOfVF8Exuyo2UFYPMtUKFIpuZpl00aEY=; b=cg9XFQjpn0/OhxaPks
        r1wXUtQrzKVd62LF8HQQPz+3WLQxMtlCdpqbjj09jtP9n4sgEaJ3LctMF0CS23fI
        lBs2TH9cVihPWtJiWExD/vViH6VwIftP5Kqn3j3cOXM/Q5aGOq+DrFLid8QSCIK7
        VaYq3J8NepilchCkzYtJrM8t1iM+UM5A9ElPARPBpUHb1TgAqD3/9aFmyICyLUDq
        Ir/Rb5Id5kxJShLiraYa8YNWkYEflVzWToJHT4NvJiWe9SSl9gUm86rbuKaKBnSp
        FPuJyDbnOBWWSXFIzlQYZJHkUxevgxJ5hj9BzZ7pKl72Nn9hsIAX8ilAgMzn9OK9
        H2Lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681384600; x=1681471000; bh=2wGOYkw5nzkZO
        fVF8Exuyo2UFYPMtUKFIpuZpl00aEY=; b=G8clR7zTYHCruGhwvHf5y1MyMUYqb
        qqRwOsuQPIVKJNib3LpUzVSvFyO5H41MWbe+zqZZnCUnlSSqE7AjdCIcFfvWb9EL
        MJ4prytinfZirmwt+b4zEbrekuoaFmKxWLEUQOMjDz5pfuBk3kB4uUncGOclU8Z3
        4JW9bCQoR4xMrLifwDkA8ZGuchwIpDR5utp2abUXHojVdVN5hiUo4Z7A8hKp2Xih
        rIDk0KSaSC5tfL+8S7EsWPzwM/P8dnw9y9cgDjicOYXgfhhscO/95OAy1l1XIWVt
        l8GAaIuB9Jl+Gf9srrVUv+dR+doo+D8/4ITjiy4BZsUczQCmCcVG9/S6A==
X-ME-Sender: <xms:mOQ3ZKKT3VtDbWkrLFducAhr2TMgxKojXFOGh2zmG412dZUdDVEx5A>
    <xme:mOQ3ZCKESQ1IDwvIz85qVjwdUCcQfchp4JT1WQyWcADmsracGhQS7JsNlT334nxiU
    yNND2RPMODssQCIbQ>
X-ME-Received: <xmr:mOQ3ZKsmvPcrDbJzKHe3uBH7KyuPf8__67HZWGlTaFIK9RTnYSopsWWdcqQGjo2611kAXqzWGMAkgP-VycnjEpbLooeFFzI0NLoWgaWwumsVa4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekkedgfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedunecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:mOQ3ZPaEYbq-sMRv31noShZ3uuxYCrxMvOQHraCj0Jx0VAKxxiED1Q>
    <xmx:mOQ3ZBZlBhyMcYJ9p_OUMJYhMOAKsXkoRTh3IqEbPRwUHCCidCZEAg>
    <xmx:mOQ3ZLBquXJnv7Q4SP5pNrFzULsnr-JneYbAikxQFCOfXlJBrVKA1A>
    <xmx:mOQ3ZAm_lJhc5ONE3PCyDX4q1ZNOzoKXR9eI8t4nblKELWOToXxl5g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Apr 2023 07:16:39 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id ac0cb7ca (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 13 Apr 2023 11:16:16 +0000 (UTC)
Date:   Thu, 13 Apr 2023 13:16:37 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, peff@peff.net, dstolee@microsoft.com
Subject: [PATCH v3 08/10] t/helper: allow chmtime to print verbosely without
 modifying mtime
Message-ID: <18bac902896d6955a359093c4bb072166209ffc4.1681384405.git.ps@pks.im>
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
 <cover.1681384405.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tUfo0LXBsZrL6otS"
Content-Disposition: inline
In-Reply-To: <cover.1681384405.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--tUfo0LXBsZrL6otS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `test-tool chmtime` helper allows us to both read and modify the
modification time of files. But while it is possible to only read the
mtimes of a file via `--get`, it is not possible to read the mtimes
and report them together with their respective file paths via the
`--verbose` flag without also modifying the mtime at the same time.

Fix this so that it is possible to call `test-tool chmtime --verbose
<files>...` without modifying any mtimes.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/helper/test-chmtime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/helper/test-chmtime.c b/t/helper/test-chmtime.c
index dc28890a18..0e5538833a 100644
--- a/t/helper/test-chmtime.c
+++ b/t/helper/test-chmtime.c
@@ -94,7 +94,7 @@ int cmd__chmtime(int argc, const char **argv)
 	if (timespec_arg(argv[i], &set_time, &set_eq)) {
 		++i;
 	} else {
-		if (get =3D=3D 0) {
+		if (get =3D=3D 0 && verbose =3D=3D 0) {
 			fprintf(stderr, "Not a base-10 integer: %s\n", argv[i] + 1);
 			goto usage;
 		}
--=20
2.40.0


--tUfo0LXBsZrL6otS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQ35JQACgkQVbJhu7ck
PpSSlQ/+LqD41gWV3KdImNQapjiaVlg9RiEvWUIz9m+hsMF515ZgMRxCc2I8L2Dm
hGfQj12CUyHrsGHzWddc5TxQgqzxNoQqhBkTDMosMeZxLkE/jnArKCts3l4yCgNI
/eCwYGtpZ9a2gMlrjCiq78irf7NweQCpP46Aln3iTtJAvlujga+2yOfCJJvN4hAl
37ZISiLjk+JUW68PIbmLPyXzN1qTHdqGCoJAKNQPghSZ6nUJ1lUY3aXCZ8eajWkv
4G1GZW+y8aRUQFqHNWi9yefJhiq4JO+uoRmbm9IpLDXJiTAVfbCKyi67qjVU1ecs
se3+Jcmq6O/UFrbHM6h+2GK0HmrpK5N3UKfWiSDx2fdjModfSwQ93vxMXQ2fus1T
FRjE/Pl5SczEs/tcYASrxb06skYrp6IXdfzviGj0pu3BSc1hA4vl4Zo44hqj/g4k
XF61lGsZOHLQCZoegiAiabaEV28b2wyk+snaF9Aj0szh8ccpTjLgHD/fq7o1xorj
i47JpKHrqZ50nBSJmXwI6m2kK/o6SN2wvIb0K4jPcBt6/HF44w9LHeHelDuB7IEv
LF7nbc8wucnA9jJid9ygHJp0+llg2Q8LWZEA0A2CG+LIJlwRTQIr8znPX/z7QjCh
mLwv7l7Gs+QzZ7rZl+vq95lzNWu1hj86BG8TZIRujJxKkGaFRcw=
=suci
-----END PGP SIGNATURE-----

--tUfo0LXBsZrL6otS--
