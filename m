Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5950441B36F
	for <git@vger.kernel.org>; Thu, 14 May 2026 14:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778769252; cv=none; b=V8tAkzAFfaQ3ORWfEzKsfWk53Gq8PoLAn8CxN1prREs1C3lnddo92q75xgH6JrGacXM1VFi+YbNpH75h4XnHFyANhtMRP39EaVXcFFBVGJKJLWOBDuJo68P/vsnizMtkIqW9WOkYUp6yEug6uy41mho8IimvZECqVnCdv7B7/EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778769252; c=relaxed/simple;
	bh=kyDUY0vq/BhgW3NKew0sKdpxoja/XUcuiQf2jMFdONA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aqCE4hTYYcdXSccanx5cl2zgag+/DnMER6tPxeP+5xt58yo/4/6G7WA7FLDmsZRFGExGk9X3cFq+CLK/b8dvI4pAqbLaIWCgseyejKBfu8GAfIWMF+fiMkwWyJWHgMuxIRYB37kmrd3GNLVfL366M7XsCqVeiE3TiMEBt0m+/Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gimopAVZ; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gimopAVZ"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-9118b952e2bso7355085a.0
        for <git@vger.kernel.org>; Thu, 14 May 2026 07:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778769250; x=1779374050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JsNCcncnJULr9ktBmEwB6cDmkprE8K77C5ZvZe/9PGY=;
        b=gimopAVZNcBAsYQephIrqT1dLG6V1Z0u+L3UTwwn6D44UWBiR8cSQbQQxoiFqwDOQH
         RluU+DBq+RyJsZS7f75uTrPjPAtwLABIiPHAZHmrmFHXOOCLzWUjWhvZ2hBBuRvxR4xk
         2BuLaCTcCVoE2GJF9VxMA40DZFomSFnbBADcjkryYnqP9seV68kz6ExF5FbUey9yHbmP
         7xI7t8sdp6Ss+6YS9NZYbARjIUn4cx87GtyapMHWPtKO6niazYWqDO69G3Ra7U3uDr+d
         KVAA0cJu0/u/ESCEQ5i1Z5HATfdfLG4gEJnot6lLEdly13C9fgA9wLxkGN2GDPPefuyi
         VzuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778769250; x=1779374050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JsNCcncnJULr9ktBmEwB6cDmkprE8K77C5ZvZe/9PGY=;
        b=L9q+PkYs2kDollKnj2PT0m8uWEEDCVwHWaD9gl2+jhd8D38m2VoH+sx2OKGDU32zAg
         t21KXBeGIe2l1CpunXVw2IF4Fh3Tfh2NsU3+vxnPxN1scERPC8mWvzoO7v53Ee5Mp0Ur
         1h7gTF7L8CBqlF4ShPfB9+WuFP6RA8TSeXgIzbgU9DWY/jRwZFuiYg6iJAyvkXCKpkNv
         8wbFZDP49mMhW7K+Gtkv0PoGlkJ63avh+sbvdxGhS/MfpnBgADDmQXzxlopGwYHhZAAu
         apsnxMFZ7bmvpaFHmkVrpnExhuv+TE1ptdZpbHU959yWIu8/7TNJt3JiT+zQrJ7pRIRn
         GCeQ==
X-Gm-Message-State: AOJu0YxLZaXmOih2M99z6Pyn7D7RYe6KFVfNNmsrO/gtHjiawmmInMXi
	cGPsnkoDTE7/Z5IYUQQwjdSodla/U9x7ObVGSOFlXszdBMU1n6EQzmHJcIkSZy2K
X-Gm-Gg: Acq92OFf/1acQCSCQiFNan79JJLkHFYK3jtrKgu3zVw/bjuevAX/8RwKdcJprRgQ/oq
	XyNvebasecgQ94lR/4H3I3YvG1tRgeli2YLT+3vzOJV/HvdXKcKuWF68EGS7lnSt/JCCrgLwkSL
	8/I6RheIzjxiQNENtapSeDva9qJPrTRD7sw4/E/iAMPDlN9ltaM9xCxBLpp0sSnuMP1jXbmG73Z
	9dQE3gbFYTYmZECgtkBlMN/eL3PyW8dIbUy2fA5jKnp2FDHJ7bTITF/9kZ95tmLnmOnHSv2EKFv
	El/dH9ttSBbjxFI7ZTfmzsZxX1baYvlT/I7CVACtsQATzcCY7H4zEPI82qzw3svsgXa19Kj4TlJ
	FIyfCrcZnd+rAx6wufKLxmzaklsceafZAwUqoS5tplk21LmxVP+KaxcTUUku3zAAF5YXL8UMVhe
	OyuLPpU1g=
X-Received: by 2002:a05:620a:f13:b0:910:87f4:9a26 with SMTP id af79cd13be357-91087f49e6cmr739946685a.41.1778769250055;
        Thu, 14 May 2026 07:34:10 -0700 (PDT)
Received: from markl5i.lan ([2600:4040:264b:4100::59a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bad2dd8esm262768585a.19.2026.05.14.07.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:34:09 -0700 (PDT)
From: Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
Cc: egg_mushroomcow@foxmail.com,
	j6t@kdbg.org,
	bootaina702@gmail.com,
	Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH v1 08/11] git-gui: simplify [is_bare] to report if a worktree is known
Date: Thu, 14 May 2026 10:33:19 -0400
Message-ID: <20260514143322.865587-9-mlevedahl@gmail.com>
X-Mailer: git-send-email 2.54.0.99.14
In-Reply-To: <20260514143322.865587-1-mlevedahl@gmail.com>
References: <50df7f28-c63c-4762-b542-b888ea3604c0@gmail.com>
 <20260514143322.865587-1-mlevedahl@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

git-gui includes proc is_bare, used in several places to make decisions
on whether a worktree exists, but also in discovery to tell if a
worktree can be supported.

But, is_bare is out of date with regard to multiple worktrees, safe
repository guards, and possibly other relevant features known to git
rev-parse. Also, is_bare caches its result on the first call, so is not
useful if a later step in the discovery process finds a worktree.

So, simplify is_bare to report whether git-gui has a worktree or is
working only from a repository.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 git-gui.sh | 25 +------------------------
 1 file changed, 1 insertion(+), 24 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 81789dd..a03eaa7 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -372,7 +372,6 @@ if {[tk windowingsystem] eq "aqua"} {
 set _appname {Git Gui}
 set _gitdir {}
 set _gitworktree {}
-set _isbare {}
 set _githtmldir {}
 set _prefix {}
 set _reponame {}
@@ -524,29 +523,7 @@ proc get_config {name} {
 }
 
 proc is_bare {} {
-	global _isbare
-	global _gitdir
-	global _gitworktree
-
-	if {$_isbare eq {}} {
-		if {[catch {
-			set _bare [git rev-parse --is-bare-repository]
-			switch  -- $_bare {
-			true { set _isbare 1 }
-			false { set _isbare 0}
-			default { throw }
-			}
-		}]} {
-			if {[is_config_true core.bare]
-				|| ($_gitworktree eq {}
-					&& [lindex [file split $_gitdir] end] ne {.git})} {
-				set _isbare 1
-			} else {
-				set _isbare 0
-			}
-		}
-	}
-	return $_isbare
+	return [expr {$::_gitworktree eq {}}]
 }
 
 ######################################################################
-- 
2.54.0.99.14

