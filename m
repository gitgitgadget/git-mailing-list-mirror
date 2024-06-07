Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640A715278F
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 06:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717742274; cv=none; b=vDtnC8gLa/ICFuYU3QvzchcIApoa79plBS8sbDr7BVzRTLcN2re8/+Rx5u/2dPkGYIyadkEP7tJoeJdQ6O8Vi9NV63JFc0d89Bku20UzKxKhVvoHy4ebIzEOKztx2+B23cuXNDjrtbjpJXEIdlhDTIyCFstLfZtbimjcMPhDn48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717742274; c=relaxed/simple;
	bh=qVRcKQAxquCRTLuauXmyH5CSPLge5NfM06E4iM3aNHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IGV8XrZ/pUkfn97E/XT2T6Rh1kwgOSzxwHbqXS6pYpje2bGkz2xoA8+0dblizNa+kWGL2mRyhn79aroa1wvNuQUsMJb2/y7Cax9GfuMSBcsyVtsN++eCWdi4lpVTqmyUy+RPQoCAeAHEONwbYeZtxtVw/tEIsIBg80PmEXjVsrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=N8//Sqwi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jSGML0WO; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="N8//Sqwi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jSGML0WO"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 63FA113801DD;
	Fri,  7 Jun 2024 02:37:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 07 Jun 2024 02:37:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717742271; x=1717828671; bh=LauQLYedlz
	BYkGX6SSvhY4i8V0A3zSq0XU6k/Xe01jE=; b=N8//SqwiT+/OwrrPX/b5B2shre
	RlVpLFVqgivlbwbjzLajs1CKLdSgnNR23u9dl0XYppf9O3wp22VQ4bFK+CbcVtxh
	tgWjBJR8BaHTj36Dor8AwqJcYTZbXfA2+hZDwmt3nHhF76+nI/8UgcfoTNMNWMoj
	rgl/CuXmDJBNSTecvi8K/xkB0y0bn5ql3kIoqVbbfT9VQS/PVmB9ph+pjRWrJUHo
	ZkC0O3wvyZnSJs2RubgPCGsVNg63pjBaMtmvu/syXiIUSaGOZQ2ZNMI6KLSVjt+q
	jk88ZMEVGDgC5qMoM4XDNakpDpg2jTxHzW2MmWjI1JQfEnxErGIGLAOFNQuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717742271; x=1717828671; bh=LauQLYedlzBYkGX6SSvhY4i8V0A3
	zSq0XU6k/Xe01jE=; b=jSGML0WOQHbWs2zmAaDsnXy8OjyxcHf62aC1sefbgDpe
	sCK21wvXYGcbRFGdRdDABjq/L+JaaTFU9khnlQxKOd5mrt/Jq11ExTrOnZNEwcbk
	e3sORawh/sBWGFyZHsLqQGRyxbnFUdDaBdiVOw+5gAX+IRm80/NVKV/skMGX2wH+
	y+r1Ofn7KXDt7RWIFC2f1QttjWRWM6Rn39aROMXCVKa3AmthynIYU1qA9asVdNuy
	k+qu7/Fr7IU31XLPIFppSRX8KjcMA0WIwBlLBjA1PFtg4XNhD7in1ikYKeQg1cqe
	ONSBdASY86C64sW20u0HALxPj3yaq97UzCUzs3PBlA==
X-ME-Sender: <xms:v6piZhrbKYNUvoYbCLgGC2EnCpz4wUxiiTI5gQXDfTEk7mO_V9wdgw>
    <xme:v6piZjrCmUNm-PD8ZtoQ5J6otMFs6aQWoqpYC9GfwMqDw20ks38NF0Tzka7zlbqJi
    vrcyYmdpkjQLrp0Og>
X-ME-Received: <xmr:v6piZuMm0D2M5_PS9_2ZeLLORlLifcAQXtHjJH7LxjzF_pSYplnyNOpk5D6834fDqcPsx-CMc0jf6am0J8_iF5TLrUer5uL5hmz2fOI04r-jVj8R>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelledguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpefgffetfeeguddvkeeftdehffegfeetueegjeeihfekueektddtfefguddvtdeh
    ueenucffohhmrghinhepuhhpuggrthgvrdhnrghmvgdpuhhpuggrthgvrdgvmhgrihhlne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehp
    khhsrdhimh
X-ME-Proxy: <xmx:v6piZs7st0zrcQ6wPQLnmTu6polhqR-LcDraey79YSobVH937Q4QhQ>
    <xmx:v6piZg6sPBeW9_iUJS3MfesJOuZ_S6ujog7Gj-IRSOXd7cxBPoJUYg>
    <xmx:v6piZkhyOKmfr3LNiBOAJ4_3QSYavKr0wVlL-MkcOxgB9-4u8cYMCw>
    <xmx:v6piZi7qsgB6rrmByBdGZ3pQLSII2R-l8VICMB84X3N8v4gyuhgUVQ>
    <xmx:v6piZr1QGvagJqQmTWnoAn0Kvgh5NmlGeW5Ho76e4nEoi8_m7jrJzrcC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jun 2024 02:37:50 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 0154d6c6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Jun 2024 06:37:49 +0000 (UTC)
Date: Fri, 7 Jun 2024 08:37:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v6 03/27] refs/reftable: stop micro-optimizing refname
 allocations on copy
Message-ID: <90613bd58285553a406d447fa41d4b86cacb605b.1717740366.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717740365.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZLa0HU7r2XRcurur"
Content-Disposition: inline
In-Reply-To: <cover.1717740365.git.ps@pks.im>


--ZLa0HU7r2XRcurur
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When copying refs, we execute `write_copy_table()` to write the new
table. As the names are given to us via `arg->newname` and
`arg->oldname`, respectively, we optimize away some allocations by
assigning those fields to the reftable records we are about to write
directly, without duplicating them. This requires us to cast the input
to `char *` pointers as they are in fact constant strings. Later on, we
then unset the refname for all of the records before calling
`reftable_log_record_release()` on them.

We also do this when assigning the "HEAD" constant, but here we do not
cast because its type is `char[]` by default. It's about to be turned
into `const char *` though once we enable `-Wwrite-strings` and will
thus cause another warning.

It's quite dubious whether this micro-optimization really helps. We're
about to write to disk anyway, which is going to be way slower than a
small handful of allocations. Let's drop the optimization altogther and
instead copy arguments to simplify the code and avoid the future warning
with `-Wwrite-strings`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 1af86bbdec..e77faa2b9d 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1340,10 +1340,10 @@ static int write_copy_table(struct reftable_writer =
*writer, void *cb_data)
 	 * old reference.
 	 */
 	refs[0] =3D old_ref;
-	refs[0].refname =3D (char *)arg->newname;
+	refs[0].refname =3D xstrdup(arg->newname);
 	refs[0].update_index =3D creation_ts;
 	if (arg->delete_old) {
-		refs[1].refname =3D (char *)arg->oldname;
+		refs[1].refname =3D xstrdup(arg->oldname);
 		refs[1].value_type =3D REFTABLE_REF_DELETION;
 		refs[1].update_index =3D deletion_ts;
 	}
@@ -1366,7 +1366,7 @@ static int write_copy_table(struct reftable_writer *w=
riter, void *cb_data)
 		ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
 		memset(&logs[logs_nr], 0, sizeof(logs[logs_nr]));
 		fill_reftable_log_record(&logs[logs_nr], &committer_ident);
-		logs[logs_nr].refname =3D (char *)arg->newname;
+		logs[logs_nr].refname =3D xstrdup(arg->newname);
 		logs[logs_nr].update_index =3D deletion_ts;
 		logs[logs_nr].value.update.message =3D
 			xstrndup(arg->logmsg, arg->refs->write_options.block_size / 2);
@@ -1387,7 +1387,13 @@ static int write_copy_table(struct reftable_writer *=
writer, void *cb_data)
 		if (append_head_reflog) {
 			ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
 			logs[logs_nr] =3D logs[logs_nr - 1];
-			logs[logs_nr].refname =3D "HEAD";
+			logs[logs_nr].refname =3D xstrdup("HEAD");
+			logs[logs_nr].value.update.name =3D
+				xstrdup(logs[logs_nr].value.update.name);
+			logs[logs_nr].value.update.email =3D
+				xstrdup(logs[logs_nr].value.update.email);
+			logs[logs_nr].value.update.message =3D
+				xstrdup(logs[logs_nr].value.update.message);
 			logs_nr++;
 		}
 	}
@@ -1398,7 +1404,7 @@ static int write_copy_table(struct reftable_writer *w=
riter, void *cb_data)
 	ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
 	memset(&logs[logs_nr], 0, sizeof(logs[logs_nr]));
 	fill_reftable_log_record(&logs[logs_nr], &committer_ident);
-	logs[logs_nr].refname =3D (char *)arg->newname;
+	logs[logs_nr].refname =3D xstrdup(arg->newname);
 	logs[logs_nr].update_index =3D creation_ts;
 	logs[logs_nr].value.update.message =3D
 		xstrndup(arg->logmsg, arg->refs->write_options.block_size / 2);
@@ -1430,7 +1436,7 @@ static int write_copy_table(struct reftable_writer *w=
riter, void *cb_data)
 		 */
 		ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
 		logs[logs_nr] =3D old_log;
-		logs[logs_nr].refname =3D (char *)arg->newname;
+		logs[logs_nr].refname =3D xstrdup(arg->newname);
 		logs_nr++;
=20
 		/*
@@ -1439,7 +1445,7 @@ static int write_copy_table(struct reftable_writer *w=
riter, void *cb_data)
 		if (arg->delete_old) {
 			ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
 			memset(&logs[logs_nr], 0, sizeof(logs[logs_nr]));
-			logs[logs_nr].refname =3D (char *)arg->oldname;
+			logs[logs_nr].refname =3D xstrdup(arg->oldname);
 			logs[logs_nr].value_type =3D REFTABLE_LOG_DELETION;
 			logs[logs_nr].update_index =3D old_log.update_index;
 			logs_nr++;
@@ -1462,13 +1468,11 @@ static int write_copy_table(struct reftable_writer =
*writer, void *cb_data)
 	reftable_iterator_destroy(&it);
 	string_list_clear(&skip, 0);
 	strbuf_release(&errbuf);
-	for (i =3D 0; i < logs_nr; i++) {
-		if (!strcmp(logs[i].refname, "HEAD"))
-			continue;
-		logs[i].refname =3D NULL;
+	for (i =3D 0; i < logs_nr; i++)
 		reftable_log_record_release(&logs[i]);
-	}
 	free(logs);
+	for (i =3D 0; i < ARRAY_SIZE(refs); i++)
+		reftable_ref_record_release(&refs[i]);
 	reftable_ref_record_release(&old_ref);
 	reftable_log_record_release(&old_log);
 	return ret;
--=20
2.45.2.436.gcd77e87115.dirty


--ZLa0HU7r2XRcurur
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZiqrsACgkQVbJhu7ck
PpSkNxAAqlZSynudfCzWDKwMV7SinuascQVIhQs1O1YCewwSpIVzpSfRMQxxT2T1
7NRRmSXC0lCb1jzITw1ZdvaQtBvTY/LEpdhh7bLvqgT4bCd3AG3Ow7CxAb4+Ki1l
5AT5c2MrRgu29iIpKe3571mmr13a9+kv/AmJUllXucFMO/pJQU7/kb5tFSKQbG4y
WlhCvfUKuRDNuqL2oIVTR/OzxrbvZNoeBADuSflp5OoLp0iN4p4+9EhNxhayT+3w
q+B+4D+DbBHpEUYxvfesSOvB/WJB9K/KfZqq2uzWbTI8knuw5Z/sGzldFq5z6pMQ
dZgn+hVLWTi1m8uDj5yHfJqz1vZo0Y5tFTXcKFZUMOIzl6UyqXhWJC6kKT+cA9PZ
OKGTBCd4Ieo6CEhXjhi3yJpiaXMEnu2QubZMNn5L4G32z7LEaDGvNkqs49PelJMl
cAndj/WCRgeHzSouOCIiZb9GDfoq/6C5Wzfe58rmIwhnS1zbclOw6pTQ2Si944r3
pviUpTUmRkBmrRkIH+BMaXb+c8FRzw98UKXzogcTo0ea7pGT6Ou9hLF2z8p5v+9X
WyskE7mZqu1uy9Z1bWoRFnQ8lhnfUw91nMAmsFdYW+W4DO+5WTWDhxqctYjYCV51
3bVd4jenGgMUxqMLSciYKHf+s5WXsHq0O47UW9nZw/nF6C1K1yk=
=TZzS
-----END PGP SIGNATURE-----

--ZLa0HU7r2XRcurur--
