Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA612249F5
	for <git@vger.kernel.org>; Fri, 31 May 2024 07:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717142203; cv=none; b=MEqKawzlT6QWPyQ6f4vHSpwo/VDhTxiH3cQs0jcIms2Z1tTs2vqypWzHHkFypH1s4s1Y+HgYkaMWVxFb6Wb3p9TgvUVjMwkYoYpj3+XKYSxh9wkwPwR3TKimehqxtQ6iurfsGzPxvWCpUeVKFqSLPA1baqiF6BF8MeY8M/Sx7x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717142203; c=relaxed/simple;
	bh=G+0rjS9J64NY8ImBa78mOHr1P1gvNUgmo7ok+onKmIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ncHKcW9/Uxu84kUe2nr85NGW9mb36JDK2IPqm2iCQOS43r+CI3fsoiFlg10gh3SWmZiT6jZUu8AhHiOJWE6MuTVGTkS2YfrQilxSH4Pnxgbb2+HFwitVeTmqUil+lR5ZZUXn88h0CrbuSvzQxBOlFNU4dNP6+wXjDzBgD9w8RCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TGyjn4ix; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qXh+JnDZ; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TGyjn4ix";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qXh+JnDZ"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id EDA871140107;
	Fri, 31 May 2024 03:56:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 31 May 2024 03:56:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717142200; x=1717228600; bh=kVFO6k+WaQ
	gSvcpL4raf4AgDkh1KxOo8+ffwxixsh64=; b=TGyjn4ixoXgv5U+FDFRpm2pM3k
	jcSpcVpK8eIFvDB9SdVovGc/bMgA4VN9xL16fUS4/klSDq9d8851vX9zf8jmUihv
	xduBg3tXz7wPduHSGVCrbxacdBf+qNMJxKkE9eu7zYIZ1LDx/DcdveTgh+b3QFZv
	+Twbe50BcoqangQxDn2EgzyPQb62SSapT0XOygEecx8xu5wkp9qqmnkW0XZgXQeQ
	twbA+QAJ4b9E2EMRIIE741IVE3R1xWXrVLb3RmKoXb05/AFJlsKc6zY3H/07j33S
	gOZhXy7lgI6LZwjTd2/GuaL/0Li9zky5Uj3E6MQpo641hFG1c0Usza5GTM0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717142200; x=1717228600; bh=kVFO6k+WaQgSvcpL4raf4AgDkh1K
	xOo8+ffwxixsh64=; b=qXh+JnDZWRpw6U6R6WIQ9Y2Mx2zD/uXZlQOQ/3mJnW9f
	6mKY3n+oq6Gm2Qkjye7QZdSQ7zUKHCWfdciVuKwU4eDeVd/C+ZsWRRpwNDSdopGM
	gOOkMS5bNXlqo+WvThYu1dqlXwdmB2h2hTYxKcqbCPkrhd6A/EqSxD2w1EkwgH/q
	ha/p3YC5LqccgFr5ZgrXAb4WqPUgkU8iv2Jau2weV4PF7dDb59ol//+Xr7e1OnjL
	DqvYH2bgjDXMZy2ySwrCfEAEww+ifvHhzmsmtgvpqGLQ+rUxtUP1Rp1DQD9mMw6P
	uddot+nMF4anhRH0zc6vCxtrb8cYWmBe9cL1x+fobQ==
X-ME-Sender: <xms:uIJZZrH5t41Tt63m3_Brc31xCuwS9x97q9RDJMKh5fDkgW_4Ixm-Rw>
    <xme:uIJZZoVyzJaPtaFK8u3qad1visvQ-B97_0xE_mJCJyyAqKqIcYf6ClwLnb8mpW79U
    Q4_54BpgO4z_ZPzrw>
X-ME-Received: <xmr:uIJZZtKY7MOvS8aDcML5EqMliDvFQhT24DLNAgKFadnH-5ytsiGoO_7tApWmQzOYlwSWu6BQLwTkKH8e3h1C-K9Ic4XsiC17xH4xe24Ya9udf04>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekhedguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:uIJZZpEphT-Gn1rO-O_xGCkx1mhMzrzTTxvW6LSKhNjVxsruXi3LfA>
    <xmx:uIJZZhW9-vo6sjUo_pnE6xWQwsX1zURMBDVbvqNztn3maU75RjNqqA>
    <xmx:uIJZZkP85SgjhJILD9tpAtiH-j9x1UHKhkQZBEVKXd2N8e8yfbbZPw>
    <xmx:uIJZZg0s8iTWDqCyK5ppUXevoFsW_K1EQXXL5lopmNrtpc9RmhY7NQ>
    <xmx:uIJZZgGoe5lVyvXciaCCjH9UON18PlghD8fTQUVFeoYdNg1mfWOsCYJg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 May 2024 03:56:39 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id fb9a91ab (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 31 May 2024 07:56:21 +0000 (UTC)
Date: Fri, 31 May 2024 09:56:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 2/4] BreakingChanges: document upcoming change from "sha1"
 to "sha256"
Message-ID: <7c84b2f957595a3d8bc6d28970a009339c5fbf5c.1717141598.git.ps@pks.im>
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
 <cover.1717141598.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mrsHv2BEb6v1VJi0"
Content-Disposition: inline
In-Reply-To: <cover.1717141598.git.ps@pks.im>


--mrsHv2BEb6v1VJi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Starting with 8e42eb0e9a (doc: sha256 is no longer experimental,
2023-07-31), the "sha256" object format is no longer considered to be
experimental. Furthermore, the SHA-1 hash function is actively
recommended against by for example NIST and FIPS 140-2, and attacks
against it are becoming more practical both due to new weaknesses
(SHAppening, SHAttered, Shambles) and due to the ever-increasing
computing power. It is only a matter of time before it can be considered
to be broken completely.

Let's plan for this event by being active instead of waiting for it to
happend and announce that the default object format is going to change
=66rom "sha1" to "sha256" with Git 3.0.

All major Git implementations (libgit2, JGit, go-git) support the
"sha256" object format and are thus prepared for this change. The most
important missing piece in the puzzle is support in forges. But while
GitLab recently gained experimental support for the "sha256" object
format though, to the best of my knowledge GitHub doesn't support it
yet. Ideally, announcing this upcoming change will encourage forges to
start building that support.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/BreakingChanges.md | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/BreakingChanges.md b/Documentation/BreakingChang=
es.md
index d8a26c9bf9..1b0a357e65 100644
--- a/Documentation/BreakingChanges.md
+++ b/Documentation/BreakingChanges.md
@@ -56,6 +56,33 @@ be changed to or replaced in case the alternative was im=
plemented already.
=20
 ### Changes
=20
+  - The default hash function for new repositories will be changed from "s=
ha1"
+    to "sha256". SHA-1 has been deprecated by NIST in 2011 and is nowadays
+    recommended against in FIPS 140-2 and similar certifications. Furtherm=
ore,
+    there are practical attacks on SHA-1 that weaken its cryptographic pro=
perties:
+
+      - The SHAppening (2015). The first demonstration of a practical atta=
ck
+        against SHA-1 with 2^57 operations.
+
+      - SHAttered (2017). Generation of two valid PDF files with 2^63 oper=
ations.
+
+      - Birthday-Near-Collision (2019). This attack allows for chosen pref=
ix
+        attacks with 2^68 operations.
+
+      - Shambles (2020). This attack allows for chosen prefix attacks with=
 2^63
+        operations.
+
+    While we have protections in place against known attacks, it is expect=
ed
+    that more attacks against SHA-1 will be found by future research. Pair=
ed
+    with the ever-growing capability of hardware, it is only a matter of t=
ime
+    before SHA-1 will be considered broken completely. We want to be prepa=
red
+    and will thus change the default hash algorithm to "sha256" for newly
+    initialized repositories.
+
+    Cf. <2f5de416-04ba-c23d-1e0b-83bb655829a7@zombino.com>,
+        <20170223155046.e7nxivfwqqoprsqj@LykOS.localdomain>,
+        <CA+EOSBncr=3D4a4d8n9xS4FNehyebpmX8JiUwCsXD47EQDE+DiUQ@mail.gmail.=
com>.
+
 ### Removals
=20
 ## Superseded features that will not be deprecated
--=20
2.45.1.410.g58bac47f8e.dirty


--mrsHv2BEb6v1VJi0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZZgrQACgkQVbJhu7ck
PpRQxw/+JU4uwgwuahGTuiNJ7qankQF2HeEV9Biijkgj++hrnVyWxzVbpaQRXvtJ
3zF6Q8tyWrU99VVRYaFptimr9Vmd2FqeDyfrHU8xaMYef5TC6JjZyuztWnRN4yxj
8iKWOW8/8qAR9dAq5+4hLP7Iu7+Kqn1Kfdb/wN12aloZbHxU5K78JNxagzq4jB7A
yoeB5x7oj7Npixl29KjdTOoGngszp2Q1QON9+Eb4CqQQfBMd9La/vnLIZQ3yCG4s
XY8AU+i7KXIFzjfp527qkAotL5NnNpcXiYlsHhPj1LADI+2EEKke5WaRux89oLGC
EVzYB65qGgl1l0ttPg2qGRuYEqHak/7iTa+t32B94Le9W/h3pXrP17/IS2WTmd93
VDKkOhV9iiDDsdTcL4FFqSdfZYx8Y8b54MBadgUi9+CH+stHTTJy7JeUWnMLcGxy
rD/pVLiwx0RcxvRPYKWkYkT2iipcbuRQjVbOUaE5BbWJuPra4plzU/QP/Wv4VzuN
LaKXKK/Hc7fN5wPujdNF18Hv6JxVjEkWRxuFGv6L7yYyQYAeLxuDeNCp4szEWQM4
jIryZayVPv8rQMOFxb0w9NASfmX/1m7X34M1hq7Z2gFIuKp1qO0gb6IQvY00IYnc
FAQ3pfjhyzMo5upm3rLDrtzSsYrXNrJbhH46+d5ynaav2ycAdaA=
=NyN9
-----END PGP SIGNATURE-----

--mrsHv2BEb6v1VJi0--
