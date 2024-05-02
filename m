Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7CB17F37D
	for <git@vger.kernel.org>; Thu,  2 May 2024 19:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714678882; cv=none; b=buyO3yf5hyD0G/e5gVrOG9WDqW4Vjj2jGDXjBQeXzmWYy61DJVRgZMQ15k1AxMyJ8mhgthtj+SEYw1QWjooZuzA98JWTDD0gABgT3E0qinRZ6nnzmN2StMO+GChq+8uzcIgieYuN7H9IEqJTReFlHE6oYFQrCjgFTGtLz0OPwwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714678882; c=relaxed/simple;
	bh=UahwUq9KQ+L25qWoYlDOZhfHrQ02v1DAE6Qi/vaHVgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MX9dC1AfB4sN1Dzskw8ACCIkCZy5e4XxsI8nAOilAXfkzA48m2PcznM5jG3TQPhaWK3FcBgVeOhV6w+0xe4rkT1jt15iD2syO73arqWv9lKyqKiOoyxiVzX2hJWAp66nf23x4Ttc8GZdZzfvryXV5uK8iJZ71Rt3ODWOesz7orM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K2e877HD; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2e877HD"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6ef9e381989so699398a34.0
        for <git@vger.kernel.org>; Thu, 02 May 2024 12:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714678879; x=1715283679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7oeVL87ubFP4WWknZ8iX/rlxxUxGiJ6CGRc32QJEWXs=;
        b=K2e877HDw+s2JBCRc9Pn2s4JL5K9DijwhosKggJvgT4+m0FgTurJtFO9HOsaVsSxgU
         R2a+hyHTeLcw8E7WZXwsCIf5A7/RBh5agefK9r18eA5DUppJ0bcqv8stUnuLOOKLunpL
         IY5KeG8JPGcM1LVMzU1d8bFb3jg71hnGSFp0m9NOOc2pOoSMyTNPLvCl4BFQa+8H5ryz
         sT100V7LigQdtri+WLz74A5yRUIgvTt1E+fqRgaFS9d8wWKcpUruI/sLehED3qx5JmVn
         HKPGLAzlSjdDcm2Xn+O7tyNMy5iu0vhr3LxYlQcl9BXSVnb48f73CWpwuRQd7x6nh9PV
         +hBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714678879; x=1715283679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7oeVL87ubFP4WWknZ8iX/rlxxUxGiJ6CGRc32QJEWXs=;
        b=mFDke0NZhIc1U1WpJL+mnP5qq7PQQK8m7RWnAPtawBuhP8K7qH7MoQG8Zkz/9gsVGm
         XiBNw/aRArvf567t/74WSJZ/HHWPMDQgowos8N3yHfrMz4GTtbeYlgfM8iylxudBHZy5
         jJ8aEQJE9OIZNQja5Y6xrhgYH9Idj0wQ2/sYzbcqtj1NWMywS3VOF6ex+NBsmXm0Dclx
         Z/nizBmlDTDlGIAblVi1sU7zrKF5T3lrv9t5lBBB73UN+Os8V4K8zcmsrY5bFsCVdBbI
         GYQvkFl4Bhbe2kvCVGNxEPjgSKx0ZquhNszaszGhtHyiDtfCzQ38TEV5gpDSE7c8+k1G
         hiJA==
X-Gm-Message-State: AOJu0YxVCbpeToZNG90gffLZ5009wgg0U7F6Pc0dnkfvaHy5LzGJJfoo
	eW5M/tU8y3iPmS2qug2PEA6soGe0ix3HwqMkLAyEkEzl8vJ6qqVed3Ldmw==
X-Google-Smtp-Source: AGHT+IGonf8yMqLbHShNivqoKnFrm+dvquwsWNAP4zYrxbnIDwylpKxiqFpTfIZM/zG8jmYxBLCPjA==
X-Received: by 2002:a05:6871:58b:b0:22e:c6da:6196 with SMTP id u11-20020a056871058b00b0022ec6da6196mr1023692oan.27.1714678879378;
        Thu, 02 May 2024 12:41:19 -0700 (PDT)
Received: from denethor.localdomain ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id uj12-20020a0568714e4c00b002390714e903sm297443oab.3.2024.05.02.12.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 12:41:19 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 2/5] github-ci: fix link to whitespace error
Date: Thu,  2 May 2024 14:38:36 -0500
Message-ID: <20240502193840.105355-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240502193840.105355-1-jltobler@gmail.com>
References: <20240430003323.6210-1-jltobler@gmail.com>
 <20240502193840.105355-1-jltobler@gmail.com>
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

