Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BB82749C3
	for <git@vger.kernel.org>; Tue, 27 May 2025 14:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748354673; cv=none; b=E+19nKCQG3Kw6NdvUZ60Pi4ZYnEAOZtX9MVPwzBYKVOZAqaK/pldazIBO+ssJP33+UfjIpn9i3iZHuS0e6PAAsxBN2PVy/B2fByKn+1VMxUeuZW5GdykcxB//MmNkUHQibquBtZbMBouCtPN9fPS/UkIueBI7Am0WlL8+C9QzQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748354673; c=relaxed/simple;
	bh=V7lfoLVtRVEZ92GmC7vcgqxZHnyR814xXK1rxaoPFpc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=r6SWPQL5YeCW1a0uabjGi9CvQSkxZjd4yU5d159yQhMyfochzSzYjF7ZxNRWArVZc8dV9rGH25upTYUt106IP9rno4YXzwWkm6R/jp9UOu+eQmqK+6I4l+5V/Xn4d53KcySD/XYpzDbma9zYPhY2OnfvST9PH9dYJmI3EWk6iGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pen9ms8v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NTw9sZbj; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pen9ms8v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NTw9sZbj"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A2BE3114013C;
	Tue, 27 May 2025 10:04:30 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 27 May 2025 10:04:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1748354670; x=1748441070; bh=IvmW9CAFIF
	gAqsR1sDB3M/Q+bYQdYlwQfBHI3bDaD7E=; b=pen9ms8vMt26wLURi0P7MSu7fK
	O+HzXzlnHdfw+ku6cXiavMU8a6qfHuCu94kHFljnMWtJgo4GkWwtoXKCocb6IiUL
	yFWmPYj41YJbPdBPjfAZ6bW5kmXyfTIJSJRGtfW6w7QAJUcJ3W6nENzo/gtAAYdn
	G5oPoFCMpYskzwPIiYZ/BFw3KGiUBLRSwIF/nJXL8V0zfmSzmY8jp3xhOQip5QAX
	952UG44hVXsSfi0G+b6BN2UqZJfJxtQu5VcAioiBSxWUXt53jBkyM4er19Ni9cb7
	F7ItZ5GaMUtV/C6MmpPMaLMxQtNxr+E4qTIMluRD2oxdB0ksn8ZpdMo/xF9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1748354670; x=1748441070; bh=IvmW9CAFIFgAqsR1sDB3M/Q+bYQd
	YlwQfBHI3bDaD7E=; b=NTw9sZbjwsqz5FZnTsWUpsPSs9ELZwSYGAr7C/3xHHAq
	y+ArZVdyJTmYa0ixKcOpYfc+XNKq90g3ScUbCr+5fVHTJoeXqn+w0Uk+yvvhhGte
	Ot82jprwa1TZ7QTyiLpBdCoRm2TWa2QKDbltwIK28eyxLaXjFrLF4MpPE24yIBeM
	kClc/ooGe+edXRxbq++6IjlzaWDUZMja1UyKuLGvJsJa+XpuGJYHZRZOU1AfznST
	X9yU0UYXK2iSBqKYmGu11scBcCHGmg6fZjnH2MPnf6f2hP68GwsN8qtHkg0UyajV
	eDASMCoKy1KMSnMMExkjKxo+MCJVhV91Lw8hedZu4A==
X-ME-Sender: <xms:bsY1aDxEKZO9MZ5_GA6IG1K1X6Kva6RSc1_BdWo5ZuTuKyG2fWIDng>
    <xme:bsY1aLQRJvOAe3c3nOOPcaMf9VNfMQrBZMbDCaa3AhT1oQBDVtCQrA5nfNrHhxzSO
    EV_jLLGh59LtWIVQw>
X-ME-Received: <xmr:bsY1aNWZbRyQ3wpc33UkiDuc_Q46jcPoZU0NxAnewTNFFwhSUMZ1wff-9MZtW-EhJzY5Q_BTOe6SHGtYWPYGoIA1OsR9QUjkDvvl8hnassMj2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvtdehjeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfg
    vfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrug
    htuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveeugeektdetieegjeeu
    heeuudfgveelfeevheeuhefgteffffevhfeuhfeukeevnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghp
    thhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopeihrhhothhhsehprghlohgrlhhtohhnvght
    fihorhhkshdrtghomhdprhgtphhtthhopegurghsrhgrfhelsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:bsY1aNhJH14kI9sOKtWuqDPSYT-LQQcQWeU6dm6S9bhBBKFC0-UOAg>
    <xmx:bsY1aFBFDs-2jGamm5cely1ug6zsMK1MVZcnKbFT--CONr5wIOOs9w>
    <xmx:bsY1aGL__8E4VMEGghRRc0vbKH4Yx2Uyu-fgsaomNYcvndfKGj7z1w>
    <xmx:bsY1aEBaZ3aU6RyQp03napzEwJXg5D9awym4-UTFzt3uDfMnU6BxFA>
    <xmx:bsY1aC40tvriYwy7IuI7PXg19CTB29QH9QnPHZ7e3Lk6xzZ3FyO3v9bR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 10:04:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 46103d2d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 27 May 2025 14:04:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 00/11] builtin/maintenance: fix ref lock races when
 detaching
Date: Tue, 27 May 2025 16:04:26 +0200
Message-Id: <20250527-b4-pks-maintenance-ref-lock-race-v1-0-e1ceb2dea66e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGrGNWgC/x3NUQrCMBCE4auUfXYhCaaKVxEf1nSqS3VbkiJC6
 d1dfPz4YWajhqpodOk2qvho09kc8dBReYo9wDq4KYWUQ04nvh95mRq/RW2FiRVwxcivuUxcxRW
 jIA/9GaEfyWcWz/r9X1xv+/4D3Y8LaXIAAAA=
X-Change-ID: 20250527-b4-pks-maintenance-ref-lock-race-11ae5d68e06f
To: git@vger.kernel.org
Cc: Yonatan Roth <yroth@paloaltonetworks.com>, 
 david asraf <dasraf9@gmail.com>
X-Mailer: b4 0.14.2

Hi,

this patch series fixes races around locking the "packed-refs" file when
auto-maintenance decides to repack it. This issue has been reported e.g.
via [1] and [2].

The root cause is that git-gc(1) used to know to detach _after_ having
repacked references. As such, callers wouldn't continue with their thing
until we have already packed refs, and thus the race does not exist
there. git-maintenance(1) didn't have the same split though, so this
patch series retrofits that logic.

The series is structured as follows:

  - Patches 1 and 2 do some light refactorings.

  - Patches 3 to 5 refactor how we set up the list of tasks to not rely
    on globals anymore. Instead, we now have a single source of truth
    for which tasks exactly will be run.

  - The remaining patches introduce the split of before/after-detach
    tasks and wire them up for "pack-refs", "reflog-expire" and "gc"
    tasks.

Thanks!

Patrick

[1]: <CAJR-fbZ4X1+gN75m2dUvocR6NkowLOZ9F26cjBy8w1qd181OoQ@mail.gmail.com>
[2]: <CANi7bVAkNc+gY1NoXfJuDRjxjZLTgL8Lfn8_ZmWsvLAoiLPkNg@mail.gmail.com>

---
Patrick Steinhardt (11):
      builtin/gc: use designated field initializers for maintenance tasks
      builtin/gc: drop redundant local variable
      builtin/maintenance: centralize configuration of explicit tasks
      builtin/maintenance: mark "--task=" and "--schedule=" as incompatible
      builtin/maintenance: stop modifying global array of tasks
      builtin/maintenance: extract function to run tasks
      builtin/maintenance: fix typedef for function pointers
      builtin/maintenance: let tasks do maintenance before and after detach
      builtin/maintenance: fix locking race when packing refs and reflogs
      builtin/gc: avoid global state in `gc_before_repack()`
      builtin/maintenance: fix locking race when handling "gc" task

 builtin/gc.c           | 386 +++++++++++++++++++++++++++----------------------
 t/t7900-maintenance.sh |  19 ++-
 2 files changed, 229 insertions(+), 176 deletions(-)


---
base-commit: 845c48a16a7f7b2c44d8cb137b16a4a1f0140229
change-id: 20250527-b4-pks-maintenance-ref-lock-race-11ae5d68e06f

