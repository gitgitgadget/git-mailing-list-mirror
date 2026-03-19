Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD10140628C
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 22:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773959928; cv=none; b=n0hcmK+YKklzX3J4IJivD61B4MlAPUDgJIBSD4XnCozzlfmfi5GLAynsCbZEUKCZ5I5uehdo+tD4rR7+viU/C6IW5PUvwYisjeMwH1vZvYW8QQBCwddaOdnV29aGNBU4xvRQ4pzbV4sojLk2JIjMCbFdEm8CsosJIioF1feNIyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773959928; c=relaxed/simple;
	bh=Fcm1hazel3B11bKgD1SGNFOofSIpgyA0RfwiX94VM3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HHuufD0Nv519IIL5iPDhVuuMoCtqkVSbKvCY1GabwyUqydl2k5vDltvxPSTIxJgxOaGLdTWYLO9I6FZDKAEzvpQ6FcU3VG/6N7n0hrFnc62nj2Sm22T+5rUfy07u0p89d+pcXelhMS1+sp2XfUoZQtAFwDhQvDSyO2rwd0xEtpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=LZE1FW21; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="LZE1FW21"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1773959917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xWmyvO1bSm2biI8YixhwNhrAnuga9Y5tvRiePzapk4c=;
	b=LZE1FW21fqU31vaH9N72kYXjiSqE5l4dAGCx99WXtvxYgOC8CMd5NVzyIuCWFXB8FDSzjv
	xfvyt3VIZI0eyG5lLujkFmUwl8ooIjkioadyWJzFqaj7LH/zI1+KTwYK6hmMhWeRkpCOqH
	VtPwkiKJqPPM0FDLSA5sYI8fZCwRwib0crgvD+NwvDdyT7wchD/0sbZ9fr9Y1V+WT2XuVe
	FoYf5f1ovga3P+ZWPIWz8GLKiGdbWDU4zsmXUvFjQFJkQGVxpbm8anjjEp7GzT73NiDqQh
	6SfypqGCA9wgAc8Q7XLaFt2FKrroZUPoSIvYVJa/TNgnja3ZzJSVXq5SUifqcQ==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v2 0/8] improve "git format-patch --commit-list-format"
Date: Thu, 19 Mar 2026 23:38:10 +0100
Message-ID: <cover.1773959395.git.mroik@delayed.space>
In-Reply-To: <cover.1773530191.git.mroik@delayed.space>
References: <cover.1773530191.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -

I've applied the suggestions that Kristoffer made and added an
additional patch that documents %(count) and %(total), but I'm not sure
if I've placed them in the right location. It's in the "Placeholders
that expand to information extracted from the commit" section despite
not being the most accurate, but making a new section just for
"Placeholders that expand to information from patch series" didn't seem
right.

This series is based on top of 67006b9db8 (The 15th batch, 2026-03-12)
with the following series merged into it:
  - mf/format-patch-cover-letter-format at 51ed9f7e72 (docs: add usage
	for the cover-letter fmt feature, 2026-03-07)

[1/8] pretty.c: better die message %(count) and %(total) (Mirko Faina)
[2/8] format-patch: refactor generate_commit_list_cover (Mirko Faina)
[3/8] format-patch: rename --cover-letter-format option (Mirko Faina)
[4/8] docs/pretty-formats: add %(count) and %(total) (Mirko Faina)
[5/8] format.commitListFormat: strip meaning from empty (Mirko Faina)
[6/8] format-patch: wrap generate_commit_list_cover() (Mirko Faina)
[7/8] format-patch: add preset for --commit-list-format (Mirko Faina)
[8/8] format-patch: --commit-list-format without prefix (Mirko Faina)

 Documentation/config/format.adoc    |  2 +-
 Documentation/git-format-patch.adoc | 19 ++++----
 Documentation/pretty-formats.adoc   |  4 ++
 builtin/log.c                       | 35 +++++++-------
 pretty.c                            |  4 +-
 t/t4014-format-patch.sh             | 72 +++++++++++++++++++----------
 t/t9902-completion.sh               |  1 -
 7 files changed, 84 insertions(+), 53 deletions(-)

-- 
2.53.0.1018.g2bb0e51243

