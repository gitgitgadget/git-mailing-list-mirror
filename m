Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224E744BC97
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 09:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773136247; cv=none; b=ngvXCi/MBCDzQUngPti6l7dRFciWtBP4VjHRVO12WWGYbx6h2991BizDej/D7JZWNivizQ97MLjJFXWmxFTkRhoLuMpO2dGRdOzqfeirdJGMA91E8D4Go4WdAdTjMCB6ZXHFgGRywosgtWG4biBm50NT8qIZUVOkRxq+urzCqe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773136247; c=relaxed/simple;
	bh=t9J/7mrgrBrX8u6nl13wgz3ekqlQ4AzqdTMIB//F7X8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uCkd6XQ2wmNU3cWtkgEaUvB/rN0SYU7raZqXRbwAqy7kgcLHk9+C1HWXR1H8bXN3P4ELTxTju/4YACCmLA2mcqVnZWun4ZYHiK62SADH3NJU75BpvMWeTMNDrJBRQO1971sHgmCVl3rlbuhElTIywTny134Lhk4r0GQUy4n1uJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=D9vtSugA; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=h9Ly9lil; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="D9vtSugA";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="h9Ly9lil"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=D9vtSugAJJuiHdvAtlja9lV7z/ENLIhawai9mGW85633CHNyn0Pg1L09WbDs1b3BCAqcoyd7XsxCxnizVE4llkraE3pAebm9F95BZMMRORv5Mt9+Rvrukx0YoGqQAI8Npe5WeRXuY3MD8hiiqNzEGsZkB/uboUML+XXOEA6IO6W6pzHpqmQM9YU/oZ8b8QCi8TdR4Tdf8dHxjnVRC5KqxNHHeZ6eedhVwBbsx/CZjJX0VMxXw4eAjC6P68cTj3z4sWF/J59GL6wINNM6EOUjRdtfqsenXjOZ6cDcipUuQC0C6xvj7DiB1LYNs586o6wkEGwt3l8p2ddxFblmPVhV/w==; s=purelymail1; d=malon.dev; v=1; bh=t9J/7mrgrBrX8u6nl13wgz3ekqlQ4AzqdTMIB//F7X8=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=h9Ly9lilUXmZ13zA1+/2+Jy0b8AvLMXZVq74T6RANJEg0zWeVCc6cBpgnkcp6iy3L2EQshKsFS/ddYv6eDvGxEFPpUjpssgtJ9MKVWQw6hmihoj3kkwhFjPj2oLoQdcm/5jHGOBtNdf7fegWHzQb53J5S/UatUT1W55m3j+MGqbPtK4xB9bYYSY3Z4zWlT7qYns6I+6YKp0lvSeuB/+7df1RI1lzayZ85asoAkwIX0HVA8/6stnrdMO6mU375sdF0m7rxSzYZDu4fOveMBwZdRyHe8Oyj23YUIbbyXvEybr21OnrGp6gfzAMnZ9HiXKzJLilJl/uSoOD2SaFLBaAsw==; s=purelymail1; d=purelymail.com; v=1; bh=t9J/7mrgrBrX8u6nl13wgz3ekqlQ4AzqdTMIB//F7X8=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 258813898;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 10 Mar 2026 09:50:38 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ben.knoble@gmail.com,
	oswald.buddenhagen@gmx.de,
	Tian Yuchen <cat@malon.dev>
Subject: [PATCH v3] diff: document -U without <n> as using default context
Date: Tue, 10 Mar 2026 17:50:17 +0800
Message-ID: <20260310095017.131957-1-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309172719.125419-1-cat@malon.dev>
References: <20260309172719.125419-1-cat@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

The documentation for '-U<n>' implies that the numeric value '<n>' is
mandatory. However, the command line parser has historically accepted
'-U' without a number.

Strictly requiring a number for '-U' would break existing tests
(e.g., in 't4013') and likely disrupt user scripts relying on this
undocumented behavior.

Hence we retain this fallback behavior for backward compatibility, but
document it as such.

Signed-off-by: Tian Yuchen <cat@malon.dev>
---
 Documentation/diff-context-options.adoc | 6 ++++--
 Documentation/diff-options.adoc         | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/diff-context-options.adoc b/Documentation/diff-c=
ontext-options.adoc
index e161260358..306abfd9ab 100644
--- a/Documentation/diff-context-options.adoc
+++ b/Documentation/diff-context-options.adoc
@@ -1,7 +1,9 @@
 `-U<n>`::
 `--unified=3D<n>`::
-=09Generate diffs with _<n>_ lines of context. Defaults to `diff.context`
-=09or 3 if the config option is unset.
+=09Generate diffs with _<n>_ lines of context. The number of context
+=09lines defaults to `diff.context` or 3 if the config option is unset.
+=09(`-U` without `<n>` is silently accepted as a synonym for `-p` due
+=09to a historical accident).
=20
 `--inter-hunk-context=3D<n>`::
 =09Show the context between diff hunks, up to the specified _<number>_
diff --git a/Documentation/diff-options.adoc b/Documentation/diff-options.a=
doc
index 9cdad6f72a..e1f20bedf6 100644
--- a/Documentation/diff-options.adoc
+++ b/Documentation/diff-options.adoc
@@ -127,8 +127,10 @@ endif::git-log[]
=20
 `-U<n>`::
 `--unified=3D<n>`::
-=09Generate diffs with _<n>_ lines of context instead of
-=09the usual three.
+=09Generate diffs with _<n>_ lines of context. The number of context
+=09lines defaults to `diff.context` or 3 if the config option is unset.
+=09(`-U` without `<n>` is silently accepted as a synonym for `-p` due
+=09to a historical accident).=09
 ifndef::git-format-patch[]
 =09Implies `--patch`.
 endif::git-format-patch[]
--=20
2.43.0

