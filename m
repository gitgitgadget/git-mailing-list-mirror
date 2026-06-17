Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4063B6BF5
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 06:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781678437; cv=none; b=u25/hLH0WU8ly5vYSMl1/rhV/bf/7ddNfI1VFlH4YRAYyjRw2GHNn/p+yrs2EKPJOp4rx4oI89plrp86ll5+b3TZYItx7zlO7j2LK9N9xD+EkfM9sARm1Sqwfznr2BWIn401S3NzcpOcMhqALbJ/otwm/Ux21uUWQxun4TiN+5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781678437; c=relaxed/simple;
	bh=iVSvtUXFJf015FiQNJ9epprNndSXWUKh7N28Z3v2+m8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=almfrCP6FuhwEKcycjXAmrNSX40xrAao/ySPpOE7/kcs9VZ0pMV3m1X9CmdTLiFwsD3tyYPHMaXtOVDWIyKmGmhRe6g5pcQAXItJncCbbxG4NBeXq/bMEXrAhOIlfd9oYSkT1pWk1Y7aq2RNSrNS7qGBADQCeyiMIxQPn2z5wAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qcrK7cl+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gA2YrKj+; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qcrK7cl+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gA2YrKj+"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 301C27A00D0;
	Wed, 17 Jun 2026 02:40:35 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 17 Jun 2026 02:40:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781678435;
	 x=1781764835; bh=2/NMt8jTNku2Nb4+lPgaq8eYFcL1/ZUEPjyx2fSOuEU=; b=
	qcrK7cl+N8U8E6GkZeKjV3lPl8wthccnU7wdIHVCX7ySplpK68nP/LnFTQoyjFyh
	VmtSdhUXK+7juCtfipdKZOt7JI3U3oWigtKgXdirSewcrM4Jg/eYxBqi1H+ZyUw6
	JcNkTk2LM7uedi7FCBbcK4gfRIcIEdnq2e5eHQQj00dzNlXwIujIvL3BKKWa1lZR
	AME3OP7Pw/72UaiDl8+zI1HQ7TGWvAlwWqRye3txg3/A3631mxFAKNtEn/wwXcVN
	soqPgLMgt73ZIAZWLKRxwDuiA+gVbLUtxJcwiNetocZ5End60SYMzFQjo/Rkqelq
	5qMh1D2uKjtL/I4Aqxqb1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781678435; x=
	1781764835; bh=2/NMt8jTNku2Nb4+lPgaq8eYFcL1/ZUEPjyx2fSOuEU=; b=g
	A2YrKj+VSbDcMrb0xn/CoDBHimeUebwKvTVQLQ1BB3SK24RpTZd01a+wXngQFj/1
	BxOxAhKkf0WVEz3FyrdpVm8uXWT49J2lh03KzQwzIqAwFjNS1ibKmFJuWoCbq1LZ
	l6Yprt7Tl56qZ4SS+yOaiDm7f7DXRS26JWpOpXZNK4578+x/bNNN57TFBzRvKTmo
	ohqCbMEkX6WOWlw+t/IXg0QUHEw/68eka+8+TC/1+UvJn4tCNNzHKf5QEJ2toRkx
	VbTtZpa3NKaii0Lag4odQCl7FMK7q1Vp1dnoc9kX2KHJp21/fS57kdWokd7mrWgk
	9k+vDLNgDmDvRDZ8H2Y5Q==
X-ME-Sender: <xms:YkEyahc2CFRmTX_TPqJtWzHRlXwC6YcwTdnnXWDAU6EpSrN3YuLA2A>
    <xme:YkEyamqpHakf0W0jczxtCciP_S3csZ2XyLU3l83FR4HIF69kQYu5yAkKiJil3nxhJ
    SlHULzatfgwmPwHifMY4WFb6ujQBCRDRpNhmytynjXM5UpOeHpPsQ>
X-ME-Received: <xmr:YkEyan5mDPb6eY_0ydnPmTUzZNaOe0ZZK-ciyejCajGPK3E-NBtk6qWX8SjHY3OpgeCur0bkqgW0HOSZXaOJ3ZLruskXuCpVhc4GarM>
X-ME-Proxy-Cause: dmFkZTGR+6fD6sF8kDvw0pfUKwXsPss2g5jLX9LdXMMlmWpDw4pAYwDgH4gaOHBtJ4+Vk7
    gLyAvhs3EZ6KLc5YOFlW5U1JexX5XChen62Ab6OOkAX+Roz5vxTAZP61GgQ/ZhpaNnPl7g
    Z3TBT2tPlfrRkzTm8fd9LBfs7DfcQ0jgrKEIZBXdCs+iU9IvQvvgDtLl+yS7reNy9LgWdS
    pNp3GsSdINDe+hfTG9Ltmn3PU1SyHK4WmiAOi8JEIHKKqr0e7ViJii5y7vOyP0LxEwJ2pm
    XJ2n3KSUsfvpUNalBeIn34RIWpR9v/FZ2Ajlu/ZmQKKhiitSPgJ7Mjwe0zdDZWGIFYfDtz
    7RT1/4YnOILTMtUCjvJfaSfQSF2D5EwK4yx4MN8EdbAq6Yo6hTjjDs8mXaNIz9lGfiF8id
    RyonUyKROl6Q+NIVzRqzxpztRAB/O5936AtjhsscucQTGKl+8moONEP7ypk8x1f6OC3NhJ
    CobXpxhCyvobzRYpsAspo6u61o6j05R3X57Ga8aPM2T29KOm9QSEwPshiHByXVMgyEuxgI
    hOI80493jiwIeeYJvDmfWx1D/rPTnVStgIVZto1QG4sYvHowvRt+TD53gM5U2yPkMOt8GX
    DZC0rrUgYeHCoqItT7iVhbiQN442Qvi8XNqIFAoMJSpag2rdkKCNUsJi8iAA
X-ME-Proxy: <xmx:Y0EyakpbT5DG--0DUc_B5vLUWuAUNsRaUkbYUBUD11y9PZ1Aw-f4bg>
    <xmx:Y0EyahjWZ3wJTwXmsUQJchXfgDn5qnPP5cKtkVRUbBniphvfS-GUrQ>
    <xmx:Y0EyamI5QXs0PjbLkRYwo7vfNs80hFsbA44ATQEGo9taXLG2pJ2Nvg>
    <xmx:Y0EyapCEfmSH3-jYTDtlrLB1tqhsDfPkb3usSu0J73PUIYwB6p0IOA>
    <xmx:Y0EyalGIlFQRMrJcyaHTJaV1iRRW2N1xNVQMsDXvzRGGD5j3AyU18Px8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 02:40:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 33cbce25 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 17 Jun 2026 06:40:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 17 Jun 2026 08:39:58 +0200
Subject: [PATCH v3 15/17] odb/source-packed: stub out remaining functions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-pks-odb-source-packed-v3-15-b5c7583cd795@pks.im>
References: <20260617-pks-odb-source-packed-v3-0-b5c7583cd795@pks.im>
In-Reply-To: <20260617-pks-odb-source-packed-v3-0-b5c7583cd795@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

Stub out remaining functions that we either don't need or that are
basically no-ops.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-packed.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/odb/source-packed.c b/odb/source-packed.c
index e40b52e445..08a2de9bc5 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -501,6 +501,43 @@ static int odb_source_packed_freshen_object(struct odb_source *source,
 	return 1;
 }
 
+static int odb_source_packed_write_object(struct odb_source *source UNUSED,
+					  const void *buf UNUSED,
+					  unsigned long len UNUSED,
+					  enum object_type type UNUSED,
+					  struct object_id *oid UNUSED,
+					  struct object_id *compat_oid UNUSED,
+					  unsigned flags UNUSED)
+{
+	return error("packed backend cannot write objects");
+}
+
+static int odb_source_packed_write_object_stream(struct odb_source *source UNUSED,
+						 struct odb_write_stream *stream UNUSED,
+						 size_t len UNUSED,
+						 struct object_id *oid UNUSED)
+{
+	return error("packed backend cannot write object streams");
+}
+
+static int odb_source_packed_begin_transaction(struct odb_source *source UNUSED,
+					       struct odb_transaction **out UNUSED)
+{
+	return error("packed backend cannot begin transactions");
+}
+
+static int odb_source_packed_read_alternates(struct odb_source *source UNUSED,
+					     struct strvec *out UNUSED)
+{
+	return 0;
+}
+
+static int odb_source_packed_write_alternate(struct odb_source *source UNUSED,
+					     const char *alternate UNUSED)
+{
+	return error("packed backend cannot write alternates");
+}
+
 void (*report_garbage)(unsigned seen_bits, const char *path);
 
 static void report_helper(const struct string_list *list,
@@ -715,6 +752,11 @@ struct odb_source_packed *odb_source_packed_new(struct odb_source_files *parent)
 	packed->base.count_objects = odb_source_packed_count_objects;
 	packed->base.find_abbrev_len = odb_source_packed_find_abbrev_len;
 	packed->base.freshen_object = odb_source_packed_freshen_object;
+	packed->base.write_object = odb_source_packed_write_object;
+	packed->base.write_object_stream = odb_source_packed_write_object_stream;
+	packed->base.begin_transaction = odb_source_packed_begin_transaction;
+	packed->base.read_alternates = odb_source_packed_read_alternates;
+	packed->base.write_alternate = odb_source_packed_write_alternate;
 
 	if (!is_absolute_path(parent->base.path))
 		chdir_notify_register(NULL, odb_source_packed_reparent, packed);

-- 
2.55.0.rc0.786.g65d90a0328.dirty

