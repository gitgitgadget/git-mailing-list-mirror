Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C239715D5C5
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 11:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706788711; cv=none; b=c7h63G1LzPXdfj5cT+Cdzg3t3T1Bkn0Fu6Ea7Xdf+XYEg+3Cj2PFP/A2vCuPB06GUtJqJqXEoS6b+r1QdB+S3EQmM4q6Epq0oMAl9STTtpG/IZ+czFqQlOgQQgIY2gDoNCgpDhOb43/nCp9wyr521KrQSmhIsb6AdNC05+J//SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706788711; c=relaxed/simple;
	bh=aeQ3Erh/fbZ/PZ300U8hAloeC9Tfa3iEu8AJceU6/1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KKMsvrqKZ7ScMhDMt88xjIPn3z1VAfIaSTxjT1x+uhl1Cx5LPwnaz8zx7Y7k1W4udG0eo2T598hSyj3uUZfprdGgy1YeiTAbOee6Hlh4Db4Aao4d+xXudlMZJIuLLmHnFcF7qGSaZ9T2NWKHqN8Akxi2Sd6X/GH1H6uOeG6O6TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VMen5QQx; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMen5QQx"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51121637524so1112726e87.1
        for <git@vger.kernel.org>; Thu, 01 Feb 2024 03:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706788707; x=1707393507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kv+cJ7ob1td5pzKZwFqj5zOW6fAB39eybS77es30yB0=;
        b=VMen5QQxi+XKAptwFJVA2WifNN5cixnKzSNpmrOfPk7UbwMHOR2g9CJIeHY28JrWs8
         igzhAofJlYJXMoqvYPIXqJG1Dmhf1w0HwGiAPmHj58xAEE/Pe56NmZf20cMGMmqvky/P
         kG9fJTOh9bDSchI94xXKsbLJpa9tskrnMka7zqQ45q6gkudbdKgo0s4UlGiPD3Lr1vt0
         YdZE1NiWadCS9lsSt9+XxXO9EWTQSrLMxQVpO+SR85XrwGs5wVehr1svSPZhost6cfxI
         u+2iyLbs5DGeUwGt98AXxFurKZoehaT4z0XM2VDSfCN5pOWHSbEj5mhtp+gUb1g/dDOu
         //PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706788707; x=1707393507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kv+cJ7ob1td5pzKZwFqj5zOW6fAB39eybS77es30yB0=;
        b=rse4LAb5Ts56Keetstvba9Hbl1p0TJtPuYqrgYyUMX8yonE/KzOMlaP6qNrPJjh16y
         PoyB+WjtpaNO05s0QYs5t66GAmOf/RXw4R7d76cm4oBxks5p4cAiIXxeVOkKNQVjtrjG
         REZDA3pMiWXcJESFyJScNGipQQy8bnkghnUT2mIwU+/obAxqA/2x7q2ZbV02B0yoId53
         q5fy0h5VDCMfiW53/F4rPAb7t+n1SnufGSyzQWqrOjmc+kZ57mJ8yVtuTizSgMV0VcRK
         IJw2f98pKQtJbURRntwvOtEbth/r8fRi6/jaWwSI4qOz9C9QAEdXyRoUqL1AEP4whYG6
         fl+w==
X-Gm-Message-State: AOJu0YwtQgDG7WZuIWjEjBfVu+/AQ+QrbJV8sNYTGi8IwuHJ2zbV70aH
	9xhI3OZf7BL3NBHFHKf+ghOmG10LCKOms1p3Q3p7Gm4YgcbwPFbt4j04s9Zf
X-Google-Smtp-Source: AGHT+IHT7F/09Sth6L3oP0fqCQJHMZvllEke3miIDA8P59bf3ds6r7l6+aTeF4K0bozX5yMUTqlHqA==
X-Received: by 2002:ac2:558a:0:b0:511:22ba:c0a7 with SMTP id v10-20020ac2558a000000b0051122bac0a7mr1592830lfg.17.1706788706957;
        Thu, 01 Feb 2024 03:58:26 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV5aDy38cdfJ+UWW6PLClDxdENpPOhvrpOLD+BxdkfWleFRCsQnHM59utOkch9eQ7Qt9qVFIV5kUR4pS2rRY1TX2TRjFIGmA5DWfYscpru4LOFxRJjrA5DQMN06S+hJ2gmYa6yBLqn3QIdTfrKSpoGURGHmDVLV4bYs6n9QvCpgnL02cQ==
Received: from localhost.localdomain ([2001:861:3f04:7ca0:e1e0:bb55:1733:6146])
        by smtp.gmail.com with ESMTPSA id s6-20020a05600c044600b0040faf410320sm4113495wmb.20.2024.02.01.03.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 03:58:25 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	John Cai <johncai86@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/3] t6022: fix 'even though' typo in comment
Date: Thu,  1 Feb 2024 12:58:08 +0100
Message-ID: <20240201115809.1177064-3-christian.couder@gmail.com>
X-Mailer: git-send-email 2.43.0.496.g8be34ce359
In-Reply-To: <20240201115809.1177064-1-christian.couder@gmail.com>
References: <20240201115809.1177064-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t6022-rev-list-missing.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t6022-rev-list-missing.sh b/t/t6022-rev-list-missing.sh
index 211672759a..527aa94f07 100755
--- a/t/t6022-rev-list-missing.sh
+++ b/t/t6022-rev-list-missing.sh
@@ -46,7 +46,7 @@ do
 			git rev-list --objects --no-object-names \
 				HEAD ^$obj >expect.raw &&
 
-			# Blobs are shared by all commits, so evethough a commit/tree
+			# Blobs are shared by all commits, so even though a commit/tree
 			# might be skipped, its blob must be accounted for.
 			if [ $obj != "HEAD:1.t" ]; then
 				echo $(git rev-parse HEAD:1.t) >>expect.raw &&
-- 
2.43.0.496.gd667eb0d7d.dirty

