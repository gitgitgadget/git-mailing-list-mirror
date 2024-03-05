Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3344F5A781
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 12:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709640668; cv=none; b=Zws0Rv0ZHC37SNoNSf1OJjgM1vLIHiWBKtzwz1H5ASEMkXrUFlPE+QAVRw0HlDUeXiZJF6ybzHI1dSxzlHw7kON7J8o0Np5pvaty07YPcnqpy+XKGomk8TjY1ztiKhq+YWbzDakb6tOElXQ+T6z/JGgJGnNW4jYzyu4oRlCUqvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709640668; c=relaxed/simple;
	bh=2KQTFci23etIiorA6C0VaOj82wRREIt3xolbjlNXGsU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S5kw84csCQuCTtqjYDlxLO64VM29Q5c+fPVr/i4K3KzLmMP+swShn6bT+HXx+4anwh6EFyEbuUH4163yl/poHDRg4A+y15W07sgUGfKHeDvrtHGzUoHxwRQHiuKPVolMyc6Ql/mPNAGqhj+K7xDBDH1O9HYVvLobIe94naFc0tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mwa7bNvX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BMXFWWy8; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mwa7bNvX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BMXFWWy8"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 3AF3A13800DB
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 07:11:06 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 05 Mar 2024 07:11:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709640666; x=1709727066; bh=ddErPJCZml
	sSCT8WVtcg8fmBw7p0wQpyosY9m8pNe5M=; b=mwa7bNvXELiViyYIhsIfZuAWzJ
	t8Xx/4ONvw0fD1Y3w/9jeTqKtcPn+VeoTAYD2xbX2hxxVYOwHHvt5Cj0T2/Zlk1F
	zvgMcB3w8cOhK7XONDj/ubxw0JL9thnmimLySYS3AiJL2m7k2jgKZJqCUuHGYe+t
	BEiT4Se2GXqr14RjleEnyQpCEUSbDVtO7INZJPbv1RXz5S2WHbRwWJw0gLfOH477
	BTS+JBdxaPJEmQnzu9u/THGy2DTDpSsamCbNSrEse8Q/gfo13iD5cJc1ahrIS45N
	YxsCtH+swRYgUrjiUCb8y+wsJ+VJqOqVTX7eFcMhlkbg1KH9gbdp00EVvQYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709640666; x=1709727066; bh=ddErPJCZmlsSCT8WVtcg8fmBw7p0
	wQpyosY9m8pNe5M=; b=BMXFWWy8VimwuZrFbyXlvvZtJq0B6eglVnEzG7XBE4PF
	mOEkK25AtxHLY/ywiZo2nQ8917mv5wtXRdQnkiohV3q6IxJ6bVsk16/0iYBa/SrW
	/J+l2gp4TrQDcy4DRtrrWwoV2qkjm6MX3shEqg96Jbmsf5s6vOsQZ3gRvd7ub1KY
	FcITwvSIfTNwRq/N0JKmsSIcGajXZUdAk3GbSHyi1bYnx4JwwdC4YHUEqCGSSiiq
	dLeUU4yXVsX8BIOlL26RwzmvrQPeytlSHn7QI/lj3ZwO1sXBuT7dza82QlCqfyCh
	i8czh2OjpKd/Uds+QzZyOePk27Ce96uboLI+/tYOOQ==
X-ME-Sender: <xms:2gvnZZ8m18s9phulzJcCLU5Ba6ZbUPdXvpi8d1S-fNSdRqBpXTWduw>
    <xme:2gvnZdtn2NsPCJlU-VaArO3p76WecliySoFe4vvyJ7NxWDCO850RzAzVYq_WUZEhP
    z_s2spUrJT0EdtJeA>
X-ME-Received: <xmr:2gvnZXBSt6d55OyiFU4VK2uJ3PDKvPGVXkQUCraGh4KQCH8qKDsyONHhrJJATWrHOeyU7g5bgyMnVuES47fjHqR86gvFcVxsoBNm0ndsNdAAuYk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheelgdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeeludejiedvjeetkeetleetfeeihfduueffge
    duvdekfeduleeltdegfffhhffhkeenucffohhmrghinhepuhhpuggrthgvrdhnrghmvgdp
    uhhpuggrthgvrdgvmhgrihhlnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:2gvnZdclQoF_E35lhejJOp_UMTU0ZvyHw5preYyZS4CRhq8SGeEiCA>
    <xmx:2gvnZeMKoQc7BgVC42oPrf0BxUxqwgseP8gGb1ItsLRxi7c3fn_EPA>
    <xmx:2gvnZfkwhFODCNqSK9YZAVIR0AwZ3T2vlVn8b-AMljIFyzHk-1Jniw>
    <xmx:2gvnZQ11cdsCK8sZ1VwWNFXdrS5Ew2sMk9VFliSzD2kCCmPWCnnJiQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 5 Mar 2024 07:11:05 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5a211355 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 5 Mar 2024 12:06:38 +0000 (UTC)
Date: Tue, 5 Mar 2024 13:11:03 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 3/7] reftable/record: avoid copying author info
Message-ID: <6f568e4ccb67a7af8279352153d052c5f9a88234.1709640322.git.ps@pks.im>
References: <cover.1709640322.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WzAeIK+RG8Muallb"
Content-Disposition: inline
In-Reply-To: <cover.1709640322.git.ps@pks.im>


--WzAeIK+RG8Muallb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Each reflog entry contains information regarding the authorship of who
has made the change. This authorship information is not the same as that
of any of the commits that the reflog entry references, but instead
corresponds to the local user that has executed the command. Thus, it is
almost always the case that all reflog entries have the same author.

We can make use of this fact when decoding reftable records: instead of
freeing and then reallocating the authorship information of log records,
we can special-case when the next record during an iteration has the
exact same authorship as the preceding record. If so, then there is no
need to reallocate the respective fields.

This change results in two allocations less per log record that we're
iterating over in the most common case. Before:

    HEAP SUMMARY:
        in use at exit: 13,473 bytes in 122 blocks
      total heap usage: 6,068,489 allocs, 6,068,367 frees, 361,011,822 byte=
s allocated

After:

    HEAP SUMMARY:
        in use at exit: 13,473 bytes in 122 blocks
      total heap usage: 4,068,487 allocs, 4,068,365 frees, 332,011,793 byte=
s allocated

An alternative would be to store the capacity of both name and email and
then use `REFTABLE_ALLOC_GROW()` to conditionally reallocate the array.
But reftable records are copied around quite a lot, and thus we need to
be a bit mindful of the overall record size. Furthermore, a memory
comparison should also be more efficient than having to copy over memory
even if we wouldn't have to allocate a new array every time.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/record.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/reftable/record.c b/reftable/record.c
index 8d2cd6b081..d816de6d93 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -896,10 +896,19 @@ static int reftable_log_record_decode(void *rec, stru=
ct strbuf key,
 		goto done;
 	string_view_consume(&in, n);
=20
-	r->value.update.name =3D
-		reftable_realloc(r->value.update.name, dest.len + 1);
-	memcpy(r->value.update.name, dest.buf, dest.len);
-	r->value.update.name[dest.len] =3D 0;
+	/*
+	 * In almost all cases we can expect the reflog name to not change for
+	 * reflog entries as they are tied to the local identity, not to the
+	 * target commits. As an optimization for this common case we can thus
+	 * skip copying over the name in case it's accurate already.
+	 */
+	if (!r->value.update.name ||
+	    strcmp(r->value.update.name, dest.buf)) {
+		r->value.update.name =3D
+			reftable_realloc(r->value.update.name, dest.len + 1);
+		memcpy(r->value.update.name, dest.buf, dest.len);
+		r->value.update.name[dest.len] =3D 0;
+	}
=20
 	strbuf_reset(&dest);
 	n =3D decode_string(&dest, in);
@@ -907,10 +916,14 @@ static int reftable_log_record_decode(void *rec, stru=
ct strbuf key,
 		goto done;
 	string_view_consume(&in, n);
=20
-	r->value.update.email =3D
-		reftable_realloc(r->value.update.email, dest.len + 1);
-	memcpy(r->value.update.email, dest.buf, dest.len);
-	r->value.update.email[dest.len] =3D 0;
+	/* Same as above, but for the reflog email. */
+	if (!r->value.update.email ||
+	    strcmp(r->value.update.email, dest.buf)) {
+		r->value.update.email =3D
+			reftable_realloc(r->value.update.email, dest.len + 1);
+		memcpy(r->value.update.email, dest.buf, dest.len);
+		r->value.update.email[dest.len] =3D 0;
+	}
=20
 	ts =3D 0;
 	n =3D get_var_int(&ts, &in);
--=20
2.44.0


--WzAeIK+RG8Muallb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXnC9YACgkQVbJhu7ck
PpQxig//blu7+HcGGmmGjNGxo+gP9b4TBdNMKnxIJlTp7+mJAkHiMmGqAx+oQPOJ
eI/HCmMFUGdIDUf75OrSH8BVnEApmi3ULiWP9i06SxgUsF6w5t3iKiUitqn8spYs
nk1Ubzm+/7bxU4LPbGPsMHtt4i+LeXAG9fv5xVM6N+2XSqJo+hnPykn37fSeEMxL
1eWFJa89/AratF+WO2FSX3uD3y6rI+4lvnixFjoyxB6rvPR9kbrc765lckDe/AG8
nTz1/CJWWHHSNNCl6p+CKZI/n3iFz4b2AwO9NSZicvZzqeqOzAXMu59BQklo0esN
2s4GeiKUB/B7rEdPvZ5iw0yT7Vl4ckwfzeyny2KAHK39WC4ZhAGiilVdCDJQfvbI
aMb58kJ3s9V00Lxr3K98xqg/sRg8v+7lhNWW1/pulxvJRxDBtSmzUgJN0lN1TEZO
/FWOYTgOAYBqoW9W5kTzRzQTeL+6doMnNh/jXr9Txweibk3pTp3AHC7YCXtKjVXw
hZ2lJNvJkoF5c+2FFXWYNNr6JflHiHz58qNJkaxCzja1YqnL6NUe0h7LLyFo+Mew
4XDbEsxoE+xuywpYMBrJws56gWxFrjtuJ/gc0zQRb8HsUMPUNIOQqy7Kp6mtQfub
kG4Uw77JPcsYl183e/R5XtmI4XhzR/rsEF3J6/dMSE4swj3pqi8=
=ZS7y
-----END PGP SIGNATURE-----

--WzAeIK+RG8Muallb--
