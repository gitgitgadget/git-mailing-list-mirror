Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A661E5B60
	for <git@vger.kernel.org>; Sun, 20 Apr 2025 13:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745155181; cv=none; b=bu0uWNm6TGsFqeyaZf9PB9nB4MuzeuXB6ZcmJQiYg3+I8GE2jttL6vLvtuOlADBZ8ol2F55tj+1lyNUPXB2imioqm79F9LX8phS/ypCvTqOFSuG/+mTqX8Ws9iMYI6cQ2E6fqOQk97tSdumuEO6TsJ3xselqlzYLTPerPtyReYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745155181; c=relaxed/simple;
	bh=QDZE6l/OQsFgvSHoUyZ9I1BGdvakPz5IH9yfpHvRbjs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fx0/n+DRJ1rEnvez1CLxCHONThCJCa71nyjo7Af46S1YmhNxLAGOFSnNrVIrxGpTD3jUqhsSf+Db0DtoZwMWgrxn6euER49nkjfz8Kyzl2pjBpWNcgYzFGzYR+w8pPtRT/UrcOEBaPFN8sCx9aWkU9KjOwcobQwSm9a+rDlwfmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lfYj07Ea; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfYj07Ea"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so583837066b.3
        for <git@vger.kernel.org>; Sun, 20 Apr 2025 06:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745155178; x=1745759978; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hSNj/9wvxFkDNSWrUZRrDB5kxB/zNjDo3jSgTVS9RaE=;
        b=lfYj07EamXsKT32TpFRkc3RmPzVK6AAwhlcpagl4aZXZrnOvVyB0UvK8kqcHYUmH2C
         9THmDQ57aVq0SEFB1soB+uOeNCOVtj75RvKPwK8XidzmFIozLCy4Rz8PrzsbLsczVCT3
         TumqYdPE9Avy/k33D0HvmtGv2Yb1YsYgezN50x/s4XlbqUeyiYQdYnGxJm9VE38y5/52
         tpAXYki/5v12mX0h1sN8ljHEmkZu25QJQb4vjlD4Ek8uIt/oST3xzPmAeQ6mj57+3CAw
         YM2SQrwQzJGpWH6FmNOhUgwi8ppa2PcEWCN7W8rm4OX22mGa0J03fM94GIo4OiE8XcQ7
         Xzyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745155178; x=1745759978;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hSNj/9wvxFkDNSWrUZRrDB5kxB/zNjDo3jSgTVS9RaE=;
        b=pCFDXXT1mUKUwdgpoSzcHsQHUjU3akkuFswiki+yKodZT8KynueeBTgA6xWz903WXM
         fER6dxqUV7aa93qnB3Nl0tEln7A1BchF1YrmATI7e/YqrOrDdntvBvHCUsuhGd3ab9O1
         BiMMS2EXO32FrSkWWTdIWxnISLjR4YYqnIxYDUYhSRggZ3U7+9Cn6lLKZNMjcj0ZtVHz
         8YH1s7edCy3HW2TuIwWze2K7y44qQwzU6VeXSKHZ8XfxPE9IckmDs2qjgR7NDu5Su5pE
         4qRJz+ZXHsP9YQp0F0Nw+YJPi/hsNhmh42dxbiPC7UWzLRNy7Ktk6OwV9pTBNrils+Sm
         9pjA==
X-Gm-Message-State: AOJu0YxUt0JDwZ+LANupG/3M7ANeMdEOC642DYh8Nuc77DWEzppZcaB/
	aZG9yIlgZjLM4KMcSSZcjXt2XemE88TyU8UK9zUA8l2Po72Taxl4
X-Gm-Gg: ASbGncseySA7rsD0V1Zc0kSe1newO68E4SlUynBwCKVws/mxn/PAxYsui+TLzRBoz8D
	OYJCJbvRdcsISNoDcs9DXnYSbj0wOrn36Ho47ghjXf5X5ckEi+aPYODxp6ku24z4YHSjDpmn6l9
	uRWLSMr+WEZQLHq2R8Cac63DOM2wsdKkxa13faAJpnxY5vP/+vP2Z41+t7Ex2SC31KwJp8r0x+r
	OgDc5d8ccIuaesIkVzU4EA50/hdQtIwm9J//NPWlbFFivt1b34G9GKzQOR3wUzyqLrQGhpQ8LQ0
	5HlijoKtAEjqYg5MR8/v7zxgEbw7JiKmPtVtoYnj/nZIw+Y=
X-Google-Smtp-Source: AGHT+IFH4rjYdibCM7GJM2M4TdYHZQfdstnXBli4fU3n+OVlcoIMjvYmS0/chbzhc80Qf49BTUX44w==
X-Received: by 2002:a17:907:3d8a:b0:ac7:150e:8013 with SMTP id a640c23a62f3a-acb74b1ce20mr867428766b.15.1745155177745;
        Sun, 20 Apr 2025 06:19:37 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:7cb7:e0fd:4535:dd46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6eefc703sm397872566b.94.2025.04.20.06.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 06:19:37 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Sun, 20 Apr 2025 14:21:34 +0200
Subject: [PATCH v4 2/5] meson: move headers definition from
 'contrib/coccinelle'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250420-505-wire-up-sparse-via-meson-v4-2-66e14134e822@gmail.com>
References: <20250420-505-wire-up-sparse-via-meson-v4-0-66e14134e822@gmail.com>
In-Reply-To: <20250420-505-wire-up-sparse-via-meson-v4-0-66e14134e822@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, toon@iotcl.com, 
 gitster@pobox.com, phillip.wood123@gmail.com, ps@pks.im
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2993; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=QDZE6l/OQsFgvSHoUyZ9I1BGdvakPz5IH9yfpHvRbjs=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGgE9GYf/rp35efMWi97gs/0RmJCHSgZ1ZkrR
 K1P3qrO7Xe2TYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoBPRmAAoJED7VnySO
 Rox/ZroMAIOMhUIjUgg0QtURJ1lE4h+od2QBx6949zpccVJddaQjSM1KFCkc4dEW6uTDgSauvot
 LU+m0lTztdIcnM0PJ0aXJk9w116vScapVHmMB3jqlxiiCbtl7IkxnTI3fLi/AXvz+GaxiH3/fJT
 cidLaJChvmtvyBC2AHKWuZ3jVitjULDNpXS1T+niFoUgJCxbpA2YtgSrvotdNXjxVV6jDAgT3qt
 nzTCMIXkfVq1UyY+IRdqb9zbOBNPz+voeQagwOjNvFc+LQ2LvkOKhHUBhPmz6HrU+qpYIyIAr+z
 h7HJn2WvBFL5fj/PfiCYeaIxlnBKDdUf26/htG3qDAl9MWGUHwLLBs/tTTAbz6zdSsOfkdu+xSK
 M43M1qqdCWXwWjN5ctjbz+1SuHdw7L9YvLIJZMkCiwxnBx5xD14p7iQcsxWr0RMvrAlevnpkd2E
 gAhXpK/VdLGahw1ThiFxjDDUGnYLZxXSuuuMddsA1YIefHC31fRrhjg/QF03n8TEgm8dfQfoB94
 +k=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The Meson build for coccinelle static analysis lists all headers to
analyse. Due to the way Meson exports variables between subdirs, this
variable is also available in the root Meson build.

An upcoming commit, will add a new check complimenting 'hdr-check' in
the Makefile. This would require the list of headers. So move the
'coccinelle_headers' to the root Meson build and rename it to 'headers',
remove the root path being appended to each header and retain that in
the coccinelle Meson build since it is specific to the coccinelle build.

Also move the 'third_party_sources' variable to the root Meson build
since it is also a dependency for the 'headers' variable. This also
makes it easier to understand as the variable is now propagated from the
top level to the bottom.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 contrib/coccinelle/meson.build | 17 +----------------
 meson.build                    | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/contrib/coccinelle/meson.build b/contrib/coccinelle/meson.build
index 03ce52d752..4f07824402 100644
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
+foreach header : headers_to_check
   coccinelle_headers += meson.project_source_root() / header
 endforeach
 
diff --git a/meson.build b/meson.build
index e98cfa4909..66ee6fb096 100644
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
+if git.found()
+  headers_to_check = []
+  foreach header : run_command(git, '-C', meson.project_source_root(), 'ls-files', '--deduplicate', '*.h', third_party_sources, check: true).stdout().split()
+    headers_to_check += header
+  endforeach
+endif
+
 if not get_option('breaking_changes')
   builtin_sources += 'builtin/pack-redundant.c'
 endif

-- 
2.48.1

