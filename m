Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDEA3B4E9B
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 09:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784280756; cv=none; b=fsRKK2OWCINK/PqVqMF99LGhZY+D9BgCKSf8fxTJWhp9f+tYy9p9509QwmOrA9vNEXOMfgxozn1wJBVKoyV7jdKu1BcxfSfjzj4S2TXNt5JZvKGUNLe9JPEapxdadAcK/tYJgMrvqZPES8Y8dp69KbCzjMXN3G4G+YWPqeDHhRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784280756; c=relaxed/simple;
	bh=UBqhBehpbW/UeWHj99vjeWy8YxtwE7jX2P8Wl2bEtnc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I53gGNKlq0mO4vmDCEfGBTDzekBtPLlYV2Xd3sfymEq1U2vDGkMoCbrHXhJu1pBy6iCVZuPURiauD4vZ19xIuue2GpqvIjMPnH8tYSNjpBw0AZyQExGgb0ebamJV6D+f0GxAfQxoJA8YflZ1nN1H7f5RsGef15trpIy3YNTes98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=byf0gZpr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q7J2L3F3; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="byf0gZpr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q7J2L3F3"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 10A9F1D000D9;
	Fri, 17 Jul 2026 05:32:34 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 17 Jul 2026 05:32:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1784280753;
	 x=1784367153; bh=scv3XQDJp4v0V3cYcIMt+20A9jFkUOdklE7ef1UcWtk=; b=
	byf0gZpr9kTu3X/d20h1iXMQvWs8ZuIAkLR6lT/BC/wr83dSHe9BaSIzIj7FKiIP
	AGjlWa4AKtUK1B8bizLE7V2WwuMF25LixNw4UN24esMfmCxahSPNADIuLMODZ+iH
	/kxz7IwM12zUJgmo4Bp+OgwUCj31oeikfsYLMpUMJaZohXBYH8xEPdKMVUDPY3wh
	kogF/onYhaj+YKD16ZslBTYB++JPlI6519AwSeYAqleXbjCtk/07j2Vff4U3QMeU
	x7V8o22JQPY0FYBLMYtlOYY5a0VlheCGMHgmB4Zji1iQZdR6pbVJFu9HxRv5cS0A
	bdKjmlqPt3DuInWztkYbuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784280753; x=
	1784367153; bh=scv3XQDJp4v0V3cYcIMt+20A9jFkUOdklE7ef1UcWtk=; b=q
	7J2L3F3asrOb5vCr8d3lSy03hch2X9lrdny9JzJJKs51d4+aQmKzpfP2v8C12DVs
	ICreDb18ktSmz9RQG4A8MWsnTv0Ef1zOUyAUdKgx8ZJZytAIc6wxtoEkG96I6sgy
	Q1YKWuKj7u5o0h/hyuNVVSnREGZcjSYsKAC234zVu+yT9OLFXVTkFXpfpYQlAm/K
	QOfBMSJqLHVD9AFpLsB8SlqCgeKkKLlXWrcKzvSGw5VQqC6gBCCxaltPfMHTPGXn
	e+eX3UVNol4vNVPdpA8S9smRlp1PFfaemM0q2axyfO/0qgptvYn5hjd8NU46g4H4
	JjshbWfJqHJWNw+HOz1ug==
X-ME-Sender: <xms:sfZZanxDmVz3VlMiRMnpa5d2qDZkPm5kIpR1Q613vNOOtUVqnl87rQ>
    <xme:sfZZalTDxrbv8XW-cMf1ROe5qqOAhCHEOTPj1T3aB5zYLfGy9e5yxLAm0uMWdQP-c
    x4mdHaR24k2kSQKWr5jxZyiG7gOUe5a8C15xy5WwWF3iUAdvQA1Xg>
X-ME-Received: <xmr:sfZZau-Y14OMcLNYdch076i83ZNHMbzuI5sVya_rqBGsNKSkyZUwX1kZ1DS3sQiEPhqcBMmbdlk7M2zrTrrW6sqLkAgpaMlAu4yystIqJTc>
X-ME-Proxy-Cause: dmFkZTGNHhUECtWbI7dGTPFNitkS7LxgjgJ4w9ttpCQibr0d0pgAOmcVCqLeCbbV7wL1OE
    61pGVn8/ErNozdgmjBCJ22JUEuhEdV43SljPiIS68IvSIIEx2/IT6MCkhIkJCPTcQTmu9o
    2Qdy2OioKaWgpjp2RsgJ++fMJvWUuDUVquHnVN8kVLLylFlUQTFByQkM3aEyZv+j9jYhcI
    TKigCUrRA+8Y1aLWnthCzkuv+IxGUWyKW49IWIb9XdP9KobKSZZLxL1izlSkhLpchPtJY2
    DckpFY149y2mp922DWSqIc7sogOMMiGU8oJ5EHDRxShwxMLqGszhZwCopB+raiMyjqIIdT
    bILgdPwsgj/X8TRNIktcyoNyPxtSudaGndY4HXoWkKthK2p6e3gSGbMLBClBunTDKOJfDS
    nlfO4OK/qrGnpQ6EKdXBigJ/A4Hv6Wt2wg5pvfkNaT1WSWCmK853c82DlwhOWtH5VCthfV
    E47W8/mg4IPgh1Jor0ocdVpRXKa1VMl9LeH7uMMPvYWMqGJ54Z515V5EqSKzSFDLr7LCcI
    GVOu8aILh82zwaThDwXEGK92CEwCcdulpsDy2NEyqiPzNtqoAyvxRl1d2rh/i1awuOZwdk
    NdWtarRs1ov11YhMJVa9NGM8+KwSJ2tAHQmyUtC1fEC+byRnvCp5QE/M5sQg
X-ME-Proxy: <xmx:sfZZasogYTyr6w0uJXZngm0wDqz687vpzt4HTwY2mqyw0pxqqz2M2w>
    <xmx:sfZZarnvzkjK0ibXuVgY29LO1kPuo2qSCZWRvsj8gsWEiY35evVgyw>
    <xmx:sfZZajIzoPWdRYpOTQgbX5N7nZyYtYK0yhnf1qJjDojKQGLUO18YLw>
    <xmx:sfZZagxr4ezN6CSV_lqt_UICwPd0YP26BH0GXENmxRjvK1ZhacPjjA>
    <xmx:sfZZajgWV7ps9WNCVIRi5dccLuR2usOq2r4udABrrQc02C5OlZGLEkTt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 05:32:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1e27253f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 Jul 2026 09:32:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 17 Jul 2026 11:32:14 +0200
Subject: [PATCH 6/9] object-file: fix memory leak in `force_object_loose()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-pks-odb-move-loose-object-writing-v1-6-46446a3cb5b7@pks.im>
References: <20260717-pks-odb-move-loose-object-writing-v1-0-46446a3cb5b7@pks.im>
In-Reply-To: <20260717-pks-odb-move-loose-object-writing-v1-0-46446a3cb5b7@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

We return an error when converting the given object to the compatibility
hash algorithm fails. This early return causes a memory leak though,
because we don't free the content buffer that we've already read before
via `odb_read_object_info_extended()`.

Plug the memory leak by creating a common exit path where the buffer
gets free'd.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/object-file.c b/object-file.c
index 5b07530950..067a63a4f1 100644
--- a/object-file.c
+++ b/object-file.c
@@ -898,7 +898,7 @@ int force_object_loose(struct odb_source *source,
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
 	const struct git_hash_algo *compat = source->odb->repo->compat_hash_algo;
-	void *buf;
+	void *buf = NULL;
 	size_t len;
 	struct object_info oi = OBJECT_INFO_INIT;
 	struct object_id compat_oid;
@@ -916,19 +916,29 @@ int force_object_loose(struct odb_source *source,
 	oi.typep = &type;
 	oi.sizep = &len;
 	oi.contentp = &buf;
-	if (odb_read_object_info_extended(source->odb, oid, &oi, 0))
-		return error(_("cannot read object for %s"), oid_to_hex(oid));
+	if (odb_read_object_info_extended(source->odb, oid, &oi, 0)) {
+		ret = error(_("cannot read object for %s"), oid_to_hex(oid));
+		goto out;
+	}
+
 	if (compat) {
-		if (repo_oid_to_algop(source->odb->repo, oid, compat, &compat_oid))
-			return error(_("cannot map object %s to %s"),
-				     oid_to_hex(oid), compat->name);
+		if (repo_oid_to_algop(source->odb->repo, oid, compat, &compat_oid)) {
+			ret = error(_("cannot map object %s to %s"),
+				    oid_to_hex(oid), compat->name);
+			goto out;
+		}
 	}
+
 	hdrlen = format_object_header(hdr, sizeof(hdr), type, len);
 	ret = write_loose_object(files->loose, oid, hdr, hdrlen, buf, len, mtime, 0);
-	if (!ret && compat)
+	if (ret)
+		goto out;
+
+	if (compat)
 		ret = repo_add_loose_object_map(files->loose, oid, &compat_oid);
-	free(buf);
 
+out:
+	free(buf);
 	return ret;
 }
 

-- 
2.55.0.407.g700c83d4f3.dirty

