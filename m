Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799861C460A
	for <git@vger.kernel.org>; Mon, 23 Dec 2024 23:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734996357; cv=none; b=fdCxWrvSomYzgxCGNYmHzfgo6LTAXM/QDX6fU9vWkYTdQEqZMNjWQkEy4OfY3pW2zeK+m9Qgt8dwTu7FWjX19fBv0kFDnvttpCGlzDOI3EkHNUxak0goYvw2DQkY9vSRHdL7w8DPDoGo9zulgqzJD6r612aLH5Q2MNIHaInquD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734996357; c=relaxed/simple;
	bh=HFdGhJwhGJUn4kZRktplAojj2t+ASWJ1rx4kz0Z8K2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PQFulLbkWw5+g1ieUWuHH08VoQ2K3iNd+yfK5BOQTs3hjwnKW/4gFQlZdCDK/obHYlh7HD9+tsy9WLzWsN0mUqRMeaI9lvZ0Q8Z6Iks7lfaK6YLBaNrK7fAzWovHvIMWvpxyxhFx0X+da2fF/jhRQtyVOJ9ax2cUDuHpbipZsjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=naE8u1Jl; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="naE8u1Jl"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6d8a3e99e32so37585426d6.2
        for <git@vger.kernel.org>; Mon, 23 Dec 2024 15:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734996354; x=1735601154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GotuVzde6tik4QGom0hXsYTvLLu+oD6Q5UlPWTFC83A=;
        b=naE8u1JlT87gXqfst/NBOom/W/qAceqEH2+haZUUuDa6WndZlVg80SEv45ZWEAyMDm
         OOQ1q3A0/q8PmcQCQ4dl3rwl7glOYnmCNIxt1pt/DcktzI+PMK8VhW8YSbdA//wQ+gcr
         qwVXy99OdbINExboZOI+rm2+v6chyYRtGTZY1yLbeDN1M5J5tFuC7lXI7t7B2XsA9kBO
         g5irz1iuQZ1QILh0n9NyGu9GFpBVlQXXO83h3wGj+wlljwOb87Qp7LsjiizwPSwrV3DF
         gFyUM3DbtfwuupmR1VIXv3emG0BLjqs5ZY1cpNnzrxZBHx8e6y2wfnT3wVMtIjx7TwPT
         S9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734996354; x=1735601154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GotuVzde6tik4QGom0hXsYTvLLu+oD6Q5UlPWTFC83A=;
        b=O3FPdZBjb2Ki3Fp/TuOsls9r2Axmh8NhOIK+kBe8Pep6mt27MZBsL2O3S8S0zHD+7E
         ikFAxd1i566ynn5P0tuy4R5g0JWv9tPNq9iYMNsxlW1ylG6PIBf/lqfQGknb8pCpc5Pq
         CgAkWqhB6gSgHDyn6SkpSJz8F9nkanc9yk57eqGyKLzucidXEAPHiJ7tVcC9Vx9ymTfi
         xwtq9fzGBvrgnj0Lc5e1GDxVN8XHYCnxwMoph1mjsooFl27dQLEbwF58l6srTHuJYNkF
         CwQG1iB0sqZ9DnWBWIfIdEWO1symvcd4kJ07tKkNquUHKcAF8y/2YV1Z2Yg/vPTMMgSx
         lKYA==
X-Gm-Message-State: AOJu0YyVzBMpBhO+cbkZO4yaIHrGwEt/2ec/Pdc7Knsq9CHkCPcbO15j
	9SSk0PIZ3x4YX9SpSHhLtakpCnfb2VZQlBl1UMc26tQirAb+TKZDTjYtpEks
X-Gm-Gg: ASbGnctHq23A9yjsfAjsO1XUVhzTsnIcRnOMPSGPlKjY3xcCQVugbWI05veLkpjrCaW
	7hDpGro1Q2J2erlntlBLcF05oVqIWuEZGeblUFpx16V7qJ5Je6VJwyBkkFQGMBIYU4Q+hSaZ9LU
	VWRQQAC06X610764FLGWPIG5mZzFgbhqQ7lD4lW7yO9llbstMB8wZrYRiHHDBMhxjQd0cSd9nhV
	8vTwgixn7ZJlxE9DTduIVfYoUUUY6hEmNKzKiwMeS2dH/rchgWisDP1XhTk07lZyGIc6YOD0cJy
	QeG0pzmOdZeprUUDDYegPwHdk9uWFxdCzugCUsI+QLv4D2aGHW8tdGIL3E+xLg==
X-Google-Smtp-Source: AGHT+IFvQrT90cw0HCBYgb8hA/awo2OvjVJ6MgQ42h/VymWHcprXLYwQ9VyRzGiFPXIaNJz1EDENTg==
X-Received: by 2002:ad4:576e:0:b0:6d8:aea3:e27 with SMTP id 6a1803df08f44-6dd233a7469mr224322226d6.44.1734996352806;
        Mon, 23 Dec 2024 15:25:52 -0800 (PST)
Received: from localhost.localdomain (pool-174-118-208-220.cpe.net.cable.rogers.com. [174.118.208.220])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd18136e56sm47672496d6.61.2024.12.23.15.25.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Dec 2024 15:25:52 -0800 (PST)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v8 0/6] add remote-object-info to batch-command
Date: Mon, 23 Dec 2024 19:25:17 -0400
Message-ID: <20241223232523.76236-1-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20240628190503.67389-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series is a continuation of Calvin Wan’s (calvinwan@google.com)
patch series [PATCH v5 0/6] cat-file: add --batch-command remote-object-info
command at [1].

Sometimes it is beneficial to retrieve information about an object without
having to download it completely. The server logic for retrieving size has
already been implemented and merged in "a2ba162cda (object-info: support for
retrieving object info, 2021-04-20)"[2]. This patch series implement the client
option for it.

This patch series add the `remote-object-info` command to
`cat-file --batch-command`. This command allows the client to make an
object-info command request to a server that supports protocol v2.

If the server uses protocol v2 but does not support the object-info capability,
`cat-file --batch-command` will die.

If a user attempts to use `remote-object-info` with protocol v1,,
`cat-file --batch-command` will die.

Currently, only the size (%(objectsize)) is supported in this implementation.
The type (%(objecttype)) is not included in this patch series, as it is not yet
supported on the server side either. The plan is to implement the necessary
logic for both the server and client in a subsequent series.

The default format for remote-object-info is set to %(objectname) %(objectsize).
Once %(objecttype) is supported, the default format will be unified accordingly.

If the batch command format includes unsupported fields such as %(objecttype),
%(objectsize:disk), or %(deltabase), the command will terminate with an error.

Changes since V7
================
- Introduced strtoul_ul() in git-compat-util.h to ensure proper error handling
  using strtoul from the standard library.
- Separated the test library into its own commit for better clarity
  and organization.
- Use string_list_has_string() instead of unsorted_string_list_has_string() to
  avoid quadratic runtime behaviour
- Added a documentation link to the wire format in the commit message to
  provide additional context.
- New test case "remote-object-info fails on not providing OID"
- Fixed typos and formatting issues for improved readability.

Calvin Wan (4):
  fetch-pack: refactor packet writing
  fetch-pack: move fetch initialization
  serve: advertise object-info feature
  transport: add client support for object-info

Eric Ju (2):
  cat-file: add declaration of variable i inside its for loop
  cat-file: add remote-object-info to batch-command

 Documentation/git-cat-file.txt         |  24 +-
 Makefile                               |   1 +
 builtin/cat-file.c                     | 110 ++++-
 connect.c                              |  34 ++
 connect.h                              |   8 +
 fetch-object-info.c                    |  92 ++++
 fetch-object-info.h                    |  18 +
 fetch-pack.c                           |  51 +-
 fetch-pack.h                           |   2 +
 object-file.c                          |  11 +
 object-store-ll.h                      |   3 +
 serve.c                                |   4 +-
 t/lib-cat-file.sh                      |  16 +
 t/t1006-cat-file.sh                    |  13 +-
 t/t1017-cat-file-remote-object-info.sh | 652 +++++++++++++++++++++++++
 transport-helper.c                     |  11 +-
 transport.c                            |  28 +-
 transport.h                            |  11 +
 18 files changed, 1021 insertions(+), 68 deletions(-)
 create mode 100644 fetch-object-info.c
 create mode 100644 fetch-object-info.h
 create mode 100644 t/lib-cat-file.sh
 create mode 100755 t/t1017-cat-file-remote-object-info.sh

Range-diff against v7:
-:  ---------- > 1:  c09e21a9d6 cat-file: add declaration of variable i inside its for loop
-:  ---------- > 2:  ed04a4a7c4 fetch-pack: refactor packet writing
-:  ---------- > 3:  bc52c4f80c fetch-pack: move fetch initialization
-:  ---------- > 4:  4c1b989c41 serve: advertise object-info feature
-:  ---------- > 5:  dbc95a9ae5 transport: add client support for object-info
-:  ---------- > 6:  f244ec8a2f cat-file: add remote-object-info to batch-command
-- 
2.47.0

Information Footer:
base-commit: 8f8d6eee531b3fa1a8ef14f169b0cb5035f7a772
Merge Request: https://gitlab.com/gitlab-org/git/-/merge_requests/168
