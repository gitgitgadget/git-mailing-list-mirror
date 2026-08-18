Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EFF309EFC
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 14:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787062784; cv=none; b=J439K4PbS7whVoQw0RQeYkCQvxtj7vs+rGNqc1OwFGkhm+qhr/MYFXi7OKI+x8EOwk4pjJ0srV7yIYoGO3PndpbebUCXIn+0/jQifqcXbg2QeSGfTATg8pSzqMzuTGEuERLwUezDlpBPTwHVp+bDgROBBdnWKH9rvPSeeaQTJPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787062784; c=relaxed/simple;
	bh=c93uWn6vOren1HT049SNac60adMXBIIn9/ZKLYyBgz8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FSdDU2AA9H9Uo7BxG8i8f5asi/n5WjhhgwHuixiTd63bOqaUW4YIN6D4r5Zwv958YGX+iCC71TXqfUo0RC2rz6Wt9cM24MhiGY9oc242o4X8bzVmALgYqHKVQEkpbIH+3uEOs4+u2N4nMGbExSauhvBc5OgjcM90wWzTbVepujA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Jju6pNVL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EYJ88m47; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Jju6pNVL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EYJ88m47"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 2CB6C1D0014C
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 10:19:42 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 18 Aug 2026 10:19:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787062782;
	 x=1787149182; bh=zrLsNJfgstFA1giqAK7cBXz+ruQ13w/vCp2sCpFgBS0=; b=
	Jju6pNVLk3a8cu5G2TrfU9JcHpaBNqXPmi4zR2QdDjeJ/fm1JVlN1vXRKVJAkruv
	wv13hXWkGHC5N4nz6ZveIUtUqf6cFHIMN/3ZZq9i/+BsbUZbQ/BMiLcI0L071gXR
	tYrfxWtE5evk4nyOSpRrkzYeRPNqDILFLvMNw8FFwgZGh4suC/XZptfqzYdNdtSB
	q+rB+1RQZd+Kd5rozMA2r/rcmSPVJJ7uZ2o3x8kV5fzfRaD6HaiP2cgwBvgOhEOJ
	D2IWAmlWi85Kh3rrIMEn4unMmxjBry9wy+99yFuQxGMTV1FKM9xN6RGGqcF00ixo
	zdKAlAUL/xypGdCpt/gVIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787062782; x=
	1787149182; bh=zrLsNJfgstFA1giqAK7cBXz+ruQ13w/vCp2sCpFgBS0=; b=E
	YJ88m47oFm04EXxmOzX82Sco4mRZv6S1SLC2Jozrat9ix3ahWnuYgjcd4v5neVDA
	oZQykgS5gxjxEhGNwojZsYlkMOY1Ti42cghuYPt8u7RN6SridOLjiKUQZo3fERel
	FrD5IlG1qTHfvH+u5b90e1MUkhRvAQZq1Yr84xyZeHSAPhNnKGplxD7QFfAdMg1R
	W3jws4mafXj9nqc1jKtIz6HcwcvLelJQiINahP7OQoKzT0TF3pzN9fv8x1UsPSR/
	J9sVPgovYFCrc9vvr+v2MdzeJRLtDN5xCrFtoQZ78HC3zUlSbYv1qdI7fX4VdtHe
	CaVT7udA7Wgf3/N4ddZTw==
X-ME-Sender: <xms:_WmEavyHNRqdiV4mLZSyRuHicLZ2QHw0z6viDULVpZjec6O-cMA2XQ>
    <xme:_WmEauNi58uNSA9IoE50AAk2WNDyu6N_xcGyZj_K0POlQq4Z3S6d3LzRy_IsY_Yoo
    FRtC22GwmecFyTyuRQmDA3oERoiLBS2x8U2F_uYZej2WiossyZMB6c>
X-ME-Received: <xmr:_WmEau93wzMzGhlHZGPssKs1UBHd-9Ah77bw2UmCDpEEKb3ZmLNDCjsprF6s0jpUmEVZHnjYMsVOc76leMrGx64MVjgcBI5PnuwUsWao>
X-ME-Proxy-Cause: dmFkZTGSoJp7k8c0Cn+kkyI49yzacQKpkTxj0CYv6iZVkinoAl4hjDbQ4pKe6QO32cZZlg
    ZLC+erVc3/aZNPlbelo8VxvwzwtJpCGw4RaR3KFLJjFqS+H7kSlUbiIalE8uVq39xM3xrM
    oKlGhH8IJ3jjPdPWvZdyFwBJw/cKncFPYozfcBgmgSfBW0u5XNxAbImSnkleaD5p4tFswo
    6llvEoBRy3ZLp0GlgZZLZ4fT2LGU/0JMQg7zLs7NiEN2BBeKMLYn4hbrvtc1XsLqyhlY5H
    K2HBNYR7bnjg/4cqcVDJUoTt/V9RqevBQ+8RfA/4AiOJQZqXXhcBPl6edIVnuVDkrBj9cO
    12e81GIk4wAI8lNpHJDxUS3wGtKQyOFY+GX/9NpGfYIyDD/nkkPlDFz1rG/+N4VSmlgrdb
    z8+mK2TMbQOiyenbJG+F6isdnRKJa60gsmjVxjq4m3rR2AmMEVidSq+eKfLMc2BBSmnad1
    cAWUpDvYnxz1uL3Lk0ZUueCW7cyf9b9SfUl00UNU/6ZVQyRy+OaH7szzPamvFxHZDa0Kn9
    SsmqeVvRnTWAFdTHryWw7+xxjGGxtAZV0uOUoVVV+pgsCsuFP1b+Ej1u743Hx+l1/bCd99
    oIIlaiFjGBoR3eLjDP7LLyO+vGWACy6wnazO4WHy3Kw7bIPU+5fEJT9zQ3vQ
X-ME-Proxy: <xmx:_WmEaupLxOIcr6l6mo5VmRtvPeJlAGM5Vfs-r56Y4e8ZhMn0qE_kvg>
    <xmx:_WmEag6EpXLzwc50hAFqOwTMN7I2GthTtGj-TLKHx_PI1T0-OvG6-A>
    <xmx:_WmEauO6sCeUvYe75fe81N17T-JW2svvgrZqSyKs7AuekgmSz0QlQg>
    <xmx:_WmEaiOOauC1Mw_g-u8om0_tPSLYuI5zVjsD0j1tVqLtOioqEW2xPA>
    <xmx:_mmEatxpa6TIa6xvneQ8VKWVcrRPhC-Q7W9nq8k0bQ5fhPaq-j4fAf-s>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 18 Aug 2026 10:19:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d9952be3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 18 Aug 2026 14:19:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 18 Aug 2026 16:19:28 +0200
Subject: [PATCH 1/7] odb/source: discern missing and corrupt objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-pks-odb-generic-corrupt-objects-v1-1-ec234567510f@pks.im>
References: <20260818-pks-odb-generic-corrupt-objects-v1-0-ec234567510f@pks.im>
In-Reply-To: <20260818-pks-odb-generic-corrupt-objects-v1-0-ec234567510f@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

The `read_object_info()` callback of `struct odb_source` is documented
to return a negative error code in case reading the object has failed,
and zero otherwise. This is overly broad though, as there are two very
different kinds of failures:

  - The object may not exist in the source at all.

  - The object exists, but reading it has failed, for example because
    its on-disk state is corrupt.

This distinction matters to callers: when an object is corrupt in one
source we may still find a good copy of it in another source, so we may
still be able to proceed with a given operation.

The "packed" source already distinguishes these cases by returning a
positive value for missing objects and a negative value in case reading
the object has failed. But all the other sources conflate them into a
single negative return value.

Adapt the documentation to explicitly require the semantics of the
"packed" backend, where we return a positive value for missing objects
and a negative value for corrupt ones. Subsequent commits will adapt all
the other implementations to respect those new semantics.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source.h | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/odb/source.h b/odb/source.h
index d69f8e2d1c..4ae6cc160e 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -110,8 +110,17 @@ struct odb_source {
 	 *     second read in case they know that the first read would have
 	 *     already surfaced the object without reloading any on-disk state.
 	 *
-	 * The callback is expected to return a negative error code in case
-	 * reading the object has failed, 0 otherwise.
+	 * The callback is expected to return one of the following values:
+	 *
+	 *   - Zero in case the object has been found and its object info has
+	 *     been read successfully.
+	 *
+	 *   - A positive value in case the object does not exist in this
+	 *     source.
+	 *
+	 *   - A negative value in case the object exists in this source, but
+	 *     reading its object info has failed, for example because its
+	 *     on-disk state is corrupt.
 	 */
 	int (*read_object_info)(struct odb_source *source,
 				const struct object_id *oid,
@@ -340,7 +349,9 @@ static inline void odb_source_prepare(struct odb_source *source,
 
 /*
  * Read an object from the object database source identified by its object ID.
- * Returns 0 on success, a negative error code otherwise.
+ * Returns 0 on success, a positive value in case the object is missing in the
+ * source and a negative value in case the object exists, but reading it has
+ * failed.
  */
 static inline int odb_source_read_object_info(struct odb_source *source,
 					      const struct object_id *oid,

-- 
2.55.0.822.g20453c30eb.dirty

