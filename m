Received: from mail-ej2-f42.google.com (mail-ej2-f42.google.com [74.125.228.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D3430ACE6
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 18:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791053272; cv=none; b=N8Tb79JtrQmTdCHxxYMa2s1JTuh0qqMmkzcuBxif+uZ2WGdIsmnmxKAUWcuH/HhncSKSNJCdQzefL6Rmd8MO8WyGVypCpTUYV2UD/oU7nZFf8z6l2iYtwDBXOrI4TbMgBKfHMxRcHOscN32UMM1aHMtS3SmhVeb9sRkDMMZey50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791053272; c=relaxed/simple;
	bh=QGaMFZeGqzM6vFi3evbYOljRGS7ufnh+YVN/IZsJ2Gw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gzGoCSNI4UnDrZnvygVkrI8ffyZDxwH7TlMUtfRaGltE2h6zEDn/MKZrRlTks3yb0x6EVrY6zUm9gU5vEfJHtnc4Ox8utg7fZ1n7NgCjnuW0gCFN6XcXpHiLFDnMJwwT7D2lvH/G9WjzedytoNIFyrdPzzzEblLjOK5w1mtqXW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NImGaaFu; arc=none smtp.client-ip=74.125.228.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NImGaaFu"
Received: by mail-ej2-f42.google.com with SMTP id a640c23a62f3a-c2e7c1d9202so41159066b.3
        for <git@vger.kernel.org>; Sat, 03 Oct 2026 11:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791053269; x=1791658069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QGaMFZeGqzM6vFi3evbYOljRGS7ufnh+YVN/IZsJ2Gw=;
        b=NImGaaFuEBSrgqOGRGkp3Ka2iBCZ/2PLG1QIpsaWQvk0H81rxJsnzbTd9mZq9ddIqn
         HQau4vRHxsm/jmgDnVDfO7HAdXVnZkyDkxbNTMPEbe8px3hGCsaO9e/538VFJmZiz6ma
         mrpWoHu8muf/WGkAyBaqwiFb4+eAEQVlJHISq6JjD/GrCa1KRbCl2MikUocUyinCJobg
         evzTrGY0WeHI4qa3fjJUjSa+ZyF7lQEBNWWWXwH/SZA0ygzZeSbFpK3xIzg2tkeASELB
         tXrx65kwNa8n7uSmfPdNjENoGFfavJGjLxeRt6NGgphh+yN/xpDPzm75pq3SUOdnc/1b
         Dj7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791053269; x=1791658069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QGaMFZeGqzM6vFi3evbYOljRGS7ufnh+YVN/IZsJ2Gw=;
        b=aKGc7nlzhN0lyWMMSqLqzBz9rVYxqgRCEWBiYAmSCnHNk9+gyUc34ORJQL0QSRAHeJ
         iPGP4u5nwfqYezBSwtsmIUMnp9DyH1muORRVQKOZpo6iwZbhRj5xWmYOtn2HlPpn8sv5
         vJOyLhuhBIIz02tgJwBZqB/soOJPf9oH0qj8gFtK3c/OjnS2Oh9prTsd0xhIyCMpv7pr
         TzrBJWQxDOwuTiz/VXamDmiEokSElVNzOPxMC4GZYA1d6ECc8d4PNqS/i0ryf/YtIoMk
         lW/yuvEiohj1HVtTsnJU8tcGCkSsaU4YnMepGt33rqg/KZ/CTymLkykc8bKNIT/lK0j3
         YDvA==
X-Forwarded-Encrypted: i=1; AKwUvBxhf9P2qBK4pnkGkNm3c+gwwCwWfvZjdNrdW79EF9Fyw9gZJmXYVLlPEyPlU8igwDRCtlQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mN9gjsYjIT3kMEX6s1un8f0oY8uLvAAdzK3919NgJKijcJFZzu
	r1GQW+NQQ+jIpdGHdaIS2s7vaigtGVoeb/7QipUiZXrhzBVzq+O/WNwh
X-Gm-Gg: AYBFou2E0SQGybesNEYKYnRfNKmTex5cDG4KbyRP4mBxDbuQYGYae7NXJKOYzgKBpHU
	iCoNSmb7uLrcLEL6a8yhn782yh5GxNO00fIFjN+1a7lwCLq+tSHqQR5WV8I5AExOSy/fwmiTNhw
	WdCnUistjXIp/RU/b59BTgIHooliCPGdB5t7Y4PVIYRHNg53FQfYPvdubaXKLGSE19Ueb1F3/g4
	LcZ0AcjoJwvfvq+EMNpx9yBYiGw2H+u6XUg2NIikoHaRBsmfU/f3AwQMGDUG9jqvEGh77gnlQhp
	kffAh3bha7NNhwTNuJ5AtxfC4WoGFjKtXaoyEii8IZAtZWHeoozhkYuJ0pd+fod7l8vQPWH6SBS
	aBkn3wgTvf7jqm5rVQHOpD4rrB3Yz2+gjoijSmCivkZW2ehvuyecZ/loqrnN+V4WuB83+V1rSN2
	MWxmlkPm6cP8Qa6BK9PFqJcwtUva/lubz5+1MzdD971f8X8Kv/SXMi3nYrJ39urDmrmadDm1MX6
	EvAPpG6IXMww82I536N/fAGIFyEmJ0yhBtT5raCpNhtGLNwWZjT75l6vR6NwTxJuF+WY2Wy8Lt4
	IEWLxtMHtigKVFSSu4bxFXfU+Ph9KUXvVzYqbiB38osp7CsAif47mEd2pkTx
X-Received: by 2002:a17:907:7282:b0:c2d:fc0b:551c with SMTP id a640c23a62f3a-c2e4ad7caa6mr516508966b.16.1791053269172;
        Sat, 03 Oct 2026 11:47:49 -0700 (PDT)
Received: from localhost.localdomain ([37.31.50.113])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e4cd26a43sm219184166b.31.2026.10.03.11.47.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 03 Oct 2026 11:47:48 -0700 (PDT)
From: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
To: gitster@pobox.com
Cc: cdwhite3@pm.me,
	domen@cachix.org,
	git@vger.kernel.org,
	phillip.wood123@gmail.com,
	sunshine@sunshineco.com,
	ps@pks.im,
	avarab@gmail.com
Subject: Re: [PATCH v2 0/4] worktree: add lifecycle hooks
Date: Sat,  3 Oct 2026 20:47:25 +0200
Message-Id: <20261003184725.29917-1-maciej.ciemborowicz@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <xmqqtsp9tyu0.fsf@gitster.g>
References: <DKGE5DORETW5.1S9NXEX8KMQHH@pm.me> <xmqqtsp9tyu0.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Junio,

Thank you for the detailed explanation. I agree that a wrapper is the
right answer when the user controls the invocation of `git worktree`.

I tried that approach for a tool I am building: it creates an isolated
container environment for each worktree. This matters in particular for
projects with databases and migrations, where two agents working in
parallel must not share an environment.

The problem is that, in this case, the worktree is often created by the
IDE rather than by the user or the agent. For example, Codex in VS Code
creates worktrees itself when it starts parallel agent sessions. A
`git-wt` wrapper is therefore bypassed, and asking agents to use one does
not help: by the time an agent begins work, the worktree may already
exist and its environment needs to have been provisioned.

It is possible to approximate this with polling or instructions in an
AGENTS.md file, but neither provides a reliable lifecycle boundary.
There is a race between worktree creation and the agent beginning work,
and cleanup on removal has the same issue.

So I wanted to report a concrete case where wrappers do not reach the
actor that performs the operation. This has also been the most consistent
feedback I have heard from people using parallel AI agents: they do not
want to replace every worktree caller with a wrapper; they need a
repository-local way to react when Git creates, moves, or removes a
worktree.

Best regards,
Maciej Ciemborowicz
