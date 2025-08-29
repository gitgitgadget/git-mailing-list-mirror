Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5061241695
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 19:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756496551; cv=none; b=gw8alUSQvQdzRo4DHwuOk+F/wFGkpaz9jl+sE51u2ZLl/4b9qZ55YYWSjKYWO6wGLiXLgQtTd138CpPlh13dCBQaWOFyvPPEVRgVdL6j7kHeiCtzeDpugUfWgOfrGRMVlj8zhfGbDl4OrXO8lzRVk8WzFk5+MxRVtMlDGUS0GGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756496551; c=relaxed/simple;
	bh=F0sDkcPqPiYgTCJJx1OogYsevNOFg9cTHSwG98PfFD4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=BnA4C0gCVCYqdgCzva7qqRq0/S6EatbELRa4AfUu8ZcDRaDU3I2oa59ZAHwzfuWJ4UxHezFoqQAr6+Ife6V/UnV3mqBiIA9hIuswvjhQHV/VKQ9zuuwNFlhMdQADCRyu+Tu+RiT7+/F1iR8TUVuocv+No+7K1N7AyUuioksYinc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bbvjtz1Z; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbvjtz1Z"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b47175d02dcso2082303a12.3
        for <git@vger.kernel.org>; Fri, 29 Aug 2025 12:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756496548; x=1757101348; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PnjfmB+jRyMgMhE/0ACp/vWIdzMdWp194BVbUD8Jpko=;
        b=bbvjtz1ZHPxkPY1OyfoQw7UXHlSrE7XV2s9eCdXXYepNH97HphiQ4ws9+CvgKQsgV7
         Ms4iVkvRpD02+IF9Kfv9CvLuefLhxU3SKjcbGxS76+wBVeuvnYmCSEtOTWXZLeZ/2rRi
         VgujzfJWLyOxZfvs1daDMFZh+AuUoZuej6FGOMfdyCICDGFhOPc8Lr9HG34I/02vIlk5
         9vyXD3vDZzzGbYWyJJQkjBYVmDcoxeVEsy9N1LQMa2Zvm+GqPDfC/oqkQ4e2JvreUunz
         +HIidF8XnA3alAB+Pe3sumu7hJOXdDO4D9u6NX2EGH5PinmCuY/Hhfdc0B6R/DVoNPv8
         8hJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756496548; x=1757101348;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PnjfmB+jRyMgMhE/0ACp/vWIdzMdWp194BVbUD8Jpko=;
        b=Jk1WtnyEfrj6Lhl1E5SETFVU69YOtoOYHkIo0bbr97zh0ys3WAaLaYNSZGlwL48gvx
         /YBlV8GMWSkBwNjIVRbAwbwxGhFlO8FwhVCF4eD6/joPMt5cdSW8YAODChP4+WmtTlwq
         qiL1RVCEccyyZ4x9HpdCZtTrPvgkW2VxXVw7nvTu47uIaQ4WrVVqxmVv16mKlqj89tap
         qtru3iax6JtAJMO4jq7MFQBN0asmFugKr7j4gxdfPkk3xGV4VkQkD8rOTBlAhEqtFdYx
         WVK9CII5Wsp4dLMEblQVMNupYO9JXujGfsFLovyE2gmTdPn4CedeLHWV0z7dmK8Uit9r
         2e0A==
X-Gm-Message-State: AOJu0Yy/ntZ0OI9SG9n6iVfaQjnfRKDBQZmMDSaRYtwSpCf8pRCs3LVX
	le19GjsohkNfGmsin0p081VhSEfTxiryQhl+kvfd/PyKbm1/dh9zz/a6NjgyCw==
X-Gm-Gg: ASbGnctlb3iwKDGjY1TT43OQ81PZzCTm7ptOF7V9PmPN4nMmqsvV8XpbD7ML71y8J5b
	EHR7qK89SW37fuT120h9uq54UL4bLpMVsCO86sueUqFB+0ijoDnGMPP+T8N+5k8szHKllC7sV9D
	qULoNfrpIXS+SnmuasQyXM60YrSuqVsFe0rK+qPPuotS5UtjHWZYCKDkrCqclMZY0u4PZCk1NzE
	G1ss4+AtCB4poP+Q8WS0H/toKNqghkpsnkVTEHAshUl3syQSxOMbZH2ckFskDOX0+uij4BH/oPy
	v8e6MYcITmz04N0vSiAsjra1X8omxa99b/1hAe2c1ZKPW8PLkfSUDHEgffzcAHPIp1+IeLY7WeT
	i3mJop7mYe/c8t0Oyh6U0uWHyiOOsofAaBQuRAg==
X-Google-Smtp-Source: AGHT+IGRoYEbr6gdS3trJ8fg0KkiPR+4dMGnKPx1vBi6u0+n5IH9uQ2H9rfCBFOdjr1aRxLpwXxbgw==
X-Received: by 2002:a17:903:124c:b0:234:d292:be7a with SMTP id d9443c01a7336-2462ee0b991mr385743235ad.1.1756496548413;
        Fri, 29 Aug 2025 12:42:28 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.195.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249067d5842sm32832295ad.141.2025.08.29.12.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 12:42:27 -0700 (PDT)
Message-Id: <a00cbf7bcbc0c0f2a30597bafdf26ec0366117fc.1756496539.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 29 Aug 2025 19:42:09 +0000
Subject: [PATCH 05/15] github workflows: upload Cargo.lock
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
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

Make each ci workflow upload its Cargo.lock file as a build artifact so
that we can audit build dependencies.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 .github/workflows/main.yml | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index ff2f90d122..cdd57b4ee1 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -156,6 +156,11 @@ jobs:
       with:
         name: windows-artifacts
         path: artifacts
+    - name: upload Cargo.lock
+      uses: actions/upload-artifact@v4
+      with:
+        name: cargo-lock-windows
+        path: rust/Cargo.lock
   windows-test:
     name: win test
     runs-on: windows-latest
@@ -317,6 +322,11 @@ jobs:
       with:
         name: windows-meson-artifacts
         path: build
+    - name: Upload Cargo.lock
+      uses: actions/upload-artifact@v4
+      with:
+        name: cargo-lock-windows-meson
+        path: rust/Cargo.lock
   windows-meson-test:
     name: win+Meson test
     runs-on: windows-latest
@@ -399,6 +409,11 @@ jobs:
       with:
         name: failed-tests-${{matrix.vector.jobname}}
         path: ${{env.FAILED_TEST_ARTIFACTS}}
+    - name: Upload Cargo.lock
+      uses: actions/upload-artifact@v4
+      with:
+        name: cargo-lock-${{matrix.vector.jobname}}
+        path: rust/Cargo.lock
   fuzz-smoke-test:
     name: fuzz smoke test
     needs: ci-config
@@ -509,6 +524,11 @@ jobs:
       with:
         name: failed-tests-${{matrix.vector.jobname}}
         path: ${{env.FAILED_TEST_ARTIFACTS}}
+    - name: Upload Cargo.lock
+      uses: actions/upload-artifact@v4
+      with:
+        name: cargo-lock-${{matrix.vector.jobname}}
+        path: rust/Cargo.lock
   static-analysis:
     needs: ci-config
     if: needs.ci-config.outputs.enabled == 'yes'
-- 
gitgitgadget

