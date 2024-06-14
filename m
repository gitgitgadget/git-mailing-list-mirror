Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12231482FD
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 06:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718347810; cv=none; b=kGBqaNef2/xePeE9WNtAXmLwfJYtzyyk5RVUIByYKecXaHsrUoLlG0jSIz3UseLZ63mJJ3Ye4NMf6CyehLIYofpwISxC31c32Cc7xyS6k5iWdMBv7/pSyiEgGfRZGWQI0LcUanH2sTrwQfL133rQ5bsr6RTE0UxnzExXJVGcy1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718347810; c=relaxed/simple;
	bh=VtczGtN6/+l8NmnMMUI1/Eu9izZOx3wcRhCRNqbZWbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ereiZhVj6hpUsbgsT0qypPRhzUYYVf3oJy6HwUNlCkWtVhOuWpgLnjNE6ScMEqKufuWG9Z8ZYFz6EE62Hpk7gCMgtnzSI7B8Ro/AmMHD9tVA8rwVbcaDZiQTRUniVcwHd2he5S8LHs5a3UI+EUxLW/jU7o3WAUO410kJMsghBF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VRpVQrEP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PpLlUTDZ; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VRpVQrEP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PpLlUTDZ"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id D52AB11400CD;
	Fri, 14 Jun 2024 02:50:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 14 Jun 2024 02:50:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718347807; x=1718434207; bh=lS7qF+/u2Q
	m2TZwpGi0bpT1vyoZKcLW8ISJ7HjmkY5U=; b=VRpVQrEPQePEPcmyibSwTYX2Pm
	CJxLPvyJGHKy1U2saG6gh+iOWFgPypZE6+ic+SSO6s4HQXmk7jhdfuiOSIvedxCV
	Qj/jOg5FXVjevlxSgERdrCDaBefhjTpCEsH2p16stkivCM80x1O86nTLObbWbLMp
	6yRbIyvh6FKpln8qtSw7kXKoTx+098eA+PqMiVRlbDbnDJliLR95jyJIDOuR+8KO
	XuB+U/JgTA7rVSSRbrwM8onn4JsA14SkJ0HphgYbeAWF6XBzJQGZ+uObyrQ8j2gc
	rrCUrJg+vL1T/yOBnzYC/BjVcAokne8Yi+zHPEFv1q1ks+W9opYqjUkjsLNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718347807; x=1718434207; bh=lS7qF+/u2Qm2TZwpGi0bpT1vyoZK
	cLW8ISJ7HjmkY5U=; b=PpLlUTDZKQzwUdSYtz3qhzgabSV9sHuhqqPXrm4OYH7V
	hgevBXXdOIymSOMy1O6Vi+wSeKxEAOBdm8d71/lT8KMJM9d4vizGXnGVYmGxUOZB
	JkJOmr0xOOLiqhTxBtItp05afP/tSgt/xLEqhS+sXR+B3RDKoICu5u2F3b8VGbnj
	3Q0tVnu+GZFbhUwczzAlLJIiaTV3MqUUHR2jEMPtLdFEXz+CJzR2fXgnK2S76vPo
	5HaRZtuekxz65rT8w84KMF37sFzsqHvAuKIa5+GRrdOsvz5lWdrdAEsIb9AJK13t
	K8tPi7rSKuTM4CDMeRw6cpmni5QHpCwzkni1W7cw4Q==
X-ME-Sender: <xms:H-hrZshJjfpSoQvE78Z5ubAPs46-giEEFD58wentw_uW1Ep5_HRhfQ>
    <xme:H-hrZlA2yFqcQER7fyU16mpbbm632GteR6Ppn3CvCAenIW3N7Q9-b2tb5Eg-UMOQ9
    LI1V3bmFuEof1YKew>
X-ME-Received: <xmr:H-hrZkFYK_EG_9yqf0a8CK3bvjCfLdYNuna5JyLPIvC7RdrGhLKNC7Zhrifat0IfwufgyhhdCW3emCuSJGiYiRzq7NS7UKDHygoH1ka4wtX6vw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedukedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:H-hrZtRljp_jxcOLUybX8PYlzLryJNgPxYCZMV6dteIKtNsRo3440g>
    <xmx:H-hrZpyX0dJqnnHvtOqdAKxWMZGuWXDT-C5I6HSpMNV7XCf4YqxHwg>
    <xmx:H-hrZr5RKp5t0_IwzMqYTpYNFk_FtxwWOq4lQJKFzPIPujtcU0OASA>
    <xmx:H-hrZmwTO--dOmqZc-ECnL0SZHy7K2V5ibplJb1-JBRTcO1_ZPUN8g>
    <xmx:H-hrZsou9dwsUaEW2ZCRPeFGyfxaWgb0BudMlW7YWG2BgsLccSSs7c4m>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Jun 2024 02:50:06 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 3f1f0e28 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 14 Jun 2024 06:49:51 +0000 (UTC)
Date: Fri, 14 Jun 2024 08:50:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 05/20] hash: convert `oidcmp()` and `oideq()` to compare
 whole hash
Message-ID: <91eb94bc0b91c8d1bda7f8fd776d94113acf8cd3.1718347699.git.ps@pks.im>
References: <cover.1718106284.git.ps@pks.im>
 <cover.1718347699.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7eKggVyc2lPvektV"
Content-Disposition: inline
In-Reply-To: <cover.1718347699.git.ps@pks.im>


--7eKggVyc2lPvektV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

With the preceding commit, the hash array of object IDs is now fully
zero-padded even when the hash algorithm's output is smaller than the
array length. With that, we can now adapt both `oidcmp()` and `oideq()`
to unconditionally memcmp(3P) the whole array instead of depending on
the hash size.

While it may feel inefficient to compare unused bytes for e.g. SHA-1, in
practice the compiler should now be able to produce code that is better
optimized both because we have no branch anymore, but also because the
size to compare is now known at compile time. Goldbolt spits out the
following assembly on an x86_64 platform with GCC 14.1 for the old and
new implementations of `oidcmp()`:

    oidcmp_old:
            movsx   rax, DWORD PTR [rdi+32]
            test    eax, eax
            jne     .L2
            mov     rax, QWORD PTR the_repository[rip]
            cmp     QWORD PTR [rax+16], 32
            je      .L6
    .L4:
            mov     edx, 20
            jmp     memcmp
    .L2:
            lea     rdx, [rax+rax*2]
            lea     rax, [rax+rdx*4]
            lea     rax, hash_algos[0+rax*8]
            cmp     QWORD PTR [rax+16], 32
            jne     .L4
    .L6:
            mov     edx, 32
            jmp     memcmp

    oidcmp_new:
            mov     edx, 32
            jmp     memcmp

The new implementation gets ridi of all the branches and effectively
only ends setting up `edx` for `memcmp()` and then calling it.

And for `oideq()`:

    oideq_old:
            movsx   rcx, DWORD PTR [rdi+32]
            mov     rax, rdi
            mov     rdx, rsi
            test    ecx, ecx
            jne     .L2
            mov     rcx, QWORD PTR the_repository[rip]
            cmp     QWORD PTR [rcx+16], 32
            mov     rcx, QWORD PTR [rax]
            je      .L12
    .L4:
            mov     rsi, QWORD PTR [rax+8]
            xor     rcx, QWORD PTR [rdx]
            xor     rsi, QWORD PTR [rdx+8]
            or      rcx, rsi
            je      .L13
    .L8:
            mov     eax, 1
            test    eax, eax
            sete    al
            movzx   eax, al
            ret
    .L2:
            lea     rsi, [rcx+rcx*2]
            lea     rcx, [rcx+rsi*4]
            lea     rcx, hash_algos[0+rcx*8]
            cmp     QWORD PTR [rcx+16], 32
            mov     rcx, QWORD PTR [rax]
            jne     .L4
    .L12:
            mov     rsi, QWORD PTR [rax+8]
            xor     rcx, QWORD PTR [rdx]
            xor     rsi, QWORD PTR [rdx+8]
            or      rcx, rsi
            jne     .L8
            mov     rcx, QWORD PTR [rax+16]
            mov     rax, QWORD PTR [rax+24]
            xor     rcx, QWORD PTR [rdx+16]
            xor     rax, QWORD PTR [rdx+24]
            or      rcx, rax
            jne     .L8
            xor     eax, eax
    .L14:
            test    eax, eax
            sete    al
            movzx   eax, al
            ret
    .L13:
            mov     edi, DWORD PTR [rdx+16]
            cmp     DWORD PTR [rax+16], edi
            jne     .L8
            xor     eax, eax
            jmp     .L14

    oideq_new:
            mov     rax, QWORD PTR [rdi]
            mov     rdx, QWORD PTR [rdi+8]
            xor     rax, QWORD PTR [rsi]
            xor     rdx, QWORD PTR [rsi+8]
            or      rax, rdx
            je      .L5
    .L2:
            mov     eax, 1
            xor     eax, 1
            ret
    .L5:
            mov     rax, QWORD PTR [rdi+16]
            mov     rdx, QWORD PTR [rdi+24]
            xor     rax, QWORD PTR [rsi+16]
            xor     rdx, QWORD PTR [rsi+24]
            or      rax, rdx
            jne     .L2
            xor     eax, eax
            xor     eax, 1
            ret

Interestingly, the compiler decides to split the comparisons into two so
that it first compares the lower half of the object ID for equality and
then the upper half. If the first check shows a difference, then we
wouldn't even end up comparing the second half.

In both cases, the new generated code is significantly shorter and has
way less branches. While I didn't benchmark the change, I'd be surprised
if the new code was slower.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 hash-ll.h | 10 ++++++++++
 hash.h    | 20 --------------------
 2 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/hash-ll.h b/hash-ll.h
index b72f84f4ae..b04fe12aef 100644
--- a/hash-ll.h
+++ b/hash-ll.h
@@ -278,6 +278,16 @@ static inline void hashclr(unsigned char *hash, const =
struct git_hash_algo *algo
 	memset(hash, 0, algop->rawsz);
 }
=20
+static inline int oidcmp(const struct object_id *oid1, const struct object=
_id *oid2)
+{
+	return memcmp(oid1->hash, oid2->hash, GIT_MAX_RAWSZ);
+}
+
+static inline int oideq(const struct object_id *oid1, const struct object_=
id *oid2)
+{
+	return !memcmp(oid1->hash, oid2->hash, GIT_MAX_RAWSZ);
+}
+
 static inline void oidcpy(struct object_id *dst, const struct object_id *s=
rc)
 {
 	memcpy(dst->hash, src->hash, GIT_MAX_RAWSZ);
diff --git a/hash.h b/hash.h
index e43e3d8b5a..ddc2e5ca47 100644
--- a/hash.h
+++ b/hash.h
@@ -6,26 +6,6 @@
=20
 #define the_hash_algo the_repository->hash_algo
=20
-static inline int oidcmp(const struct object_id *oid1, const struct object=
_id *oid2)
-{
-	const struct git_hash_algo *algop;
-	if (!oid1->algo)
-		algop =3D the_hash_algo;
-	else
-		algop =3D &hash_algos[oid1->algo];
-	return hashcmp(oid1->hash, oid2->hash, algop);
-}
-
-static inline int oideq(const struct object_id *oid1, const struct object_=
id *oid2)
-{
-	const struct git_hash_algo *algop;
-	if (!oid1->algo)
-		algop =3D the_hash_algo;
-	else
-		algop =3D &hash_algos[oid1->algo];
-	return hasheq(oid1->hash, oid2->hash, algop);
-}
-
 static inline int is_null_oid(const struct object_id *oid)
 {
 	return oideq(oid, null_oid());
--=20
2.45.2.457.g8d94cfb545.dirty


--7eKggVyc2lPvektV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZr6BoACgkQVbJhu7ck
PpRGHA/+PgRhmzkMkP7MohDSm1aBOoWWsRInJaWhEjADGQeSqofvitgQIm0TMcA2
PCNIQDFaSxYOs3Xf/WzqSDIegRl8cNjbXhRLI+Ks0zmyRG0/0c57G2qebGTcQReB
CoizZq7mXb/hM80olxp7MoEhAf9CxzHzD0ZG7gP5PWwIflB2aPHY02In9JIFP9vf
EF7Goolephukw27YQWUP09OQv6dIAUdzMPf3pmLhi+mbxXw6zvizN9/jKHPY25kD
ymyPBGWhUZoAjawakxRo8uSkLA8WUVI3QnARUH3m4A4dTklqfeTIK3uFaXQwzLmE
YcIFHUnJoSLjBryZrqrqi2t6opN1B4gelMb3gJQ+iN4Yilowy6VC1NRh2oBcvpp5
Rcm8jGfeVdCi35IGg2y4rcIqUWTfkvMDJPffJ9nFeBEQD+UBY/2VSfGmIqEURHgS
DHa4wwqGUQt5kYSksgzNFxdbj6w4WY8uO1tUmsJBBeaEK5Q0sFzyxNLjEa/3kIY8
4wLnGRe/Zpe9gPJskPdlzBPZDeCdu/J2QQpTZqwO5VMKKpSTkoweApYZaZSCNXcr
ZON13uR39pMwsq2xab9gq58CdBTqXhOkMJtxQxFhR2eNr0n/YN9Nkmj+/ljHJHGd
V8+XIiUHl2yjxQWRRcLkQkUxcZTjNVdmLI31su7OmS5l1rg5eTQ=
=ImNT
-----END PGP SIGNATURE-----

--7eKggVyc2lPvektV--
