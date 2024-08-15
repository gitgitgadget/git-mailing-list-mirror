Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEDB19DF8C
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 13:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723727661; cv=none; b=hP3iJ0/AOfuO+V1/op/QS76Do5A0GefOTUo3fYIYgegHefkkYELUyOFHubIEr0fqHox3tUh3b+Y29JFGqbMUF0rTAJ4X7oh5Os6jsNlsy++UUvEyTivr5gfaKugEJevmyVVtd4QSGk5iEQg8roTjP091fGDUmsIZHaChhR9ggKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723727661; c=relaxed/simple;
	bh=PeWD7Xzsyt+Jh9Nqsn4TpYWX2egoJFqBtWAUMS9nZWQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=QOKQPbnKZpOvE34caXL0UsHMNSKh7bryInspq1yyBSvAqMGAIb+P7Lyv0Q1KXBjBK51nJa2kVGffEX1sHO4Jxs7mhCg5VNtmx3oFrSnLC6Pz5IlNItYRmTo19HPPKhArwSqAD9NgOoz7vG2TZSLoOm53rA737/lfUiZX4kSQO1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jjSLJa8W; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjSLJa8W"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-429e29933aaso5902875e9.0
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 06:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723727657; x=1724332457; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bffUfw/AShNzuPzmr6Fl68h5i7kGOyEHgnQZYZFtG8Q=;
        b=jjSLJa8WLQXudrgBHXPxSeCfAX6Fav+fA8cChCKVWmSAiGq/duDsbm6FvBLKpQDP6v
         N1MKLM9AbqlG7CphTzj9vZLya63CUafBv+BaZqvQsbSCG3LiDTT9eUKRq6m1R9iHulPI
         7l1WqwsGi1I1w+Sl66qv0CXwtCcoL2RGvZ9ZCEuDUPVHK2EUXHnNj+E3RTukHirZ7uaO
         ULfxKH2Hc/hFkRIeKrerR/CnWWdFmeIygQARdf1SQS3GFn3pyrLE6NxMKPTkvBvcnVSP
         vOie0SRA87GRrZEXtNIF77Q0lWc9TXA8MM8RdctSZQIP5NkfP6C1HRmaahKcnWSZq/Ta
         YPHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723727657; x=1724332457;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bffUfw/AShNzuPzmr6Fl68h5i7kGOyEHgnQZYZFtG8Q=;
        b=X9H9Cp9xK6QByaIgbyLRtUNrG37j2CyIcxAC3kS9BRxC5guwKRn40M7uGy9/l/PyuO
         yueV478ByxmjqlSWpY6831RcouUO90y3okUhcOPVLLWwYwTdpvKB0pTcgf253L9MoRuS
         Oxj6wUrhAnhv+/2eb3adj4ulwFFCKH043DxGllK9FmZzH09788WRVj2yzU9P/GcgmI+R
         OjiLdxeyHZkI6qVIgpmCGrnGsqeFcfmj0NM7PBkEMm0wjzN7PvPksqfuBZhVmh6+pSqc
         Ck+dQ9dAKXbC43vrR1yUavWLZWnQEZVUQ6iyFQ7R5t+jygfyOuFXrlsY9tIUxQ3NemqN
         eypg==
X-Gm-Message-State: AOJu0YyBBzG/XnMmGTDtNJfjjxQFff2cBBsXD9o7gnwLfdWzAUoOfLrE
	3Fr6JD8BR5ei1jyPE4wrhA6UA/Fsn+t/LT18TKO0hSbHYFWVCS9k0Ch7sA==
X-Google-Smtp-Source: AGHT+IEgG8IQrbmwsQAYNToY7AVRpTmLEL+vsE45LEXebX07QUflQXnidlBHocB+I9nWJfmaew5OVQ==
X-Received: by 2002:a05:600c:1e23:b0:426:6e86:f82 with SMTP id 5b1f17b1804b1-429dd248517mr41803165e9.22.1723727656894;
        Thu, 15 Aug 2024 06:14:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429e7bfd917sm19737715e9.8.2024.08.15.06.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 06:14:16 -0700 (PDT)
Message-Id: <680ecb524040c64f886c4e484a64f0d17b512e27.1723727653.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1750.v2.git.git.1723727653.gitgitgadget@gmail.com>
References: <pull.1750.git.git.1721762306.gitgitgadget@gmail.com>
	<pull.1750.v2.git.git.1723727653.gitgitgadget@gmail.com>
From: "Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 15 Aug 2024 13:14:07 +0000
Subject: [PATCH v2 2/8] git-prompt: fix uninitialized variable
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
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
    Avi Halachmi <avihpit@yahoo.com>,
    "Avi Halachmi (:avih)" <avihpit@yahoo.com>

From: "Avi Halachmi (:avih)" <avihpit@yahoo.com>

First use is in the form:  local var; ...; var=$var$whatever...

If the variable was unset (as bash and others do after "local x"),
then it would error if set -u is in effect.

Also, many shells inherit the existing value after "local var"
without init, but in this case it's unlikely to have a prior value.

Now we initialize it.

(local var= is enough, but local var="" is the custom in this file)

Signed-off-by: Avi Halachmi (:avih) <avihpit@yahoo.com>
---
 contrib/completion/git-prompt.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index ebf2e30d684..4cc2cf91bb6 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -116,7 +116,7 @@ printf -v __git_printf_supports_v -- '%s' yes >/dev/null 2>&1
 __git_ps1_show_upstream ()
 {
 	local key value
-	local svn_remote svn_url_pattern count n
+	local svn_remote svn_url_pattern="" count n
 	local upstream_type=git legacy="" verbose="" name=""
 
 	svn_remote=()
-- 
gitgitgadget

