Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B67238159
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 10:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754043961; cv=none; b=nN2AqhGgYqj3JnesBVWTu1vPheTzczg0Esh6FDjz/PcNTxlAoRA5F0s8ov0ZPHCiJEBso7tpg5ZXmik11PRid9SMn328WEp2EAkuAXkBB0FrjxXkfnbHa+51dKh0LxRaW7oIVvW91/p5wPIGDM2ibZqvAjU46IZKbSHdSpRhKoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754043961; c=relaxed/simple;
	bh=JiFjATbhucDIEPQn8CrVbHdQPZ0JZW6dzfDKmhHA7L8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uBUyDUuvN9/OtBsswIQuWO22GxIt/5HtILLP4BKHR4ZPF5sNtCZKQ60XtLtqM4Vw9AA4OxuezgaLQ6wm6ZZdIX3OyWFez7Jlc/VG8G0sN33Np4PImVaEqFc4nRKeAg7tVS1UKK6lk3Q5w+Ls8li62rLpOcaPrqp6IHmJO9SxLTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=martin.st; spf=pass smtp.mailfrom=martin.st; dkim=pass (2048-bit key) header.d=martin-st.20230601.gappssmtp.com header.i=@martin-st.20230601.gappssmtp.com header.b=n7SXw19z; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=martin.st
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=martin.st
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=martin-st.20230601.gappssmtp.com header.i=@martin-st.20230601.gappssmtp.com header.b="n7SXw19z"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55b8bf653dfso950928e87.0
        for <git@vger.kernel.org>; Fri, 01 Aug 2025 03:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=martin-st.20230601.gappssmtp.com; s=20230601; t=1754043956; x=1754648756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0pSe+5OlEsPGU2mSzKGCVTK5GY2HmoNMK0RqaAqfPgA=;
        b=n7SXw19zVWlySlCeJ6DJATthzwpimDrXEO4YvMXO8McVOo1NxwUoTYeV6DuTVuFSS8
         8kPiMFSm+cBl6AodklObc8GPeJd4+6u3fg4vk0CYN33OIwjWdkQhXT3dAatCUUoDpXhU
         1/BpmbxU7dZIuGMLRG3N+rcVty372BWWQPBVom1v1pR7ZN6oYukplVKbQoTMBJiOBoU6
         DsM2vem1Lp3HmEreS9ZWP9Za4zQjqTG2tJmp/JE0agdTCCKSF6PZGsx/ngD3cDLFPmfq
         oE4C1crn8FpDPzanuXMZgcvJQlNHZsJn7gxiCci/lQhmodJuN/Q4iWLbIA6HHk7ELcVs
         d00w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754043956; x=1754648756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0pSe+5OlEsPGU2mSzKGCVTK5GY2HmoNMK0RqaAqfPgA=;
        b=sptdbV+C1ZJsdXPa0STScKWhdG1Y0zQXsE8tWK+o9Dg28M8qBRmqbtyhV0kwWHJ8yy
         poHwIx4+ihr3hLbLrJPcAYT8VQm30+RwvNB2A0BfXnA32zahhQ0ZPYxXnxLip5tSM9jv
         kxNjZUc8yp1PmCzbpl2T61XQzY5xgyAt+mQWyWzn0PdiNYoA2JrjWjbq1jnK6DHErdo2
         NwoB4e/HD03ifIhcNbxvropgPe4zWGxw5/X4dwIn2bZK1v8eLtQRuhzmqv1EcOcu2blb
         WM8bpbcK4QAhTTMQzCaWYbc25Htc3pxqgCtFBNsm4tMfcYTPGObfWwBNnLY5JctiFVfl
         DAwQ==
X-Gm-Message-State: AOJu0YwpEx1/OlypXF2Vl6UuIyxN3F9j/+kvILwfDDX4KF24zqkd9UDm
	l1nNK+xL72kXyaHSLxjFApsdWak6WSCqMnLsCoCPfQUzdKMtLemA6Tuc3WwrhUxwnlsfv0W3r8C
	sT7XT0XdC
X-Gm-Gg: ASbGncsKKwWoKoMoEILNQNU5zhBCgBnnnvkiD2zr4IdEJGB2jHjI5m6JZaoSG7iL2Ii
	glJoCC2LTG0i3p9O8lggPd+26494+h5202s7g2FBfWfpA3jJvzN6aDLQNq/AlhBjLGIOVLJcepr
	p6Fa5e0z5mmixk/DWKafDhZNtlbGvG6wfa7nrdWEJ9j4R5Cmh839WONap7WzVJ/SwFY6hhSmsDe
	MaIH1AzKjrlKZplBBsEacMerN7f3+5UTQURECvTG7i64Z1fxfytFH85GInZLBsiu2aeY3xCoPen
	XqkAPBRY0MiGs6Xj00FRYnPAdVYWg6us8gkaUyMxYS2edwLLIq7hHLB6/9TdzLwpQZg7Nol0+Tu
	9NppaEjpkjwunNDphmYKwpyN9LqBHQFaeiaB/D7O+MQMYkaRKbkjuK1VrwI49mvDY
X-Google-Smtp-Source: AGHT+IEebaDB9QCNnpFEZCgS0VrLIQDYmL84fYyM/xYFi4OyVg4aDUY3TOp0JPUghQuAtSZ7g/1QFw==
X-Received: by 2002:a05:6512:3e04:b0:55b:8540:da4a with SMTP id 2adb3069b0e04-55b8540dc5cmr2370337e87.13.1754043955719;
        Fri, 01 Aug 2025 03:25:55 -0700 (PDT)
Received: from localhost (dsl-tkubng21-50de30-198.dhcp.inet.fi. [80.222.48.198])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b8898bbc4sm538211e87.15.2025.08.01.03.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 03:25:55 -0700 (PDT)
From: =?UTF-8?q?Martin=20Storsj=C3=B6?= <martin@martin.st>
To: git@vger.kernel.org
Cc: ps@pks.im
Subject: [PATCH v3] meson: Tolerate errors from git ls-files --deduplicate
Date: Fri,  1 Aug 2025 13:25:41 +0300
Message-ID: <20250801102554.1904715-1-martin@martin.st>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <dff715f2-9d26-148-5046-6b7190b9414f@martin.st>
References: <dff715f2-9d26-148-5046-6b7190b9414f@martin.st>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When using the Meson build system with an old-enough Git version
that does not yet know the `git ls-files --deduplicate` option one
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

