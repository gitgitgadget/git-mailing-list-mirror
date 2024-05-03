Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7021581F4
	for <git@vger.kernel.org>; Fri,  3 May 2024 17:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714756999; cv=none; b=dbckcVP9ILkpdB45IKvfSRaW7OEbpQZHMD8yLstPEtPgj+LJ1ILNyjoeLvd/aM5YH01AMaYMSCSW6dV3UHRyxoYehlYUSIL/DTvZ7LiA/iOjkxc0yAJKboHpZsUWddTy4Kz6ajeeJLNPei5pYJUs84DATJeStNICk3rkYxGQ74c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714756999; c=relaxed/simple;
	bh=UahwUq9KQ+L25qWoYlDOZhfHrQ02v1DAE6Qi/vaHVgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cTZfbCsV6Qtgi32D6Yp5SLQk85k342LAQBYE7sDmSN5PrDFoIvDLWBoRZ9+z6ukzTZaH/KB12NetDCuxc23apyBQ4PdOGKM+Bp/6a8Py2AmYgPyETlXFfgjt7ByDGsRyDtuXugRiVsA+JBnsTcKBXAbnFExNtYgHzb0ewqQNs2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqLP9AMe; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqLP9AMe"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-23dd52c6176so1373786fac.1
        for <git@vger.kernel.org>; Fri, 03 May 2024 10:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714756996; x=1715361796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7oeVL87ubFP4WWknZ8iX/rlxxUxGiJ6CGRc32QJEWXs=;
        b=jqLP9AMeO7hlF9Wa4B/yMwREa8+0pi3Rj/Lvj2l+iiOxe3brTMHcVwwxV0JeXJLg1p
         ZOqfS7PNZVKKYIunz5KUqPhG/ds0/bpuNe89lRCyZiLuknte6WWLFNSYw5X/hQjF2T2I
         3CdcDRHY1SVMwI7+b+FGGhZ3QMbvo3G6ORzKW4Rttt3aV7Rn3fPMcT1RpXXBClEZ7/AU
         BxEgT6VygK5HQCMVmRnCpt7CxsYSyVaKzYS0OZnYa4Y3JSzldMj6/QJob7RB+NjhjyeH
         IMpUw5AudrWc7nrZKg19c1H9DGLfdky+TYjd8EcUQtZ6jUsHBjJjiVbVGmaTMxCR4SPF
         4Yig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714756996; x=1715361796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7oeVL87ubFP4WWknZ8iX/rlxxUxGiJ6CGRc32QJEWXs=;
        b=W4YkSbsoM4v73biy6IoS7/gpcbGd3dkzZRqhF1eUW0rlj9z/bdlnWCoc3tb4XHyQHv
         5K98vWYLVq9BpRXQkaMPeyST9d1xoO4vPA59PBahYRSe8WudlAsNHPKyceyW1NOcClJN
         7HfVrzrkEDGHdSGyiWEtkp6WbSUFEwU5VvcUSNhzRAWQ9eparFGcHNBsnNGpa5X3vu5g
         iY/AdCzUJKNchryyOToOPh9qYKnbzAdpuUz1XammVsqJhW6oh+hVCJaFSaCd+U/xnJ2Q
         m4xeTAXYPqXrKKKfZoliCxvEoAXptHH4NKEQL00eDZVzy47Eees/Q5SLYfMJqKy8ANjL
         LRCg==
X-Gm-Message-State: AOJu0YwPwEUNUqmMCqqRLIORitIuqalMoOPzdiWtER4+B5Hovxi4iHaI
	V8YBlhwqyZzpoF9k1Xnvsyehe0/z65DNvwHJNZv4A+J8YTVnNGO6+b+kEg==
X-Google-Smtp-Source: AGHT+IHt+tpaVqer8srloLk5CfWP6G22mGQOvrsn/oi7cFByRLCQ0cUcqOuh5HSBvP7NbOaY1Nd/Ng==
X-Received: by 2002:a05:6870:2328:b0:23d:35a:24d with SMTP id w40-20020a056870232800b0023d035a024dmr2499542oao.9.1714756996392;
        Fri, 03 May 2024 10:23:16 -0700 (PDT)
Received: from denethor.localdomain ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id cy14-20020a056830698e00b006eb7b0ee326sm705212otb.65.2024.05.03.10.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 10:23:16 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 2/5] github-ci: fix link to whitespace error
Date: Fri,  3 May 2024 12:21:04 -0500
Message-ID: <20240503172110.181326-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240503172110.181326-1-jltobler@gmail.com>
References: <20240502193840.105355-1-jltobler@gmail.com>
 <20240503172110.181326-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When the `check-whitespace` CI job detects whitespace errors, a
formatted summary of the issue is generated. This summary contains links
to the commits and blobs responsible for the whitespace errors. The
generated links for blobs do not work and result in a 404.

Instead of using the reference name in the link, use the commit ID
directly. This fixes the broken link and also helps enable future
generalization of the script for other CI providers by removing one of
the GitHub specific CI variables used.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 .github/workflows/check-whitespace.yml | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/.github/workflows/check-whitespace.yml b/.github/workflows/check-whitespace.yml
index a241a63428..a3a6913ecc 100644
--- a/.github/workflows/check-whitespace.yml
+++ b/.github/workflows/check-whitespace.yml
@@ -31,14 +31,15 @@ jobs:
         commit=
         commitText=
         commitTextmd=
-        goodparent=
+        goodParent=
         while read dash sha etc
         do
           case "${dash}" in
-          "---")
-            if test -z "${commit}"
+          "---") # Line contains commit information.
+            if test -z "${goodParent}"
             then
-              goodparent=${sha}
+              # Assume the commit has no whitespace errors until detected otherwise.
+              goodParent=${sha}
             fi
             commit="${sha}"
             commitText="${sha} ${etc}"
@@ -46,18 +47,18 @@ jobs:
             ;;
           "")
             ;;
-          *)
-            if test -n "${commit}"
+          *) # Line contains whitespace error information for current commit.
+            if test -n "${goodParent}"
             then
               problems+=("1) --- ${commitTextmd}")
               echo ""
               echo "--- ${commitText}"
-              commit=
+              goodParent=
             fi
             case "${dash}" in
             *:[1-9]*:) # contains file and line number information
               dashend=${dash#*:}
-              problems+=("[${dash}](https://github.com/${{ github.repository }}/blob/${{github.event.pull_request.head.ref}}/${dash%%:*}#L${dashend%:}) ${sha} ${etc}")
+              problems+=("[${dash}](https://github.com/${{ github.repository }}/blob/${commit}/${dash%%:*}#L${dashend%:}) ${sha} ${etc}")
               ;;
             *)
               problems+=("\`${dash} ${sha} ${etc}\`")
@@ -70,15 +71,15 @@ jobs:
 
         if test ${#problems[*]} -gt 0
         then
-          if test -z "${commit}"
+          if test -z "${goodParent}"
           then
-            goodparent=${baseSha: 0:7}
+            goodParent=${baseSha: 0:7}
           fi
           echo "🛑 Please review the Summary output for further information."
           echo "### :x: A whitespace issue was found in one or more of the commits." >$GITHUB_STEP_SUMMARY
           echo "" >>$GITHUB_STEP_SUMMARY
           echo "Run these commands to correct the problem:" >>$GITHUB_STEP_SUMMARY
-          echo "1. \`git rebase --whitespace=fix ${goodparent}\`" >>$GITHUB_STEP_SUMMARY
+          echo "1. \`git rebase --whitespace=fix ${goodParent}\`" >>$GITHUB_STEP_SUMMARY
           echo "1. \`git push --force\`" >>$GITHUB_STEP_SUMMARY
           echo " " >>$GITHUB_STEP_SUMMARY
           echo "Errors:" >>$GITHUB_STEP_SUMMARY
-- 
2.45.0

