Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EBA39E17E
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 09:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783070666; cv=none; b=aokYiiAtrmy49Lt3z9hV4zwFkS6KorNVdZNl1Zwv837g+kQ0zNkf4MYIsNm/KEUB16C+Qg66mtw+munKIF4uQpNe3pW30ctc6PB5rCloCiF34hXcI3hjKIbJX1aaiZT0uBlRPYXfdAD/XWlbo35wLsE98sx259gqtPYKg/xC51o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783070666; c=relaxed/simple;
	bh=oooeUt2TauJ4JIg1uQv6YVKocm9UZlZ4PMf5Inbkg+Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hNCwdUjRK+Vq2QyC/Z8CjW9g9aAiCqtQnFVBTE5S8Jl8iW28xcySYOrrDAJsI7sMLQ2oCdySSZhTGAkiITjz9PY/iTeFLKoZ5YfWSDZqTU8+dvH2pBq1B2R9fsdkkP+YP3HmGBflHJGWzrhgwWtgzrsqfgp9Th7MPGinSERMvcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LsY1rrCB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZmGuLr4h; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LsY1rrCB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZmGuLr4h"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id B36391D00105;
	Fri,  3 Jul 2026 05:24:23 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 03 Jul 2026 05:24:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783070663;
	 x=1783157063; bh=aOQ/InnYuKQyqfx/K6ZaIklkwunFwlc/kObL/4KIyDk=; b=
	LsY1rrCBTu+JG9olmeMbfKEeqOot2BE74s+AA36lzCZMZ4OzBRcZhfgPMoUzcRTf
	+C/vTbiMYqEoah5BbMPmsXOQKpO6ORfkUWQziFbiIZxXMlMJlEhvg7jAP45NblcF
	xxSE3GuMMiuHORLz1Mmb1Fpo3ki77wRmdpOz6gJy7SibAqkGlYSc8Za59AdfL+oB
	v5Y1jVyDbpUm1mikHTM+yCITwwud33ZkSsystkDvTx3ofqS+D40wwAJqLMPtU5bB
	mFEc5cXSqnbhAw2FgibDMoEsloawMWSRDxqKzUTuN04EtoryGOP002TxgE7KFB8Y
	HH/WeYtmhFOyBtH7286qRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783070663; x=
	1783157063; bh=aOQ/InnYuKQyqfx/K6ZaIklkwunFwlc/kObL/4KIyDk=; b=Z
	mGuLr4h5Tz+84ECSaTtBLCYJIS+MJ4dxGvIdtChtAzzqFZicxEeAc6Gcw5gXZVVc
	XC+zfA0lbxV3yNQfhPgTvkEhKE/dTY4w6SNJG7FjGm9056sPlaMsuTq0m3wyIEDr
	/xtUPXTF1goErwdGtcd+jJqLQ7FQrROF3qlAsEFhVtbwh2d5//7DFhCZx8Y9wje6
	0BnYG2juf11UV/7S+GKJa4oTvjtrr+4fJ/BRBfeCZ/VMlvnLBboMXcZz/yHNUmBx
	rzxXZgIW1wInqFR/86hjCLtxwzwn/8JRiepOr9rpuIV3fVrIwECLC8JjyjDFmaSm
	a1V2EFf00nxpuQO0MQDBA==
X-ME-Sender: <xms:x39HahhmJP0EzY_YmnJ5qZYmCgUk5GWCDCVjUVnhXHjRAKHvYSe50A>
    <xme:x39Has7uhYXj1cNlfY6uSXe87HP6yLY-ry_HIatUt9qGVVsfhAyMpWtrF8YeOwboJ
    3MHnXkrTaihJkt3TXXGTdqvZEst2_zunyTQi-RrgzcyxqgDPmlg>
X-ME-Received: <xmr:x39HapZUjps4ZgJeI0WGDaHrVr999HW4JjSabgfwtxMsG3h5IeVfk0ocERbE4LtEwNSqqx210tcP18sWSwCYwy4Pti1e6G4ukeg-mHhFWQ>
X-ME-Proxy-Cause: dmFkZTFabOOUVHYlTeQsMyAH9bXrP5tP4g7TtI3YXPU6qVJW4xybcjXGcBB/d8YFFD7PDR
    GTJjJMQxG1Ep7ek5Q1B6kLNCuwqHXKZCZWD+f1ToEimbdsAr40LcQqtlyZ/JP74GDKow+/
    0P4OGksevwqrp91fLzDIejw9a76MnFa/K8dWxX8sI/E8Kbm9p11kbry+Y0hW3sEUidMCgC
    VgnC8Dd36aIefh/M+PX4rviAZjFZBP8NdGjxQVD7ISek+/7q5NmRWLoh9GoDXr1NaZFkkE
    WlA0826UkfsEvcde54s5mb+xh9UY3S2PlDRow5BPBzMzn8O68BFXw6a3WVlDwlIYNlekJf
    wspYd035kZ1JVoMWRfjF/mIBigTQcxp08Ws8JyDlvt7da8RStkoWu3autU6wdkWgIHGhw8
    9w5ee7BiIKOqzNnV1rYK3Gcjih9d/PQT0R8NUop5cqfqky6GVgn9sAn+1hRBE6ucW8cOEZ
    v4v2DX/wHYBUpvbAOoTKV2rM4AuL6PNZLslZMzpN8C02Dhq5GDS3uO+1VQ0c8x5gv4i0kL
    YaxoJ1eOxXPtfXI+6u0XNw7mc0gJkN1P0WsU3I9uCquFZhVq/dPm9/6aY4ZdLSm1reQmkN
    LGRJ5mKJ91ktpBRp9YbdxfRJN2oK0lfpj8jSdYahIhfuAp6W2/MZA7OTooXA
X-ME-Proxy: <xmx:x39Hah7yga-kRbBlzvm39leWJdtM0JPjkFvQUe0Zg3BNeex12xBs7A>
    <xmx:x39HasDHmOam9rZ6TkxytLMfXJGNwCmWMoK1HEu-rkR0wOgjwU9Omg>
    <xmx:x39HanfmfxvUtbVvZJ9SsyYlsV4mF-oHEftTUP7PmrWgN6cBqPaYkQ>
    <xmx:x39HarJScZwyF2ZatY-6O5MZwKqyhBmI4s0NzPNZXYu5Ejyd9ao7mA>
    <xmx:x39HapWJznPE07B3BBIk5fHn5rSMtAgQ_fkr9lalt_XNyNK1NdsNmD-u>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 05:24:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2f888318 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 Jul 2026 09:24:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 03 Jul 2026 11:24:06 +0200
Subject: [PATCH v2 3/9] t4141: fix inefficient use of dd(1)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-b4-pks-t-fixes-for-GIT-TEST-LONG-v2-3-79076a7e0c62@pks.im>
References: <20260703-b4-pks-t-fixes-for-GIT-TEST-LONG-v2-0-79076a7e0c62@pks.im>
In-Reply-To: <20260703-b4-pks-t-fixes-for-GIT-TEST-LONG-v2-0-79076a7e0c62@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Jeff King <peff@peff.net>
X-Mailer: b4 0.15.2

In t4141 we generate a patch that is roughly 1GB in size to verify that
git-apply(1) indeed rejects that patch. We generate that patch by
prepending a patch header and then executing `test-tool genzeros`
without a limit. This causes us to print infinitely many zeros, and we
limit the overall amount of generated bytes via `test_copy_bytes`.

This test setup is extremely expensive, as `test_copy_bytes` is
implemented via `dd ibs=1 count="$1"`, which copies data one byte at a
time. So as we write 1GB of data, we end up doing 1 billion reads and
writes. This naturally takes a while: it takes 6 minutes on my system,
and around 40 minutes in some CI jobs!

We can do much better though, as genzeros already knows to handle an
optional limit of how much data it is supposed to write, which allows us
to remove the call to `test_copy_bytes`. Furthermore, it has already
been optimized to generate the data fast.

And indeed, doing this conversion drops the test execution to less than
a second on my machine. That means that in theory it becomes feasible to
drop the EXPENSIVE prerequisite now. But git-apply(1) still soaks up 1GB
of data into memory, which may count as being expensive. Consequently,
we keep the prerequisite intact.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t4141-apply-too-large.sh | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/t/t4141-apply-too-large.sh b/t/t4141-apply-too-large.sh
index eac6f7e151..9dbed940db 100755
--- a/t/t4141-apply-too-large.sh
+++ b/t/t4141-apply-too-large.sh
@@ -5,7 +5,6 @@ test_description='git apply with too-large patch'
 . ./test-lib.sh
 
 test_expect_success EXPENSIVE 'git apply rejects patches that are too large' '
-	sz=$((1024 * 1024 * 1023)) &&
 	{
 		cat <<-\EOF &&
 		diff --git a/file b/file
@@ -14,8 +13,8 @@ test_expect_success EXPENSIVE 'git apply rejects patches that are too large' '
 		+++ b/file
 		@@ -0,0 +1 @@
 		EOF
-		test-tool genzeros
-	} | test_copy_bytes $sz | test_must_fail git apply 2>err &&
+		test-tool genzeros $((1024 * 1024 * 1023))
+	} | test_must_fail git apply 2>err &&
 	grep "patch too large" err
 '
 

-- 
2.55.0.795.g602f6c329a.dirty

