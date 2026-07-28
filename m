Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13C6246BCD
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 01:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785203201; cv=none; b=FpfIwNQPCDuqdQoq0XLvuXUBFLjUeMihCIJ4og05AMkohN8/elSP8jlb3lCx65cVKhmGgggft5CYu5WJ2i1srGYDaCpGCCWwN1/QERrZCSRKCV+LHgQvhWXVHUxZz9/al1ISDHe0rik82Uc7uj/lF404BpWKIrtOxlPUmiDXd10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785203201; c=relaxed/simple;
	bh=N8kp/9E1JKxLKv2TpoKydgkwZFCceC6tDWKme3n/uo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i9ZAIgRL/qFSUoBYZdRxLQtYk+xvuOcK53EYgkid0MzB/qoBY3I/+wS6Udil2qwRYiGApLVs9BjvYObf7Aozu/veyUHI9ndFRzL/pj6W3s3pQ7dwsSPJ2BnIsHuxDUYKXeh+F0Qx5PP81oNKd0BlWSKbOkKXWfnCj9Q8v0JQ/4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=mExpKOBG; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=KbIwxL6R; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="mExpKOBG";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="KbIwxL6R"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=mExpKOBG4ssoUdwxQjrvnvDi9o34c5Ksa8EVNqUyFGsWGNIsbeQ2EzgYoqf1W3wWzLF5dcWaWGLqDTC/07WiPyl2B3BcYgYqCHs35lBZQMQ4PgQaqxRLQ/MAVn3SoSBC66I4tKwZFVOCt1SgRJNTcsDmFAuI7kfFMpMxZtUWPlg5ZHsAh2Z6TaABEwEL2bJ13xbVQtiJ6MHGqXaHqotps02gLO58NcMGYlAhM23/o2nHcSnNOzVPCbcUfGag1HkUqjs9/VYsXxZ5llhKENtsqctzGkOFEsxZbLjeR2wknlmwV3laeScjtXs1xyyKZLruqR2QSycahSY5wEE8PZK2SQ==; s=purelymail3; d=malon.dev; v=1; bh=N8kp/9E1JKxLKv2TpoKydgkwZFCceC6tDWKme3n/uo8=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=KbIwxL6Rgp9YJgUgQdlveeHq6MT8vRT3I1nRGJ5JNpX9gzUdM20qAWPLFemgGGY1P5ItIBdfhmv8QsbDwRSLdsPLUZifhvuFz4S31ymeiooR0o8+LtDoFkxwDQUQ7joexnr580trSwvtcDS569Dag5sXF4pxxP3R0O3wT3+HU7KHw/LnxGT5owT+MrLr6bF+jro5pnhT4g9iWHvt+LD4RLktTFfkc1wKRTW2jlACkGpwnj+SRJnp8ucIPtBhSi65moAVD8pkjE07f/xOgPt+sJanVXHIyQNkwdIYGq5F448rbKC4DWTzDYQbRyDtfZiuN5vkmk9e5iGhUHPA4z3sVQ==; s=purelymail3; d=purelymail.com; v=1; bh=N8kp/9E1JKxLKv2TpoKydgkwZFCceC6tDWKme3n/uo8=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1180613032;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 28 Jul 2026 01:46:37 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Tian Yuchen <cat@malon.dev>
Subject: [PATCH v2 0/2] environment: migrate more global variables into
Date: Tue, 28 Jul 2026 09:46:28 +0800
Message-ID: <20260728014630.3284974-1-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260725115428.2214202-1-cat@malon.dev>
References: <20260725115428.2214202-1-cat@malon.dev>
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

 - (1/2) pack_size_limit_cfg
 - (2/2) assume_unchanged

into repo_config_values to continue the libification effort.=20

Change since v1:

 - drop the migration of minimum_abbrev and default_abbrev.

Related:

 - [PATCH v12 00/10] migrate more variables into repo_config_values
 https://lore.kernel.org/git/20260714032525.1611141-1-cat@malon.dev/#t

Thanks! yuchen

Tian Yuchen (2):
  environment: migrate pack_size_limit_cfg into repo_config_values
  environment: migrate assume_unchanged into repo_config_values

 builtin/pack-objects.c | 2 +-
 builtin/update-index.c | 3 ++-
 environment.c          | 8 ++++----
 environment.h          | 5 +++--
 object-file.c          | 5 +++--
 read-cache.c           | 9 ++++++---
 6 files changed, 19 insertions(+), 13 deletions(-)

--=20
2.43.0

