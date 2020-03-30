Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D74C43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 13:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F18292082F
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 13:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ri9croex";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ugFGtnLX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbgC3NqO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 09:46:14 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:38513 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728065AbgC3NqO (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 30 Mar 2020 09:46:14 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id BE4A756E;
        Mon, 30 Mar 2020 09:46:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 30 Mar 2020 09:46:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=8M+IWyqMnQpI+Y2/7DcyTaNJhBg
        6gmwOqb1prWZCwns=; b=ri9croex3IdYVbV2t/rJZHxtBBIeH7V9FTMyNiqXU2t
        dFTI63EihZAoGMUZOzuGOV0SHPCC5hQhUV++x3YZsAT5Y+H5m7o+mtYZ6pcJFCh7
        E2otpyIIO19VXz2kKr2+v4wI+kgv9rRfG1TICl2UPDhkPRxRcsv36TSHfGJ4l2n2
        6fxD6WvR5hIflceuRbMSL30zI6CAfiYG3qD5OkpSYSlaAiFRAr6/Hb9C0yh2YZMT
        T6wMO+HyHdC3DTu6mNDG+ZTHU2B9jXX+x665A4cTwwYRmAKY2bhAN3ecMRMY2ZHz
        9I+sy15/AEo5hV/mePPHD2y1s2tG2HURE/mPDcygouA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=8M+IWy
        qMnQpI+Y2/7DcyTaNJhBg6gmwOqb1prWZCwns=; b=ugFGtnLX6QCIw1NMFkpN4Z
        qtH+WpXAyg70bROGz68cR4u7D7YCkcSbfmUXqcwUEnDtbD2Xuy0eDDU8Jm/aksBj
        UFYh1RQQWqGlVBzkF7qZHtXLVEy8dOHev0yjUtfx3ezGa1SCR7gWAU6VqedS2Pd/
        C+zUhQJ8aHFMHf5NyrMx8nxvZ6J3nSdlNXOJIdx3OaDIBcGYc1bPHez1k1DdCP7i
        dUf4KR4A/z2QMWgaymRLUTQVHxn1ZT6f5zj/lOmkMd6iEolNfnPr52OAUu/qoqH5
        6RMU7TKakjOZZRuP5Mh/ZiMRjcPn4NuZyvb6+eAqdJs8bDl51swBsSv5B2LroO5A
        ==
X-ME-Sender: <xms:JPiBXriChLKU4xXO05N6mvI80nXJ12-Uu73kvOQ2E3mkPI7cmPs3gA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudeihedgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucfkphepjeekrdehge
    drvddvtddruddtvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:JPiBXv-ucyUJWvmMfel20YzjRucurMA3qm5pzEP3sBSy7JOD-uegZw>
    <xmx:JPiBXiSmNGyAyjIZbzk-B5CJ9rYIX_U07317JrRCLdYsoQk-HaRiVw>
    <xmx:JPiBXutywtUGaVVhCBKylcGWOaKyD_AHBgIaYmFtDsNgqUo_sDEvNg>
    <xmx:JfiBXjQP-lEgfs5CSmveEePLgzx9yTt8F9CyUQadNRk-MBMVOTC4KQ>
Received: from vm-mail.pks.im (x4e36dc66.dyn.telefonica.de [78.54.220.102])
        by mail.messagingengine.com (Postfix) with ESMTPA id 000C4328005E;
        Mon, 30 Mar 2020 09:46:11 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 8d61d332 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 30 Mar 2020 13:46:10 +0000 (UTC)
Date:   Mon, 30 Mar 2020 15:46:13 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/9] refs: fix segfault when aborting empty transaction
Message-ID: <7a297db4daaee84dc90ddeaa8f77b68a39231ef1.1585575749.git.ps@pks.im>
References: <cover.1585129842.git.ps@pks.im>
 <cover.1585575749.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
In-Reply-To: <cover.1585575749.git.ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When cleaning up a transaction that has no updates queued, then the
transaction's backend data will not have been allocated. We correctly
handle this for the packed backend, where the cleanup function checks
whether the backend data has been allocated at all -- if not, then there
is nothing to clean up. For the files backend we do not check this and
as a result will hit a segfault due to dereferencing a `NULL` pointer
when cleaning up such a transaction.

Fix the issue by checking whether `backend_data` is set in the files
backend, too.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/files-backend.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 561c33ac8a..6516c7bc8c 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2565,17 +2565,19 @@ static void files_transaction_cleanup(struct files_=
ref_store *refs,
 		}
 	}
=20
-	if (backend_data->packed_transaction &&
-	    ref_transaction_abort(backend_data->packed_transaction, &err)) {
-		error("error aborting transaction: %s", err.buf);
-		strbuf_release(&err);
+	if (backend_data) {
+		if (backend_data->packed_transaction &&
+		    ref_transaction_abort(backend_data->packed_transaction, &err)) {
+			error("error aborting transaction: %s", err.buf);
+			strbuf_release(&err);
+		}
+
+		if (backend_data->packed_refs_locked)
+			packed_refs_unlock(refs->packed_ref_store);
+
+		free(backend_data);
 	}
=20
-	if (backend_data->packed_refs_locked)
-		packed_refs_unlock(refs->packed_ref_store);
-
-	free(backend_data);
-
 	transaction->state =3D REF_TRANSACTION_CLOSED;
 }
=20
--=20
2.26.0


--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl6B+CMACgkQVbJhu7ck
PpSciA//VfHVoWYK5Y4I/o84lfRxfYCtsUz7ee8UsqtmFLEeDo8yn45e9q9R+uxN
FEicoaptAtaeWHhgpQjGTDwVSWyzdOpNLwMvTmytKZRq9QA7unXIzEFbi6reTC5I
c8oaKhEBfntFNoeVZeVTBn+jCgAHHZYmiikL4oecoiNxDfQroGD/ALpG0Ro5eH73
jRCMKhloWfBHROAXNq1HEtvtvBQeOPpbiJC5D/hjiltK742jC+82w/jbsEEzSRsY
zg4bA3bC6maAWAMUl/I62yRHljrIpGo7u47O0MfKCFzGZjqe7PNsYPp+GhBP3z1h
DuDlH2rOwXAtLUrgKo+08CI3aX1iDlbHnYpfzaTEnmS0WUFnekhXDIb1JfsYVce2
a5j6tOLlc4/VxWb6n7wvSdPJ95ziDDJ9wFvIaAp3eS6k6jWbLUAENpLVH5RKen/y
Ny5URFpln1xkmjLNzJGRYZHcOo3ZsqLSyH+0FR+1AtIdPmE4rmfO1WsTnEelawaP
yeY5iakHoqHdkKSxudvEz2cVsdzS1yaaEpdoIYWk/XnfPygFAmCQo75qIoJCuVB7
fuopHeDbjQX5H1phsOm9vtnv210Fyf/Fu7yXtoK/mEv2VrR2XEQ/fGapkTiP3sZj
yoth28+AxvtluTnDsgyL3+48r8A9T3DN6BvFKY1pYYz33gqfVBY=
=Iq5e
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
