Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9AA13AD09
	for <git@vger.kernel.org>; Thu, 19 Sep 2024 18:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726770905; cv=none; b=HbwH3VzzrcymJeVoz6xcOShg06ULnqFwfdT6+gqsnHn8UGTM3/Hxc3vlpf55Txv5ch30oFjVYnAqfXXtLJshMsK/SXqkP05IQ50GBJ+8plHSi370GY8uTizmUT8fgmfEup63ER5oMSZmrfDCccrhHcp/EblZZUMQAdnnrwILvLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726770905; c=relaxed/simple;
	bh=zG3oWpkkQepZ06f8JdhBlH93Nokh0DThf9BH21/abjc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=tmCnPfsoInFTaAtPt3xSi1beXkpeWzY7NyJSUA9wH+e8qgdmIYDNDGlAHpxdbtPzroSHiTIB1Xgu6ixKfRWIg6ufV27nepCUaHJZSLEcszmQmWOjeu7b5TE3ydtYkF9XCM7vQc62GbPhdzCQ+ZTvSvwT2/PikB9Q+WIt6KoGA1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kqkLB5Ve; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqkLB5Ve"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c4146c7b28so1601455a12.2
        for <git@vger.kernel.org>; Thu, 19 Sep 2024 11:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726770901; x=1727375701; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EpFgXcS43eZ+IMbFFtdIlT1TJ/2SoW7CeJwiNSrqmr8=;
        b=kqkLB5Ve4WcSSSbrJZCLYNDjTuFNUEgntwe+KH91PLYIL640h1qWXiOHJhsctmzO5A
         RjwqXD1pxLVWConSH5VVEWEff/+HezUY168NPBJb4LTPLBamwcNl+CZYnp8VJZmmyQ/8
         12oSjSv6o7VZu7NK4LXCpC9E3hACv7gcZqzPl1q4PHupu5CzE+svZcI/v1Z09DoCriMz
         qfhR1+/U0v8mKrOzuNBylg7zx8X8lMMDF0DvAuRNOHH/t2lno8U4qdETYzocUO+fpYZP
         fEx4eQs9JL00zo5Q2HDfKZ+CvCJzi68kGOQb/aPJDP6CU8b+MlCNl3RiGR5eK2JwWxtz
         UQ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726770901; x=1727375701;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EpFgXcS43eZ+IMbFFtdIlT1TJ/2SoW7CeJwiNSrqmr8=;
        b=eippqv6CmLzb3GIRcPhWxKIFh/qL4/tqlqNdL0puSh6MWkKhNBJo8z7/sfrMsht5mI
         qo6ELmhEQYFvs4lC2Tefuoluh/rWQQF1JARxPWeJc8c89lq73Mlngj9gpMvrdpyAVMwl
         nI1IeY8+tfMRZIje42XEvrADR2UuKOIU8k+Rb2AMpCC84wqemtu0lp0jAvcZ0nBH4hEG
         FUs/mlgLeGxxFif1qBPy9cj9jK7Ckd7FSwluiZxirNSpN6sc8wid1DjO5oP5qZbNxfy1
         cLaswXFrdpzU9UWMlpA6WURah8kHvMrSH0TY9j+ez8RfvvX6C+uAEQn141e2vuUn1vjR
         Sa2w==
X-Gm-Message-State: AOJu0YxovXLb1tvwsoUIO8wBW/oAF2QwP9n5sIz0eSW9l4LbJLeW5ANY
	f1Peqrwfie5EXW9kUcs7oX97VGGeCNoN+uaIRXuA9zViLB8DsjtrW52rYw==
X-Google-Smtp-Source: AGHT+IHkdjqYyVqi9McsqNyFoxECzyLYtd3qcURsBBsAbQPUETC6Xk8LK8dcTXyRG0RatTXbNu/TkA==
X-Received: by 2002:a17:907:f7a7:b0:a90:3498:93b2 with SMTP id a640c23a62f3a-a90d55e1be5mr8150866b.1.1726770901351;
        Thu, 19 Sep 2024 11:35:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610f4450sm749635066b.55.2024.09.19.11.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 11:35:00 -0700 (PDT)
Message-Id: <0c21d4aa35b5dfc294cefc8ca2613dccca5c2e36.1726770881.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1794.git.1726770880.gitgitgadget@gmail.com>
References: <pull.1794.git.1726770880.gitgitgadget@gmail.com>
From: "Andrew Kreimer via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 19 Sep 2024 18:34:39 +0000
Subject: [PATCH 19/20] sideband: fix a typo
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
Cc: Andrew Kreimer <algonell@gmail.com>,
    Andrew Kreimer <algonell@gmail.com>

From: Andrew Kreimer <algonell@gmail.com>

Fix a typo in comments.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 sideband.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sideband.c b/sideband.c
index 4e816be4e92..02805573fab 100644
--- a/sideband.c
+++ b/sideband.c
@@ -191,7 +191,7 @@ int demultiplex_sideband(const char *me, int status,
 			int linelen = brk - b;
 
 			/*
-			 * For message accross packet boundary, there would have
+			 * For message across packet boundary, there would have
 			 * a nonempty "scratch" buffer from last call of this
 			 * function, and there may have a leading CR/LF in "buf".
 			 * For this case we should add a clear-to-eol suffix to
-- 
gitgitgadget

