Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509F341D4EA
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 10:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786100349; cv=none; b=pLsvFewlpi1ITbQ6s1HvF7jGqXUG1r9csCqet6H6N8BtvVOUTxLioMffz1dBNb243Cn/UKD72mF+f/nOHVv1otyC1Y510FXCF+YItorpT8jY2mcuiObhj8tf1c2ItHRv4UyR5OPj7pzELm4oSZhCqe0mP7Wc+7mQPDzH34HILhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786100349; c=relaxed/simple;
	bh=DVgGm20tFDcsYeUjtBJJ33atpD9JLweZrA6X71wSAYs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eOuEZsF8U1RLiQWALpQQzNDOGczGzg8Q8ZaeWa5YHOKq7v6/QLZiQ517+MC37CyrBaJ/6R30BbrYrNaME3ifIpLzkZlW/ZiZa8mfhq33p7R1bLtrWRrYJIq7kE5/9fET25dDXZcwuGQPyF3HvWcvjF8tX41OFYUTNQ6qd/loEUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TncIXUAA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ra7siqVT; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TncIXUAA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ra7siqVT"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 4CE30EC00DF
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 06:59:07 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 07 Aug 2026 06:59:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1786100347; x=1786186747; bh=HGqh0mvDPb
	wHJTgT1G4Z+XkVSxIJi+NI6ttOLguXTgo=; b=TncIXUAAbwyg5E3+6vfJlD308/
	3OMyUidFnKYiQffkPr8VLuOThfvUmvTjkPZ0MWvboU0e8vfmF32UZLpkgDf0D72c
	f6jcRxeq2AQEkuz0ieW6T6VCI8h3hrPlI3ikP/C887EVsk8ufdtP5NdRZKGv34pP
	pIQI64f23YrDoMvyctcYzsvNbAZ+lGB0HKy5/7q7wEYOVQSQMbWGajMyRcPxH9kq
	GXE/AAwju0W4JoZA6MHhIO/X+wj5a1zVoh5lAlUtEqoBge7RwVMiJ84PxNkbReej
	8J5qvt8Lk6WL/rmtIpAZ5ppetiVScSxcjjGXlXy3b+ySVW1qW7EVdNmGRQbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1786100347; x=1786186747; bh=HGqh0mvDPbwHJTgT1G4Z+XkVSxIJ
	i+NI6ttOLguXTgo=; b=Ra7siqVTAKuVk8hVvC8x5tjxrROSHhnTRgFBmrRBmkwa
	FGwhAQnXAiddmDu6CPZQMXm5LtHXkmvp8/75M2aV03UGTPEQfZp0qYCeWTSzo3jh
	QBWKQ9TywZG2rteeTsmyKlfbY1iHoxF/J7sMVF6MZM3bjEnW0GBACH824mF0CSqB
	W+uAHpyT2QywBNWOoSLQQ5tbNGUxG/pOeiDNguWwQd6yN/VJY8AdVHFkF50aXttt
	Nq8wFZU2vi3TsD50aOwNygRjpuLrnYuNXbhqGzz78+Jy0wwv2HYAFy7abPJN/Yur
	PPW4FyfzjBe1n5QayTfUlyBa/NOTLMczDCvFH63hUA==
X-ME-Sender: <xms:e7p1aoQH6dd49AZ49dhqFwBjM1cRX7NROSwSV0jwbaRTTzypkNW-lA>
    <xme:e7p1asvfSFdf2ux6se6fjPV0w8HSEgKurlAId23R46MR8dJ64v07tqtcJZ5_1L382
    cpSYwGRnNVl-KDy_2tanzW0O99JVcfZQJUhA0EWBYM6JNO_o2vNbJk>
X-ME-Received: <xmr:e7p1arcWXnjbT1YQKTFK1ZmGfqrEmgJS8H5nhE2AoXXy-QgWP2PrIsG6UtYbvlHAOoWGLZcgdHB8Wrnx0onE6ORzFLKpH3CwCVZe6ynR9LcXrw>
X-ME-Proxy-Cause: dmFkZTFD+pQE45VJyXJ7v6deOgI1nhahqDh+PJnW8JCsgs2ufBlJHviNEjaHkZgqfAZxd5
    1rNX/urPgpvT57U6FEsfPtBLlGYdO22zSvtX+67KvVSBxieqwYdo4fGWwv70ixe1S4e9NE
    Qw6SFdzfFkp7WJd9BgbOJAAD7yIYAjOaleaUmqxkuObSVe/rts05L1yy+0WE4o7rWcEyq6
    yCOCMczfAdj2B6IdVLGRuT0qy81INwii0Zy3naOa6zCGfAhuT8a9kAQzzBA1IpfYkFR8Tj
    v7FeYCHEVjuYiqhv4V0ROnaLbtbh6xAa5PDpLb3yjgyI19o6DiHH2YgxLX579Pe6an6Go7
    msEzXTznpAl9fZj/GOOwL1NBxujNuJvM+vnGWDis+er3tBe/ZT4R7Phsvr9fs7kDioPJdH
    4ZcVE9n84xaCFyt8dJyRloaWsRlS9hIbOc9gGXMlAffU0PCq20BWO3huNSQxD9w1ODxlT6
    csoUB5pT87I4Ik5hx1PobE86bQKwW0f2k+cTpxLpgdREydL9r9MJir7wnaTQGMxnQkmjZ1
    WShLBxjKwfhBejyT0ZVWgdK17TPzM2bLgu3eqFK+4UlMwCFBHL89GEe6WtWRH870MkBOeK
    aassw0/YOVDDRlmgD9fFzfUiAc0DtfURDBZ1FkxwwL2NTQfk0gP3z9/frR3g
X-ME-Proxy: <xmx:e7p1ahKXodMc3Gg2oFk-XvjT_2B5pyQnIM4csV7IzRyYAUCClPDycw>
    <xmx:e7p1ahZ0RMvoalBPr2_GwGQmoM88xnP4muk8UOWBMMhsz-tVawXEFQ>
    <xmx:e7p1akseZOYvL4JgJ9Fdd7NssHzdCtkCPZRVI4jXRuNZ2z_9cFxRiQ>
    <xmx:e7p1amtR-xGUwhuIDayaRJah1yZtfHwxG4gie_ETWDvTEsfODH83Rw>
    <xmx:e7p1agTPUZXGHk8h_pfDGLY-u0V_C3ROuHG84PBp3t37L94YWEeKIlzf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 7 Aug 2026 06:59:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c8911515 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 7 Aug 2026 10:59:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/2] t7900: fix flaky "maintenance.strategy" test
Date: Fri, 07 Aug 2026 12:59:00 +0200
Message-Id: <20260807-pks-t7900-fix-flaky-test-v1-0-08d0ea0fbbc5@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBCF4avIrB0YhUbbqxQXSTqpU4uVTCyKe
 PdGu/zgvX8D5SiscCs2iPwVlc+YUZUF+N6OT0Z5ZENNtaGWGpwGxdRciTDIguFthxUTa8LKkHX
 BczAXC/k+Rc6LM33v/tbZvdinowf7/gNEo0rPfAAAAA==
X-Change-ID: 20260807-pks-t7900-fix-flaky-test-160abfcef65a
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Hi,

I've recently noticed that t7900 is flaky, see for example [1].
The root cause of the flake is the auto-detaching logic of
git-maintenance(1), which sometimes causes us to skip maintenance
altogether when the foreground process is racing with background
maintenance.

Thanks!

Patrick

[1]: https://gitlab.com/gitlab-org/git/-/jobs/15762975482

---
Patrick Steinhardt (2):
      t7900: adapt some tests to use a throwaway repository
      t7900: fix flaky "maintenance.strategy" test

 t/t7900-maintenance.sh | 76 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 46 insertions(+), 30 deletions(-)


---
base-commit: 2c78326f810173a4f3aefd8021f1e07575412481
change-id: 20260807-pks-t7900-fix-flaky-test-160abfcef65a

