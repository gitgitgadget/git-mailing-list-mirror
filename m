Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15131B8EA8
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 06:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723013895; cv=none; b=HzbrWY1dSszYxTdHOzRCNCaQwIacQ7JXos5uoiBs/obaVs/VPl1wymGKH9XirnY6gJuWB0nfQXzNZeu78R1FKr/xScjdHiZUP1XONkNZN8co4F2K4ulQmivIE5UXUtPLbsou9Ce43CPIQJK7PkXpmUKtYuTaGUrD6XSe2SWVJlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723013895; c=relaxed/simple;
	bh=usVR09YxLGnLISA9fjoksYJLlqPJ84STdnpyFf9j6es=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVoXT7N0jqTE2pKEyExqn8CZYKyFMnxX+j6PJB0Mti0/tSKWGq0UMgo4XzO0qVMFMKUdoyDPZJLqmgT+eMgRm7PKzW+UAPBD03BlrUAxJfQ/GaM4HfIUV3RigrVpt7HnfoVH8ClA1C6omtUKddabNOkTJ9eQq2sk28ZOAGP+e3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OI+co2Wf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QzrbGyr9; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OI+co2Wf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QzrbGyr9"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 1E8BB138FCDC
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 02:58:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 07 Aug 2024 02:58:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723013893; x=1723100293; bh=vBmjEpYAiU
	zlG2d5/GAYT3dd0t44d8LzKQoAcKYqC54=; b=OI+co2WfBCZjnRlprV41wYXdDr
	UB89eabXi3dwLEbCnJzCCVp7NGbMUyi1nw3iSj8W/Lao5HQuP9ZKpeAtwVUc9Bx4
	t2sTQeSil7oPVzovAXujrYGBtOHzDuEKMhnRtiCR7VZvOUfp9pkbWfcb7Xldn4fC
	5ZYi5bhJdWsDSQYvO3nJITlc5A9mVCCbp1m+vUpv1X9rfGvKVvbNikY4wwMPBziK
	EQR1vdGPdqbPw4z1vno9RrP8OLyb3tsKjjCgz+gCFbT+LDaob9XdwZbk98BgCmx/
	C2LTj1rgx2IT/XAxUhtUhJX8PQXnzph93RK1fkkdhI+wW1rdLRmz9qTXb4aA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723013893; x=1723100293; bh=vBmjEpYAiUzlG2d5/GAYT3dd0t44
	d8LzKQoAcKYqC54=; b=QzrbGyr9BD/pukvac/qpOS0J6JtXDFB6l+psGs31Ut3k
	fDHCBOb+WDQmbA5JQRy0lIcoZFRrpwHahygLxgxf8m3h8TWl5GjlhmgF/2N+mXyH
	xQK7Us5s3ugNkOttuKIYBHX9ewmnfoKhVvbHi7se9xnPS3iclD4w9FCZhq4ykape
	NAR4UnP3kvpvXDO01UyWleXcaw9EvLyIPgXr4YYfkgjNjdtzCfuib7tw+xeBzH70
	XdfjFzZBJr0v7AHKjOxhNMK7YLGhpGNQfCI4p+q4OXO+vcyhwu5K5YGsGWeBGOjY
	WEBmgZHODZbCxT24obSA0sLqd44k6qnIGNge58G58g==
X-ME-Sender: <xms:BRuzZikAmAtnjYuL2NiL8PU5ITPyX9pUT10sjF6_9dicvLutI8eB_g>
    <xme:BRuzZp0Dn3u8dbY5IFkTyhHwnXYzWjhybyo7Nrnf3Rwc4VSFgS_48aWjHsOyWyvfB
    FZE63H68JZIE6-5zw>
X-ME-Received: <xmr:BRuzZgrwD_I4PnVoNJ6jKStaABfFM15VS_AYaiDnjiFpyfIKJpw3G7E1j28ZaRMjwP52aH16fbq68q09QAn73Hwz498XcEbk940MYeu690Zhfl4N>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeelgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepudegieeuffefgfegudeiueduhfdvffelvd
    fhkedvleetfeffudegveekieejieeinecuffhomhgrihhnpehgnhhurdhorhhgnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:BRuzZmmcjZy1Y_LK-y8un4uYYicB7cumhHx1pZ7F4dfxvo6G_lqjSg>
    <xmx:BRuzZg2z4V2g0RklvudgOdjVkI2nLrGcuGv3J6RDp2Y5NhIKydDQXQ>
    <xmx:BRuzZtuG2ZbPsIQC8c3BNpkSPlrcH244k2Agcg6Z0uBk5g8d1Eka_A>
    <xmx:BRuzZsW-SFixyTltRmk28AWqFe4DN27kuEjWFgbx5cowN7HtQSj7Xw>
    <xmx:BRuzZt9r6g9NRsLXlX0hbF492PCrtjUOTkmpUBV81VBeGwKiE9v_bHsm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 7 Aug 2024 02:58:12 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f912ab02 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 7 Aug 2024 06:58:08 +0000 (UTC)
Date: Wed, 7 Aug 2024 08:58:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 19/20] global: prepare for hiding away repo-less config
 functions
Message-ID: <f7617beaa5aad64fe98ac52015eb68786114728b.1723013714.git.ps@pks.im>
References: <cover.1723013714.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0IvmOpYTiBeKHAu9"
Content-Disposition: inline
In-Reply-To: <cover.1723013714.git.ps@pks.im>


--0IvmOpYTiBeKHAu9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We're about to hide config functions that implicitly depend on
`the_repository` behind the `USE_THE_REPOSITORY_VARIABLE` macro. This
will uncover a bunch of dependents that transitively relied on the
global variable, but didn'd define the macro yet.

Adapt them such that we define the macro to prepare for this change.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 compat/fsmonitor/fsm-ipc-darwin.c | 2 ++
 compat/precompose_utf8.c          | 1 +
 connect.c                         | 2 ++
 credential.c                      | 2 ++
 daemon.c                          | 2 ++
 editor.c                          | 2 ++
 fsmonitor.c                       | 2 ++
 gpg-interface.c                   | 2 ++
 graph.c                           | 2 ++
 imap-send.c                       | 2 ++
 mailinfo.c                        | 2 ++
 merge-ll.c                        | 2 ++
 parallel-checkout.c               | 2 ++
 protocol.c                        | 2 ++
 refs.c                            | 2 ++
 refs/packed-backend.c             | 2 ++
 refs/reftable-backend.c           | 2 ++
 sideband.c                        | 2 ++
 t/helper/test-advise.c            | 2 ++
 t/helper/test-config.c            | 2 ++
 t/helper/test-userdiff.c          | 2 ++
 trailer.c                         | 2 ++
 versioncmp.c                      | 2 ++
 23 files changed, 45 insertions(+)

diff --git a/compat/fsmonitor/fsm-ipc-darwin.c b/compat/fsmonitor/fsm-ipc-d=
arwin.c
index 52f4f29720..fe149a1b37 100644
--- a/compat/fsmonitor/fsm-ipc-darwin.c
+++ b/compat/fsmonitor/fsm-ipc-darwin.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "config.h"
 #include "gettext.h"
diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
index 0bd5c24250..f7cc7b3be5 100644
--- a/compat/precompose_utf8.c
+++ b/compat/precompose_utf8.c
@@ -4,6 +4,7 @@
  */
=20
 #define PRECOMPOSE_UNICODE_C
+#define USE_THE_REPOSITORY_VARIABLE
=20
 #include "git-compat-util.h"
 #include "config.h"
diff --git a/connect.c b/connect.c
index cf84e631e9..6829ab3974 100644
--- a/connect.c
+++ b/connect.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "config.h"
 #include "environment.h"
diff --git a/credential.c b/credential.c
index 4b1a2b94fe..ee46351ce0 100644
--- a/credential.c
+++ b/credential.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "config.h"
diff --git a/daemon.c b/daemon.c
index 17d331b2f3..c65b068b76 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "config.h"
diff --git a/editor.c b/editor.c
index 6c461dd253..323d7d91e2 100644
--- a/editor.c
+++ b/editor.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "advice.h"
diff --git a/fsmonitor.c b/fsmonitor.c
index 2b17d60bbb..28130f748f 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "config.h"
 #include "dir.h"
diff --git a/gpg-interface.c b/gpg-interface.c
index 5c824aeb25..6587085cd1 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "commit.h"
 #include "config.h"
diff --git a/graph.c b/graph.c
index 1ca34770ee..091c14cf4f 100644
--- a/graph.c
+++ b/graph.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "config.h"
diff --git a/imap-send.c b/imap-send.c
index 01404e5047..b2eb3d2dd0 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -21,6 +21,8 @@
  *  along with this program; if not, see <https://www.gnu.org/licenses/>.
  */
=20
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "config.h"
 #include "credential.h"
diff --git a/mailinfo.c b/mailinfo.c
index 94b9b0abf2..95228531a6 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "config.h"
 #include "gettext.h"
diff --git a/merge-ll.c b/merge-ll.c
index 180c19df67..badb6dea57 100644
--- a/merge-ll.c
+++ b/merge-ll.c
@@ -4,6 +4,8 @@
  * Copyright (c) 2007 Junio C Hamano
  */
=20
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "config.h"
 #include "convert.h"
diff --git a/parallel-checkout.c b/parallel-checkout.c
index 08b960aac8..01736f1352 100644
--- a/parallel-checkout.c
+++ b/parallel-checkout.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "config.h"
 #include "entry.h"
diff --git a/protocol.c b/protocol.c
index 079ba75acf..bae7226ff4 100644
--- a/protocol.c
+++ b/protocol.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "config.h"
 #include "environment.h"
diff --git a/refs.c b/refs.c
index 0afc70b51b..284c64dfc5 100644
--- a/refs.c
+++ b/refs.c
@@ -2,6 +2,8 @@
  * The backend-independent part of the reference module.
  */
=20
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "advice.h"
 #include "config.h"
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 89976aa359..ba2ad90d10 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "../git-compat-util.h"
 #include "../config.h"
 #include "../dir.h"
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index bf4446afd3..df67923d21 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "../git-compat-util.h"
 #include "../abspath.h"
 #include "../chdir-notify.h"
diff --git a/sideband.c b/sideband.c
index 5d8907151f..5b6b872a1c 100644
--- a/sideband.c
+++ b/sideband.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "color.h"
 #include "config.h"
diff --git a/t/helper/test-advise.c b/t/helper/test-advise.c
index 8a3fd0009a..6967c8e25c 100644
--- a/t/helper/test-advise.c
+++ b/t/helper/test-advise.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "test-tool.h"
 #include "advice.h"
 #include "config.h"
diff --git a/t/helper/test-config.c b/t/helper/test-config.c
index ed444ca4c2..e193079ed5 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "test-tool.h"
 #include "config.h"
 #include "setup.h"
diff --git a/t/helper/test-userdiff.c b/t/helper/test-userdiff.c
index 0ce31ce59f..94c48ababb 100644
--- a/t/helper/test-userdiff.c
+++ b/t/helper/test-userdiff.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "test-tool.h"
 #include "setup.h"
 #include "userdiff.h"
diff --git a/trailer.c b/trailer.c
index 72e5136c73..682d74505b 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "config.h"
 #include "environment.h"
diff --git a/versioncmp.c b/versioncmp.c
index 45e676cbca..e3b2a6e330 100644
--- a/versioncmp.c
+++ b/versioncmp.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "config.h"
 #include "strbuf.h"
--=20
2.46.0.dirty


--0IvmOpYTiBeKHAu9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmazGwEACgkQVbJhu7ck
PpRk/RAAhnrbSoZLjEmpWOyGDtlbwsdfMTD08Onq1RpMupL9Nyh5z7YfrAgjW0+M
Qyqbu9GldmaiRhCj6SbxE+ZXBUrZO07X8MH/hmF9I0GYUIF6k3r8b7Qt2n93VgSp
r5EKLdCLAhqNfm62j+JCokHaJmBrTahFzv/DRQO5dStm4s3f2h3zw/ItDsTvH3In
pozIKRdP4PUXWQXCDnvbkJlI7n34293sst7135XlYUTOeiFNvnVjlTMNP/AR4QXL
tgyHBclJ7SKY8sW/BFLC9JM/tqaXnfgOhUOHfIXJLmIzEg8jk+nfxHtwkG+4reEc
7usWVW5xUhRxyVy+D/xLUinuM1XwaZIEtGjh4TfLhv08H32LdKP3S4jPwCWNogq1
SrJoxMm9LhvWAPRrwCQcPDPAYQbpAHqt2GBqYxWvWphOMCnU5qzHiKpBj6Pz31YV
2+7vNHi+azz89pjydzQqCKLtbK6kNEEcNfm9a5WAgwEbRmHE+HB2uegoyJxMy38h
vCh2VZy1M0Gxo35nIkcwEbCJ0xdgrgPZNU2hAQIA/yqFUEqlSswI3IPhQcSQqorf
2V4u5zlIGM+t4X+ZV30DetjAQzqtto7LVvLL3h5Hy9XpANwi9HpvOgzcXos83QW3
+vuAiCitCEodahcRNjCaonQXX5OUpg3GgbYa2nCMAI8TIIpVIFs=
=i52e
-----END PGP SIGNATURE-----

--0IvmOpYTiBeKHAu9--
