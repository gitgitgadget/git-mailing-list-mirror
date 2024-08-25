Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC27179A3
	for <git@vger.kernel.org>; Sun, 25 Aug 2024 10:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724581192; cv=none; b=sVduakTmpZ7JrRdVwSEuCBzROIaU0q9LFUYpYptdrP5t95vI1hbjm1eA/Pi/iDSkfS9gkgZmYzBwrbLjb8lSm04cf3mQsSI02zwUTCNUUG19Wstjx+KCAWzHlikuVFifrtWaEHqIgzCJlvaL0x+RGIJRHMkN0r9L/PaI2exusFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724581192; c=relaxed/simple;
	bh=+8mUh4ikACYE6Y+hFVmPIXhLYF/NUhbNP8roILicNVw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=C+hDp4uSYYbjurdCPGrinypgIMbG2g/2mdeZuSEyxltHs/inU3JRidnovNTPEAf76gq1Bf8E+LOOt487sudu/n+TY1AHFzArTAeMnaiTvKcfCUBtJsLi9iNqraA2Y00N6PIRHfXXPnlTYQ+up8Wz1jJoZWVuwgMOff9Yl3G2x2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CAEcqacJ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAEcqacJ"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-429da8b5feaso37437895e9.2
        for <git@vger.kernel.org>; Sun, 25 Aug 2024 03:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724581189; x=1725185989; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mScbObV+wgVrVsORXzt/+3i+eY0eZ+MCI9jiH/7mAuQ=;
        b=CAEcqacJJek+YhqHe0rSZEBUo1uUi+GUEAodBH9sZvin6pYSQNe8gexPMxOWzdHohb
         4NUld8xnhUOF9tnWhGsaKf6UxxUmTStn562du55dDFTyeBRmZ3CYwu+sbOyibjDn73Qo
         NOwE3sGe0O8tL4EgA2j8AvGOLGGGQZDNPJUrTY3sVoNoBHjkfQafa/RafN7ycNfkMy9T
         iaSNcVReNj9vlMEHlsZcUaA0zUjW6aqefT7tIZ2LOF4D/CGbONd3FIyjWz8XyQHRTDiC
         mCQ4xnMTKdiT2QI+QOS74GyHJsffE81oO1j3qmLWaynxv8+TRUgzsmIcWYXFZr7Fqfrs
         wVnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724581189; x=1725185989;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mScbObV+wgVrVsORXzt/+3i+eY0eZ+MCI9jiH/7mAuQ=;
        b=WjBfQCpwNYZNI6ruqrOrwQCJmDU9yWhkD3au8tslAWdzTgnMVTXA0P09UpuSWd/oBj
         78Bqi96Kn+xKMzRM7p/nn1aCKPBEvbm9Jyhgwsx+q3E25cFHvMxHX3HA6inYuWt1g5j0
         wRVU9qv8o+8xH7iWVbMoFuJ0UC+Ec8DRSGBHYqCjKChwBdk1kLhpWMCYPp/gkgMo13Ob
         K41vjwhJE5sqfh1rWZvQm0z0ebnJiQUwUhTTx+2z0ytvDzrzZxpiAdZ6+VmsCHcLGYh3
         ngJfPQ2UdFN1KF8skiE8iUBC/MyE8wxRhnPDA+6Sl76AiXkUfDC5KtaMfmTmiE8jPjqi
         Q1/Q==
X-Gm-Message-State: AOJu0Yyouf1lH5psiouHP5TJrjYVXWDigjQ22tgVZ9Qglt2jAPlJup8E
	5siIyVcVUPeor30XgJadTkkLrRaQZCrG6gnOoo3zcV+H1+xiSI6Yldq0ww==
X-Google-Smtp-Source: AGHT+IGRna8Xv1atjnVhYBs1L8rw6xadOj7fVoIKgN4uK9FVtISpNaMoY4P0ve0RMan+Uman8+qhKw==
X-Received: by 2002:a05:600c:4f83:b0:426:6ee7:d594 with SMTP id 5b1f17b1804b1-42acd543423mr50999815e9.7.1724581188842;
        Sun, 25 Aug 2024 03:19:48 -0700 (PDT)
Received: from gmail.com (107.red-88-14-46.dynamicip.rima-tde.net. [88.14.46.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac5162505sm118581825e9.28.2024.08.25.03.19.48
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Aug 2024 03:19:48 -0700 (PDT)
Message-ID: <4c0c05a2-c143-43b4-bc1b-d70b3645c702@gmail.com>
Date: Sun, 25 Aug 2024 12:19:48 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 5/5] t4124: move test preparation into the test context
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
References: <6dd964c2-9dee-4257-8f1a-5bc31a73722e@gmail.com>
Content-Language: en-US
In-Reply-To: <6dd964c2-9dee-4257-8f1a-5bc31a73722e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 t/t4124-apply-ws-rule.sh | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
index e12b8333c3..56f15dc3ef 100755
--- a/t/t4124-apply-ws-rule.sh
+++ b/t/t4124-apply-ws-rule.sh
@@ -423,14 +423,8 @@ test_expect_success 'missing blanks at EOF must only match blank lines' '
 	test_must_fail git apply --ignore-space-change --whitespace=fix patch
 '
 
-sed -e's/Z//' >one <<EOF
-a
-b
-c
-		      Z
-EOF
-
 test_expect_success 'missing blank line should match context line with spaces' '
+	test_write_lines a b c "		      " >one &&
 	git add one &&
 	echo d >>one &&
 	git diff -- one >patch &&
@@ -443,14 +437,8 @@ test_expect_success 'missing blank line should match context line with spaces' '
 	test_cmp expect one
 '
 
-sed -e's/Z//' >one <<EOF
-a
-b
-c
-		      Z
-EOF
-
 test_expect_success 'same, but with the --ignore-space-option' '
+	test_write_lines a b c "		      " >one &&
 	git add one &&
 	echo d >>one &&
 	cp one expect &&
-- 
2.46.0.353.g385c909849
