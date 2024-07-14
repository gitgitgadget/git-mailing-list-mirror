Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C7426AD3
	for <git@vger.kernel.org>; Sun, 14 Jul 2024 16:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720973046; cv=none; b=O/MiFoBJwSXLbKx8vxxxAaj0qRtxwFrVRtWyUiNazPHQNLMo+UPw8HHhYOcg6Wex3Ka9u14eFF29stFTE/OxyEEwCUEs9wiTYV21885JLvmwsLfD7ETweOzLvnyjuE8KyDvNh1mOEda++j5dsjA92lIU1BwUQYs6Fos+e9MC/lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720973046; c=relaxed/simple;
	bh=MeNi5aIGWCXe9V66rV7kJAipZHF2OIqnOT0HNkkSDHQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GQLPL29H7XHZY6Bm+X1umnaBESeP9YdVXqUKTeEJDZT5LtDuFcbQUiMWnbH3mcta/GjpG+2uf2nrYMFwO/0PsjCY/n3mYv6uhMlTay3OetttacRj1zc7vV7RwkFTB7PFqNAk0J6lNoy5hZuxBWKcpU4oqLMkFHRkqIUvkdT0oZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kT0l4jYJ; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kT0l4jYJ"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-78135be2d46so2657213a12.0
        for <git@vger.kernel.org>; Sun, 14 Jul 2024 09:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720973044; x=1721577844; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vndlf0SnWOIU12Opo22dtvOc2EXq5KoPN86Nj70sqcc=;
        b=kT0l4jYJL2WMuFtwWWLDZly6JPpg54JAUQ/nbYSuh44rSOEMDKjl68pNUZrxZAjHZe
         rx2eyUICltNO53Ja20ONA0fE+QzkHeQ79CTRUwe+wB6LMVwznrLsV6r9v3WJImqKOlYF
         qZNmgLDs0yAYJebz4xpyS+969Wo47nLUJYzx0G3De+PN3CGCYt7OgcNwOvRXBYEemdHe
         3et9MgZSmtvrMzaNRMUhw0bXpXuM6VYEYkw0+CIHdcLN3oM1ytX9VJbzD+oBRQLxIH1K
         m3S0KkqYT8J36Uz+hrubL6CUkNzlCykRGqlvPcu8yWXa5/HTYRfnLUyMTgLgOdD37xTF
         RSyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720973044; x=1721577844;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vndlf0SnWOIU12Opo22dtvOc2EXq5KoPN86Nj70sqcc=;
        b=Z07W8KKqJ5bK6i8A6GUhsVlN/eQr+V5mE3Tnpq5TMj7aFoDJxnktFcZVTBEsXbLnN5
         zF+T+NmNhGsVHWkcP5OEOulJRkp19YswdkV/pI1IBFA825VJhAzDep7jKhPNmv3sirtM
         zf5cIJkm2yWFybM3eUDCTzcWM8pjFYvCsVXMUCUzHOslRnSiZThtrACEj73nfbYFz+dq
         KttYs+5xeELRFnwdltRF9SQqHdQWdmrMM2PGex5mmU/sVzzLSd92TRH6PmzziXUHS4xp
         qP0mnQsEEs+6R1V3Dy2F5IZbVfOyuYTwS/hExixrzTxaiUn4OZGIJFPquJAw4lzQFo+M
         MPoA==
X-Gm-Message-State: AOJu0YwwR3cfdhFaJznH+xSZ1VzbLrd+Lh1J02s6O8+T37denMpPu5bY
	6ND8thSjM4w8eSW1U9hUyLmyx+/2hG1qXZ0EgVkm4B0kuHTiXL6VlYAyGw==
X-Google-Smtp-Source: AGHT+IEET9Zjbj7RJWD6ua2Hkxqf1RG7xQIDQ2599UBxxDu9y9+k46HVd7TXlmIhdz7/QKWuzV6WLg==
X-Received: by 2002:a05:6a21:6da2:b0:1c2:8c73:f35f with SMTP id adf61e73a8af0-1c298398329mr22339429637.39.1720973043908;
        Sun, 14 Jul 2024 09:04:03 -0700 (PDT)
Received: from gmail.com (p4357013-ipoe.ipoe.ocn.ne.jp. [123.222.98.12])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ebb67edsm2744024b3a.60.2024.07.14.09.04.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jul 2024 09:04:03 -0700 (PDT)
Message-ID: <73173a13-a537-460a-bca1-501b11728a77@gmail.com>
Date: Mon, 15 Jul 2024 01:04:00 +0900
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 1/4] add-patch: test for 'p' command
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
 <ebcba08f-3fbb-4130-93eb-d0e62bfe0a8a@gmail.com>
 <efa98aec-f117-4cfe-a7c2-e8c0adbdb399@gmail.com>
Content-Language: en-US
In-Reply-To: <efa98aec-f117-4cfe-a7c2-e8c0adbdb399@gmail.com>
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
2.46.0.rc0.4.g913e7f3d09
