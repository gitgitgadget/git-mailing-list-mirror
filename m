Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51669C433F5
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 06:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbiAMGLi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 01:11:38 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:54413 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231424AbiAMGLh (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 Jan 2022 01:11:37 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 0A7DB3200E79;
        Thu, 13 Jan 2022 01:11:36 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 13 Jan 2022 01:11:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=rqD2Papo/j3GLQ8UZyYjKX5zUMm
        aboRD6mjg2rEqa5o=; b=N92EzE7L6ROuEfR1ydvhJ5Se3k7YfRHDPneFKFtVsX/
        WNbargJ8KKM1lemv0B3KCaFso8fnnm4QIbERUYyb9Gi+Nqviw7cJl9NDyS3WB3Pd
        h/EDc/R2tTN2ze9nniczlMZBZF49GfwLpdgUq+5jnM05GW7d3s6aLQN4ZGoORE4m
        /nP/1PwSIe85jR4dAS7txwSch44//c7wAf8KydTg0VldFviKNJedq0Qf1qSaaFwV
        WVw6k3Ov2naGPnY6+BB6bqzWSpdi75D+dTHoAXtFYCmo57xul5q3WslBuov8s6+n
        4pSXlxd8wySLtHIz8Y+CfSnrkDMgQls5gKYI8gtW1fQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=rqD2Pa
        po/j3GLQ8UZyYjKX5zUMmaboRD6mjg2rEqa5o=; b=R8UnGnsPP7FuS6AbKR7Vyj
        p6MnITF7IFZ4/GK3+54AAmCod7fXF52Ens2rbsZAjTCfW8r19FgwJ5aSzQvzJjUU
        zY71zjo0j6CXrBevNiTF9OpzcMwnXieJb0TSf/4o44UnrJ6zH+MSIN4fRcY6HQ3q
        gGdbLJjAmj3SYgNr85+4q3aCObHdAMrQc6ri+JFXIai/BPXi1YwYBHuLuwdZ7LZA
        v/L0N38G9FWTdXRDRBLHzL+8/QJHpBDT918PYfb5xmx5iCuASdZkSpU0/DT66nYf
        3OXTrnGkX0Tshk7VnvLVXB2HtvCXafaCo5HkuC46u6YulKDQcJdfERBW3/VotGcg
        ==
X-ME-Sender: <xms:mMLfYd2Xr2src70knU-NnwK-qJnOsmMY-NZtq-6He0Ty-HB3yYdOaw>
    <xme:mMLfYUFT5omX_Fj6KvDMZmPMRUKjUOJcZgifaf_986FtnlqcGButFZajo-1USj0jg
    bP8fS_Ow2zrVxBeBA>
X-ME-Received: <xmr:mMLfYd4wKrv-Y734Ybom0621J4h6zou2IWWPVhTj0wYD22_XHSphvmuyeEVp-ws1Lh4HvSCZDpMXXI6kbKPlTDzsr75y_WoT9MCiYdrHRQs2MIzAe_SCVQraPw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrtddvgdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:mMLfYa2uaW71y02S4HdE0gHUl1fR8kFlZHo00R-UYpzONrcRwHTOnw>
    <xmx:mMLfYQGSrj9tPibuaxwUj2BtvWMy41xiwz0bwYTvi18XM6SWNfiAug>
    <xmx:mMLfYb-sU-z3NRTWhTD3dS5wjhMOCW_Z6dEW87cMp0ygoZ6L8aiBzA>
    <xmx:mMLfYcgpWjN9Tcg72ypSP36PB7BdUlrZdr9mXuag-G2wYH1wShYAaQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jan 2022 01:11:35 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 1e4d1b4c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 13 Jan 2022 06:11:35 +0000 (UTC)
Date:   Thu, 13 Jan 2022 07:11:34 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Bryan Turner <bturner@atlassian.com>,
        Waleed Khan <me@waleedkhan.name>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH v3 3/6] refs: allow skipping the reference-transaction hook
Message-ID: <be826bae3b564fe003778ea10cb2e06fc753c21d.1642054003.git.ps@pks.im>
References: <cover.1641556319.git.ps@pks.im>
 <cover.1642054003.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RMepsUEsTJRpQIzl"
Content-Disposition: inline
In-Reply-To: <cover.1642054003.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--RMepsUEsTJRpQIzl
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
index 7415864b62..526bf5ed97 100644
--- a/refs.c
+++ b/refs.c
@@ -2084,6 +2084,9 @@ static int run_transaction_hook(struct ref_transactio=
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
index 31f7bf9642..d4056f9fe2 100644
--- a/refs.h
+++ b/refs.h
@@ -568,6 +568,11 @@ enum action_on_err {
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


--RMepsUEsTJRpQIzl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmHfwpUACgkQVbJhu7ck
PpQpBhAAgdpKbFOyQ6v5jL+7XLgV3ec6xf2UhKh8QhiCnkd1feVu/teDGZFcolxi
AhpN4en74ZVu+YHE2bhk8gv+MmkyroznLX2m6Rxc/IDQb9bM3mcYmL81uRyhPRrM
5wq1JzYbcJ3UWw56y6xoEWdcfkzX9C3Zpr2CG2SEmfF+RiEC0oreiIwC9kmE69GQ
g7gNYvbyUjhZifdUT3nOs/bBsmLT8lVG0REkUiQw6WfhhBHqi41RnP5R6mBY28Wj
C7Zab34/k/eMbd1mjyhzV08A8rdL79BdUBsrtG9KriRbiFnFufzXabr1kxc2AlKE
VFYIS+ZZ+6Jv6B0IQeJfZE4JbXqn4qMSPP0htWOeHRglNWjII0yQJfKn5r2JSC5q
I+wXZXf728hhbxGWgRvgLx8guYePEt0Nk7ugeVoZSmGvceDAVknVi22kS9Kg2Sxp
fdEg1Y7Z2LkVDfXpQ3fTbha4qVaq39AqDs8RlIPL00XshLhQ1b+JaOxbFctgSo8x
SuU0Mx9c+dUi6WFHGli5gGx6M/tk8ZRFmRU4AUGxaVlGBXl/NIbL0hsU3oyoX0NY
vUCAKLeWQTheBQ7ghaK2t2ACVCrEg0j1ZYIFBNH1ayElW1ih1n/pm1sz7q7hM2AY
qklApYSPv9JyW6M5hm3Zo4Xhdl8ojHPpkVREG/R6sGnbCydHIxk=
=1pwF
-----END PGP SIGNATURE-----

--RMepsUEsTJRpQIzl--
