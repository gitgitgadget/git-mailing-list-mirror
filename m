Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C3D1401B
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 19:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754421052; cv=none; b=qOTz7s/2XFWTqiqAVwtL/nLl/3eb9pFRCPsn+xPwoI3qN8Pauqt4XUcCUgZhln4MGgnW6IGZt6meHa8IVI3kt81Csv7WZG99QrmLjK/N2DBexBFQWEtrgvzEVviBb3ygtnD67XOP60KT91YNgDj/3XxxGM2PPCSKzDnqOvm43T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754421052; c=relaxed/simple;
	bh=EFRlGS3XaUpBAhrlPc8yt1TrLKOkS7+PKGO6stDRsbo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=B199F0jHw6ERfoazDVpgHGZAGH3eH/d2E8q0g72pceoL/SKcVHx1EGhueqwDXI4RXNITzAWWmq3BPUx165dGDrQnUMdu4nmdsVXvsXp6T+32pIdbtTVw7gJ1zfn/GKNQRCmnW3waOWlXEL2+OnXA+YsXhvHJ7RuPKtdthTzdxiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WasvAi/r; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WasvAi/r"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b78315ff04so4743973f8f.0
        for <git@vger.kernel.org>; Tue, 05 Aug 2025 12:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754421048; x=1755025848; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GTKPfqiztIA2fNz+ruzT9qUKZbuL519S/m9xQBwSB5Q=;
        b=WasvAi/rBO/IvxzerIafCzuB/LRTVRj8OzhPdB1TW/OyUPbz7raIbGtfYRCsRyFOeD
         buU6JQTxVV3RUisxW7g/ijTpLsr1SaZ3WsZ0E5MoN56ZKouVWBo49Hw3jlbCiR5mmSvM
         MVO5waqdvGTMvaR/oDCpYfj48actRT2uKPvN1UdMKsEVRyZCx2cX6VFqT+Iz3j1JimXK
         gU/0j05Nw/oQNbRoS8GI7x/SstlHxR/yGx5NvU7J0Jnjp7CGiHKxAahcWz8ZrkEIfo3e
         PoFByfCbvdo+7EX7fqeInxpGE0fDTe0L0X9bn++JhiRkDJWVS4lKsiGq5I3jtDoV+eVU
         vIHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754421048; x=1755025848;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GTKPfqiztIA2fNz+ruzT9qUKZbuL519S/m9xQBwSB5Q=;
        b=NLifSzghdWW56bbcF3Pt7oJ/VOQCaypEOMj5/OqcdWEEUTngvomudjVuTwjUXCFp+B
         pl0JwVdQDG8WWIH4H2zf04nJNQuLOVH+wjqvZcEf8TBOLI+m6SW1T0rzTasNnRAQDl38
         XeAaeBSRPHt/vRYBj0/gHMDyr+I4L2CRHJFWLvZkc4O03r6oA25HiAakUPU3wKlcDG4D
         nJZTsKAEJoNaMwnA0YnrGMPmsGBiRNp0kAv7YFJcmPhL5ZmXlKTpeA6Z4m+U+v9WP+iy
         SJw4oV5Y8j4M78NvdRbXfI+zX6DFkV1GxDxM3t9qmSVEmC/YRH1UBjZj7o438KuDMAWG
         9a/A==
X-Gm-Message-State: AOJu0YyC7X/Lv5/75dCGO3jZFGxFrOyeiy9IpVYaoe/YwqBlG++Fsz5w
	Ln5M90O+6K0vOIR2ecT5POmWX27+Wo/DqEFI+1UK66oNQm56zJ9bqsQz3wnk+A==
X-Gm-Gg: ASbGnctaxKtK4jokyLFSx47Y/ViHkrMgaz6RYDhnzl5OG7EF9pIYsKsZJyIuW2sftls
	Z75Dpec9wCmJraoDQcuWTEQk/lLYx0c9fVds9E5rI9G8GSmLsSyPho/apdn1HRFMVRcV1TqsKvz
	qvSg4WaZuUw1qZbER3afNvRn3SNJKI1gb16WAn7zovkJ/k82omHogp6k9oG1OLDIaGETKVwZCb+
	SknJ4WUY8reLCSN2wQJcj2Y2P1Rkh4e9fOz9aSB3d4gISoTXxPdfbTim4lqB0K0zSb6DDpsFx4z
	wbu+0dSES02l/txmQjMBGvRJUaSqH86PsLqByUvpEUIsTdXSN2A52yBCyWvNnxjMDYwBJC4wWsU
	hoO/llUGBKHh61CW83AE1Cp0=
X-Google-Smtp-Source: AGHT+IGYcBYLI/V0oaDNETq30N6i5EVmSTvoQ6oqvWE4Cigi3s/tdXHoPzJe9gnN3cA1p7WphAOpKA==
X-Received: by 2002:a05:6000:4305:b0:3b7:8da6:1bb4 with SMTP id ffacd0b85a97d-3b8f41b9316mr105357f8f.58.1754421048400;
        Tue, 05 Aug 2025 12:10:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c48105csm20308413f8f.64.2025.08.05.12.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 12:10:48 -0700 (PDT)
Message-Id: <e79bd6a67ef2ea7247359b2449c7c313c7fa9922.1754421046.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1945.v2.git.1754421045.gitgitgadget@gmail.com>
References: <pull.1945.git.1754399033.gitgitgadget@gmail.com>
	<pull.1945.v2.git.1754421045.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 05 Aug 2025 19:10:40 +0000
Subject: [PATCH v2 1/6] doc: test linkgit macros for well-formedness
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

Some readers of man pages have reported that they found
malformed linkgit macros in the documentation (absence or bad
spelling).

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/gitweb.conf.adoc  | 2 +-
 Documentation/lint-gitlink.perl | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/gitweb.conf.adoc b/Documentation/gitweb.conf.adoc
index 1348e9b12504..64bebb811c97 100644
--- a/Documentation/gitweb.conf.adoc
+++ b/Documentation/gitweb.conf.adoc
@@ -178,7 +178,7 @@ $export_ok::
 	Show repository only if this file exists (in repository).  Only
 	effective if this variable evaluates to true.  Can be set when
 	building gitweb by setting `GITWEB_EXPORT_OK`.  This path is
-	relative to `GIT_DIR`.  git-daemon[1] uses 'git-daemon-export-ok',
+	relative to `GIT_DIR`.  linkgit:git-daemon[1] uses 'git-daemon-export-ok',
 	unless started with `--export-all`.  By default this variable is
 	not set, which means that this feature is turned off.
 
diff --git a/Documentation/lint-gitlink.perl b/Documentation/lint-gitlink.perl
index aea564dad7ed..f183a18df284 100755
--- a/Documentation/lint-gitlink.perl
+++ b/Documentation/lint-gitlink.perl
@@ -41,6 +41,13 @@ die "BUG: No list of valid linkgit:* files given" unless @ARGV;
 @ARGV = $to_check;
 while (<>) {
 	my $line = $_;
+	while ($line =~ m/(.{,8})((git[-a-z]+|scalar)\[(\d)*\])/g) {
+	    my $pos = pos $line;
+	    my ($macro, $target, $page, $section) = ($1, $2, $3, $4);
+		if ( $macro ne "linkgit:" && $macro !~ "ifn?def::" && $macro ne "endif::" ) {
+			report($pos, $line, $target, "linkgit: macro expected");
+		}
+	}
 	while ($line =~ m/linkgit:((.*?)\[(\d)\])/g) {
 		my $pos = pos $line;
 		my ($target, $page, $section) = ($1, $2, $3);
-- 
gitgitgadget

