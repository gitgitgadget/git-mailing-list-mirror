Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1A6441F
	for <git@vger.kernel.org>; Sun, 12 May 2024 00:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715475563; cv=none; b=gJCOArc6d18j2k3QgHHDLUaxu5IRACPU3wIlfX3cixMPFVWU4YypLy/uNrvIVkeD1s6hgfAmTP0AfK8h9Tf7ZPxG+GklNfso2q9tdyvm/n3zNQYc//da+fwlTS5ma5Lwo6FTXF1rEt7FUzt4V85yedDZxAstu5SpK2ZRjJ3PQbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715475563; c=relaxed/simple;
	bh=3yKlau4dQprGKJyjF4b3YU7xlzm/m9up3tbeW4VuBEY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kHqptqs5T+lJiteD556/Ag79xK4yMelY2xGgYfJSvJw4kpXx6/Ha1YJczmJRmahiM9ahsmSQFTstD/0nOj+FtHqcQkh3iWraR4NXLY8b4UjuqNKaa7e+bBSm7aWDlS2E4pfhH/BLp7KC7PYOkFUSgod++55DITSDT1CR9vUDGeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=jNbsthVU; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="jNbsthVU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=vnEZXuYzybZS2hL7cQu2UVRMjcOepMrnRbGNSpfXmgo=; b=jNbsthVUD4tGGiDL
	ecPppKCFtHkpp5B2KRLsb68ERfDOe7Zhdh8+jKq/kUEbnS3URa4GQ2IkR2ATe4r9mz+LJ6VFy2kES
	QRMvD9Hlkfb8c+13ruiiHbDE8MufJ9Fl79wgGh/4kV/D9DjtEZDKzEtEHgAGyqLSDflk/9LchmdF2
	lLO6v4j7eKxefBRQJDh5ewQJJkJDEkv1LJYrUhuGQY6M20hApV6OGl6gRxoPK90nkCM/TeWBsthHE
	7qKwWQlgaCJ/rKPGMTsYeknEBkBXjy0hz4pSRgqBmsawMjWZILNrndv9tdogFuKJeP/JMtHkEnVOM
	eQkoESk5S5aQO1IrDA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <dave@treblig.org>)
	id 1s5xYa-000Yb7-1I;
	Sun, 12 May 2024 00:59:16 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: git@vger.kernel.org
Cc: jonathantanmy@google.com,
	gitster@pobox.com,
	"Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH] fetch-pack: Remove unused struct 'loose_object_iter'
Date: Sun, 12 May 2024 01:59:13 +0100
Message-ID: <20240512005913.342287-1-dave@treblig.org>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'loose_object_iter' in fetch-pack.c is unused since
commit 97b2fa08b6b9ee3e ("fetch-pack: drop custom loose object cache")
Remove it.

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
---
 fetch-pack.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 091f9a80a9..28a62e502e 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -732,11 +732,6 @@ static void mark_alternate_complete(struct fetch_negotiator *negotiator UNUSED,
 	mark_complete(&obj->oid);
 }
 
-struct loose_object_iter {
-	struct oidset *loose_object_set;
-	struct ref *refs;
-};
-
 /*
  * Mark recent commits available locally and reachable from a local ref as
  * COMPLETE.
-- 
2.45.0

