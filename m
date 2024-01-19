Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD283D9E
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 03:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705635311; cv=none; b=DKJZo7Nq1FJFqGvh4w1FkHc9KTdFS1zYzU1Ne7UY3t+AtOEXgVmuU2No+dUlG0n9GyyhCkMNGrNRUd2oKN7NiNMokivA4/zQQGPfA9ujWQVme6n+xvd/3d8sxLNjP2pJI1e6vDlLx20212+KHTc/ITlX3LAVcfLbF58vSdjD7oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705635311; c=relaxed/simple;
	bh=BVJEFqGPFviCvfskwX+QYquP79LmF+WzouiV1ead/CA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I/TtjdAEZpx0o6uiK1p7cGGPU/k8RJwr5Tif50cBYhXCGhPb+w0zHentQuYoSVY7G8TBuDrhtOK7UZhKDNFUl99V6bpzDTjyIDlSpXYmW+2JvDeclxNi0wnF3EIcuOF95umKIEgV8gEjZjG+cgZjRNA6n4ftJZ0cw91TtwCkzQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hKTit136; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKTit136"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6dddc655a60so230406a34.2
        for <git@vger.kernel.org>; Thu, 18 Jan 2024 19:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705635308; x=1706240108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=akwCkZXcPOyMbDrQl0hOKxdp5incX3fmfJS2n9NZb6Q=;
        b=hKTit136Yx4EBZ4ivNrkQw5+6JaoGz2hTD267yJHFK8xXoW/17JRCPxr8IHhbZNxUg
         T/QO1xJh6cITU+U1G6I97usQgaVckCg9swLyEQzN2AOzETzlSonrC1rdaL3hpCaSf7OW
         SHngkSiOU2dzZMmsWMjsh6NoiUJ2Yzl7x6KPZMYoXEBmbVDzZzdctKGCMk5iV5Um91ug
         QmoRmv0LKI8kTmSa9OOFtU6IcQwFuIFQaXvJpKd1JC7amNmwCQlTr3K7lutvyemTGtgQ
         iTEOyrNShvpAW6psQAwVGtedWcPItjZvE/KqnbVpqfw+HM/ML6VfeULMIioGlJdhyWrV
         m/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705635308; x=1706240108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=akwCkZXcPOyMbDrQl0hOKxdp5incX3fmfJS2n9NZb6Q=;
        b=q5OixK2hNRZKglU9E03RDdpkHtL3LU6cEIK7R/LZyWU7WhQ7Oj7B+Mt6qhpHWcra5I
         76AnPuUBrce3ram2XrtK3l6+RRtZQDizPZXAREu9HDbTwMC3YaGcJJUQ55dScBZLGOy9
         jovCHvoiN7myYcLR4mlHVKD7Z0Xzz/ejnRrDd6udqcQX1+XiQX2lrAsrKHpEkeBMmGH2
         ajNmpeyt5UAW/hoHhuHoSozKndC37ka21S8R6mnelbWYJmplnqFxn9LnFJKna0tlMIqW
         wqCzrjcUbsR4ok+BJ1Us3A0sl88b5C8hE0jSkOxGJIPQNZIxEbA5u711ZJ+Z4B3nUEhR
         vKpg==
X-Gm-Message-State: AOJu0Yxbt9Lhksu1Wkm9L79roquJgexLrD9lt4sr5V8ASyrJ30vPiTuK
	XSJVyVNaHQHbYIV2xUMwCpIDBpCGqSfIp088vDpBlTURfSWAMPspjeMGGkkR1zw=
X-Google-Smtp-Source: AGHT+IGy/lDD5dhJR+BLuEi6sHb8hO54HU8qRaOf71u9T2dhQnCU8V/pyoWnNsrwuCiEH0RFODmKug==
X-Received: by 2002:a05:6808:14d1:b0:3bd:a285:f667 with SMTP id f17-20020a05680814d100b003bda285f667mr734347oiw.78.1705635308295;
        Thu, 18 Jan 2024 19:35:08 -0800 (PST)
Received: from localhost.localdomain ([2402:a00:401:a99b:65e8:f5a4:7adb:5726])
        by smtp.gmail.com with ESMTPSA id d23-20020aa78697000000b006dae5243740sm4002797pfo.60.2024.01.18.19.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 19:35:07 -0800 (PST)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: [PATCH v3 2/2] t0024: style fix
Date: Fri, 19 Jan 2024 09:03:35 +0530
Message-ID: <20240119033410.12688-3-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118215407.8609-1-shyamthakkar001@gmail.com>
References: <20240118215407.8609-1-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

t0024 has multiple command invocations on a single line, which
goes against the style described in CodingGuidelines, thus fix
that.

Also, use the -C flag to give the destination when using $TAR,
therefore, not requiring a subshell.

Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
---
 t/t0024-crlf-archive.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/t/t0024-crlf-archive.sh b/t/t0024-crlf-archive.sh
index fa4da7c2b3..a7f4de4a43 100755
--- a/t/t0024-crlf-archive.sh
+++ b/t/t0024-crlf-archive.sh
@@ -20,7 +20,8 @@ test_expect_success setup '
 test_expect_success 'tar archive' '
 
 	git archive --format=tar HEAD >test.tar &&
-	( mkdir untarred && cd untarred && "$TAR" -xf ../test.tar ) &&
+	mkdir untarred &&
+	"$TAR" xf test.tar -C untarred &&
 
 	test_cmp sample untarred/sample
 
@@ -30,7 +31,11 @@ test_expect_success UNZIP 'zip archive' '
 
 	git archive --format=zip HEAD >test.zip &&
 
-	( mkdir unzipped && cd unzipped && "$GIT_UNZIP" ../test.zip ) &&
+	mkdir unzipped &&
+	(
+		cd unzipped &&
+		"$GIT_UNZIP" ../test.zip
+	) &&
 
 	test_cmp sample unzipped/sample
 
-- 
2.43.0

