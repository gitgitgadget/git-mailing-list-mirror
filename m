Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2D71FA272
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 07:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754035017; cv=none; b=iCh9p2aaz2xkZRIoI/OPIHYTIFLx8KB/0AJpiFt6X0vW88K+2QI09HVn76Zz60Ru1pkm8a4JGFCFOlpUV0VrDDO+PAIiikgzmY5Wq41CS/P1JGN+Q6dxT1+3X8mdKNVMj/aiBO3cM2v+fJhGo11mmQfPzZpNwYJqqD+qissRHEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754035017; c=relaxed/simple;
	bh=jnzvBvS1H7RJrnDMkCN8J2vBtvR8FXZ0R/k9aoSaXWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G7kNwsQ19Grfohq0nIwBWWLR3pg0kURh+hOqD3Y8ALtY22S0hNS7hDlcfaRl2G8xEko05WccgzCutR1oB4r+Mj5s7gADs501shpx86yB2J0ldxzTIj0WaO+Kko8eqjQwyGcwqwTZ1UASaro3rkWgkStV/7wNzMRKLLN3OdFgOSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=martin.st; spf=pass smtp.mailfrom=martin.st; dkim=pass (2048-bit key) header.d=martin-st.20230601.gappssmtp.com header.i=@martin-st.20230601.gappssmtp.com header.b=YzdUivih; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=martin.st
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=martin.st
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=martin-st.20230601.gappssmtp.com header.i=@martin-st.20230601.gappssmtp.com header.b="YzdUivih"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-54b10594812so726700e87.1
        for <git@vger.kernel.org>; Fri, 01 Aug 2025 00:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=martin-st.20230601.gappssmtp.com; s=20230601; t=1754035011; x=1754639811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sscwojku/NRzvhjpkdcQajrB3jdNy0WubhQ6SEU3/z4=;
        b=YzdUivih65qRDPqJAWk2owC/IRBaPXc2mhOTgZbSLxHCTLjRPKNq71BN28vTi0OTLy
         dX9ZbFftv1ubK9paEbDP/hGPcZVx5Z4tdRMxFst/J3wvZLa882fm+2lxlaeoZxWpkCUJ
         pPWwl7GZu11ntpvPrrwM3fDJk/jCKIjWcCQyGc/W6zwWNpSxnhCStICC5qJYYJa91Rfv
         h8jod4q/0JVeToaN8+5sqSnWoS6ZH3kcNNyr0sBxW//T4bqIkY0SESmofQxtp9fnDpTe
         sJavOG1XDg/gNvxlAQkEetEE+D6Ik3EK7mQ7ZTF1lq2hR1gkN+8fzdWeddNGm/AOXE0y
         cPpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754035011; x=1754639811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sscwojku/NRzvhjpkdcQajrB3jdNy0WubhQ6SEU3/z4=;
        b=XfWerN+aeBDF2NR24HtEmUxR1SBqEK/UVjdWX6cWEVd7hg7nPLVckqIxDkRIt1lyYf
         fyQM7HBMDSoKjEp/7fxQc5dPcLF6uYIWcOtynlQRbGlZSGIPa6nAMjHVVZPEZ4gQEDQA
         zgPY3raYBjn+DNDdXLt61BPNdwIsEaSr9KsO6K0JzU19SdyQ3nFvDNLEcGzhyBN/n1p2
         a7nUnIVCn0ILNkNFPd3Vu/n/AH8M8zMXjidDHcmW4bBieNCt2Mdi2A/PKUpV/6mmJH9N
         01/14y/9wUs31yOxKcX9X602ciPFN4F5q06x/oFW7mcj2JBuOwNI+t+KxmZVYCWW/obw
         RgXQ==
X-Gm-Message-State: AOJu0YxjT3E/n1LvPAYPpAkIxL12gsY6NKsj/0KEQBvjXTgLGWuBoNhJ
	LtZnjtYAZa3Av+0ZBwk4Wv/8gUydi4IBeQUjNRAYp7LrF354IZRO1zdzuLb9rFmDQVvp9AGo0My
	ktcURWqD1
X-Gm-Gg: ASbGncuxEf1bmUJoXgcvhLONrialkLlYNLCvWnwDB8/quh1YVXEy0X3EOr9ugiZUx0p
	0tmJN+YBf9BVPLFAK2QzkS1dvLo1HuTKODZ51jB9ZdcrBjCzMfquj4hX0YJZXMXRaGN1ICRYyki
	pIjB0iaUGxrANlZ31mkgLw/ckY0HKPH7isNSF91ZiEqHd3Romlh2vFg4jgUgtttk/BO62yz95eB
	A6hyLXfXh42rv6qM07S3GhuzTXWorM2OQqEpXR7qyLmqDLRLzf8NOt7yPSLht8uRtCu4x6W8XYe
	JD8uO8hNAH9R/PYaiTVJK0dvtXmMOOiuxoQNEDzXzeuDX9u57oJTPNaDSdwwjE8xHPsMtvaFt23
	9JLatNCxoii9GomOJn7lxO0sYXWUD3SjfW8I5rc/OAeMNsmxgfG1yIQ==
X-Google-Smtp-Source: AGHT+IEF48JPY0Jxc2jAED9JwGWMtzvcPtXdoVGDLjQreLcxgcAzDSfxytrxp1cZ2jEB+AiwV+A9KQ==
X-Received: by 2002:a05:6512:2384:b0:553:3172:1c23 with SMTP id 2adb3069b0e04-55b7c01a10dmr4505042e87.17.1754035010560;
        Fri, 01 Aug 2025 00:56:50 -0700 (PDT)
Received: from localhost (dsl-tkubng21-50de30-198.dhcp.inet.fi. [80.222.48.198])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b889ad021sm499262e87.74.2025.08.01.00.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 00:56:49 -0700 (PDT)
From: =?UTF-8?q?Martin=20Storsj=C3=B6?= <martin@martin.st>
To: git@vger.kernel.org
Cc: ps@pks.im
Subject: [PATCH v2] meson: Tolerate errors from git ls-files --deduplicate
Date: Fri,  1 Aug 2025 10:56:22 +0300
Message-ID: <20250801075649.1796238-1-martin@martin.st>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <69faab5-43d4-812c-90f-c518ff7f618@martin.st>
References: <69faab5-43d4-812c-90f-c518ff7f618@martin.st>
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
 meson.build | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/meson.build b/meson.build
index 9bc1826cb6..9b519e6eed 100644
--- a/meson.build
+++ b/meson.build
@@ -694,9 +694,12 @@ third_party_excludes = [
 
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
+  endif
 endif
 
 if not get_option('breaking_changes')
-- 
2.43.0

