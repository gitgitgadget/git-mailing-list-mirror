Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB8D1EB1A6
	for <git@vger.kernel.org>; Sun, 20 Apr 2025 13:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745155184; cv=none; b=H5BPCj3bX7Lu9DSeC8UBPesCsI7Qz9N8fj9q6tvJYFUnQjjYfFWO+bq2Q61WObssMateOYa9PFJUQ9xcCjPOTWn2Po/DhL1leoHVW2Mu9rElr+30bTnRyJi1/zNoj7+SlVjqWhvzXO5FMoPONDQ4XLWi/giLRZU0OPJUENQFJdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745155184; c=relaxed/simple;
	bh=MxCEoCgpF8FTZv/ITJGk+r4o/jLXH2CXPHnRRcj++p0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FqgivN61aIBDQCtQUH6mzhtpq1XwEctlAJ2BVJvMfNVf4r8weqTqXP6KiAwPqEreynPtxOemOfQXQybtRXkPwbn6go+GWKVMui047voPQxXvZqxeryEzuQGY5ylP384RHbWBYDhsweTqXl8IFTDrTfDlIwuSTQ+oIXr8PjnMVnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQ0CiRjj; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQ0CiRjj"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e5e63162a0so5014541a12.3
        for <git@vger.kernel.org>; Sun, 20 Apr 2025 06:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745155179; x=1745759979; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2T+9EE/FW/vUxSUNFlP1IChYz1vnkZtCLkNu/Wsx4qc=;
        b=XQ0CiRjjAAXrLS+O99r42BLX/PjwXE7zlNhm/OIo/V8sXxTc64E0nofUoA8rQy0P4a
         nMlMIgrw+NN5yeJqeYlqkHvE5xHIRwLQYfcWsgySS9mzb7u7chafDpCL/7FvLYkD+fvA
         28cCNi/xCnNOPS0Ne5uqGClOqY+Q0hUAcMIjiU8CXHIDuBtp7+YcIz9o0WKUlI2ui0PD
         AtFk1ak8kL6Z/rqLUamcZ3NyagHIn/VP2nEsY5bY+QpTMfLsaKpKnLVPlqodrkWwsB+3
         zltWo7VX4Wj1gOF1DndaxRjzyGUKn/qaanMah4FkbgMAfo8HC561pK1Pk+7gmgYl0XP3
         KDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745155179; x=1745759979;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2T+9EE/FW/vUxSUNFlP1IChYz1vnkZtCLkNu/Wsx4qc=;
        b=nATqQbcC5x7HRUaK/8K1QjjkTfJ2sIfLMJWzLlWayn6wpyhEuPReHg0RjRfQsxgHK5
         tFapR8+LM8nqe+3bp8wqnRgQJ81eIyvWkADzjAt5hOs7oE85y4evjHTFg8BbtjGSQv09
         qoHqz+rm2FPMvLa/aqdU+Ukt1+k2xPle4xvPh2hUwJAhFxaWeJ/e20x7fAZlcuw8eAlc
         IruoNqtBMWI3b/gX+AsoqGls3FozXPSGvR0RSD34iFUUPOHDkTQqjXPFUYX+zIHjEqeT
         zDlEGEGPiAtt/55lDUcBFjnOz8gpaADra/jBzboM03uydB0cOkQhxDF3ZwYbRee+6ilB
         m1qw==
X-Gm-Message-State: AOJu0YzsPuwQ7Y75Lmo4bx2Aj1TC5Z8jGlEt6yOiVK+SZ1TOMSVwFm8E
	TefPwrOgv/p7DIn03f97X5kFTYcowCHT+64N/NLamyQAwwVFntY5
X-Gm-Gg: ASbGncuVMNM7AzUG2ogp6BOwVq6L8ftgvLW5sBQF7IDflJJjRhd2PYL312EvO5biOvD
	ltdl0qKNvPthlt+/7ILqfzmkAR8cTn635SCS8DJZEm/avsvDYCxPV0LKTy6s3ixHW6/CrIsE6js
	sd4LVrTWZHIgnnJ7otrcLQAKdZFuQs/6V8V9rzYWB6BJUU5hc0hG0mZztk/VwikjEpfNkVxNace
	44w1wJlLuaeS9Q2wqA6LZ7JATZPofyXbTMVIfV27osQ4CiAWZy5MX8gOgDERG74TKTkGBkVc3C7
	2uLQU//eNsAjHRSxkQQ6MSMzQc7LpWwS9zXzf6BDVLP6xR8=
X-Google-Smtp-Source: AGHT+IGHEi3kqMMS9CHwhycfkdIarJXeGk1psp5ySqY3qP2hhgkxFzA6tV8iEym4GobGpThKR5KWfg==
X-Received: by 2002:a17:907:60d3:b0:ac3:8626:607 with SMTP id a640c23a62f3a-acb74db7dcbmr830953366b.38.1745155178628;
        Sun, 20 Apr 2025 06:19:38 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:7cb7:e0fd:4535:dd46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6eefc703sm397872566b.94.2025.04.20.06.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 06:19:38 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Sun, 20 Apr 2025 14:21:35 +0200
Subject: [PATCH v4 3/5] meson: rename 'third_party_sources' to
 'third_party_excludes'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250420-505-wire-up-sparse-via-meson-v4-3-66e14134e822@gmail.com>
References: <20250420-505-wire-up-sparse-via-meson-v4-0-66e14134e822@gmail.com>
In-Reply-To: <20250420-505-wire-up-sparse-via-meson-v4-0-66e14134e822@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, toon@iotcl.com, 
 gitster@pobox.com, phillip.wood123@gmail.com, ps@pks.im
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2067; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=MxCEoCgpF8FTZv/ITJGk+r4o/jLXH2CXPHnRRcj++p0=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGgE9GYV1TwfXWuDmKmSw+8IBwI9TYJoagGDy
 0DQehuk6XbFZokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoBPRmAAoJED7VnySO
 Rox/N8ML/1hl+AE194zkCLogwZZUuVACaER2ogEFpjJ7JiByN92shKf96UmdhxCff4xaQJpuJBP
 vI93ogB7ySi8JsWWRXbyBabMHP24PAMIF5PscANkifExNojLiTu3vJGij//kwPpNeQd5Tf4RuDe
 RddIGTR4bQ3HqvgfLQCK8jdoyN8zthbPAEYZ+JrNS0qld6zN0Newmulylx5VInjFj+F63w0BmTT
 VGDWX3FurWpQnJtQLEiXbbauo7QgPiJX0+tlLuc7Bf3c8kzNu/kbFitT+MORhhgGmcUr5Fn77mg
 9PGE4q9zrEGboToP6OlKzdqeBihZSIQKZtVgGB17aWQlDYqza4AscW5PX+eiFtb7F8Pt3myITWG
 c6y1/yGZ0UkiNdEP22mdGc3bBaSeJmQkBAL6NLpmUKTUfAifh8bQR2kJPdpbFwcm0oaxBlUxK4+
 TezwtD4IqNoCUpOkhclnQWQdITA0E0Jl5uM08+YsB1XpFaZQ8dq8VdXVli3B4jZHq5us7NBAiV3
 6o=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The 'third_party_sources' variable was moved to the root 'meson.build'
file in the previous commit. The variable is actually used to exclude
third party sources, so rename it accordingly to 'third_party_excludes'
to avoid confusion. While here, remove a duplicate from the list.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 contrib/coccinelle/meson.build | 2 +-
 meson.build                    | 5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/contrib/coccinelle/meson.build b/contrib/coccinelle/meson.build
index 4f07824402..dc3f73c2e7 100644
--- a/contrib/coccinelle/meson.build
+++ b/contrib/coccinelle/meson.build
@@ -41,7 +41,7 @@ concatenated_rules = custom_target(
 )
 
 coccinelle_sources = []
-foreach source : run_command(git, '-C', meson.project_source_root(), 'ls-files', '--deduplicate', '*.c', third_party_sources, check: true).stdout().split()
+foreach source : run_command(git, '-C', meson.project_source_root(), 'ls-files', '--deduplicate', '*.c', third_party_excludes, check: true).stdout().split()
   coccinelle_sources += source
 endforeach
 
diff --git a/meson.build b/meson.build
index 66ee6fb096..c4dcf756b3 100644
--- a/meson.build
+++ b/meson.build
@@ -633,7 +633,7 @@ builtin_sources = [
   'builtin/write-tree.c',
 ]
 
-third_party_sources = [
+third_party_excludes = [
   ':!contrib',
   ':!compat/inet_ntop.c',
   ':!compat/inet_pton.c',
@@ -644,13 +644,12 @@ third_party_sources = [
   ':!sha1collisiondetection',
   ':!sha1dc',
   ':!t/unit-tests/clar',
-  ':!t/unit-tests/clar',
   ':!t/t[0-9][0-9][0-9][0-9]*',
 ]
 
 if git.found()
   headers_to_check = []
-  foreach header : run_command(git, '-C', meson.project_source_root(), 'ls-files', '--deduplicate', '*.h', third_party_sources, check: true).stdout().split()
+  foreach header : run_command(git, '-C', meson.project_source_root(), 'ls-files', '--deduplicate', '*.h', third_party_excludes, check: true).stdout().split()
     headers_to_check += header
   endforeach
 endif

-- 
2.48.1

