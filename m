Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14BE40FD8F
	for <git@vger.kernel.org>; Thu, 14 May 2026 14:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778769250; cv=none; b=m8vJBWwZiFitUxz6fVBS0+HuodXo41/Q820dAN6JLhXKlHWTYeQAKj95U8zTYWbP9TBdjUvCOcs5dyg9vlUkSSBylFEB3pUbW5K9ZUaDd3WVgI8jBedz137PR9C/R5hh//li47Yo6zQM76kUiefR94KfTB0lLPYgaGhAqIpsiOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778769250; c=relaxed/simple;
	bh=YjZlG0HwExtK6/aBqUIDhLwn6Mh+/PksmHSsYk7trfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NLcaYSrAr5BkUltfMxpisSuSyR1QH9eAcwRrgVwCFuRYngjm2+wq/AJsK+Gn9e77O2jJHshKvf+0GpjynvAHtE/nOyrevvfF5u7TcX+GfVDHha5vhwvNFinH7xSbEHxH94vWy0YaYWa6EwWgabN97WOL9GFqQRF1lZfhYg22ZTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+mkBBWL; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+mkBBWL"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8ef45a6d9dfso853748685a.0
        for <git@vger.kernel.org>; Thu, 14 May 2026 07:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778769248; x=1779374048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+YYX4iBwNLZTn2hNJRvTK1VpY1e8eoqqz0V3DLIDij4=;
        b=J+mkBBWLmFc6BGkA5t0REsVaUKxOWvQlOl2y4DnQwZYr6SltZGathOax09JJSNuId3
         WbfapEhqlbsvEFn0UDPxP7DkUqL7b5XBfVB4boM0wSh49mXP7v3HIU4q6mNL7SL2pUvs
         UC8g9fxTEV2SKcagMiDT80SZfKFImQ2xRrVts1KzjAcZAmYRCPUmA3tL04o0UBGYNGcz
         gQ8mf6rg4kX3CvE+MHmvgIdr3QXPrFjxQyjKTmAS8d4XArAQCEjBPz2hiUQvj5vPkyUl
         S/0+olCbZZTRpaqy9NOsY/5szoKYo4yyUcdXeiYqtv5H7O5cuUj8ILgPV23kcJ79Sd0z
         EmNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778769248; x=1779374048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+YYX4iBwNLZTn2hNJRvTK1VpY1e8eoqqz0V3DLIDij4=;
        b=NVLOIIJj/Qs7cenQAMZxblkxq4DrEJjE/BO+ojXoZPDLh9QY1NZ8LA6pujx1RIqxYF
         rQ8D0Yl4gNdr4jZF7s3WwWHNGhoc0brw7h2AbUvpkB5VfiIBkeCYT2dUM/b7QCU8etK4
         8p3xbSQIT8TGWAZQ0dppcELFui7qRh09fF0LWX278I4/yKxFCcfe5aiLWaXVCofX4TR6
         Rq+pbC6wxWJSsIJZUtfcHXzKWcx0vsL8QuSjOnNhccQmZd8LP+SjnbOqqiKXLNhLA6dU
         NZB526BK0Kcevd2qtkfdl48CMzqjM9OgCHlIL3Wd4zD+AlZ82lN2eU1KPnXWC5yIbFvP
         eMQg==
X-Gm-Message-State: AOJu0Yxw34Qfa4Cnw8YYlYuM/HvgMZ7hQ8MMDJSsPsN5622GKPS3jJ8x
	fiIEykVBU26oQ2p8IPhbrnRg9rto0fzVRcC5LJeXsfFMJiabbuyub8x1xMg9Lg==
X-Gm-Gg: Acq92OHnszp5AfPAVzoSe7fQJMrIemdX791haxP0pTo4zJLpcwo7/O1TxZKyYSfuGY6
	lfra3CVNe/3/BCSzMjRUzpR8fXqojTeJo/HxmLAC+LFhwha2ekv3oIV790CUVPxecYCWFXWt2SN
	t+5+WL5td8wJTruORMkmfQcMvlP4Z74bQoJ4N42/ZEjD+wa8rtYj1wPalPoZoPjV+iUK/+BujZV
	4aJF3F4Ry14UIsiiLeIn7x6HW98VxDWraBRXxzUFVmu+BaCNY0VqrVIoYAbES7ICy7LYG8p2rpg
	GAomwZp3HY5iwotwWfj3sZulG6XXsIf6Kjb7P1c02ztZgsKkGFKplekP21BkGGkIPjrsYaBxZD0
	HpxxsScKIFMrSeZBsp7uOsghb2iLP8XiIVrmxrnfM6fZIlo7uSX/JG4/kqPKIvHVH2UUNBBL5B+
	MQMsXMDiY=
X-Received: by 2002:a05:620a:2687:b0:90e:dc5a:c07 with SMTP id af79cd13be357-90f88ba5fe7mr1200916685a.8.1778769247572;
        Thu, 14 May 2026 07:34:07 -0700 (PDT)
Received: from markl5i.lan ([2600:4040:264b:4100::59a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bad2dd8esm262768585a.19.2026.05.14.07.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:34:07 -0700 (PDT)
From: Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
Cc: egg_mushroomcow@foxmail.com,
	j6t@kdbg.org,
	bootaina702@gmail.com,
	Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH v1 05/11] git-gui: use --absolute-git-dir
Date: Thu, 14 May 2026 10:33:16 -0400
Message-ID: <20260514143322.865587-6-mlevedahl@gmail.com>
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

git-gui uses git rev-parse --git-dir to get the pathname of the
discovered git repository. The returned value can be relative, and is
'.' if the current directory is the top of the repository directory
itself.  git-gui has code to change '.' to [pwd] in this case so that
subsequent logic runs.

But, git rev-parse supports --absolute-git-dir from fac60b8925
("rev-parse: add option for absolute or relative path formatting",
2020-12-13), and included in git 2.31. git-gui requires git >= 2.36, so
this more useful form is always available. Use --absolute-git-dir to
always get an absolute path, avoiding the need for other checks.
---
 git-gui.sh | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 0b73c35..c2cf5f1 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1156,7 +1156,7 @@ if {[catch {
 	&& [catch {
 		# beware that from the .git dir this sets _gitdir to .
 		# and _prefix to the empty string
-		set _gitdir [git rev-parse --git-dir]
+		set _gitdir [git rev-parse --absolute-git-dir]
 		set _prefix [git rev-parse --show-prefix]
 	} err]} {
 		pick_repo
@@ -1173,18 +1173,12 @@ if {$hashalgorithm eq "sha1"} {
 	exit 1
 }
 
-# we expand the _gitdir when it's just a single dot (i.e. when we're being
-# run from the .git dir itself) lest the routines to find the worktree
-# get confused
-if {$_gitdir eq "."} {
-	set _gitdir [pwd]
-}
-
 if {![file isdirectory $_gitdir]} {
 	catch {wm withdraw .}
 	error_popup [strcat [mc "Git directory not found:"] "\n\n$_gitdir"]
 	exit 1
 }
+
 # _gitdir exists, so try loading the config
 load_config 0
 apply_config
-- 
2.54.0.99.14

