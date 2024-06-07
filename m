Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097DA14F9DB
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 06:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717742297; cv=none; b=anEBUShpubpdKeqIpqsfMir9HVRrBqgOZz94l6E5MkqIV3OwdXDIlN4zle8sW4uoUFTN9KKamq1cb7YRy8lYmvAgFB/zFRCz/De77Zkk9lpcHvh7PAPNN/D4ODYotRqbqdoUJB97/MCVyYbj5PyclnJ7e8Yxpz2hg/mXwnxC8Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717742297; c=relaxed/simple;
	bh=gm6CHDrlOdxGCBZTjIYAdk4UVb61E5REeKc6nusZ/+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ig+gbk7ZKH7gvI7dFrbmpSajqIiq80QYriX52BxWKZQ8ZlvQ5jyGkhvm+11F5YDjr/T2lD8oJeZFSTxgwUp7tgfIXhE9X+nJoiI+jDf/EzMNh5ycujBva775gABIs1tWiZh+ZyQCwNeVXcN1f7fkWZAiPZLkOMbRdfsGfZ/hprw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=d77sT3TD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J1gf/n84; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="d77sT3TD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J1gf/n84"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 1291B11401F6;
	Fri,  7 Jun 2024 02:38:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 07 Jun 2024 02:38:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717742295; x=1717828695; bh=wJFt1Xjq+9
	t83GQlJ4uyw/JoS4aOVuH5otWNGwI+TOs=; b=d77sT3TDt08L5BJcB2hj0tlRuk
	scvrdBA1rih2z/fWeqO3fpTmuLNSjc6NCi1GAhQfZZWEN4hJUPa6UeLAOBPlwSmN
	nQoWHHHYic2vsVtWoiOKNuc9dl0J5ioK597mIfwllV+sWb8fekyIZL/DFWmTOXjy
	faL2VKj3tMhejrVM9NOpU/7gA+2o+DKErSgua4Hg7LEG3UdSaBC5GpSH3a9y02OR
	JSRas4YktxwcG61S2N2BEwWVIBDT9swSDMrmg9+NiOfy7RNJSTD75W1gpaP7dC+F
	WjcpDNN5hskcc4M8BNfnZ446S6l9q9miqH8qBKYQNddAR8C1P19PdTYhR+eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717742295; x=1717828695; bh=wJFt1Xjq+9t83GQlJ4uyw/JoS4aO
	VuH5otWNGwI+TOs=; b=J1gf/n84P7QDAGrx4HnVV/b5gk+pWzMWs5SHhKtVQhon
	7J4vy5JHBVyLiS8TT+dPCRvC+4XzqRlYu1pr819x/XIwbfNlzBpANw+8TsoBJ4dK
	LB8hEFHbDI7HSSPgTYCpTEb/Ery/gWFlnv/4I+LX7USu3S8OQG1cxf+twSWQrcb/
	vKGOcEtXn/FAwZOT0K43xehLpqowOQQydvJy5xbF7O4gaDH4FjgRRAk0zR5/Hm7v
	UvcxPLgW3cyOvH8DBBAmMyHw+ek2iFYVs4CpFXQfwfTdO3NtB1c9oKhkhnV8dw0v
	5fSqdl/hHPBsGRPsaRspjOn23EsYsJh8bN3NxaKCpQ==
X-ME-Sender: <xms:1qpiZpVI0aoI0k0xVxaVy64NkccxOpAKloem4ahPiNC_SDjqhwzhLQ>
    <xme:1qpiZpnhoylaQznH7coztE_bNz-tfAA96wfDJRPQBOvChQuDkiZaqHbkWzC-o9QJl
    GY4Tzw_WBlAqVeFdg>
X-ME-Received: <xmr:1qpiZlbc4pUAG8SAKCqY1re6-HH3Ip6jb5d3JNrYiXAPCYG_I7NVlij4juoqrfwDl9gpO_4Yi1rIuqlcnrdXAUL3cp8Kl_27r9ZvPESi1ePnF4mU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelledguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:1qpiZsWAuJspagFnfEuBTza798061T72WikCIIWig2JgIHaeIKNtpw>
    <xmx:1qpiZjmWH9nL5UxtZnUSkal7uxDmBHVDvRWMe8By9Bvw7HHiHJHaZw>
    <xmx:1qpiZpfI3D7Ty61hZxV788-WGkeofm-dCazkA0YzdRI3S0HKmLxYRQ>
    <xmx:1qpiZtGjCnAs4mw9rkyHNkkdCgX2mgT7cJqpGnXgmXPNB8-Q8FcRjg>
    <xmx:16piZsB7RN6K8uds5iXPBQmnyzhsVKmCMYbVsV8kMFsURIlDXoJfpbJ1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jun 2024 02:38:13 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id a32b2239 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Jun 2024 06:38:12 +0000 (UTC)
Date: Fri, 7 Jun 2024 08:38:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v6 08/27] line-log: stop assigning string constant to file
 parent buffer
Message-ID: <777b93a89aff6db2422c257870225e43ce342eb9.1717740366.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717740365.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4siQPWHxWuzAZSUm"
Content-Disposition: inline
In-Reply-To: <cover.1717740365.git.ps@pks.im>


--4siQPWHxWuzAZSUm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Stop assigning a string constant to the file parent buffer and instead
assign an allocated string. While the code is fine in practice, it will
break once we compile with `-Wwrite-strings`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 line-log.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/line-log.c b/line-log.c
index 8ff6ccb772..bd3e663c24 100644
--- a/line-log.c
+++ b/line-log.c
@@ -1032,6 +1032,7 @@ static int process_diff_filepair(struct rev_info *rev,
 	struct range_set tmp;
 	struct diff_ranges diff;
 	mmfile_t file_parent, file_target;
+	char *parent_data_to_free =3D NULL;
=20
 	assert(pair->two->path);
 	while (rg) {
@@ -1056,7 +1057,7 @@ static int process_diff_filepair(struct rev_info *rev,
 		file_parent.ptr =3D pair->one->data;
 		file_parent.size =3D pair->one->size;
 	} else {
-		file_parent.ptr =3D "";
+		file_parent.ptr =3D parent_data_to_free =3D xstrdup("");
 		file_parent.size =3D 0;
 	}
=20
@@ -1075,6 +1076,7 @@ static int process_diff_filepair(struct rev_info *rev,
=20
 	diff_ranges_release(&diff);
=20
+	free(parent_data_to_free);
 	return ((*diff_out)->parent.nr > 0);
 }
=20
--=20
2.45.2.436.gcd77e87115.dirty


--4siQPWHxWuzAZSUm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZiqtIACgkQVbJhu7ck
PpTh0A//YFjea1F3QtVeKJjslXmcgyotyzEM+9HLxV9peDnFxctB0MvsqiExtpR5
PQjMCp0FlWbOoOcQ/oReEnobTCTUXy9qFdCTajj5vaHyhY3gTp6/iepjRNe+hLCd
je48Zh3EwMaX2LNRnztx3okf8UDlWYub2ccYQ1gVl67uHX7g7hRxsAk1wePXAIeV
SvCiBOxT+eFbobiHlBcqjhQkku6rmiwfcwfT4Dj8x4VWnFpC80yLuXXAuXnQGehM
Kfy4S6Eb4jOvqfHipsr0YBTEoC9knp5/UwX1cjJYs26uxpGvdjd4NqbBhlg7DIs9
C9hN+TCHSm92QN1zTrTXpsLPFaKfmHxHZkT6fpZVqvZMRqlbZmtahFx0r09o+gcw
4x6edy1Mh5YAt+YBUJ60WArxjUyVqyFGKyaRejiUpbigtTLoz/c8ZT99WXcM6Piu
NoND03AWxhHfk0RGp6bO5i9CIaQivu3FjkqbGmklNzDFiqI6WuFwRLa8IjD9Drb+
V/5KKiMImy2jKCW1iyFXJJTDkMBKVV5nzhHlm3MWP7UUyYHUT8V9LkbsOtSesZD5
vzzmlxkFi8VU62RSAqdGtddvC/S3rqS3jNSZXY8pxJae5llBszA+GoeN3yuQjEMV
KV+B7xjl0+dJSpvEwgRyXupJJ6nqteRg3RfddcPlCTLgnl4cTo4=
=otxz
-----END PGP SIGNATURE-----

--4siQPWHxWuzAZSUm--
