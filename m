Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FCE2D9ECB
	for <git@vger.kernel.org>; Sun, 20 Sep 2026 17:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789925617; cv=none; b=sW+Dn+FkUtTOdBJApt4nQdKR4TSIQctIZBeZfivz/baHKAyl1rmIJAwfHLndxzyOr1UA/7NUKxRlJH7xK+A1ksOrrLroYDn2OmMlKpIWxucAXWrZpOrHC9GXwgUC3Vynpk1FBtzDWmm8aiC7SCTabqqTRTo4VG4hQaCI8ETt71Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789925617; c=relaxed/simple;
	bh=3IRJ8SIgCVSkTGmAXC9dTICGwhj7WqOAwxeJP10T3gw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KrQIrrhhvImuQ1nQnFdenlkBlnWxF/Vyg+si8epOe2VOiMBm2iIi2QK1en66ifZO6cWzAxgKSVrV9fQGBl0PUDAkVQNQnkxwodbzeGeBDHDxz4Krl6Wg7tu+bRQTPeN3ydFNI4oAO8yvyrXVZvNTEcIZVzTaJ8sAbrjrsb4RT/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aYJW44GW; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYJW44GW"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f55efe5so359152666b.2
        for <git@vger.kernel.org>; Sun, 20 Sep 2026 10:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789925614; x=1790530414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aZ2LpnBGe/+S+gp+6blEr8MRFiOvpR1cBlUSWXKoLX4=;
        b=aYJW44GWNNwkoBskFBAP1sYmDESEgm5VJg0iWlXOtqgq7xcjOVa+gU4KoZW5s8r9Q+
         G+93IWA0sx8Va8V0btqSwEUkTIlcqTHwPCF0HWGTeB6mXYHCU5Swv/Z1K7AgTewUh32H
         N14wSsZgO+JVs9E5RO3eD0EmE4ZzAtsp//katoYDDZyP9LuzC9QfwfiBuLbm/25KPkwV
         Da7atHx2YVQwJ3rD0oCptAA9P0gsW+C7kc2M42zX1cKLc6/8o3mGqclKcaqvLisnMcro
         q2YFBZ+2Bt3OqwUAe0+lw4HgqqFLjW0z5H1tbmEI/rihlmeZrgGV4BcLR7iNKCITHlOn
         dbjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789925614; x=1790530414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aZ2LpnBGe/+S+gp+6blEr8MRFiOvpR1cBlUSWXKoLX4=;
        b=a20g9oIA4yxp4RkOj6/RDHwwg0ATyr9gkITi5ggPRH/4W3t0vXCDGgGKb3ltlRyDzV
         TGLtnM/L0IEjMCNJiyxwkpQaAjnLDz666Gic+enRpETlF5wYKBTAAT61BLE0lq9ID6yB
         zOB5FjQeN4VTXU/XXXjMuLVVNBNjlkrR/GaASmrOWtHqDqsWQZEhebacBWZqDPepoaG7
         FGBVgwMxJ2VohGG2xL8+8om0RRyXNXmF28u8BMOs/QbAz5QWEneU4dk6x8nly4ZoWWQs
         wWjU58WuUaTy9M9T0A1E/LXBfGATzsbvVERZc1a/BH+5VV1JaEI5J+a2b1tAkZlGRr1z
         bO2Q==
X-Gm-Message-State: AFuF++kSTrpcigIEdXqcJH8uTurfxxMLVOfh70CWT0qCEm9L0iR7xLT6
	P4105nfexbLrotC+v1MCZfASIvCjFhdaOZhJIq2jdQiYWKY1V3QQpOI8ddzb+8B4
X-Gm-Gg: AYBFou2sDgY7hrYgaMZVtUcUW/PFhby4f+ahNQZVYXldryDD1aBQykuDjP8sBQBDFMD
	uoOK4xnytheFejUPO3MFMvlDk7L0eiAM78Bq80lT/x4WdVAfpVP1v/ZL5CVR4fHNaIvS3+b0RVa
	76yGyWiEdjz/Bwr69cRb+mlsYiE3IrLHqlEbRnil9JTZ9WLkr104HI0sZKVb7Us5UW8FJewbF0W
	9zR0C+4m9qU4tASvLpow1dg06owiy0NEvO6Xu6a3hUbw+384opZXKzD8ukVtRuos4D+j0ddrn2S
	eDw1JcxJRdbDPtDXmEweYh4OVsuHrQKLzse8GOFuTc79ETrlSwQMS7EhlT6aZ4vLy98QNk0tdHF
	gS9KSpVVzK1JXsIokhlCU6dj5nEP3VPCctq5skaz/tmdPZtrd+ZXsNWKy+KgqBtGFFtrmtJQrYE
	Si7M2Q4XH37BBWhSCsBXCzBh6pSKu5AO8rfZfh3RbbSno15kHjeFXKS3c5rrrKw2OiScHmCvSdf
	wt9wwaYOOOEnqUNxugCcxzz1kP1TDj0Wwtz7B4AUMNnqVBpf0bcVY3wN9MyiBQRQUUmUFVZYVj7
	RIxhS1szMQuTeoqZGhLWZaFID1Q0pdfKmnN2D3NnYmgHnWbU
X-Received: by 2002:a17:907:1c9f:b0:c26:1691:b372 with SMTP id a640c23a62f3a-c2a15827daamr777010866b.43.1789925614609;
        Sun, 20 Sep 2026 10:33:34 -0700 (PDT)
Received: from localhost.localdomain ([91.236.84.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a3570d5a9sm201418066b.32.2026.09.20.10.33.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 20 Sep 2026 10:33:34 -0700 (PDT)
From: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
To: git@vger.kernel.org
Cc: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
Subject: [RFC] worktree: add lifecycle hooks
Date: Sun, 20 Sep 2026 19:33:33 +0200
Message-Id: <20260920173333.1606-1-maciej.ciemborowicz@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

I'd like to discuss adding native hooks for worktree lifecycle events.

Git currently invokes `post-checkout` after `git worktree add` when a
checkout is performed. This makes it possible to detect some worktree
creation cases indirectly. There does not appear to be a native hook for
other worktree lifecycle operations such as:

    git worktree add
    git worktree remove
    git worktree move
    git worktree lock
    git worktree unlock
    git worktree prune

As a result, tools which want to react to these operations have to wrap
`git worktree` or compare the worktree state before and after a command.
They cannot observe an invocation which bypasses their wrapper.

One concrete use case is git-hooks-ext, which provides higher-level events
for Git operations. It currently has to implement worktree events by
wrapping `git worktree` and comparing the output of `git worktree list
--porcelain` before and after the command.

Would it make sense for Git to expose worktree lifecycle events directly?

One possibility would be separate post-operation hooks such as:

    post-worktree-add
    post-worktree-remove
    post-worktree-move
    post-worktree-lock
    post-worktree-unlock

Another possibility would be a single hook, similar in spirit to
`reference-transaction`, which reports worktree lifecycle changes. An
illustrative payload could look like:

    add    <path>
    remove <path>
    move   <old-path> <new-path>
    lock   <path>
    unlock <path>
    prune  <path>

A single hook may be useful for operations such as `git worktree prune`,
where one command can remove multiple administrative entries. It could
also leave room for `git worktree repair`, although I am unsure whether
repair belongs to the same interface.

For the use case I have in mind, these hooks would only need to notify
observers after a successful operation. They would not need to veto the
operation.

Before attempting an implementation, I'd like to know whether this would
fit Git's hook model, and whether a single lifecycle hook or individual
operation hooks would be preferable. I would also appreciate guidance on
whether a stable worktree identifier should be exposed in addition to the
path.

Thanks,
Maciej Ciemborowicz
