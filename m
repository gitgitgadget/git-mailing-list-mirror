Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBAA34D3A9
	for <git@vger.kernel.org>; Fri,  8 May 2026 12:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778244667; cv=none; b=NGUA+3+20LtZVWJCek740YTJf6AaeMZCtQYkGhS5TaFPXVN4zOiC8Xp1KmgMqr2y7cY1nAmjFJA6Elb/PKv3gtEBN6LsJV1H5huUPbi+vYIdoh3gu+aF/LafAS8hPeuT2or3PtsxXpJycQG9rnlC+Lmb4p80fnm/SQqIBoqS6Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778244667; c=relaxed/simple;
	bh=qSbSG+wrcEWAIc1R6IuHG8WxHRxQ/eNVvBziIqse42k=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=UfIkWDxmzUUQoNJ9Rz7Qv18QLPR8c03aJcwn7E0XyEgHOzeb3/uZCNZuGs853l5iLhEAP6+/4ObUO9mAotlSSAa58KW6Mc6uPXOkBIQMVdh/dIy8FrRtGtX4bJ4V1kCUlq3IEeSvU2GGamTrnTUO7Tf1KVPp1FDOleTDZR0LJ0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WR9IXSEN; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WR9IXSEN"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8f0a87e23daso207148885a.1
        for <git@vger.kernel.org>; Fri, 08 May 2026 05:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778244664; x=1778849464; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Tix8F3nwvzcVolImWDnGF40B1w1DatVag6dbbk5nCQ=;
        b=WR9IXSENdJVekdOhai1a+hZ1JlpYuNIEmU0TlPWFl6IFfBGzm+FWuU4sucIewD5mrR
         1iBbS9TMdImn9/l4coanj53ysrvViR/pcUYv/7xcNexBUzjSD8oOJ8FCCGg58QGuWyeF
         NuprfwsnPympkeOgN4FN/xp3tGIwzgjhfdc1suA8X09nCE1dI73LKwouG3A2QeYQ6QiY
         eIsSAiFtNiNX8Don4JFTko3ZwsyWxpmwf+UqbXJfPf681agbT5PmvvaRrUM8JiKA4lAb
         XEukI9OwCYmLtU4x5wo+W/6sBI/9/ZMFpmoTcoHCoxJgSKQp0n6gvaN77keS9h7Rt+jF
         RvwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778244664; x=1778849464;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8Tix8F3nwvzcVolImWDnGF40B1w1DatVag6dbbk5nCQ=;
        b=nJnU8FLXL0uaLF37xT6zBBafQQRQ6bni2zG4tDJyVSsBqjSqhYdrDoetQP2yQq2+Tg
         T9QnNZEkSTa9Pa53sT3f/nYlkIVBBttim3H42OpQ3V6vKnnvxkqaVh9xXn4m64Fk5t4I
         wjEWUp8degchRG8yymiQ9Z+hbq593v38LTuBHdh50oHvEEQU3zfLA03EbbotFLegKI6r
         aNgkrpMXHP0vcr+rSXYfki0rRgq1gZX8hDH+Na6NEKXD5VW46q83yqUHfSpcReeFIuic
         G987M1ZuBoz1U/3B2BFwRVNjVvRE8oKn80XGW8u14bmGfH0lYXlDrm/gNEYy6yJKPpKn
         TJ4Q==
X-Gm-Message-State: AOJu0Yx4AMY7+c7Sj0HqGyYo41upHfjgAAXZV77QvgKtQxCr8zg66Em3
	8MQqSnV1C8BkYkmTjsjMcX5zRuCNA0KSnpvr6bu1ebM5MR7em420RHE74pzxEw==
X-Gm-Gg: AeBDievhoY9p2Il3sip+6/WDK9CaMhDOI82wHdndKGgb6wibxQYtFZ5+xl+t6RgAtUN
	+/IITfDWXCtfsyz0RfdxHhjdi1L4SOBRUn4IfaQbC9HpatnEBP+hTDAiFH8k25DSNzr+Qvr8Ehm
	ClclRD8/vKQFTz8lOiWBL/d2tIz9pZLpBiVeVrm6OJOvNf/UOMbJaBAGBB1+saOt73oj5eyU+DU
	o+6d2gzOKrH31UBWN89qODSYbwGVjT0FAmc8rD2MiIjt20qRKULDcPba/gL4QAWFt7jJd6QsYT0
	pygULbZaXxGBVbgBqYsO31qyS+cQkX3uP41ASPgflXDbpybhn/xVHGOqG0jHQL7EoCPEtv7DoiR
	NBt5Ugq9L5HAfSv9y0h1K6lswEPiAGu6ksqSxNhSrxPNh0PZMZO+pjLC+gwTt6KFWA8gkChE0Er
	QlJR94KpGNaQN+CYuXkq54lmyRHXPu
X-Received: by 2002:a05:620a:f0f:b0:8ef:7934:22d6 with SMTP id af79cd13be357-904d6fccb8fmr1795241685a.55.1778244663992;
        Fri, 08 May 2026 05:51:03 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.176.163])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2cd04de9sm2275267285a.44.2026.05.08.05.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 05:51:03 -0700 (PDT)
Message-Id: <pull.2104.v3.git.1778244661.gitgitgadget@gmail.com>
In-Reply-To: <pull.2104.v2.git.1778169613.gitgitgadget@gmail.com>
References: <pull.2104.v2.git.1778169613.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 08 May 2026 12:50:55 +0000
Subject: [PATCH v3 0/6] mingw: stop using nedmalloc
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

Git for Windows' SDK wants to update GCC to v16. Since it is used in the CI
builds also of the git/git repository, it is crucial that GCC can compile
even the latter all right, but currently it does not, see
https://github.com/git-for-windows/git-sdk-64/actions/runs/25244795074.

Git for Windows switched away from nedmalloc to mimalloc a long time ago,
but recent benchmarks across Windows, macOS, and Linux (see
https://github.com/git-for-windows/git/pull/6231) show no measurable benefit
from mimalloc over the platforms' default allocators, so rather than
upstreaming the mimalloc support, I will drop it from Git for Windows
entirely.

This series therefore disables nedmalloc for MINGW builds and removes the
vendored-in nedmalloc from Git's source code; my earlier sketch in
https://lore.kernel.org/git/00fd3145-b3d2-ddab-466d-d06fd27298ec@gmx.de/ had
the opposite ordering only because it assumed mimalloc would land first.
Since that's not going to happen, it's best to move forward with this, so
that the CI builds can switch to using GCC 16 (and the current Git for
Windows SDK) on Windows.

The patches that remove the vendored sources have a slightly unusual shape:
the Git mailing list rejects messages over 100kB and
compat/nedmalloc/malloc.c.h alone is ~196kB of source, so the deletion of
that file is split at section boundaries into three commits, each
comfortably under the cap. The intention (as documented by the last three
commit messages) is for them to be squashed by the Git maintainer before
merging.

Changes since v2:

 * Reworded the last 4 patches as recommended by Junio, in preparation for
   squashing them on his end.

Changes since v1:

 * Also remove nedmalloc from the CMake and Meson configurations in the
   first patch.
 * Add follow-up patches that drop the nedmalloc build-system plumbing and
   source files.

Johannes Schindelin (6):
  mingw: stop using nedmalloc
  mingw: drop the build-system plumbing for nedmalloc
  mingw: remove the vendored compat/nedmalloc/ subtree
  to be squashed into 3/6 (chunk 1 of 3)
  to be squashed into 3/6 (chunk 2 of 3)
  to be squashed into 3/6 (chunk 3 of 3)

 Makefile                            |   17 -
 compat/nedmalloc/License.txt        |   23 -
 compat/nedmalloc/Readme.txt         |  136 -
 compat/nedmalloc/malloc.c.h         | 5761 ---------------------------
 compat/nedmalloc/nedmalloc.c        |  954 -----
 compat/nedmalloc/nedmalloc.h        |  180 -
 config.mak.uname                    |    4 -
 contrib/buildsystems/CMakeLists.txt |    3 +-
 contrib/vscode/init.sh              |    1 -
 meson.build                         |    2 -
 10 files changed, 1 insertion(+), 7080 deletions(-)
 delete mode 100644 compat/nedmalloc/License.txt
 delete mode 100644 compat/nedmalloc/Readme.txt
 delete mode 100644 compat/nedmalloc/malloc.c.h
 delete mode 100644 compat/nedmalloc/nedmalloc.c
 delete mode 100644 compat/nedmalloc/nedmalloc.h


base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2104%2Fdscho%2Fstop-using-nedmalloc-with-mingw-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2104/dscho/stop-using-nedmalloc-with-mingw-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2104

Range-diff vs v2:

 1:  d547877ae3 = 1:  d547877ae3 mingw: stop using nedmalloc
 2:  7b5daae659 = 2:  7b5daae659 mingw: drop the build-system plumbing for nedmalloc
 3:  a5ccd4dae3 ! 3:  fc7f5cae10 mingw: drop the small nedmalloc auxiliary files
     @@ Metadata
      Author: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## Commit message ##
     -    mingw: drop the small nedmalloc auxiliary files
     +    mingw: remove the vendored compat/nedmalloc/ subtree
      
     -    The Git mailing list rejects messages over 100 KB, and
     -    compat/nedmalloc/malloc.c.h alone is ~196 KB of source, so the
     -    deletion of that file has to be split across several commits.
     -    Carving the four smaller files (the LICENSE, the README, and the
     -    nedmalloc.{c,h} wrappers) into a commit of their own gives the
     -    malloc.c.h-chunk commits that follow enough headroom to comfortably
     -    fit under the cap once email-envelope overhead is accounted for.
     +    The previous two commits stopped opting into nedmalloc on Windows
     +    and stripped out the build-system plumbing that referenced it; the
     +    compat/nedmalloc/ subtree now has no callers and no consumers in
     +    the build, so retire it from the tree.
     +
     +    Logically this is a single deletion of compat/nedmalloc/ in its
     +    entirety: License.txt, Readme.txt, nedmalloc.{c,h}, and the bulk of
     +    the subtree, malloc.c.h.  Unfortunately malloc.c.h alone is roughly
     +    196 KB while the Git mailing list rejects messages over 100 KB, so
     +    the deletion is artificially split across four commits cut at file
     +    or section-banner boundaries: this commit (the smaller auxiliary
     +    files) plus three chunks of malloc.c.h cut at its own top-level
     +    section banners ("Overlaid data structures" and "System
     +    allocation").  The split is purely a mailing-list accommodation,
     +    not a logical separation; the three follow-up patches in this
     +    series carry "to be squashed into 3/6" subjects so they can be
     +    folded back into this commit at integration time, per Junio's
     +    suggestion in
     +    <https://lore.kernel.org/git/xmqqfr42fw30.fsf@gitster.g/>.
      
          Assisted-by: Opus 4.7
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
 4:  95682cc2c6 ! 4:  9085f00910 mingw: drop the first chunk of compat/nedmalloc/malloc.c.h
     @@ Metadata
      Author: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## Commit message ##
     -    mingw: drop the first chunk of compat/nedmalloc/malloc.c.h
     -
     -    The vendored malloc.c.h is around 196 KB of source, which does not
     -    fit in a single mailing-list-sized message; the deletion is split
     -    across three commits cut at the file's own top-level section
     -    banners. This first chunk ends just before the "Overlaid data
     -    structures" banner.
     +    to be squashed into 3/6 (chunk 1 of 3)
      
          Assisted-by: Opus 4.7
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
 5:  a605b58586 ! 5:  fa28d50d18 mingw: drop the second chunk of compat/nedmalloc/malloc.c.h
     @@ Metadata
      Author: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## Commit message ##
     -    mingw: drop the second chunk of compat/nedmalloc/malloc.c.h
     -
     -    This is the second of three chunks splitting the malloc.c.h
     -    deletion (see the preceding commit for the rationale); it picks up
     -    at the "Overlaid data structures" banner and ends just before the
     -    "System allocation" banner.
     +    to be squashed into 3/6 (chunk 2 of 3)
      
          Assisted-by: Opus 4.7
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
 6:  90d4137018 ! 6:  6e0fd5182f mingw: drop the rest of compat/nedmalloc/malloc.c.h
     @@ Metadata
      Author: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## Commit message ##
     -    mingw: drop the rest of compat/nedmalloc/malloc.c.h
     -
     -    The third and final chunk removes the remainder of malloc.c.h, from
     -    the "System allocation" banner to the end of the file, and the file
     -    itself. With this commit the compat/nedmalloc/ directory is fully
     -    retired from the tree.
     +    to be squashed into 3/6 (chunk 3 of 3)
      
          Assisted-by: Opus 4.7
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

-- 
gitgitgadget
