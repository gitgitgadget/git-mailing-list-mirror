Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE58520DD3
	for <git@vger.kernel.org>; Fri, 16 Feb 2024 10:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708078625; cv=none; b=GzQKyis5UldKIwC883aB+ujf4D0DeOPT4GAWDLax80TmVoJuIeYrm4IIp/vDRsmVJMOZAjbzyLB1Cg0jYGRKRVBcrdjJqSPOzsNBulSym4Emlt9r3RSY0VLMsiDoDTp0lqnGyyFLB2OKf5sOvCeKTMiOjWKV5pL9e+ozQrZhFdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708078625; c=relaxed/simple;
	bh=Nwk7XZ3wl5kujZGiB5ysDIBfLybxm/JdCielk1eJFkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sfbEMePKvEFOqyxv9ApAwn/JpULMJfSZV/0T4u45W9p6BVeJdPzX+6lv2Ki7yP8U11G2eWF7GeL4BhYF4iohuAllkVhox7/GI9zOQpXhbqleSggMLysUTIOsEPg0QxO7mILV/dvPfYpxj1QfouqlyNXWAZXMG2kqIw8mceQOl8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org; spf=none smtp.mailfrom=kambanaria.org; dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b=QRaMxm8t; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kambanaria.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b="QRaMxm8t"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55a8fd60af0so2694642a12.1
        for <git@vger.kernel.org>; Fri, 16 Feb 2024 02:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kambanaria-org.20230601.gappssmtp.com; s=20230601; t=1708078621; x=1708683421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+AFdioYcdF1zchehxYiMSDvD2KuztVEpEKRhtMCiG0Y=;
        b=QRaMxm8txM4kscBsxvUEF1+czf3+DmWQ7Yu4KIUGPJj/PL7GqtkRZGgBEQVcMpGViN
         Nczq7dbZCDntPkxU6hfEL8cJNie7T3I1V15/viowgZFStE/nAgzhH/6n3E/peEY52omd
         3uZOd1FTqxzATkklFgFnPoQ9ObV1uQblpt5PJhY46C3l+BezIomXw7bYlmzXyhezqFOo
         vClXYikMfgzkP5ohkmviuzoubTrLqPmAIzLFpRYFNncW///C/bZlFyP3JNuLWPftEFKg
         17os73MQHnThEuURFSrr0PA7lHSXgRdkI0M3mqSQt117S9VkqHCogqtu9F0S485/SkmM
         KG0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708078621; x=1708683421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+AFdioYcdF1zchehxYiMSDvD2KuztVEpEKRhtMCiG0Y=;
        b=K6K9CzgnL7Jlxtaz6naq/bkNcO9TCL659gKeR4h8x6k3Wcz4OARrwcd0k9Wjdhun4B
         9Zfk5wYqWxdkKo38BvQAE6gs50RrzWrDPMLAWKGr99YVmslw6fWMAnfce8GA607OI+o3
         TotIeLf1Hz0S/NVZnfzkq8WhTeYO4deAccfnmvvFI2e84BqvT+9rkQ3eTAgM6g+58m+O
         zu2VvXYwS8srJ+ZA3ytwgiAzl//cuUkclci8iw+nclEBI9CAHFscW5MSqA6pFh1MiEPg
         s1F8JN7t3EUgMa/bRHvLi89vEVfQ4dYMN/G8MaTZgdfCKG4bu0lRMz/UzRDhxKKH4BF1
         25QQ==
X-Gm-Message-State: AOJu0YwmL1V+N1XP1RCoOZDD3yXvr9LdTtzYw7LPQAtCfrkCLBWz8HRB
	j4Oo1T9iRNsjXwYPETMSUU5yeViF2momtDExihvHsNISyvOVA9a5B5h2e8P5gtWQb1FfHyNJPCw
	dv7s2Sg==
X-Google-Smtp-Source: AGHT+IFVo4Ni/mcSIxlau5ONCAswSlnVar1eYLVC+znpUjsKlLFr1/QbVldXnqGXZn4ACR1CH4mpZg==
X-Received: by 2002:aa7:d604:0:b0:561:f645:aa88 with SMTP id c4-20020aa7d604000000b00561f645aa88mr3119933edr.39.1708078621414;
        Fri, 16 Feb 2024 02:17:01 -0800 (PST)
Received: from ashopov-C7P4TNH9MQ.corp.uber.internal ([165.225.240.192])
        by smtp.gmail.com with ESMTPSA id v20-20020aa7d9d4000000b00561fbfebdb5sm1337682eds.96.2024.02.16.02.17.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 16 Feb 2024 02:17:00 -0800 (PST)
From: Alexander Shopov <ash@kambanaria.org>
To: git@vger.kernel.org,
	gitster@pobox.com,
	worldhello.net@gmail.com,
	stefanbeller@gmail.com
Cc: Alexander Shopov <ash@kambanaria.org>
Subject: [Improvements on messages 4/5] builtin/clone.c: trivial fix of message
Date: Fri, 16 Feb 2024 11:15:36 +0100
Message-ID: <20240216101647.28837-5-ash@kambanaria.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240216101647.28837-1-ash@kambanaria.org>
References: <20240216101647.28837-1-ash@kambanaria.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bare in that context is an option, not purely an adjective
Mark it properly

Signed-off-by: Alexander Shopov <ash@kambanaria.org>
---
 builtin/clone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 315befa133..f0261bbb01 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -115,7 +115,7 @@ static struct option builtin_clone_options[] = {
 	OPT_HIDDEN_BOOL(0, "naked", &option_bare,
 			N_("create a bare repository")),
 	OPT_BOOL(0, "mirror", &option_mirror,
-		 N_("create a mirror repository (implies bare)")),
+		 N_("create a mirror repository (implies --bare)")),
 	OPT_BOOL('l', "local", &option_local,
 		N_("to clone from a local repository")),
 	OPT_BOOL(0, "no-hardlinks", &option_no_hardlinks,
--
2.43.2
