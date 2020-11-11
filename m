Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF8DC4742C
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 07:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5817020786
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 07:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jxtu/Fm3";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cLxm3MQ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgKKHFa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 02:05:30 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:58017 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725882AbgKKHF3 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 11 Nov 2020 02:05:29 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id A3B765C045A;
        Wed, 11 Nov 2020 02:05:28 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 11 Nov 2020 02:05:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=djaGuxkgg+HjAAejZhXsDZHi+6k
        xVQnPuRkraZYebvU=; b=jxtu/Fm3vaWDY+//Er49Yun/3NfjjwZrMkNXrlozFdQ
        4ueu6lFNFWIHeT5FqZY4mg/pqxuEHB5VOwRJuaDGIWSQ2IvYFAJ0pOPTZbpH9Xhd
        QTK732wKKAtb4QJKP29KvT8r8IlaeqIfd3w9ztiU0TryhFfL0zXQHRQs3evUVSF8
        ouueJbjUX7SrhAIe+9RGo7LkIw6nMQxNAw5UUbNcvu95j6e23Jzgr4H7Db0k6DEf
        ZjaMHPNviKesw48pvvO8PYXNEAa5wqp9dzeFZ6MMhNF87EgVL+XpE6Ot8IULpBuT
        sTWpgmlBsAJ7lRtoomUjc562CZTiXaELaalbVOog+/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=djaGux
        kgg+HjAAejZhXsDZHi+6kxVQnPuRkraZYebvU=; b=cLxm3MQ/UgtsFdbIolfGV7
        zTuMgYR3bEtmLd35bKrIFzVcSzkx3TCitEDNTpn/1svcScXv4500zz96kvlTlZBw
        NwSq0vG+TXOgIZenz5h/DVCE2/6kOz4vpFvhcAELc/aqTzagLxQWqd4XaUz8/B/u
        ZOl69jsz8BbQiF56TI5vNVSlHKNNas3gi1YV03UAzvFMeJaLXcvy4ZdP4o/WhA40
        30BtRkuhlrEKJENqpQJcz3WSWCMJ+rg149gEICOhmPEqamCVSW/6ahDCWZBoQtx5
        otLHl+dI0ngYwPhFD8+q0ugr1zemL8D6uJYp5ySPpC5tmZrcwdxKMHiSbtI8+l3A
        ==
X-ME-Sender: <xms:OI2rX-firwpFU0cJdfIPeqQPD4Ac3qLX2aA9stiuzP6F69nXSBop3g>
    <xme:OI2rX4NCqVmspGUOpr0jZ1spTEGTKcV5cf4EzdukatkW7krwKmwGOF6TAkyxArHl6
    6uWH_cTbIVPr4H5CA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudduledgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecukfhppeekledrudegrdeivddrkeeknecuvehl
    uhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himh
X-ME-Proxy: <xmx:OI2rX_hb9yDGeRZRcF0AQCw2KtinpUlbXrO2ksi9PRXpEccrXpUcog>
    <xmx:OI2rX79kdmP6CQBSUuuB9eI-9OJFlM5gBCAg5SaZYHX4znyuIkBKKg>
    <xmx:OI2rX6tDRHZkhTMHpWRp-3uiEYDConUdTWvjVEwC9zU9cUmD9RKzPQ>
    <xmx:OI2rXw0AJ12SW_fSQgzdz6WAhYY3wGE43b4FBEMEgDXGJfaES4bDRw>
Received: from vm-mail.pks.im (dynamic-089-014-062-088.89.14.pool.telefonica.de [89.14.62.88])
        by mail.messagingengine.com (Postfix) with ESMTPA id E89D93280060;
        Wed, 11 Nov 2020 02:05:27 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 7f4edda6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 11 Nov 2020 06:58:47 +0000 (UTC)
Date:   Wed, 11 Nov 2020 07:58:47 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com
Subject: [PATCH v3 3/4] p1400: use `git-update-ref --stdin` to test multiple
 transactions
Message-ID: <e393b5350f5ed0c7353b6301755a35d7c3b1b83c.1605077740.git.ps@pks.im>
References: <cover.1604501265.git.ps@pks.im>
 <cover.1605077740.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cljao4jDg3a+zOqm"
Content-Disposition: inline
In-Reply-To: <cover.1605077740.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--cljao4jDg3a+zOqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In commit 0a0fbbe3ff (refs: remove lookup cache for
reference-transaction hook, 2020-08-25), a new benchmark was added to
p1400 which has the intention to exercise creation of multiple
transactions in a single process. As git-update-ref wasn't yet able to
create multiple transactions with a single run we instead used git-push.
As its non-atomic version creates a transaction per reference update,
this was the best approximation we could make at that point in time.

Now that `git-update-ref --stdin` supports creation of multiple
transactions, let's convert the benchmark to use that instead. It has
less overhead and it's also a lot clearer what the actual intention is.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/perf/p1400-update-ref.sh | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/t/perf/p1400-update-ref.sh b/t/perf/p1400-update-ref.sh
index ce5ac3ed85..dda8a74866 100755
--- a/t/perf/p1400-update-ref.sh
+++ b/t/perf/p1400-update-ref.sh
@@ -7,13 +7,14 @@ test_description=3D"Tests performance of update-ref"
 test_perf_fresh_repo
=20
 test_expect_success "setup" '
-	git init --bare target-repo.git &&
 	test_commit PRE &&
 	test_commit POST &&
-	printf "create refs/heads/%d PRE\n" $(test_seq 1000) >create &&
-	printf "update refs/heads/%d POST PRE\n" $(test_seq 1000) >update &&
-	printf "delete refs/heads/%d POST\n" $(test_seq 1000) >delete &&
-	git update-ref --stdin <create
+	for i in $(test_seq 5000)
+	do
+		printf "start\ncreate refs/heads/%d PRE\ncommit\n" $i &&
+		printf "start\nupdate refs/heads/%d POST PRE\ncommit\n" $i &&
+		printf "start\ndelete refs/heads/%d POST\ncommit\n" $i
+	done >instructions
 '
=20
 test_perf "update-ref" '
@@ -26,14 +27,7 @@ test_perf "update-ref" '
 '
=20
 test_perf "update-ref --stdin" '
-	git update-ref --stdin <update &&
-	git update-ref --stdin <delete &&
-	git update-ref --stdin <create
-'
-
-test_perf "nonatomic push" '
-	git push ./target-repo.git $(test_seq 1000) &&
-	git push --delete ./target-repo.git $(test_seq 1000)
+	git update-ref --stdin <instructions >/dev/null
 '
=20
 test_done
--=20
2.29.2


--cljao4jDg3a+zOqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl+ri6cACgkQVbJhu7ck
PpS9yRAAlLQHhsyz0JKPZ91CBeLbUcO8O346HorSjF8mImm4fTI02oPeinM24QhN
ToWI7Pf88hst2xLu4dmKM5o+tKv6YYOzOWL1UP9jUMHu3LfJbKC1c12qjdNuIHjQ
i4cffyMylwb/5Svkpydoy/UiH7XEvWQeU5JgQ9nCvToXdnBdJRywdjbmk9U/VA4P
hJ4LZakWjbUYIGYXvf/cognOMyLIbDIpY7g/Re+tlE1LSsFm4Gyn7/eBbmtTf2EA
KDiVFQYhF56T4MgAKnBOfAcDColGS9r+l8BlcSI4or0umHHQn6bEeASOsKqgMF55
myYJPz35yHzhy26pF1a3VftW2ZpbTf/WmyHqZSlrFq0b27GESpso6qxS4ykeeXB3
Nh1ZrdQSO/JdvR8eucjIyTSgVIXYp54imNiagvdYCoawme4rP57/3XydiaAmdRVV
vYw8bB0K2U28sMbJuyF2EtrMuzAmdXnUfqbBaqTrmafKsIIfnq/jWkPDjpDWaoeP
NJke+bI/WJ5v//c+Tkiip2QcXTBjKYkkrvt2pQ+xyzN/YUmggmMloljdNbcoVuO7
l1M62VBf9YlzDuYyOkC0T4naf/3O75BASYiQvHKR8C8leOvmftxreomL3meHdgvZ
wb1j+vYkRICiGxwJVtigM+hZk7YjfBBFie3Up30MYIQpkijgHw4=
=8O5c
-----END PGP SIGNATURE-----

--cljao4jDg3a+zOqm--
