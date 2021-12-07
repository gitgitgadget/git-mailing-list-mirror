Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23BF7C433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 10:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235463AbhLGLAR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 06:00:17 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:44857 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235466AbhLGLAQ (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 7 Dec 2021 06:00:16 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 3D2F25C0039;
        Tue,  7 Dec 2021 05:56:46 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 07 Dec 2021 05:56:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=z/MQqbskvrmSpKBAcDfjMcY0Lkm
        u//JN6oxgS/8PpMk=; b=q57wPpj4uBmirYPxV7oI/djAClmXQw7Mlo1nhvzsJlj
        tVd5SvD62NCj9noGiB7Kq4yHl4rf9IukQoPqK+8h8nmjdVuegNp3qBndMLEgbzl6
        BDtjO+0X4UVJOzhv4NO3SlPfxv3yDcdnjf24MNkTZfDvYXmv1pS+FdUvWpyV8k4c
        xP4l6R7dpfw9o5zOcqpy0pfdmr2HfuBI3QhCtmqshaoJF+ag1qyefUCCUrksK4gZ
        H+UlhK5P9GVmf1DX7Xy9TDXmWVXd0kj/603DNooaNk1ArXPrgSFNY71GwvGmWEmD
        shvcY96vPvQIECBsyLLco24q+CRhgECPQrtRVdmn7Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=z/MQqb
        skvrmSpKBAcDfjMcY0Lkmu//JN6oxgS/8PpMk=; b=SxFF3MaYZptGnQk28tq+MA
        fhOkh8y/80/7FZpk3OU58xFbfnzCWZEejzraLUIB1Wni9dmIwy9sLbEbIJ94wUS4
        ExK/d8nba9cdUYFyqSkFqrS4MoJBILfAod3ETTYeSKIhdHQS8AwFQuj/KN8a3g+R
        Z8byyLw052rksWuWHSkXbtjyG+GoJt+3qn7mSgpeVHgid8gLmJNi+wt5ZZC0Cw/T
        lj5frw7hkfu09y17yRmc8GwPjQntENMpN9ajuiJRKt0tjeFfLYM0Xdks/2mjDzpK
        QlluDYB2a5cW8zaxwMr5WnRHSpr5rWr7kWSiRlf6sZCNhfs7xT2EM2G3NFt9HRjQ
        ==
X-ME-Sender: <xms:7j2vYQyYigobYGkKLOY9IRISs0DUPoXBSZWuGo_f3kNb7DO6PYU3iQ>
    <xme:7j2vYUSho9xf2H25SGXtdByZUtH01YqjNeVe93XwRqaK767ncV2Vos-v1h67J5AF1
    93MM8pa3IDF-UIoww>
X-ME-Received: <xmr:7j2vYSUan457qKQQ3vVDnlaH7QyvQe_adCe8x6eHi9UZe0s9rw9rJmWYygKboI8q_c5O-hU3jRXjmjnu8Q6NJAU-CjYjWrqBPFnZ6MZzU-PQql_l-J9MmGSD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrjeehgddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:7j2vYejLOiAqPdlHaEXV10qh1eIOo6WSZRxwXAuVAyZgKvY5vtkwzQ>
    <xmx:7j2vYSAGX_IU2WYxO26jYQ8o588vwGcUHEZjgQFsoyvL7xVVexoaeA>
    <xmx:7j2vYfL3XHgAMRFdxe_3a5-WZ0IHdD2iXea7EdxCYaxRZbG3sB80YA>
    <xmx:7j2vYVO3eMIN4qk0XhsOnbvedyAUKo2JQ92Y1lDNYxl9Vyi4AKLyLQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Dec 2021 05:56:45 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 044aa871 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 7 Dec 2021 12:26:23 +0000 (UTC)
Date:   Tue, 7 Dec 2021 11:56:05 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Bryan Turner <bturner@atlassian.com>,
        Waleed Khan <me@waleedkhan.name>
Subject: [PATCH 3/6] refs: allow skipping the reference-transaction hook
Message-ID: <0e42fc07f80903135bae10ac91e139f85ca9db54.1638874287.git.ps@pks.im>
References: <cover.1638874287.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g+ZDtJ8yl5GmoyI6"
Content-Disposition: inline
In-Reply-To: <cover.1638874287.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--g+ZDtJ8yl5GmoyI6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The reference-transaction hook is executing whenever we prepare, commit
or abort a reference transaction. While this is mostly intentional, in
case of the files backend we're leaking the implementation detail that
the store is in fact a composite store with one loose and one packed
backend to the caller. So while we want to execute the hook for all
logical updates, executing it for such implementation details is
unexpected.

Prepare for a fix by adding a new flag which allows to skip execution of
the hook.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c | 3 +++
 refs.h | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/refs.c b/refs.c
index 1c8a0c01f1..462e629d37 100644
--- a/refs.c
+++ b/refs.c
@@ -2076,6 +2076,9 @@ static int run_transaction_hook(struct ref_transactio=
n *transaction,
 	const char *hook;
 	int ret =3D 0, i;
=20
+	if (transaction->flags & REF_TRANSACTION_SKIP_HOOK)
+		return 0;
+
 	hook =3D find_hook("reference-transaction");
 	if (!hook)
 		return ret;
diff --git a/refs.h b/refs.h
index e3d3b7aa14..840fa02613 100644
--- a/refs.h
+++ b/refs.h
@@ -546,6 +546,11 @@ enum action_on_err {
 	UPDATE_REFS_QUIET_ON_ERR
 };
=20
+/*
+ * Skip executing the reference-transaction hook.
+ */
+#define REF_TRANSACTION_SKIP_HOOK (1 << 0)
+
 /*
  * Begin a reference transaction.  The reference transaction must
  * be freed by calling ref_transaction_free().
--=20
2.34.1


--g+ZDtJ8yl5GmoyI6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmGvPcQACgkQVbJhu7ck
PpSdLxAAlpiaMRlDbgQUJrEfxHoHuK8nM/rN0ZQNqQWyuu0Dn/S7UBmjoNMo7G0E
Jnkq/VCkyZrrHjij5R6vQ9Uw0nUJWat9lFpn0gY3He8bWkZGtk10Q2K1sVjoPtnT
okePvv5C7DDAVn6VEodKs+t3oSaVJBV3LpZ1StzzEfRAwoj+xiuquqcqBaL5LniG
A7itKKR/silZDrMaLu/FFEq+Pz42x+PHBBNwC3/qBcvKsOaSZcq7Jtj4dtRZOJX5
Oy57C+1sq65q/z3ZEsvfk+Sxe9haLFoyLpE6QkZuWTly63JJDEVoLq3/8ReR/a+D
SWNMUd3FWxt783W91IujNj4t8M1eapSstTdNLUBDPnANGlibWvXwVx2kLMNbnUfy
XXVoQ5rb3NPO4KqUrdUfFvtDUpfn5AAIMEuQuZOtd6inkg8r6gDNM5CumY1KdtFj
SE6MUjlDMPniEywQ8qKNlHZuFK8gxHx8MghIOPdzBWFrxDa3mZXehfaboelg0VCl
2/GQnGwHxlAjFBH8/zTo7Fn+Pv728FZmSHCU8AOlKZcW286gBk8Ul/SmSjFJbiI/
4rHvYaAh0qJCsXkM8hME6Byq0LwwuYGEtOsCRqTYKyVWC52B9l/mUUCX/+jTjpDO
6JiQfTtd7F3z+9NtelffqXepIiUdTXB8FM2hGWJBuDbJaItb06E=
=vSlw
-----END PGP SIGNATURE-----

--g+ZDtJ8yl5GmoyI6--
