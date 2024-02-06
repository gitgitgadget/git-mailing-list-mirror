Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D886D5677B
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 02:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707185376; cv=none; b=Y4Ede0oTVDz8Tc1p13rviOXlpYzvpcWgfw4jZA40RXFNExqaVyV5r2FD20rxxJf2DEtUZI/R03AAW9+vUkDlvRnWDiczRr4TTWz2VVqz/3tGR3YKO/zAdETE3muFouGfwI8+OFGq+9F/D7FLV/izynG8+hLRPWxGIaEDEk/GjxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707185376; c=relaxed/simple;
	bh=6h5e1f3ZIeMJQUz8oMhboJbNf+tiaXGt48DYcgHkjUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t9TATIzgKhOJOMQWQSx+9avOGkLSJWW4bfaUIx5Z8HcmMCjXsRz++knjjXTRqboqxQk0lbHqRbsk7hpxYV6oxnV2P5NIMCnr75o7NfHAdx72Z5X/gAEqGpjXtNqdfp2Pt/Lkd47/D0K8qSoDpQ6oHQ+DjVpoQp+Cu2taHtiRB5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZDFVy5H; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZDFVy5H"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso4230653a12.3
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 18:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707185374; x=1707790174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mtZl/JLBY55f0TcDPFOUW1HtKEHIRTFgF3o82xinFE=;
        b=TZDFVy5H86QaB6/oeyQEppk8UzHn2+so8YRmescoIp/UJoDPIPWsAvNP+KhYMqKUlC
         hz5+vKXaJAknP6g73o6F5JEZ38AzkHsjuAqHf3kewpphKgIzAkOy7PE4iC7aY5MEX56z
         Rio56vXSK72pewzriwyZYLg/WJiV8SlmQr9fuJg5KsAF+nECGVWBmRSN1/ZNVG4aHwYX
         exTls209jnNMBFj1HZCDhnEF/6pjkg7+yuDzz3mdZoYnab6IYyTAiA4ecTks8MhLa4ti
         hqNSXErwtxuBVDob5gPK4uC1eEWjgyJkeeFNUL4T+vqJ9ryRJhk5bS3RN30CjCAgZ9cA
         WEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707185374; x=1707790174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4mtZl/JLBY55f0TcDPFOUW1HtKEHIRTFgF3o82xinFE=;
        b=mVa4j+SqqkCRFh3j1qypQdntYqr7V3baP87L7/JalVaZ3bxlsxBi9640g2gMZV5Tdx
         JdfdQJRdzatWv89Qu8Q2IdAriqKV5GbE2pCHLlTG/mP0hHZ3iJulZkFPPl14tcxO0RSN
         E3FdyUzO0MhdLY8h7wzmFztSxSHyiTEzP4jkvVfs7x08ouHkP20KpNQKy6Pp2taXvzqN
         IdxxGt/B9cWMGu5JJRV84Z5X1Dkzb3mHiwZsgrCLV4PyybDWCFELUOSyh8/5UNXmssH2
         Su8h7/yASabTdinKdMHMcjON+onds4zjJloaMbgqxLR0uSNBU/DprjbPn3ezqD1iliyq
         M4wg==
X-Gm-Message-State: AOJu0Yx3nqQvb64F40mWy9o4aJFOxwVYtfKAZwvCsnLmeoD81VL6e93r
	1XrIQjP/tS+odjkSPo/PqLHE9vAKWfKgoqmBXBfn0JYHdWl/YPMXsmQLBK7H4JI=
X-Google-Smtp-Source: AGHT+IFB7ZNx9+A+nNHKVflB+VjnTGqvfQx8MS+JR99DXS73gTnFiCXKXvoncB+ruJHtweAMgsbLng==
X-Received: by 2002:a05:6a20:3ca7:b0:19c:64a5:2162 with SMTP id b39-20020a056a203ca700b0019c64a52162mr337799pzj.20.1707185374106;
        Mon, 05 Feb 2024 18:09:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU+CwgdvX5FlWElfMK86B2ddO3Y/FXE5oH8uoz7JCY0i3N1/I8yuLjUNsPWCPP8cyoZRYag2cKEu1xpmxApkMJO03IX1cH9a9LdOwy0AJDNwCSz
Received: from brittons-large-Vivobook ([2600:380:4635:872e:d8c9:9f5d:4e33:1b6a])
        by smtp.gmail.com with ESMTPSA id js12-20020a17090b148c00b002960a58b04bsm190485pjb.28.2024.02.05.18.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 18:09:33 -0800 (PST)
Received: by brittons-large-Vivobook (Postfix, from userid 1000)
	id 76BE0520288; Mon,  5 Feb 2024 17:09:31 -0900 (AKST)
From: Britton Leo Kerin <britton.kerin@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Britton Leo Kerin <britton.kerin@gmail.com>
Subject: [PATCH v5 1/7] completion: tests: always use 'master' for default initial branch name
Date: Mon,  5 Feb 2024 17:09:24 -0900
Message-ID: <20240206020930.312164-2-britton.kerin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206020930.312164-1-britton.kerin@gmail.com>
References: <20240128223447.342493-1-britton.kerin@gmail.com>
 <20240206020930.312164-1-britton.kerin@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The default initial branch name can normally be configured using the
GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME environment variable.  However,
when testing e.g. <rev> completion it's convenient to know the
exact initial branch name that will be used.

To achieve that without too much trouble it is considered sufficient
to force the default initial branch name to 'master' for all of
t9902-completion.sh.

Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.com>
---
 t/t9902-completion.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index aa9a614de3..a5d4e900a2 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -5,6 +5,11 @@
 
 test_description='test bash completion'
 
+# Override environment and always use master for the default initial branch
+# name for these tests, so that rev completion candidates are as expected.
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./lib-bash.sh
 
 complete ()
-- 
2.43.0

