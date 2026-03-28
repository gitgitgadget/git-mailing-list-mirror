Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A14A40DFA3
	for <git@vger.kernel.org>; Sat, 28 Mar 2026 00:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774656681; cv=none; b=G2/+4kWrgElXqquFhPn/kzMf22/yDQ8/JY0iOC1rdsV9m5O2cRC8s7wppGc2apxOw1CndVNPoKNYFAXU+zUxqzFHm8W663E+TygD2vwy75MfRq/x+PBVuqanCZnw0IK65gr/uUS7XphEeVWGMdaadVh2lA0OA2ZngQxDYe5Q9nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774656681; c=relaxed/simple;
	bh=qQB1Ze7ds6EIM8spzg+/kwZO+aY1PT80Bncm9g+bGDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g6V2l9CEvRb/jl6GsQkjm6ntUGcltOi57nl2qhVuEhvHEVwcKjBuNdQtq8BmZOqj2TJyLzh3nmPSwmiT2RnMuEO7BZ6DLa2fyhbhJlLTUOw+27YUnQ1J6Mf6MvaTx9wsfsAL4x0BSg0PNMT67tzEUJe0DX4hFVrigJ9ss+F25HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=smFWP8Lb; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="smFWP8Lb"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-486fda2a389so21247975e9.1
        for <git@vger.kernel.org>; Fri, 27 Mar 2026 17:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774656678; x=1775261478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ztxGQ7RMdo4TC4Dk+KaE+5mvFfCyM3zZYEDO5sfcZvM=;
        b=smFWP8LbSfn2Dq5VDE1d2ybj0wAJUp5/O3P8qjwbLsSyllvDxDZGF4MKEBIEzkDxdw
         +er027YwM4UhE8QJl5WltCmAiz4lAGIldUQ5dIv9+fj1TVVAYm88Lw7ZSDb+rkqEA+7N
         IAuh2iOR+ghsGwwOfNxzhIN2UZcj0hn0YReroqd/jDH1Lll2UWIGYjozoB8lFK9zIGXT
         k6feGKrbfV0BU30B+19m/LR1kzvcWlBwkL7sHVPDdIOG3+f+/6WiD4Gj72EApROLlCfJ
         fHHz1f8y7ZuwR2Rv3cY+Xi6mRSMd8WqarSjgb4VA+5TeYDPKmsATozkFBsOX1P/GsmNy
         xRVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774656678; x=1775261478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ztxGQ7RMdo4TC4Dk+KaE+5mvFfCyM3zZYEDO5sfcZvM=;
        b=esaKT7rWl23Y+GTxvrwHtOlC+P4tghzk7SLq95eS3ERs8SWz0yd20Q9bpnU9Ofr8CO
         Nlv6ni2UW7Qizm/kg0BxeLhhQFF+voOZ7FZYaqS3ruTBKjvtfwjk8X62XAzmyj40qiWR
         hDtkODgRncjfx8qBEfM52sj0OzotHCYxGVKCgWjel8Uv7Ly4jR4c1v1unwk1IwLbZYcj
         dSfkjDiVdZ2Mg4AvukCXTaCPFX7s/QJ/KaQyZEGDKEmIl76sm4fZuKrKzgWzXJvUU7KV
         bPS1ZjGSzat9M9HDNu/Fp8+nWogHPwNel/Un/aX0YKQIuwKKk72CUlrKCEN1na2MpgqO
         Bkeg==
X-Gm-Message-State: AOJu0YyRreGcgnnRJxdZ9IWo+CRuBge76ozWaKqYq67OHOudhkKczLuZ
	Ea0wz8YdUCBzD876XNqt6B5rKAfzGB8pTNUhvSzSX1U7/wuA6qkD75Q0m0u8RqnFuUw=
X-Gm-Gg: ATEYQzyKGTOkzfJ2LxOujMPqCzZLQ6x6A27V2Wwb0EHfgGghhB61kb9UPYtzA1w/j/H
	6ru9r832MRd+x9ZKW70dId73/Z+UV/laSFz/QLrNxt9Pb2xz6Azzrod8AyIvEahOKm42FLLEWBw
	ctBEGd6oEQrGMS0RitvOzmcuxSolZCYqfpXqOQARYWlJB7uYvndGaITnBaTBRkQY/k3mMgxUy+S
	H/EqmqnGdfWaB5I3ifv7uE822OUlqmSrFRboNCVfD2pnO8nfIdS1f7ntXjMwImNdgwSM/638+Gk
	zeWN++cpWEPv+KsJuGm3WJ1Dod0IbHCxc8iwYgj9q9dRYim6Xjmp5V9+0i4KQGh9N5HClVMcwPA
	BFSSqG/7ub5y0RDrx7h7y8lG+M+t63kK94lUXfEqZH26mW80B8OyHXAM/vsQihzr0uoYsDy1Rmv
	0ZFytjWe+e6lr+XFlf4qVYh08aj294t8c1lD/F8aHGD/X8OwgWIDo7zdPX8EcI5IGODbUZSlXBP
	5E/h1zkJoMAwQyA0BOZ5IHvdgYR++XEnYu2xYz+4osxa9p3goDB4vxG0f8=
X-Received: by 2002:a05:600c:a44:b0:485:9a50:3384 with SMTP id 5b1f17b1804b1-48727efcb32mr74510575e9.25.1774656678299;
        Fri, 27 Mar 2026 17:11:18 -0700 (PDT)
Received: from farblopa.localdomain ([84.126.0.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722d2366dsm116147635e9.10.2026.03.27.17.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 17:11:17 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	karthik.188@gmail.com,
	jltobler@gmail.com,
	ayu.chandekar@gmail.com,
	siddharthasthana31@gmail.com,
	chandrapratap3519@gmail.com,
	gitster@pobox.com,
	j6t@kdbg.org,
	szeder.dev@gmail.com,
	Pablo Sabater <pabloosabaterr@gmail.com>
Subject: [GSoC PATCH v6 0/3] graph: add --graph-lane-limit option
Date: Sat, 28 Mar 2026 01:11:10 +0100
Message-ID: <20260328001113.1275291-1-pabloosabaterr@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325174401.217577-1-pabloosabaterr@gmail.com>
References: <20260325174401.217577-1-pabloosabaterr@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Repositories that have many active branches at the same time produce
wide graphs. A lane consists of two columns, the edge and the space
padding, each branch takes a lane in the graph and there is no way
to limit how many can be shown.

The limit is a horizontal truncation, each lane is cut at the lane limit:

  Without --graph-lane-limit:

  *   7_M1
  |\  
  | * 7_E
  * | 7_C
  | | *   7_M2
  | | |\  
  | | | * 7_H
  | | |/  
  | |/|   
  | * | 7_D
  | | * 7_G
  | | * 7_F
  | |/  
  |/|   
  * | 7_B
  |/  
  * 7_A

  With --graph-lane-limit=1:

  *   7_M1
  |\  
  | * 7_E
  * ~ 7_C
  | ~ 7_M2
  | ~ 7_H
  | ~ 
  | ~ 
  | * 7_D
  | ~ 7_G
  | ~ 7_F
  | ~ 
  |/~ 
  * ~ 7_B
  |/  
  * 7_A

The '~' is the truncation mark, not an actual lane. It was chosen because '.' is
already used in octopus merges and '~' is not used elsewhere in the graph. Yet
the edges between the last visible lane and the truncation mark are still
conserved.

The '*' commit mark is visible when it lives on a visible lane or the first
hidden lane, any deeper lane doesn't show the commit mark but keeps the commit
message visible. 

Merges where neither the commit nor its parents live on a visible lane are skipped
because they don't carry any visible information.

The original idea to limit columns was noted as a TODO in c12172d2ea
(Add history graph API, 2008-05-04).  This does not implement
gitk-style column rearrangement, it only truncates the visual output.

Possible future improvements:

- When all branches involved in collapsing or padding are over the limit, the
  truncated lane doesn't show any information, this lane could be removed to
  make the graph more compact. Currently these lanes still appear because
  graph_output_collapsing_line() mixes state handling with rendering, so it can't
  be skipped but callers always expect a non empty buffer. Fixing it would need
  to refactor the callers to handle empty buffers instead of expecting them to
  always have content.

- Collapsing and merges lanes that start on visible lanes but end on hidden ones
  are kept to maintain the most information possible on the visible lanes, but
  the information about where they go or come from is lost. They can be kept,
  removed or think of a way to show that information without showing the lanes.

Changes since v5:

- Changed patch structure
- Fixed octopus merge truncation check to commit_index + 1 + i.
- Added check for first_interesting_parent() NULL check.
- Shortened variable names.
- Added clarifications when converting between lanes and columns.

Pablo Sabater (3):
  graph: limit the graph width to a hard-coded max
  graph: add --graph-lane-limit option
  graph: add truncation mark to capped lanes

 Documentation/rev-list-options.adoc |   6 +
 graph.c                             | 178 ++++++++++++++++++++++++----
 revision.c                          |   6 +
 revision.h                          |   1 +
 t/t4215-log-skewed-merges.sh        | 144 ++++++++++++++++++++++
 5 files changed, 311 insertions(+), 24 deletions(-)


base-commit: 5361983c075154725be47b65cca9a2421789e410
-- 
2.43.0

