Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4AD391E40
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 13:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773149110; cv=none; b=Ab0pwEsUbzPckwOCsK9upoHy8aJmUtlxYhmTClrhAE3b9P3cNq8C8pIO8NWdA+cJzJNwsuADnb7DcFjl3Na30TJTRjGkAPVa1ZWyAlu0dj8q2c9LhDqu8kT2TjwvRuisPRxRMelAVKjL6PTTuODwH/kJzwvHPNdkq89Ha+p7db8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773149110; c=relaxed/simple;
	bh=ocwcEOjt1hi6WT7JRhh7chTMusEZtxKumPydgdQgXeE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=fKN1wHVcaaiwltB9oRcVXL9xvKjYHZc1uZSoZ1Es3B+YPBGjdarEgz6PyZUiP8FEKGfP6kjCq8MwgF5CSp8o40vii89q7piFl4I9HYmWjOoDDninhmm2bnb0/RxVkqdh79mBXMRzTRIdLoZUyhtY0tgizoCy5jVifHOft5dyagI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bqDTyacn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kGxX2JzV; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bqDTyacn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kGxX2JzV"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3372B14001D7;
	Tue, 10 Mar 2026 09:25:08 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 10 Mar 2026 09:25:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773149108;
	 x=1773235508; bh=z7I1MvkEJ9HLBeIzy/tEBPU68FkUpA/p0QeI5CGYrZ0=; b=
	bqDTyacni+txeGypq6B3qRowUxLkHaB1i3bhJifI8ZLB8Lk7fIg+pm0Ke6Cq53PW
	NiPCeSPoqLDyfuHIU2sk6erKsvl0ZZ+l9jSn3kGvm1CF52JLVi3JuBzBX/CLK7QN
	OrlQ9gavfOo4MQTG8VEfAHmUpflMGBij519U79AAkp0PMTpDU6p27viNcniNdHtD
	47e4HPz5LeLkrlnNB7ZpACryBayHB+5aJTzpIBqn9e/G843yUbpurN7HiUlc+Fm3
	6k/wV/Uvp0qqCpyWaUTz9GhZ8a08/CyBc0g4KOIBRW8uq2pKrSjfJPa+Spz3XT0p
	k+8dYRukLS0hI4HnWPSIAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773149108; x=
	1773235508; bh=z7I1MvkEJ9HLBeIzy/tEBPU68FkUpA/p0QeI5CGYrZ0=; b=k
	GxX2JzVm/+/FtWR3hIgcIRlmLymDgm+Ci0hfR3tAFRWC3PvvhHMbtj5K60rO/ITT
	OwaT7JpzxIYFT6xC6z2U953SHnfW2DhAYQmjniXfBeEVS/tLpBNoUO34iExcV5ec
	rAqmuXx/W8aQeN2xU3UDeZHyHhvYgoAt9hfqe8uTWFGFBYgKDtzsSUbuP8jWKGuV
	U8S3f5pFG4VNElzZB5Tc3eR5cZ6YC1xbuJhkDJla1NeRjmqa7H3paS9jX6Ed60BA
	4jJ6N6NL5Np838M7WT37KAapuI5z2x2Wu/DcbeTcglBt1A6hQ9HWBDTi9Pq2nKyP
	0ZUSi2Comwdn0vtUxFceg==
X-ME-Sender: <xms:sxuwaUCILVd2WDbLRzfD3xBlrbZSZk-X_hsercFmmKgS7q6wDzgfDw>
    <xme:sxuwadZp-TyfRNb2XWxv_kbVkvbztTbAkmRNZr-eZrGNfj3OAqIe5plBYub0-YaYK
    io1lUBnJqng-3fvGl8hfm0iB__WkjGD-Et9XQd_E13DLLXyeSQWhA>
X-ME-Received: <xmr:sxuwaf7motOxfSdaYN5lVgyv5BRMlQ-tVTYqFo9YQZD1B_flts-dLCBLXRp89lgFjkGx2JbsobRq4Go3yTUSJ-R6i_2KLafMAXc49Oez>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeduudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetkeelkeeuueevkeeufeegvdfhueeilefgtdegteeifeehkedvhfduvdekvdehvden
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhtlhgrsgdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjie
    htsehkuggsghdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrd
    hnvghtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehmshhm
    ihhlvgihsehgihhtlhgrsgdrtghomh
X-ME-Proxy: <xmx:sxuwaWa4rTPcU6pvzh02FCTYDbRn--yc3vnIrBoTTzNK3k8B4lkF9w>
    <xmx:sxuwaWjkwLvbLR4lerwowKK8IeUSUEtLLBUWkEvtpc3hA0tLTbXoAw>
    <xmx:sxuwaf8JMwKaITNUyqR5Zop_FrRh0k59uQMitalPA4XMzrz0swsCGw>
    <xmx:sxuwaZqjA3obV2TgiQPzNtArzLxJbURBoIVDh2zItmBBVk84PPUxFA>
    <xmx:tBuwaa6EPPgr6cm5FBKDjnn6IBpNu2U3-EI4V0TezI-RgY3cMl1nFHUq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 09:25:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c32779c1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Mar 2026 13:25:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 00/10] upload-pack: reduce lock contention when writing
 packfile data
Date: Tue, 10 Mar 2026 14:24:56 +0100
Message-Id: <20260310-pks-upload-pack-write-contention-v3-0-8bc97aa3e267@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKgbsGkC/5XNTQ7CIBQE4KsY1j7DT2mrK+9hXDT0YUkVCCBqm
 t5d2oVudTmTzDcTiRgMRnLYTCRgNtE4W4LYbogaOntBMH3JhFNeU84b8GOEu7+6rgffqREewSQ
 E5WxCm8oYKiEVUqalxj0pjA+ozXO9OJ1LHkxMLrzWx8yW9g88M6DQsLrWyKVsaHUsk525kUXO/
 KsJKn7Q+KIJzlpBNW01frR5nt9T/mAnGwEAAA==
X-Change-ID: 20260227-pks-upload-pack-write-contention-435ce01f5fe9
In-Reply-To: <20260227-pks-upload-pack-write-contention-v1-0-7166fe255704@pks.im>
References: <20260227-pks-upload-pack-write-contention-v1-0-7166fe255704@pks.im>
To: git@vger.kernel.org
Cc: Matt Smiley <msmiley@gitlab.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
X-Mailer: b4 0.14.3

Hi,

this small patch series fixes some heavy lock contention when writing
data from git-upload-pack(1) into pipes. This lock contention can be
observed when having hundreds of git-upload-pack(1) processes active at
the same time that write data into pipes at dozens of gigabits per
second.

I have uploaded the flame graph that clearly shows the lock contention
at [1].

Changes in v3:
  - Fix handling of `iov_len` overflows in writev(3p) wrapper.
  - Add another patch that causes us to flush out data instead of
    sending a 0005 keepalive packet.
  - Link to v2: https://lore.kernel.org/r/20260303-pks-upload-pack-write-contention-v2-0-7321830f08fe@pks.im

Changes in v2:
  - Change the buffer size in git-pack-objects(1) to also reduce the
    number of write syscalls over there.
  - Introduce writev to half the number of syscalls when writing
    pktlines.
  - Use `sizeof(os->buffer)` instead of open-coding its size.
  - Improve keepalive logic in git-upload-pack(1) to account for
    buffering.
  - Link to v1: https://lore.kernel.org/r/20260227-pks-upload-pack-write-contention-v1-0-7166fe255704@pks.im

Thanks!

Patrick

[1]: https://gitlab.com/gitlab-org/git/-/work_items/675

---
Patrick Steinhardt (10):
      upload-pack: fix debug statement when flushing packfile data
      upload-pack: adapt keepalives based on buffering
      upload-pack: prefer flushing data over sending keepalive
      upload-pack: reduce lock contention when writing packfile data
      compat/posix: introduce writev(3p) wrapper
      wrapper: introduce writev(3p) wrappers
      sideband: use writev(3p) to send pktlines
      csum-file: introduce `hashfd_ext()`
      csum-file: drop `hashfd_throughput()`
      builtin/pack-objects: reduce lock contention when writing packfile data

 Makefile               |  4 +++
 builtin/pack-objects.c | 23 +++++++++++---
 compat/posix.h         | 14 +++++++++
 compat/writev.c        | 44 +++++++++++++++++++++++++++
 config.mak.uname       |  2 ++
 csum-file.c            | 28 +++++------------
 csum-file.h            | 16 ++++++++--
 meson.build            |  1 +
 sideband.c             | 14 +++++++--
 upload-pack.c          | 81 +++++++++++++++++++++++++++++++++++++++-----------
 wrapper.c              | 41 +++++++++++++++++++++++++
 wrapper.h              |  9 ++++++
 write-or-die.c         |  8 +++++
 write-or-die.h         |  1 +
 14 files changed, 239 insertions(+), 47 deletions(-)

Range-diff versus v2:

 1:  ef3244ffcc =  1:  540b577540 upload-pack: fix debug statement when flushing packfile data
 2:  3297edd609 =  2:  253d119b10 upload-pack: adapt keepalives based on buffering
 -:  ---------- >  3:  960c650063 upload-pack: prefer flushing data over sending keepalive
 3:  84671fb222 =  4:  0e147c41cf upload-pack: reduce lock contention when writing packfile data
 4:  bd1f070cb4 <  -:  ---------- git-compat-util: introduce `cast_size_t_to_ssize_t()`
 5:  d5acbd1584 !  5:  b6fbd89b8e compat/posix: introduce writev(3p) wrapper
    @@ compat/writev.c (new)
     +ssize_t git_writev(int fd, const struct iovec *iov, int iovcnt)
     +{
     +	size_t total_written = 0;
    ++	size_t sum = 0;
    ++
    ++	/*
    ++	 * According to writev(3p), the syscall shall error with EINVAL in case
    ++	 * the sum of `iov_len` overflows `ssize_t`.
    ++	 */
    ++	 for (int i = 0; i < iovcnt; i++) {
    ++		if (iov[i].iov_len > maximum_signed_value_of_type(ssize_t) ||
    ++		    iov[i].iov_len + sum > maximum_signed_value_of_type(ssize_t)) {
    ++			errno = EINVAL;
    ++			return -1;
    ++		}
    ++
    ++		sum += iov[i].iov_len;
    ++	}
     +
     +	for (int i = 0; i < iovcnt; i++) {
     +		const char *bytes = iov[i].iov_base;
    @@ compat/writev.c (new)
     +	}
     +
     +out:
    -+	return cast_size_t_to_ssize_t(total_written);
    ++	return (ssize_t) total_written;
     +}
     
      ## config.mak.uname ##
 6:  e3525cd25e =  6:  0a90ab2f62 wrapper: introduce writev(3p) wrappers
 7:  fe07f2d331 =  7:  5e29cfbf10 sideband: use writev(3p) to send pktlines
 8:  4563ad923f =  8:  32b59d5f29 csum-file: introduce `hashfd_ext()`
 9:  549b3dbefc =  9:  a5b0eb3627 csum-file: drop `hashfd_throughput()`
10:  155f79b128 = 10:  a82959772e builtin/pack-objects: reduce lock contention when writing packfile data

---
base-commit: fb1b83bcddff60463f6e86bb021784c88d0b748c
change-id: 20260227-pks-upload-pack-write-contention-435ce01f5fe9

