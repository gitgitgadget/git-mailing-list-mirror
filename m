Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65BE2063FD
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 16:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754065721; cv=none; b=uoEX3wWpOYFTpL/nmtXZ0V3VYBaSF7N2/00NqYCZU2b4ilBUAgg1bRjriMpZXWMrtsPYfplYhT8YugzKcrhUu6SNqzzWzeycPb5DSSoh1y7ThthSY6a5ziFI6vtjLTC8yMmsKB+CPhjMB2uucMtNUgVmQY7LAnQ44i9+aMwkHFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754065721; c=relaxed/simple;
	bh=QWqYWa8zrPD4Dc0MOZ1H8BFE87gAogcS5ZVkuLlw/ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GwzFWYmO3uzXnHpjfqQ0Q9sKwPbL7q9kQIabqP+D+GH8OtWbenfNOCWdN3prL/hG75OXoufC0M0ZnFXWmPN0D9Py8URRLkNcqHTR/lnIK3AT86gaxbHEe3770KwdZIx0QEWd6t5mH/yDVP4yWNnhwdtRCcKQuMFd5qJBjHRBR+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=martin.st; spf=pass smtp.mailfrom=martin.st; dkim=pass (2048-bit key) header.d=martin-st.20230601.gappssmtp.com header.i=@martin-st.20230601.gappssmtp.com header.b=XpFLSg1+; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=martin.st
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=martin.st
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=martin-st.20230601.gappssmtp.com header.i=@martin-st.20230601.gappssmtp.com header.b="XpFLSg1+"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-553d52cb80dso2415282e87.1
        for <git@vger.kernel.org>; Fri, 01 Aug 2025 09:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=martin-st.20230601.gappssmtp.com; s=20230601; t=1754065716; x=1754670516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B/yHlMaUzOJnvLbiM8goKlQIbT3HJZO70k5m5qDjuIM=;
        b=XpFLSg1+zk1lbdxcBlcDSqMiygB4N8hOXL7jXxFRXb+bEhYoXV2FwljJ+cWa29KfZT
         WY4pf/tcrhgP2q6EqXZQN8hDxuQquzxWzwEo8gSJjDhNAN6O6tQYYru3KNEYj/wBgJd0
         Txs4kFl1WfxY9F3S1eFjPT9nDgkKLe350gtQFJHX3qWOEgYbiETbfyVN+y0g0qANUMkJ
         voTNuloWuwP+B/auK9M49t5LM2z6crbbSkz0XvIssHNONlswLxflxssvuyvfCA5XPYqa
         eGnFlIvCIO/hyIrb7vDe6psuIaEnmh7lhDq5DJXcuoBw0oMzPvBA09x5aTKrOuJnU1q9
         hJLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754065716; x=1754670516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B/yHlMaUzOJnvLbiM8goKlQIbT3HJZO70k5m5qDjuIM=;
        b=XjyDDVVixq5zxLmd6FlnNM/D/W5vWjA9CqT7p4UUHZQ+q6CUmGZBErEJhou9JH5rLP
         IRvlUshcHJaTqNXfx/Xc0UbGZDrVAxPSChLK8C1mWNR+MREh6WAHlGTy3tI4irCakOza
         AkR+lNQ9JKFmSxVey1mqM2xSXaNMaWHW062Z3y+Ow4xR5VHeAZtD4MmPISCgcwWZSD7R
         p0NCI/4Mlm0IaPF33OdPbrY+Eb2XSo47V+OWszC12iKgJRHpab5m0rs1ghjgtrZGW+Uk
         UXngvB2x7+Bj6Dx1B0WKQUrJYBVC59LXaLL/u5AhzOLmbADeAx0FQiKMb8fu7XfFSBS9
         QM8Q==
X-Gm-Message-State: AOJu0YyaaVqJFRO55JhaB+AtE8zXGXYo8YHZ/Hly8w+4sC6BZ1Z5wYFV
	iQMIOMWYewpAJZOFrl7lnewC7F6vgXbicbeoAT/f8VfhkZ6jb/H8khGeTRGFoKfmbdbb2DLtKvp
	X62ZypjKG
X-Gm-Gg: ASbGncscHjwr7LQepddySuupaPGeDFUUfUWv5Chta13gQTm5Ppj2zbH7gbjh3i00DoP
	dEtyj0bGanE28h1jXvWDKZHzxnxLmMuPlRxnTw258ODFY92kPec5XZXxFMboljFJuDaw5q6JK8H
	ZKMp7w7VoBxo7Q0fwqa6BneNEmf83D+LXizdtKEHZ9gkukYEjc3VmEuHKT/FPIt8Ljxe9jEoN3n
	JM25tPTJ4rHvEYbKuYkMM9NmHT22dve3jq+fAJslKYj2W2iCnskljnfTN+UkfLYoYmLYQmz9KoK
	c1VrubFuB67vFu9fhJNvp5f0IJVpbiUOLlkCFR74pRJ4NNTr+IyJ9ZOypiQcl7vVI62Knvw+jt4
	a87UOnF6ox2j2Z2EqWTsVGLlAX0UutkCHZE5Y+8NhMojXfmOOG1tMlDHMBKgfqEWj
X-Google-Smtp-Source: AGHT+IG/WasDmifz7gAThfcQOsP9vtbDiNDhfsefE/Z5myyoermFNKEaTdxm3UNGuGvO+iT+NGT5cQ==
X-Received: by 2002:a05:6512:1188:b0:553:2154:7bcc with SMTP id 2adb3069b0e04-55b88c8efc0mr2241832e87.20.1754065715749;
        Fri, 01 Aug 2025 09:28:35 -0700 (PDT)
Received: from localhost (dsl-tkubng21-50de30-198.dhcp.inet.fi. [80.222.48.198])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88cabb7fsm643636e87.146.2025.08.01.09.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 09:28:35 -0700 (PDT)
From: =?UTF-8?q?Martin=20Storsj=C3=B6?= <martin@martin.st>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v4] meson: Tolerate errors from git ls-files --deduplicate
Date: Fri,  1 Aug 2025 19:28:14 +0300
Message-ID: <20250801162834.1923702-1-martin@martin.st>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <8d86fb70-abd6-1a9d-f5cd-ad4ad7aa8e46@martin.st>
References: <8d86fb70-abd6-1a9d-f5cd-ad4ad7aa8e46@martin.st>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When using the Meson build system with versions of Git before 2.31,
that does not yet know the `git ls-files --deduplicate` option, one
can observe the following error:

    ../meson.build:697:19: ERROR: Command `/usr/bin/git -C /home/martin/code/git ls-files --deduplicate '*.h' ':!contrib' ':!compat/inet_ntop.c' ':!compat/inet_pton.c' ':!compat/nedmalloc' ':!compat/obstack.*' ':!compat/poll' ':!compat/regex' ':!sha1collisiondetection' ':!sha1dc' ':!t/unit-tests/clar' ':!t/t[0-9][0-9][0-9][0-9]*' ':!xdiff'` failed with status 129.

The failing command is used to find all header files in our code
base, which is required for static analysis.

Static analysis is an entirely optional feature that distributors
typically don't care about, and we already know to skip running the
command when we are not in a Git repository. But we do not handle
the above failure gracefully, even though we could.

Fix this by passing `check: false` to `run_command`, which makes it
tolerate failures. Then check `returncode()` manually to decide
whether to inspect the output.

Signed-off-by: Martin Storsjö <martin@martin.st>
---
v4: Clarified the affected span of Git versions - no changes to the
patch itself.
---
 meson.build | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/meson.build b/meson.build
index 9bc1826cb6..10a6dbc639 100644
--- a/meson.build
+++ b/meson.build
@@ -694,9 +694,14 @@ third_party_excludes = [
 
 headers_to_check = []
 if git.found() and fs.exists(meson.project_source_root() / '.git')
-  foreach header : run_command(git, '-C', meson.project_source_root(), 'ls-files', '--deduplicate', '*.h', third_party_excludes, check: true).stdout().split()
-    headers_to_check += header
-  endforeach
+  ls_headers = run_command(git, '-C', meson.project_source_root(), 'ls-files', '--deduplicate', '*.h', third_party_excludes, check: false)
+  if ls_headers.returncode() == 0
+    foreach header : ls_headers.stdout().split()
+      headers_to_check += header
+    endforeach
+  else
+    warning('could not list headers, disabling static analysis targets')
+  endif
 endif
 
 if not get_option('breaking_changes')
-- 
2.43.0

