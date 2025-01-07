Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664AC1F3D55
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 15:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736263635; cv=none; b=eFQuU/jg62Te95BTjZJgyLTRY1xG/TjfcYlyOedxYynFj2a8HHIK/bM/HgZFPSkSOl22pKI1LVjuOwQZSe1uOhWnPsdTa42/guzvG4WhsXyaRvGj2bOj3swwpwB3w/9CcwH8HsCp7sd1gKfMt0rsGoxtoYjbGPbYcd2HlKHO7tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736263635; c=relaxed/simple;
	bh=MgSCjPw1zoUT0I/wfit+BJxKZLUHXMDBzfCYmj0q/BQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IK5iOlScrg2OhAtzXn65BB4ay63kPseQ1xjtQv+IJAvJxv+8iCBMH7I4tftAEm2RTl8aSUT/S6TTDbmn25/P8nmgBRzLc6Pwq0cB/+XHZyL57MRYkeP4/y2Vyy8prmh27aJnVT7aEpRcoqVK9AJd738e8Bx7ghMMfIXoKqXqv8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Dqo0qIqn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tQtR90ON; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Dqo0qIqn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tQtR90ON"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 71E2A114016F;
	Tue,  7 Jan 2025 10:27:11 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 07 Jan 2025 10:27:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736263631;
	 x=1736350031; bh=7buQq8KKwe0WnuxRFkrrxZf+GYZhYgqJQWGvCiFoG+0=; b=
	Dqo0qIqnfnfrEDbVY7osqDENkv7fQi2tNPEe1B6jYLcXy2T6FSium0aYEUhPGbx0
	lD8pqhLmQrM6ya14LK6XCzI571hGMivAuF3bKQ864KDaKdBkq0AECQpjpvN9YYyp
	yondbPbQ4zYxEMPFLTCgrHWEr1R9oi476PIi8CVbnhLaWmnIAZ2UmyjrQcCHKjYa
	KOIH9wXtE/ga24Ysn3Q6jnaa1LfI7975JOfB5Bj0Qf3/epoAE4KoMEl5po8KL4xh
	ZtDEfxQLAz1BC0KWJeXi+bXVhE4G8H/VRfQsVIcmp7iuZEb8ojVBMiuzpLJjBJGe
	UlLKtfYXOhHZJt3i1Z7WZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736263631; x=
	1736350031; bh=7buQq8KKwe0WnuxRFkrrxZf+GYZhYgqJQWGvCiFoG+0=; b=t
	QtR90ONft2JrI49t2l666iGjYhBO5OzRCXbgEYl/MjfbKxb0IVKBzw2ll9T0FZEv
	4JY9/stRLEZMvg1PQxly6nb6uOTNkMn2BCFVVYgCaq6TQ+d9oxQpvcku8LCFoCYS
	qXBjlb7V5z2/nuucAQzznWCJcrxFOy/jf4eja3JC7wNdvTT5DkiwtuCuN0QO8tBM
	NOUu/LvJNZkyvfIzAocdeEgsT8uYN7aW4HvBWIQEmJc6/bTmiDTyd7jNm+wwY6vr
	HL9IIVlCoBe6pGT1HW8qjqYO1EldcXzuL+6qH0AciTn+0GEib2EMaZWo110Nb6As
	XDulEWewLdGHoNWK/PppQ==
X-ME-Sender: <xms:z0d9Z37IdiNy1302a8N9Lv5LuGTybr-TjRx6tqNyWR4bbZTlVzOJiQ>
    <xme:z0d9Z86t0jGF9wwpRgV5KJtWdxf3mxcSkelhnrJQ2nGpS794aU9LsNP8zBrOrPiEN
    vVpND0KeohH-_Fm4A>
X-ME-Received: <xmr:z0d9Z-dsI1RDH7DnbMBWvLoFWRmA1YSSbqPxbRE-FM9k2POEzeNpULM2Q7ZXNlH535_kGPQfJu9oXiGCg55MXV83jPtryg2Xg37TQ5ZzKN6L9g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegvddgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeegkeevteeiudegtdffieeuueffvdelvdevheeuheej
    keejjedtvdfgkedtffejveenucffohhmrghinheprhgvfhdrihhnnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgs
    pghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghnuggrlhhlrdgsvggtkhgv
    rhesnhgvgigsrhhiughgvgdrtggr
X-ME-Proxy: <xmx:z0d9Z4JUxKJDJa4gh1YrGQoJlHqCCy98IRFY-raX7b16OydPrN6wsA>
    <xmx:z0d9Z7KLoJGDxFoGB6HwF8DWt7NT4A2qA4yIBhDwdPqW3wkYxAxFrg>
    <xmx:z0d9ZxwD3ONfsBbCUlhbFUENZaj1Ryk8sJ2_xbR5Ots33O6SojPnYQ>
    <xmx:z0d9Z3IM5kfS6NwJ_05FnfxcobMTQMj4jlgBcJo3Tp2SZjULhCUmVg>
    <xmx:z0d9ZyWd-veAFu5aHB8Dde4Kmv1PlTKHTqeWjHe2R82eM_S3THN-G3Ku>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jan 2025 10:27:10 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 307f1dc1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 Jan 2025 15:27:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 07 Jan 2025 16:27:00 +0100
Subject: [PATCH 2/2] reftable/stack: accept insecure random bytes
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-b4-pks-reftable-csprng-v1-2-6109a54a8756@pks.im>
References: <20250107-b4-pks-reftable-csprng-v1-0-6109a54a8756@pks.im>
In-Reply-To: <20250107-b4-pks-reftable-csprng-v1-0-6109a54a8756@pks.im>
To: git@vger.kernel.org
Cc: "Randall S. Becker" <randall.becker@nexbridge.ca>
X-Mailer: b4 0.14.2

The reftable library uses randomness in two call paths:

  - When reading a stack in case some of the referenced tables
    disappears. The randomness is used to delay the next read by a
    couple of milliseconds.

  - When writing a new table, where the randomness gets appended to the
    table name (e.g. "0x000000000001-0x000000000002-0b1d8ddf.ref").

In neither of these cases do we need strong randomness.

Unfortunately though, we have observed test failures caused by the
former case. In t0610 we have a test that spawns a 100 processes at
once, all of which try to write a new table to the stack. And given that
all of the processes will require randomness, it can happen that these
processes make the entropy pool run dry, which will then cause us to
die:

    + test_seq 100
    + printf %s commit\trefs/heads/branch-%s\n
    68d032e9edd3481ac96382786ececc37ec28709e 1
    + printf %s commit\trefs/heads/branch-%s\n
    68d032e9edd3481ac96382786ececc37ec28709e 2
    ...
    + git update-ref refs/heads/branch-98 HEAD
    + git update-ref refs/heads/branch-97 HEAD
    + git update-ref refs/heads/branch-99 HEAD
    + git update-ref refs/heads/branch-100 HEAD
    fatal: unable to get random bytes
    fatal: unable to get random bytes
    fatal: unable to get random bytes
    fatal: unable to get random bytes
    fatal: unable to get random bytes
    fatal: unable to get random bytes
    fatal: unable to get random bytes

The report was for NonStop, which uses OpenSSL as the backend for
randomness. In the preceding commit we have adapted that backend to also
return randomness in case the entropy pool is empty and the caller
passes the `CSPRNG_BYTES_INSECURE` flag. Do so to fix the issue.

Reported-by: Randall S. Becker <rsbecker@nexbridge.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 6d0aa774e7e29d5366ed55df19725944f8eef792..572a74e00f9ed6040534e060652e72c26641749d 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -493,7 +493,7 @@ static int reftable_stack_reload_maybe_reuse(struct reftable_stack *st,
 		close(fd);
 		fd = -1;
 
-		delay = delay + (delay * rand()) / RAND_MAX + 1;
+		delay = delay + (delay * git_rand(CSPRNG_BYTES_INSECURE)) / UINT32_MAX + 1;
 		sleep_millisec(delay);
 	}
 
@@ -659,7 +659,7 @@ int reftable_stack_add(struct reftable_stack *st,
 static int format_name(struct reftable_buf *dest, uint64_t min, uint64_t max)
 {
 	char buf[100];
-	uint32_t rnd = (uint32_t)git_rand(0);
+	uint32_t rnd = git_rand(CSPRNG_BYTES_INSECURE);
 	snprintf(buf, sizeof(buf), "0x%012" PRIx64 "-0x%012" PRIx64 "-%08x",
 		 min, max, rnd);
 	reftable_buf_reset(dest);

-- 
2.48.0.rc1.245.gb3e6e7acbc.dirty

