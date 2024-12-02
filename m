Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5D61D9A6D
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 20:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733170726; cv=none; b=GXJrCZ1LJmNZ8MYMRU3qDn02w/+LH+nSryMJoXVYQZV+JaYuMnSrjScEdtU/ALZ5tJF7AyHJWoo8Qn/OOlJw0S5jCkEzGzJuDsJmnCutULwbRiLxITyup2FuTNYVcGkKNkX8DkXUUfehOnvaX/LHxzG7Wa6ASB3AKEcJfd2LjIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733170726; c=relaxed/simple;
	bh=s4AOXJzWzvZ/22hNQqeVlJgNVGL2R19bjN5Egzf+Sws=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BSzlrekDV4T9lD6Gkd7G/MOUWHBQE8kMzty4LzBTcz+unW3k9inKAlnVXFhF3eSIvC6smGpqYqVPFQ8SkbbeGQKAkzHfJmsGWViqGdW2mMIzi13d+14NrYyr5UtobwP7y1mMqepvBIER2FTVWibj5YCd1qaKT1rUQLPSxcURChQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UpGY0T80; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UpGY0T80"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7ea8baba60dso5522517a12.3
        for <git@vger.kernel.org>; Mon, 02 Dec 2024 12:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733170724; x=1733775524; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=foZ2NB4/ie+8HEaAPOfO+mercz1XDmuhD73jNG4SUa0=;
        b=UpGY0T80iq6vNa9lmKFTqeXFmwga0SVk2SL9rqCzEVR0HQ4OmguiTu7AN6W6kgpLdG
         Fyewdpm3s/z+afxkPxPy1n6aGGoNohysT//I6i2/47KwI6cSZIRqvfDnd0BmdEaRgyG4
         9RfkkHM3vfMX8OM+DBc+4cigJ1pD/rjYpqbr+9APFqMrubEFWR2Nl5dpFtV8miMmAOg9
         qSiBLyUQlOCnP2ewzdlwvk34iQaM6Z1NfVmpgj4roQLWmsKcOB9umI0dwD2n1CNcD4dw
         ITsHRWskhU2lrI+m4LVr5OzxXZmTn4ewM9qI/71XAM05sCFm+S4IDf2tnzGm/RdA+P/I
         WsRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733170724; x=1733775524;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=foZ2NB4/ie+8HEaAPOfO+mercz1XDmuhD73jNG4SUa0=;
        b=s8s0mGvqjbylTCLtzw31+tdvaDzpseFQ5U0qvgdSReEysQWMEN6Qtxu8ElQECiL074
         V5RgrZFTYx0D7FabRlPPP/bTHQqUxPIIJRM9UXRsU3MjIzSagePsDjcjYybJPEY4B5Al
         oYDgEaMs3mRfufrMcFrM63YiKPomVSKcnqF3dNPE9d+dkkbgBhJXpPtICzEXM3bn/FVZ
         do02dAKp1m4ZNRisJFkTJTwf0XwC/Ohet2JaFA3OtkLhjNMDG01XPPoExwQGvvxPubu7
         DNPh9bavdIeIHf/OFhRhGo6a1B+EyuwHfqba8mrbbImbzaZAHyAAlpGM6n8eHdM6PyTz
         kXHQ==
X-Gm-Message-State: AOJu0YzGgPbsqbujpdBmCMFiN3PFjbmkuCUt5aybEWQxn+AlxEgEnIqP
	Fj6WJ/+p9EvFXrzkKT3l/C/RZrXmhG6Qa0b8rqJS8hiQVWovSWyWC5Ts5pDcpp57m6CJYfxVhWO
	NVPOpeNvUNXT+RbjFE5bVCfYR8LsAYBGj9/57FTEmSE/mdfwDa3aJZGJepXKecoLbW4hfEJ7luV
	XWCwzQqHM4rY/BfKb85klHlN+lPH1ogbZYMiajo1003SyE0zOKlPrw0K/LXx74E+RH4w==
X-Google-Smtp-Source: AGHT+IHcCyvwrQ2yX0QPMsNQ+YtZXcyANpSUSyUIw792U3VF0vZvv0BSACaF9v1WiWEHUw00eGHRC0A8T6efyVoHt1jY
X-Received: from pfbeb28.prod.google.com ([2002:a05:6a00:4c9c:b0:725:44a1:b5c2])
 (user=jonathantanmy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:2583:b0:1e0:d380:fe71 with SMTP id adf61e73a8af0-1e0e09e2467mr35204619637.0.1733170724013;
 Mon, 02 Dec 2024 12:18:44 -0800 (PST)
Date: Mon,  2 Dec 2024 12:18:37 -0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <cover.1733170252.git.jonathantanmy@google.com>
Subject: [PATCH 0/3] Performance improvements for repacking non-promisor objects
From: Jonathan Tan <jonathantanmy@google.com>
To: git@vger.kernel.org
Cc: Jonathan Tan <jonathantanmy@google.com>, hanyang.tony@bytedance.com
Content-Type: text/plain; charset="UTF-8"

This is a follow-up to jt/repack-local-promisor [1] (but these patches
are based on master, since that branch has already been merged).

These patches speed up a fetch that takes 7 hours to take under 3
minutes. More details are in the commit messages, especially that of
patch 1.

Thanks in advance to everyone who reviews. While review is going on,
we'll also be testing these at $DAYJOB (I've tested it to work on one
known big repo, but there may be others).

[1] https://lore.kernel.org/git/cover.1730491845.git.jonathantanmy@google.com/

Jonathan Tan (3):
  index-pack: dedup first during outgoing link check
  index-pack: no blobs during outgoing link check
  index-pack: commit tree during outgoing link check

 builtin/index-pack.c | 49 +++++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 23 deletions(-)

-- 
2.47.0.338.g60cca15819-goog

