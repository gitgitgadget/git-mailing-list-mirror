Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4873B8920
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 07:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784188377; cv=none; b=HARRVgKlokcQsFKoQE9PdcelszpwcGKyfFwAUYfYtmoIRNIsr6p3/6LkL+g9ZUqyP3F7Tr57SIW6Mn8YYhpPtcRr4HwoFlhSDxBRMUFjopUzps/GsifZE6jBVO00AnPMmmwbHNLNYTxDGVhs0Ov66vcA8if4o89RjmfUj0F+V+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784188377; c=relaxed/simple;
	bh=/18vg7Up6H8BKUNVGdJ91usz9AGvBKb82HzeMqUFoHc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C7IUfDVX5MlMQd13o/aHYnxCXtbNXjeQSff7neBDMmrMQbPQj7VjfVhcClLCnrrOtdNqUJTW8vgTiGpFZWRZq37fl1jOgLoVH7IWeRvPKXYa9LszG1HspRlVWOxfZy9+5Sii0U/x40VvG+0LlPkJLF8tb43IpQTEU7wUgn2XPCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=e8o0lsKz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KQcBu09U; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="e8o0lsKz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KQcBu09U"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C0DBC7A0172;
	Thu, 16 Jul 2026 03:52:46 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 16 Jul 2026 03:52:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1784188366;
	 x=1784274766; bh=kyMQzYXgN5BdHHp9E0w+4yOkrNbObHp0FYTWvjy51x4=; b=
	e8o0lsKzDdBCclgPAU+iPE7k6QkL6f4u0U7Qc2azWRGmgR9M6yBjqWEY3AoNev6o
	D6SnbWZPvGGaAaKflKBLPBcuw36+9cVxzGBcF4nEEYpg5BQuiPkWe0rG96HpD8kC
	wfr8u9OKLkCbKyNmVBeMdLUlkbS8J8TnW30WxhXiyMzOvYJ9TEHu5mMPqp2gLUF4
	8vXAXV4Ifyw9htOZdxcdgNlZAstdlu7+o9jpD84NPz4Z5W5nINcLjGm9jcMdnOMe
	med1I290uSP/kjRMCFhbaIJguXRcLZ/Q+O6O0FfhSyrxWFXRJQCtkGd8UBigU0iv
	fm2kxv5L9rVaGIjNUja6MQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784188366; x=
	1784274766; bh=kyMQzYXgN5BdHHp9E0w+4yOkrNbObHp0FYTWvjy51x4=; b=K
	QcBu09USahpt5zn0Ci42B5dSokPvjvmdQik3d4Cgqm6DnCcrb8wshjZtubDB9uDP
	qJ8sLkSanLjMhpGJ6njv6h9QXsmV7qEPNg5khSAek9YVVKmiRUA+GIfLZr3hHtX2
	ZzWCFF5JnC1YW4kxGfOiUW7WBAFklOJkiJsPghxiq9TA01LcH/R3bG3utVkRPK2L
	j9ASG49ca+YD2TsrfhhTUS78MIM+o4LV/sv0/mvoDSlNzwE9nVzfzKwDge2c6abM
	FEPLnL+a9rTrhyINr+MCEYLuJxk7RC4z19jz0VW9fSZ/f0UkgRRfj/h3yXDH/+x8
	rp75bFkUk8rho7s/hCAbA==
X-ME-Sender: <xms:zo1YarQVJD5MaMrggckcYDwQ4ge8XT898TfBKM0oQ5UGPLLombE7jg>
    <xme:zo1YamwTtm-jqUq98N-FeLt48DpOlk7JbXv4NM4yIyjkF09gXgaW1xZeKUmek_UCl
    PM1pEDhguU7RwT7BJzoj69vCD50RpEKW9Ws-HlXuDjAkp8I2nxr9Q>
X-ME-Received: <xmr:zo1Yanfbx91_V_VOb--4bc76lmFnUDg7ZropyYQNqALyn1akb2aySLoleRP4FfyuDF1OFt5Sc1cj7aNHoK24iQbrfjcvHkdAsk0eGao->
X-ME-Proxy-Cause: dmFkZTGOlf285yZ3X+c/PJV9ag1wkWbR4p0TW8If2NqMRC5DdpBVEtYULU0iA9An6BQ0XE
    gB+V1kBLkJLxHM/6+gp13MPHat3k5j8e68HDZU84RgaFaYzihmDZtE8E9rRu+mfm2wYv9w
    AVJGqcTVb90ULT67061l4kPa1H4un9Dh2Q3UeQOcTggB2CIdSYZl8Oksw9hVPPeCpPH4r2
    8+nW6PNLh50A7T6vRyAu0SI7GZ/VrcWGc2vW/vsgp2kVtyCxx2bQOd2FaoXbAvV4qh5cXb
    iB69vy5FVQycrTgC4KANegzRElFJIgUwI1DGtRr9vjqHVj3XmusehvWNhew2snbwJ+Onth
    i99heAsPKnj7KaSvLtL85lp2aRu1Ph6G/9UltzOC+hbnBlQCWIIESL5k7eEzcLcGmTtEIV
    fZYGkwTc1daTB8vxA71KQo6QGp2+QfebS+4mFOOJnTeCRHQV+G1dlwwbku6Iq/zJDUMrjw
    RfGoY6bj6FlYg0r5RfB6DusesD/oc50FyCWMMNqO2TIJQ7GOePsGD5RWhg66KglXAahwIo
    9QPpju3+ruZsLTIXOy5hOA/dHGaWHoJB0h16wme/ctphg3ws688qN8+qXE8Etq8yA7YmUg
    pqC9GYcKSEQDQavYhArnBTBV5X6kOLnPEpJCsQu+GIoOaCibZfLDIVftXTiQ
X-ME-Proxy: <xmx:zo1YapNZsWEC_ZGUwjXY_an4wV8JxMr4sYJ09lHcPOo7WsM6AjOlbw>
    <xmx:zo1YaiuGRH996HbKW2-i7xbcI3HtUmcjrAhDSEvX4NV7iG_gL16Pig>
    <xmx:zo1YaqCiD-3FouVXRLCOZISO1WvXwSJsZBqTo8WDkTzTdXRxK68ndw>
    <xmx:zo1YahbTYS6IBMxIPjPPU-59EPOQkrd5zfSbsBHQxKFiuhs61Z9CPQ>
    <xmx:zo1YahCxsmPkhNFaqi1EoX3eeGzYUP_t2bIL5DyKZ8EdQxiWfnNd-AN9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 03:52:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8a57fa97 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Jul 2026 07:52:44 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 16 Jul 2026 09:52:22 +0200
Subject: [PATCH 4/5] sideband: use writev(3p) to send pktlines
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260716-pks-reintroduce-writev-v1-4-ea9038c884bc@pks.im>
References: <20260716-pks-reintroduce-writev-v1-0-ea9038c884bc@pks.im>
In-Reply-To: <20260716-pks-reintroduce-writev-v1-0-ea9038c884bc@pks.im>
To: git@vger.kernel.org
Cc: Ben Knoble <ben.knoble@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Jeff King <peff@peff.net>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 "Randall S. Becker" <randall.becker@nexbridge.ca>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.15.2

Every pktline that we send out via `send_sideband()` currently requires
two syscalls: one to write the pktline's length, and one to send its
data. This typically isn't all that much of a problem, but under extreme
load the syscalls may cause contention in the kernel.

Refactor the code to instead use the newly introduced writev(3p) infra
so that we can send out the data with a single syscall. This reduces the
number of syscalls from around 133,000 calls to write(3p) to around
67,000 calls to writev(3p).

This change leads to a performance improvement for git-upload-pack(1),
but we have to cheat a bit to really make it measurable. Usually, the
time is strongly dominated by generating the packfile itself. But if we
precompute the pack and serve it via the pack-objects hook then we can
essentially eliminate that overhead. The following setup is executed in
the Git repository:

  $ cat >request <<-EOF
  0048want 5ce91c059e41090e7d2cffad39c04af8acf98dc1 side-band no-progress
  00000009done
  EOF
  $ echo 5ce91c059e41090e7d2cffad39c04af8acf98dc1 | git pack-objects --revs --stdout >pack
  $ cat >hook <<-EOF
  #!/bin/sh
  cat >/dev/null
  cat "$(pwd)"/pack
  EOF
  $ chmod u+x hook
  $ git -c uploadpack.packObjectsHook="$(pwd)"/hook upload-pack . <request

Benchmarking the last command leads to the following results:

  Benchmark 1: HEAD~
    Time (mean ± σ):     192.9 ms ±   0.6 ms    [User: 106.5 ms, System: 95.3 ms]
    Range (min … max):   191.7 ms … 194.1 ms    50 runs

  Benchmark 2: HEAD
    Time (mean ± σ):     141.1 ms ±   0.7 ms    [User: 63.2 ms, System: 86.6 ms]
    Range (min … max):   139.8 ms … 142.7 ms    50 runs

  Summary
    HEAD ran
      1.37 ± 0.01 times faster than HEAD~

This might not be impressive in absolute numbers when you also take into
account the time it takes to generate the packfile itself. But GitLab
(and supposedly other forges) have caching mechanisms in place that work
exactly like the above setup, where repeated incoming requests can be
served from the same cached packfile. And in those cases, the impact is
sizeable.

More importantly though, as hinted at above, GitLab has observed in the
past that with enough cache hits we eventually start to saturate a
semaphore in the Linux kernel itself in the pipe write path. This
bottleneck is being moved a bit by having to do less syscalls.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 sideband.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/sideband.c b/sideband.c
index 1523a53e1d..94e5b56172 100644
--- a/sideband.c
+++ b/sideband.c
@@ -441,6 +441,7 @@ void send_sideband(int fd, int band, const char *data, ssize_t sz, int packet_ma
 	const char *p = data;
 
 	while (sz) {
+		struct iovec iov[2];
 		unsigned n;
 		char hdr[5];
 
@@ -450,12 +451,19 @@ void send_sideband(int fd, int band, const char *data, ssize_t sz, int packet_ma
 		if (0 <= band) {
 			xsnprintf(hdr, sizeof(hdr), "%04x", n + 5);
 			hdr[4] = band;
-			write_or_die(fd, hdr, 5);
+			iov[0].iov_base = hdr;
+			iov[0].iov_len = 5;
 		} else {
 			xsnprintf(hdr, sizeof(hdr), "%04x", n + 4);
-			write_or_die(fd, hdr, 4);
+			iov[0].iov_base = hdr;
+			iov[0].iov_len = 4;
 		}
-		write_or_die(fd, p, n);
+
+		iov[1].iov_base = (void *) p;
+		iov[1].iov_len = n;
+
+		writev_or_die(fd, iov, ARRAY_SIZE(iov));
+
 		p += n;
 		sz -= n;
 	}

-- 
2.55.0.313.g8d093f411d.dirty

