Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747F020B0F
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 20:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723666044; cv=none; b=cuieNBrySQd8q/fdQ5ZhN7bcOyHgzNfQ1qAYTaou+KdWgsASXMjslreUPohL0GKVZsE4ZMMKo/9WcljDAlgbBzDjD87fsOgqLLwokMwXviRCwXDXaE20MrItOce5lpCvmkSVjerPIDWjJkTCc/LwRhzvhJa756lR1L5kOgG/uss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723666044; c=relaxed/simple;
	bh=odjp7zcUmtLSJE8AzPq0Jmkb1tg8hbI+2ba+FEKZ4kM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nqe/8RiK6GihWk32Dh0EFqRbj4W3stquWu5kpJHMwkPAhGEUdtfTilEXnq1pjWqcifVVUeCkMoG7ABn3vznF/1A/gvlIL3mJ8N0gKhDfOXnPeOJ7r8yV/dEbQZSZGLMPCy3QXodfu+BvJRNRZfaisYqJj4oSQhapMSo68BM/YfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ldpreload.com; spf=pass smtp.mailfrom=ldpreload.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=vVk8Sh+G; dkim=fail (0-bit key) header.d=ldpreload.com header.i=@ldpreload.com header.b=Qaja6YxE reason="key not found in DNS"; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ldpreload.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ldpreload.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vVk8Sh+G";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ldpreload.com header.i=@ldpreload.com header.b="Qaja6YxE"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C581D2AD85;
	Wed, 14 Aug 2024 16:07:20 -0400 (EDT)
	(envelope-from geofft@ldpreload.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-transfer-encoding;
	 s=sasl; bh=odjp7zcUmtLSJE8AzPq0Jmkb1tg8hbI+2ba+FEKZ4kM=; b=vVk8
	Sh+GGOXnmAGA8RU8HPTMmJNOB5jQG0Rm60A+xz3pICHuqAOGOkczM7KFZJF/aXKt
	utY4Tr3CljgBB/mdTgOyc8dbJe319WuyYsj8QKc9fCc5nHTVR0LIkG9V2TWoRNEA
	c+CX9OJxfqV5q7x37IZmYEhm2OKyHu7ZQbruZdg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id BEDAF2AD84;
	Wed, 14 Aug 2024 16:07:20 -0400 (EDT)
	(envelope-from geofft@ldpreload.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=ldpreload.com;
 h=from:to:cc:subject:date:message-id:mime-version:content-transfer-encoding;
 s=2016-12.pbsmtp; bh=E+a3hzjP6W/U2yP7nLt5EcKMZIDNBnfwL+RNai7jzwQ=;
 b=Qaja6YxEqJyNLZBuo7YCjdBHtFJD79CKKP3lpAZddh8+bSzJAGgHEBPSGY6ycPDPps2E13tzeyzNbGGNcteo13OcjS9cwqd070Ztw1lejRQ73oDPYLMSd44Z9bnEtbnVpEx/m92RVGXfngJdUeD82d1WcnT4ST77iVQltPn6/o8=
Received: from localhost.localdomain (unknown [24.38.253.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 705A42AD83;
	Wed, 14 Aug 2024 16:07:15 -0400 (EDT)
	(envelope-from geofft@ldpreload.com)
From: Geoffrey Thomas <geofft@ldpreload.com>
To: git@vger.kernel.org
Cc: Geoffrey Thomas <geofft@ldpreload.com>
Subject: [PATCH 1/1] git jump: support show
Date: Wed, 14 Aug 2024 16:07:09 -0400
Message-Id: <20240814200709.53450-1-geofft@ldpreload.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 CD2B6560-5A78-11EF-B558-E92ED1CD468F-67873895!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

This makes it easy to go to the changes in the latest commit, or a
previous named commit, to fix a bug and commit a fixup, to respond to
code review feedback, etc.

Signed-off-by: Geoffrey Thomas <geofft@ldpreload.com>
---
 contrib/git-jump/git-jump | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
index 47e0c557e6..6cf16e0f32 100755
--- a/contrib/git-jump/git-jump
+++ b/contrib/git-jump/git-jump
@@ -41,8 +41,10 @@ open_editor() {
 	esac
 }
=20
-mode_diff() {
-	git diff --no-prefix --relative "$@" |
+do_diff() {
+	cmd=3D$1
+	shift
+	git "$cmd" --no-prefix --relative "$@" |
 	perl -ne '
 	if (m{^\+\+\+ (.*)}) { $file =3D $1; next }
 	defined($file) or next;
@@ -56,6 +58,14 @@ mode_diff() {
 	'
 }
=20
+mode_diff() {
+	do_diff diff "$@"
+}
+
+mode_show() {
+	do_diff show "$@"
+}
+
 mode_merge() {
 	git ls-files -u "$@" |
 	perl -pe 's/^.*?\t//' |

base-commit: 25673b1c476756ec0587fb0596ab3c22b96dc52a
--=20
2.39.3 (Apple Git-145)

