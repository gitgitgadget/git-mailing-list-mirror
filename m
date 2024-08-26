Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABD1768FD
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 18:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724698143; cv=none; b=lV/v2d4XxyffBbS/fa7mGh8g8o9kL3Ye4dKp6/VgTZpJGXG6xNF53sKu+yWTyNlSqOc/us1NrR6WIkdv41RSh21YD0jt+j2kEUoycpJJ13jvUyKQU2mM6MgrVu4mObsMhvm5O0ZTtYSlhR9FbDWZbTrevCOwJ44cCFwtu6KZAJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724698143; c=relaxed/simple;
	bh=Rr6De+C0cgIAJPokEkk96GAWOyEn/6MNIkudLy6fJ3I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t6MQ22rUypYXgzxDgz1F+yznUtUPDr6iBURoTzmacmjtI3ExtzRCqZ0x3JsRwTCSWbO8W7wPEDXrh6Jg3YfmLcgEi77xIv20aC6B6PhJfAV/Pwa6LEJl5CdbWy4Ua+Mtj34hg/XeR2pGpX5WgDiP5JSl1M5PiEEdaEEPC1uOciE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=T2zH83DH; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="T2zH83DH"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 23EFB2BA85;
	Mon, 26 Aug 2024 14:48:59 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=R
	r6De+C0cgIAJPokEkk96GAWOyEn/6MNIkudLy6fJ3I=; b=T2zH83DHsWacIa6gO
	JEEVffJp6LTl7tbN86Fttb8OkdAz1OGswaaG2KzN97Pdaluv2RYf1OYLRtJLXnYq
	nW+IhsMr/Zps5fuKpS5tPPFro/Cct7JuvrTr+Vl7GYlkQYs+iZzxDTsXhssszwFj
	NJqDJw7mWEWpnCyRqpYGTOuJK4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1C3772BA84;
	Mon, 26 Aug 2024 14:48:59 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 837402BA83;
	Mon, 26 Aug 2024 14:48:58 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2] git-config.1: fix description of --regexp in synopsis
Date: Mon, 26 Aug 2024 11:48:57 -0700
Message-ID: <xmqq4j77jf1i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DA702140-63DB-11EF-BCA2-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

The synopsis says --regexp=<regexp> but the --regexp option is a
Boolean that says "the name given is not literal, but a pattern to
match the name".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * t0450 strikes again X-<.  This should pass that test.

 Documentation/git-config.txt | 2 +-
 builtin/config.c             | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 65c645d461..85a7edc407 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git config list' [<file-option>] [<display-option>] [--includes]
-'git config get' [<file-option>] [<display-option>] [--includes] [--all] [--regexp=<regexp>] [--value=<value>] [--fixed-value] [--default=<default>] <name>
+'git config get' [<file-option>] [<display-option>] [--includes] [--all] [--regexp] [--value=<value>] [--fixed-value] [--default=<default>] <name>
 'git config set' [<file-option>] [--type=<type>] [--all] [--value=<value>] [--fixed-value] <name> <value>
 'git config unset' [<file-option>] [--all] [--value=<value>] [--fixed-value] <name> <value>
 'git config rename-section' [<file-option>] <old-name> <new-name>
diff --git a/builtin/config.c b/builtin/config.c
index 20a0b64090..97e4d5f57c 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -17,7 +17,7 @@
 
 static const char *const builtin_config_usage[] = {
 	N_("git config list [<file-option>] [<display-option>] [--includes]"),
-	N_("git config get [<file-option>] [<display-option>] [--includes] [--all] [--regexp=<regexp>] [--value=<value>] [--fixed-value] [--default=<default>] <name>"),
+	N_("git config get [<file-option>] [<display-option>] [--includes] [--all] [--regexp] [--value=<value>] [--fixed-value] [--default=<default>] <name>"),
 	N_("git config set [<file-option>] [--type=<type>] [--all] [--value=<value>] [--fixed-value] <name> <value>"),
 	N_("git config unset [<file-option>] [--all] [--value=<value>] [--fixed-value] <name> <value>"),
 	N_("git config rename-section [<file-option>] <old-name> <new-name>"),
-- 
2.46.0-528-g6fe5f670b3

