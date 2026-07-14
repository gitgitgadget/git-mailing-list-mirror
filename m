Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7344417BEA
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 18:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784052010; cv=none; b=boHg8mdUcnTDgmzsJotYG8Qk1t3seQQjdPcJpKHY3SG+i/8M7kDAcWeZ4HZwqqJwnMv3SZ8w1HGF7YoMoekMw/tBh8vy1LSbTffweCG/uNdgUaqSPUo6My1XpGyBI7rSDcvlB0ga4x6kBz0h/BrQo4SwD7vriLmxkgGiMK52jOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784052010; c=relaxed/simple;
	bh=b2gDV2blzGIZl+bmM6ASbf/QtHfdPBvd3s0uct652/Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ljqYIXbAhnWE9DZh+1Rf7o5qstQcLQP1tV8gGH4Das77jszhjSJlaqwXxEdj+nodR7envgzk/jGTmafMBsdlsmeEgsq6owT5rYM3/blwj9hqjvIvtnrVqihei0RnYNFF+txN8Bt+6IA5JqEoEm4fLxw5NO2Q4kYgnLIyTdkK6Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=Hmuzbqph; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="Hmuzbqph"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1784052007; x=1784656807; i=l.s.r@web.de;
	bh=0khhsoUtZZBJ0cX3vkJdYZukxx0sFFTUefHKaZ+x4Oo=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Hmuzbqphpe+x7M4spWsPN2Ukwmpc0n4BZrweVFqAfmIzNSa7NDPlCsfV7UEGM2fC
	 zOXUlvnJJNTXdgZIgmHqRYmDfhkEYu7K4IuHiZfEDbXu2j0J7mvekX+WH2bPianGN
	 nrg2RNzMIlUxIEeUAy+6QarpjCFs6VFZOS8rpLnc5ObztcHS0DQgePBXUi2nwgyXs
	 01enkmzGDxQTkgpsfno5sTevjcLgANURG2MVT+1VdkYELEOFB8b6OmCu1hEmLJ6AF
	 WuMbmnzXgEJhPjhndwC7KQzH0zkqd6X608XOrWjSU25zPQucPTE8fW6mXfJ8voVbX
	 YG6kLXgZPpgO1GhpMw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MiMEW-1xCyVE3Kp4-00eMuA for
 <git@vger.kernel.org>; Tue, 14 Jul 2026 20:00:06 +0200
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH 0/5] tempfile: stop using the_repository
Date: Tue, 14 Jul 2026 19:59:51 +0200
Message-ID: <20260714175956.54601-1-l.s.r@web.de>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PUahFvwF7FyOjt4yMqkw11c8Nuk9mUeovzYvvYytHphyQ680gty
 qea8NtvY8oepGyXSMIPT7pa23cQylv7prIWsn4IRpDe/2egyFyUOhxosdD53X59aEHU88v+
 46ri4JCL//pIBVSKnoD/0KIr3gd455BFCz/jlrX8sH61FSfI4xUlpAsU7SpqvUQ8Fa/KKKM
 JQM1YMrDyawOFanLTqIrQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:A2QpUjJMn3Y=;Xvda2H/0+8e8Cej/Q0Q/Fqv8k/i
 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

create_tempfile_mode() and create_tempfile() use the_repository
internally to call adjust_shared_perm().  Expose that dependency and
push it out to their callers.

Patch 5 is a bonus; it converts lockfile users that already work with
other repositories.

  tempfile: add repo_create_tempfile{,_mode}()
  refs/packed: use repo_create_tempfile()
  lockfile: add repo_hold_lock_file_for_update{,_timeout}{,_mode}()
  tempfile: stop using the_repository
  use repo_hold_lock_file_for_update{,_mode,_timeout}() with custom repos

 apply.c                   | 10 ++++++----
 builtin/difftool.c        |  2 +-
 builtin/gc.c              |  2 +-
 builtin/history.c         |  2 +-
 builtin/sparse-checkout.c |  3 ++-
 bundle.c                  |  4 ++--
 commit-graph.c            |  9 +++++----
 config.c                  |  4 ++--
 lockfile.c                | 30 ++++++++++++++++++++++--------
 lockfile.h                | 31 +++++++++++++++++++++++++++++++
 loose.c                   |  6 ++++--
 midx-write.c              |  7 ++++---
 odb/source-files.c        |  3 ++-
 refs/files-backend.c      | 10 ++++++----
 refs/packed-backend.c     |  9 ++++-----
 refs/packed-backend.h     |  2 +-
 repack-midx.c             |  3 ++-
 repository.c              |  2 +-
 rerere.c                  |  6 +++---
 tempfile.c                |  7 +++----
 tempfile.h                | 10 +++++++---
 21 files changed, 110 insertions(+), 52 deletions(-)

=2D-=20
2.55.0

