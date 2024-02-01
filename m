Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1586C158D9D
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 07:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706772788; cv=none; b=bBSGkqY5QFq8+IEMorkTVuPVXcNDKyZL0CjCEA/V0JzKlT64O3GMuwrfJiYwoyZGSKeRKjOOOzlTSrmdxeK/2BpAPsV+Wlalm5tgQc+Uy3ph9F+oxc/bwHpupGRc2a1lrH5zqjiOvpT35RCAUpzIn2ITsfSG2opaFbwocGAv4Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706772788; c=relaxed/simple;
	bh=3eBTWL+UOwZNVKCwAJiHZydd9vY+oVSJ1xcN0z/bTdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oGs6fEUhwAx4ZmEAtm4aiPQxXNFOJ5oRyxP6fj8mjk9TTgFzb/+l7LM56RsUO1fpPsSASUFDUQmuf7hjU3ohVYtM7Oeu0HmpOjo0oUO7v3L/JMHo9gs1Qj6agtUsVGjrgkX9oNrcz+1MEzVzLQ7KaXIzy8M/lWCKBpggdnU1DSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HM8Yth8a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DiAOVJt4; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HM8Yth8a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DiAOVJt4"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id 22C653200AF0;
	Thu,  1 Feb 2024 02:33:06 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 01 Feb 2024 02:33:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706772785; x=1706859185; bh=txa/XPJlhl
	FGVcKVuBWCooph8usBSwB9ODxCKkwx9fs=; b=HM8Yth8aA9uMio1CjKb4hDKK6V
	1LCO5Z7vsw4PTpaKg4KI0bsvfA5XAA1nWP7nuPfr5j/Rhim5jP+K2mJsbnzouXee
	Ptd5mZgICqf8n51rqIyuEPn18gw3BmO7cMgF74Sbv4cmQzxX2OX5KkEPsIKEI4GV
	AmxA5GCcF1B8nQRg2986zxDeAsJOoeBtl0R4dRTmks60uQfOXSqT5xKC/YJpHhj7
	/S8M0U1PhtSmS8X8u3EzGjf7u8d3SprxuEmHoHMLf6E5yg6lGdkEI5zsSnZrw7lu
	ndDPZKBllgfQuGHClfJcFDPU9L9fWdl2a1fU1C32jQt6GB8fB9byOieZxDNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706772785; x=1706859185; bh=txa/XPJlhlFGVcKVuBWCooph8usB
	SwB9ODxCKkwx9fs=; b=DiAOVJt4B+AKf4eMlQ2S5mh2eTawD4JIoekqauwDzg1U
	oGoLwGPeabOlDB/g5jOn8LkX+TM+sYF8KQo0Mbd71IhEj/k8uS57RgqxznHBAzs2
	xvnWbT+VUwYHzhHREyMhtTSen3taAB6IEmky/eVYWYkw64JMt227itxgmAB9ExP8
	ZSIGHuxpIJbtt9JnCDZ8Qj/BoXGlrqFwqm+CwlP6x+Xoye2hIQfC3EQJyoUwTxvv
	ZJWMJFXAmsoUBB4UWSknHXXE+j+b9PoCzjUDLXaMpk4m+3s1vUm1O7QSNYf2pMxV
	ZWESq1PoNrRjbMD846HO0GBf99DrL6AcRdyaMXfJcQ==
X-ME-Sender: <xms:MUm7ZXKGOXjuw0fhoqEMmxJGUHJj8Lu2nGmAraCCKPlXtBAd8U8T2Q>
    <xme:MUm7ZbLGVvRyEqgJnKQlJVboxvPfTRXh6Zr2GaQC-MdtEbIMmsKDQEeXp2Q7ll0ia
    bUCQ5-Fatvu1SB1Zg>
X-ME-Received: <xmr:MUm7Zfvd7n5ug7h_pLfAvHlnwS2bFwuzuipyTjXCZPSnWScbeaD7OJWhgOd0QcS-1eAMvyW9IzxfDbCSwFILFHbQvvrACqnaOemD2QoqIZijXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedutddguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:MUm7ZQZyazm4lefqzsAzAaImJpJoawHLWMf8pgPXo5UrQAMopqKx9A>
    <xmx:MUm7Zea0_Igf6_lvJs2mftwLcYyrNvcTnnZXeUAiU9BHdwBlzpIXHw>
    <xmx:MUm7ZUBGDhdQAqM-2q8kiZGru33rsbQMmNf3RdSikUCfV_miqwfyBg>
    <xmx:MUm7Zdk491g8glydmcRUYGZAHNIWw4LtjIWZY-CE48AWsSctxlWosg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Feb 2024 02:33:04 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ab6d49e6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Feb 2024 07:29:42 +0000 (UTC)
Date: Thu, 1 Feb 2024 08:33:02 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/9] reftable/stack: fix parameter validation when
 compacting range
Message-ID: <f134702dc5f656942baafbd80af46ad928ee1449.1706772591.git.ps@pks.im>
References: <cover.1706687982.git.ps@pks.im>
 <cover.1706772591.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3z8pYcwv/VWMCR4E"
Content-Disposition: inline
In-Reply-To: <cover.1706772591.git.ps@pks.im>


--3z8pYcwv/VWMCR4E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `stack_compact_range()` function receives a "first" and "last" index
that indicates which tables of the reftable stack should be compacted.
Naturally, "first" must be smaller than "last" in order to identify a
proper range of tables to compress, which we indeed also assert in the
function. But the validations happens after we have already allocated
arrays with a size of `last - first + 1`, leading to an underflow and
thus an invalid allocation size.

Fix this by reordering the array allocations to happen after we have
validated parameters. While at it, convert the array allocations to use
the newly introduced macros.

Note that the relevant variables pointing into arrays should also be
converted to use `size_t` instead of `int`. This is left for a later
commit in this series.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index d084823a92..b6b24c90bf 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -966,6 +966,7 @@ static int stack_write_compact(struct reftable_stack *s=
t,
 static int stack_compact_range(struct reftable_stack *st, int first, int l=
ast,
 			       struct reftable_log_expiry_config *expiry)
 {
+	char **delete_on_success =3D NULL, **subtable_locks =3D NULL, **listp =3D=
 NULL;
 	struct strbuf temp_tab_file_name =3D STRBUF_INIT;
 	struct strbuf new_table_name =3D STRBUF_INIT;
 	struct strbuf lock_file_name =3D STRBUF_INIT;
@@ -974,12 +975,7 @@ static int stack_compact_range(struct reftable_stack *=
st, int first, int last,
 	int err =3D 0;
 	int have_lock =3D 0;
 	int lock_file_fd =3D -1;
-	int compact_count =3D last - first + 1;
-	char **listp =3D NULL;
-	char **delete_on_success =3D
-		reftable_calloc(compact_count + 1, sizeof(*delete_on_success));
-	char **subtable_locks =3D
-		reftable_calloc(compact_count + 1, sizeof(*subtable_locks));
+	int compact_count;
 	int i =3D 0;
 	int j =3D 0;
 	int is_empty_table =3D 0;
@@ -989,6 +985,10 @@ static int stack_compact_range(struct reftable_stack *=
st, int first, int last,
 		goto done;
 	}
=20
+	compact_count =3D last - first + 1;
+	REFTABLE_CALLOC_ARRAY(delete_on_success, compact_count + 1);
+	REFTABLE_CALLOC_ARRAY(subtable_locks, compact_count + 1);
+
 	st->stats.attempts++;
=20
 	strbuf_reset(&lock_file_name);
@@ -1146,12 +1146,14 @@ static int stack_compact_range(struct reftable_stac=
k *st, int first, int last,
 done:
 	free_names(delete_on_success);
=20
-	listp =3D subtable_locks;
-	while (*listp) {
-		unlink(*listp);
-		listp++;
+	if (subtable_locks) {
+		listp =3D subtable_locks;
+		while (*listp) {
+			unlink(*listp);
+			listp++;
+		}
+		free_names(subtable_locks);
 	}
-	free_names(subtable_locks);
 	if (lock_file_fd >=3D 0) {
 		close(lock_file_fd);
 		lock_file_fd =3D -1;
--=20
2.43.GIT


--3z8pYcwv/VWMCR4E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW7SS4ACgkQVbJhu7ck
PpThUQ//X6JCXaKUy55HzDtAg5k78UQJNpXuINmhBY0P2B4hxSzRpRQ07Ro3OFH4
VdIG84HBbfFOGkkRcV9ib9OmxpLvsBqsArYN1tjc3g7Nw0c+1yJllosmXTjCd+ox
pXx20sBQ/XLCuovsIGQmuaPQQ/bjR/9A74ZVD40j5NPXJSsqYUOBrrcw3m/qZ3/J
KRMC76hzOZ63yt0FPk7AlHvvteYtKB0La311gX8ZDkO+RJI/0aHC1BmQR3RZL9lF
hhZsXWxGxXUqFLPiQUeAGrIYtv/RsHQS2IrN9f9fk/aGdyma+tgBo+Yoyr4Pk+Sc
mTgSD1zpukmD3j6wvvxgEJrjldPDo5kJQL/U6oimRbGV+rV9rvfBv0HUyYY2z+u+
deKnqpQXddFvslDvsy5vcAoPPCGoITwX+Xb65YLsWg6HXKF46BRb7knZcz1yQ8JE
mPGt8sbZxGotDKYCkDc+1Nxj8w2c5lX9AAKh/DCF7mepnNma99yXlWReB8efn/yT
NcnrfaO70Es7cMRBTdWqEZzmbagnIiMSX20+GFg+PiYZRqDznmQWv7KfqiiyVnLC
I5RGbKPjN57s0t5I+JjGVZZrkBqqm2UJgJobkDXTsgbmCWBbD9IuQXhqO+vlO00b
nszc67sOmMNl9OfveIqm7rR8DjuMHx/AaTizSF8YW0RreH0oZTE=
=AwDi
-----END PGP SIGNATURE-----

--3z8pYcwv/VWMCR4E--
