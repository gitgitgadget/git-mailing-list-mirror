Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEEDC001E0
	for <git@archiver.kernel.org>; Wed, 16 Aug 2023 06:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242026AbjHPGHk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Aug 2023 02:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235328AbjHPGHH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2023 02:07:07 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9D81FDC
        for <git@vger.kernel.org>; Tue, 15 Aug 2023 23:07:06 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id A3F77320090D;
        Wed, 16 Aug 2023 02:07:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 16 Aug 2023 02:07:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1692166025; x=1692252425; bh=fH
        bbvjj1zGPIiZYH+fN+2m2G6hxtvGIGwYxTP0tfWVE=; b=Wcwkt6WrJDPG6O29p1
        MqtrKouteFxRgGcx61TEQ+xZ85XQpikWto1jXpSHiZrk1S0qOUZ3PEgeWwv1zvcj
        RPrbaNW5ypMFoNluoh3nWY/oqA0cTC5ue1WuhatUN+PP6gGWTTDB2hTgCZtZQ6Tx
        Meqyjv6nY8JjLc3tOHqpylV4/8OzfTt7heYr0sT69BceegZVbAiS0j/OO8XxDUcr
        bnay4TrIlrEfkLSSsHV2/wZMZvJfjXFg99fw9Sbk1e1KIyNZ318O/HTvFKSFxpHW
        oWCbMmkFZflNqhwjIz3Y5E0RQcFDGVY7gImmRIQoV05LR8CjJesaf87LkiWPGRQz
        Z3oA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1692166025; x=1692252425; bh=fHbbvjj1zGPIi
        ZYH+fN+2m2G6hxtvGIGwYxTP0tfWVE=; b=tjfZhx5v2BoL39yKWE4s0eRjz38bn
        PnTUpC+4SEZUYsPhTm6ZhcZ2NLEoAqVfdkwWkAhY8yRbJaRKcG8xoye1VvvovJhi
        C9RhlLzumzWuFlFDZkcYcUe9RloElc3gzDRVVhcSflGmcjo7XiaMUjCFNbAV5sWR
        5lgEigA0GZ/rfsWwQgjiAqz6Xuu4sM008wAUhgrpK6Zsn6DsFs0rWSgGHfzOyyJe
        /MGYcXgJflA3BrDonpkVelyDoiwCwYP/8+2LGePnB/o3unshPnWZccLFKYdrTlcz
        JyPWRL5ONs8G6lkIKIKRwF8RaqW+NCFI8at/CFOVzAvVz8wnampzKxmcA==
X-ME-Sender: <xms:iWfcZJW72AUmWlAgQ0MyOwa00vrUKsxVvHmGoJKlyfiD401TSFuBfg>
    <xme:iWfcZJnYIaFwosFkgV2dsUv9GP6WtrhlLlh6tXP08qB2vzn0p3SJqcPg_Kuy10Xj7
    Qchv9UiR5zZCbx14g>
X-ME-Received: <xmr:iWfcZFYHb1bNFHAufVWyvMZtLkAZsA4tugGZc14XuAfrdaYrB7jX-dthosft51XHGr5mcwCuxcazfm7hgySKj7piFMk4GQYNoy2JcJZmTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddtkedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:iWfcZMXPCCrnh7AqDDLRiyy9VJMfUBKZg4N3aIeGzH_FTAw44SEzig>
    <xmx:iWfcZDk5S2ynRHHz6C2_p-DEuyCZ9qbAJ2qyqfHL9pRWVP3HJiGkRw>
    <xmx:iWfcZJcv42CPASxmxVgHLVbO1PS6HBFsOCIT4T1ECdXvSHaTEBCvJw>
    <xmx:iWfcZLsu_mH7Q_WYqdp-JOPhNBALxYqNxnfAT0pIqs53NRU1PAOtBw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Aug 2023 02:07:04 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 86338906 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 16 Aug 2023 06:04:47 +0000 (UTC)
Date:   Wed, 16 Aug 2023 08:06:59 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>, gitster@pobox.com
Subject: [PATCH] upload-pack: fix exit code when denying fetch of unreachable
 object ID
Message-ID: <fe028981d353158e9840eb035194ca15e6a2c15e.1692165840.git.ps@pks.im>
References: <pull.1572.git.1691678450757.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="c5szo6olyslfvgf4"
Content-Disposition: inline
In-Reply-To: <pull.1572.git.1691678450757.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--c5szo6olyslfvgf4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In 7ba7c52d76 (upload-pack: fix race condition in error messages,
2023-08-10), we have fixed a race in t5516-fetch-push.sh where sometimes
error messages got intermingled. This was done by splitting up the call
to `die()` such that we print the error message before writing to the
remote side, followed by a call to `exit(1)` afterwards.

This causes a subtle regression though as `die()` causes us to exit with
exit code 128, whereas we now call `exit(1)`. It's not really clear
whether we want to guarantee any specific error code in this case, and
neither do we document anything like that. But on the other hand, it
seems rather clear that this is an unintended side effect of the change
given that this change in behaviour was not mentioned at all.

Fix this regression by exiting with 128 again and tighten one of our
tests to catch such unintended side effects.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---

We have found this issue in our CI pipeline in Gitaly, which explicitly
checks for the error code. It is very much debatable whether we should
even be doing that in the first place given that error codes are not
even explicitly documented here. But I think this is worth fixing anyway
given that it seems like an unintended side effect to me and might be
biting others, as well.

If you folks agree with my reasoning, then I think we should pick this
up before Git v2.42.0 is released.

Patrick

 t/t5703-upload-pack-ref-in-want.sh | 2 +-
 upload-pack.c                      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-i=
n-want.sh
index df74f80061..fe6e056700 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -483,7 +483,7 @@ test_expect_success 'server is initially ahead - no ref=
 in want' '
 	rm -rf local &&
 	cp -r "$LOCAL_PRISTINE" local &&
 	inconsistency main $(test_oid numeric) &&
-	test_must_fail git -C local fetch 2>err &&
+	test_expect_code 128 git -C local fetch 2>err &&
 	test_i18ngrep "fatal: remote error: upload-pack: not our ref" err
 '
=20
diff --git a/upload-pack.c b/upload-pack.c
index ece111c629..15f3318d6d 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -782,7 +782,7 @@ static void check_non_tip(struct upload_pack_data *data)
 			packet_writer_error(&data->writer,
 					    "upload-pack: not our ref %s",
 					    oid_to_hex(&o->oid));
-			exit(1);
+			exit(128);
 		}
 	}
 }
--=20
2.41.0


--c5szo6olyslfvgf4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmTcZ30ACgkQVbJhu7ck
PpRWgg//f1zKGp9z7GT98mnia+4Q46bladVAgFOTq2y+pXEQ35LWaCSRmEYPiVQw
Qn5W67e1OZsrqxQeT9Ddesfm1ADTr6+75hWNyhwMyfBRPhMdOSU/6H/ZcpFDAvPI
5XOANoaUwZd1aZpCo6VJwkwlMIAr9GpcwE2Mb0/fZZuO8+tIhl3gVNQuCHTk16tj
rTJ4bb5ictWjLIptpIVg8uYa4oWELYI1ku+d7bKH42mfxg4rgHViGY69kxApmdIu
Ht5m+TaL/FnofWyLSL24V2tgViZYymlG1bT0ODDjIizU22E2HBQz9VAZM5KkKygP
TJtzqiwVkriTH1lGB+DpUhWw7eJNGcwoMXhX2WNzssETl2gy8g0io5VtJfAMXJAS
xqn/7Z2BmIglwwvUJJPwelL6qlGjFkYCfSPv8LW0Ad8dHvWjrsKsqLFInrXgUjm1
MGtswMVLTALDJGKKVzmihkLfr8xeCIeS79bKG2YDljSwN8LLAO2K1+4VmgWoH5jt
z+zliQtK0kSXYkLJdGK1FFCpQfBsXDIEOgh8ouBAyOdACGKVLXSrsHHtK8SHmZ9N
gXEqX89NDYGxyAS6GBo+iOZwWj3AdQLpF/igb72GfKNq24cbljjsZymiDCRbVrTK
nhNOhFWuXsaES77f4w+Y/CgBmyZ7JJGh+o92weFZqY4LfC9rkkw=
=9J7w
-----END PGP SIGNATURE-----

--c5szo6olyslfvgf4--
