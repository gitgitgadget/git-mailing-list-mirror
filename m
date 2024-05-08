Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5910F81AA2
	for <git@vger.kernel.org>; Wed,  8 May 2024 11:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715166256; cv=none; b=GEG3VTWQJKyCacESEJhzps/xLoyg8aw8NRoD6Vnj6ZzUmxcZSfGMER/7yswrOL0TF86QtN519FUUouYQFWTnett6g2yeJSHI6s7G7R/03WfEndmC6WfGgPsYjpqwAGGvGEEMbXZ0fmzdYsXL4LyBPbp8Btr6akdlZQd9b7Lksbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715166256; c=relaxed/simple;
	bh=Hj/FvAQEjG22vrfkhkPL7UWVT0GmZl/Y7aWOVXdUVpg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+vusPyXuOb/BtiS6s4FhCn/mqA4MHOzvcQt3GdFG843NAVKAzkrir8SzzRm2sdvsosMTip9lvmIpzF5DFCpEf+st7mgtLgEpisrBGusxSQt5dw2zbnSp4mgn6VW64E5M+K14iBlY3oUFz+9qsVaCdQTRL70ObDpWR/0eopXInk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VCQ4FDjt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SD0C9c5+; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VCQ4FDjt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SD0C9c5+"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 8DE8C1140224
	for <git@vger.kernel.org>; Wed,  8 May 2024 07:04:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 08 May 2024 07:04:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715166254; x=1715252654; bh=4zn2XNPS2x
	uTM/GvMgF+g18tLHkUJuVGA1XZwAFvQ0o=; b=VCQ4FDjt3YyE4HoKsZG8W6Bwd2
	8+8t1fO9WNpOWXpvEfdAnC0PIgQOkoKisogbme3Cm2Q0VhKncxPrpTbsCRIF+/qy
	wY8oonTXMf8F14mMUk6Z6hG5gdb4WxZOpr6HUPUfbKPqjEpyzzn3nOdhMHboNcMD
	J2OtfHTIQJWKY1ZvZGoJtVclHbLnTsd3XSacdtGUFT3pQvNkw1Z9GBJPh5NT0t8q
	Srno7qA6pvVz95siIlkn0NnbVECtShSmK761KBIRbqScJyxey4J87ShhZjT6hqE6
	c39Vld4SaN+3nMB2oae1yP7HIruI6Hft/Fj3FKkGfx1LRuCwt7gWrS5nlsOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715166254; x=1715252654; bh=4zn2XNPS2xuTM/GvMgF+g18tLHkU
	JuVGA1XZwAFvQ0o=; b=SD0C9c5+v2OtHdunZ127r106CLM7xL75ovZs1CBE7OzA
	0pnCQc1JA2G8MZcaS2yWLPkFcEqtw+aH/a+Mn4Y1aBGZlS4h6xv0/F+xIX7CxYK2
	dzmslT4FXdPzn3NfxR6hHQO8kapeniBWfTqJfpNABQgFacVvf+wlVMhIlwViABt4
	Dt8MFcLyDF3RhM+x9O6kSDkcEYgsv3CFk3sp8FbVMmteWsaNXnm00nYZwL/4xeqx
	VQsgoZyK1e1MdU83j0qJW8RZUFQ/hj98IDTNl0O2FsKK90umEipzFs1zcYs4/DXV
	yNqwk5N2EFwLcu6ZsSObu2EPc4FAHrq7Yc9I8km4GA==
X-ME-Sender: <xms:Llw7Zl95Yg5uLN0-0gPbnnrrXcl19Q70KjMuJgt4LjO7dQRZ7rYJWA>
    <xme:Llw7ZpsjgyZIzx2CF3rtvAOh2PzlwNOklZMLrgwbkr_tk6-vuhph-r5IRU5AnJoL9
    WfVpVkRR7E1uRnKqg>
X-ME-Received: <xmr:Llw7ZjDDF2yCRr8o8exIFKry2eq7aqJIadAvDyD4yk3S20JFtIhTYwvioSHEH_yKXybg6QNGtyo_ePO1PvUOkparj9xckaCbBw5HUCLgMJu2xn6KNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeftddgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepvdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:Llw7ZpennjSsfWLiz9O7XKTNR3lnPPDla-CBzidQDgS8YDsWjcrLtw>
    <xmx:Llw7ZqPJlp8L4uElG5gNXs8P_u0Wtarv_ZcWmm0okblji0ufANTaLQ>
    <xmx:Llw7ZrnohilLqQngvjvaNDhdM1sao5NJfkvNQ3UohBlcFvvEnTNAWQ>
    <xmx:Llw7ZkvesE62gKxyEU_2vigxoxbg8FeKc43QjUamrKDgWZvexyYbFQ>
    <xmx:Llw7Zs1utG-kq3aAGJYxi9FsoXZsRo7pOZ03PiqhxZnYChp_YUPO053L>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 8 May 2024 07:04:13 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id eda0b46c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 8 May 2024 11:04:03 +0000 (UTC)
Date: Wed, 8 May 2024 13:04:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 08/13] reftable/merged: simplify indices for subiterators
Message-ID: <f0f42cd56b9e54e9c7d58be41fcc4e226d5c76ff.1715166175.git.ps@pks.im>
References: <cover.1715166175.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u0AAM2/R0gVS/pwk"
Content-Disposition: inline
In-Reply-To: <cover.1715166175.git.ps@pks.im>


--u0AAM2/R0gVS/pwk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When seeking on a merged table, we perform the seek for each of the
subiterators. If the subiterator hasa the desired record we add it to
the priority queue, otherwise we skip it and don't add it to the stack
of subiterators hosted by the merged table.

The consequence of this is that the index of the subiterator in the
merged table does not necessarily correspond to the index of it in the
merged iterator. Next to being potentially confusing, it also means that
we won't easily be able to re-seek the merged iterator because we have
no clear connection between both of the data structures.

Refactor the code so that the index stays the same in both structures.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/merged.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/reftable/merged.c b/reftable/merged.c
index 4e1b78e93f..18a2a6f09b 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -37,6 +37,7 @@ static void merged_iter_init(struct merged_iter *mi,
 	mi->advance_index =3D -1;
 	mi->suppress_deletions =3D mt->suppress_deletions;
 	REFTABLE_CALLOC_ARRAY(mi->subiters, mt->stack_len);
+	mi->stack_len =3D mt->stack_len;
 }
=20
 static void merged_iter_close(void *p)
@@ -236,21 +237,19 @@ static int merged_table_seek_record(struct reftable_m=
erged_table *mt,
 	merged_iter_init(&merged, mt);
=20
 	for (size_t i =3D 0; i < mt->stack_len; i++) {
-		reftable_record_init(&merged.subiters[merged.stack_len].rec,
+		reftable_record_init(&merged.subiters[i].rec,
 				     reftable_record_type(rec));
=20
 		err =3D reftable_table_seek_record(&mt->stack[i],
-						 &merged.subiters[merged.stack_len].iter, rec);
+						 &merged.subiters[i].iter, rec);
 		if (err < 0)
 			goto out;
 		if (err > 0)
 			continue;
=20
-		err =3D merged_iter_advance_subiter(&merged, merged.stack_len);
+		err =3D merged_iter_advance_subiter(&merged, i);
 		if (err < 0)
 			goto out;
-
-		merged.stack_len++;
 	}
=20
 	p =3D reftable_malloc(sizeof(*p));
--=20
2.45.0


--u0AAM2/R0gVS/pwk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY7XCoACgkQVbJhu7ck
PpQvbg/9HEU8A24t9GwEp5lVJQAs17LPow8UXGLmqdTc1B+PLoG5Oj0Cykr/CMJi
Ji0Rl5BsCDR0qFIg39M1GDMd7IOlENNoF5e7wNY6mzeLHl/6Ye8lm4dh1w4a/HQA
c5Tx4b95Aq9RVXUNFhJJS0DiOTGpCxF0+gyekSB/A+cNYLguSjUCXKNEkir0iZiw
Cqxyc3hjwhZkyG/yGOsEIHldOGlUIJNU8YNZWT6LH8EYsyQ+l7Fdnb73DCrW7efx
uPvE+LeWbl8XiwXa0IpOXQLo4MEbmr5WqC32RaZCOt3jp9OH20OZmrlnDvgDqC66
JBa7VNchYSdktk6ueZnLBZER3Ikno2fliHaGdI6TW9PKN2cTpkLx1lfmMf0Cst9G
t8qi6KRURWlUUGXpjtulHjk2afy29aqoK44LVQfTleFp0Zk8LrZAHQDsgMKFO0tb
Do8/qSMjruRVaYWmpeD0U2UHxNZ58WysVjfrPCThrHZoge4NQ3A86l7ihfio4Bze
Lr07UWTrg6LPX5w/D2jRLbN8g+JLmoTzFvmZUIj8q7k9rGdnuBX6ihjUe8+POWdR
CisA+xMFZjLQYMwlEWoC7IpgGGRSoNKanZvwnCHWo7J/j9aMhmzXz2YtyNRdfv42
R4bZDvuDbJKn0KoRvTKBu/DFY7TMLxMKo+8ImJ7HHr7Nu1Y0k/o=
=cBsQ
-----END PGP SIGNATURE-----

--u0AAM2/R0gVS/pwk--
