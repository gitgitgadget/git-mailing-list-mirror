Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6833EFFCB
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 08:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780995090; cv=none; b=PzOBJUDxZS5pRQ49Bd+C0LulqdLWjVpRHceTZBz8QlsnPEKpsATQ2XYuQ67upncFNaQV4LszdpbaqKR6KNG40MzC3QRzexS7Mdz73DjBcUS5/AYUO7IugLspS3bRKIB+ge4i8GHliT5XwFBYqIYBd9RK5/cATuCM2wKsiV9DGFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780995090; c=relaxed/simple;
	bh=RPQTtZm/Ys248dvX3a0tirrGaUODGIjyZoElkClc4cU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AhEkKI/1BM7DDVNYwA+Se7G5p9/UrwsQtPH254WjISyEqAWPSA3HSlK3I0CBNmMMOzO4dbTUkzX8XLDFJ49Go3sQBob7JdfHSufPRqVw1rVzMEvuIUMJ48JzlbHa6iJ3pOdz3IFlhkDuJI5AfD122QPB+s9VJq0HboitSGaDa38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MnrSSx9F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WwZc4yhJ; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MnrSSx9F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WwZc4yhJ"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 22CF21D0017B;
	Tue,  9 Jun 2026 04:51:28 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 09 Jun 2026 04:51:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780995087;
	 x=1781081487; bh=/7apvoSUg/s7HXNeqJsmaWX3f8IWG4MJ3aXNlUAkVQU=; b=
	MnrSSx9FRq0NqPdk9NWdCPh7enLG5AFXFJyHNRnabvBX1Qx165/gd0sQZzZjH6cl
	jHe1jQTd7lHTY/HOXlPwi/29Q+SEmKEWcUzGMbvu7k9/4LMspA0ERQOXjGewW2HU
	XUIBnC1cw7XmvW9YFDhs0b64JkfJc5fSP/holbT8D88Wm2i8yYyAaC2kDAMmB4qn
	tEYsQiYgy3Ja7yXJNuusCE3zHLSQ5OQXK20QN5gzWNLX9lo4RpxzeQ8/AhpHEk8Y
	CcE7Qd2UrFZe0u2K9T7Bc7H2Qyed+Tpnejp6X2r3u68khzDMjxw0K6LDyVij+5mA
	8fHkYmPYHgka/d2U+BNKkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780995087; x=
	1781081487; bh=/7apvoSUg/s7HXNeqJsmaWX3f8IWG4MJ3aXNlUAkVQU=; b=W
	wZc4yhJRi0C33usPBRIp2HFAe0DDF8VPbsq013ToGmB5khTojffL2AAWRT98lHdM
	TyVr2EMGPMIzLtdpJdk5G6CvkB/oyRarSlV+cpnDw8QjaDCGnWnSTnAY/eqlDn2w
	X0nk5AtEhWpZN2M/ip2uLxkN95kuFPggtNocM8fjSIfSiSKa/KpNufxcPdNMSIo5
	OHN4KdoJRZfF9LDXM/cJ/yyuJrYvt+KX3gNSYIbr4U11/htk19pd0attQii0hkDK
	jN67D6SenCgKtmR9tHzTeFNz7TJ2NwfcW+hyyVYFsnKL3JaM/CdWLg4qGKxVaemf
	34Z05VMB6dpLB7i+rFTEw==
X-ME-Sender: <xms:D9QnanghDErviwMA5cIAa04xd4XZRMUIcvqSacrGYt6_JjVUR9QbTg>
    <xme:D9QnaqCvbzBVbjTKlSiArQNm7VVwZslT2pY1pZ1BvK9HU4prTyoMLuysLZvq5lbxJ
    DZc50kbzjO96O_QtlFV-cQmODJHl1m5fbsnoTO3iqmyzdHo9mhD1Lk>
X-ME-Received: <xmr:D9Qnakt9INNjtfGbxeAw8xChW72qs0lGdpdrvwvc46MysknZdazuZpI5tyYYHX06G7NDXs2BpAZJkMJLJLOmo_wja9uzuy__V1aUX_7QP9A>
X-ME-Proxy-Cause: dmFkZTFScmXmBNtXOl4rqVqM8DAc19fyHinqrfJGsNjV/CE2oHckwvnGyvDfLnNUuwKybL
    TXXNE7zDSLzm9sqK7QnFjZefXQ77hB0yUpUORZINqHtbw80x5HeASQHzHrphN1o87wLUDo
    o+b2Dx90Cc3HLmwbZsks1v5Qe3wgVjPUMwX4Epw71mRv/T8ItHrE8RkWZrv81HY9CRlc3Z
    /OiNXFOpQwrN765XqADbyILD80acXbo1GJdpcquKP94bmw57TBOmknCC1tOk25qwSfgaav
    egwmPIOD8ZPaE7+A6cnzDiyYUxaYdFHC73rr/JrclTuz03BNq0lnxnglgQ3GRx5+ugY1cl
    EIz6bLBgq5e3lOKwC/vBh98bfxoq7lPfa7RAzXlWa+sIPGS6qwNPbfBF5OMZvDBiS0n/L+
    /WEIqIbYxmkX3xDOmFksjpaBrzixDGFQ/CNS39TihpYcMg+cAnOe2aJL5nvoWUKFT1MWz7
    Wr1owld/cHvoEA+7krvwt2t1BsMnxQCkPrvRRg7h/+EOV2iHktT0n9ufEaZ+0U/1Y0b/iY
    Yo+c6/d8FzhO6DzYLTykQJrPxhidNy9vm1YQPVtX29lpqg2RqhZUGDde63MOn8BK6/llSM
    0kaLgN3NsKwDaLLpAVvysh04q1nGwgpWUwrZlmA5kn7uGZEWttRbComPHS0Q
X-ME-Proxy: <xmx:D9QnavYDZcho2yoC0AwYQYHX81jk74RRQkkEWM-g10PNj4ElDExvGA>
    <xmx:D9QnanUxIPn9-Db56INU6O0RDXoKCQgLGSxQ0JO69IP2DQSsKgz-lQ>
    <xmx:D9Qnaj4YmKoswYx6TFs0qk2q1AKso_L5NSbuS4FKUVsZxh1-ckDrgg>
    <xmx:D9Qnaii5RkHz4vgBw8D5VXHUtxEt5hr4f4pwyI70F9k1WycWygJhfA>
    <xmx:D9QnavRzJulHh0SvCGw1b-KM8hBCuh8x96hwH3IuPaR6DEHPfWpAY_4I>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 04:51:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 61ac8791 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 9 Jun 2026 08:51:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 09 Jun 2026 10:51:01 +0200
Subject: [PATCH v2 08/17] packfile: use higher-level interface to implement
 `has_object_pack()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-pks-odb-source-packed-v2-8-839089132c8b@pks.im>
References: <20260609-pks-odb-source-packed-v2-0-839089132c8b@pks.im>
In-Reply-To: <20260609-pks-odb-source-packed-v2-0-839089132c8b@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

In `has_object_pack()` we're checking whether a specific object exists
as part of a packfile. This is done by calling the low-level function
`find_pack_entry()`, but this function will eventually be moved into
"odb/source-packed.c" and made file-local.

Refactor the code to use `packfile_store_read_object_info()` instead.
This refactoring is functionally equivalent as that function will call
`find_pack_entry()` itself and then return immediately when it ain't got
no object info pointer as parameter.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/packfile.c b/packfile.c
index 65631f674f..b35afd7797 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2049,14 +2049,12 @@ struct packed_git **packfile_store_get_kept_pack_cache(struct odb_source_packed
 int has_object_pack(struct repository *r, const struct object_id *oid)
 {
 	struct odb_source *source;
-	struct pack_entry e;
 
 	odb_prepare_alternates(r->objects);
 	for (source = r->objects->sources; source; source = source->next) {
 		struct odb_source_files *files = odb_source_files_downcast(source);
-		int ret = find_pack_entry(files->packed, oid, &e);
-		if (ret)
-			return ret;
+		if (!packfile_store_read_object_info(files->packed, oid, NULL, 0))
+			return 1;
 	}
 
 	return 0;

-- 
2.54.0.1136.gdb2ca164c4.dirty

