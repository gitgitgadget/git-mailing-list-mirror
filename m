Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F47136E12
	for <git@vger.kernel.org>; Thu, 13 Jun 2024 06:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718259231; cv=none; b=FdN6C2A8abqNhPanvrw4pK/hQyob0PIs1vUTMNiT5SjrNhpVmWT82+q4mR8NjhDWbg2vKMOAPJ8CgMPlQo5BnZJXcDy7uzPqOgk7TBn6XGrAePSxra2zjZkhuzQlpHsaXl8eMcs9kL0iIHy7olNZ3jy50gBjDJGNHgkO5rWq9tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718259231; c=relaxed/simple;
	bh=gTPA9JiyE3U/cxgV4sOSEYv845aZpNr9nC9V6RpMEzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QIQRnQr/UNhqNq4ZlisA/0bAjOUDR74ujVtDZF1oRBbi1WNmXvBJi+iMg7g2HLt5A6eJl4gO/9xkmXx0gjjWGixmX9fj5XsWLSUXRwfQ9jevTAM4WTYDCeERJ41AqPm7K7sLIx9w1Fy6mS+eNaxv2/v9gS0WJBEHfiOtUDaxf0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aesweUTq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nmKZ48h7; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aesweUTq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nmKZ48h7"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 559591C000D7;
	Thu, 13 Jun 2024 02:13:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 13 Jun 2024 02:13:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718259228; x=1718345628; bh=3EE8yWZlwL
	g2Vb4rsThBPIdww8jSfPh7St31LlIFGuQ=; b=aesweUTq/Cr7Rl6vzzOzzFP+JD
	5HF/qaxyMdGa2yI/iilXWmoBBcdGwtgGF1jURDJFaYTYPr+cWGqRTj4NaIYXlgGa
	Lq4yYgYkiT+XzDyXWuwMWrdvThjwDbZbOzKLVjxD80wiaAzCisf+jHi52DX0FxI5
	ZuNYOM3XNQJCkCJvsXpTT+lUqsXYxqr8j4z2uagSMlVeNsuXuerOjwqg2Bm2fWPh
	DUbkTqC/zI2ycpHJoxUJz8XmBHfL6RRSX6ccYJcGCHc2Eokhvh47LORxt/7Cfa4M
	ITF9dIjme+WftHxsRFdAcvxAXAFKwzms2KlqHZ8SUZm3FrKeKxyEBeMwrUNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718259228; x=1718345628; bh=3EE8yWZlwLg2Vb4rsThBPIdww8jS
	fPh7St31LlIFGuQ=; b=nmKZ48h7IJfc3+eO+pE5A3t9PDSuiCJPyI/SdG4EAJ/7
	348qpH+zXDFp6P5gB5YoXfXmLOB/fLxx7oC0anKkGGypOaE/11nBu1ZrCRFxCDJn
	tvhQdEo4DHRdPu7xaG65q+csZa5QVB4UOFCYWqygfXEPEGTwNITG3Q7t9hIH0wlb
	q5zTmW/RxtMiqk44vHaZsegGZvEh46o6Kz4cbjNOJbGSxMaaxW/13nlm5Zp2PBOS
	k1g6swLsGQoiR44dMM4lMa3eU1SwGxwQdw3P7RYomkIz2VgcTia/1TbJAoZVUyfn
	HVCHvx5LDyAXE9jxNI7G+KDGvKKe4okcP4Mh3azAxg==
X-ME-Sender: <xms:HI5qZpZB63XjHO32TwY0e8kX7TOLMddYggLoK-LYPBMC7oor26awKQ>
    <xme:HI5qZgbNVWTtrKomXk9H8XK6uQsdTLVYN5cATmaVIYve43jn7hZcOpIsE1a2ECWDa
    VJew0HLt2nI5zdn8Q>
X-ME-Received: <xmr:HI5qZr8HpPtZL522BfcbQjq3JJmkdtdJhb-sduTc6-c57CUXzz5hJyhVxppjlEqx3tn4oFPzrEy4ArO422RhYvoKCCHxGDK6jjIN-v82GQ-q0kJZU4s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduiedgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:HI5qZnpSxI6tH5z-1mMd-zrkxkcHwCCv2OPXBMQ2jgPLfV0Ui_XBGQ>
    <xmx:HI5qZkp-bDz809Ncf_RdMapss5zVqLo1HDwjImJSXlpSsv4JYJfLGA>
    <xmx:HI5qZtTdxkzPLeiwJQqCh5KmAWA7jIVFkpbS43BImdjnQmPRkGrg2w>
    <xmx:HI5qZsp8BiYw0IrWfkAtKF01ayYtZ_z1tqEPjMUiXQP-MRJWTdd9NA>
    <xmx:HI5qZvWptQogM1b3O3MBl2UB5EI0RnBZdlm_VZM3jiVKqD5p3Ksj7cRN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jun 2024 02:13:47 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id ac49cc45 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 13 Jun 2024 06:13:35 +0000 (UTC)
Date: Thu, 13 Jun 2024 08:13:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 05/20] hash: convert `oidcmp()` and `oideq()` to compare
 whole hash
Message-ID: <a7df209bda9bacf3dc88c8a021f9162069f78867.1718259125.git.ps@pks.im>
References: <cover.1718106284.git.ps@pks.im>
 <cover.1718259125.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5qoqQe/FTVFNGhbc"
Content-Disposition: inline
In-Reply-To: <cover.1718259125.git.ps@pks.im>


--5qoqQe/FTVFNGhbc
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


--5qoqQe/FTVFNGhbc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZqjhgACgkQVbJhu7ck
PpQ6Lg/7BsOb0nM7LQDpEXAYDFrdJhQwCqmnVIIglJBfr2yOCANeqnpPx8UXVVqX
QxPzwNoDsoy3kLHE1RaynxaYC9uWSStcn4DunOZrfX4vCwzNozVDb2JgxJHD6fbs
p1ETx2312lZzPrPfqPMOFDyyoAyV2qXZkI2bDFuq/EcCatMvChnw4fKttH976Jrk
O/XtuJp6JOHDWMUs2MSM4tnc9w0qZXTTAWlUqesEtSN/tbII9cPeN44bDmKqNLrr
f1ofzlCrnhMVT6quWQWR7cz+Ji6a/IBcB35VaUC7edTGRafpCtpzsjJe5l8RXHX7
PgNMvvUKgldxQd3znzu70rDHcp2aKnQmIZQNy6tVJ0rkwS4L3VMRTsJ677c08874
b0WdbgcAba1eeBE/uIlXPNJXIMVTLWPFl5T+YYItR21KhF3h9ft9skpZklAP4BQ2
UttonyhlwBvc6UH+nQqrqVwtYNWB+plL3upxgm5MMrKKZUI3/ygHH77tSARG8T66
4TPR7Wav+R62rUcbM0iZCUTiI8nUOJxu1yoxiHRx7Wxx19bhhHwowEYMu/ZZLY9R
/K/mpak7jpRGVlcvvIpU3njwXoo61ptDAcBg3eLzlMjD534Brvs7WyMxz9lv8eKC
wn6i8FJFmvCxKSo7RUh4LQq9ZVF02qgZ0KNENH2FGYKrEzxUBe0=
=q1gC
-----END PGP SIGNATURE-----

--5qoqQe/FTVFNGhbc--
