Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A33D13B5AF
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 20:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717447088; cv=none; b=lkZNNjG/PgilOs/AwkmsvTz2r33h2aObsgcZm/f3wpTv25J3VehpOgZYxbFuUKrr6A41X9y9fGsQV9ilLsVWIbiNpoNP6U0gORZAPVJMtVcy8nO0NlxHFTNCWMN5QZ0An7BvDJM1+710GYNKskVRQVs+14gtoaxLvJdO/AwsCUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717447088; c=relaxed/simple;
	bh=Y6CDrVEANeofyF3gYzYnrJBcyUmy+fDe9pkxNHJweXU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=MqWzEhVf0g4Nj8Ua5rvJHwS1024WHEeJBTn4JDgQ5bAlul3jHDc8e7/vUXjisSoJamCCDbQZ0zDBsYHVqGf6h9TqWdASpQAoy11JYlIw3y3VZYgqnZrSEnYscJrNBTeX5CE7yapdL23IiRTI5p5WgxjBKhCEpRy3j51KCiWbLc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NFEp3nBt; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFEp3nBt"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4214aa43a66so746765e9.1
        for <git@vger.kernel.org>; Mon, 03 Jun 2024 13:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717447085; x=1718051885; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ayZgIbNzVwcE6oDv9YFWqhEMm253yLcstl5OPbScquE=;
        b=NFEp3nBt4iQYNczEnBnrlwZ7kgV42lkHC/0FsyoZqvJDCsUtaj4lFlLNtgTW4t+aDb
         WmnY3vnRgreodQjv/djJoXp2tdJQU64SVYoblnu6sAHGilr+s4gzGhK2RR1VZnvliazP
         GFBLDn9tPixim2A438z2hYswll/mUnTd6P7x3XMEOUPnbcgKaME2Z8h2y0qP+ZdEBYa1
         wvyYYsFDWKtm0Zg8eaVQzKcJbYq/WismF22I5Qz+GQWPsvPIotI6Z9BDr/kQTA88by1X
         z76ki6VavcLpaDl/WysEAYz9A44Iy5p6CZc7P5YYvnW9Wu5mFwscuizeoe0/ktGyu3mf
         Gg7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717447085; x=1718051885;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ayZgIbNzVwcE6oDv9YFWqhEMm253yLcstl5OPbScquE=;
        b=i82KO/p3kYnsianZ815xXSEH2ZWPalEwBD0kg1SrH3VLyctaibvdzltvjG8S1UHo2r
         5sy9csoL8MgEUHC7xmv5iSfmeG/zVY8Ggxf7x7q5k34JaBRqFRsXe2cutgNC7UhIE3hh
         2Q7bzp75jnwomXNQXX1ZQSnrFq4c7s0W7YS/lk/Vrs+It9OCnJ6k+q5f08fg8hxiPn4n
         VN8qy2DoPqboE6UDt62+CTriCXQUfnJHH1dng/kAKW8yxAAMp3sd8xHO1Gz9NzYALoFB
         V4SMld5N030+X0p1nkKTSffgk2URTtYZxsl/bgEnvn3MoL9mCcJdcVuMFzkwC5rt70ql
         Qoxw==
X-Gm-Message-State: AOJu0YzlqyOGWkXTQFjhro93ADYQRSIOGA2Ns7+3lJJgxa60MejH7n2D
	qnYzM1BHWPy2X7lFQAQRJwSbhCfXw3jEYTrn37mJQ5lFHU1cb3if316xHg==
X-Google-Smtp-Source: AGHT+IGDnwsKCrnfrtWk57AmNBhi8W3yE0hqh5gP4mWZTUF2/qgayiqXnKI+snElfHpiMrhE15dh9A==
X-Received: by 2002:a05:600c:a4b:b0:41f:fb7b:bc53 with SMTP id 5b1f17b1804b1-4212e066be2mr82929265e9.22.1717447085271;
        Mon, 03 Jun 2024 13:38:05 -0700 (PDT)
Received: from gmail.com (20.red-88-14-43.dynamicip.rima-tde.net. [88.14.43.20])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212b8a758csm129443445e9.36.2024.06.03.13.38.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 13:38:04 -0700 (PDT)
Message-ID: <28cc803a-1885-49fc-81b2-4ced1fbb8236@gmail.com>
Date: Mon, 3 Jun 2024 22:38:04 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4 1/6] add-patch: test for 'p' command
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
 <b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
 <1ef0ac3a-3be5-4fc2-93f8-46610f3d1880@gmail.com>
Content-Language: en-US
In-Reply-To: <1ef0ac3a-3be5-4fc2-93f8-46610f3d1880@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a test for the 'p' command, which was introduced in 66c14ab592
(add-patch: introduce 'p' in interactive-patch, 2024-03-29).

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 t/t3701-add-interactive.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 6624a4f7c0..6f6d174687 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -590,6 +590,22 @@ test_expect_success 'navigate to hunk via regex / pattern' '
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
2.45.0.97.gb691764a17
