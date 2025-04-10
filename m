Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AF32036F3
	for <git@vger.kernel.org>; Thu, 10 Apr 2025 11:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744284648; cv=none; b=Bt9nz8HrGOlBuKJ8ExM2fEqdN2mAe1/TasXxY6PASiVY/UMeAkJvZzsOjZjYrUIMESvt2I3ktCBqDk55h1IxISnP2fPEil6D7gXeKtEyrVgvlmLqTkSKMVDtHfyRt8RjbpjjNaq/U9rY+9KFjnArC8FUTLyDqHvPIaCF1vmb3HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744284648; c=relaxed/simple;
	bh=J8O9rrams01Csgw/7vq5iZTBem3U6Zt34kMbZrSDvlE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KTwMz+eomU/DCIA9bH6eDT9E0jz/NqNa3ZyEr6CF5K6mLQssyN8Mtb1VnQjyy2mieG/OwQXq8sXWz76AezKYEpJPrEqgxaE7DGXNhC33dq1MDKioa5ubLx28IDGN4w4a4mj392cnTXi0R8czwhOif9FTq+nOza1a2BRnQ/cGQWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ftGLvHyW; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftGLvHyW"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac6ed4ab410so114469666b.1
        for <git@vger.kernel.org>; Thu, 10 Apr 2025 04:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744284645; x=1744889445; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BPYIUTzXbL7bnFS4trC/BMzpOR1dg3sH9m1g0Ym/Rl0=;
        b=ftGLvHyWhNLgm4NqUsxuyK9g9T6Wri6tLfS/JRaYspbUXdRxGEKVm24LsWZiOt6A0m
         fmD+3WpARXf/ZIMUPBxLN8YdrUvTun/dLQxlZppOyvy38X25C4/G3F2Y50t2heBA7g2z
         YhBnCm+cXgNpzIlhPF00LaKSpjPV0zN7BYL9JaIPC4qC3hYRngHWqKe7IrAOsheFuzSU
         h420noI5wf7lZDr1K7oT5XKI+RsB611fqZtjSpN56I7dWeRepw6pXDRYwKZPAq4etugc
         0lKquPNTLR/De6JOmfaFKB6LKyqIUVaYvSHatdmgFtB5LNUAJ5dyUF+1g1c+P3rIRBkU
         ynOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744284645; x=1744889445;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BPYIUTzXbL7bnFS4trC/BMzpOR1dg3sH9m1g0Ym/Rl0=;
        b=qeu6OKgITKeZ668a1fIqf1JCPTHwiyhx95/a0g9F/zvlqYq4XHIdHaWqkPNaeDwUPo
         HgceZgZTz2FGtJTYZlAPvR4NiCLKNdgkxdyMoOc6Bo3isETxFUSkCyWClt0PgHEm4fqz
         Y7xKSeY9fhN9pN06CCAMtzPwMG3GBZqATF1WCimE4Taw8+ET6omJNQTD/uxlOpUSZeNm
         HU3E+TtwYmgOGt5nHvgnSJM5MrmJDwMOI5TITdWmpRMGvTNxzKj/O2/P0u6NKAz1PlOL
         AnBjQK6hsGLND5Q1sDQ/msHTUoc++xSOCF0C2nSyq+vJs+iSgCZYfgj5X8dU0fp1CWNe
         ep8g==
X-Gm-Message-State: AOJu0YxLI9pV7mlCcqy/xSVUn/mu8gYVkO/WNyqVm0QmYgUO3ayhAj91
	E849DG8Qc3pdGjOQG3Ewfxp7T7QUu4Mk/2RZKTNKNLsFMKJoE75KQKfIQ9Fr
X-Gm-Gg: ASbGncuflMa1ZG1cr0VRjbVR1+ElYgmMxraNyxL3lcOmKuKDCg+FEGUUs8MzVz6lBCv
	95GWip17tJRHvHVXUpcVHCaEaKziucULlUwnenw0Y/9K+Unt1921u0wAc3Rxcgy+iK1RxDtOrAe
	oYqL5Wb3hSKXTK5UvYY8XG+4obFnIvsGHXmPW0HhVMLroYs+V/zWRnhsZnLvPJManYlxceDCCLD
	uU2Ey+PTW/btwGRUiBNfUTwCcp3cPVNuzvSP197u5W6oV9pmsLxe0gUSXqQGNSRE5xpR2D6SfLb
	5rxFYuWlde2w0HPTR4zHFHhDdwZP36dBcXJyt9uEH0sL0A==
X-Google-Smtp-Source: AGHT+IEwcfhdR0sjHwPYo3qe7f0+br/mFO7OQtPfFQXo268gkL0+puue8l3xHM3k86nIlFQCMeglBA==
X-Received: by 2002:a17:906:4fd4:b0:ac3:49f0:4d10 with SMTP id a640c23a62f3a-acabd3ba5b9mr203655566b.38.1744284644634;
        Thu, 10 Apr 2025 04:30:44 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:9936:e3af:b877:72d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1bb3553sm260230666b.29.2025.04.10.04.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 04:30:44 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 10 Apr 2025 13:30:31 +0200
Subject: [PATCH v2 1/4] coccinelle: meson: rename variables to be more
 specific
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250410-505-wire-up-sparse-via-meson-v2-1-acb45cc8a2e5@gmail.com>
References: <20250410-505-wire-up-sparse-via-meson-v2-0-acb45cc8a2e5@gmail.com>
In-Reply-To: <20250410-505-wire-up-sparse-via-meson-v2-0-acb45cc8a2e5@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, jltobler@gmail.com, 
 toon@iotcl.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1987; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=J8O9rrams01Csgw/7vq5iZTBem3U6Zt34kMbZrSDvlE=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGf3q+Ikh+xfSFSM14rEY0XUBGcBnSChOrBRL
 UF16DUQhH7A/4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJn96viAAoJED7VnySO
 Rox/5jcL/jbbhMifpqQAAUDxn2t9Fl2iTm/I7lWPm/M5kCigZSOWJ4T+u1XO8nMLX9pUfHiwBs5
 AnqZ5KLtkrVN+x/rXhipa7threm5PdhsnQogcYAIEhlfwSHfJjoan/e6JUGPJ+XrYMypNTi1db3
 X+21N4q94cqhr8Q9kPiktk5QX2amcBk7s7lghO5KxyrIx54x1HxxQ0AAyO7E6BrG4vUyYZ/Z1Tm
 gB6doZgJBJDM0dlOTnQX2j+83WQH//p8bmeJBMjLt+NAgSxvLaMLcJJHwTscu7YGZNw0N8y3dgO
 6ptUyBqsMGXdSMGWyb+CZx4tZH+xp1roqnbPUUIyzZP882Gvz/AXIQ/ePA8hzCK0SDwuZxuklfT
 J3pxRDtsBaaO41criCraJc1yBhE3H0DWII4wCtxBxS/XZ6yX47TzyofpvFkKwVTAAkn8wZo68v3
 ZxA5z6HduNXy0PBGLQ4qw6vRwKqlhawU4fLU8XN90Sz7UizYIFtvmwbKy2F16sSd8miA04BuzB4
 9A=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

In meson, included subdirs export their variables to top level meson
builds. In 'contrib/coccinelle/meson.build', we define two such
variables `sources` and `headers`. While these variables are specific to
the checks in the 'contrib/coccinelle/' directory, they also pollute the
top level 'meson.build'.

Rename them to be more specific, this ensures that they aren't
mistakenly used in the upper levels and avoid variable name collisions.

While here, change the empty list denotation to be consistent with other
places.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 contrib/coccinelle/meson.build | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/contrib/coccinelle/meson.build b/contrib/coccinelle/meson.build
index ea054c924f..03ce52d752 100644
--- a/contrib/coccinelle/meson.build
+++ b/contrib/coccinelle/meson.build
@@ -55,18 +55,18 @@ concatenated_rules = custom_target(
   capture: true,
 )
 
-sources = [ ]
+coccinelle_sources = []
 foreach source : run_command(git, '-C', meson.project_source_root(), 'ls-files', '--deduplicate', '*.c', third_party_sources, check: true).stdout().split()
-  sources += source
+  coccinelle_sources += source
 endforeach
 
-headers = [ ]
+coccinelle_headers = []
 foreach header : run_command(git, '-C', meson.project_source_root(), 'ls-files', '--deduplicate', '*.h', third_party_sources, check: true).stdout().split()
-  headers += meson.project_source_root() / header
+  coccinelle_headers += meson.project_source_root() / header
 endforeach
 
 patches = [ ]
-foreach source : sources
+foreach source : coccinelle_sources
   patches += custom_target(
     command: [
       spatch,
@@ -78,7 +78,7 @@ foreach source : sources
     input: meson.project_source_root() / source,
     output: source.underscorify() + '.patch',
     capture: true,
-    depend_files: headers,
+    depend_files: coccinelle_headers,
   )
 endforeach
 

-- 
2.48.1

