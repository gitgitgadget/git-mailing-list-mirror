Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AECB29E111
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 08:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753949276; cv=none; b=UuCHk3iO4q9P3Y6Ts9zPBzfOFCyge67kpVNmzS0k5z0pE1eVnlt5OhVDMHq0oFQJOeRR3uaAoGIXfdwe0DL/54wMHU6XRiMCyGkbFx+Hz4g891RG4PmtGJmi5jYUJjvzGeyU6CsNZj59+fdrwp84KsjIEHDpt5st6ys1K+XmQqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753949276; c=relaxed/simple;
	bh=9h8pJh4RaZ9g93LAG/lf8zkYNDqQTG/z+HiFeYWMVNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LxjoKuRQiEVTIPKdpFSXW6xE9bPsXZTQMxk/WaLaYwQHOcDfu2XNLN6o2G93bWJNaCYX3qGpDPsabBAsKxugVh+afHTYBvRU1FSei0D7EjZpuqpZ1SwGB1DT6UHoW7RdCNVP9TIkWPEwLf11UjAFtECkhAgfNb5yzmKgfOLktmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPLLpRDO; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPLLpRDO"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-31efc10bb03so116967a91.0
        for <git@vger.kernel.org>; Thu, 31 Jul 2025 01:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753949274; x=1754554074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hFBmxSZileWzLcMRLLlXYXEQ8Sbq9eDCbYq7QbWgrww=;
        b=dPLLpRDO8Afyi/eBG9mUIqxfOIETFRuAviiF1e3bKemgFhDH5VqQ0BAxvvgXkTtla2
         lICeftJrjJV9GQqZVzD+xFy9l1LYpaSKF5XrJdxd/Er5rxIxfzKnELZK1ZfYSgGTKuLo
         aUahmg2/tHxnFqAwNaTqgSPYcwF1vJoPK4qWRdt5uPbG88OfjUfIBSewhHNzBAd8kLVD
         TA8M0nVzrunB2qBG6Wxw0QfAaq0Il/x172kYsTDfnuCSnZ/UXe9puEjDEyeuUy/RONog
         bMNK9L8WwMkCvHgnGDTTGPuwKpa42iW7JVTe6K9dREZNbTcVw6z/c029aE/sYxfe8EbP
         4WZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753949274; x=1754554074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hFBmxSZileWzLcMRLLlXYXEQ8Sbq9eDCbYq7QbWgrww=;
        b=FsioIOWlwqWO9d7Akm3bSNQtFKoTqRyC8z7YqwleVP2mCejugFd2oFpai0vLpJ++Rj
         nrPkyTFGA4QZTHxZ8coJPg9NxwnA3pHIWzefhmEH3FO0XB0HiOC5J9nfc4FJpESV5WQG
         P7YTvzSSFnB25iVscwKodiuXsKJZqLBZtwkEgRpAG/18uC0ijz2S+TnTn8+wbzv/TD8H
         KHDNXQypbEB67S7bUttM5DE8Pc0J03jqEgEBXZ3Nig48jkFHSbAPlV5LIvqsFze+RXbq
         BNzhJocuicOdEigg8R+ZINoIiKnff+OOo13R5eJ5vFUzztrTVXIPGjeA3Biel0mSyaao
         7jxg==
X-Gm-Message-State: AOJu0YzLHz6dGwlwwfuYK0+VUFwIgriIdB2CfxLf+A6iCvrGRx3yBho6
	XEcUz/NYwCDX1+g6gxhknAf98ax2VlRn9/6aE7dFG2CnQpBmmWyILO8vElrsNg==
X-Gm-Gg: ASbGncsD07QtibAT68lDbJ8xh+9tLB36Ctp2+bpZs012ZoUAqnovYbgYwkTbitz89CN
	mPoLzrCscyO9XYM1GQE2fn49vY2ee/PT0HnF3d5hx+YPfB3NwUU5q2HXhexpCGILHMDwuqoViCd
	fqr4H0ZU1VUv8tMC4VO4ZbxUxLCyyAfGhRSMV1nL6AclDoZEjMMaQSHRJOX3QK/WVjeeUawsW82
	VWB69s9GGN381KChuI16MqzKIF0ZCYXv5RiC5/0hknGTJDFeK1VCBgnG6WrDlXkvmZfTqdaRjQU
	mop0ti3kJCfQEwZkoJHJyajCFMGltSLCoQ/XlUS6YXY4nHKH3G9RbQ1fUnmUOSb0bKfMrrboqIG
	Elg+0Sfd8jeT7pDfYAyS5nluRilf4bv1/pYoyT3pM60XUZBRjd9LWeVKweW08U9fe6DxxzSxq
X-Google-Smtp-Source: AGHT+IGWTGwsMzHPm0R0Sv4gaOa3kMeBmebuSO/djm58AWbhmlrr/EYD1lDQvmxjLIJoiCPm3fkvbg==
X-Received: by 2002:a17:90b:3d08:b0:31e:cb27:9de4 with SMTP id 98e67ed59e1d1-31f5de41993mr8828821a91.24.1753949273554;
        Thu, 31 Jul 2025 01:07:53 -0700 (PDT)
Received: from localhost.localdomain (c-73-70-17-6.hsd1.ca.comcast.net. [73.70.17.6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3207eba6b69sm1237309a91.2.2025.07.31.01.07.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 31 Jul 2025 01:07:52 -0700 (PDT)
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
To: git@vger.kernel.org
Cc: j6t@kdbg.org,
	johannes.schindelin@gmx.de,
	mlevedahl@gmail.com,
	ps@pks.im,
	gitster@pobox.com,
	=?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
Subject: [PATCH v2 5/5] git-gui: ensure own version of git-gui--askpass is used
Date: Thu, 31 Jul 2025 01:06:28 -0700
Message-ID: <20250731080628.27917-6-carenas@gmail.com>
X-Mailer: git-send-email 2.50.1.475.ge15fa7359c
In-Reply-To: <20250731080628.27917-1-carenas@gmail.com>
References: <20250730164052.15371-1-carenas@gmail.com>
 <20250731080628.27917-1-carenas@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When finding a location for the askpass helper, git will be asked
for its exec path, but if that git is not the same that called
git-gui then we might mistakenly point to its helper instead.

Assume that git-gui and the helper are colocated to derive its
path instead.

This is specially useful in macOS where a broken version of that
helper is provided by the system git.

Suggested-by: Mark Levedahl <mlevedahl@gmail.com>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 git-gui.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/git-gui.sh b/git-gui.sh
index 8bb121d..78324db 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1114,7 +1114,9 @@ citool {
 
 # Suggest our implementation of askpass, if none is set
 if {![info exists env(SSH_ASKPASS)]} {
-	set env(SSH_ASKPASS) [file join [git --exec-path] git-gui--askpass]
+	set env(SSH_ASKPASS) \
+		[file join [file dirname [file normalize $::argv0]] \
+			git-gui--askpass]
 }
 
 ######################################################################
-- 
2.50.1.475.ge15fa7359c

