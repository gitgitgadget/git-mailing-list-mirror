Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E44D37B40C
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 12:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782303586; cv=none; b=OiVuYP18nTrui7aMW52YjJUWtn9hG8EAesZW5ZttsWR+xeQXCTFBJ1+/k41C0msBlBXDFqhN/+QFMcxAF1eMap/aDCISCAFwiD/SmYUgnppfIhPUmcuA1fhZHvMX7yQPUQc5N1mGjaQLM1MHOqXO2ZAHaTdbxfRUDLpQFLyCflc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782303586; c=relaxed/simple;
	bh=SfHtBbscjKyV9I15ryrQBRDXA07fhcIDUx6c92qtLng=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rsjjb6my+Zbkvde1S1wE+87fHFDHxjnAZ3bzDMwCl9ygsOcSLqrruOaHzmViOLaCx728wNpc7A3m4CrKe4NMEeR5RBevTCult+mGGVXBA1haHeyn0x///J0swxaxxKqR/Rj7iquc++ovHaL2uU13vxDIbsTwQ1JiBZgdImuOZqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bCx9SVj+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NYSLq/XU; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bCx9SVj+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NYSLq/XU"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A694F7A01F4
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 08:19:43 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 24 Jun 2026 08:19:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782303583;
	 x=1782389983; bh=mkFVXtuGUDMdrbrDduJWEJCeSc+ch6MY2rXwENGCekg=; b=
	bCx9SVj+/weDj/L1L7Kvy7f1MH5wIQmFLGS/YmrEkr53GM5CsNiz8G4Wq5Wm4AE1
	suH1tBEuSCr3y51miHpcnGQY9NmtLNPi7NL3TESGq7ir4LefOMeoMUSGFa8YN/9Z
	mxv1pCzOXxbuf+af0twuoIYF7mskg7q4+Ny8s1ogRioX9jjLD73mG6LhCUpaspxq
	cg5EQ8PELYgXnLTzSG4z+VzVGxA+eQvwS/WnTVJtbWgmMNX3YX2Vuzk5WsFXF2a+
	UW1RGkr3HlJjYyPNRI7gjmmor4ny9jnlQIUZJBqfvQj+dBXHMS6aUNYyjAE5IdVn
	zC/ZJHRgl0dVviUuH76yVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782303583; x=
	1782389983; bh=mkFVXtuGUDMdrbrDduJWEJCeSc+ch6MY2rXwENGCekg=; b=N
	YSLq/XUp1VmQBQc68GS7Uw+aWlRQHF0waw67v8C/Pvaj/nL9xvOrBjSaj3XXKP4l
	NYGTDpN7vRLEXwx0JoVpwUVyOdZKqMF1AHuekbXUMTg+2SqLAIHWta7bXeUF0rRy
	vz1U1YKn5OxE0q3uvAGSf7Z9mQHAg+zTioM7DttxcMb3u98LPISySpG5ESFIQ2iN
	GMGAhxW0X8b/EjihVEdBcyHwrlIdEOOaw8f5MOs+y6w26Rve8cgopie9hyPl1ow6
	KTwe5fZv1rCUVyAUZrKBI134TR3wI4KSQXaeSBH6BJ9sh2uAfDer0KfLHjlczTHZ
	UYZnkdeb0XPA6TEABVH/A==
X-ME-Sender: <xms:X8s7atazXOodA7yxlAWBcMjllxr8NvCaELEoME9KGmupI_dETyW1sQ>
    <xme:X8s7arXq8hbPCkKbyjmiAosWVZkdKMmscSZZAV9k54RHlC3lIh1k0TPkIkRZdoY83
    uMeSYYRmuPw8B_vhhLS_kLVw1kPSJVk1N9dPKhu86OYEeqSZe8sEw>
X-ME-Received: <xmr:X8s7aln4StVbPMSjukL6dVDYFYmcBiqec-FIOQas-jWovFv5HBD0KrZX894TSY-6smYe19sOpwZhrSjHais4Nm2o0o2_1eThTcRtFOJr>
X-ME-Proxy-Cause: dmFkZTGqat1Mfn0idfGqd8wszj37GZDlcg6VdsFF/s6Lvo6E9OkC0O89HBX9mJz3ZmDJab
    YYfNbUJLoNUxFuYbKZwJUCihCEsIVvJMyJuSfj6NgXk+02mWx4YOQW/7j/npRXrxpJDXu5
    GAq9Sb8DveeOLclKserqF6ttViR4qGbxnIyWYvmn/5ZI2mqnc9G00OMmNisSQ4b8YHFKcU
    o/pRDaTCPLlYCsgOwfn6nL4ncWPq5dN4oTEZmGfd8adKTUDwFurCC4SQqrnUdY5chLH2Xw
    szBmS28CULBkcz2L47PLfbv2oDpQXdurTJeXG5LkLbx3aSkA9jiXghJSzANVVV68dXBlDl
    PW0Xb9YXG3av+gMCAarX/RpAEROcC7Z9bIF7JMPzVUEBzymyY7w5VRt4Evypc7LoGunk9m
    idxUdqYXXtLzcdB2+6z1L+dFwJuzb5KG1D+BihWyuv87pI3I7O9bOp2k0EmMT4wNNwp8+6
    eHzQgGFXGU3uYmHP+yw9rAPynvX3ziqQ36fGqcL6j5GXmA2vYZo++Ii+D8OqhS7Wmsg0oG
    Yrz9/Snjta88eViUd8xOd05T7ZWifP8l1qZ4okoY/KQq+uy1kT23LbeMpsyxkTIOxi3prh
    U3RP60ZxGeqlYyS9nIDurKbprX0LDUWakRFOeAz9Qy/0o/KkM4GPMqZFrKog
X-ME-Proxy: <xmx:X8s7agw1jbSILwDV5vX_go3qh_HFSJ2jXoFNpxv-MsNxDvMTgGKH5Q>
    <xmx:X8s7aohT_a2H47yBJaekyN28wADUKkyL4jlxnnP2CnQQWwSjgSIxMg>
    <xmx:X8s7atWt82DJDscE74NYW8MLrIuNFU1Ib67SNv8nXUyWl-bKB7zUeA>
    <xmx:X8s7ai1rSTsQUeQoLNqlV63yPJQJ0x_mkr_E_XMWHxhyyR0ZNRxsVQ>
    <xmx:X8s7an7fqN1mp_giaEsmQnFfMIdJMmJsQdyu38uXELoUod_ND3UNYE8v>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 24 Jun 2026 08:19:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 980e3da1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 24 Jun 2026 12:19:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 24 Jun 2026 14:19:19 +0200
Subject: [PATCH 6/6] odb: document object info fields
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260624-b4-pks-odb-drop-whence-v1-6-8d1877b790ac@pks.im>
References: <20260624-b4-pks-odb-drop-whence-v1-0-8d1877b790ac@pks.im>
In-Reply-To: <20260624-b4-pks-odb-drop-whence-v1-0-8d1877b790ac@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Some of the fields in `struct object_info` are undocumented. Add these
missing comments.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.h | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/odb.h b/odb.h
index e0d05eaf87..a44ec46b08 100644
--- a/odb.h
+++ b/odb.h
@@ -283,12 +283,28 @@ struct object_info_source {
 	} u;
 };
 
+/*
+ * The object info contains the query and response that is to be used for
+ * functions that end up reading object information. Callers are expected to
+ * populate pointers whose information they want to request.
+ */
 struct object_info {
-	/* Request */
+	/* The object type. */
 	enum object_type *typep;
+
+	/* The inflated object size in bytes. */
 	size_t *sizep;
+
+	/* The object size as stored on disk. */
 	off_t *disk_sizep;
+
+	/*
+	 * The base the object is deltified against, in case it is stored as a
+	 * delta.
+	 */
 	struct object_id *delta_base_oid;
+
+	/* The object contents. Ownership of memory goes over to the caller. */
 	void **contentp;
 
 	/*

-- 
2.55.0.rc1.745.g43192e7977.dirty

