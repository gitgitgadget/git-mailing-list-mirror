Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B655238423C
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 18:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774376458; cv=none; b=NckBBNo1ars1pvVjXLGk+wESEk2QjzMeJ89JnlCimkZInI9UcbDq15dmtU2crjUTHlTzvn+aWhG9NxeTxkTdDKYnCh6Jo/XVfptEUZFE0FmF2K9oCqnpydgd7guxKGzvTTrvLgHveAe53B6FXcCvpm/4hvlyluWVO7meo7+QK4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774376458; c=relaxed/simple;
	bh=JOCFl/Tc7nDEJ8dyNwwCf+TkQ6Gylqp2DzLACwHPfz0=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UAbRcUH3+Ko/vuBB7+FtZ6M9fgvpazQoKp/3dZ92cCGOJyr5wMlyKIY9zvbMHKjkh0YqoEBt+H6KpmAEZhqYSMQM8FUVhJaY4KuUapF3ncazUB1+KhWDIBaEmotqSVuBkkzL8Et/3DCmJLBgdZK73L7Dk9QW8ogBV5Hg/nCJHx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PB0plnae; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WoJqVrjk; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PB0plnae";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WoJqVrjk"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 01603EC01E4;
	Tue, 24 Mar 2026 14:20:57 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 24 Mar 2026 14:20:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774376456; x=1774462856; bh=K19dqhWpv/
	HTRK+CuzTo2XYZ0XomV9GAMbQZvpahv10=; b=PB0plnaeMaCIQOEcdgpQp4QSo4
	syfexBgSlDJ7978psRsQZUrAmYsJafZZG5yidZqD3dzSdRTRFjjfQ1S+8KygF5jD
	JZJvGVawHXkfasEjK5h7WbYfRxXaypqi4ZcWbtqVvMbR6oG2fbabBoff3jgNlyLG
	2DEn8XPYpSD1cS7YNhid5oJmF3p1Cp9rqwJH7EaSHm1aIOpqzd27B6H+I6bawAE5
	HlLD9rQGA8gfAiAsCMmycDobYS+MHjKVsx414b5zLD8hXzgzmQUQJzdPXu6PMK6T
	1P/1eAFC6BjCpbCf3M2a/G4Vn9MAbGw3oTPIa1k4DD5lbg5eHlA1G9+ukJjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774376456; x=1774462856; bh=K19dqhWpv/HTRK+CuzTo2XYZ0XomV9GAMbQ
	Zvpahv10=; b=WoJqVrjkjzwmwEwUogY1BXsMD7dkVw7RbjtxoCyOsb6onXoD+HS
	JSXnkI6NxxyECllHkaStRaY9VEWMT1OtB0cvDlQD2HXzg/Bnc/4tF2qrozYQC6SN
	Nxw45HiONyUPAfHviphs7pyQdVdfKsVSGwaK29QnqdA/Bm6CQAe06ZiYEu1p7zh2
	PHqSzKNj9Tc9ckFR/DY/2Dq+c4vogxQ5SJB65c9oE62e6IxM0TJfyy+87hsYURrM
	d4s4NNWRq1yTgZaAd/fVqjCr2XGTlH9rmDDYn3alxpTTzlqC/Ykk/v2D/B6sxElV
	FB/pHD70Yza150sniXim4F6FZcVyPfXuCdQ==
X-ME-Sender: <xms:CNbCaQn4ANyHPseJqTdnjX1BSnqCeDiNzYj6-0AFDg3h3lPhr8qkVQ>
    <xme:CNbCaV1RIdqRLMrOfTeiUmiMNPILAFYHtqJuTw-aWmVKZ6kRVZKoMILxCUaWGobxC
    1VT0Hr7X_i-s6rMEm_2ra86TyN86cBAFXt8ZM8ZqAEOvrRQtGnqnQY>
X-ME-Received: <xmr:CNbCacQoTqtnPiGAKbtdxEdoM0eOqBWOVqC-glw5DaPdtjcKSFXmSHveOd4gZH4hq-Y7R_MeLHA-oQPclI-COnTq0j2my2pKOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvddvvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepkefhueduteekgfdtueegvdfgueeiue
    dvlefggfefkedvffduvddvkeeuhfeifeejnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:CNbCaXu8cd3_bACtzMu6UoczyRddEYcGj7wzRiiySNk3iRBnPneHGQ>
    <xmx:CNbCaRZA7s2vo1QXUljz5rb2mP36zSCCPLwABt_YmpMgwnCn46nXQg>
    <xmx:CNbCacv45IEbbdP3SBoUsH6PHBWAr1OwRUMEs-uTlTiPqBnTMZt0lg>
    <xmx:CNbCaTEDvUaUAr9Wjaj2soPakXaOcz8RedxMJkQUA_53so2DgYMS-g>
    <xmx:CNbCab--h1C9VtumKKJU4SbJz_oSrGX3cgSFOehvZ7Mszgc2ny7O9Krt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Mar 2026 14:20:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] t0008: make test "set -e" clean
In-Reply-To: <xmqqcy0t178a.fsf_-_@gitster.g> (Junio C. Hamano's message of
	"Tue, 24 Mar 2026 10:13:09 -0700")
References: <20260324-b4-pks-t4014-fix-test-execution-v1-1-ac83c1bcc828@pks.im>
	<acKqvI0EhaORjoD7@exploit> <xmqq5x6l2q5y.fsf@gitster.g>
	<acKx6yBi-BWUVJcv@exploit> <xmqqo6kd18sr.fsf@gitster.g>
	<xmqqcy0t178a.fsf_-_@gitster.g>
Date: Tue, 24 Mar 2026 11:20:55 -0700
Message-ID: <xmqqh5q5ytq0.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

In order to catch mistakes like misspelling "test_expect_success",
we would like to eventually be able to run our test suite with the
"-e" option on.

A piece of script used "grep" to filter out its input purely for its
output, but of course, "grep" reports with its exit value when it
did not see any hits, which didn't mesh quite well with "set -e".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t0008-ignores.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git i/t/t0008-ignores.sh w/t/t0008-ignores.sh
index db8bde280e..8edb08d9c2 100755
--- i/t/t0008-ignores.sh
+++ w/t/t0008-ignores.sh
@@ -122,7 +122,7 @@ test_expect_success_multiple () {
 	fi
 	testname="$1" expect_all="$2" code="$3"
 
-	expect_verbose=$( echo "$expect_all" | grep -v '^::	' )
+	expect_verbose=$( echo "$expect_all" | grep -v '^::	' ) || :
 	expect=$( echo "$expect_verbose" | sed -e 's/.*	//' )
 
 	test_expect_success $prereq "$testname${no_index_opt:+ with $no_index_opt}" '
