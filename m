Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E992279346
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 07:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771916781; cv=pass; b=R5nxywUKhCzs9v6h7d5ZLKfHUDDKajlo/0cC8KhX+/8CFpondrWIX1TO/9u5rSO03S/VzoNnZe1OfwyNGsdrgijceuwcklZGMJDMtWUrAgNluu2zGedAB0IJDp4uxTc09krHZvZgdeyFi+WMI84T/IGBv/m+T/IbzCsf8iVC2KQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771916781; c=relaxed/simple;
	bh=CpcNgr74bZJi8Oaonw39gJ10fUBgnIlYgdaugZEPHXY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KmsLT0HxXB54K2qqkXu1DvBK6Q4Ah1L1lA2WA1IZ5ewZg24HPGCg8aNbGionm1mDePLnP2acoGphrrXYz6nOM3cFzl4Cr8UE3K1ZXJJJ+keqSBWfWnSi9+vgosI8wzdjidYpzS5PpN5W8j8pz5vmo24Nm0GbZa6AjrYY++CPLZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=gDhuZElh; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="gDhuZElh"
ARC-Seal: i=1; a=rsa-sha256; t=1771916766; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HSPPYk+P/BCbC9v8rM6AzS4ZqlB0DGQDD1d1/YaY01VPdfwoNzQmnzu6XMepQv47bVpkGGFu+pHYIRaztvgpmwa3jzbXBdfxCewBkZeVQei1CweCPee44tzyUdkUVqr6KKuPiO+oXu0KEIhXhCMGwKc/sfGNd46E4ujl6+/AVTg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771916766; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Tc/WPybBQBLvuuHpCisYic03LpFqSGxH42gS4s3vYKU=; 
	b=Vvt0paZb5GHkEYVRdPr2Bses85LtZIgh2JULlbRoTB2e6yx2jcqaj0kpb4fcBHatHhHvIM44sDc1R1hzQ9ie17JrM6ziUe+zPXQY7EyU6G6ywrQFHfQUR0dDx34xE7QH+MWkr4nifx2F1jTFE3cHCtD/CmUFunk3cSP26cJEeJw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771916766;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Tc/WPybBQBLvuuHpCisYic03LpFqSGxH42gS4s3vYKU=;
	b=gDhuZElhUvye5n2svHXtTzWVFhdpTluNLaY12YLQFHwZcpSwBjBjMP3W44l0u0Kf
	WU/+RPgt3VPsmjcSKEm6ppUtZaFKb/wUFE0MemggA7JeaaJwXfPGpRV6cpE5ky4Bvgc
	J3F2r+NF3bATeGHl5IRCHfwN+ol9Q3ckczKUyXrY=
Received: by mx.zohomail.com with SMTPS id 177191676482894.76425892880286;
	Mon, 23 Feb 2026 23:06:04 -0800 (PST)
From: Li Chen <me@linux.beauty>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v7 0/5] rebase: support --trailer
Date: Tue, 24 Feb 2026 15:05:46 +0800
Message-ID: <20260224070552.148591-1-me@linux.beauty>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Apologies for the long delay in sending v7.

v7 is based on origin/master at v2.53.0-154-g7c02d39fc2.

This series routes trailer insertion through an in-process path, removing the
fork/exec to builtin/interpret-trailers.

The first four commits refactor trailer rewriting in builtin/interpret-trailers
and trailer.c so callers can reuse a single in-process helper (used by git
interpret-trailers, git commit and git tag). The final commit adds git rebase
--trailer, currently supported with the merge backend only (rejecting apply-only
scenarios and validating input early).

v7:
Rebased onto origin/master at v2.53.0-154-g7c02d39fc2.
Split out a new patch to parse --trailer with OPT_STRVEC in git commit and git
tag.
Use strbuf_write() in interpret-trailers when emitting buffered output.
Restore --in-place rewriting semantics via tempfile+rename.
Drop wrapper.c/h and validate trailer args via validate_trailer_args().
Drop redundant rebase basic-state save/restore for --trailer arguments.

v6: squash all fix commits and split refactor step from the original patch
based on Phillip's suggestion and code [4].
v5: fix all Kristoffer's review comments from v4[3] in place and without new
patches.
v4: fix all reviewer comments in v3. [2], and add patch 1~8 & 10~29 to fix
review comments.
v3: merges the remaining trailer paths into one in-process helper, dropping the
duplicate code, as pointed by Junio and Phillip [1]
v2: fix issues pointed by Phillip
RFC link:
https://lore.kernel.org/git/196a5ac1393.f5b4db7d187309.2451613571977217927@linux.beauty/

Comments very very welcome!

[1]: https://lore.kernel.org/git/xmqq8qlzkukw.fsf@gitster.g/
[2]: https://lore.kernel.org/git/20250803150059.402017-1-me@linux.beauty/
[3]: https://lore.kernel.org/git/20251014122452.1851103-1-me@linux.beauty/
[4]: https://lore.kernel.org/git/7d12b046-365f-441c-af8e-8a39d61efbbd@gmail.com/

Li Chen (5):
  interpret-trailers: factor trailer rewriting
  trailer: move process_trailers to trailer.h
  trailer: append trailers without fork/exec
  commit, tag: parse --trailer with OPT_STRVEC
  rebase: support --trailer

 Documentation/git-rebase.adoc |   7 ++
 builtin/commit.c              |   3 +-
 builtin/interpret-trailers.c  |  47 ++-------
 builtin/rebase.c              |  18 ++++
 builtin/tag.c                 |   4 +-
 sequencer.c                   |  28 ++++++
 sequencer.h                   |   3 +
 t/meson.build                 |   1 +
 t/t3440-rebase-trailer.sh     | 147 ++++++++++++++++++++++++++++
 trailer.c                     | 179 ++++++++++++++++++++++++++++++++--
 trailer.h                     |  30 +++++-
 11 files changed, 414 insertions(+), 53 deletions(-)
 create mode 100755 t/t3440-rebase-trailer.sh

-- 
2.52.0
