Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC1047DFA3
	for <git@vger.kernel.org>; Thu,  8 Jan 2026 10:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767867572; cv=none; b=oD9aSEU847f7eH58xUDFDV96pYQC6EP8wCfsxJYgyZY88pgnIqLzmB8+fP0MxpkJ0qcuyN8Ejw8PiklXUcydzjh37+lvXyXOZVBemTZ3He6Wp+BQPjpm5YtvbOmDUy8WvvrKUtLDCHKfFRDSHxVMkSbdHt82nle2/zVHGXFrrnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767867572; c=relaxed/simple;
	bh=82hH5YYmkFbLdcNTjYmilzDKrB651scZCTMtN6O9Blk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JseYWjHPggBZzrgKIn+MbHfXdCXRN5TViVQvYwi74sD7QSddgVzxFq17Oe0ckrZdRZj5oYPKK2fR3aGLxQ8ae1Ct76s5RTlcPWeCoraoUasYlNLTqSYJiiyrq1/xegn9kZlwh0i3ePcNOdZRBpAMAyWBrT7lPgiytEqn8f4HXyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C0vfbFPh; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0vfbFPh"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-59b6c13b68dso1308290e87.0
        for <git@vger.kernel.org>; Thu, 08 Jan 2026 02:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767867568; x=1768472368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=82hH5YYmkFbLdcNTjYmilzDKrB651scZCTMtN6O9Blk=;
        b=C0vfbFPhmSMushCFX6uXC/NdpEmytKF9aCo28slsGPd3veUEPuxyZYXtSJlRE2Zy7V
         Y0KNGg66l2HSxDZodDxhSVC9aDuM1IpQeQR6LgOQBa3fdy7CjQcHwIoodcNp/63CJber
         NrKbsjzMFvwOJ7FE72e+gVFbE1z5XCXp9OV2675jCnQ2uR5oiy4XUuZkmYxe2YD26sha
         LnviXAo7qkWjEQAEvCkfh7Zhy0gmMcgyJFIc+l93+OSGeyLyx9SMXGFLbUZwoOnwPpbT
         ngO0Jj/doBZx9HmB8nxfrRHd5PTyTK+3PHHwv1OwCAFh8V87e5U6dqc9EVjsWCETLwLK
         gRrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767867568; x=1768472368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=82hH5YYmkFbLdcNTjYmilzDKrB651scZCTMtN6O9Blk=;
        b=jCmyzEdEdr967L1KmYbAf4zP8wPpgJCdLInqVkYstzGjnmO6nKUIz4E93WkqLRTwo3
         0sBRkxyM1SaqTpEkQisnsPibxHM9d8EiUE4QssFy5uEjNv5H7nQiX8bOPIfVRdXE6uSf
         LE2m7dbdlJNsNFsZ6edoA/g6phKY5bFbEaFLGeBmGcWk2ZyqJm3I4Pz6dw2uZ69s2Vu6
         hMfkTir5V4cX/RQ9xAcRNOYr4m/SRzHWXYTTTffpBMukepq9Ys+v6rZW+okunB0cUrNt
         uu5jLUwkM4uAWcZPuRtEaGgXFpEgxJFyIcc45K3euiOBhgC2Vkfiqfy8ByGI/T0lLrJG
         T8SQ==
X-Gm-Message-State: AOJu0Yx02nfnW+ohoj09iUFDhYhfl3gVZAFSCnrK9nfW1hresX6EEmKR
	YJeQ6NXVBoS/5T7Y3Kbtd+zLLb0jvYokxt4xv5FzHA7sxNEntB7McGKw
X-Gm-Gg: AY/fxX49uVX/xxZFjgAZy6SEf4MUgsi5iPAl5U0Di8fcChffdCsL/92CDCZ/Z+VEbBz
	dYgS+T+bNyRoJLv6zyYM+5Q6svkAYg6heO4SoLwK1Z/krO8E4iqGamGCBSK37oger6EYz4x4Iw3
	RMhGuemym+Rn46gKlRDvEYoxAVlwuN0eDUfcsOdSTS/kX43itnTSk7NA6Cf3FkPLonYilvTEcCG
	6pqkMrK208NISAINUQ+D1TqQBJIIanF5ayjuJMXe8ATxgZpEB0T8IjQnZx0ygmQv1+afEh1VIz3
	ae4YN5aqAy+JWKI+cNdJsx+QiCBjA9v4bo1iVBgRs3Cs2rOMvQ/0kmsa4Q9C8M8SjvBjZXN4uH8
	9EmP+YSZlS8/sqrMRnGDw4ykBeLWIg2IV90CvdLHXjff4b5IscdoLMOYwi36Xj0X6F4mKircHys
	CrhXmY7QpQKgKq2iO4Y8wBrArC+OqMAoB+DqA12OTa8kAFGSvue5z/Ty3fnSJGmSaIZGLyivjK4
	AmX
X-Google-Smtp-Source: AGHT+IG4tp4hKJfRYpEHaMm6oszkH6dAsw8vmdFMSt/nyvJgnGzls0XFuU9A7MfW6TLjt8sEz4supw==
X-Received: by 2002:a05:6512:ac9:b0:59b:6a14:569c with SMTP id 2adb3069b0e04-59b6eb16919mr1800982e87.6.1767867568247;
        Thu, 08 Jan 2026 02:19:28 -0800 (PST)
Received: from localhost.localdomain (h-98-128-149-74.NA.cust.bahnhof.se. [98.128.149.74])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b72af5ed2sm942968e87.58.2026.01.08.02.19.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Jan 2026 02:19:27 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: haraldnordgren@gmail.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	gitster@pobox.com
Subject: ABQ
Date: Thu,  8 Jan 2026 11:19:26 +0100
Message-Id: <20260108101926.94715-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260106000814.58893-1-haraldnordgren@gmail.com>
References: <20260106000814.58893-1-haraldnordgren@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi again! Could this code be ready be the merged?


Harald
