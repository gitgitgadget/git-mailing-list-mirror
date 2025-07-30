Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B949A4C62
	for <git@vger.kernel.org>; Wed, 30 Jul 2025 16:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753893841; cv=none; b=LVU0zHKHAZtr6O0SI73/W4+dQKyk3Rqp65IL4TjUVNY/NYwMH9siN1ifQB+AcUf5td016RnMeErfRzRptWfDdlW+eCxym1vp4stwYJdJ4hLRHQ/0kViKxNRZyhvbZIKibpX+GoObh8b4GrJZ1S0JhnKCXKY+PcEfdW89i4Wi9qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753893841; c=relaxed/simple;
	bh=W+yKA5WCyfv/lkp4jpyrOgBQQbTqrC+b2n0qDxO3GIk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TD1fobu3470ZtYY76kb1zO/htMP0H43oPzLMMzhWOeTdA1b79TH3xCkE7gIhC8WY+6ka92c4qD3a6eo60T0lEixr0x2GSiSfMDxiyz4U0KKojfORr3AiqBAMU2AC8cjVT5N+Li+MzYYqJoVnHgmvO5IzcHyke2CZMoseF4cVsLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1NQVzd3; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1NQVzd3"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7426c44e014so2839b3a.3
        for <git@vger.kernel.org>; Wed, 30 Jul 2025 09:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753893839; x=1754498639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A+8YJLEjcvpzo5HUZsbsSay6GcBFC4MbWArUcb/2Sfk=;
        b=F1NQVzd3xUav5oDv1ZDNgTh+pxIaFZhOIOeJmX2Ve4T3dIbDXENuDpgOU4rke68tgG
         QZLveI/ONLcIHtRGIAU5w/217CD6OUz7bdnhJ0pxEXWoDejDZE9Z2r1bFyVKsPFmiBtd
         CjN07nWzcnI6m8aeHteY9RisES6D07BLcXN/BqkxD1BWaqo/XaC0j/qozQMLbBbKCKio
         k22iHjPdn2vN7MsSj99n1wYdE/mJTXn9QexbSZM4wWnJiuaUj9OZjI2LnRNhkzw4q7S4
         zjAxRVLAf6lHk8zxQGjD0RtAV3nxz+pv+LesbcoVl8/31autJ8b3R+cfcvONkmnhPakD
         +dLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753893839; x=1754498639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A+8YJLEjcvpzo5HUZsbsSay6GcBFC4MbWArUcb/2Sfk=;
        b=d7KzdRBpVA5xH4b6msSzFUKY8GTrrkk6ThwEY7mGNVUjB4QxwcwFnfrsyuGO5iaZLg
         u/s/qE4qMTzJ124Ask3siH4YtuADdnfp1y0cw5S5aKv70c5QzljChDUsCvYD+COA+/0/
         5DBYUL7qpKYfKZGelMKFyzSqJpE040w36NDn36wk0sb4Y/C1HTjlA4NWD5g+VamRzLhD
         dzZe8LLTj1zY8Eq7Jct5/YQkAszfzRnUwoFLl2f4n08vPcba5HOFF+XCift9cqSTskxs
         4DQpI+DQEN+VigEpzweuGKa1SslIowmLIVcdBewhpAmAXqiJZzD/FtL/w7kjeeIkZgmK
         hlkw==
X-Gm-Message-State: AOJu0YxBbGnSmqbgUjpjkvrpp/LJVRRkWLfk/oCoTn1c56veGyS8xrO1
	z/ZirK8F96/O9+0JzOPdM1nNd9ZB0LXGOcau9YUdDirp815QbwdVFHtsN6EXkg==
X-Gm-Gg: ASbGncsi7vmKlU3H3nSD7GoXYD7WJ2a19hNzy73pH8Q5v9pC59i1ME7/suR2jdNhymX
	XWzN22RlNgB9PeqDof7DCiaEaA7AaeZHyJubNH2H+GiqegtE7uF03+clh9lBSc0cYQF4YK768ps
	UmMrlkAm57Ad8N/H1OP/WVxFauT3laCVZ+xS4+FPkXwDfgQoGPwZIxHQlfkVCGqWQBZAKWrnplw
	dnmARzbyIL1w7xM0X3akWB31ChBCQPWmjcptPfyYAiGpCj8CEmP5mJMnLbWi7+Ff8QNuIhLWSsn
	zgn9OvKaygDDI5riShOjqNHMV4SBO+MCXTh2qnP1As+5tvrq1cTySDi4BHHzUJZmWkxNOMIQa5t
	00f4wUz3JJQVDOypwF2J8htole6vEQ1zKzKqp/PE+el/KCDFwzlgLYl1x9s6SgNhCbpSdIUAu
X-Google-Smtp-Source: AGHT+IE/UoEbfyJmafAVcIMUquuBTChNG1uI/sdz3JXA6BuqlKCyLF3Uq0RT0bSSfbGebMvGNNw2rw==
X-Received: by 2002:a05:6a20:7290:b0:23d:54bd:92e6 with SMTP id adf61e73a8af0-23dc0e1cdeamr6877090637.29.1753893838573;
        Wed, 30 Jul 2025 09:43:58 -0700 (PDT)
Received: from localhost.localdomain (c-73-70-17-6.hsd1.ca.comcast.net. [73.70.17.6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f7f58b95esm9671536a12.16.2025.07.30.09.43.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 30 Jul 2025 09:43:58 -0700 (PDT)
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Patrick Steinhardt <ps@pks.im>,
	=?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
Subject: [PATCH 0/5] git-gui: workaround deprecation of Tcl/TK 8.5 in macOS
Date: Wed, 30 Jul 2025 09:40:47 -0700
Message-ID: <20250730164052.15371-1-carenas@gmail.com>
X-Mailer: git-send-email 2.50.1.475.g795bb014d8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series, add improvements to allow running `git-gui` in macOS, which is
stuck in an ancient version of Tcl/TK that is no longer supported by git.

Patches 1 and 2 are minor fixes that could also apply to maint, but the main
change is in Patch 3, which removes the long obsoleted "Git Gui" app that was
tied to the system provided Tcl/TK framework and that has been broken for a
while.

Patches 4 and 5 are needed to avoid the system framework and facilitate using
a third party provided package of Tcl/TK 8.6 instead, but the last patch also
protects against a conflict with the Xcode provided git that for some reason
includes a copy pf `git-gui--askpass` even if `git-gui` is missing.

Carlo Marcelo Arenas Belón (5):
  git-gui: remove uname_O in Makefile
  git-gui: fix dependency of GITGUI_MAIN on generator
  git-gui: retire Git Gui.app
  git-gui: honor TCLTK_PATH in git-gui--askpass
  git-gui: ensure own version of git-gui--askpass is used

 .gitignore                              |   2 +-
 GIT-GUI-BUILD-OPTIONS.in                |   1 -
 Makefile                                |  63 +++----------------
 generate-git-gui.sh                     |   1 +
 generate-macos-app.sh                   |  30 ---------
 generate-macos-wrapper.sh               |  35 -----------
 generate-script.sh                      |  22 +++++++
 git-gui--askpass => git-gui--askpass.sh |   0
 git-gui.sh                              |  10 ++-
 lib/about.tcl                           |   4 +-
 macosx/AppMain.tcl                      |  29 ---------
 macosx/Info.plist                       |  30 ---------
 macosx/git-gui.icns                     | Bin 28866 -> 0 bytes
 meson.build                             |  79 +++++-------------------
 14 files changed, 56 insertions(+), 250 deletions(-)
 delete mode 100755 generate-macos-app.sh
 delete mode 100755 generate-macos-wrapper.sh
 create mode 100755 generate-script.sh
 rename git-gui--askpass => git-gui--askpass.sh (100%)
 delete mode 100644 macosx/AppMain.tcl
 delete mode 100644 macosx/Info.plist
 delete mode 100644 macosx/git-gui.icns

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
-- 
2.50.1.475.g795bb014d8

