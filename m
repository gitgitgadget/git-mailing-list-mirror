Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC4D317701
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 23:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770679044; cv=none; b=dDo3QMDbJqDTkz8jL5FDbgvJj7Kho9dt1zu64B/55IktXjheQMppXgSukKbWRAUZ//OVAA3rHQqD4P9wcYC9oD54E82eVorCL5CMFPufAyt52F34K1K43C2jF3THB6Omw5ZCa2Le2SImm5v58JhLY0bAmIESYK0npK06ZGmcuFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770679044; c=relaxed/simple;
	bh=BM9uEcdC+hudU2S5Cte37dGjT5eObDiHy0m51k5unuE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pdWeACHNQdC5UMo2gd650w89LKzeCSD7UWLEWkMObS/gCZ8wipD9MHzsHXjWDHorgMpXDzt+a+9HJVvbQk6B/k2qNuh/LiSiVkQ0QLVGumd9ZYiIY2toQfQ25SyG46F4rRn9tYOe5Olrm20MMzfNh0wJgZwYqPjLsCZ1k1QltR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M6UXNyMW; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6UXNyMW"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-896f82e5961so2388516d6.0
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 15:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770679041; x=1771283841; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tSq0PNQVrqZsL2QTVF7Vs8KWfL+gIllTtZacy+7yqvM=;
        b=M6UXNyMWP+x5MsMLR8cvW9vVUZuH+1H4MOZG1j2ox5DkrMQ3ZxMmLCfXI/UwB3LeZo
         8HWtXD+MjY62FxKMza1IZeIDyqJY5u2aVATrfL35dQJePFYOHFt1iQvFdYvI61+n9NwB
         9PqogWRQ292B0fmN+tyRVsVS2ojOtkQOuhXzdsjDoDTei5MsWVBxPFDmvSpsLF/RusPw
         w8LlRV82wSQ7Pmcm+F4Y42houm1OE5sPTye3xkoNq9coiWwpR2Lz/cor4yy+1KkdDEA1
         llaL8DaLUx93SoaUNXZhmMSxG9UpM4FLfZpNpLvvVS0zywgQgawlhuDcAIq/eGS50pvd
         0REA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770679041; x=1771283841;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tSq0PNQVrqZsL2QTVF7Vs8KWfL+gIllTtZacy+7yqvM=;
        b=LXGsXs4h7UdY9AEwVTBnRJDOOzQ+cuSvd8vDZbSPPGVUyGqWIv0mePeHdH3E20Uxek
         NOd+1YjkMvR9NEjziuByhDCiesH1TKa4nLHCbqrnE0J5dSXyhN10xBJTYeQbjA5GHn5L
         Urhi4naYBcm6p0YJ/YbKxxZQJWc1H6FFWdpvReHC71Sjzzc+yasIjVAzftzLKUTUDILT
         YkasffTe/MJhD0ccX7qWtmU8J53XOr7HtZ+xsGJiUSIrbRzfDyHFBqBSJAuYqUh5w8bg
         jM5nnOcu3QUHRhQR29jx5T6IC9VjiOQHdHybxb741RPRCW4HjRrxxUSK4LQgL11JB082
         6Skg==
X-Gm-Message-State: AOJu0YwzxH8UuGUf5co5BeVEbXGCyuskTOoGgbX3p6Be28UmimNnHHAS
	MCTyrn6CHyhkwxuOk88ix87qjNWqvOxGPdxLHTh+kK5k4Uc/4EYMilIJE76z5A==
X-Gm-Gg: AZuq6aLlWTlSeBj7nh47Lc0Zw6XFqoaWxOsyqH7nv4+exTZss09eQ/oqihoh1+OVkRN
	Gf046puVG2Va5iX8DY0sDwKdQGwi+jXOEJNX41MmUhCpcezxhpINTNEu5U371dYpRSRs3qwmejM
	Grn4mpUFTeyY3k2sHxw8uUzBIaM1OG510Cfl4NKYyJPYuBEdI6M3PA+4mA9EpQwbcwg07CcWUak
	6eGSCK4yQXxZAKsLZuCJWU2D8UzrBYlYjWdYqUb2Gw7B/YOPsxIwND36SEarxqs+xzkErFh3PQo
	nUSBGBC3Uvmij5qeshX3PuSeDWNOYbIO35Y3tPb4QP84CKiWLliLkFyqLJTXAsD7N+gtaFG6M2f
	xDkZF6gzC4vM6rl95tp6PjRMFxtkV+vejmj6fttjrxsjHyF+MXamsH4qJ5FkKRmcEZGWid+cNMU
	tB5jh9MsoQDkQ8v0JiRTQSXfUF
X-Received: by 2002:a05:6214:5085:b0:892:6660:d758 with SMTP id 6a1803df08f44-8953cb97780mr185095506d6.55.1770679041558;
        Mon, 09 Feb 2026 15:17:21 -0800 (PST)
Received: from [127.0.0.1] ([64.236.200.85])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cafa3bff8asm904983485a.51.2026.02.09.15.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 15:17:21 -0800 (PST)
Message-Id: <ff85e97ceedd206f723061ced972b7b7ba431b56.1770679038.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2043.git.1770679038.gitgitgadget@gmail.com>
References: <pull.2043.git.1770679038.gitgitgadget@gmail.com>
From: "Rito Rhymes via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 09 Feb 2026 23:17:14 +0000
Subject: [PATCH 1/5] gitweb: add viewport meta tag for mobile devices
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
Cc: Rito <rito@ritovision.com>,
    Rito Rhymes <rito@ritovision.com>

From: Rito Rhymes <rito@ritovision.com>

Without a viewport meta tag, phone browsers render gitweb at desktop
width and scale the whole page down to fit the screen.

Add a viewport meta tag so the layout viewport tracks device width.
This is the baseline needed for mobile CSS fixes in follow-up commits.

Signed-off-by: Rito Rhymes <rito@ritovision.com>
---
 gitweb/gitweb.perl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index b5490dfecf..fde804593b 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4214,6 +4214,7 @@ sub git_header_html {
 <head>
 <meta name="generator" content="gitweb/$version git/$git_version$mod_perl_version"/>
 <meta name="robots" content="index, nofollow"/>
+<meta name="viewport" content="width=device-width, initial-scale=1"/>
 <title>$title</title>
 EOF
 	# the stylesheet, favicon etc urls won't work correctly with path_info
-- 
gitgitgadget

