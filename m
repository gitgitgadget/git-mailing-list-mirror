Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E6A1CFB9
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 14:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712413981; cv=none; b=eDY4BuLtsAMhlv0LYzmuyfIPUa8/uHJNtbl2QuMzuz285Ydiz+qPI4z0lZ33Y6smYuGbtsp4luJdvj/OU8nwsj21IKXGflSMcW+MeqklVwMKARPCjB3KLujD4fpSM6daFJc1Ge2ON1EADMtQazhZT+NMqBHJSapd+nyqXf2vzxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712413981; c=relaxed/simple;
	bh=aQNaT/KZZgTupuJKHEjNeWIPEKvUisMwuqkvuA8dR/w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=DBYEwWe8beZ/HFhC9n7/R+1Qj7BWfwNqe2sTA6eQHjULcEuJrxZzUzf0tPavdsYiMAis/Gx2UsYI5/wzvQn2yWoc+Zg8nzypX7Km3s5T4gz0eTuO5wE7wyy14wYAk2oH0piC3YK9dHx9/MuK8TMJUIC5SJBiVm+Y2X89WR6AxP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWV1UPE7; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWV1UPE7"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-343cfe8cae1so1555756f8f.3
        for <git@vger.kernel.org>; Sat, 06 Apr 2024 07:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712413978; x=1713018778; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w/igucRLj4B1C+6BQp1nIsOKQYN7Mcng25kDVNBj6do=;
        b=YWV1UPE79Ax+vpngCOhxKQDxERvCGVKkTM1VWifnks7Dzs/T+eTOE4YjrKGRS37nAE
         /Qzz77NFGglacqSQG/kyzlJ8YSjug+nWyEXXevbmgYodYplLOBqozY62GD3Iq2fm1KNS
         Br070H9ETUiyoWArokaKT2KDnAspXkIe6EbTQcd706nH+WL6EM2IAauvjfWm+uQi+syX
         saWKFVx6/tzZF3C5SwEEoma3Pqkq9HK3Zu7pFOduNg2vsC6LFQsT8FclE/9onPm8RHkV
         J8Xtr2RQoty0rCLOGLwhMO6vZsZI8tOnjloETPt3SMI+6nVTUCcUQp/AQHVrVOC5o5Pp
         N00w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712413978; x=1713018778;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w/igucRLj4B1C+6BQp1nIsOKQYN7Mcng25kDVNBj6do=;
        b=Y19n3w0RK5U6tAO4AJY6VgDDnE3AaHOLSjGpI1vtXL8B37SJDlVn+HtFmrMX5hl5bX
         jma3L1GM2oQyOI7O6Mdw++Ws1C05WsqyV4ifZDi8RxDPYHnp5XBLTIZ5Hy0uWgX/oggE
         4YssIp0jyEgYOaN3dgUYJcFmQHO1Qoxj//LZL0DEIYJnvTJeNA03rpVvgXSnBAHwPGwf
         mo5spE4mZ2d/xUHd93VKz341vJuXNTeZfQ7aT/f9QhrFRthlSclIBeKdTqKohaJJFee0
         ZnGN8XX5x5exRjWOhiCuj6FeEhVKXvd0gN/o6E9CiqTe2VrBSjpVadvX8wzPznDrPyU1
         ym+w==
X-Gm-Message-State: AOJu0YwkY4Rm0bVnfRYlXI7mZX+B/mS/7nTse1txPDUGEjGSooSHSnvG
	mGptYKOVAxYuIxABCQwR98KQnKP0/3Rn49XG8Vzud/GZhdU+ekMCaGsgeb5J
X-Google-Smtp-Source: AGHT+IFe9yi+t7u1AmBSSwfk2ONpJd+MfnsF7pzKNBVlRsDTbUF6XAUdPIzE7rAY7HsvEZNrbcgFJg==
X-Received: by 2002:a5d:6348:0:b0:343:ab10:f31e with SMTP id b8-20020a5d6348000000b00343ab10f31emr3060305wrw.42.1712413977973;
        Sat, 06 Apr 2024 07:32:57 -0700 (PDT)
Received: from gmail.com (4.red-88-14-47.dynamicip.rima-tde.net. [88.14.47.4])
        by smtp.gmail.com with ESMTPSA id s7-20020adfea87000000b0033e7de97214sm4592137wrm.40.2024.04.06.07.32.56
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Apr 2024 07:32:57 -0700 (PDT)
Message-ID: <7f759a5a-ae25-4f2b-a38e-4d0d786ca3bc@gmail.com>
Date: Sat, 6 Apr 2024 16:32:54 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 4/4] t7300: mark as leak-free
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
References: <f4af1e88-5bd9-4b3c-8691-84dbf0ca3ee2@gmail.com>
In-Reply-To: <f4af1e88-5bd9-4b3c-8691-84dbf0ca3ee2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since the previous commit this test does not leak.

Mark it with TEST_PASSES_SANITIZE_LEAK=true so to make the leak
checkers happy.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 t/t7300-clean.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 1f7201eb60..0aae0dee67 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -5,6 +5,7 @@
 
 test_description='git clean basic tests'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 git config clean.requireForce no
-- 
2.44.0.697.g9b33b46f29
