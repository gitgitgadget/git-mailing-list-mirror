Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CC94908D1
	for <git@vger.kernel.org>; Sat, 25 Jul 2026 11:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784980480; cv=none; b=bB+Zhlz7BW7OB/8NC7Y0l4QBprFda4LsfggSfWmQj8piaWygjly5tdNU3+lVb8dEmY0PENXFZRJgYzKyyJAEqCrk2djCmezZX8rfx6b4z/BRx5zHVXGaPkiEysXrJ9knvZYQtAT4KYkk3fDuKPmd4/G1IAmds0bnOTL7gl0C3v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784980480; c=relaxed/simple;
	bh=84T1iqXCnLVjq5Biaqekzo/LdjhR4eXnboju2yXXNT8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GyLeaszRrejvI27GA34lP3DQSGeorM5nFEqNnzCIZHlvuxcRqajRwoPLFEwRoKR+VfsjrgxSjVj/l58g6JzfVe6dUMUDtf3VhCzJKJ71jNqzPGZQjRWkTlgg0RkNlIUi26H2Tq3pV6q2+P/jskcvwUJzPiiqx0zf8LCMp0j6VnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=G/1jB7Ne; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=F6cXPesN; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="G/1jB7Ne";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="F6cXPesN"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=G/1jB7NeNaYXADUyXcKHxnYPsTlI5UkBvJaP3JKbzroKRZSnAqWus5lVB4zpOOQtHePJcgeRYbXh1Ya0hS7Eh7r2jQg4FUKXk1/7foNBgAPSL5/Lvwmnpo9oOVA7FCTFOWsIEdkJHWlD1GZLgo93ZgQLuiUAsZV2bS297HQXW415CSpQtqsBKz+KLM6n0WWg5EauXk716AqkKXRTScZwvP2Ox5DDh63r/hmDJdoh1ZHBQoMcZdpHxaVfWaDWfWj/vtS1qXTqrpfZmc8SojS2U9PBvR8fFLSEgrPc0x0nZSGTq4PNj758fAp9PY8f4OTYkGnL6KZwnDpvSQeqodbZFA==; s=purelymail3; d=malon.dev; v=1; bh=84T1iqXCnLVjq5Biaqekzo/LdjhR4eXnboju2yXXNT8=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=F6cXPesNM1ZXSW9GDamKZUzBi43af+4fjz+shWHUqWXCvxNwUq2SqwdZmfnuFsKe76MwWR87ucgMDT3aF3t7k0x5ZBkjmFRtgXjuVyZPyJyu2T68fDQbgQp5f/YRphcm3xwnmjwUe2ghPMLadykwnXWfbf4PXTmFmOEuqgX5GMDC+lI+uY/RIh+2IpqEuLIro+F4JasXKCmMN/AADa6hSep5edIiPwq71XqV0d8f6aSjIX42QSGqL7Qd/mLWjXh79qD6QdjQdHtzZB0DrvQgD7014IbjCsutcarc+LGEIpvlw0OXf979lHOisR/ersnJFI938oKHik5rv+O5DYgylw==; s=purelymail3; d=purelymail.com; v=1; bh=84T1iqXCnLVjq5Biaqekzo/LdjhR4eXnboju2yXXNT8=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 891366051;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 25 Jul 2026 11:54:35 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: ps@pks.im,
	newren@gmail.com,
	Tian Yuchen <cat@malon.dev>
Subject: [PATCH v1 0/3] environment: migrate more global variables, pt.2
Date: Sat, 25 Jul 2026 19:54:25 +0800
Message-ID: <20260725115428.2214202-1-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

Hi all,

This series moves:

 - (1/3) minimum_abbrev and default_abbrev=20
 - (2/3) pack_size_limit_cfg
 - (3/3) assume_unchanged

into repo_config_values to continue the libification effort.=20

Note: in commit 1/3, we need (repo !=3D the_repository) checks in the
getters, because some subsystems where the readers of _abbrev
configurations live forbid the use of 'the_repository' and only accept
'repo' [1]. We have to explicitly intercept those intances that are
not 'the_repository'.

Thanks! yuchen

 [1] [PATCH v3 5/6] merge-ort: prevent the_repository from coming back
 https://lore.kernel.org/git/42a25768784492a4e8187bad0b070ccb27e980f7.17717=
18393.git.gitgitgadget@gmail.com/

Tian Yuchen (3):
  environment: migrate minimum_abbrev and default_abbrev
  environment: migrate pack_size_limit_cfg into repo_config_values
  environment: migrate assume_unchanged into repo_config_values

 builtin/pack-objects.c |  2 +-
 builtin/update-index.c |  3 ++-
 environment.c          | 39 ++++++++++++++++++++++++++++++---------
 environment.h          | 11 ++++++++---
 merge-ort.c            |  7 ++++---
 object-file.c          |  5 +++--
 object-name.h          |  4 ++--
 read-cache.c           |  9 ++++++---
 replay.c               |  2 +-
 sequencer.c            |  5 +++--
 10 files changed, 60 insertions(+), 27 deletions(-)

--=20
2.43.0

