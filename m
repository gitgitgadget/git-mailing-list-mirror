Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBCF139B
	for <git@vger.kernel.org>; Wed, 30 Jul 2025 23:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753917503; cv=none; b=aCu077/UdSMZS3V7uMTrmqD5qr+pV7/RcI/r+lU7fUvpj4H1uBoxVhwhukSEDImIHvtapADZfLbrFzBAuc8VkUD1ERqA5NrzyeZaFl9owx+AZ/x2g0Rm3CwfDFao3tc8vy9nUCrjezjuqyKIvfbi4QLPFNE7fJ18bSOZPSNCTHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753917503; c=relaxed/simple;
	bh=vI6G7mZQHS/c6noR5I8no7iYJlEEbV8JLz8J24n8eTc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Yk5mXF9Zdw2Lnx4b58YI+YP5EQN3eucF15rSExIgDkDxISeOmCSkaIc9moRaGJIGiEBV6x3zE5zyU5NQ3kDsOHwisIKiRF/3gCTchVcdHxp1COTTjXFVI73Won6W3SWqcUE1itQdKIVzXqzhnWIG1GospcZ/iX2byEvbS6sGInk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=d/fnqlrH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z+vbBwG1; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="d/fnqlrH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z+vbBwG1"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id A49B8EC16FB;
	Wed, 30 Jul 2025 19:18:18 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 30 Jul 2025 19:18:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1753917498; x=1754003898; bh=SidvuKrV5oraPLiZa+mXL7K/Kc7gMjb1
	jm+tyUt2FD8=; b=d/fnqlrHLzv8nbV2jfbX9uJafGhuZ4BQ5U/QMc71k+NZAFuD
	wsVWXKMY+niaQTElMxdXJHfV41YSHIJTU+N1v9UwZfTBVG8tExB5km9YLdXbw27J
	lQVGWaOiWPr9BBTUAGX5C/gw0/c2RCTacI6tOSgiZZAiMfpLIhnDSIYmbaFlh/tC
	KtaHIrSDX/4osGCJ3vlOuY6dLcPjPYkeiqQBdhPtkoLBRhwGe/BTVhEbabi+W36+
	22FeOUYNicij55a1vQWObt1+UraQRJo/kNqtjwjab39PQY0Yw/82HQPJYWovv9km
	PaMhG957bDWFmEii8o8PQ/b1PNYf1f4n8CaeLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1753917498; x=
	1754003898; bh=SidvuKrV5oraPLiZa+mXL7K/Kc7gMjb1jm+tyUt2FD8=; b=Z
	+vbBwG18PS1/cHtgnFmItCEGMO9sRKWZMAz8vOiUPUhHVA7XrZDYt7Zz4XaHgGLG
	z7oY5K5MEBHR0bQsg/p4Fz88x+3LEt1GfzMgmoXfQY5KB2jAl8VrMzubEaZTnkdr
	zFwMoDrraDN8vw246Y2QzvYG5G5S6WlLRFXvckA8WSPw0Q6NOaTpQPXdsvuFSnfb
	gY+Zmx1YRHNqN0BtbOfSG0fuzCcAsEX8QHY4Pgf9cr5kbs3Q5jJHXnQw4QP38fxt
	pmZoyJyLJr9eUpGJM4sdJDGOKf0kmB93PnRxiK44ItkR0hWIR+iNwIG3mCWyMuUA
	YNAhFKXcVrazHIPvEwRAA==
X-ME-Sender: <xms:OqiKaAv-AsI24bPkJNd-liG5vo9il96aLRh_D9AQGbh6GxGuFAn7jw>
    <xme:OqiKaNoC8TsMvUisL9S_ZvU8h9HCuQJMtBhP3d-FYBbpcZHB82tRL2m94p5NEh0lb
    PGW5iagqzHwG-q5yw>
X-ME-Received: <xmr:OqiKaNlbAOOMYvH1P2fS-k4hVP5G8td-8UddvoruMpqXDpeq8oGG8Osr7ln978x9chnX1ZFWAfN_uTcU0mke6k3pGGxVENfJcPtJYzc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelledvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvufffkfgfgggtsehttdertddtredtne
    cuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohig
    rdgtohhmqeenucggtffrrghtthgvrhhnpeduieetkeeijeeuueekffekfeekheeiudetgf
    ekvdfghfetgfffteffuddvveeiudenucffohhmrghinhepthgvshhtqdhhrghshhhmrghp
    rdgtfienucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:OqiKaByPfr3CyR6ylEvi-pQk1nxLclRGSM5tUujkyMILfC03ZmeLbg>
    <xmx:OqiKaFkC3jYiVFfuj0NNhMZrApsWVPSw4qqypmjxyVFNe-jDoUROCw>
    <xmx:OqiKaKeoQwZiIxD_J2C5CB-RpElP3atXwFQwcQIVpzGk2cRdAk66Ig>
    <xmx:OqiKaLrQGnLOWQsYtrG00KmWv4P3CoUor1UFMVaHujN-n805S1GPBA>
    <xmx:OqiKaDTbOuvYyH1JQGJ_5vD-br86yPZIRZIvRxc5-gflYw59yzMUkct0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Jul 2025 19:18:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] test-hashmap: document why it is no longer used but still
 there
Date: Wed, 30 Jul 2025 16:18:16 -0700
Message-ID: <xmqqwm7ptghz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

As I ended up wasting a few dozen minutes looking for the reason why
this is still here, help future developers by saving them from
wasting their time by documenting why this code that apparently is
not used by anybody is still here.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/helper/test-hashmap.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git c/t/helper/test-hashmap.c w/t/helper/test-hashmap.c
index 7782ae585e..16a3145c3a 100644
--- c/t/helper/test-hashmap.c
+++ w/t/helper/test-hashmap.c
@@ -137,6 +137,11 @@ static void perf_hashmap(unsigned int method, unsigned int rounds)
  * Read stdin line by line and print result of commands to stdout:
  *
  * perfhashmap method rounds -> test hashmap.[ch] performance
+ *
+ * NOTE: this is not used by any of our mechanized build & test
+ * procedure, after 3469a236 (t: port helper/test-hashmap.c to
+ * unit-tests/t-hashmap.c, 2024-08-03).  See the log message of that
+ * commit for the reason why this is still here.
  */
 int cmd__hashmap(int argc UNUSED, const char **argv UNUSED)
 {
