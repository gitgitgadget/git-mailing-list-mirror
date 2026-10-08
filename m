Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE0D3CB574
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 19:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791487743; cv=none; b=WqSYdZXbOPhj4Sb8rBt1PzORAk8w5ku3qvyG8/VjDBdf8tMtNugnJR14N90GJlaoPEBBO541rp9Ofb+hqM2sZRnsH2Q2StQRqvs1Cx7xsMb7Z/WAmnWfQfaKYVrWwFsaDqC+rue7fqeYwwHiFmhQgzst57lrbvCnfViLG9yw3iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791487743; c=relaxed/simple;
	bh=ToJjR9rE6kHQ+irRi3FOITIlBO+K4L31LGerrPguS78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VO9SiVg57rwD1E7KyIFghaqzL3eLC+8+/4kkMnkxSmHk34WW8DaNKNQ82sXkYVzg+FJiJxP6XZ1jbqlzGYppFRoBV1YB5ATScognEJmCx3gS3cdE9ectb9pZwvh/190GY+wl8tdXWhXjariOMiszoVlmhOpvYwjRDL8NRHo5W0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=U0SrqIo8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oYU8hVCj; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="U0SrqIo8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oYU8hVCj"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 253D2EC031C
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 15:29:01 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 08 Oct 2026 15:29:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791487741;
	 x=1791574141; bh=dvSJzjfHFPwMWOrEVW6HiF/BsG6GOK9L/YtulaTRQ4E=; b=
	U0SrqIo8ENpgle/3cYhgHQ3IvJbKftGKswfwRCabpMn1SxEoeg1ZJpFRvTnR0t2P
	nRqYL3TY7G22jEuwkJx2ypOPbyPcRHN1QjYxyDRyr9oBwTf1xwe/bW6Z9xZVtUA7
	ikoWJDl4ghJsf3tXIyXDkhp6N5GF/g4shJdIFGF+kW0ZieP3ADrzHVpoezDOzhZT
	/UYkqI3oD4AQc5ioEItBaCKHVRDZYhQUdZYQAQjprN/xA4QgeyQH7UmPdhKrL5dv
	Z9brRIP8bdAsLJP7a+l25vdHdWuz1T+zs25fEpgSugu4sOAxylROXPfo+Q56xEa2
	UOHxmqe0RDebW/p8OzWaEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791487741; x=
	1791574141; bh=dvSJzjfHFPwMWOrEVW6HiF/BsG6GOK9L/YtulaTRQ4E=; b=o
	YU8hVCj/leusPX03Z9jd9Zo1c1KX6+HC5oH7uvK6iSBpTD3HD2bfBWiWwUb2oOnO
	N1sQdnKd237VaClHSupTYAohXPEN6RyLXG51ovTYHdC35YzTzel4wcAlp8Dig/rn
	GpwcXyFMlxGHinkxy+dQ021n3hIZs60L6ElfXARIgFM7ORud4NXaCLKyOB4fpmRT
	uNmuJUCYq2UNoIPp8OFJkW7gmCB8BfjR8cA4Ks5FdWL+XdDtNe4c8sk0V8E2oIM8
	KxXYo2pu4m6nftUzvc6prz0V4jHjjnmpJQVFW0PFjXimCEu0TbBRrnYN3bYDQs/F
	SNj30+WA7YAaeHWbbaZFQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791487741; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:UmqG4plbI7onKTPJjhiiaDNSlINRcXmY3aT1qzBwV05uMqK
	3n1TwsFr+wm3MmRteoXfUI++JaBqKRVItE2ku6gEPDN+cQmSaZ95GpnPOUHxEpxd
	U1NIjlsn3vPlsg5tp8FWrEss5XgiOtCk43xhNApe7H0/nMv778dsCAIg/a3PcoAa
	1CE/VSOee94607T5Xhbg75ndJU1JhQoELyrDmXNoOWuSWADc1a5CvaXYqxVAuEmx
	EAZGyf2K6iYm7+Q/AFfTWi3GmK5jZKThQPu/JB3iNqzX69BwCn9t2hWxD8Lteo9M
	IJtJ7W6XFUA1I0rqjN0Wrh0/5ovec+0Wr63RgEQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:hm5S926y4OdB7NcEcDhbil/0mHGguCABHyJk+ZSJMCA=:ToJjR9rE6kHQ+irRi3FOITIlBO+K4L31LGerrPguS78=;
X-ME-Sender: <xms:_e7HakobZ-KQPJHLMb8Um0FeW63R_O38I-vbBqneQI6XrVKKUYTofLY>
    <xme:_e7Hahrb0b_gRDjsVoNRTLm8yVHD53mCvPVo1x6fHLIPzHAqH2UmutKoqYpcF_VaM
    LjcYbIRsDkF3O8OdqglUDtF7Pgqb2PQVabZmUsj20DUeVCli71Lbbc>
X-ME-Received: <xmr:_e7HauOzFS3A5dkL4M5fNgXSZ6LeeEzjtz_NzPcTY6gEf3Xcty2QLFocN8tDRJsShWQYD9frjF29bAcZN_RmyyK2INGiwL-XWE1IQRdJD7w2E9gbepEgpJo>
X-ME-Proxy-Cause: dmFkZTGB+uPsGxAVpx8HDgbPj3bD98k5KeivRy+i3QijGldlr8/eCq09jjeSGKFnTZ/EdV
    YZ2ciL0lynUwGtN8xgfPg/PIc4mbTOw9aA+wSXfSaLpPWqKSylAUxpsTiE3YsEkuRA8fAU
    0kX98vEzlb2E3fwTnmTEIT1be2walK2l2xVLRDJldiOm7K6SCns0vJuPpGHpi6EvCheqHg
    KcuPvaZIul9lZOUaXirjBP4Ct+e0k8aTJ9Iqi7lFSJbTN3UiJ6Ckl+hT77X+A776Fo/FR7
    YZr+JBSFzBkK04+ryJqs+pAL5woi4Xs8Y62XfcsNbYwqZMe/FPuK5Xo3pRk/GUfoBfIfZh
    LWxkU/1OkmSQJ1JMeczTv96ImXYXpvfauv8WAb6UWkjqVNDPSN4uQTKsRSUrzrL+aQmGf/
    nIcsvzLZaMU4D0SRtCDgI6oRaCANEGnamr1U1ZcIBooppNK1OJ0fnipL6htEDeLMhvW5L0
    6qLVgktc2DHLUXy/H9yhPY1f8R5ZgMM27ZCEks6qbdKabhREbTjghEnMOlH7fV5Bbg2CSE
    5ym2oxd8vT4Etkjv0BUMTfIzR1ijfMtkFmkr06r4Yh9cXzkpkd2+cPODIDUtOnqlm8Jxk5
    1fY5pM2QSCFHV8MFG+nYaGsWQjqvtABn5+G0gNgeTummEYuRH3zPaNy2HqoA
X-ME-Proxy: <xmx:_e7HaqyXPzolKJY3UxyucI9Is5zoQmi5QhzKtAbjS-NQlkEVwS44mw>
    <xmx:_e7HavtRKZd61N1Xk7KlKkTTRH-WjScDVY4OiIKi8r3RpBIXQ_3srg>
    <xmx:_e7Har63OQjH12sFCsazDzPkM9fDbZQA65xEkdFUx9xX0acddu8BOQ>
    <xmx:_e7HamQDuwr08rEkOIUVs6ZBJRwfmC6sHANylenIp0NqnWINQiNdfg>
    <xmx:_e7Has3VAa9EwzEASteaDwPtkkTqHvdFC25yXtbyXoBIh-SoSFf-Tw-K>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Oct 2026 15:29:00 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 5/5] doc: gitbreaking-changes: move new-items discussion to the end
Date: Thu,  8 Oct 2026 21:27:20 +0200
Message-ID: <V2_move_new-items_disc.dc9@m5gid.xyz>
X-Mailer: git-send-email 2.55.0.793.gc667de3f2c5
In-Reply-To: <V2_CV_gitbrchanges7_please.dc4@m5gid.xyz>
References: <CV_gitbrchanges7_please.d1c@m5gid.xyz> <V2_CV_gitbrchanges7_please.dc4@m5gid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

The target audience for this page is expanding. That means that this
discussion about how to add new entries will not be as relevant to the
average reader. Let’s move it to the end of the page.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    • New: <ar0OltAkeTiCx81c@pks.im>

 Documentation/gitbreaking-changes.adoc | 30 ++++++++++++++------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/Documentation/gitbreaking-changes.adoc b/Documentation/gitbreaking-changes.adoc
index b94759260d9..e984c2c8ca5 100644
--- a/Documentation/gitbreaking-changes.adoc
+++ b/Documentation/gitbreaking-changes.adoc
@@ -54,20 +54,6 @@ breaking releases. Furthermore, this document also tracks what will _not_ be
 deprecated. This is done such that the outcome of discussions document both
 when the discussion favors deprecation, but also when it rejects a deprecation.
 
-Items should have a clear summary of the reasons why we do or do not want to
-make the described change that can be easily understood without having to read
-the mailing list discussions. If there are alternatives to the changed feature,
-those alternatives should be pointed out to our users.
-
-All items should be accompanied by links to relevant mailing list threads
-where the deprecation was discussed. These links use this format:
-
-  https://lore.kernel.org/git/$message_id/
-
-I.e. they link to the `Message-ID` of the email on the mailing
-list. These references are there to make it easier for you to find how
-the project reached consensus on the described item back then.
-
 This is a living document as the environment surrounding the project changes
 over time. If circumstances change, an earlier decision to deprecate or change
 something may need to be revisited from time to time. So do not take items on
@@ -382,6 +368,22 @@ Cf. https://lore.kernel.org/git/xmqqttjazwwa.fsf@gitster.g,
     https://lore.kernel.org/git/xmqqleeubork.fsf@gitster.g,
     https://lore.kernel.org/git/112b6568912a6de6672bf5592c3a718e@manjaro.org.
 
+== Adding new items
+
+Items should have a clear summary of the reasons why we do or do not want to
+make the described change that can be easily understood without having to read
+the mailing list discussions. If there are alternatives to the changed feature,
+those alternatives should be pointed out to our users.
+
+All items should be accompanied by links to relevant mailing list threads
+where the deprecation was discussed. These links use this format:
+
+  https://lore.kernel.org/git/$message_id/
+
+I.e. they link to the `Message-ID` of the email on the mailing
+list. These references are there to make it easier for you to find how
+the project reached consensus on the described item back then.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
2.55.0.793.gc667de3f2c5

