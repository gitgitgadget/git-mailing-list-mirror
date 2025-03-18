Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AFB1DED62
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 23:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742340269; cv=none; b=ICAFiycsuTDWLPaal1qyPFzN5twShJwZis06z56NZlHoow1TUPdm1YldGiTrPXBAoO2onlhiLNwPatR6CDWcs/VPKwsUnGspPmYNbK3zbrI1BfjdfWQExpueyww1uBjl1CqICLj5Yqt7NJqm/2C7K+1JafEVm0pTKENZryp4sAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742340269; c=relaxed/simple;
	bh=9lP6zMBVSnpIs7XGOuDDmT+cM1Y+iOSbjhMTH59+Rp4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mgd+e7fqWXOVs3KWZzMabhA5D2E2Gc62oBT4KRpkn3kgZS36qV/WRE10EksedyM8RrX44TXLb2MGejja7bv9xYdgfL0qjVmz65feBTtbKAB6/rLrWs/+TPPx6I9s4FHRMzBL9FnDoPYmGZX+4qzcup0xrjaIFNbsAK1KLu1yqC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wmaHN7Lq; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wmaHN7Lq"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fec3e38c2dso10051251a91.2
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 16:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742340265; x=1742945065; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GqZOfxNtTXmv/L/q/yHNBA2/0IDDMHQUd1QnXow44K0=;
        b=wmaHN7Lq+ydeAv6h33ZUQZi5mtsJ4AbxL6Mcqxlf6SXZO3fSLgQNAvKkEUnYtjCTRA
         KAPTVrTFejw8GJ/jsWSLDx6auUYVp8mxb4bg6VOiip8o4DCFF/oEBYfOFm7G4pWiH7Pr
         LWwSQCh9L8Qq+zUR3FKHzJAa+WsAywtF2f7Qpd3XSjiM3d3PrmgRYD4Ob+/i5IHVJjEm
         ltvIdee7pTxa486RJWftTMdK+S/sbrlN0K34YX/363jIVLlQVCpZbeTknj+Qz+fkt2YR
         VYgG+RTX180oO98ifZEPsvc69YT2AY3Ym6BLAke/zY9M7vY3j8L66xwOk7bWMe081b9Y
         1oWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742340265; x=1742945065;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GqZOfxNtTXmv/L/q/yHNBA2/0IDDMHQUd1QnXow44K0=;
        b=ggPLORaoFZj/QAU+zkcfckXM+g0C70TVmXZX0vWG23cDlDInOspr/gNx/gVkujhM0A
         vWRca1ARqoj7+hXCxva90aVeCWD7M2xSK9OhMkFGaRvjJyR3Jqr/gkVYyzu1gyv4Fjqa
         ewB0ntnfCzeQ3gqfgHgGvj0dEmd99QEAW82+bKlLAEhgmMYBAUWTABkorbABW7FW3Gob
         sJJ2RWa1P35Dh6+4j3HJ0KInpJKBEBI4hV9y9/w+tiFqZNMgaa3frizIn6uxZ/D1YBMB
         7Gwp4k3Is+o3jVYSeNodmG0wcsPXakq75OADzHX+G+Ja0c4l3KzFjlyDsDVKPKk8lIG/
         imPg==
X-Gm-Message-State: AOJu0YyTQbvdSQJr1NQGaDgYJJhYoMBgtDBy5TN4iMB29ydaWvP5SfS1
	tFk1vorK2TWQf8v4Q+Sm8CEUcaZuH2ZVJuaDh+HOutZ7VUIiDQy3tpOiM8Vff3tu+73O3Rn4EFK
	zx8hAO9gcW1UjvLWE6dAk0JKYf0JZZMOybu9geyR1dbrhCAMlz1xGkfM1dQsMWRsC+TPAxw38qg
	lUTfMCv1zzMp49Tjn4vF/na9S+OmNrqQO+ynZz7yw=
X-Google-Smtp-Source: AGHT+IEc+AA1FJ7tCmruVQeFzGF9a+ykKhXQYD/5+5NnvCiEuPbk7jqhK3gcSDePgEsc34NGD/6bdBLUHPI5Ow==
X-Received: from pgv19.prod.google.com ([2002:a63:1553:0:b0:af5:de08:d3a9])
 (user=steadmon job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:e8c:b0:1f5:9024:3254 with SMTP id adf61e73a8af0-1fbeb3a76e6mr873619637.6.1742340264613;
 Tue, 18 Mar 2025 16:24:24 -0700 (PDT)
Date: Tue, 18 Mar 2025 16:24:18 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <cover.1742339107.git.josh@steadmon.net>
Subject: [RFC PATCH v1 0/4] Fix `cargo package` for libgit-sys
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"

Fix a variety of issues with `cargo package` for the libgit-sys crate.
Most of these are straightforward, but patch #2 carries an unfortunate
side-effect that building the libgit-sys crate requires cleaning the Git
worktree in the process. Please see the patch description there for
discussion of possible alternatives, and please suggest any other ideas
you might have for that issue.

`cargo package` for the libgit-rs crate is still broken for now, because
it will require publishing the the libgit-sys crate first.

Josh Steadmon (4):
  libgitpub: move to separate contrib/ directory
  libgit-sys: add symlink to git repo root and clean after build
  libgit-sys: parallelize build with Cargo's jobserver
  libgit-sys: exclude unnecessary directories in git-src

 Makefile                                      | 36 ++++++++++++++-----
 contrib/libgit-sys/Cargo.toml                 | 12 +++++++
 contrib/libgit-sys/build.rs                   | 34 ++++++++++++++++--
 contrib/libgit-sys/git-src                    |  1 +
 .../public_symbol_export.c                    |  2 +-
 .../public_symbol_export.h                    |  0
 6 files changed, 72 insertions(+), 13 deletions(-)
 create mode 120000 contrib/libgit-sys/git-src
 rename contrib/{libgit-sys => libgitpub}/public_symbol_export.c (96%)
 rename contrib/{libgit-sys => libgitpub}/public_symbol_export.h (100%)


base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
-- 
2.49.0.rc1.451.g8f38331e32-goog

