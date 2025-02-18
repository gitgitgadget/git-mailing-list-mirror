Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B78C22FF38
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 09:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739870520; cv=none; b=UeS2vAPCpinMSoBBUmS6VwJsoYxYU3dmVuI7jN0zb0gfu7harqTaS5kjFybHGfnLNYPHLY1N9PollWrCyhLoBisv+V17TFY21fblPE9WbyUaMiRYfQ0L5OOcBW11a6UA0JASqz1QJ7z2dgBTSaiTZp4eu922+8oCEqOBGr36gpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739870520; c=relaxed/simple;
	bh=Aaey1T7ZNu3F+BFSCS2a1Dz4UYvvmkXOrbE0xs6f3Q4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rb019CEKiOV3CDv2bGa9O53L/YawWqpZLOVYRkp1R1ioPTTdaFMCZhC2G5E1+XjOYIggNDPXjezBFmmCWlJPdSSaT/GLDGskSHrGi4ohVOFKSmSDXcmlGaHSG/5ziwaFHzCgJ/MZekS/J0hPweaXcHJSj133lPNkXkVhGfckB8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=M7j2NXQl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MT7k4S33; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="M7j2NXQl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MT7k4S33"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 40AC81140270;
	Tue, 18 Feb 2025 04:21:57 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 18 Feb 2025 04:21:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739870517;
	 x=1739956917; bh=9ZpRBlL3hMbdIFV10bgdFOOr2KfwK6OOB97HCDEe+aw=; b=
	M7j2NXQle4gWS3mndM6RmN/Jfe8l3I4OHoXxYr/RPY5e1rEItUlVgm1B4xDyEkwa
	TYdbruwZCSDHEOFK7kJOX9d9nbpkj3N4F/9mhpIAB4CZjNawfjpm6fnMAiONsJN2
	1En5MHMxIPnX89aEV3poD9m0as9a0IWjwMSmogezC2F83Eb/MYDBCdz2RLXqhsCB
	tr49PhpThfpqCPwASPoDOiVdkebniepTIL04T48+6DZNOgCtEkkpIxjAFfcmJ343
	UkNEBR+ofLDCOa0i7XzwzokTxbt24d13TthKucrAgRfp7MwqwybR4ANNSWKMC3tA
	0iPnsBQpTXJXKEYeNiWExg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739870517; x=
	1739956917; bh=9ZpRBlL3hMbdIFV10bgdFOOr2KfwK6OOB97HCDEe+aw=; b=M
	T7k4S33FLv5NH/3seZjuOz9iBisl6zRneoj8n6hr61k6myaRxMTcjOy/NN7CRkvX
	s/5vguzmfd1Rl3JSwtZvD3TSt2Qu8u+OKy9Y+0cc1e4c5vamUHQWbfI0NTQsq0fz
	pXBf/lLtV6+7IYT3lAKfn6uv66sG0FYWVqE2edYNB7szIN19Rqu3fKtm7+hquGIN
	z6k3UzazvBXfaBR4UCLbUkHOzPAdsIN98qepqdxtCxKgLJR/Hn96rJlto2iOHdEH
	JddCp81YKViTZaho5tONgRzplWjZ2Ds6TEZJhFssKezUuUo/70sP/EYR/ijISeEY
	bv1mnveKtW7mTIExkpYtQ==
X-ME-Sender: <xms:NFG0ZzVl1nDilWfX2Xe81MWSWcm89bgI0p_pNFiSqe-tRqhzNt2Fyw>
    <xme:NFG0Z7nRCDVMQu3O0VeN4yJHZVC5RRlaZbgpSXugo0zO4v7Avs6nplx2RdhO5WaTU
    1Jl7VnZjjE6WdziCA>
X-ME-Received: <xmr:NFG0Z_bZGT20ghegWQz1QLtTcTSQQP4u85kMALosTpydJVD53osoacmWhYz3_bpk-Wz0g8qd2fXYmA5JsCaV28tLAhywtBQbqa-ywdCjfh3K8fLZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeitdelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdp
    rhgtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhi
    nhesghhmgidruggvpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:NFG0Z-U9gMUdVodJWCd1CdEqWduzrqV6Xlu41tO67B5XpiE_QY0KxQ>
    <xmx:NFG0Z9nclTB57vlP3zUk2OYDGQP7h-nhSMEuZQsGXTSbDS8NzHjGrg>
    <xmx:NFG0Z7eaLJsFg7XK6G0JoOCo6rTpg5DhaFeRu-rLyVipVEdZABKVYw>
    <xmx:NFG0Z3HbT-rSDt4FqALFKl-xLRK1lUvRNw17zePRglQekdroLQA0jQ>
    <xmx:NVG0Z7aBq7qG0S6Xazngdf2IqQ8rPgWeUpKi_rJIIjB322aEKDS48bgO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 04:21:55 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id efee999b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 18 Feb 2025 09:21:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 18 Feb 2025 10:20:37 +0100
Subject: [PATCH v6 01/18] reftable/stack: stop using `read_in_full()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-pks-reftable-drop-git-compat-util-v6-1-8c1f39fb4c02@pks.im>
References: <20250218-pks-reftable-drop-git-compat-util-v6-0-8c1f39fb4c02@pks.im>
In-Reply-To: <20250218-pks-reftable-drop-git-compat-util-v6-0-8c1f39fb4c02@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Johannes Sixt <j6t@kdbg.org>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.14.2

There is a single callsite of `read_in_full()` in the reftable library.
Open-code the function to reduce our dependency on the Git library.

Note that we only partially port over the logic from `read_in_full()`
and its underlying `xread()` helper. Most importantly, the latter also
knows to handle `EWOULDBLOCK` via `handle_nonblock()`. This logic is
irrelevant for us though because the reftable library never sets the
`O_NONBLOCK` option in the first place.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 6c4e8be19b1..1cc47b94d9c 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -115,13 +115,16 @@ int reftable_new_stack(struct reftable_stack **dest, const char *dir,
 
 static int fd_read_lines(int fd, char ***namesp)
 {
-	off_t size = lseek(fd, 0, SEEK_END);
 	char *buf = NULL;
 	int err = 0;
+	off_t size;
+
+	size = lseek(fd, 0, SEEK_END);
 	if (size < 0) {
 		err = REFTABLE_IO_ERROR;
 		goto done;
 	}
+
 	err = lseek(fd, 0, SEEK_SET);
 	if (err < 0) {
 		err = REFTABLE_IO_ERROR;
@@ -134,9 +137,16 @@ static int fd_read_lines(int fd, char ***namesp)
 		goto done;
 	}
 
-	if (read_in_full(fd, buf, size) != size) {
-		err = REFTABLE_IO_ERROR;
-		goto done;
+	for (off_t total_read = 0; total_read < size; ) {
+		ssize_t bytes_read = read(fd, buf + total_read, size - total_read);
+		if (bytes_read < 0 && (errno == EAGAIN || errno == EINTR))
+			continue;
+		if (bytes_read < 0 || !bytes_read) {
+			err = REFTABLE_IO_ERROR;
+			goto done;
+		}
+
+		total_read += bytes_read;
 	}
 	buf[size] = 0;
 

-- 
2.48.1.666.gff9fcf71b7.dirty

