Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239D048FF88
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 10:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791453696; cv=none; b=iBeXeLgWZ6alIY7/jOc6UM0tQ5cBnVw30wQzWU3DSCkftHqFZB/4W+kaGG6lYZeOqtKgKhrgvnSJAcXCRALFr5jIwWvpFgh+4kwIky/LqiXzWOmUxqCfvCSefLCfYPWYx0d0/AGi/t/Fhr5ZLLpZbXdzsH2fVxn2E6WOV/g95W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791453696; c=relaxed/simple;
	bh=wMyv5sMOAk1I8/FbZDVP5+wqwNEiw2+RqscgcX6yDBQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QlZZJJ2v6k0YDa5a2fY23NWXoEd3SQ2MOq0t6BfZxJC1Gg4Y7Lgt6rFUxa3BY5WvIi16jqLtNzg7/i+ki/gZJlehOJ1jTT9Q4xc7dpfG2tttXsqJ4wIUEE8/JIaVCEl/vaV8Rk28isSjl77RJY74PGFlzf7TChZJg3u9HreFciM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OrHKe+AD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XqzcfQXj; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OrHKe+AD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XqzcfQXj"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 058CAEC00FF
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 06:01:34 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 08 Oct 2026 06:01:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791453693;
	 x=1791540093; bh=ggl7+/WxG3t+9r46hjuvZB85vwravDk6fml2TyaZWo8=; b=
	OrHKe+ADW8ff5LVNhJyeXCwlGt4xysC3ifHT2FADSzeyOiS8R0LL9uZJ6iJRUAa8
	dpOwoolNYmh6QS4DkDBUFOdKANvC3lEC7yXCAt/qPULIUTCHh7jxgTdT2sr2jxiC
	cdBs8Wgk7D1zxUbSygHOCYRcqMjco4YqfcFsm3g00m7FHfVHJOCNGwOmwN5xDSs5
	7R5eEO58UKkzKtqdo7ZMqVnB20nUrMlcHPHFTRR8P4a3HmT7AxCtUWTgSN1iuvkV
	E93rkTebdlQf3SNohPbUiGVUzvY8TdHDRwKucLdluSrP/lW1pjeRqdyYcrSLKSOv
	H1xf1C32UjsbSCoLb9BklQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791453693; x=
	1791540093; bh=ggl7+/WxG3t+9r46hjuvZB85vwravDk6fml2TyaZWo8=; b=X
	qzcfQXjeJOEtgctS2osel5wD4XxgODEQHPF4Ej87K98TGmiYtfEdY26cooll+xfz
	JRnbbMeYOSWAduqD0+HtDpPvPYUX/GlF4RiUdQ5o8iAwYYKatuH0cW8FZ7hvn0Si
	gqO5CTQx58v/W5hXhv/aYzyCGEZSkg6EXZTsfdqTcVj+N1/gAr7qDUUc73CY142R
	BIeeMRb3i9kMDv7VE6Lf9bnohjfj4v+XjDFXSORCnMbYaOD3at/8CJe+glMVV/aY
	nMIZ3TlfRTAragZxIjfbtV/+FP+Ogsqb7VjSk9Kci6JhmUxSrMck+7AL8hJa8/ki
	eknnKnUd/wQLfOunxrE4A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791453693; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:NaPhhuJIwVWtwhY4bYE5Ilm9l7ketEgCr3/BGCc7D5I+hY/
	gZnUD2KcnUsyNsTyAp965Z4F5TX4RCJyCl5qDbU4Wn3XrVgj6NFiZSqWeWGt0s/A
	mgf/985riRnKFjT/RQmMBX2x47cz19BXRLbZnMo5j5nAaKfr5e3keqPHv/8BOI96
	HLQXMlqcO0/GZBMpC1CGMwDohyuUv5UbnqmAw/clUkWecuGBYRNwsV9lZW0zfEl+
	17V3Lbo7zaHno2efPvEmU8VvJcm5GiMsskkbhA4jGIjnMp5UPNQ/yuW1f1STiNY9
	m5zBNSEunUaqmaZKlf3kLjNyzVtGE8sWvHHCNnQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:c8jUbxRwioWgp4qvjOdbliSJc9gjiEU8+rbiD2oyTdo=:wMyv5sMOAk1I8/FbZDVP5+wqwNEiw2+RqscgcX6yDBQ=;
X-ME-Sender: <xms:_WnHahQ4S1BV4GUH1_nhtW9_wX6DAM04Mh_7hc7fY1TAhIjr76LxtA>
    <xme:_WnHaiPQqoDr27as4wsnkKNqV0v6l_lpWMFaOTwRDbepi9P26hgaNqTepnErdsWRD
    RLVFqvMHfg_0eBsFxBqsQDm0n2x7nwHjDT7dTRs1e-9euspG-Imq48>
X-ME-Received: <xmr:_WnHakMZfK4F6zvTOSStzJDCWeU0p4bEUFpDUlhMNByHpclwRu--aA>
X-ME-Proxy-Cause: dmFkZTFM6ftuP4DOLoqyy3KouLyF6qZyzpmE9dvjtChdfgUMA6B/oLo0lzuUj5oruLPxSJ
    XyyZHElFuitD7Ehl0c8Q9cS0izTMXiocDDDG8SIYKjxvTy3l1kafihkKQluaoEpKImE+FZ
    C2bcvBA+x5wFX9xQGiMQQed9L+UY3z+Pcllo73MHxL8Wz56CmFzaNcsZtPKWedCPGFySyb
    lgy4tqyZhCH+GlfnXN1u7ZGS7bjwtUFPWVngmaoRHha2Zm9HVGmahRtv/snQSVc76cTata
    G7Ne8Mj2hZlQIz6OojcDB7ZXJi9bg/nHrWqeb9GUFDgVkVNnqpyYUGuLteRl5yOK2XdRkM
    NF2EjxZvQpJxf2KW7RFbEzjdz+NgsCS8+1qXAOwIujmgYGeDVcgAHVntG74jaL431tNIYc
    de7hGCjN/321QIsLIADtwOLESIrGspo0lXwbosVtXwncWPfn0MIzpP5kB1NRRtUCG+A1iK
    BIAjCaGWS6p1cjL2ubrS3b9DG8x2DWTg7WQX5EsIAXFHalztGsrWyoalukf69JrQxBG2fk
    pKSsgQ/fOenfOqalnbI8xhwva6+MlOJPRFC6vW1s9mGV1gsr4nxeLTTQRi+2/xOoHPrxRl
    Q0xXyXwOf7XhE0+m6/qLzCwv7DGNl3JeUB5PlZbfirVDk+NEjMy0HQjcV3ug
X-ME-Proxy: <xmx:_WnHait3FxaHMIIHEQWkO8LvOLzAjaqgIxeeXJhsDByIpIYpyQlUhQ>
    <xmx:_WnHauXaEw2iQnpAK_RGdUwfuANtN19r07qps5rPfA3BTFu4Q2QNmg>
    <xmx:_WnHaqtyy9PFf9b2vaJnwuiPm5RuWv8AhP08wRp9c4oVjnpBVU2EVQ>
    <xmx:_WnHaqV-HGTcAJX5hhbhckkbYQn4uWWRsmIJnxOIWsGKfW3q5pmSUg>
    <xmx:_WnHak9Pvp_rmkdo70krkNb2ynyPk94ht_RIzzngxVynpwGRQ2rVBpoG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Oct 2026 06:01:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4fc7f60b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Oct 2026 10:01:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 08 Oct 2026 12:01:20 +0200
Subject: [PATCH 2/8] ci: fix "fedora-breaking-changes-meson" job
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-pks-ci-housekeeping-v1-2-baf015c589c0@pks.im>
References: <20261008-pks-ci-housekeeping-v1-0-baf015c589c0@pks.im>
In-Reply-To: <20261008-pks-ci-housekeeping-v1-0-baf015c589c0@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

The "fedora-breaking-changes-meson" job exercises Git with breaking
changes enabled on Fedora with Meson. There's a typo in our CI scripts
though, which has the effect that the build does not enable breaking
changes by accident.

Fix the typo.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/run-build-and-tests.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 6a3b43b366..bc5058c917 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -18,7 +18,7 @@ almalinux-*|debian-*|fedora-*|linux-*)
 esac
 
 case "$jobname" in
-fedora-breaking-changes-musl|linux-breaking-changes)
+fedora-breaking-changes-meson|linux-breaking-changes)
 	export WITH_BREAKING_CHANGES=YesPlease
 	MESONFLAGS="$MESONFLAGS -Dbreaking_changes=true"
 	;;

-- 
2.56.0.406.ga2d225a756.dirty

