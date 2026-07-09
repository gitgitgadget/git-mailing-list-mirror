Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC6737E2ED
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 16:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783613522; cv=none; b=jWpz8QgfKxcONsC1dlvoOZ9q0/C5Sgxja7FXWr7X6j/JKIVZUKAr/B1dckB0RLsyBhQXScmycPxVmlbYA9H5H6VgGGCbGxbJ0PItWDUFaz9bw1h4EyEXd22ilMUJ366sI0uR/pFQsIOwdb5W3/ew0PzGgH8f/EfAx6ZzJURAa+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783613522; c=relaxed/simple;
	bh=xpdX2hCnD4Z9SOX1PA/0VdIkPMU7sNG5yhPEbxlAQsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J5VC098Y5dFa5vFgFfdG9TJBD5S6hcrzeZ3vLEhkcV/hl86a0XaagfLhYU/FVGjQ3zKEe0LZl9BDXvW3zPumPaoA5KZgp+GfPwwl3wyxXTPaOEwUa+ZABKhmpUBI9Suck5d6SQm+RrCOZGXIa2pwcn1+Iij6BckWAMsFHWVgk+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=ed2gxxX4; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=ODWrdnM5; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="ed2gxxX4";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="ODWrdnM5"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=ed2gxxX4qRi0F0olVZ3NqdHvfA5Eq5CBNOh4h8Y4AWoxtRX+6v/bq+q2C+LU0mpfvwYXrg7wIrSEnCBWgtaCSzlKR0FsoOGeTdmTJmGhbf7Vf+ArhAhEGwARJw7gCqLztuquhOt7LinjawmOiP6wHMRtqmbMywMdcGJ50QnsbjeqH3+FFF3VprRNUVvDPXgRB8+VX+QhTjJG2tJ5811AzTrXyT6TXbRvRQWQS8g3TF5u43Jh8g/wqN4WhYZZirF9UotB+tSms2+BTYyiBHSHepYDuWYtIQ+MYHTVrPnw9fl5EG5Rt866MW5+9j1P4qp4pBB/DNsIa2/tLg2SwHbT/w==; s=purelymail1; d=malon.dev; v=1; bh=xpdX2hCnD4Z9SOX1PA/0VdIkPMU7sNG5yhPEbxlAQsM=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=ODWrdnM5Gwn9iAW6dd4OtCLWJQDP7KFSRWQ7zzZPUHcy4vMy45ki8ZRPtfHEMCaIbAuTYxqJBnZXaqGFoARuNlgerqxk/WRyA3Zk811XY2K6wor+3R0oG+7ftX/U1A0dwh5CnFlwLwbwLW+i1CF2lr5tGELtpULiVqPbU8KVz2+HZJpbg6aYa0XSAjQ23vHawivLiQEp8ev+riBj6uRayjTZxoFGUcKduxj1OTv1wqOQDYVmmD3gf9O4NT4+GRJj/odu4O6Lv42dDZ3F0sIi9VARELml/d0vnSNUVj6J372t/YVacVf2EWt0+Bf3K0qoW0RVScrSu/skFEQ7lk7nnw==; s=purelymail1; d=purelymail.com; v=1; bh=xpdX2hCnD4Z9SOX1PA/0VdIkPMU7sNG5yhPEbxlAQsM=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 872182701;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 09 Jul 2026 16:11:58 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: cirnovskyv@gmail.com,
	szeder.dev@gmail.com,
	Tian Yuchen <cat@malon.dev>
Subject: [PATCH v9 0/9] migrate more variables into repo_config_values
Date: Fri, 10 Jul 2026 00:11:36 +0800
Message-ID: <20260709161145.13349-1-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708160300.8852-1-cat@malon.dev>
References: <20260708160300.8852-1-cat@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

Hi everyone,

This patch series continues the ongoing libification effort by migrating
a batch of global configuration variables into struct repo_config_values.

What does this series do:

infrastructure & strings (commits 1-6):
Introduce 'repo_config_values_clear()' to manage the lifecycle
of heap-allocated configuration strings. This infrastructure is utilized
to migrate string variables, including 'excludes_file', 'apply' whitespace
configs, and external programs including 'editor', 'pager', 'askpass'.

enums (commits 7-9):
Migrate enumerations 'push_default', 'autorebase', and
'object_creation_mode'. Care was taken to make these types available
to the configuration structure without triggering circular header
dependencies.

RFC:

Commit 3~5. Is it really necessary to migrate _program variables?
https://lore.kernel.org/git/8e657184-ee0b-453a-9f2d-a98080d3582e@gmail.com/

Commit 6~9. Previous related discussions on 'git_branch_track'.
https://lore.kernel.org/git/CAD=3Df0L-mPX+KECUjXk-WBzEbTP7wCa8sB56GySQT0yh9=
mfUOWw@mail.gmail.com/

Note:

Since a new getter 'repo_excludes_file()' is introduced, as previously
promised, once it is finally merged into 'master', there will be a patch to
update and squash the comments.

Similarly, I've noticed that the classification and sorting of variables in
'repo_config_values' don't seem to be correct. There will also be a patch
to fix this, and I think it will form a commit series along with the commen=
t
patch?

Change since v8:

Fixed a memory leak in pager.c.

Thanks!

Tian Yuchen (9):
  repository: introduce repo_config_values_clear()
  environment: move excludes_file into repo_config_values
  environment: move editor_program into repo_config_values
  environment: move pager_program into repo_config_values
  environment: move askpass_program into repo_config_values
  environment: migrate apply_default_whitespace and
    apply_default_ignorewhitespace
  environment: move push_default into repo_config_values
  environment: move autorebase into repo_config_values
  environment: move object_creation_mode into repo_config_values

 apply.c        | 20 +++++++-----
 branch.c       |  2 +-
 builtin/push.c |  8 ++---
 dir.c          |  4 +--
 editor.c       |  4 +--
 environment.c  | 87 +++++++++++++++++++++++++++++++++++---------------
 environment.h  | 75 +++++++++++++++++++++++++++----------------
 object-file.c  |  2 +-
 pager.c        | 26 +++++++++------
 prompt.c       |  3 +-
 remote.c       |  2 +-
 repository.c   |  1 +
 12 files changed, 152 insertions(+), 82 deletions(-)

--=20
2.43.0

