Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A4728AB0B
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 08:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784191799; cv=none; b=tb91WjGBABOJtIWJqJ2OYQcpYH2KFoJl5krFqqVmdUc4RvdDX+bIpkODRYy8LTh8pDTjUyyVjzaRYUR8CLBf2ix377IABU1Ihi8/5A4O5KS52MRAgqOkFp2hk8VOaa8ZJaTFAOp84NNB7t6nCf1NFsLO2/VZa+dPLmlpfL3lG6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784191799; c=relaxed/simple;
	bh=962E3wlfFhbjl8vjYI/4YGr7sYiSpjcTwXeprFq42S0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GzoWi1ByLVxoFWMc5cd0ZvY5zgTgBhV/VMr9V/TD8XqxS74l67kuaTXzO3X8vCCMpQ+0zG7HGc2vWQwt+Cwv+X/Op091M3CuSNnrDjZTFZl8rEwoa1vSWdbIwO/fC3Zi7mcoeM0v8V+FhODT8QoqcGDZLJorBmw4ouL0e8pz+1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=m05oybLb; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=naxF30Or; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="m05oybLb";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="naxF30Or"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=m05oybLbMsr7lG+s5B1i9ljiOGVA5ndQGyIv6Y587w8XHv95W2AAWA8zSzJ/ONIo+hXJHZqnhvTtY7LY2fD9pRDXWCFJ89sG1Q75hWXEV7oFlCHGVFGbGMAD5Kw9FqwQ0jZMtJjDh/XCBW571UpjqQ5kZQS1LLNyCRHlb9aYLJlkc1qZMs2TemThqCyDk3o6pjSNqwRUiv5gT6XiEZ2Fsb7YhdwBBibzo6WDMiCN6fFe6DB628xW3MKoXwa2sDzHUoMb9zX6AI6Cwd8keG0I050mckKTfNpkQn2+EqhiNmc2KISaX8K6Dv4f0yvcLWXckS4q029BENrnDecInBdPKw==; s=purelymail2; d=malon.dev; v=1; bh=962E3wlfFhbjl8vjYI/4YGr7sYiSpjcTwXeprFq42S0=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=naxF30OrE763WXY8bgZOwC8ab0t37Xw9dpmW9QBzdElnORIRrZouDKtK01sIl+48wTITDxtjMzRYKE/xlgHHFmWpyCmMIJrBKH68dckPBl887XhvcnvlnYzrCJ/fjjbWL0wLJitFufvAtVri2pA3SfVVjGRauKkOhBfuA6nw4tSKqffcVJTT6yTkBEghoFy4aZJBOYWULAqJ8Nd3MDxocrJnWem4wCQUlnwNajHDV5udxQjruQ/rroiGzxN1t1M/1QNDJPs9l/5Tmm37+AyepxKUZlmgUmWL6BbqOLzhrlPlPIiGHdt94pAK9kDGbI3coYDK89vb6BFEx+Da0mmJ7g==; s=purelymail2; d=purelymail.com; v=1; bh=962E3wlfFhbjl8vjYI/4YGr7sYiSpjcTwXeprFq42S0=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -873613066;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 16 Jul 2026 08:49:51 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Tian Yuchen <cat@malon.dev>
Subject: [PATCH v6 0/4] environment: migrate 'trust_executable_bit' and 'has_symlinks' into 'repo_config_values'
Date: Thu, 16 Jul 2026 16:49:37 +0800
Message-ID: <20260716084941.1101918-1-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715035501.48271-1-cat@malon.dev>
References: <20260715035501.48271-1-cat@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

This series moves 'trust_executable_bit' and 'has_symlinks' into
'struct repo_config_values' to tie them to the specific repository
instance they were read from. Eager parsing is maintained because
these two flags are heavily consulted in hot paths.

Note: 'repo_config_values()' still does not support any struct
repository other than the_repository due to how deeply these flags
are accessed. In other words, this series of patches is laying
the groundwork for the eventual elimination of the_repository.

Previous related work:

[PATCH 2/6] config: add trust_executable_bit to global config [1]
[PATCH] Refactor 'trust_executable_bit' to repository-scoped setting [2]
(This previous attempt was unsuccessful because the target location
selected was 'struct repo_settings', which our analysis indicated
was not the optimal choice. For further details, please see: [3])

[PATCH 5/6] config: move has_symlinks [4]

RFC:

 - Is the locations of the newly introduced definitions/macros
 appropriate?

Change since V5:

 - do not intruduce new global variable to deal with compat/mingw.c.
 Make use of macro preprocessing to allow platforms to override
 platform_has_symlinks().

Thanks!

[1] https://lore.kernel.org/git/837b5360b40f992351f489a0ae05fedf49884c6e.16=
85716420.git.gitgitgadget@gmail.com/
[2] https://lore.kernel.org/git/20260301190017.53539-1-dronarajgyawali@gmai=
l.com/
[3] https://lore.kernel.org/git/xmqq1pht6nyx.fsf@gitster.g/
[4] https://lore.kernel.org/git/a154008619790f7a60f2bba91db7b0fe29e67e1a.16=
85716420.git.gitgitgadget@gmail.com/
[5] https://lore.kernel.org/git/xmqq7bokebct.fsf@gitster.g/

Tian Yuchen (4):
  read-cache: remove redundant extern declarations
  read-cache: move 'ce_mode_from_stat()' to 'read-cache.c'
  environment: move trust_executable_bit into repo_config_values
  environment: move has_symlinks into repo_config_values

 apply.c           |  4 ++--
 combine-diff.c    |  2 +-
 compat/mingw.c    | 17 +++++++++++++----
 compat/mingw.h    |  3 +++
 entry.c           |  2 +-
 environment.c     | 27 +++++++++++++++++++++++----
 environment.h     |  8 ++++++--
 git-compat-util.h |  4 ++++
 read-cache.c      | 33 ++++++++++++++++++++++++++-------
 read-cache.h      | 16 ++--------------
 10 files changed, 81 insertions(+), 35 deletions(-)

--=20
2.43.0

