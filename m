Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A77C646
	for <git@vger.kernel.org>; Fri, 12 Jul 2024 01:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720746021; cv=none; b=I+MdIc58kjGrHCjONpt5DWzZum2t+p25lhvhtQl5MJ4b/hq+vDrGeTsIjO6TAzsK8JQowpSL5w4lnn2SpmQWBuIY+KHFf4nA1GlExc5JwjAOuRumzoGXmKFh6JJWQHtts3sFFGhaWNI80YFfrB8u0Y2O4BiSRu8aihUJrTXxp0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720746021; c=relaxed/simple;
	bh=pq5h937NldnwmHI/rommp8BHys2iI5Xt8KKHto9rOdE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=LfY96UlmkhVx9mfGflzgSm4keo9MWVKKb47iwKYD9O41y1PLRYHWpXuqo4fs9qaQCOpR3zwusR6VtAhf83pPd6m4nXr4KwVnUeTLmrsQ4oRR7FfB9XuG8ADpaIxGS9tAm3IJykzhTNo+oqdEoKfDHqnLA6FF/mhBbSWkXHXKe5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGs0aB9y; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGs0aB9y"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-70b2421471aso998834a12.0
        for <git@vger.kernel.org>; Thu, 11 Jul 2024 18:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720746020; x=1721350820; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/S/2IwA63oCbT4wEpXHln9cmhCR478Rm9Kf0oeW+1jE=;
        b=XGs0aB9y5G8/PiBsluM0iEARCX1j4sjiUE9ulaCI/pjnx8J2gtN0WYRSi93RZEFMeQ
         w7+BCmzaoAjhED631dY5a/iuy+JtiSP4FMefCzBMAcbY3bjHDShhgX6yrMuQKiYoV02t
         IQdEuFNgX9krNTOjOytbWXv+TiIeh2AMRZzVmvB0RKpDgz89+iCKdHH2yIPoLZ+twlae
         lnZ0T16SoO3acQ19tJUs243Cp8Okl1n7LOs58W6OviprxQlPIO3qyag9nUoCP+5Plzi7
         AenZHghoM9H3CAAyuGCUMl5Zxfu6KPq7QVrn4t3bPLX1+v4+Jss9jse7an4j5A9JIwZb
         invw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720746020; x=1721350820;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/S/2IwA63oCbT4wEpXHln9cmhCR478Rm9Kf0oeW+1jE=;
        b=osXTkSs2PFwvdUUcHeOQSWPiS55zDJAeUZSOrTXLyed8YhYhk8uApfWyWaufQsAkDb
         gh1RPaVJCJ2frnznArXgD8bB1x7hAlBOnr6WOX1onJ8o6nqssmf0MBaG/UkujAZUMVI0
         JmMoBCrk/xd7BxpMQLRKBZRCquEzZe5rSbLcBvomusDtnJXvUiNfLFnuJRY6W5+Jmn6E
         IV9PVVA67AlONL2zJyEBnA3kMHcrRfxpB82mWYNK2WbYuj865xYpieKKEn7WM7aiP5+a
         e5aZ4a/JElYyR8ltMTXQNiw4sIPhpi0ucnsdr2iQs0frwuaKlccWPX7KwvyqTIqswuiK
         XOIw==
X-Gm-Message-State: AOJu0YxTGI1FDhubF7UAf+XJnjqbKt7rwIqJlmGMbNJGv0Ob5OLYZORX
	s8ySL+Xlo5YN9m45l0QFLvVyIqBI7Jbi1nuDuDTjArVkmMh0oem9z8rt4Q==
X-Google-Smtp-Source: AGHT+IFID6fOlRuA+wquCKj7CZjUyvWiMo/cJiKGvc7Zo19k8ClzHdZlrza8f/FGHIN2Lv3RSsAI3g==
X-Received: by 2002:a05:6a20:3941:b0:1be:d5e9:b444 with SMTP id adf61e73a8af0-1c297d67c2fmr12167308637.0.1720746018674;
        Thu, 11 Jul 2024 18:00:18 -0700 (PDT)
Received: from gmail.com (p4357013-ipoe.ipoe.ocn.ne.jp. [123.222.98.12])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cacd3febdfsm220644a91.16.2024.07.11.18.00.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 18:00:18 -0700 (PDT)
Message-ID: <3e518245-11f1-413b-a2e6-e3b3efe3d7b9@gmail.com>
Date: Fri, 12 Jul 2024 10:00:14 +0900
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/4] add-patch: test for 'p' command
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
Content-Language: en-US
In-Reply-To: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a test for the 'p' command, which was introduced in 66c14ab592
(add-patch: introduce 'p' in interactive-patch, 2024-03-29).

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 t/t3701-add-interactive.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 5d78868ac1..6daf3a6be0 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -575,6 +575,22 @@ test_expect_success 'navigate to hunk via regex / pattern' '
 	test_cmp expect actual.trimmed
 '
 
+test_expect_success 'print again the hunk' '
+	test_when_finished "git reset" &&
+	tr _ " " >expect <<-EOF &&
+	+15
+	 20
+	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]? @@ -1,2 +1,3 @@
+	 10
+	+15
+	 20
+	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]?_
+	EOF
+	test_write_lines s y g 1 p | git add -p >actual &&
+	tail -n 7 <actual >actual.trimmed &&
+	test_cmp expect actual.trimmed
+'
+
 test_expect_success 'split hunk "add -p (edit)"' '
 	# Split, say Edit and do nothing.  Then:
 	#
-- 
2.45.1
