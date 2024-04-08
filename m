Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6B8433BD
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 21:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712610461; cv=none; b=TapKU3eR7QOAyVP7KrOylBj01S4unrIA6rsEn01YA70Ybv5/dVpMiH0xVqsmvWD0GgUVowX/YSU1TCjP3SdCc1VidKeaJIam8RwkrEW6W9NKWfhF0qw637btEXgNlW04kQUWMlmFr5N8LdTUCOkvRSP9icDKbXhJkP+/CDsyd5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712610461; c=relaxed/simple;
	bh=LtNptoB/zjK5xAtzxYHA4+rnGjZS9fFN3FoaeUfFPxk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=ClufN2OMjtw/OYtMwVBLIWkDQp3Y79jquuygcPYvCaqLfnnlWfAFYVmLL2tuC79/Kc9T+Xxbn1QOtOfUdqx+ZqMWKkLEtzUM0TqhgDiGby1IYzB0vHqjJEg+IYgq65Hdxi/K0DFEfe2pIrkllIr6b9l+cMSRua0iQ1eMvAwzqak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hT/tDKIt; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hT/tDKIt"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-345e1c645c4so601956f8f.0
        for <git@vger.kernel.org>; Mon, 08 Apr 2024 14:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712610458; x=1713215258; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OzPWkGPQ+xiTjPsN4CnPFfADaTU++JTvHCwL3CidkL4=;
        b=hT/tDKItCNRj05vXNOe+jfzj9ELGdttuPm2qns25h+wWLJeIiJWF9xGCqjx31r9M15
         n7DG9zsHW1O1A1CKWTmU2BdHguGN5FMNJICZMOK3kHr6P/1ickSb+DBQjYwDI6zsNbM4
         Wo2VBe+Sv2jLmqIYw/FHGJgzmbYPACmCDaNLdyziUE3YCSF4rEIcO0h57kVj83SnKjhX
         k0h+TB3IMaT+veERPrWO1r67YAReIN1N6OYgX2gCdK1XOEn+P0UYZCR5yEo+h/9oIsnz
         Hy9JvBaa4tyyDjGLKCA5mAxl1UDEM6VwL2hTABFIgpW/0B+yVBDWiNb9NGwO4vUivIjb
         JhKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712610458; x=1713215258;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OzPWkGPQ+xiTjPsN4CnPFfADaTU++JTvHCwL3CidkL4=;
        b=K93bNtVPG9nzNHwxBhnoPqhPCo2Lleio9NpaBf7N99yMdebwViIS55qYqp8bIGsig7
         /PTIj6r3CqTNteXv6UWH3jGMOWhgXAWD3o35Z8t5qm2pvL6Xsz7oypSjVXfSy3RVQvjc
         4aKKz4743QriYlneUHkNHQ5Hmjfk1c5DWUKZl25LS7VkC7AqlVonlgfBYPh9MzzshegH
         ec51acvJH4XAYj71R4HA51dMb+kC8Wjh1T6+5JrFxEY0n4hjx9AP9ZxldivAt8hhgIFZ
         vnopUy9VUZfmJNQ+7bQkmgjcKXtQAGu9FPkd4yxINJ2/dTfxgKPY+bdJyH0apQLV1Lu6
         AB+Q==
X-Gm-Message-State: AOJu0YzVEqzihI9s9ESS1q1rSeZlbmZATjUyiLmIgpV1hkMvWKRfnYU8
	cuBYsj9xy/I2ji5ZZPmQSJvzemFesgzKmzMHvChzKWSXmm2GAsyV9NtBENim
X-Google-Smtp-Source: AGHT+IGikGtl3Wo3MvofIAmUrpSMUsEXEOpq16/7BLMw6sdPC0eCAQVXkWMXeUnzuAilUkx+3n93rA==
X-Received: by 2002:a5d:47a4:0:b0:346:1b20:f134 with SMTP id 4-20020a5d47a4000000b003461b20f134mr161292wrb.0.1712610458409;
        Mon, 08 Apr 2024 14:07:38 -0700 (PDT)
Received: from gmail.com (4.red-88-14-47.dynamicip.rima-tde.net. [88.14.47.4])
        by smtp.gmail.com with ESMTPSA id dj15-20020a0560000b0f00b003436cb45f7esm9806014wrb.90.2024.04.08.14.07.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 14:07:38 -0700 (PDT)
Message-ID: <96bef5f9-1286-4938-99ec-6beed13ee68d@gmail.com>
Date: Mon, 8 Apr 2024 23:07:37 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] launch_editor: waiting message on error
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <e60c1217-aeb6-48ce-9aa5-7c0b13396e33@gmail.com>
Content-Language: en-US
In-Reply-To: <e60c1217-aeb6-48ce-9aa5-7c0b13396e33@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We have the hint we're touching in this commit since abfb04d0c7
(launch_editor(): indicate that Git waits for user input, 2017-12-07).

Adding a new line after the hint when the editor returns error was
discussed in the list, but finally it was considered not necessary
because a shorter message is used [1].

However, even with a short message, feeding that LF makes out next
"error: There was a problem with the..." more clear.  For example, the
editor could print messages that would be mixed with our error message.
So, add that LF.

While we're here, make the error message follow our CodingGuideLines.

 [1] https://public-inbox.org/git/20171127134716.69471-1-lars.schneider@autodesk.com/T/#u

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 editor.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/editor.c b/editor.c
index b67b802ddf..0d4c6f94a6 100644
--- a/editor.c
+++ b/editor.c
@@ -104,16 +104,26 @@ static int launch_specified_editor(const char *editor, const char *path,
 		sigchain_pop(SIGQUIT);
 		if (sig == SIGINT || sig == SIGQUIT)
 			raise(sig);
-		if (ret)
-			return error("There was a problem with the editor '%s'.",
-					editor);
 
-		if (print_waiting_for_editor && !is_terminal_dumb())
-			/*
-			 * Erase the entire line to avoid wasting the
-			 * vertical space.
-			 */
-			term_clear_line();
+		if (print_waiting_for_editor && !is_terminal_dumb()) {
+			if (!ret)
+				/*
+			 	 * Erase the entire line to avoid wasting
+			 	 * the vertical space.
+			 	 */
+				term_clear_line();
+			else
+				/*
+				 * We don't want term_clear_line() here
+				 * because the editor could have written
+				 * some useful messages to the user.
+				 */
+				fprintf(stderr, "\n");
+		}
+
+		if (ret) 
+			return error("there was a problem with the editor '%s'",
+					editor);
 	}
 
 	if (!buffer)
-- 
2.43.0
