Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4A681724
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 11:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781782943; cv=none; b=d4wVAhVFzt1yFJs5f8GQ6TZqMjnXhMMGHQxww4QjU+T8Kg4oRwY3mC/usJTe5TXz0VpmVboacRvs0RK0SJIz1+wcjGoqDbuC5rNJ+mRniVdpMXYRBtvNUnBdVVlo2SZhlNJKekYnT/IRw8FN7GMsEwBDlrGUUyW/kTugHWTYMsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781782943; c=relaxed/simple;
	bh=h2fT8jnYD4vKGFEHTWqJoijeSqkVxSyoyiH3MJSUFwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fvp2khH9wOzSaxVVmcn4xtDMQF7BABCpAPnk3lrBimDzhOooN15KVxCJjW1s0f7phpj4BWL4X+g7c6a6PDYjw1qUgLzkJR45J2sTxcV/dhfPkXlRkJ9J7gf6/oHfSOREtDiJyDlefCo08JmoZephCtq4VrpKuTIw9v7obyon5Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=mq0XfrGQ; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=bPkLYlmZ; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="mq0XfrGQ";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="bPkLYlmZ"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=mq0XfrGQWCGg1zVjKaiKcMAEtwHsq+LkI/WQv9arPtLLLjLcCUC6Q6DEcE6It+eLwB0bx7iPUO0V3AKkDB7/QvCWgEQdSO3+FFr/U1NVyapQemyy0eM7BHy26VqMymNrHizBAc3/cYZ93sAS2Jbp87LA1CTPBz5gEcf3C/LoxJ6lZtb6vOxEJFM4lbzXQ3jSzlf8p6MNQyOiqd0cQbw1nGlwhH2GwpMiy7GZCyXQw+MSrX9TXfXj4gBBIFrN+aewWqQLELtOwYdH0Y8aFEJdmZchXS+cFQLSVF2P1FrAX3CywvWFNGHNpYW5nb4Y3dPJ1Hgb459xhOl64aQoiPP0eA==; s=purelymail1; d=malon.dev; v=1; bh=h2fT8jnYD4vKGFEHTWqJoijeSqkVxSyoyiH3MJSUFwY=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=bPkLYlmZhcoA+S5yvOx2MafAGLY/MP6Kb6hjiopBMoYH6/qLbcVV9lk3zaTrK8B0tKSpehhoEA64CtRq5t194d3TTMxMc73xS+3Vt9pJvmZOytogwsqjHpdVbMsSvysQcBP+YkhhNOSZWYkFIvs58zMOyfoxLQSFvNJT7EXr83Ces3oUqf+Vk/uuqvC3FhHDevjEA52eIo7UySPACQERCkD9wgZgyD4zH+EhNbdyVHQeMUc9QcWgqfLN0iiJWwvxAnRUrOMMkctF0scU3Yi2vPAD5FC6zyKCPtDHEDiqipIUguSvA4ubmJ/P47vPhZs0Rygs4MBK4QVa8ip76vhv/Q==; s=purelymail1; d=purelymail.com; v=1; bh=h2fT8jnYD4vKGFEHTWqJoijeSqkVxSyoyiH3MJSUFwY=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -632351446;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 18 Jun 2026 11:42:16 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood123@gmail.com,
	johannes.schindelin@gmx.de,
	stolee@gmail.com,
	Tian Yuchen <cat@malon.dev>
Subject: [PATCH v2 0/2] environment: move ignore_case into repo_config_values
Date: Thu, 18 Jun 2026 19:42:05 +0800
Message-ID: <20260618114207.605211-1-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260617154929.564498-1-cat@malon.dev>
References: <20260617154929.564498-1-cat@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

The 'core.ignorecase' configuration, stored as the global variable
'ignore_case', acts as a core filesystem capability flag.

This series continues the ongoing libification effort by moving
this global variable into 'struct repo_config_values', tying it
to the specific repository instance it was read from. This allows
us to encapsulate the configuration without altering its
eager-parsing behavior.

The getter function 'repo_ignore_case()' is introduced so
that we can safely retrieve the configuration value whilst
maintaining the correct fallback logic.

RFC Questions:

dir.c --- Performance overhead?

compat/win32/path-utils.c --- Is it appropriate to include the
repository.h header file?

Related materials:

 [1] In this patch to migrate protect_hfs and protect_ntfs, the approach
of introducing getters has been endorsed.

 [2] Derrick Stolee's previous attempt. The reasons for the failure are
also mentioned in [1].

Changes since V1:

 - s/repo_get_ignore_case()/repo_ignore_case()

 - Use repo->initialized instead of repo->gitdir

Thanks!

Mentored-by: Christian Couder christian.couder@gmail.com
Mentored-by: Ayush Chandekar ayu.chandekar@gmail.com
Mentored-by: Olamide Caleb Bello belkid98@gmail.com
Signed-off-by: Tian Yuchen cat@malon.dev

[1] https://lore.kernel.org/git/20260606143412.15443-1-cat@malon.dev/
[2] https://lore.kernel.org/git/2b4198c09cb6c04c60608d19072d419503dfe5df.16=
85716421.git.gitgitgadget@gmail.com/

Tian Yuchen (2):
  environment: move ignore_case into repo_config_values
  config: use repo_ignore_case() to access core.ignorecase

 apply.c                             |  2 +-
 builtin/fetch.c                     |  2 +-
 builtin/mv.c                        |  2 +-
 compat/win32/path-utils.c           |  3 ++-
 dir.c                               | 18 +++++++++---------
 environment.c                       | 11 +++++++++--
 environment.h                       |  9 ++++++++-
 fsmonitor.c                         |  2 +-
 name-hash.c                         |  6 +++---
 read-cache.c                        |  6 +++---
 refs/files-backend.c                |  4 ++--
 submodule.c                         |  2 +-
 t/helper/test-lazy-init-name-hash.c |  2 +-
 unpack-trees.c                      |  2 +-
 14 files changed, 43 insertions(+), 28 deletions(-)

--=20
2.43.0

