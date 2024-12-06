Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00D61DDE9
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 03:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733456786; cv=none; b=AGcYyYsvYLLDYskZ1T0DO+Ffr+KB2dllPcfkw1xW0AozZKedmw8zY1H1dq0MGHHwaM+sNs2LKN6TYkJx5HvVJowYw0uecC4Obk6p7G8i2ZR3FtFD3lQVFAZaGITYn3gw6+hytsqYMR0cfiOcWZ8Z4lqxymGdmbCs6aZ0WB8dZm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733456786; c=relaxed/simple;
	bh=Xfi9T2HGV8nGBQqsRA7GyCleKeRcTD7Vp+8q8iLWaoA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=kLKb1jk03VaveN7hLnzFfo32U+g3VxfPcAAw4G45lRA9gjPG56enUocDeRwVXfERxNZKDtTKPGWIuhykCfGvl49Z3140efDLHSEDs1H1iGkBeSpJ58FFtrE1lPn5lCt6dzloABRM14pacY+Ydf4H7qObX35w6+Ntyvquz6SzXl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=atlassian.com; spf=pass smtp.mailfrom=atlassian.com; dkim=pass (2048-bit key) header.d=atlassian.com header.i=@atlassian.com header.b=qiu0BG3y; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=atlassian.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atlassian.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atlassian.com header.i=@atlassian.com header.b="qiu0BG3y"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa63584e157so10098766b.1
        for <git@vger.kernel.org>; Thu, 05 Dec 2024 19:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian.com; s=google; t=1733456782; x=1734061582; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xfi9T2HGV8nGBQqsRA7GyCleKeRcTD7Vp+8q8iLWaoA=;
        b=qiu0BG3yDCUTip/sDGSaUutjdxpjg9UFvmgYy+/Rihe/QsOOxw05PbweCa5a1gM+FG
         EuIwUnvsD7lF4hq9u8CE819BIF2dyyTTk6oUc1RbdhGNsNkbfshGCZWGvV4xk1F8n1CO
         mEe1kDN4ylPGdfZwgWFwXCnwwygxC0Q1V6n+rkwKCNbo03H00G/zsVCEDLdQ0TB+phqS
         slXkwvTOPgTgbGsfYSjczF0hfQVP5LbsZIjRky5n8MLyi/0gAqwiZsWNK364dX1vuCs5
         G01OeZnJt0qwbrLJWCfzVWqfAsjyrbNl8bcB1FAFMxCh4+z7h83Q1gBko9Nt1MHNO0Kz
         SeZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733456782; x=1734061582;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xfi9T2HGV8nGBQqsRA7GyCleKeRcTD7Vp+8q8iLWaoA=;
        b=PG0CQTbhHUkr9hpCKSPbW5GOnn92Heu2le1T/sjXjMjLZsr6ERc+SJNGVf0D/0bA+D
         hxUgqCyrWUKePBFtwyW2iugLWaWUQiWp5+Z1lI355ryWGww7dJqrTSMFQCRcqVsr8WXW
         70+WAI01bkQ5tu/QxHbEZYZxelBgT8Wf3wJedyveKSx/rvtp4iFyqV3pp7nIdydaxSXP
         68UUfFCfB6JebiWNZrH5KVUb3wHDWSB5N3I7+3ae1T2K4y6E43A0SBBKpxT3zXofnd6T
         nE29+08CCxm+vqPJYwcKqzhj66Nr5B6k1nojgOz4+ITHW89urGNwvXPSM4R1IL8EhbGX
         t5xg==
X-Gm-Message-State: AOJu0YzJR9pTJhxR59P4W0bpGg8gswgu3rvbpcYQnKiVD6RSTdVjKSuo
	1LkAEc7jI+qOcY2NvcVZfqchLcsWX2fS33jeuWrhJTBk2Bz8eyN/DzZ6rhWN5U4h0CPgd+SZRDg
	cw//JNdsbz3lYf4dosm7MIazaPmJU/8QUD+JcfhdlBSeB58htC0P6gIM=
X-Gm-Gg: ASbGncuX0eTJaovHiUG5IG8S6Y6qTwEoZXMBhSyLvuJdD1Ehk5rkL5IZhv502mf5zqp
	fWr/Q7ax6+HoeCIXd3Ob0c+nelRVHw2JD27Fl
X-Google-Smtp-Source: AGHT+IHkMTylds/XR2RYWjnLb43QuPAxC77eBGhyDbS47GLgdjm6rau+QZSdYWEgyM5LdSvUcJaMl7UqgNhFGw0C088=
X-Received: by 2002:a17:907:c48a:b0:aa5:5055:50d3 with SMTP id
 a640c23a62f3a-aa63a2fb28cmr47552866b.14.1733456782345; Thu, 05 Dec 2024
 19:46:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Manoraj K <mkenchugonde@atlassian.com>
Date: Fri, 6 Dec 2024 09:16:10 +0530
Message-ID: <CACfnds=++C75pg8ojn5sJzjKzLcgnyPxgR2c6pOPCRmf2rDKvQ@mail.gmail.com>
Subject: git add -p is slow for sparse checkout
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi team,

I am currently on a sparse checkout repository, and it looks like the
`git add=E2=80=94p` command is much slower than in a full checkout reposito=
ry.

When run, the `git add=E2=80=94p` command expands to the full index and tak=
es
more time to start showing the patch.

Also, we have git trace2 enabled, and the timings of the subcommands
gave us an indication that the `git apply=E2=80=94-cached` subcommand is
taking way too long, with an average P50 of 3000ms against 300ms in
the full checkout repository. The other notable spikes are in `git
diff-files --color` (180ms vs 80ms) and `git diff-files --no-color`
(180ms vs 80ms).

I am really interested in understanding why `git add -p` expands to a
full index, which I believe is the issue with start-up regression.
Also, would be great to understand the difference in performance of
the subcommands.
