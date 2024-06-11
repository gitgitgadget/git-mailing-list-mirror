Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D4E176AD4
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 11:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718107082; cv=none; b=IpF6+biVuOA/MhcdPHlgKR9AiFxTEYikhLtUg/tkBH4pw60TkwBMowKiRx47Xt9bfE8TLCUW/Y6hg8JzzXdc0gFKXfIYroaZoVLdAXHBf4jxiveUyuEVizgasKA/JQHKwiCP0tpai74V43F494yMOXP0xBYHnWd+ED/Em/rIo8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718107082; c=relaxed/simple;
	bh=jNxhppwAb4ukCYgtwHQNu7tENZrqBSSh1qfUX+BE/Ws=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s39/oqawqbOZKI5/15TYusXqkeand1gij13tDZEo8Yaksn0eEIrVsEb9VfRBRAqXj3KxAkk3Ge8bm6YjVHb5E7JJWn22+INhX0hM/CFTiRVL8+Mxt37/wu9S5Id+sNxHNS9K1/kEF5vqGLGKe2AsMl9uJxRY7L4ss1S+rwkbgCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GFjtQExl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lJmN6P5o; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GFjtQExl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lJmN6P5o"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id EDDD11C000E6
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 07:57:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 11 Jun 2024 07:58:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718107079; x=1718193479; bh=WwMKmrw7f4
	JbAabxAAcxMroJRqQq6X+TiBKVlVjASXY=; b=GFjtQExl5yFcVlFrpdWfv5Lmvp
	EL1OhMk986v72z+cA+E0fccH+FR7kCaEhIA+jcuz0W5NsnTjYrGq3hgZe/UEoGpD
	sfbxUGuQco1N+AtTfuTkzlOnwyVAnZ1wSyneyOmRSy22nhqJqkYNl7wdgs8YEm4c
	HXUKNNRDPBpfPT0KvZV5zNMEWj+BG8y8StfODkrYp0b2c9Sidyde88bpdarCK35q
	DUoT37XkulyOAJS0KOXaUVbsWFZITQ5sZFiW8vUADc0LKMRP8SVx9IGkPQMZjfk5
	8LEbk4RmcvVnwURodEzfJOHuGWyZX0FW+GEKr+i7QBlnldRBuvDa/7PNC5zQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718107079; x=1718193479; bh=WwMKmrw7f4JbAabxAAcxMroJRqQq
	6X+TiBKVlVjASXY=; b=lJmN6P5oUd6V0uvOuYNuzBpacS2ogpmgZNlQWedqHV3+
	rk6nu9AqCb5AJW0kay3pETzg1Q+M6LTPC92D7V7gJfIZQpM2EaStVVayZ3cpi3Mf
	GmDD3pAKVA3Wz20E25mptK43y5DBdRlIjnzq9X7pOgsiA9WCorbhlwRBsYQgTumG
	ovfUzjowfTS8XbHuGF+bqzNtU3hd1MNb3KM9dyVUV7b11DEwMqzFkjVb8YL3BcKL
	7ML0qlJySFWnhsZFTRSPdQYfDIQnuR/UFmLSlr/CyYn7RpTgcTy4bUSyVaeyKBBl
	VBBQow76ZVMRQxu8JEugsIFkAYAKN30WjiLYKO87+A==
X-ME-Sender: <xms:xztoZqtnheUZJyBJni4ZthXLDNkIBylH1GRIy_EnfV6LDATpY_AMeg>
    <xme:xztoZvfhirhL9K4thbbPLJ8gA13NiN7UvvdbquBXePpVnFtzjUT01RpkO-Pt6yg40
    REOOJwmPvAF-ISNJQ>
X-ME-Received: <xmr:xztoZlx4OtPZNP11subOy9l5ZQD_pS7F7vxou3a7eFwO6D0vXd9PPZ10ASbZmNBYSvMYyv83TG_Jl52_WKmjenEBfVjmP1jz6eSZzrG2T9f6qPASs-yP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:xztoZlNTu3na1-nimxtpk_iW-V_k9lx_oSbKM_OB-_CY9x_6CPCv8g>
    <xmx:xztoZq_QZih3nx5FQsK8nWe7le3zQipDRfP1XA_7uRxAtrV4AkA-Tw>
    <xmx:xztoZtWwfjcCj70_hVDalRj3T8s6nv8CbHVVz1DvNf_d73PwgWg-1Q>
    <xmx:xztoZjc6yqB8FyKQJ-OnOfz3BohiMjk4fifgCXDopN58PhoH2e16rw>
    <xmx:xztoZglWPL1fwyXpHJUZj7R3bvs2oMfhLYXRpglMUZJlQM9WtXSXAMvk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 11 Jun 2024 07:57:58 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id f1c7f4b7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 11 Jun 2024 11:57:49 +0000 (UTC)
Date: Tue, 11 Jun 2024 13:57:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 05/21] hash: convert `oidcmp()` and `oideq()` to compare
 whole hash
Message-ID: <e2a0f2125d4a4af84a71bab9f07050d37c4a40a4.1718106285.git.ps@pks.im>
References: <cover.1718106284.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6DfZaqcKn9whk32f"
Content-Disposition: inline
In-Reply-To: <cover.1718106284.git.ps@pks.im>


--6DfZaqcKn9whk32f
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
2.45.2.436.gcd77e87115.dirty


--6DfZaqcKn9whk32f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZoO8MACgkQVbJhu7ck
PpTtxg/+MOUWG2OIHFVX0shLjplm25vipmrwCiNYGKZJxiBpxWAehDgdyzOx2Vfx
rCX/TzZL9hqoh3Jc7WMGk5+w70JxImzmsQLbCs7/dF/XdWYzRv7DMk3+R/c9hbSM
GGTOsh/wFSJvg5uQR2clofG/bPe0WJ/N6tzXDzdguI29zVa4X4aNX0bQ0iIrDQqz
ePtEnLmvDnjBs34GhJK7mxJcXjUZywH+NaqOYlNrNR7JLqKII/LpehllRnACZ/SQ
uVn+gfHUg0efCWje3M4owyRUjZ3NfsJ8jh/ftARjmMY7tKLXKGQYTS7KkSXP+gIu
Pw8cLz4H2W1R8dFVBOQwrIRhPY+tHV9oOBjA1uGNniVY5vYZ0EsFzfrRvFNfn9K7
QCxfIajXVrPPS9jhqrzXRWnu1f1PCtAp9s1ReY/kZ2DlIoP9P87OlQyBTeE/Da/P
MQvSDplVAUba3s5ITZQFurjh7j07jnYPGlc3Ri/twdJi3Dyn/biC4zXc+AHRpR6h
RtzKAOITU4B/FxnHDMacqnVI5IKjF/1n+atAtlgkofR2b8U5sG9VvUuIe+dyDeK/
mtO2jAgqgelq5eKfnt+4fKHhsiniJe2TG8qj0B8AMh/67JfUDIi1I8gHeATK7xtl
P/fFTTmGTLIZR2OyjQRqzmzOIKgO/1hnzEbG6AsVa7CmLchFGTc=
=8Evt
-----END PGP SIGNATURE-----

--6DfZaqcKn9whk32f--
