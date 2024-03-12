Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D1C58112
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 13:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710249298; cv=none; b=iUTd32RrTKbTtpc3svuWEus2ee+YkjXKe6D9LPnZWm4JQcZNqfXIjPsKvvDUmwyks45vCLzU9DL2wLa2u3ucVMoDdRlvxAq/CZJ6+XUwZlGC/e6GRrcrB1OZViwyS4Z3tsky5QxzrBlr1Dqsiz/gQ/4q0pUbcLMgMZWIIqUin4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710249298; c=relaxed/simple;
	bh=ZK9PuJZQXmxCrOY2MHL3UrU+Ohue6dc0TQ2bcUH+fHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZmwedVRmYqm6O4r1nWJMeQcX58At8VxbL61/ipTvFq/fSa6WPIQcDCCbE1WOL4BI76/TkoBMv+9IRa+2aO6duM0LOBeIikp4i+OihGCTTAR5l+hXX4HvLF9TjzlQDbp/3RMkmb8I5FQhWPvBKitFbeNWK3f3upw8TO8Webjug1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bz1wEQU4; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bz1wEQU4"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41332865abfso5415855e9.2
        for <git@vger.kernel.org>; Tue, 12 Mar 2024 06:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710249295; x=1710854095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=we7uoVi5lX0UHmExlkxCOTUXfU3jH5EUwDTrm8GhzOs=;
        b=Bz1wEQU4Fg4eZ+3pS0XAMC3rC51lqRRA6oOEwY07u0i/54P7zA39YA9zH8Si34M41g
         iZyrxFmf94Pkd2Ubenm0MIc17Jr9J0M2JnXhSkBBfqR+XFLI9Fcqxbz0VSgjBDZUBg5v
         0qtEib0MlqeoVQ52D9rHy0lnZoDJSxJH2uUMZZZQzPtb2haQRgoJTozprsBBJAO1DZqT
         sQIXEeWKDwKWcffupR8p6mWygvZbu4JaUiFsIoZcJrnG3G1QDGyzzRUDijMwpYMIUogD
         XW+x4bK3PezL4f3tjjQZEJIxhfo4aeiqR9cmhGz3Nxu8KP4Q9iw0UZuzqYwBxeG+Gq1C
         bI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710249295; x=1710854095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=we7uoVi5lX0UHmExlkxCOTUXfU3jH5EUwDTrm8GhzOs=;
        b=hrwTMuPr154SaxoTBBv+rMzjWfKpfEsbokwhKPdA86B27vO1DzRIohCfIXbmEvC8jO
         pbgXya5kdi11p7hTCxVMzOYJxLJPnbhBf/O75tQcgKIkLhXVh3mVnF3LhcQe1eHRPA3o
         fdfClx2XcsaV8/Wp9hbj2ulh2kpdOXC4u845JfL02zqEsjJOb6vnlRxquWDHOixBjYQQ
         YTHcrwAv6Yq7+dbQTq+CthHRMJL3HsEOIesxxvqPjZn0+8RmzCB/5Gu6CTd1lW5kc3Qe
         MGUGZnCNS3pUoHGOfg3g4XfTjd0hoNnG6uKnWHux8kSntomXjNTVHAnSCmE0wYe0UlX4
         4DzQ==
X-Gm-Message-State: AOJu0YyB5nz10BbhoTky5jCR+QM8jB5VGNx3uH12nyiy6kMazYUW4rzs
	dEDtPqfIuVcf5+20j0NGf9cvsu/P4881Ei7X5mkfjPU6J0ZTcrxadI5N0kVlmeg=
X-Google-Smtp-Source: AGHT+IF4zt0toN1s2YF4GZXknB9zVBXSJMqszxqz+XvsQh7p/bl4qb3S6tSAKFByhNVOVqXC7/51yA==
X-Received: by 2002:a05:600c:4f09:b0:412:f979:587b with SMTP id l9-20020a05600c4f0900b00412f979587bmr1398717wmq.17.1710249294931;
        Tue, 12 Mar 2024 06:14:54 -0700 (PDT)
Received: from host-sergy.. ([154.72.153.211])
        by smtp.gmail.com with ESMTPSA id l2-20020a05600c4f0200b00412a31d2e2asm12586737wmq.32.2024.03.12.06.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 06:14:54 -0700 (PDT)
From: Sergius Nyah <sergiusnyah@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	pk@pks.im,
	Sergius Nyah <sergiusnyah@gmail.com>
Subject: [GSOC][PATCH v2 1/3]t4018-diff-funcname: use test_grep instead of test_i18ngrep
Date: Tue, 12 Mar 2024 14:14:46 +0100
Message-ID: <20240312131448.638472-1-sergiusnyah@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <ZeWOhxBDvyjH8gW7@tanuki>
References: <ZeWOhxBDvyjH8gW7@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Sergius Nyah <sergiusnyah@gmail.com>
---
 t/t4018-diff-funcname.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index d35cce18a0..e6d2f1c215 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -119,8 +119,6 @@ do
 	"
 done

-test_done
-
 test_expect_success 'identify builtin patterns in JavaScript' '
 	# setup
 	echo "function myFunction() { return true; }" > test.js &&
@@ -136,9 +134,11 @@ test_expect_success 'identify builtin patterns in JavaScript' '
 	git diff >output &&

 	# check results
-	test_i18ngrep "function myFunction() { return true; }" output &&
-	test_i18ngrep "function myFunction() { return false; }" output &&
-	test_i18ngrep "var myVar = function() { return false; }" output &&
-	test_i18ngrep "var myVar = function() { return true; }" output
+	test_grep "function myFunction() { return true; }" output &&
+	test_grep "function myFunction() { return false; }" output &&
+	test_grep "var myVar = function() { return false; }" output &&
+	test_grep "var myVar = function() { return true; }" output
 '
-test_done
\ No newline at end of file
+
+test_done
+
--
2.43.2

