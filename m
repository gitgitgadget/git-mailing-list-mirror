Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E780A3FFAB4
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 14:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774363960; cv=none; b=c25pmsxTbX/z47EyS6nTXQj0xJoo4dK1n/HFABy2NwDagrmDXO77+/ILVnrLtcO3CveVcMMVl0WApCTQlouOkfXwfhaVBG6jQaic1V7QMJYQ7X1psHtlZALExB0A5ka+tHi9g5HCerFXgHw07UgViqbUuA0kdXXiUnSJWd+i834=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774363960; c=relaxed/simple;
	bh=6zrywn4Tz2dY7MGSaxWDXbef0lE4YWMBuE8dRk5BJAc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=twfkQEfY9rKjbNOeFAyiNgy89ozF06eBqCWVWeKTNa3TMF7HkCk17VLsyL1DLda0mxWOtmiJJKt1b3FcYOLnUiOgm5nDgaXeoIPUkHfSwk0uIowTMlixkXOaXU0mzir2+uMTe4PFD8zKQMojagtEOTcItSTvn0uhU8EheMBjW5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OgBXoY2s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sywVCS2N; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OgBXoY2s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sywVCS2N"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id D57C8EC011C;
	Tue, 24 Mar 2026 10:52:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 24 Mar 2026 10:52:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1774363955; x=1774450355; bh=93IjoWrmyp
	eSPZkFK69QpS5oKNrm+IQIyGzhA6QSyzU=; b=OgBXoY2s7pNny+lbMHxSH0VHU6
	2jdzNMDj6ylIZgn/yIVSNQgOlALYhUmgnry5o7MKllRRQCVDJl2cilL67PcHe3MZ
	HZ2sxxUncdU7vSzV86OxOT8j7g4mem90QXSYmB2aqyaNV5s81YKWj8bPObalGGTM
	QlCHQjJovE9CQR/JNKYAph4R4F53BUU8TpxPvZ7BWIia9jdsYfnIBg0iZ8iWCf/d
	QUs3EXLsDySlyo5Y06lYyhExpBrvexoiqXk/atBFoPKSPPfOE0DGoiBjKkWB4WBC
	LLAtFEZORDgni3hAMkl8aNZnHUijDd2bCGTaVx22KYXNGTzexPmTqIAXZwDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1774363955; x=1774450355; bh=93IjoWrmypeSPZkFK69QpS5oKNrm
	+IQIyGzhA6QSyzU=; b=sywVCS2NtaTB5bspRHmeT0mn54rGi404pz+dhs9+B0S3
	eKMgiSh/NvWiaslP50J5QX+S5uxWn0AgOLOVdZwbvQnrCH/5TOj+v8pcvJUwLpB0
	A09UBeCMO1AWB1EkYWTZXcizKhGjROw6FA0QuUdy7XT5FTkqDjoAcVp2xeISBV9k
	MBr88k8JbVaF3i4LdyWedQwXybAwEpy5XzXyeWFrXK1ZIGApNj6UD+jrq3zYaioE
	RK4W7rs7s46s4ZvMaFjyXQlAx8V3eU7DJDAVWsHbu9Gl0GrNzwvSAFi27vMACvjN
	QsLCz2Vd5G9b90M9unqi67YUach5KyIWo5H2PDCj1g==
X-ME-Sender: <xms:M6XCaScMmLiJhy1sylFSgKEd5KJXbP3kGYtG8Ecf2Qtjw1uruuOrIw>
    <xme:M6XCaToubusn-ogZZG90USzwWP7jkDTCdBZJLQ1wRhlxqjT05l0Oh5ilo60xtPdzB
    PZ0qGECbyRrrT6KfJbkT7I5Ef56hGxacBE6QUFJbMJ6rK1DEeD7OQ>
X-ME-Received: <xmr:M6XCaQ7TZ1lYLbda393rUVdD5ROlEP3fPZYbo-57Tyn3NvdIDT2j2KeIDjJY8OEnLF1qXmCwbkNf7yK6grIe4_IDRSo6Tc5uCREdgW-V9bwqOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvddukeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepiefgiedtffffvddvueehheejheehleduudfhhe
    ekkeeggefgueffheevgeetjeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehmrhhoihhkseguvghlrgihvggurdhsphgrtggvpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:M6XCaZr0hfbqrvUFm3PTDhjvXbqC9YxP6neswpDO_n0KNaSQJgGuSw>
    <xmx:M6XCaSj9JMXH0yijVm6fqTPIPymFE-dU5gS6XaMKanqUxXcVnzpfTQ>
    <xmx:M6XCaTI7o0dICQyz4ZVCa0TgkYGOF_0Bqktnbe8q9b_gOHsCAvPAYw>
    <xmx:M6XCaSAqmoOD8nF_EESB4_LC3MTugDD1bnOQ5B_Q-B0c_NUCDg0y7g>
    <xmx:M6XCaZOisTPO1WmYZEjcKQ6h-Vin9UeZI5qdawvOkBAunR4ZSaoCEC_v>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Mar 2026 10:52:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 52f1788f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Mar 2026 14:52:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 24 Mar 2026 15:52:30 +0100
Subject: [PATCH] t4014: fix call to `test_expect_success ()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-b4-pks-t4014-fix-test-execution-v1-1-ac83c1bcc828@pks.im>
X-B4-Tracking: v=1; b=H4sIAC2lwmkC/x2NQQqDMBBFryKz7kASg6a9SunC6EQHwUomFiF4d
 4cuH/z3XwWhzCTwaipk+rHwd1OwjwbGZdhmQp6UwRnXmdZ5jB73VbB4Yz0mPrGQFKSTxqOoi9G
 laPshBJOeoC97Jl39C+/Pdd3H7wqzcQAAAA==
X-Change-ID: 20260324-b4-pks-t4014-fix-test-execution-b2fb17a880f9
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

We have added a couple of new tests to t4014 in 6005932d95
(format-patch: add ability to use alt cover format, 2026-03-07). One of
the tests has typoed the call to `test_expect_success ()` and instead
invokes `test_expected_success ()`. Fix this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
Hi,

this fixes a test bug in one of the new tests introduced via
"mf/format-patch-cover-letter-format". Thanks!

Patrick
---
 t/t4014-format-patch.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 7c67bdf922..4f8967e283 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -393,7 +393,7 @@ test_expect_success 'cover letter with subject, author and count' '
 	test_line_count = 1 result
 '
 
-test_expected_success 'cover letter with author and count' '
+test_expect_success 'cover letter with author and count' '
 	test_when_finished "git reset --hard HEAD~1" &&
 	test_when_finished "rm -rf patches result test_file" &&
 	touch test_file &&

---
base-commit: 927a571e75d06037d46dc9ef5fe26b0dc37bbff6
change-id: 20260324-b4-pks-t4014-fix-test-execution-b2fb17a880f9

