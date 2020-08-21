Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566A4C433DF
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 08:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07D4921741
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 08:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MAcbNOgk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k/UqB/xi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgHUI3c (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 04:29:32 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:35407 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726879AbgHUI31 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 21 Aug 2020 04:29:27 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 12FAA762;
        Fri, 21 Aug 2020 04:29:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 21 Aug 2020 04:29:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:mime-version:content-type; s=fm1;
         bh=IbIhG2N70OgVDcdF1+Q4ogsD6s+5Uq4hQWaBiILRvlg=; b=MAcbNOgkdnjk
        s3cxVnqa9eSCbF8VIXw6lXX+TnBFcdqOkEWHh/NMQ3lQ55Hrpg7QTh7l8Q5IMNsF
        3e7rC4wvy/OttJHg48JG1MZMscoNR4odt894Q+YboElcdqOes+ra+Dl4qnjzKURe
        LBCbQTU+7zkFq9EFh1DIAjLVp6hGla+cqUVw64kVh6BHnrzSwFNawCOCMzdqUScS
        KxFkp2iIhpUn9OIBY+mHjL9lnaslZy0PcmwNSwTS/U4WIYJ0klWOA0dTizWGmUv6
        TSQCRt8cos5NUBEZLJyOWPa4OdOLRKOPy41+OZbI3aNk+pOPR5f984i+bnN3Cw3z
        fr85hQ3uUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=IbIhG2N70OgVDcdF1+Q4ogsD6s+5U
        q4hQWaBiILRvlg=; b=k/UqB/xiTmBu99QWtzMbOV+MJeDOgNmgScTVvnK/rTEEJ
        pBgHAjVYLf10PpmcTzi5i98gVWpKkK0rKki/TcgfwHcjOrUgEUsY1qDZPZwOKOg6
        kqimf/wmERjVdN732utWR+YiQ2kkLB8zN+336TavF3kKD00HPVDxjbO3vDVjB+rV
        EpZ1D4oycu1eb5DwkLQmFZNC8/RNhqxSQjbQM+WL7UxU1Gi3N1xqq1GueAyg+0b4
        sLrB5vzWn6cCmdFgOSizmRf0bGDAqWl2iPTVzn/1H5OJ4HpXYQUOYdnwSKQIsdnF
        Z+epne4K4IMCCJvSJdWM/0rwue4g63HdHd4P5E1Fg==
X-ME-Sender: <xms:5IU_X54im3PhjzFRcsXUHY7EFnX95J5Y25r-kjG5ZEdTfCZyxX7pJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudduvdcutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfggtggusehgtderredttddvne
    cuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhm
    qeenucggtffrrghtthgvrhhnpeejieefvdeuleffgfejudffvdeghfeigfejgfdvvdefud
    evffefveffhffgkeeiffenucfkphepjeejrdduuddrgeejrdduuddtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:5IU_X27Nxc8-yIUuC5E1CB2NbqSaeSw6J3AjSyGrQgWgTutBEIqicg>
    <xmx:5IU_XwekkerJ9AIx0Q9asL9MWbS0l4b0XKBiBPeKarPBqSewd400nA>
    <xmx:5IU_XyKNuEYmIzYv7YQ_6uIa2nqhbtqTIk9fY9FMWDjoG77VqsLCZA>
    <xmx:5IU_X_ya9ud2Uz16zul2LquJpxd6m4bIsfVk3A4hjyx3Ds-m4UY1Hg>
Received: from vm-mail.pks.im (x4d0b2f6e.dyn.telefonica.de [77.11.47.110])
        by mail.messagingengine.com (Postfix) with ESMTPA id A7254328005A;
        Fri, 21 Aug 2020 04:29:23 -0400 (EDT)
Received: from localhost (tanuki [10.192.0.23])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id e86386e1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 21 Aug 2020 08:29:18 +0000 (UTC)
Date:   Fri, 21 Aug 2020 10:29:18 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH] refs: remove lookup cache for reference-transaction hook
Message-ID: <0db8ad8cdb69afb9d6453bf60a808e8b82382a4e.1597998473.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When adding the reference-transaction hook, there were concerns about
the performance impact it may have on setups which do not make use of
the new hook at all. After all, it gets executed every time a reftx is
prepared, committed or aborted, which linearly scales with the number of
reference-transactions created per session. And as there are code paths
like `git push` which create a new transaction for each reference to be
updated, this may translate to calling `find_hook()` quite a lot.

To address this concern, a cache was added with the intention to not
repeatedly do negative hook lookups. Turns out this cache caused a
regression, which was fixed via e5256c82e5 (refs: fix interleaving hook
calls with reference-transaction hook, 2020-08-07). In the process of
discussing the fix, we realized that the cache doesn't really help even
in the negative-lookup case. While performance tests added to benchmark
this did show a slight improvement in the 1% range, this really doesn't
warrent having a cache. Furthermore, it's quite flaky, too. E.g. running
it twice in succession produces the following results:

Test                         master            pks-reftx-hook-remove-cache
--------------------------------------------------------------------------
1400.2: update-ref           2.79(2.16+0.74)   2.73(2.12+0.71) -2.2%
1400.3: update-ref --stdin   0.22(0.08+0.14)   0.21(0.08+0.12) -4.5%

Test                         master            pks-reftx-hook-remove-cache
--------------------------------------------------------------------------
1400.2: update-ref           2.70(2.09+0.72)   2.74(2.13+0.71) +1.5%
1400.3: update-ref --stdin   0.21(0.10+0.10)   0.21(0.08+0.13) +0.0%

One case notably absent from those benchmarks is a single executable
searching for the hook hundreds of times, which is exactly the case for
which the negative cache was added. p1400.2 will spawn a new update-ref
for each transaction and p1400.3 only has a single reference-transaction
for all reference updates. So this commit adds a third benchmark, which
performs an non-atomic push of a thousand references. This will create a
new reference transaction per reference. But even for this case, the
negative cache doesn't consistently improve performance:

Test                         master            pks-reftx-hook-remove-cache
--------------------------------------------------------------------------
1400.4: nonatomic push       6.63(6.50+0.13)   6.81(6.67+0.14) +2.7%
1400.4: nonatomic push       6.35(6.21+0.14)   6.39(6.23+0.16) +0.6%
1400.4: nonatomic push       6.43(6.31+0.13)   6.42(6.28+0.15) -0.2%

So let's just remove the cache altogether to simplify the code.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c                     | 11 ++---------
 t/perf/p1400-update-ref.sh |  9 ++++++++-
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index cf91711968..cb9bfc5c5c 100644
--- a/refs.c
+++ b/refs.c
@@ -1924,24 +1924,17 @@ int ref_update_reject_duplicates(struct string_list=
 *refnames,
 	return 0;
 }
=20
-static const char hook_not_found;
-static const char *hook;
-
 static int run_transaction_hook(struct ref_transaction *transaction,
 				const char *state)
 {
 	struct child_process proc =3D CHILD_PROCESS_INIT;
 	struct strbuf buf =3D STRBUF_INIT;
+	const char *hook;
 	int ret =3D 0, i;
=20
-	if (hook =3D=3D &hook_not_found)
-		return ret;
+	hook =3D find_hook("reference-transaction");
 	if (!hook)
-		hook =3D xstrdup_or_null(find_hook("reference-transaction"));
-	if (!hook) {
-		hook =3D &hook_not_found;
 		return ret;
-	}
=20
 	strvec_pushl(&proc.args, hook, state, NULL);
 	proc.in =3D -1;
diff --git a/t/perf/p1400-update-ref.sh b/t/perf/p1400-update-ref.sh
index d275a81248..5d6da3cb70 100755
--- a/t/perf/p1400-update-ref.sh
+++ b/t/perf/p1400-update-ref.sh
@@ -7,11 +7,13 @@ test_description=3D"Tests performance of update-ref"
 test_perf_fresh_repo
=20
 test_expect_success "setup" '
+	git init --bare target-repo.git &&
 	test_commit PRE &&
 	test_commit POST &&
 	printf "create refs/heads/%d PRE\n" $(test_seq 1000) >create &&
 	printf "update refs/heads/%d POST PRE\n" $(test_seq 1000) >update &&
-	printf "delete refs/heads/%d POST\n" $(test_seq 1000) >delete
+	printf "delete refs/heads/%d POST\n" $(test_seq 1000) >delete &&
+	printf "create refs/heads/branch-%d PRE\n" $(test_seq 1000) | git update-=
ref --stdin
 '
=20
 test_perf "update-ref" '
@@ -29,4 +31,9 @@ test_perf "update-ref --stdin" '
 	git update-ref --stdin <delete
 '
=20
+test_perf "nonatomic push" '
+	git push ./target-repo.git branch-{1..1000} &&
+	git push --delete ./target-repo.git branch-{1..1000}
+'
+
 test_done
--=20
2.28.0


--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl8/hd4ACgkQVbJhu7ck
PpRiDw//UTAksIgjV7XQ2kTNuwsmavcTwsstapGWx8Pg9elHm0u+6HTOg6wynru3
JNqVhr8CoxiTtP2YDA7Fwcw/nOnUjkbw+Q5jl9kxYyvb80jXpvLIWreddWSFJLLK
u2jV+NXEQRa42fnlPLUOmMkWDvUxiXFaxSRBmMzitQKkDRSgib3VkG5kwwYM6hAL
W0X5dU70fU2KJv0pBUPQr0GR64aK521cXra50Z94CcKJAvKzScvUV6DavT0WXGdE
rF3AjfSbDEbX06MhTcysSnUksWzbTHn38y3gsdfDnlGaUzBFJ/ybH/SsgtWcNXSJ
YS1PPdgd6/81uvlpJP7Ts4Ozm+fL/J5boyff8y+zBc6pVbhG3NBBU9QwKrEKHzBU
kod518rsf8JIdGABvwcsBESAtjn+kOzkzB4tNTnbj+f6bBTwYTDAFe3aZjSSVSSz
4ESwyLjuBv1Zp23iRA5BpO3ghs1v/PiXVCxE4msMAeuSGmgGXUKBMALcJbXJ/Asx
taLGG+RGmXqljNyDonvG8Y3Hb41BDZMrRndDqpW8jxdOqTmk48CH+UdjNAca0g8e
kei3+2I2cyazA34mzB42CYabslGa0S9ONzz/JdKds0RnZzrSplRr8MJvfhMUKRQw
FDGujkn7Drpfk3HVropDMIydONWmedpPFVDafs8Q1MfLj+5h5x4=
=p7Ao
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
