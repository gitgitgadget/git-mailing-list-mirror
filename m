Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BE947DFAE
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 15:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788277992; cv=none; b=liBSSnHQ8003dHgMByFZoJGkGth0Lgfb39R1IlTX5wY+ERsNNkdIuqNVjHlm7Oz5ZXQnUvmEs0qJhuk21Izp9npUk7OxpSLsCI6gA1Xrq/z+T03LhlDGP9/mL9uNryFQjVZJVujTIsGbKF3D8sNOrq31/xGMvehjx9BTB9+Kscg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788277992; c=relaxed/simple;
	bh=3x3mS9wp9zS4rITOvM2VNES0EsxqaFj4TwGlOTsrLOk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=G09lABG4BT11w8Qx+4RyAN4m6PtRkryJR8Rh6UBDsnz8aJrZ2VtRykCSJ2GxZZr3enBTnxJMqfTKmSNE2Qn5iEzgZJS0q5oNVYE4yRSgsXUY9i4M5TRz/tQKIe2aAQYVBJ2d3XCp6Xpk9bD+WjmabGu2B0DpzCR22Nf/oaSYw6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SCFkVjbn; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCFkVjbn"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc1cc1b42b5so4754a12.2
        for <git@vger.kernel.org>; Tue, 01 Sep 2026 08:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788277990; x=1788882790; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AqIDdJ8ANufL3NCYKuVIe80LUKn6x0FHL5o3FWkSBiU=;
        b=SCFkVjbnP7R+NQp9K9tzw/ZCg+33hupxOj0h1Vp1SwwLM+YWgu3F83HvZMSdmE4+LX
         +4IiaryxnMQmlO9lx3MOM4TYcqTk/ejmJbfp/78mM4hpVD9qkU6lkVwb4lSA4ssM7dPd
         hCqtCBWkx+KkFz5G+Ow+VmfOeQzH9vJOEuMM69RrwDE7ev9NiQOQw5UKAhf/bkW7qrT7
         XWMi54U0AGKI5Bli9aK9S52hCnZtmpnnmJIbhTEcyU5pR+FArZK2nliFMPdkUKdJguu5
         Ij9eidvwYhloWL70Av4UoJ4Ik7U5tNfWwxALYUWpTQU8gIqNVxQlAPLzwBxF+DDvQGJ6
         OFrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788277990; x=1788882790;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AqIDdJ8ANufL3NCYKuVIe80LUKn6x0FHL5o3FWkSBiU=;
        b=EmMRwMjzCvgdMMBfTBxjZylfeLPWmn4jAPVpapipklRgH5ggdrl2v+UdxxqZqliD9y
         aCy8yslIq7WHwdalPeF1Wf+lQu+ei5Y3tNva6cwNeu/1jtqkERsgng/iM9c4Glw15UF5
         qbRBI22bTsy4BkirzbUp/KoQvyLALUhEV8LPONK4hGGgHJudD+dFIkCUi107ndJ1IrUE
         U/lMcaVt9PYFFaVWkJFkApPLxiV38iVnuZ2CQ8nVUg6Fx3jsOLZf3t10fJCfTOcl649j
         +bPqWOpDmE6zixuFq3AtjvtQ1VrauETNEw6FJvFUxVgdtdlj54q36bBZafACe0s91kbP
         jMBw==
X-Gm-Message-State: AFuF++ke7SGROqZjNDj8M6L+QNG2rNH9qQT2Ac6ISxtY2ByeDIZ3fvj3
	fOo7vAl8eiV9rdCjzfaBXtRiLwrdGPlcoci3SJuPYJVlTGfaDOV/AYcnG0Gwug==
X-Gm-Gg: AYBFou3TMOcYalajB8fZMbFYKFq+asTA1K9+alqHK0gCXtukwZBigA5OY7fNObTbM10
	hniRQW3pBmOr6qNgoNb/QtHArYLVpD/UwD7XlAnAWK+WI1sVo3Gj9Pm8d4wwQBozbD5siuovAvh
	+yal54a76CEX6ols2pDdLkuTDg0ANB2FyGn92H7f9pbgCn02gecY0rJELreXUUTTV0N4vOkdxne
	g0hugIKc2iSy5grtx6uGhKipcgrP0GSnhwHE+V2S4FW3vhnWNw9ITYkLLiSFNsaf1PyRz5ot/MC
	PG/UoMK/5fYQ/UsaqpL+LhTqrmCfUlAGN3aNFJhBGE7EB+qOUj6IGMqq7faO/mh4f9RCQwhT2RD
	NV5shYqLiWv+n0YJDqIY/bvTUrN9ahBj/MjNjOihJYPqj8oj18kqxXOz4g+f49kk6dou83ecTDl
	xTh5BZBTYt95Ra/ELCLCEPQe6bi2lXmm5xPjxw2v+aN0+AENUpOPnmT4y9n4ai
X-Received: by 2002:a17:90b:4b82:b0:38e:4cb:51f with SMTP id 98e67ed59e1d1-39907d1cad8mr13678699a91.11.1788277990181;
        Tue, 01 Sep 2026 08:53:10 -0700 (PDT)
Received: from [127.0.0.1] ([57.154.3.146])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-328713b944bsm41378547eec.27.2026.09.01.08.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 08:53:09 -0700 (PDT)
Message-Id: <75a184ca09010c1ff75b140ae31c4af32fc33503.1788277983.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2171.v5.git.1788277983.gitgitgadget@gmail.com>
References: <pull.2171.git.1783479584.gitgitgadget@gmail.com>
	<pull.2171.v5.git.1788277983.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 01 Sep 2026 15:53:03 +0000
Subject: [PATCH v5 3/3] t/lib-httpd: document writing concurrency-safe CGI
 helpers
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
    Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

Update t/lib-httpd.sh to document the fixes applied to
apply-one-time-script.sh and http-429.sh for future developers working
on helper scripts. Add concrete examples of patterns and anti-patterns
that should be considered when handling state management.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 t/lib-httpd.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index a216e5376f..115455784c 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -159,6 +159,18 @@ prepare_httpd() {
 	mkdir -p "$HTTPD_DOCUMENT_ROOT_PATH"
 	cp "$TEST_PATH"/passwd "$HTTPD_ROOT_PATH"
 	cp "$TEST_PATH"/proxy-passwd "$HTTPD_ROOT_PATH"
+	# Apache can run the following scripts concurrently per request. Make
+	# sure any state management logic is resilient to race conditions.
+	#
+	# For example:
+	#   - use "mkdir dir" to ensure only one request "succeeds" under some
+	#     condition (see http-429.sh).
+	#   - chain (&&) atomic operations like "rm marker" (no -f) with the
+	#     logic that is guarded by the marker instead of relying on a
+	#     separate "test -f" and "rm marker" check
+	#     (see apply-one-time-script.sh).
+	#   - use scratch file names that include the process ID ($$), so
+	#     concurrent requests do not overwrite each other's state.
 	install_script incomplete-length-upload-pack-v2-http.sh
 	install_script incomplete-body-upload-pack-v2-http.sh
 	install_script error-no-report.sh
-- 
gitgitgadget
