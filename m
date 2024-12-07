Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8C9101E6
	for <git@vger.kernel.org>; Sat,  7 Dec 2024 13:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733579581; cv=none; b=qo+UMraAM1ScnOekjqRW1E97prFjfuFHEYX3AQv30y/VVToyn07z8MiIa7W64DUH87KQ0eYu1YGxi0hZU512FBkWgw2ADhKLjcelmHSjGKuaAaKXhVU+u3BIVkNZnnSyvRk+2rUC6xEQ2/mR+9NHOaWgJRXwnUalxn7wBzIOmJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733579581; c=relaxed/simple;
	bh=/FIXdo83wWTEuygfQ8jObjIqI4Jv59xo15bfe2ayPNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cmFiZMXNAhDqQcgcrP2p23MSOd3RIoZS6awvrAKyVNX+n1/YRFtDXj9BYtB4pQJFQsa/yVm5NbWySbOWlzZ+4tqNJ8xcMeNl1D+cXIZtxzTqmBZEBYJiUgs4qKAUthIS13BV83pw0fqKnrerE0BPJ6N8Dkuh+PWih9l6w0tSRbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KvdBMCnK; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvdBMCnK"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa625782fb1so45018066b.0
        for <git@vger.kernel.org>; Sat, 07 Dec 2024 05:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733579578; x=1734184378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3cZBOtor+bjhe80WPXNfIaq3qvxrV8EGsOHJLBylrU=;
        b=KvdBMCnKCKurGzCq89LM30l1e/13c/cUlacF4d1WCsLY3VXu2Ngugdf8MCeBAL8bUM
         vQpZ9UxK4L3BEUaPP0COfAs3m54QYXs98NNvE1z78W3NymJRlEReV3E7MRynwdgtmbSX
         h+5YNGctm4h9oQuuPCANgcaiiy1u1OlhWhG+a51BhJtiBCIP3isHM4gLdBNxdQmXeVTk
         Zf9/wb5vnSnlGYrW/1uej1CJlQd3cOmxWA1MhOSHYNJmu5TuWL3xtXvo9G0dApXzI1pE
         eJNsgFk/sqI3o5msOdQ3fwT+4nLNDgJJlKWFUUezclSpWz9hNsRuRQ7hi/Y4von2zuK8
         sA/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733579578; x=1734184378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m3cZBOtor+bjhe80WPXNfIaq3qvxrV8EGsOHJLBylrU=;
        b=XaGG4NqJL2Ipv1/OVDbGla1h1w6KQ/dDqM/+2ORSVdsjC/V6BPwXp5ri3xgYPW79WX
         ZTucnxHyeHRAt8UXiZaoQGqnhUsV4+jeYKP35zLpgjJfyf729lEzGaUpyX1MZV8y2I2T
         /28O0kei/EmIo64Yydly72TQdPpxweYz/CLdKpohmlRYp6in88WMpVnBF5CZPlbC0/CA
         Hk0fsp7SOGKVwO+7hfYKGCyON+ATrHBCUDI4F6TgPr1xrEYSJMMWM34s+uRIIdpzqZkE
         DEZIfL+6d5tXl2Bi+bbOQx0VWYKHyWLEmkRPpuhqizTVxuwOkXUZKanfSLtZRoLUmMDr
         a+iw==
X-Gm-Message-State: AOJu0Yz1Nru/4qqLR0knD67G7MLMN2vl9HIEC2Fc69SIydfDngNwncMx
	p7Gj9SrHr9Bahsyq9pJW2uWw8n95EvoC5sfTABzsS4rLxaFT7Os51cevA3Nt
X-Gm-Gg: ASbGncvspHS+5m/GY0mWazqxH9w5mK7GXWALqBL3mrDZ9cnghX2YdE6lHwYn5IvRj82
	+yWI5vcKcQB2HvIbUFVai7HvHLv+chEmon2INfhGr46c3Qt+FfQTdZCla6BIkrQK+yKmBU8pgnE
	Jqzje5Pjw22Yh3lCTHlMZxghstrxx3OQgXyqYEIRUvNThvnlRaor5qh9nW9QX2+cbwpvFvQ7FEd
	QY6tjQ096VD2ce5TRDeLOzyojJsiUypvmhxtETeEnzfAdKwo7oA1oD+V3s=
X-Google-Smtp-Source: AGHT+IH2Tp3EDHY8eHJFd9yqOYOKYc3xWvS1DiOr4yZ+Wb6a3QiQkOhr1+p4gDnpGaXwh1MP3q69oQ==
X-Received: by 2002:a17:907:2d8d:b0:aa5:a36c:88cc with SMTP id a640c23a62f3a-aa63a2e8bf8mr235633066b.14.1733579577525;
        Sat, 07 Dec 2024 05:52:57 -0800 (PST)
Received: from localhost.localdomain ([5.29.161.23])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa62601f4e0sm385811966b.119.2024.12.07.05.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2024 05:52:57 -0800 (PST)
From: Roy Eldar <royeldar0@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Roy Eldar <royeldar0@gmail.com>
Subject: [PATCH 1/3] git-submodule.sh: make some variables boolean
Date: Sat,  7 Dec 2024 15:51:59 +0200
Message-Id: <20241207135201.2536-2-royeldar0@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241207135201.2536-1-royeldar0@gmail.com>
References: <20241207135201.2536-1-royeldar0@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When git-submodule.sh parses various options and switchs, it sets some
variables to values; in particular, every switch that is passed causes a
corresponding variable to be set to 1, which then affects the options
given to git-submodule--helper.

There are some variables are assigned "$1", although there is no reason
for it; this was actually noticed in 757d092 for the "$cached" variable.

Make some variables boolean, in order to increase consistency throught
the script and reduce possible confusion.

Signed-off-by: Roy Eldar <royeldar0@gmail.com>
---
 git-submodule.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 03c5a220a2..107011f613 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -78,7 +78,7 @@ cmd_add()
 			shift
 			;;
 		-f | --force)
-			force=$1
+			force=1
 			;;
 		-q|--quiet)
 			quiet=1
@@ -231,7 +231,7 @@ cmd_deinit()
 	do
 		case "$1" in
 		-f|--force)
-			force=$1
+			force=1
 			;;
 		-q|--quiet)
 			quiet=1
@@ -294,7 +294,7 @@ cmd_update()
 			nofetch=1
 			;;
 		-f|--force)
-			force=$1
+			force=1
 			;;
 		-r|--rebase)
 			rebase=1
@@ -500,10 +500,10 @@ cmd_summary() {
 			cached=1
 			;;
 		--files)
-			files="$1"
+			files=1
 			;;
 		--for-status)
-			for_status="$1"
+			for_status=1
 			;;
 		-n|--summary-limit)
 			summary_limit="$2"
-- 
2.30.2

