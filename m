Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418221DF733
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 14:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744124137; cv=none; b=XZfMupovgCy0K0cF0R4Rr08zZD8iGv81oldjJ4Z3WW42JGDsseWshBuWNtL5jii5WOQoF0FyxfEvVUhEKDmrjJA7jCuEFRV0kIUaB90djHfWvUCO0NwH+r2pU42ZTvA+hRuQfIbXf85pt/dsHixAVTboLGHJXdI3UvfCtGzvBjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744124137; c=relaxed/simple;
	bh=F3Q69tFNbGxg+PEJ9V5jxC52Sl7UYCWNVH5idkt2h20=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U/lUd0+EW+0Pc9luk7qVx9lkxbIGy3YQdsF9SrfporuFxn9VUUzt5a9LCHF9H42cH23RoMKMDgsNbUGonp3jXFJer56ldwiaSfP2l4s6AHLRjOdcYkZvNOorwrI4T/aU0PRA5WtHVrCS3pLO6jGC4dE5C0eTqIOEehQ9mpm4xfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CvSNkpcy; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvSNkpcy"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5eb5ecf3217so9771497a12.3
        for <git@vger.kernel.org>; Tue, 08 Apr 2025 07:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744124133; x=1744728933; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6gd24CCdItEBTAAHxOfC6kXtEz1iXDr1nDOlouqc/Ro=;
        b=CvSNkpcyZiSHSCjihsvEh2BEy2IeLJVsQatLnxA12b/dMatHfVoyijz3ImgHLOdwRk
         8do4WuSVgfIuH4r8iOxY3boTQ7RAeqWu9PUaQGWjmU60dDukus1yC2KOGasHe+zDttiv
         8zZ60zJ1nUYA+bszNRIFES4MFgG0a5Q+CkgzEFTfk+TdzvoysmdBlXpSUEzkxsGP06gf
         Mg0xcBkrlB3MGzWbFr68zgqgeTy1IPi9SBQuPryRGL9AdvXK6hS00jQIjOT3k49XBy6A
         k+B0mdybBVUVF/RQ1e8A/tY4rZVx2h1Azg+C/NNb0zkyrtPI98YPgAKWmn0PkQS9UtnL
         WRHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744124133; x=1744728933;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6gd24CCdItEBTAAHxOfC6kXtEz1iXDr1nDOlouqc/Ro=;
        b=E7e2oZGDis2YAkAidv1cnUo5U1rx0VJESRBRXYRIVwmTZMhEcHKORBCl3hOx36jv04
         XYWV2D89wCxTZRUk7f7t/gqJuTY3an2lvCJD3bQDzAtcvpyQAcELaHykOp2vxhq+JQsP
         m+Q5zKPyRw+35srHoOMwQ3THuAWR462uAsANM8hLHxyTh2dQyVcfXWtAtfW7EXqd2pnI
         APn2rGfIsU6SQSJKMIVI5kl9GcEqGwYFUN8oD/xgaF+eU3+c/PpXFDYxetm0FyHXN9/2
         gb1xpEXDbcPsALr9wMg8cvx0yseb48Kh9pwYFNMHHm9vc8StJLCR1ZJU2zb49uunM2za
         g5vw==
X-Gm-Message-State: AOJu0Yymu3kjZ6/ugnEB6aXMB8u5NorKQlwAcuzcmd2iIJkbzTTGy1/G
	UAV0ggOlKpKVMEIHCaCsVu/MqHBF+8jB15rzf4eY3w6TWy7mQSxefC3c3IoM
X-Gm-Gg: ASbGncsQGPSpSE6f/kHcvtqLqZO0Wgb3A46fLVcOpSuv+KZtTNvenLWI+53n3A0iTH8
	6gThSw8W9JfrftwcQsauE6eaAVETid+nTARKo0U5kuTOomL1MACPbZbf5OE+SSh+yMUeRNX51kD
	D0Gi9nzfGs1KrOgeCKHaEemUxDqkBzE1AO3c0bArkk0mi4jWq4NtRTmhk10GUvnXpI/24zrf2dw
	UCqGTdbx9R66A1uiDTFgSft6jxtuI2H0fx68/nr/cUxBaMBJCJkWE86aN4ETBFmDAHqoFIDSHmK
	i+Qg9wsPE5lBR7TIOlBnrFxQXI/byMeWppT3Yy2kW8JY
X-Google-Smtp-Source: AGHT+IG9+yhPZ9/vwLCPo1tvzfEAilSZ1XdiOKZLTVXKQP5NnP8i17tISZSBf3bEyOHDm00ggjtJfw==
X-Received: by 2002:a05:6402:5c9:b0:5ec:9e9d:486b with SMTP id 4fb4d7f45d1cf-5f0b3b65d7emr14181618a12.7.1744124133092;
        Tue, 08 Apr 2025 07:55:33 -0700 (PDT)
Received: from [127.0.0.2] ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f087ed1c68sm7905678a12.17.2025.04.08.07.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 07:55:32 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 08 Apr 2025 16:55:28 +0200
Subject: [PATCH 2/3] meson: move headers definition from
 'contrib/coccinelle'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-505-wire-up-sparse-via-meson-v1-2-17476e5cea3f@gmail.com>
References: <20250408-505-wire-up-sparse-via-meson-v1-0-17476e5cea3f@gmail.com>
In-Reply-To: <20250408-505-wire-up-sparse-via-meson-v1-0-17476e5cea3f@gmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com, toon@iotcl.com, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2964; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=F3Q69tFNbGxg+PEJ9V5jxC52Sl7UYCWNVH5idkt2h20=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGf1OOK9RUjHKtjytchCPw0Ma4kXxUZMCBS03
 QZfwKoPuZ7KvokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJn9TjiAAoJED7VnySO
 Rox/+3gMAIfKqdulMnoOwofAsVYAcanEtZ5xKvmFYmGMJoo86bn1X1L2sgohitzxD2KbJ5k+Rg1
 lI2X3GQ1hmj58YeeOnvMn0946t5X6BThMqeQXjdMhjmA4Dy4vDfCLYXNMYp/m9ADoDwcF4KrOSP
 jQKicqmYDxjqQziuGaSR8IgDDvM+M+7PU78FGVrKzEUn8HZxKqNryS5Q9L1EwFFA2JV11X6WBQM
 MnLboCCktvCvposK3GNhgsFqrfDFBto4jYLlRnU2byuyDYpsZh7GwZH7RTRCf5EOQTWE+BxBUbF
 u8MdDLJIdFJZxwWkz9B3tTaePuy0XgC1qIx4QUSM0EKer+i4LhbfRYZ0CecQM/vgSJJGqOkph9i
 cicwCq8o6sOgJgisyBZMc+JL2m8Rxj/g5eN71pAfv+tV68dTQDaQSgjCwuzaTmkNHULv2SoHQd0
 GIgdFS/STg5xRG94ZseMZOhAe/Bnb3OpyH2aZe8eMwEz93b38+0jrpj+CUi8n5jJ162INv/1Oj6
 Qw=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The meson build for coccinelle static analysis lists all headers to
analyse. Due to the way meson exports variables between subdirs, this
variable is also available in the root meson build.

An upcoming commit, will add a new check complimenting 'hdr-check' in
the Makefile. This would require the list of headers. So move the
'coccinelle_headers' to the root meson build and rename it to 'headers',
remove the root path being appended to each header and retain that in
the coccinelle meson build since it is specific to the coccinelle build.

Also move the 'third_party_sources' variable to the root meson build
since it is also a dependency for the 'headers' variable. This also
makes it easier to understand as the variable is now propagated from the
top level to the bottom.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 contrib/coccinelle/meson.build | 17 +----------------
 meson.build                    | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/contrib/coccinelle/meson.build b/contrib/coccinelle/meson.build
index 03ce52d752..32568c5103 100644
--- a/contrib/coccinelle/meson.build
+++ b/contrib/coccinelle/meson.build
@@ -8,21 +8,6 @@ if not spatch.found()
   subdir_done()
 endif
 
-third_party_sources = [
-  ':!contrib',
-  ':!compat/inet_ntop.c',
-  ':!compat/inet_pton.c',
-  ':!compat/nedmalloc',
-  ':!compat/obstack.*',
-  ':!compat/poll',
-  ':!compat/regex',
-  ':!sha1collisiondetection',
-  ':!sha1dc',
-  ':!t/unit-tests/clar',
-  ':!t/unit-tests/clar',
-  ':!t/t[0-9][0-9][0-9][0-9]*',
-]
-
 rules = [
   'array.cocci',
   'commit.cocci',
@@ -61,7 +46,7 @@ foreach source : run_command(git, '-C', meson.project_source_root(), 'ls-files',
 endforeach
 
 coccinelle_headers = []
-foreach header : run_command(git, '-C', meson.project_source_root(), 'ls-files', '--deduplicate', '*.h', third_party_sources, check: true).stdout().split()
+foreach header : headers
   coccinelle_headers += meson.project_source_root() / header
 endforeach
 
diff --git a/meson.build b/meson.build
index e98cfa4909..790d178007 100644
--- a/meson.build
+++ b/meson.build
@@ -633,6 +633,28 @@ builtin_sources = [
   'builtin/write-tree.c',
 ]
 
+third_party_sources = [
+  ':!contrib',
+  ':!compat/inet_ntop.c',
+  ':!compat/inet_pton.c',
+  ':!compat/nedmalloc',
+  ':!compat/obstack.*',
+  ':!compat/poll',
+  ':!compat/regex',
+  ':!sha1collisiondetection',
+  ':!sha1dc',
+  ':!t/unit-tests/clar',
+  ':!t/unit-tests/clar',
+  ':!t/t[0-9][0-9][0-9][0-9]*',
+]
+
+headers = []
+if git.found()
+  foreach header : run_command(git, '-C', meson.project_source_root(), 'ls-files', '--deduplicate', '*.h', third_party_sources, check: true).stdout().split()
+    headers += header
+  endforeach
+endif
+
 if not get_option('breaking_changes')
   builtin_sources += 'builtin/pack-redundant.c'
 endif

-- 
2.48.1

