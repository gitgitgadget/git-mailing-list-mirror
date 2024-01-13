Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F68DD282
	for <git@vger.kernel.org>; Sat, 13 Jan 2024 04:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmYQbSQX"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6e0a89b98e4so544606a34.1
        for <git@vger.kernel.org>; Fri, 12 Jan 2024 20:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705119798; x=1705724598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iO3M97Q1nb17xrjsGll1B39pV+CaXNSWtnoe2H60siY=;
        b=kmYQbSQXvA8gRh04oH+18FAPD44XmIeSRPt8qKWk4qona2QLble6TL6hCnXJlZWdg2
         sCqHQ9bEzEpUEPWePLuIUXJVseJ70nDPKxflSZamLjtJmlFI/ARuQtco6BaVx+12mdUs
         0wQZW7onfMNNKT3DrJHtSoy/xXgIj5KvWi/uk+V6MDYUvhJe67xcdmRNAndcfqqhJo/a
         czkK3cCthfNbU03RtK3V47lJ29xPh20nD56HnFdez7RxZ1jxGvdGK7xeSQIxmC6KUjXL
         wf3M1d2DpuslWZQIjn+1RDKR/VsvtEKrE8Qtj21tMmmFcHzQzm9NQq4EDJagDgtZLnnw
         vv3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705119798; x=1705724598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iO3M97Q1nb17xrjsGll1B39pV+CaXNSWtnoe2H60siY=;
        b=jjP8Nbn5SQy5ELLrSAEhdYLQ5f7FZ2DTamI3SCx0k0kn6FEoLcHqFEi74KEbUuUWHO
         3AhYdI1Hnhs2HArNcWjqHYtyy1wtDGhj4jK/8KWNnpIdwabSCoc1BGVq6nPZ54rSwgcV
         zfU9S8Eig++r0wdNxWmAwDtUm6/WPm0VnY/S8vP6v+RwRSni8T/gAK2DT1ClD05wHrGz
         t98tOslexXgYA+LbXABwe2pXubGxi8bEcWj2tQuIG8AjBOFuywLJt/Fk+UdJ+csLd+Us
         +AqO+FttWFwsj+xZP97r9SLzn3Isy+d+SlZNKt/nwptszUhC47L5g5ozXJwzpSMaU2i0
         /I4g==
X-Gm-Message-State: AOJu0YxrJPyyO1AP2I5AQzLuMuXY3lu14GbmwwKx1JVsy2903bJ3qqOg
	hdn78kJaSEqAbiHJNRjDwn1G3K6s7nV8rJ9N
X-Google-Smtp-Source: AGHT+IHZB7OIY05lIvv6c6Kb1UOpVisRMS+3UlEwBAPgIHrPWkCrdJJj89JS4tTsfn/riQ4DCBGicg==
X-Received: by 2002:a05:6358:c611:b0:175:8c20:cad with SMTP id fd17-20020a056358c61100b001758c200cadmr1927682rwb.0.1705119797589;
        Fri, 12 Jan 2024 20:23:17 -0800 (PST)
Received: from localhost.localdomain ([2402:a00:401:a99b:65e8:f5a4:7adb:5726])
        by smtp.gmail.com with ESMTPSA id gx18-20020a056a001e1200b006d9a1812e35sm3899385pfb.119.2024.01.12.20.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 20:23:17 -0800 (PST)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood123@gmail.com,
	christian.couder@gmail.com,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: [PATCH v5 0/2] t7501: add tests for --include, --only, --signoff
Date: Sat, 13 Jan 2024 09:51:53 +0530
Message-ID: <20240113042254.38602-1-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240112180109.59350-1-shyamthakkar001@gmail.com>
References: <20240112180109.59350-1-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The v5 of this series updates the '--only' test to use the for loop
and >> (append) operator to test all three cases (-o/--only/none) via a
single test.

This version also documents a bug found via the previous iteration of
this series, which does not report error when --include is used with
invalid pathspec.

Signoff tests remain unchanged.

Ghanshyam Thakkar (2):
  t7501: add tests for --include and --only
  t7501: add tests for --amend --signoff

 t/t7501-commit-basic-functionality.sh | 100 +++++++++++++++++++++++++-
 1 file changed, 98 insertions(+), 2 deletions(-)

-- 
2.43.0

