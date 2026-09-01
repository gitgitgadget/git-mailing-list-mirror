Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3969247D475
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 11:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788260995; cv=none; b=jIZvjzbFNcRxTDp6XtytYuWJjG8HY8V6pVELqBJK7sv4BBTe/nPumIV5MkdrZO3BtO1YpOSe615CMOmjTjVb6M5aaz1O/Is8UTdeJ8na2l6tov7M7cAPMOnhlV8ZJHJbYDMVzAxT4PudYpvEFFIvvqiuxOoziXuJKqhVDAvuUX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788260995; c=relaxed/simple;
	bh=5fJfsKhP2gcnHy7KKiOUiaS6IIAUfV+7Ihu1D5XwQGk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nIXBYu0dDjO5iA6M2DbK1VkIWbGmhuMmkrQjSfg4B0zYcBzp7t9Uy9WD2tzyuAJSHwzVNzs0m7zjnld3krH23CFUBcp6oEWLjQpKv+ldx9eYO0s+VDVaT+cJ+jv+59A+/kUAyCUmNX8Qmu8ahTLSiLPpHc50P0QLIWenxHcBJZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GgGDCOWs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BTWiiMcX; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GgGDCOWs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BTWiiMcX"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 70222140004E
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 07:09:53 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 01 Sep 2026 07:09:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788260993;
	 x=1788347393; bh=yfrIIl6h5COz+C5GPro6hzOpqICSN0DFRp3rLh1hI1s=; b=
	GgGDCOWsDT/Kfo1R8jehhYW9QGqYWdgI9ua60Qq62kNlCaU13DrnKgdig2ZGUgum
	JQBClv2scu9KALUKy5Aku30UKLclkhuj8lPKmfLYgItRECke9CVxQ63BUgNyxNBa
	9nTriV3JfifnY8UdK+iXlagQObBes5AMTM+DGkQI0JqkqArmgED0QIsjz0q2jQg7
	fW/WPUpyNFltkxLbk8r30+qmk954zL66M538AUy0urOl7v6oWdktLx6HiTDo0yL6
	nZRXxCtd9PJBRFUybvekTk51Z2dKY3ZhzjDTzgnJvd44gr2y7LGPkSYaH4/b5cfr
	T8HtZ8EMB7lf4XhQujqUsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1788260993; x=
	1788347393; bh=yfrIIl6h5COz+C5GPro6hzOpqICSN0DFRp3rLh1hI1s=; b=B
	TWiiMcXhEKL1NQ/R78U9Cs9yPgM9CooDcJN6mI/Lu6Y8BdWySU4hqTFYZPMGB8o1
	nvTZNxqSvV1cUr0GSMRmiBI0x72Ts5dhfIZZhMZmPSas4iUJCs2grUOitps2Hbuq
	cJ91cFwe3D13Ybq+LKmrAF27vfboOVjE/1jGKN7FE8SBLnVC1sdy2nNVIXKEfay8
	DJNrGFQCfvfAJki/fAQ/Hp3dFCyUS1fLMoH1rDF4jP8DQSmpvvnBIi2yjHLkgG2N
	mczx6GTeqw0VXOLegJYfJESkVa9/ZLORlJZxmqMBhNy9+BTKAtQI2Ql2zKAmNQth
	1QTCY1F1mBqQN8U4y9JuA==
X-ME-Sender: <xms:gbKWaomrCR9q1kgNFd8XyYykI54nCI3pLA04HFbjq37TpnciuRvSeA>
    <xme:gbKWauwzJ37ar_OQzR2SK2CLSv9XG2X6WmNGyDfa56sSo-_x6KAd_boM4xYak0bn8
    lhGJ3MarAT0YE0VWBxhdNoNBagN02Gf9d3QRk6IsTd97Kls8uYu8kM>
X-ME-Received: <xmr:gbKWasSOCfH5-M1a78VJ4CX2hj7spGeY50NKsk84GE6i1eqJygyDSQ>
X-ME-Proxy-Cause: dmFkZTEN9g1Fe0QNve9ECoP2TiUiX4EEH5POEiwmRiQIlHZ+xDbzHkU7NDd2M3NVK6/umO
    bXXkzUK3COWchLgt1/LK6gQ+MqeSaO5Oixh8RPOTrogDUVvdApPqyytnFYWyXEx31a/UW/
    VrRjQoyTePvVd8NFe+FYtwmzmG6MTjOdJtb92EaY7FcVv+MSIEhwv9SzJucvjBA0gTjUZ5
    irBlskFAJd/x0/Ql5UqM+PWol2xq0PhHqo6xS2QHAKohbPBqVxfe/t/HxXIdPstzFq1tQ2
    zZWYaDW+dfkh9KQoVCr2N9lwFiWtupwGIIOt/EhVGn/DGYrANZ/6T7aifXl4bC+/EDNajs
    fGf6Er7SQpUyVKq9dgrOiIxw1CI9Fkfr7ti70ffotR5HlmRCLxsHk9hkMcxXxJKQeiRMbm
    U4iqWfzk/dN6izBlUJNhri1Ykjq46h5+oLHUIijUxAMjOU5uFNFwSYBnx7Z2lijpuiUtIx
    V4/MBn/Pw2E716buQ8zZhPk6EKGaUJFbpehzxWQH1ToMznwYl+YvaukRhonthTtEFITr4J
    4rIVBoKiho4z7GGg77eJkc4gRvcViAflCXYiIdrnSoieuPOQYHBZnUK2m28cEhTglcWNZV
    EThHp4M/tJXNhldSph8aUSeErNUokpLcOceHufj+/nVTbYSQsXfR2Ghhw5Zg
X-ME-Proxy: <xmx:gbKWaptiezTr2hxch4E5QHoFtm6aTW-TXTTw7ofKqVn-2g9n4VV1JQ>
    <xmx:gbKWamszKSVUk7Zqp7N81ohodxJ0I69GZ-AuAlbmfN6sHx8uyPS3pw>
    <xmx:gbKWanzzC8nmfrLtaPcWS3TaSGum3YvoZEBjRngrZRYer-xB-mucow>
    <xmx:gbKWakgdJ2SivmScHfoMsS43jK3n-k9fD0CHsymzUkDHNmFx-JZuxw>
    <xmx:gbKWas2OSXqL46usx6hQGj7vm9A_KSD4LVTpP3ukI8jhwCH-ggIr87fd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 1 Sep 2026 07:09:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6094c845 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 1 Sep 2026 11:10:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 01 Sep 2026 13:09:07 +0200
Subject: [PATCH 08/12] odb/packed: fix memory leaks when freeing source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-pks-odb-registering-in-memory-sources-v1-8-97a312d5fa25@pks.im>
References: <20260901-pks-odb-registering-in-memory-sources-v1-0-97a312d5fa25@pks.im>
In-Reply-To: <20260901-pks-odb-registering-in-memory-sources-v1-0-97a312d5fa25@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

When freeing a "packed" source we don't close either its packs nor its
multi-pack indices. This can cause memory leaks in case we create an
ad-hoc packed source. As we used to always link packed sources to the
main object database we never noticed this issue until now, but it's
going to surface in subsequent commits where we stop linking them.

Plug the memory leaks by closing the source first.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-packed.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/odb/source-packed.c b/odb/source-packed.c
index 1d90e714e6..166e76e2d6 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -844,6 +844,7 @@ static void odb_source_packed_free(struct odb_source *source)
 
 	chdir_notify_unregister(odb_source_packed_reparent, packed);
 
+	odb_source_close(source);
 	for (struct packfile_list_entry *e = packed->packs.head; e; e = e->next)
 		free(e->pack);
 	packfile_list_clear(&packed->packs);

-- 
2.55.0.979.g7e5102b832.dirty

