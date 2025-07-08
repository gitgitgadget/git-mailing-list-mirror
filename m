Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E59D2E3711
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 10:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751969952; cv=none; b=SAzvV6Gk0+tviweDBvJEbFho6DMIAigN00db7QU+dfYn4EzoYznpJx5c3DuA+l33D0PmwIe3dPg523PaKcby0Tdy8QzTYXpgoi5ibl0JmcRuhXZ+2fWZ37Z1DJmSv2pcFjkkZoaIydJ7WVurjXZNRfYFoUlkKCkiLJY2qv2gqys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751969952; c=relaxed/simple;
	bh=V4GUUsqKGMlzQ99vBORmmjT54N65UoKs8IQbh8muh/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Zfu7axoTZJdUQitnxSyf1ivJ1Sdl6vOFYjWZtW2/0zDcGFbNLHEA+iiayhvWlIoMa6RlanDpWmhTAnMlkgnwhfwwsqlNDJjbK5DMAKUH5xRlNxfWdz/Gj0yRh9TQD5Tjism9VdYr45kOt6vcLnlgtm3OheCid2f6rTSW90b4RCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dyFlPEWu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nGIqBwBa; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dyFlPEWu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nGIqBwBa"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 8715DEC0BBE;
	Tue,  8 Jul 2025 06:19:08 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 08 Jul 2025 06:19:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1751969948; x=1752056348; bh=f0SN4HjWwV
	O2ZIx39v0tsnLdDw9QBh97WuKaFXw/Pl4=; b=dyFlPEWugt3XnlEI6PgpLqnA0q
	rX3iQ1Cmv35gITUKZZwfA5A9vl0f3XCRftSx/XaWYZPLlMVb5QdiEmjzI5sPUASP
	x5L1s6qA+Xvbz2zUlCnRq6iohby2GlYwTId4cr/Kt303z+z/u0Ke/otOH5SMjBY6
	L0Nn/Bbqs8RrVI/visk40znpqfiiJ0/5xdnnqx+ebCHrkSyJRVbbl0a/yCT4zjZ2
	Lx9qJE571LbU6OMhu7fKnfGFL+D3wqtmpREGd3GM6Sio9EC9wOb/eJMeOAPWyA0n
	Eq3JoI0x+5gMP6di7Rcy4Kkg/umY8kC0s8laE0ekSTgz97xuMvjN1x06Ofvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1751969948; x=1752056348; bh=f0SN4HjWwVO2ZIx39v0tsnLdDw9Q
	Bh97WuKaFXw/Pl4=; b=nGIqBwBakB3mskgcn/9n4blHogt+A5USlNdP1JP4M1fX
	kdwB6xcBRLLaYx6o7+6oV3JckIM24GO9Hm7fFJbigiWZ+KzQyJ33axlO5rk1CmU0
	r249WF1AjRk5lD2KJjjpbEhXsDfgciXZz2cdswo2Pd5HzmNyuHRi3aBfdx+zJHZU
	byAwBYOWyegm9tC7qOWXYsyNZIelIZ0SQaQAt/JocxsYBveRK+riZO3bzUfNyQyI
	PrvNzUkXCMlOcaA4D3wNv8z3Bw3nj/BX+IOLiXVtmvhfHeELeYGmCo80MRnVrhLd
	uObsHnFSeIMilH1diEk/J0j2gPaNFPx8k5LICYdOZA==
X-ME-Sender: <xms:nPBsaITdtC0aIhH6s6HUOpkA62p8RuCW7LIavImT0N3f61ORKCAxsQ>
    <xme:nPBsaF_f_9ZvYf7mmuA4Gysu012pmDIfQk3WmQMi_DZxMWTa0pf5Id6Z4VEi9TBBY
    TDhWJEeFhJbky1Lzg>
X-ME-Received: <xmr:nPBsaHq-D-NlkEfw9cp-FDEmvn9SEnIxbiqbwz7ybsGgSi_knjD7_eUqKoCU14ZZGDhcrw_-3yo8WvtsoYSMdQj70ntfSrJRntT5kRRYJBU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefgeegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepie
    fgiedtffffvddvueehheejheehleduudfhheekkeeggefgueffheevgeetjeefnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehvugihvgesghhith
    hhuhgsrdgtohhm
X-ME-Proxy: <xmx:nPBsaKkzFCElXDtUOyoAjH5zgkxQhIIwDVYHOAdtrBPkcqi-a76cNg>
    <xmx:nPBsaGLAZwdu0exO5CNNO4DjPDH0UVZ-MuzJDkqLHFGV8DwcsTzYQA>
    <xmx:nPBsaHyo8Y-kYe7q38Q1xOeOBFoy1IKEOUxdBrldsHV7bFWGUe7N-A>
    <xmx:nPBsaGscZvO6XSVOcmfqyw5ByKYrXhwhYAdBmSK8Gy5ZRPra1tB76w>
    <xmx:nPBsaJiiaK7mY41c3pPj_H21QJM5VEDZMDy7StZ94sbcKUrQ_W-2ROtg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Jul 2025 06:19:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d2dc2230 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 8 Jul 2025 10:19:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 08 Jul 2025 12:18:58 +0200
Subject: [PATCH] t1006: fix broken TAP format
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-b4-pks-t1006-fix-tap-format-v1-1-c3f837448364@pks.im>
X-B4-Tracking: v=1; b=H4sIAJHwbGgC/x3MTQqEMAxA4atI1hNIi/9XGVykGjUMo6UtIoh3t
 7j84PEuiBJUIvTFBUEOjbpvGeZTwLjytgjqlA2WbEUNtehK9L+IyRDVOOuJiT3Oe/hzQsvO1N3
 YtJYJ8sEHycV7/w73/QA8rE9bbQAAAA==
X-Change-ID: 20250708-b4-pks-t1006-fix-tap-format-2ab169c782a0
To: git@vger.kernel.org
Cc: Victoria Dye <vdye@github.com>
X-Mailer: b4 0.14.2

When running t1006 via Meson we receive an error about invalid TAP
format:

    $ meson test t1006-cat-file
    1/1 t1006-cat-file        OK              3.86s   420 subtests passed

    stdout: 147: UNKNOWN: c308ae01840d8e620ad554ee5d77fe114dc2d912:path with spaces
    stdout: 159: UNKNOWN: 3625298bf5e7c464a7d0e38ea80c2a5b5904d9a3e5b2b025b67f360e09b68dc7:path with spaces
    ERROR: Unknown TAP output lines for a supported TAP version.
    This is probably a bug in the test; if they are not TAP syntax, prefix them with a #

    Ok:                1
    Fail:              0

While Meson copes with it alright, it's still annoying to see these
errors on every test run.

The root cause of the broken format is a call to grep(1) that gets
executed outside of a test case, which has been added recently via
9fd38038b9c (t1006: update 'run_tests' to test generic object
specifiers, 2025-06-02). This call is done to determine whether a
subsequent test case is expected to succeed or fail, so it makes sense
to have it execute outside of a test case. But whenever we do that, we
must be extra careful to not generate any output that breaks the TAP
format.

Fix the issue by adding '-q' to the command so that it doesn't print
any matching lines.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
Hi,

this issue has been bugging me for a couple days, so I decided to
finally fix it :) With this fix all tests that aren't skipped on my
machine conform to the TAP format.

Patrick
---
 t/t1006-cat-file.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index f123ef1e360..1f61b666a7d 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -197,7 +197,7 @@ $content"
     # FIXME: %(rest) is incompatible with object names that include whitespace,
     # e.g. HEAD:path/to/a/file with spaces. Use the resolved OID as input to
     # test this instead of the raw object name.
-    if echo "$object_name" | grep " "; then
+    if echo "$object_name" | grep -q " "; then
 	test_rest=test_expect_failure
     else
 	test_rest=test_expect_success

---
base-commit: 41905d60226a0346b22f0d0d99428c746a5a3b14
change-id: 20250708-b4-pks-t1006-fix-tap-format-2ab169c782a0

