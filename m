Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F7429A30A
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 11:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751886540; cv=none; b=FGidVR74YWBI+eeaqB5qfw6YZeg1KpdPxtAJU9XT2dZggRrLmvhayk+sRuVfok2XvhFtDtsIXKlZ0SFFsQ5pzfp8PbilYLazjCZNsEAG5agLXqZp1xA8SMOpjKEX/LshO0wmCotlOkPVogHb3YC63SL1EfisHaJqCy0fIE5HkIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751886540; c=relaxed/simple;
	bh=HJ+rEP947gr9I1KRauU2w+Libd8uR6vLx5IxqtRwIao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BzksWFinrepf8qBGkwkAXVm9yL5OALQlFlWfAGsDUBlnq1EIDPO/UCI47bWEvLpKXo2bXlNl3Jg9xNW7tcCd7PVCFlwLuAXeUePu0taBwkQEMAJMe6TdtHL0neaDcAUhG8nFcQoOjzFJIs7+wiUiK7W/Vs9t3VcZmGct0EYDcSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Z5/VU2zh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k8suLbQe; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Z5/VU2zh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k8suLbQe"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 001E71400A81;
	Mon,  7 Jul 2025 07:08:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 07 Jul 2025 07:08:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751886537;
	 x=1751972937; bh=1PVtcptBqyYWQ8uU1G/tY3z3R6UBnEH7rKvT9EXNHD0=; b=
	Z5/VU2zhHhpskqmZRD3HbbK4+/jGiY4lFdkx/+WqN2SFqC5g6+nNzJSrPwQ++6Zm
	pxm9O992rwifbiiAcBW7s3z+n1tB0ncvCAx3g8H2ibl0VnJ9qjuRwgXvTSYRvGYk
	Jf5OQgeTvwbhwGCIYB+VO60BnkFwZ6Yo/JjWHM/9hbuc0dsf/2GJTgN1udgq0+zb
	MOJQgtQOwIglVnHRT+43JYXAEsZLmkf32CgF9mWLwkugolAxG7TCNYdPqUy+3wXE
	4h/43bsWHrgVZDICF565r5nAFHK2WZldmf5lPArvtMieJJtPF8k8JtEgCGZ7y+Bm
	myRXqmY9Q+ipy6wMCKdGTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751886537; x=
	1751972937; bh=1PVtcptBqyYWQ8uU1G/tY3z3R6UBnEH7rKvT9EXNHD0=; b=k
	8suLbQelSH1Yyw9odsAXtJX/CEtSaVuY1i8hvDFBL9bWRTLRY0VKo2bcpl6QtVPa
	He+VkBTSynG2QdErh8W0Gr7FAUyNinAAwijnI7lQowBXagFoSbI2l4pMZp/ZaBog
	HllGYj/G32rMwFXBz2Vo/mUioK8c1KgFf46xY0kiDEO90ouFRskIzzIbZkz9aNKm
	v7Zdt9+6qBUKffDRfKwE9DFawd1JpWBUjLtYpKGFIntydqFMP2SS3W/jbDSPDgn9
	lfXxfWos6WI7id2c9ogOOFd4nH14+NTWHVQG0GYwgDI+QCGiUDjhZRXTOnCEW/7Z
	YDAydtMgo7BhOG0FawIcA==
X-ME-Sender: <xms:yapraHo-BwscawNopLFO6twvuNi5I-Ojqjdm1yaCGGkCJNVkbeDmOg>
    <xme:yapraE4-Lc2Sb-mWnkTg80-hZrui9GI5sXxChGSTyRVtVAfjYjYFPLQy_0FESyreY
    WOQkkrSylicSpAtXA>
X-ME-Received: <xmr:yapraNoe8P4kKLhsNOaRqxgrB5R24t-zsy7A4EmpjkGP60WxCsic2_D9vEDU1ryCC4X5XcrgiDgxNwhpr2NEdMyEWJ23WVgQRNpTr5-tSA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefudeigecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeefhfeugeelheefjeektdffhedvhfdvteefgf
    dtudffudevveetgeeuuedtkefhgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhope
    hsiigvuggvrhdruggvvhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:yapraGh6Ti9FqucyLNRAlFUSl1juUv-A2fAIN9RTh7SA3-eqUZ-00g>
    <xmx:yapraHIP1biyVWrrmEFewk5VmRdCY_kkJVAwBo8IBQJTVj8ucXeo1w>
    <xmx:yapraGAJg6WzLYgaLAVKDrj1rpi7FcadPIO2QIkDbZU_AdaZs0HZVQ>
    <xmx:yapraHj-5XrhT9khajleIwdT0zTHFWH9Ldh2O3n1osFdFZdGu5Qsbw>
    <xmx:yapraFhgcxgiWLjE4urUKlnJbktWKNxzbCLVaeyWUXft-Zd7sU3k3I-F>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Jul 2025 07:08:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2267e7b7 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 7 Jul 2025 11:08:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 07 Jul 2025 13:08:34 +0200
Subject: [PATCH 2/2] t5333: fix missing terminator for sed(1) 's' command
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250707-b4-pks-t-perlless-fixes-v1-2-92b2de1c3dd0@pks.im>
References: <20250707-b4-pks-t-perlless-fixes-v1-0-92b2de1c3dd0@pks.im>
In-Reply-To: <20250707-b4-pks-t-perlless-fixes-v1-0-92b2de1c3dd0@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

In 6aec8d38fdd (t: refactor tests depending on Perl to print data,
2025-04-03) we have changed some of the tests in t4150 to use sed(1)
instead of Perl. One of the conversions is broken though:

    sed: -e expression #1, char 41: unterminated `s' command

Curiously enough, the test itself still passes. This is caused by a
sequence of failures:

  1. The output of sed(1) is piped into git-update-ref(1), and because
     sed(1) is the upstream command we don't notice that it fails.

  2. git-update-ref(1) does not receive any input and thus won't create
     any references.

  3. We then repack the repository with the configured pseudo merges
     pattern, but as we didn't create any references the pattern doesn't
     match anything.

  4. We use `test_pseudo_merges()` to compute the list of pseudo-merges
     and write it into a file. This file is empty as there are none.

  5. The loop over the pseudo-merges becomes a no-op.

  6. The final test succeeds as well because the number of lines in an
     empty file is obviously the same as the number of unique lines,
     namely zero.

Fix the issue by adding the terminating '|' to the sed(1) command.
Furthermore, make the test a tiny bit more robust by not using it as
part of a pipe.

Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5333-pseudo-merge-bitmaps.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5333-pseudo-merge-bitmaps.sh b/t/t5333-pseudo-merge-bitmaps.sh
index ba5ae6a00c9..1f7a5d82ee4 100755
--- a/t/t5333-pseudo-merge-bitmaps.sh
+++ b/t/t5333-pseudo-merge-bitmaps.sh
@@ -234,8 +234,8 @@ test_expect_success 'pseudo-merge pattern with capture groups' '
 			test_commit_bulk 16 &&
 
 			git rev-list HEAD~16.. >in &&
-			sed "s|\(.*\)|create refs/remotes/$r/tags/\1 \1" in |
-			git update-ref --stdin || return 1
+			sed "s|\(.*\)|create refs/remotes/$r/tags/\1 \1|" in >refs &&
+			git update-ref --stdin <refs || return 1
 		done &&
 
 		git \

-- 
2.50.0.195.g74e6fc65d0.dirty

