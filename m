Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D841F8EF6
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 17:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734456727; cv=none; b=UDd5zKU+K0sdz4d5/+g2MTLBfoEtTHVZ6YpIjxgB0sK5vw2koaKh9EvPUbyJ32OfXzEq4/zLL6cfvsKeThlSCBYcLTq27pRRFOrHVDSx8tOUlhuFat3PctiIKf7ULTiMJBWoMoiROAy9TyB3pZNOraowGCldGOegTGwbGqioCeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734456727; c=relaxed/simple;
	bh=bgHXxMQSrD5tijJ6ez7EoXYM5JxCBx2QcB7M1ISAw6g=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=JDgGWQLEe+ut8ulZe0bfLLcOHb5obYUbguRSWcpa23Lb3De502+xZStyj4QdURHQuk/yoDMUdm+ms12sFvHXswVABc+yfR+w/Aig7UA83bIbrMhqw/57Yx+zA9Xzp9m5OLf2t+T4ijGNlwg1w4pVpXmfQOYybNURFPztnIxyJD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AB/WqLHs; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AB/WqLHs"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43621d27adeso39289415e9.2
        for <git@vger.kernel.org>; Tue, 17 Dec 2024 09:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734456723; x=1735061523; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/O/DpKuJJiAyJAaszUEC2BEOuV/2AgG46dlUjVauZbA=;
        b=AB/WqLHs2hp8BhoHz4Cp1KXQpMpaH6giBnKRfMb0THE8IDcG+qleiQY9sf/OWpHYVt
         6r1C/7MZ1h6CSDyCFKOmaFngWfetuhuRrqleC/kDacZTno7ixyWVQ00TaxXgk6K7Jzna
         EJJ4x5Xx6u0Jwe9IyTcVSxtQo5r+yU/4rnwpgt0gZebvc20mXYBXf9c7Owb5sT+pxa9P
         1cNU+/05sZWr6MzoLU0Dobnt66dQqAbGZtuvDWwvdYTjItK4PkYPSFbFl/8xoW2Ky3FZ
         4Udbr0yE0KScEugoS2sOB/gASw+9lPAVRNk/aU+hpcp5jFRiZU2W95kY0oYNhxG8af0U
         c21g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734456723; x=1735061523;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/O/DpKuJJiAyJAaszUEC2BEOuV/2AgG46dlUjVauZbA=;
        b=cqd/BYTd3sRz2ZFb7aivGR6XA063fJRROlFK6CsRFy4T6B/gpp0oEGEfE/Uj6mSvA8
         Qj2ktI5DzwEzh3jqs+O5sbmxyv7p+s05z/1q6GSTDY1QkMXsatm7QKxp7oynrDpcOp3W
         C8z2C7R1u+AKcQZlbhleKf0Czj0G379qzdnDH4M7DRRtT/YKEMi/raRv/nevxX6U4z8F
         EWt2Zve1iD6tqbp6VOVCwtXiyuA47P/xMbOMuxDNrnmri7IbcGysvcdumu5HcEW3IrkT
         4qUZkyGIqCB/GYUfHcV1qR1jf3JqMfYinauasZl99Op4Q0IatOVCZn4M9RHxQESYlj0S
         Kntg==
X-Gm-Message-State: AOJu0YwFf32/Im/abfGiBlgrbYNmqCexuQO5ajxIX7pPQyACHaUs+Jeb
	l/DzkiLCXB7LtDgMCIMYdjoCJykveype52aoT+iffvBavDVHHA3bmJs3xw==
X-Gm-Gg: ASbGnctGRNCYSmnirN4TyuklN7nJnr0Od3ZlxdpxYN1trcqwHTiSJbstNEdBD+TMtUj
	Py7EGddwG6hMH1v12MSMKEyTwoIkvFa97sbvErxQsI+QyIxfAp/sXQIQjoAoteCP7iVbZ5iN3TK
	ho3at+woeV4CAUaISG+NNepg8YALxTtZiiP4ZPFILS9UnRQdCLe2RzVsNRVRKEsmmDUIP+aUIpu
	PsxrPVs71Gu2UfpcIS5RC/+1S1GmRITUQqHbNBcFuDWPD+HFqce9w4+lg==
X-Google-Smtp-Source: AGHT+IEHFiVjLIvDzweQiWNenJzjwcqSTMignUtakiGI3IMeVZo7UwxL6VbEKpI/Qcl7xvpEKUt8Eg==
X-Received: by 2002:a05:6000:1ac9:b0:382:47d0:64b1 with SMTP id ffacd0b85a97d-38880ac61ebmr16066092f8f.2.1734456723188;
        Tue, 17 Dec 2024 09:32:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436360154c7sm123180125e9.1.2024.12.17.09.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 09:32:02 -0800 (PST)
Message-Id: <187888ca9cd723d78b7bb96ba4d10a64450f553d.1734456721.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1840.git.1734456721.gitgitgadget@gmail.com>
References: <pull.1840.git.1734456721.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 17 Dec 2024 17:31:57 +0000
Subject: [PATCH 1/5] cmake: better support for out-of-tree builds follow-up
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 7e0730c8baa (t: better support for out-of-tree builds, 2024-12-06),
the `bin-wrappers/` strategy was changed so that it no longer hard-codes
the template directory to be `@BUILD_DIR@/templates/blt`, but instead
interpolates the `@TEMPLATE_DIR@` placeholder during the build.

However, this commit only adjusted the `Makefile`-based build.

Let's adjust the CMake-based build as well. This fixes t0000.15 which
would otherwise fail with:

  ++ echo ''\''t1234-verbose/err'\'' is not empty, it contains:'
  't1234-verbose/err' is not empty, it contains:
  ++ cat t1234-verbose/err
  warning: templates not found in @TEMPLATE_DIR@

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/buildsystems/CMakeLists.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 49904ca8a93..926f0d7b86c 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1087,6 +1087,7 @@ set(wrapper_test_scripts
 foreach(script ${wrapper_scripts})
 	file(STRINGS ${CMAKE_SOURCE_DIR}/bin-wrappers/wrap-for-bin.sh content NEWLINE_CONSUME)
 	string(REPLACE "@BUILD_DIR@" "${CMAKE_BINARY_DIR}" content "${content}")
+	string(REPLACE "@TEMPLATE_DIR@" "'${CMAKE_BINARY_DIR}/templates/blt'" content "${content}")
 	string(REPLACE "@PROG@" "${CMAKE_BINARY_DIR}/${script}${EXE_EXTENSION}" content "${content}")
 	file(WRITE ${CMAKE_BINARY_DIR}/bin-wrappers/${script} ${content})
 endforeach()
@@ -1094,12 +1095,14 @@ endforeach()
 foreach(script ${wrapper_test_scripts})
 	file(STRINGS ${CMAKE_SOURCE_DIR}/bin-wrappers/wrap-for-bin.sh content NEWLINE_CONSUME)
 	string(REPLACE "@BUILD_DIR@" "${CMAKE_BINARY_DIR}" content "${content}")
+	string(REPLACE "@TEMPLATE_DIR@" "'${CMAKE_BINARY_DIR}/templates/blt'" content "${content}")
 	string(REPLACE "@PROG@" "${CMAKE_BINARY_DIR}/t/helper/${script}${EXE_EXTENSION}" content "${content}")
 	file(WRITE ${CMAKE_BINARY_DIR}/bin-wrappers/${script} ${content})
 endforeach()
 
 file(STRINGS ${CMAKE_SOURCE_DIR}/bin-wrappers/wrap-for-bin.sh content NEWLINE_CONSUME)
 string(REPLACE "@BUILD_DIR@" "${CMAKE_BINARY_DIR}" content "${content}")
+string(REPLACE "@TEMPLATE_DIR@" "'${CMAKE_BINARY_DIR}/templates/blt'" content "${content}")
 string(REPLACE "@GIT_TEXTDOMAINDIR@" "${CMAKE_BINARY_DIR}/po/build/locale" content "${content}")
 string(REPLACE "@GITPERLLIB@" "${CMAKE_BINARY_DIR}/perl/build/lib" content "${content}")
 string(REPLACE "@MERGE_TOOLS_DIR@" "${CMAKE_SOURCE_DIR}/mergetools" content "${content}")
-- 
gitgitgadget

