Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0661AE053
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 06:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723013863; cv=none; b=Wlbdbi1j3XZB3JjawOhczvKOVpM226UKVPs3ReXfRpQjsCVhPdYLGIZPk1vFlm5QIUk1z33wyd23HhfKJGvDVFwfKT+EsZ07WtvRWuRPe48Kf8z/zS44yhDDu5yIEZtjmSa4/nagDRNNngUqodQmyCcxlSdvw5wnhrL+Xbuo9l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723013863; c=relaxed/simple;
	bh=ap/mCdk+ccXvTWSUhTm2IZLhzGtpaf53htMbECSd7jE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UO9OROD8qM8Ru+0EHA+qau+brpyL9dPMNtLmv4MWdJjP4pNRCYjhoF0VCxlx7jBdhAmHhh9+olunmLWqrQu6xPtIQ4J2HXUrgUlz2Wl+R9KWK/10YutZAEQ9X3xzNHXI6KEnFVCjkOFXIkAG/BG3Jjl+XIj1FpFhBedpMWQ/HdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=S0C2FG33; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=absLo+B0; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="S0C2FG33";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="absLo+B0"
Received: from compute8.internal (compute8.nyi.internal [10.202.2.227])
	by mailfout.nyi.internal (Postfix) with ESMTP id 6B78C138FCC4
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 02:57:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute8.internal (MEProxy); Wed, 07 Aug 2024 02:57:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723013861; x=1723100261; bh=av4cxzc/ly
	je2jr+Vtg7ow9KGhnyhRTFgX2puoK1CpM=; b=S0C2FG33aEpxPZku9TIR9PdilF
	mv6WbaiIw7U12wEtribzVc+v4da6Bazsq9ncdqLjArzNhvJZNF97Mj9Ac0WMSAEh
	JmNWC/ZNAo6nHcz2TANacqTRtTU+QAPQxiNW7XVH7Eb9DV1IqnK0fNiEvkqzzpR+
	LoAV44paVbcpFj+0k/TWNCy5zmqIyX4ClWntLHvWRHe8k3FhV3Gd7ShEwCVNenl9
	IPReEmx/2XA/WEXTS9YylOuwSYI0IzJQi8DRmwP2IitePnf2KzwUC+af6hf8n+Yw
	mIywl6iPs4wsM9UV2Myf3eoXD8YarXy4DT9NkjM1FlTlyYkATvdTO3fvOkiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723013861; x=1723100261; bh=av4cxzc/lyje2jr+Vtg7ow9KGhny
	hRTFgX2puoK1CpM=; b=absLo+B025jMsCPz/JwcjrQe2JNRCr+wNsRZQQlzEMcJ
	1g4KZaFI9GuboBVt9F+5dbBdKM3odvve5y0sWyBq1L2tXtkjN327luDIz3dK/P4O
	zbNbTP2ByHP6psrCJeImZakyzaYYFjfuFVg4eTe5aUsgL9aAKYB1adL+ADwMolVf
	R/VKgpMxWo7UcS8E/D3vcGIBMSbakKjpFH+byaUu2oWCJqWBhbRSHXhZhnbkIOmY
	vJPnfIhiEqpOV+Mqcj0WUk3jxjj/+ITGfuX5Cu1vuWAHNmX7Du5mreQ17mYx9ohv
	5vVpq3PHNnXUnzSmMfvDQKLZfBWbQgeW62Ht2G8QMw==
X-ME-Sender: <xms:5RqzZnGtdi5bm6UACmQK5gyJ46pJ7M7rj31gUT31zxIsRUYltQP9yw>
    <xme:5RqzZkV7fZLPC-_DO594hapmiotdqhIipglINQfzfvul5uSjf1de-ptfPaszq12XF
    AP0U1s-Ykx0fjYAog>
X-ME-Received: <xmr:5RqzZpLSKY2VrccZSJ8o_u6p3upYG-CQS7pzzDEwugoljD5CTwHmepBXUacwjHSNEybKFOeDI8iD6e7kqtpjeE81NSTNWC5hx1HsIYGG2sjkA9b->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeelgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepvdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:5RqzZlFAea1B75J1aoDz9XzFKcfhF7v4fITbNXIM6AEzBY8HF8cAuA>
    <xmx:5RqzZtXsWJGKO1kc71xBFE09U80Q8QWiqNCgFNf9iSBhw_8I4tmIsw>
    <xmx:5RqzZgPR5lLqMLZrPIsC-JlQtawoKmJ_eRHyTrw087iRhjWalhLS-g>
    <xmx:5RqzZs1BcWdKaNtGKdPYIf7CORmU4uHWkXeY6wPy5o230iwSJcwvEw>
    <xmx:5RqzZsekn2GqD4F10yBZPfzeTbrtaU2q8H6MpkstzQ8fJyRj_ztfpTjL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 7 Aug 2024 02:57:40 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id dcbac6cb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 7 Aug 2024 06:57:36 +0000 (UTC)
Date: Wed, 7 Aug 2024 08:57:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 12/20] config: pass repo to
 `git_config_get_max_percent_split_change()`
Message-ID: <b95ed05f883f771274d0af367c368e87f84895e2.1723013714.git.ps@pks.im>
References: <cover.1723013714.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JhrMttPNsN3hT+UE"
Content-Disposition: inline
In-Reply-To: <cover.1723013714.git.ps@pks.im>


--JhrMttPNsN3hT+UE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Refactor `git_config_get_max_percent_split_change()` to accept a `struct
repository` such that we can get rid of the implicit dependency on
`the_repository`. Rename the function accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 config.c     | 4 ++--
 config.h     | 2 +-
 read-cache.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/config.c b/config.c
index 89fb7ce6b1..f1d2fb6d4c 100644
--- a/config.c
+++ b/config.c
@@ -2811,11 +2811,11 @@ int repo_config_get_split_index(struct repository *=
r)
 	return -1; /* default value */
 }
=20
-int git_config_get_max_percent_split_change(void)
+int repo_config_get_max_percent_split_change(struct repository *r)
 {
 	int val =3D -1;
=20
-	if (!git_config_get_int("splitindex.maxpercentchange", &val)) {
+	if (!repo_config_get_int(r, "splitindex.maxpercentchange", &val)) {
 		if (0 <=3D val && val <=3D 100)
 			return val;
=20
diff --git a/config.h b/config.h
index 35cee9d4ca..dd7127b8e9 100644
--- a/config.h
+++ b/config.h
@@ -712,7 +712,7 @@ int git_config_get_pathname(const char *key, char **des=
t);
=20
 int repo_config_get_index_threads(struct repository *r, int *dest);
 int repo_config_get_split_index(struct repository *r);
-int git_config_get_max_percent_split_change(void);
+int repo_config_get_max_percent_split_change(struct repository *r);
=20
 /* This dies if the configured or default date is in the future */
 int git_config_get_expiry(const char *key, const char **output);
diff --git a/read-cache.c b/read-cache.c
index 12c2da5a8b..1e52db7f36 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3275,7 +3275,7 @@ static const int default_max_percent_split_change =3D=
 20;
 static int too_many_not_shared_entries(struct index_state *istate)
 {
 	int i, not_shared =3D 0;
-	int max_split =3D git_config_get_max_percent_split_change();
+	int max_split =3D repo_config_get_max_percent_split_change(the_repository=
);
=20
 	switch (max_split) {
 	case -1:
--=20
2.46.0.dirty


--JhrMttPNsN3hT+UE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmazGuEACgkQVbJhu7ck
PpSRBhAArFZA+gVWac/WJW++xXzdtsfj6vhLUQXT7pk4fvFkW0hdBdUKausn2J3X
dBV71VehZhJvf3daDYZXPz0E8ilCs4Bp4jkH6DqfyhRbvYJ4lZ2K98Rcm16UbeDZ
NViOnR4Roq9UAmjPRz4A9ovw2q7udQIvmPnWwI8+m98kxeJARozjqELTTcV0XCz3
3wo6uFa5ByswG8pJrRmeUIYUwDolGc/13V7ZaVliMx0BqoP/geFfp9snPngnWm9x
SsqZWhbQrYNh6HzM9AJpW+dLeUdy/VhZkx4gTH1sokAIcStKm6QeaDgvj8p88cJR
DptbZ16GvMGFAGDFGdaBaQEl9aCvDWws0VpuzgHw8U+GYzXGyVlvTTJuXlvxcnct
UZJnLviwAmSDBi1l2mWzqRE9zC/37XrIn8Gl4nuEjZlW6J71wWrinVKikV09GIeN
cJd6Re7XAz12TyCt2K/AoxMbVS+xPwgmxYUMa8HEd8WFWDEqWyjyOr/nODUUCkH7
oqq4HLkZ1dIrpzIVgckqTeHCL1qtqOdq1dXMEROXufQssD6FdYJ4Ae4EpxsGU4Ed
jI3sXfb7GofSGYb0bLvP6A0GNB5Z6qvo11Qky0UaRInYKMtjBswkP3BjtfqSD89J
X5uC4ekUBdULtPSaEQi0O+HCZAL/SrC6PhXvgEKuCSLI3pmoBwY=
=+u8d
-----END PGP SIGNATURE-----

--JhrMttPNsN3hT+UE--
