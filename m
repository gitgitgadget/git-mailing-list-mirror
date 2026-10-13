Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0134E06FC
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 17:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912200; cv=none; b=ZZ+P4JBK9qKbjv05p2C8RHP6cMQhslVjTEnnEv4IfHx+RMFZNEebAKQp1j/+koI7theUKmHp3sRWt/AQwpUuhwibQAdEzKqXJrj3pClI+DBGkmJRHOzxK+skXpA9Hu7w3uBsRz06JE0ZDMghPz6+ZDPhOh1d+iUeGg6slLKbNJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912200; c=relaxed/simple;
	bh=bxTZrz5NgvOBLcG+ThvHilt/yNUWfZI9rOLy+t2/raA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=efwj4pbmE6vxX7SGrTuKonbpZVR21+vQ/yyHz1csFbeyomCAXnojeRjTWXFF2OMGUsR1yCsPGaNtEeg8X4uFGc7Jrt8z/7C3r28LwcchQzPg1KUG8NWepeli4aAzhlgMNwqHhsXiqkPTu6A8rZASEYaCD3zH70x2KrAHZgAMAjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=djn7pUGb; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djn7pUGb"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc4c02ddd62so47091a12.0
        for <git@vger.kernel.org>; Tue, 13 Oct 2026 10:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791912199; x=1792516999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wLWff/1hM/AJVzjuOigcwzyYVqhzU6FKCaXx6ZQSpok=;
        b=djn7pUGblYDOawBqRrv9/Uj7Q/RnPwrUAmil5gGKTsm+cBjIUiF8qxm9BRtL+5gCZI
         /H5aY2Z0EKWN/SQ81q9Al+tQaNFSsT2qKsF7PFbNDiw6WhrB9XpSYNnpIcUjnWNA1j2S
         hRtBCLD0RbEv79RAd8XIrxphn0mdEYzHEb6UKhejaLN5oHnvXYqaWs1PBiLvySEj9Hms
         uJAUcL27hFYfQarW28BmP0aR3K49+uwYCZVCFe5gx2NQmvCFGXHaGnXECzOFfEnzrkc+
         /MIzKPaRAwuaJpFAOAbgP7BwqdoDG6nU6wGXipfT3HOddpLZGw5AsJE4ipGJbUsOXDD5
         eDgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791912199; x=1792516999;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wLWff/1hM/AJVzjuOigcwzyYVqhzU6FKCaXx6ZQSpok=;
        b=Z3tcRmYG7LwaVJUwPot4JErm1H5U+Q8cetB5RoMoqouakdT0aJWKLwrxI3gyDrTyrJ
         3KDwtaj2d3a5nDYvN5eM5D3U/GiYWf7nLJG11KKlAPi4BIDLgABmV/JoRpWckypoxvRn
         ZoTBefRL/b31yNOryIPBHCYWeH+eU6dJugyHnLgrfxNsms28Fb9A3QSJOmSI+ri5rG7m
         AygVdD5P5Szw1hI32TRZ3J39qS3i+EwA/UFSgw3ChbafU/LolxOVLkd47Y0Sr1cKe/pd
         r9MU2rxSfGfD5abXB830NVWOGIEob3XWlYmHTlVgIbGQKXQLtYUkYttlZaYHLwcLbq8S
         9dUQ==
X-Gm-Message-State: AFq9FYKtMzREFVF9WjSj8qRfaZ/gPu77gP0FdRw6srVLmNMmZowixPmM
	koOVtzL31hoJY3D1tLdXWI/chgFG7p/rs+LBmYqyUB+0NJumK0tTB2nYYcd4fw==
X-Gm-Gg: AYBFou0n8aOKWzSfp62LUBLsLfbO6WZKHQkVjG0Dj73jcPQ8KprCgodEbRDXVDjfJig
	e2onIWf+k/Hl+2SB2czsjPjNbEUxVjvAaO9CfJVXRdhyhOf63OF91r5maTo4HnRLTCJuqFVsQ8L
	DwYXrjCyzgxFrpvcK40j465NISD94McJF05yKbLbeEcPWqbLzsz5GQvfFqnx/l28BVl3bCWu0bE
	KieEf18LebY2Hr5GUfO/q5eM3dYvQgpcZaLtyxBZbOtcMZAjXuzVuSmT2xIpdV4vEuIsP72I3OT
	zCTB0Hn5i/g7c+ZWqNyznVOhjZWzbHKPVqz3asr+7l1jszxZYiI17PMUa1HDNGDOd2wARcvTAqm
	wzHbV8hhwBO0NfSnGVMQdIIcZJSX6kaPiAMmVQ6i4bFCq8dCqWb1A5RjsBs84X3qXXOw8Is2wcP
	Pa2Jwrr317yWwkgPQcRMYDEbpNvgBLOpK45EiJYVhTfGZElmGambaf9KefWqx5uovq1vnKNiocT
	vuTWTjNRE7iNa1rc/0xYleYZTEDSg==
X-Received: by 2002:a17:90a:e70c:b0:3ab:2d17:51d6 with SMTP id 98e67ed59e1d1-3ab3a32cc0amr10260876a91.2.1791912198659;
        Tue, 13 Oct 2026 10:23:18 -0700 (PDT)
Received: from quark-fedora-PF5F60VQ.thefacebook.com ([2620:10d:c090:500::4:4699])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac5f2026efsm631690a91.4.2026.10.13.10.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 10:23:18 -0700 (PDT)
From: Jun Wu <quark.zju@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	peff@peff.net,
	ps@pks.im,
	Jun Wu <quark@meta.com>
Subject: [PATCH 0/2] Add a way to wait for index lock
Date: Tue, 13 Oct 2026 10:23:13 -0700
Message-ID: <20261013172315.2997446-1-quark.zju@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jun Wu <quark@meta.com>

An IDE that runs `git status` periodically in the background has 2
choices. Both are suboptimal:
- with `--no-optional-locks`: `status` becomes slower over time.
- without `--no-optional-locks`: conflicts with other commands like
  `add`, `commit`, often run by a user from the IDE terminal.

Patch 1 adds index lock timeout so `add` can wait instead of fail.
Patch 2 adjusts the read/lock order so `commit` can also wait.

To minimize write race, if the index is read before locking, the
wait will be skipped, as if timeout is 0. Depending on the read/lock
order, some commands (e.g. add, rm, mv, checkout, restore, read-tree,
apply, update-index) respect the timeout. Some (e.g. reset, stash,
merge, rebase, cherry-pick, am) do not. I started with the simple and
common commands. If there is interest in other commands I can take a
look too.

The default timeout is 1s (reasoning in patch 1). I'm happy to change it
to 0 if people prefer no behavior change.

Related context:
- (2017-9-22) https://lore.kernel.org/git/20170923033425.6ilykxl5pi7unlj6@sigill.intra.peff.net/
  proposed index lock timeout.
- (2017-9-27) Commit 27344d6a6c (git: add --no-optional-locks option, 2017-09-27)
  introduces `--no-optional-locks` for the same issue.
- (2019-5-3) https://lore.kernel.org/git/CACsJy8BcBk6Fsfy7o1aBTQAPeH-w+rBwLZrzw4jJ-OM_jhkxMQ@mail.gmail.com/
  mentioned `update_if_able` and "gap" between read and lock, mitigated
  in patch 1 with the `index->initialized` check.

Jun Wu (2):
  repository: add core.indexLockTimeout
  commit: lock index before reading

 Documentation/config/core.adoc |  6 ++++++
 builtin/commit.c               |  9 ++-------
 repository.c                   | 17 +++++++++++++++-
 t/meson.build                  |  1 +
 t/t0031-lockfile-pid.sh        |  4 ++++
 t/t0032-index-lock-timeout.sh  | 37 ++++++++++++++++++++++++++++++++++
 t/t7400-submodule-basic.sh     |  1 +
 7 files changed, 67 insertions(+), 8 deletions(-)
 create mode 100755 t/t0032-index-lock-timeout.sh


base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
-- 
2.56.0

