Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A87A2F12AB
	for <git@vger.kernel.org>; Sat, 30 May 2026 16:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780157141; cv=none; b=G19JCUF4DxB2jklpWTJt5g+m6T2LVwHwDez97rTStQ4ql59ba9SMiKpVcWzZAY5nLaqK3J7mLW0DLFgZ4lBlFlYXlqjOg42NGI2pbkUDaHL20OuYhXqSxBb8sswauD/p8f8izpHouVjRdCuvbfBOQMa/Jsn0yuRi3rp1Lx/Xomw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780157141; c=relaxed/simple;
	bh=Srilpj0nzvzUby1pSpivtaeR7rhYdB2jpPwmOvREzmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GKri7fULAXBWZTJ0WCJYguQviATByMhyUj2yKevmWWo98X5DOmSlQ83iVQUlH0sNzRee613yC+95CRZGOwkCtOAfUG9v6EhgW5e5420NkexQlCrX+PWr4/bWJB+RL01RC6sgGbNvKoAsVsVfVh+HlSzp13cESTlhWwFbQFDYmO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=chaSMpCy; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=gLMnieSy; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="chaSMpCy";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="gLMnieSy"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=chaSMpCyaFJcOTnsNIDxtXb65cHRZHZx/8R5kOWZpS2ZcunzUhPk00nhLsRamzd9aLelvaoMIDj+ql+pfXoXouJb9Stwrq2/DTukUb/P0XjDeAVg67ru31NrVz6VujuSEhKMwIWCRKcVL6W7Fj6rm/0Ht1WCVN2N1rXP+pYgXLdnSYwcr5t+uEZ0RlrSfVz9I6MfW/NdcLaHZovYxdx9rrGyaNRC4G0YRerhxIFDY9k5ueH4mDNPhJ4jxly9BjBMOFzR7rOxP7D9G4sFvl4hqMq/V2AXLdFhi8PBOVWlbqgFKY2h5atFAn3gUm1QPrSPuNPlDdwacic+EHAu5QOW6w==; s=purelymail1; d=malon.dev; v=1; bh=Srilpj0nzvzUby1pSpivtaeR7rhYdB2jpPwmOvREzmo=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=gLMnieSyMcERaxgIkNgG7lJ8klS9EUhvVSvuAbblVWws7yo2co1SiopwJMoHLn77CVBjy1uIM/pNS03eN3aXvQjbtdXQUQPrLEMwXY2w0cTVXWRtshza3y8/KGGoZNflViiGHjb6aBc3zntrHCaxI7uV6nyIPcH/06DH2KkHPKT2eHDOfOQ/kZjQvPtWXFYDBhbwnP22yKdC28GnemnUsPLopGIBZ8rWIqLi4ZlbGZC5oagBms7hR2fHgXoJBUeTCxAeYF5aeGu1Xor2WreMGaKYNk5W9u1FcJT3YqcNo+eZ3k6ZEqsskFrUvAIQHCpvUNtWD9gzmNmFBz7B+bNURg==; s=purelymail1; d=purelymail.com; v=1; bh=Srilpj0nzvzUby1pSpivtaeR7rhYdB2jpPwmOvREzmo=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1173446767;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 30 May 2026 16:05:36 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	ps@pks.im,
	Tian Yuchen <cat@malon.dev>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v1 2/4] read-cache: move 'ce_mode_from_stat()' to 'read-cache.c'
Date: Sun, 31 May 2026 00:05:17 +0800
Message-ID: <20260530160520.77859-3-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260530160520.77859-1-cat@malon.dev>
References: <20260530160520.77859-1-cat@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

The ce_mode_from_stat() function is declared as a static inline function
in 'read-cache.h'. As we want to migrate configuration variables, this
helper function will need access to corresponding repository-specific
configuration logic. Move the implementation to 'read-cache.c' to
cleanly encapsulate its dependencies.

Note that the 'extern int trust_executable_bit, has_symlinks;' line is
discarded because it's not necessary when the function lives in
"read-cache.c".

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
Signed-off-by: Tian Yuchen <cat@malon.dev>
---
 read-cache.c | 13 +++++++++++++
 read-cache.h | 16 ++--------------
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index c44e4d128f..54150fe756 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -202,6 +202,19 @@ void fill_stat_cache_info(struct index_state *istate, =
struct cache_entry *ce, st
 =09}
 }
=20
+unsigned int ce_mode_from_stat(const struct cache_entry *ce, unsigned int =
mode)
+{
+=09if (!has_symlinks && S_ISREG(mode) &&
+=09    ce && S_ISLNK(ce->ce_mode))
+=09=09return ce->ce_mode;
+=09if (!trust_executable_bit && S_ISREG(mode)) {
+=09=09if (ce && S_ISREG(ce->ce_mode))
+=09=09=09return ce->ce_mode;
+=09=09return create_ce_mode(0666);
+=09}
+=09return create_ce_mode(mode);
+}
+
 static unsigned int st_mode_from_ce(const struct cache_entry *ce)
 {
 =09switch (ce->ce_mode & S_IFMT) {
diff --git a/read-cache.h b/read-cache.h
index 043da1f1aa..3c4af2faeb 100644
--- a/read-cache.h
+++ b/read-cache.h
@@ -5,20 +5,8 @@
 #include "object.h"
 #include "pathspec.h"
=20
-static inline unsigned int ce_mode_from_stat(const struct cache_entry *ce,
-=09=09=09=09=09     unsigned int mode)
-{
-=09extern int trust_executable_bit, has_symlinks;
-=09if (!has_symlinks && S_ISREG(mode) &&
-=09    ce && S_ISLNK(ce->ce_mode))
-=09=09return ce->ce_mode;
-=09if (!trust_executable_bit && S_ISREG(mode)) {
-=09=09if (ce && S_ISREG(ce->ce_mode))
-=09=09=09return ce->ce_mode;
-=09=09return create_ce_mode(0666);
-=09}
-=09return create_ce_mode(mode);
-}
+unsigned int ce_mode_from_stat(const struct cache_entry *ce,
+=09=09=09=09unsigned int mode);
=20
 static inline int ce_to_dtype(const struct cache_entry *ce)
 {
--=20
2.43.0

