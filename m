Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCD1EEA9
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 13:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723122317; cv=none; b=CmAL/HlCGpnlgINorSI2ul00ydw+9dd2jihmf04M+kyhVJjy67o6YUPzGzgvlUWF729CayMSO94mSLJkoinx103pv/meunbHiRf1RATpxxjplQs3vXwzmcJehc0dUUkfqmPrRmWwqbz9lrYEaxV2wwEk8J3WT3DEV1c4Ilmsdcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723122317; c=relaxed/simple;
	bh=szKMLuTQWNgtjsbJASdSyjj6BZcyNqyGAyLxorIM8mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJyKYfihatKsQAMdeV3LzZdQIhbQVpQ92OiQUgXLlgp5xmtM33Trx5dUArYdgjd92MEGqu+5jVTd3GInmS5nU5q18MgN9gmJWgX/JA8OBfO4gxK+k6+zMa+QtrWiwAHe6J9WDNv6eHd1YDFq2NzgIq4Qlg1StmgHZU1hDRv3Cek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NZRakOLS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rwfn9S6o; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NZRakOLS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rwfn9S6o"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 17D691151ABB;
	Thu,  8 Aug 2024 09:05:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 08 Aug 2024 09:05:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723122315; x=1723208715; bh=7D/VnnsTlS
	SRNaUReBh7hQcfXifxue1fHQFwmd5FeW4=; b=NZRakOLSNvPr4Okb5lFQgIkb9n
	KuBBTnXDbA1l+UIk6TLgZxqjuiBJP7s0d1+mvQf8OChLswA50io/C5oXJ/Iphdzo
	tPAc03ZOLqXlJBVRQLkgrNg3xHr5jeZZUB1ZeJ2VzUASU4zohYZ5EnWN0jFMRGcY
	Wbcag2GlhUJZh6SPoZaFzLwng5uIvam2i+5envaBUxXHYx1kzgFt6y6W2i0VlZpJ
	w/pJtimUfJFkOtUXw5k7OJAd/LBnKhjQ7pO8pAEChmaOxhN6E2Oq6ghLQFtirLX8
	6Z0wT+9ztb7oqyhWsJ0L2ZVQwBcTB2ozHB8+wmfVpRfC03zu6IK9LC68EkEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723122315; x=1723208715; bh=7D/VnnsTlSSRNaUReBh7hQcfXifx
	ue1fHQFwmd5FeW4=; b=rwfn9S6oPR0sCdqMwxrssJvKxCAIq+Qxmaun/dm5WC4F
	BjbcmgFLHLxw7lG3HR5eqD5/h/LwqWEWStvo9Wc0dpQ7ASYlX/Axh+k1gJyI/xOs
	78lbD1PYytQm4Hd1yXbSRg+L1CwljEQYuvQIfAbTResXoTGVjR8tyxjhPLHGEuix
	sF/SyQcC7H+PvVf0yiJ0nx8tm8kegQ+31hi/NDM7opr5ns0U0Hfs3nBvi04KcWkn
	PdryFqKy/KKK8HJIc+aCRSO7z0BdGx8hZGSyM7NBC5Rpy8Npxf79iklxdrhcTM9x
	0lHHdMaObb23Xpr5f6Y1Il+QyhuDmzlE8QDtR1soNQ==
X-ME-Sender: <xms:isK0Zr5CclB8yDkwbPIAopdn7iOV7hkEiVCCYZWP9YPGVnVAQzva6w>
    <xme:isK0Zg47u3tCGJ9N3rJCOBHXJkxRq66tMe873WT5wokDCUu5f9dL74DTVTm8SW6Qb
    xdCw5oQUDLISQn0zg>
X-ME-Received: <xmr:isK0ZicRD3ITeCTfqAabo9hAhfQGWcbo6uujEmpxiNMuAzWufyNNkptTFGrtyYsdDR1sgBaylnuzLzWy6xyDCXCUOlbZMP2fjGu49Aaz0APc7zhk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledvgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeeh
    gfeltddtheejleffteenucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepjhgrmhgvshesjhgrmhgvshhlihhurdhiohdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:isK0ZsLDqgBjLvjHBUrLpDyui5Z5zLNXV7HIAm63IfcA2S5NqJexig>
    <xmx:isK0ZvJpsaPxh_XOLvsKapBGIoqrbbHpSPQhRZZcI1GLBjBxiby09Q>
    <xmx:isK0ZlwkuB-ecsOvwpB9212yGvHTI727ogTRJR2mA5THJtfBNnI4zQ>
    <xmx:isK0ZrK0f7E9Dp1HCzgxHw2egP8_oDYRDf3Xmso3y7AlbwwedHrIcg>
    <xmx:i8K0Zn05RsDoJjrTbUwt1JK9zGvZHbzYXR-uMcRSE16wO9Qz_BN0Z1Cv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 09:05:13 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9035d9fe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 13:05:07 +0000 (UTC)
Date: Thu, 8 Aug 2024 15:05:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 09/22] builtin/rebase: fix leaking `commit.gpgsign` value
Message-ID: <e497b76e9cd0fc2e664e8031b68dd04f6b236c74.1723121979.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723121979.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x8yyUL8wli7/7VqE"
Content-Disposition: inline
In-Reply-To: <cover.1723121979.git.ps@pks.im>


--x8yyUL8wli7/7VqE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In `get_replay_opts()`, we override the `gpg_sign` field that already
got populated by `sequencer_init_config()` in case the user has
"commit.gpgsign" set in their config. This creates a memory leak because
we overwrite the previously assigned value, which may have already
pointed to an allocated string.

Let's plug the memory leak by freeing the value before we overwrite it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rebase.c              | 1 +
 sequencer.c                   | 1 +
 t/t3404-rebase-interactive.sh | 1 +
 t/t3435-rebase-gpg-sign.sh    | 1 +
 t/t7030-verify-tag.sh         | 1 +
 5 files changed, 5 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index e3a8e74cfc..2f01d5d3a6 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -186,6 +186,7 @@ static struct replay_opts get_replay_opts(const struct =
rebase_options *opts)
 	replay.committer_date_is_author_date =3D
 					opts->committer_date_is_author_date;
 	replay.ignore_date =3D opts->ignore_date;
+	free(replay.gpg_sign);
 	replay.gpg_sign =3D xstrdup_or_null(opts->gpg_sign_opt);
 	replay.reflog_action =3D xstrdup(opts->reflog_action);
 	if (opts->strategy)
diff --git a/sequencer.c b/sequencer.c
index 0291920f0b..cade9b0ca8 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -303,6 +303,7 @@ static int git_sequencer_config(const char *k, const ch=
ar *v,
 	}
=20
 	if (!strcmp(k, "commit.gpgsign")) {
+		free(opts->gpg_sign);
 		opts->gpg_sign =3D git_config_bool(k, v) ? xstrdup("") : NULL;
 		return 0;
 	}
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index f92baad138..f171af3061 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -26,6 +26,7 @@ Initial setup:
  touch file "conflict".
 '
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 . "$TEST_DIRECTORY"/lib-rebase.sh
diff --git a/t/t3435-rebase-gpg-sign.sh b/t/t3435-rebase-gpg-sign.sh
index 6aa2aeb628..6e329fea7c 100755
--- a/t/t3435-rebase-gpg-sign.sh
+++ b/t/t3435-rebase-gpg-sign.sh
@@ -8,6 +8,7 @@ test_description=3D'test rebase --[no-]gpg-sign'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-rebase.sh"
 . "$TEST_DIRECTORY/lib-gpg.sh"
diff --git a/t/t7030-verify-tag.sh b/t/t7030-verify-tag.sh
index 6f526c37c2..effa826744 100755
--- a/t/t7030-verify-tag.sh
+++ b/t/t7030-verify-tag.sh
@@ -4,6 +4,7 @@ test_description=3D'signed tag tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-gpg.sh"
=20
--=20
2.46.0.46.g406f326d27.dirty


--x8yyUL8wli7/7VqE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma0woYACgkQVbJhu7ck
PpTj9w/+KM1XFPCDt1yh1e8ac17UrnjIAWguyMMHE5OBQgaHySwovVoc8gIPgQK1
gcTzpM/ND54ccJgkfysCuhE8rzUWdfUdw5GweqLomnx6GNWRHAemZ7cG1T/Xo9cJ
Ortu2SA4RSV0A1KAEmQaDwaT7RuOOsohYgJq1MoMpxSNfVLIBS8EGy5wbaJj31eB
iYLwzRzem7dzSOr1c0lOQjHD67dNwQW3M8DlX4Uixgq5Me9lsrPJYq9PS6NdJwwt
RNEAVLjWHWWCQxftPn52wbacNGGWwEnGjHfHkp4EvOc8yz6IQKaRAMpPrRQYRNp6
+762ksX1FVJbjR5+0+vEPRlrOtnQSxvT8nmILyLejyFQKgriI1bUSs1YMZOW4+GC
jN2phS4zHJFln/NPkhlqIPeaun1p3CjAuoUwdVKScZDQMUXWha1fdlMn6uhxWTBv
ZWxw3/ElHFRSVgLjnDHxCJwRBndPXLg93uAFZe4QtcXLdP3VCytJyRdJSRkBscJG
yQyuCaM/gt+v7muuz586uXW5fnI2mimlfQ+4noY+Mk75w79RBIBybEhbkZi2/nBk
d28ttnKJdC0SNp7Qf8n3P2ROC8nfuiHsRSRqDTgnVn9VoycqaAdNUSlpPpfaPqwh
AnToajHD0tQW8xWGR0yhYnssKi9tLnlxYoUVspIJHRNlgo/EArg=
=W6TF
-----END PGP SIGNATURE-----

--x8yyUL8wli7/7VqE--
