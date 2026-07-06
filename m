Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDA63D4132
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 06:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783319059; cv=none; b=Mt5uHBTY/yO1XbeA6/x4a7CNUIwp1oOgj4vOq8NqhxOMDS6TzblBwyXwBmKkQSDD0w/KqwBtvmtWAMuYMnilbtVNfKDAnzdSE3EjtqbvhRTuy/jvrv9LheAqji0YesBd7Yjqenm+0yeueOYopNtRp+PYxeRo128NmC/+65FIa4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783319059; c=relaxed/simple;
	bh=oooeUt2TauJ4JIg1uQv6YVKocm9UZlZ4PMf5Inbkg+Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p0wvGKoUvE+hCFbAlRTrlcH62y8S30iHhxUqlRVg+56t22b9uVR388T798lfnvuhQ6eZVWq6tsRHBMtzgYBuvGL+b1LottcgyYzMov/kQMzgmRrsKFI4KX3U7ukMBPeCTnX1JnFsCOdqoOcXhwiXs8/fGkDNqUZNW2nBUb6seEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lePNMAEN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PvLEc0K8; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lePNMAEN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PvLEc0K8"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id E33331D000C3;
	Mon,  6 Jul 2026 02:24:10 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 06 Jul 2026 02:24:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783319050;
	 x=1783405450; bh=aOQ/InnYuKQyqfx/K6ZaIklkwunFwlc/kObL/4KIyDk=; b=
	lePNMAENKcYjD0DW+iaM6SlfkLHpfPOJsvmm2Sd5AYIToljYHGpBMo807d8pq3Pl
	Zb7nP0NwnzJhvBPNNEZBxAarQ1Zx1gtnCpgb0VhHA2lPr7N+A+VEcN8zMwu+FS7g
	p5zcCBhAx0A4bnEkbRX24EreX+zHNCTij9ZVLZDZIDD9C4j+UIJ/tvKc6VbMugII
	C3OlBrMSi8nxOazs4RNahoPa+klGBNy1VWdnqgYH30/cOZZXEmAkE6VLNHdb+rwD
	0N1uU9BrhHkTBUjVEoS0r4ssD1LKyZfAu9galzhCZaosiPtNVdusbpBsG07h2YRt
	NGA3jj5W47X0N/aGWVvMyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783319050; x=
	1783405450; bh=aOQ/InnYuKQyqfx/K6ZaIklkwunFwlc/kObL/4KIyDk=; b=P
	vLEc0K8x8d7az9xRH0p/ync3w3z759y1kttTMc9Tm5iFlc2pq/mgV0GL+HoBX5kI
	eFnccZVf8/BnDgEYPrP/9Sliac6VcCHL77U3Nf7/4vFI4qytaUssWb4JnWBP5pUP
	99S5kizJHI9jqLZXNHIJzUI+6NxGyVs7T0ZLBQKeWeGYXMR8fXeFTwhOy+a5dSyB
	CnNDcQNaVIYlJqFUkTtkv25Qe72u2C4WwJGOL28KZ0xQ64O5f5xlg+CM2aesq5fW
	QbkxzlAi+9kZm4g5K/3OjhMjnCKN0k/5w4wMDTi2i0oR7pW1XGhdPEngmrNHWNrQ
	oKgPjsy+qw14mwe+gu/qQ==
X-ME-Sender: <xms:CkpLarQcoPl1oFCDSSWgmyrT4zIt2yb53FEw7lC1IAdY29SFNT20Cg>
    <xme:CkpLajrXEswUAVKmO_a_yC9qbydsZPFqNZx-T0BzMSqki90KiAH2f1Tf8mQwabgBb
    oUSGUW8xRsGMz8Qe9Ni29-PwWXq9o7viz14LhS3iCfaMfZ0iCIw-g>
X-ME-Received: <xmr:CkpLapJS7inks-TogqbcWZCcumEjnkawHhx4UzyvT7NqOSrEXptgnuDSNCu3MEveZAHHAdUSNDZisXUWXJM9RtdxvA-3Wk3o3lB6CBrFGPo>
X-ME-Proxy-Cause: dmFkZTF17AfV6XO0usBmc86SAi5z6HQuck7ySRe0CZv4Tr7ef2D3PyPjdsrtHyrohmH5LM
    8PibOrmJdKU+XpIRahlbOkv4t5RR+XfuSuX6lZMmabUVlOs7MlOrLXE/cLabyZc4Fv+zCv
    BpnvpqVjroE/BWbCWz3ZnipN08RC+nXAfSKIpH46VmGPJGbn5G+g3EkcTy7SZTmmR7Elgf
    IeX4m8AzzXy51WFxCzkp1N1kUJyuoz9WBD5Vq7HYK4I3wDyTPuKmMzn5wzekCvdmdVDSpk
    Fz5kiu5pS0lXX9SFGHy76iVY3USPY4dYFkeLQPYVWekcah4ZWrnUhCll2DXoPQGKbW7VpL
    u14unDDlltMGJmkw2/LBREk5p8o40GPDVuVQ4eZ9B0kz718UtPiRed1OK2gUYTsDcAuJGA
    MP/d7bHmXvd677wW5whDSrpP0Tod0BPb1ZbowjrFW5f85IMdmQorgkNmT439lXWpYyL0pg
    oylAyiWA4hvz40d8WVedVFeJOhhCN2T9fFjSGh8yXhWSjhO14BwTxCqO8tRYELDAOtuACi
    I1K6q5jVOxQEYOBa2XUNsl+tzPSw3ZeaqBtVdwqMaqZphDNrYvL1PmZN51v4YK17OLIhpS
    WmgD1X3yI8HMJ3AWJNOQnEqsf8TMGuahEsbg0k+Csj6mCJwrWagbc3oLTJcA
X-ME-Proxy: <xmx:CkpLamp-4TgfqocIi_wqtDvls60dUz87pSHyJM8iHnWPjOq8kHd_Gw>
    <xmx:CkpLahzMY3rERd5rsrVg8dD982psj-Ii14kjtdzEILS3qVfF2JsODw>
    <xmx:CkpLaqNpqzu3P6H0_CpTSrcjlIVMhJ6jtH9BHUFUfSeLeRiKbYcPfQ>
    <xmx:CkpLam60YXvdnmeNY4Z88Q9soRWfe0xWFGBBP9GIDiD3lNA6rPe70w>
    <xmx:CkpLamFVdkTb2YuAvYYCu_OoFW1PUPEapZqnJyUdU6d8z889wA29u4N0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 02:24:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fff49aae (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 Jul 2026 06:24:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 06 Jul 2026 08:23:58 +0200
Subject: [PATCH v3 3/9] t4141: fix inefficient use of dd(1)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-b4-pks-t-fixes-for-GIT-TEST-LONG-v3-3-4f6c5a37fd1f@pks.im>
References: <20260706-b4-pks-t-fixes-for-GIT-TEST-LONG-v3-0-4f6c5a37fd1f@pks.im>
In-Reply-To: <20260706-b4-pks-t-fixes-for-GIT-TEST-LONG-v3-0-4f6c5a37fd1f@pks.im>
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

