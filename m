Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54FF1FC7C8
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 17:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734456730; cv=none; b=c6NDg5IX9PN/aV7mHmY0nvJg0fRCD4eCQHlA9bBjIVihF/HZJPXK9KRfJEccaeGv0LDk0BSzbhGle8JynFSJS/xquEZwmpOeliHfG8SsptawBROGNV1aAA29rT77TnnbNL2nGjeZXZVpfzlFuDQLxd1BwjOrPjl71QJhIlVbK9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734456730; c=relaxed/simple;
	bh=Vmce3Ha7lf1+N8vpiVco7VGKSUTdr/BXT9Jqzf3Ol98=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=f7jJgCxeJmiCw0Q/WjRt2hOpVB0FFETY+3WGo9jvuzBcYI3nEvnuRkfF/90aUrrapyi6+4tJVXH8xeUlYflJgJc1GVLmMyTWg+CLozQJPZ6z5Fm8UCgqqhiTrV3T/gezfUEKNhFJLc7S2WbQsI+fVIMtEi5Qb9hJlXx3YlxA92Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EGvLHzay; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGvLHzay"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43626213fffso32969765e9.1
        for <git@vger.kernel.org>; Tue, 17 Dec 2024 09:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734456726; x=1735061526; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nc2Va2Ub81JAcP6Q8sTqHrN/bsyf/Ds1wGkBpC4DqVQ=;
        b=EGvLHzayx0yUCQyvx6Kq2RFHfV8kvWer+2yqn3jIFZbS7HYrSNUmJon40GCWiwQZYA
         MWOaarCF7h31MmMpkDGaN5S7bh+fQvvMXk8n4BLXvPi+1ksBuFfxEIItuIxGN5FIs4hN
         cZPIs4BkLJ1msxKDHREHa82QEtKlm2xERyNzb729YJcVFDiJhfwnSC7izuIE+6nilBbM
         qhwvkhLKkJVQzawT5XN965kM1PG3MqqYW1fpK2AV6P/Iu+IEsupPzhSLG/ESITnCO8nZ
         bh43vHM+8zZcY5BSBMl6Y1S28ttinlrRNgSeQfibsBkYUZCFzvzp8Qus5WywXy6stiS6
         0XiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734456726; x=1735061526;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nc2Va2Ub81JAcP6Q8sTqHrN/bsyf/Ds1wGkBpC4DqVQ=;
        b=WZWbVTAJUGGPntG1oXoHEvC6wPp5UkbV8picN7sZQa4xxNF8QzenB+Xwed58NPpKi8
         VWICfbHPQCy3iu9d8rC6uQGXLjhh9hnX3E2aMkzefe7pfHzchyrLmaGlTPrYsJD2Cqzu
         6xbNqli8bm5JKqXCD6Mi6V005Ao30rs1olLgek9W9AyRnLyM+YAlU4E47V6CjLfErwZZ
         hDphuIm+NAuqifE6KOvRcTXhmPA2eQQIft/lnfiO8J0UPi82kHM1PIWn+cTFSE2ChvcW
         LDIS6J51L0MnwNwkZrchEsJ7C1oFKhpNyTTuV5Ng8raluBZKUWBoPieCSo/yMBTIuOe9
         u6bQ==
X-Gm-Message-State: AOJu0YyADjti/8DZePkRYufbqvjvSDpWB/jbLR45w3EvQVOsCQvayD+D
	nNP5+Kp5GRre3J3yAW6OOh3ecviaiNgVAwvsZwuJsih97aSMTFdloFIwBA==
X-Gm-Gg: ASbGncuPwa6IG6XTfALAPf1U08I3IwBUdC1bk86Tb2Y0xZET1k7OjXaeU5sb9dtdWU0
	2K6ams6yuqnqfgRVJaRV7gtXVIUM6No7/+ZmHT0Puhhv1LLibbfaEABKRZbiCy6kPtomQif/RO7
	wEBVwgXeuPWHhjLu8rRGMiEpdQfCRD1uLBjOZdydlvO5+sBr9r80fFi00ax5pcnuP6lxLGRfupq
	hqb9dr/teXkvBG/H5sTfTrjHATPXEepVuH4Nmib0fEK7WEMSw2Si0Vvnw==
X-Google-Smtp-Source: AGHT+IHkC8P1ucEABdTpochPEuf0X85SS227VE9fqgvNoW26zL5REQRB5KDAYbHcmm96+uXzVC6bvg==
X-Received: by 2002:a05:6000:794:b0:385:faec:d945 with SMTP id ffacd0b85a97d-388db239bc6mr3824076f8f.9.1734456726429;
        Tue, 17 Dec 2024 09:32:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c8061038sm11593156f8f.104.2024.12.17.09.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 09:32:05 -0800 (PST)
Message-Id: <0f1808e37cc75ac6d2bd5f28deb7c91bfeedcba9.1734456721.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1840.git.1734456721.gitgitgadget@gmail.com>
References: <pull.1840.git.1734456721.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 17 Dec 2024 17:32:00 +0000
Subject: [PATCH 4/5] cmake: put the Perl modules into the correct location
 again
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

In ccfba9e0c45 (Makefile: use "generate-perl.sh" to massage Perl
library, 2024-12-06), the previous strategy (which avoided spawning a
shell script to transform the files) was replaced by the same
`generate-perl.sh` invocation as for the Makefile-based build.

The only difference is that now the transformation tries to handle the
Perl modules in-place (which ends up in empty files because the same
file is used as input and output via stdin/stdout redirection), and the
Perl script cannot find them anymore because they are not in the
expected place.

Let's put them into the expected place again, i.e. into
`perl/build/lib/` instead of `perl/`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/buildsystems/CMakeLists.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 6f35cd66f39..36f18ab2dd1 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -882,6 +882,10 @@ foreach(script ${git_perl_scripts} ${perl_modules})
 	string(REPLACE ".perl" "" perl_gen_path "${script}")
 
 	get_filename_component(perl_gen_dir "${perl_gen_path}" DIRECTORY)
+	if(script MATCHES "\.pm$")
+		string(REGEX REPLACE "^perl" "perl/build/lib" perl_gen_dir "${perl_gen_dir}")
+		string(REGEX REPLACE "^perl" "perl/build/lib" perl_gen_path "${perl_gen_path}")
+	endif()
 	file(MAKE_DIRECTORY "${CMAKE_BINARY_DIR}/${perl_gen_dir}")
 
 	add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/${perl_gen_path}"
-- 
gitgitgadget

