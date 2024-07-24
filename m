Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279BF1C6A3
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 11:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721819125; cv=none; b=pMhhhIUgdWSTWxiDkMFwWIJ2gI/rUO4TWi+rw3u/lyNlvLzogKfMLNmpthFUf9mbRZn/JotvduKorb3vs3fbwGU3RJDWna+Vn1OM3/AK8bXnR56DdLtAVl4eL0yl5Bn/TQzNnT6uWjJffXrV3NdldzH0d5o6sqwGkICGENhcUYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721819125; c=relaxed/simple;
	bh=nS55w214nVXTD2VVcf8dRf87QmsiHHFywkqeiqpZ4TE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KrlLFPKBv8wCUMhDN7s9DcHN5Q29LdIfLbjRVIf8Rni2M53L5ZDUdfN8ziqrYh1klZSIuMpU6eNV1hBCAaRCDrAHjPR5493EbH/3Rfj7McGNorp8k34lrYz30X44iwibeEpoLkSzUsm42rdGQmUJMV16lES5Mwct0014XUpyFCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KbFV2uPU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XNV9UCR0; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KbFV2uPU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XNV9UCR0"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 9FEFE138067A;
	Wed, 24 Jul 2024 07:05:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 24 Jul 2024 07:05:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721819121; x=1721905521; bh=RETWbb3Yig
	2FdC+intxx2ez18VPRt/+H2leylH3CDTk=; b=KbFV2uPUAThsk/gMW8cs3eZ3W5
	zvSQ5x9GRuAzd3v+m3+SJfmmmhZpVmOcIakzb0PM+bg8LgipMHCuF2EI3wsYl/XT
	EwhyYCwazlLOF9wXfOjjPJpYgjUM8QS6g4m4Cx13gxuIt3Di896FD39+9Fpg5Lck
	5q78sdgyWeHYSfQtkqsYIEmp3GHEz0rBx4bpKJ3N7P48d7ww0y4RWUjHQUdSDtg+
	t4vf8Wc3y/mi9Ke6wQfpz2s6AtSjtkYps/FD0m78LEK2vh+G71PQlUn/Uj2EVbhz
	gFHdJMhvoAeQErIvhmCosK2L7xZXLU2/Njqp7f8rcxUYRfRhA69kI3o6oyeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721819121; x=1721905521; bh=RETWbb3Yig2FdC+intxx2ez18VPR
	t/+H2leylH3CDTk=; b=XNV9UCR0JJKJJmT4uV69bB0VShAAfMVvk9qNvQySwKID
	OLszP1s4xpCnwFvGUEFbHnFBWI7DS8iOttq4zHAh5qTT4U3jdfZ6OJSTv7j3AMTo
	bHRW+dCe/6+1fkebv6N8n37zGhts/bQB8E7Z3CGUakEW3zd2xxSlKf2bKF7V3Z/L
	Y52llPuFMBOuoS3nELNSnoHNPS06mJwP88Slfg2TjXv5ScvOYxdXP9etZvwG+bKQ
	bZqW1ZN5a0T4WFP10RdfIZidZrnj8yMUAjVO59Zn87qKzEMf3gxrid8FW+l5Oo5/
	D08obn2sfMOgbILvL8ipabkVZOvuscNU/CNCrl3SSQ==
X-ME-Sender: <xms:8d-gZmfM2dBo-0mNRv1m0yxxYYVdRmw6mDtGrOItuNGJlCRwzQ1bcw>
    <xme:8d-gZgOuSqNuJxK28L-Pdh5gxqdb3Jy_kDed2aOsyXJwz5CVynVi3HnNueV2HMRc2
    DcdIvQ_xBk-y_EVvg>
X-ME-Received: <xmr:8d-gZnghR5usj70Hopb9il4zFyKrPe6SDFfTX4ftC_0yfjyikR9prMO7viF90y7DeiWKO4YmQloJnnW4uoZxQNZmuCiVo5gDW0-nkd8diFQ-d471>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddriedugdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:8d-gZj983jSFSODi1GSWZEykesKhqwCciWF1nWYsSdfRgQOjQvIldg>
    <xmx:8d-gZitFs85_5yMaiRSxXaRXPM0HBtgMA86iZizYe27MOHY0KIwWww>
    <xmx:8d-gZqGxA6EInW67VeUC3uxUouiXgPeeRiHZlROlMe-3Wml93Ob7qw>
    <xmx:8d-gZhPZMrFXoWMAjufNfVQDQAM9IJG1B_eor1s2mIessIO5SvMq4A>
    <xmx:8d-gZr6sE24NQ0PjVNBRh0ft5oDE_b2XKkqtamAtlWCSBRxJd1EJJzyo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jul 2024 07:05:20 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 99a5a101 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Jul 2024 11:04:04 +0000 (UTC)
Date: Wed, 24 Jul 2024 13:05:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 2/3] Documentation: document naming schema for struct-related
 functions
Message-ID: <7f07bf1f3beee2f74a3572d2b9a8d28b6535053e.1721818488.git.ps@pks.im>
References: <cover.1721818488.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BKvuzQf+cgY3ntJe"
Content-Disposition: inline
In-Reply-To: <cover.1721818488.git.ps@pks.im>


--BKvuzQf+cgY3ntJe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We nowadays have a proper mishmash of struct-related functions that are
called `<verb>_<struct>` (e.g. `clear_prio_queue()`) versus functions
that are called `<struct>_<verb>` (e.g. `strbuf_clear()`). While the
former style may be easier to tie into a spoken conversation, most of
our communication happens in text anyway. Furthermore, prefixing
functions with the name of the structure they operate on makes it way
easier to group them together, see which functions are related, and will
also help folks who are using code completion.

Let's thus settle on one style, namely the one where functions start
with the name of the structure they operate on.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/CodingGuidelines | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 1d09384f28..34fcbcb5a4 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -541,6 +541,25 @@ For C programs:
    use your own debugger and arguments. Example: `GIT_DEBUGGER=3D"ddd --gd=
b"
    ./bin-wrappers/git log` (See `wrap-for-bin.sh`.)
=20
+ - Functions that operate on a specific structure and which are used by
+   other subsystems shall be named after the structure. The function
+   name should start with the name of the structure followed by a verb.
+   E.g.
+
+	struct strbuf;
+
+	void strbuf_add(struct strbuf *buf, ...);
+
+	void strbuf_reset(struct strbuf *buf);
+
+    is preferred over:
+
+	struct strbuf;
+
+	void add_string(struct strbuf *buf, ...);
+
+	void reset_strbuf(struct strbuf *buf);
+
 For Perl programs:
=20
  - Most of the C guidelines above apply.
--=20
2.46.0.rc1.dirty


--BKvuzQf+cgY3ntJe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmag3+wACgkQVbJhu7ck
PpSK+RAArHV19OAKXbmiFJP2BMdwQkrMjjeH2j0RUynvs7b8R2XNQNB1B7o+5BxS
2KkhBep0ZSJ5pUDB8Tx6H5zjdg4n/z+6VRJRnq35bBxGreR1sfs4B8OSg46xbWTh
LYWDrc4n4jTuK5mtVqcRcjf2whIcYuIKqfhCkd3e+MCQkNN4Qs9HYb0UFVXaoH9j
voS29yy+jPBRIs/ZeSWYnsW4DwYpa0si2uIG3MgR5+5xDS4Umy/mdiRiZpSrwU6D
nxpSJ4M19xfoIWm+X6zHUO8/t7t62G2e0/7ddHMiDPzo7pVINidhKbyv9HX0vvFj
6xLHrp0H+/4wE9W9WI0bT7+w5atvhbwoS0nS/dx9B956PaoN/4zQp9xW1Vr4A47L
z8NTeATem43cjcIeNU87bKIvs99EPnUV8Ex33ZX3TCFEBRnY/qHez87S1bFtIJmk
8pdwFGN7Oyy+tQe/6y2z6MF2D4uRMqjYID7XYl6PYkHDMxYGBjJ/JCPkelUoQsa9
KqYUwKf6afu6XNMFNsNqA7V7xdEdvkgu3yVEuGoeiJBdE3wtPe4viXi9t9xW+QS9
tWe37ZBIF8LtT9l+kHzhXy26cShR4lKDhlGJn6/JEHf2ll6Ff+GfGu1Xejcy3Ilc
ArWRiPucmcX3BSoGGfZrCcfo1NY0yJVYgkG0VDUfq5fK9rV24RI=
=gJa2
-----END PGP SIGNATURE-----

--BKvuzQf+cgY3ntJe--
