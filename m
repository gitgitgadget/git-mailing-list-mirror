Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC86364AA
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 10:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710759179; cv=none; b=cze5hlM9yA4INoHtdq9CBFGKgnVUQMl6qt80KTH7Y2wu23I8YADMP4dLRv23bL6fHIMVb0qETLTmLYIOjtsQvc2SUgpDd/8Ej0kLVa06L0tFRLALYtQpNUiq2PUHa55s1SmuvpCqH+hcIPqhhDS/zny4hhq2FZHuwlnv8yIvySA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710759179; c=relaxed/simple;
	bh=oQT8on1+l/dRIS2KaXkEBK9n5NIxHigJDuiCoWYB6wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YEkTFn+SxmkNTVyJvuuZXeOt5k86Q1NvtnL4bHNdjLbjvYGH/LXBtQz+UuBv8e/cbYd5JvunaAVN/jWzA6sVRh9F0PVVa+91CsGxNLhnzvC3M8Fb7ynNk8yRSfE8NqbT+DPZ3CidzJI9NX4A3op0mTNEWOc42gqwxLstief2YxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=F+HnD75f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YNitTk9N; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="F+HnD75f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YNitTk9N"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id ADA55114006D;
	Mon, 18 Mar 2024 06:52:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 18 Mar 2024 06:52:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1710759177; x=1710845577; bh=OzsO38GPky
	iKvDrw5DKmd21FLlUKuv4Rbd4fG+KDkiY=; b=F+HnD75fUa1gu+Xc5jlAA3M8wH
	FGHniDzEOOLZZ3VUEpv8uWcU9IKVHFKHxpb3TgfnSAd+mWePtEdLvYv2d3VmstE4
	P6Lp2Ql8Ho19oRyyMGUKgNqcIPzUk6mF6vZZ14G7tAn3hqsEFuMpz264AWdBitU6
	3G5cUi2zefEkmKZU/vADat1eFcdvYDQ6mmmZeSi/ByHNg3v+FwrnFaqpM9sAMZRG
	thvwQwzVqgmw1bh6nKKfZvP19m2P3fC4zZqymH8l2ruKv66kacSl6RFhKhjCRKfH
	+nbvXoxKOsCg3L4kUC9ghgcQUAadzZ+J+iOzBR1Yh8hl/DWERiyYIrcrBurQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1710759177; x=1710845577; bh=OzsO38GPkyiKvDrw5DKmd21FLlUK
	uv4Rbd4fG+KDkiY=; b=YNitTk9NiU5nnlKWpy4IQnpn2ayhC4ApgnAWaXj/hEM9
	eX7NHEg560GWlIebhpIZjwGXozsgV9O9zCjvJXwymnNZXrzsC3NhN9P/PybkvVtI
	0Be+9+ME8v4S2IOjsO0I5Ctbk04IhJ43DjnbCs++nxqGL9AxaOD2pEUMWNW/oJEO
	6TI3zQU25ipeESpbwUu+4lWYutIC5Ep0IOnwBwgtzZaoOp8BOO7fUjp7oZPAl5iQ
	168p38eNzIlU+Ejh7ZpkS/cbJQPTJW3VshpZDO36O9bZUJFoONYaLfDCg3AUbqGQ
	K5kkC4xbLn9VkMkV9MSk8Aaq6IuDx8bbVDqnEb+7GQ==
X-ME-Sender: <xms:CR34ZYCNOsylpWseXFy1-1tnSImoaDIQ7wNw7N-FDvTP2QXLvLan6w>
    <xme:CR34ZahbBUom5Ogqn-_3OYLXX4BOx0ZjqXIBekCtvWhHuhlzQ_DIL4TST6w7aTYY_
    ybVl9z28IcyFHoOeA>
X-ME-Received: <xmr:CR34ZblO4XpOoisztRQ4MN4EqO4v7y3G-yRb0mx4nRzJ0zsQf-9Cr5O6UDs_LVF9XCCNoa6XOuEffavCpNIung6PRLGr8Hyluv0_GCxJbd0iaA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrkeejgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:CR34ZewmGAQiI6SPrNa2yiczqbj0C5HDf8dJHCLE8m78AVOOTJoYsg>
    <xmx:CR34ZdReFDefNevTiyOkUS3y9fHsyHUtA3aMM3tpn--q5PmQqVNFNw>
    <xmx:CR34ZZZ0NYVeGhs5CMFyIsJxc6DlIBX_uoer7ZesiPzPRf29rCk1fg>
    <xmx:CR34ZWT5Zr-s10Vv23YoWJ1Hbts7OGlxshFtG87vHRBk4zXScpOF7A>
    <xmx:CR34ZfeWo0itrPgLQaDEXHYlMGu120TjzyTx5UGKvRdVSghkZn3yyA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Mar 2024 06:52:56 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cef2137c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 Mar 2024 10:48:05 +0000 (UTC)
Date: Mon, 18 Mar 2024 11:52:54 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>
Subject: [PATCH 07/15] refs: move `struct pack_refs_opts` to where it's used
Message-ID: <072627d82cc71a56a4e0884a15380a9df5d1d03d.1710706118.git.ps@pks.im>
References: <cover.1710706118.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j4ySED2LskrSfWzD"
Content-Disposition: inline
In-Reply-To: <cover.1710706118.git.ps@pks.im>


--j4ySED2LskrSfWzD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The declaration of `struct pack_refs_opts` is in a seemingly random
place. Move it so that it's located right next to its flags and
functions that use it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/refs.h b/refs.h
index 298caf6c61..139ce7113b 100644
--- a/refs.h
+++ b/refs.h
@@ -66,12 +66,6 @@ const char *ref_storage_format_to_name(unsigned int ref_=
storage_format);
 #define RESOLVE_REF_NO_RECURSE 0x02
 #define RESOLVE_REF_ALLOW_BAD_NAME 0x04
=20
-struct pack_refs_opts {
-	unsigned int flags;
-	struct ref_exclusions *exclusions;
-	struct string_list *includes;
-};
-
 const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 				    const char *refname,
 				    int resolve_flags,
@@ -433,6 +427,12 @@ void warn_dangling_symrefs(FILE *fp, const char *msg_f=
mt,
 #define PACK_REFS_PRUNE 0x0001
 #define PACK_REFS_ALL   0x0002
=20
+struct pack_refs_opts {
+	unsigned int flags;
+	struct ref_exclusions *exclusions;
+	struct string_list *includes;
+};
+
 /*
  * Write a packed-refs file for the current repository.
  * flags: Combination of the above PACK_REFS_* flags.
--=20
2.44.0


--j4ySED2LskrSfWzD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmX4HQUACgkQVbJhu7ck
PpS8WQ/7B1N7ZPPP5s1YVQsX0wGuPrxLz0VCNZqt9GTTIQexJs7UNRHGkHggNUmQ
CsNHKj3w4XKjt0ckDOnjGU6VWwrbd4pJO9zf8yUGBINLj6pdkNoyo3CQ14Puf/s3
BjnzhwKbO+fbR4PIBLGp4vrjyC5SsO8nV5lk9/a9O1falEWm+dedO5NiMWvod4zb
yP4/S7uMuEDDhutl3l/ShfWATo2iyfAdYmHUpRYv/z4LrCNvxi0GzQVuzRmjitXN
kwy6p5qiqrTwREPNFsd7jIvbG+a/yywmu+VTyhCN+Fkd2tJGyZxHReHXw3iiw1kh
aYDoJvG1G524+rbCn546BTG1quD47axklAZNz+Gn3fvT1vPWa7EaHiaZ6/nZ4WET
dho/EsOP2AyyHjS0hB8P7W0w1fbyrLcCqBMPPs2M9K48b1289S7gQaxwD97IlzST
B5hrEfx0mNUsRqdPkX6zqTEuwiZTTggzc32w5iAqeBJsKGdxAnMnsevJzAAJswg5
sHmodWZYFYaWP88MWLQpr7QLhq8ynUMDR4j1M+SfSH71U/3+ng0gqPh9AfntJq4H
S5PLTVF9k+azTSD/xjcL7c6pckIFBbt2Rs6y35gG+dinmi9Eh4IPECIgjUtaUGud
YIkD1ubEJ0kJTOEQ2NjZMyWbohJRspHILcGwb5BY/WJoH+O2d1I=
=JRjc
-----END PGP SIGNATURE-----

--j4ySED2LskrSfWzD--
