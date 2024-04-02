Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06116FD9
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 00:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712016834; cv=none; b=HJWY/p6ymvQ01juApyrOTIOh9tZhC6mGLt9wS1utOfqOa3Vuttq/2lwdOPzF56eKm0eTZztJHRKn7pQSaZY6x1MbNpdY+y/JRyUzkMqhMCk/X7NSOMBsLUdtRcFnSKMDxv9N7LWtU3/W6CsuIlvMXyrhf1FNS1hDF31imbpW5so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712016834; c=relaxed/simple;
	bh=VyFDZfgIm7soKk2AJ8OG788n8fltV6c8sMg2dnP5+Hg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=bep6psLcu73QiIsEL7HHPgVChqHZHfK83054AzJoVwY9gvQoOCnsjoeE22sMwU39kyooOJm1MNsr5NdMmrQC35RVWvwdrXzfki8pYdEUWUAT/K5W/92jTyEiirOi9ML2ZpXM3AtwDIttGspdUkkfOhnNx7EdXTLjJ0+GBvlXdGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=TSjNWJW4; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="TSjNWJW4"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1712016828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Py4ZplJraco+AFTTJgke/rHN0FmyF+VtZ08YzeyRrrY=;
	b=TSjNWJW4zikBcUWPF20xoUsLVI0yFzbUeC1lb1+3jN5HtcELMoU1EaXklL39v6jriQgZqH
	5fb3YkTLyOK79ydq78WWy/kzfG3BtCdygy9GqT+s+GqgkT9N15gx1/xybstgeXwvZi3XzB
	jxedkKfQ2YGnfDYz/y7GJIdk74DRJ5ywTTodnsLC2er+alHzs+dl6+3II97JDg0MuYdUJb
	B9ki7+REg0SKJ111MZtMVphqqWfxpmrISHEVl7rT+cl846EH9QwlVC6eqVQVu/YU5uhJI5
	YBBFGoI7KmMi4jLjJUnfO3cVsHirNc4G5l02xDgfmst7846T5810O77XKidYIA==
To: git@vger.kernel.org
Subject: [PATCH 0/3] Make support for multi-value configuration options more consistent
Date: Tue,  2 Apr 2024 02:13:41 +0200
Message-Id: <cover.1712016667.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

This series adds support for optional placing of additional whitespace
characters around the commas in the multi-value, comma-separated values
for the "diff.dirstat" and "diff.wsErrorHighlight" configuration options,
and the "--dirstat" and "--ws-error-highlight" command-line options.

This makes the way multi-(sub)value configuration options can be specified
more consistent, because exactly the same additional whitespace characters
are already allowed for some of the configuration options.  It may also
make the configuration files more readable to some users.

Dragan Simic (3):
  diff: support additional whitespace in diff.{dirstat,wsErrorHighlight}
  t4015: whitespace in diff.wsErrorHighlight and --ws-error-highlight
  t4047: whitespace in diff.dirstat and --dirstat

 builtin/gc.c                |  4 ++--
 diff.c                      | 14 ++++++++++----
 notes.c                     |  2 +-
 refs/packed-backend.c       |  2 +-
 string-list.c               | 27 +++++++++++++++++++++------
 string-list.h               | 10 ++++++----
 t/helper/test-hashmap.c     |  2 +-
 t/helper/test-json-writer.c |  2 +-
 t/helper/test-oidmap.c      |  2 +-
 t/helper/test-string-list.c |  4 ++--
 t/t4015-diff-whitespace.sh  | 36 ++++++++++++++++++++++++++++++++++--
 t/t4047-diff-dirstat.sh     | 33 ++++++++++++++++++++++++++++++---
 12 files changed, 110 insertions(+), 28 deletions(-)

