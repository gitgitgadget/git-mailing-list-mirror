Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD9716B75C
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 06:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728194502; cv=none; b=TWsaxWSwaEQdgyCS6cqPwUT38LMA/3pBEe6TsF1blIa4TLi5S/p8U+XZEeV4JbyiCp9IKzMZ4/gDdp7GpFsNVhXwEQBuYbtpce2acuCWkr4NOmVd8SElcOVoGhJ4o/Utj/LLedCLurVAYJyda0HH7maKDz2SbwHt1MQ2zQH90pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728194502; c=relaxed/simple;
	bh=hmxG7654v9pL/lC/2kRtpa2/HmKluFMZkNq5wJRpDi8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=phHGA81T1owSGlB22M2jigxeNp14gHeUn31ZniGXfdqYcfft3AnABdLQwNSyFzlLTcx+lZm0C14fydetkuBNIB7/FbNzw0BwdcrHWzanMDPLOq3chotp9tAFIcEET4DzzWBLrx2YHr4t/3cmxjTzEjG0LQYc4ShtRs9BgyOoanw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=nFE+e5YC; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="nFE+e5YC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728194499; x=1728453699;
	bh=eJAYFAmyEddl+GzJ3o1Du0u3FEXKNwKwbZkbjU99GNk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=nFE+e5YCHJMxBVF40MFrBa3YfCLgq4R2e+qcsrAQnks8TgEhs26Oq6cPUdfBPoXYk
	 jFTO7sV5L3d+M9VhZTOYVcwDJVPBxj2nvxzMF8ymFMuPhkfkFjLU6vldBqw8+mpuPb
	 xpkqsCcptY5mKKSdVzgrO+P1dazO2zPHtEQ0bncTOTbVWQIIR4V01EXUR3ZfDZYC9D
	 YHC2ZAeyEcJDe3R0mmI+WahsAFZRPJJHGOvaMOkEYrw+0nSwul6Bb05+BFG3T9fFlC
	 oPBCpPa2hDy16pZbeCbE/TVAGRXHrwOM47xd77j3W+ocv9n1JUw/WrKGtXseytjHnK
	 PymarbpeGL3SQ==
Date: Sun, 06 Oct 2024 06:01:35 +0000
To: git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: Caleb White <cdwhite3@pm.me>
Subject: [PATCH v2 4/4] worktree: prevent null pointer dereference
Message-ID: <20241006060017.171788-5-cdwhite3@pm.me>
In-Reply-To: <20241006060017.171788-1-cdwhite3@pm.me>
References: <20241006060017.171788-1-cdwhite3@pm.me>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: b785527e36168ce301cd77bddf838212ba32ae9f
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------643b989615e59e8f58cf6d3bb6159c3f0ac3a7d1801e36cc815d7ba69f655f56"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------643b989615e59e8f58cf6d3bb6159c3f0ac3a7d1801e36cc815d7ba69f655f56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From: Caleb White <cdwhite3@pm.me>
To: git@vger.kernel.org
Cc: Caleb White <cdwhite3@pm.me>
Subject: [PATCH v2 4/4] worktree: prevent null pointer dereference
Date: Sun,  6 Oct 2024 01:00:17 -0500
Message-ID: <20241006060017.171788-5-cdwhite3@pm.me>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241006060017.171788-1-cdwhite3@pm.me>
References: <20241006060017.171788-1-cdwhite3@pm.me>
Reply-To: 20241006045847.159937-1-cdwhite3@pm.me
MIME-Version: 1.0

If worktrees is NULL, free_worktrees() should return immediately to
prevent a null pointer dereference.

Signed-off-by: Caleb White <cdwhite3@pm.me>
---
 worktree.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/worktree.c b/worktree.c
index b08ecce..1cf15b0 100644
--- a/worktree.c
+++ b/worktree.c
@@ -28,8 +28,9 @@ void free_worktree(struct worktree *worktree)
 
 void free_worktrees(struct worktree **worktrees)
 {
-	int i = 0;
-	for (i = 0; worktrees[i]; i++)
+	if  (!worktrees)
+		return;
+	for (int i = 0; worktrees[i]; i++)
 		free_worktree(worktrees[i]);
 	free (worktrees);
 }
-- 
2.46.2


--------643b989615e59e8f58cf6d3bb6159c3f0ac3a7d1801e36cc815d7ba69f655f56
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAnBQJnAie+CRAy5Kywm9vL4hYhBE+hHqFr3OG0O+P29TLkrLCb
28viAABuIggAn+LKNHKzLxWq6ZZatDqw+vTlkMJfg4HkCuUhq9Uvp8ZJfIeT
0exT1KxaiQuhvuuhoZCLjtF4BLHRvywWMfR3GsemQnkb6zlKbI6hEUc0i55+
trrGIniEAK0JCMXp+gAXWjazdabvhu8zOzg7VfgDXWEGvE/cMe6dGIDsX7tL
W17/81IEWZNjoOQILa3U+S1hCrhcZYuGxJ/IZJ2f+uPoUwrj3iiZfDrIkRFt
Ogm082Dy38SKJodVizhgrRmuzhgr52yX0gLDqyo0eKItUGRGt6jz9qkCDa5l
JFKJzUvYBl0lnfFmhlewpwH/LMKMjmgvL+wsf89/S9L4yh/tAldYPA==
=nqtM
-----END PGP SIGNATURE-----


--------643b989615e59e8f58cf6d3bb6159c3f0ac3a7d1801e36cc815d7ba69f655f56--

