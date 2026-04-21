Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D16383C62
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 07:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776756882; cv=none; b=oVBCAhnwh78bciMpfJY98VL74vDDmWYIe1VknhW0sscS3uRLG9MHDVV87ThFlGG5FZzadUHoTIRQNMDjgwy+1OxhyPp2dZn1x8bQ02gHL/yQSE96RdW7pg5l/boNW/RBQRuJePox+BLo30Spwo/YDilOgZB+S0zpJ5FoP2i5oFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776756882; c=relaxed/simple;
	bh=F1FlCB50K3nsowzKP//uNmF9X2BLloSM98+xeexSsws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QD89UD2R2weG63RqA/Ya7/JRsUXks9DDXHnISseHMx+jugtAUh7Qc00sodTTaChoXDTtMztaYTSMfiP8bajH27L0oulIcjR7LzSXVh3XISLlfdcQ3lqSlrtvFURJntbCDYUx6okOo4zsM9zkyIPx6/XSx9+YDJnQgW0aLsd7VDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dWppRe8N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=REQTBlx2; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dWppRe8N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="REQTBlx2"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 9B827EC0256;
	Tue, 21 Apr 2026 03:34:40 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 21 Apr 2026 03:34:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776756880;
	 x=1776843280; bh=p5EPjgPB4I8p2s2y1duHvDtjCSrop/J/gUMb9aY8GCM=; b=
	dWppRe8N5UKCnj6h+84C+6riA2pe3XqxNb/7ip46SObLyITFf5kOe/jdRVN+sqdR
	D3iC1P52Pk9xiZcQDm9w8uxe2fVjXf4wJJ/8O7WOupuuuRT1c4TlCCgwYo4PUFAw
	0yFXy6LntyNELA83zEYp3OukuQjctCj2SiyfPLWZmtVl5tNGPaAe3FVB0avTtS86
	ZQIeoH65UXeEf9nFhGG2YKq9MXGCd8gPw5yXx2pPhA8z0lm5nNfV/RuaS8/OeKIu
	bxcb8kGlICXGpu/5mSChcoVkFtZdzuwaN0RcbCXxl9Yiaq9B0kS4y/Z8HOG8y0FH
	DnSNyIkWg5cKmkOIJBF/pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776756880; x=
	1776843280; bh=p5EPjgPB4I8p2s2y1duHvDtjCSrop/J/gUMb9aY8GCM=; b=R
	EQTBlx2NAxarMn5N8EW9JnDEPYA6RkKIPn051J7FXp0HFEnhtZe5wdqMBjND1e7o
	V7OjkyX6XdWrf9mpU64QLeu/+4uTkrSpUj5EhM3L8y99h8ptMQUxHU8/71eRSSRr
	Qnx54AE+69NLnTsMx++hWCzplpOiP9jlzoeSGQpWBTJogmvSfa+SAzixjC+maA1C
	7hGh+hMUMTrPgeFFDVAM6HOUHCjoEGyvdNUdQlPiyAfWWRFJwhUgZdeNDouv+dWq
	/ET/FzwMdVBjZosxVAHQoPxAtsDvJi5XQ+1si4PaEwQ/oMLyyhM1VKhbR+TZYBDE
	1mCsTmcAVFs//LKCrcVyQ==
X-ME-Sender: <xms:kCjnaSw58bJNpLqzIxMwxyf-4mxupyaTtVT-b-q4r-1m-QPo0q2ltw>
    <xme:kCjnaVSg0SkDOREC4Ib68mVbCPn8GF2tBiyclGaVW8959qR1HnQ0fYA6CcQZ-Qv7B
    o6kujiwOP0foRJPuVjnEZBxKmpjGvz2Sv78ex0ESwRsvvYGiABxWQ>
X-ME-Received: <xmr:kCjnaZXJpjfHXYkVHRcZCMLsSOqmuhuQM8rMfhlSf49pc30DQbH2xgVIpju9Y81jnmd4L5CL9Emrzda5v394Xr7CAW-VNydkk9SpxwU56A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeitdektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:kCjnaXbAm28-yl_idkmI2OTtUYXbmtj3dcuD7B0Dtgxst9UZQoaihg>
    <xmx:kCjnaf0rROJiTOrcnh5HlXb9WFlWdCE7ZA0ftN5IP1ufnXZxRahtzQ>
    <xmx:kCjnaZhWXtiEHd33YobvxOUoV_SHQGOlMMs9xxLSSC7F_VJQ0_Zy6w>
    <xmx:kCjnaTaCAg75gEbNQYVqAw2Cm2zIfFA-BsHN-XvcalXwRbrRh-9agQ>
    <xmx:kCjnabTiX2zuzUJsJLWQup8y11y6lZK8fha2YuV4DtaJXyiNbGmavgWA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Apr 2026 03:34:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6be7453a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 21 Apr 2026 07:34:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 21 Apr 2026 09:34:21 +0200
Subject: [PATCH v6 08/12] t0008: silence error in subshell when using `grep
 -v`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-b4-pks-tests-with-set-e-v6-8-26330e3061ab@pks.im>
References: <20260421-b4-pks-tests-with-set-e-v6-0-26330e3061ab@pks.im>
In-Reply-To: <20260421-b4-pks-tests-with-set-e-v6-0-26330e3061ab@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: b4 0.15.2

In t0008 we use `grep -v` in a subshell, but expect that this command
will sometimes not match anything. This would cause grep(1) to return an
error code, but given that we don't run with `set -e` we swallow this
error.

We're about to enable `set -e`. Prepare for this by ignoring any errors.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0008-ignores.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index e716b5cdfa..d77a179bdd 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -122,8 +122,8 @@ test_expect_success_multiple () {
 	fi
 	testname="$1" expect_all="$2" code="$3"
 
-	expect_verbose=$( echo "$expect_all" | grep -v '^::	' )
-	expect=$( echo "$expect_verbose" | sed -e 's/.*	//' )
+	expect_verbose=$(echo "$expect_all" | grep -v '^::	' || :)
+	expect=$(echo "$expect_verbose" | sed -e 's/.*	//')
 
 	test_expect_success $prereq "$testname${no_index_opt:+ with $no_index_opt}" '
 		expect "$expect" &&

-- 
2.54.0.545.g6539524ca2.dirty

