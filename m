Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA0A226883
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 23:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734736750; cv=none; b=q5g0EcrR6GYr/UxkdrvpibNOvcVKLHn4OSsggg8UUXpOvducczUEZFQ0dFzjjB6BdSEbz+VTgR+EVecMR9/YYNPnLn5Hay+fmsahXZ2gfm8nFyOe/R8Cy+g4ohAYzdHa1S4V5KB/qMn3xE0hmcsG65+NqR1eNn6h2dRHSDp1LIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734736750; c=relaxed/simple;
	bh=OxPRFBbkeBEtcyDflLwxNrDx3uMMaZhtW9RZ6DZBUa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S+FSun5iDeUITN2dmgdC322kMoyylDKMnPhKRQde7Y81AW8Pd2r1Ev8skppJsC/VjPCNNwVKm5+ZYDJoE4XuyawWyqmei54w8+pzz2ekfQuph4pXhscNJljxlmPnN3Ja6wwDfHHshZfDuYsEX7bPdk2IanXxFcVRi57Tnfqb2No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lf+KX0Pb; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lf+KX0Pb"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-540254357c8so2326691e87.1
        for <git@vger.kernel.org>; Fri, 20 Dec 2024 15:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734736746; x=1735341546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ymxx741lgLNLtEQKC3uZwRUhugqIb22XeDVvOmGI4fE=;
        b=Lf+KX0PbSut8I9ssZ+X8cHSD3s+dQ0RlLUSJQ5E9tIF7f9NDTSLA8xn0uusHRWK7Nm
         5PWAF82g61SiytC9jsIo+sTwOABCqTIeEBKHefLli3M6wj097SGKKVW6PUKVr5XFHSl8
         VmJmnY4ywElxBor8jyReJ3OKvxlmrfSVD6upPohoy9I3lJKyY5auPogTPEt9wlonxJ6y
         Ftsvvo2hJLcwCpmn7HBt0QwcUck8haONUuGSKvbu3RoDIUQCfozLxOCzfuafLMQR9Ih/
         Eic2c7J7jNDiYDrqNmE3toZqxaZ0+zhVsFkXpPSnio8mgG45OQN9Ywreie5KSenm4rOc
         mv2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734736746; x=1735341546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ymxx741lgLNLtEQKC3uZwRUhugqIb22XeDVvOmGI4fE=;
        b=ZHR94URj54i6Mgqd6GBOuuGmAPr3J1BgZASbZcZAILheOBXbpwwb4Pd/yPT7BBE6kp
         xQ4GFYTrD4qK8Kq8Y3bhQXniBcES+DWqL+vUBrme+2WEy14a0UFJQBfH31y/mIwhCV4b
         TO7EkcMSqKbMsMJwKdSlRj0DPWTtB+z4kZaQbqcO3AS/hsUNft+5suU/aUlRW2xcJjug
         JEf0Jc55ZaLMEOjmR2JkiDhGhgVzK3b4O5/iVbg+W1gDAyPe/2/+r1ddgCRTH70TFVRQ
         MMDh/wVmb9W8KPrVUYEqKHuGr+vZH/0b027SWY6P7Z+AvnC3REjAQqSqiXSsC5VJsc5a
         uIGQ==
X-Gm-Message-State: AOJu0Yz6GCoWags8UFxRa3WdSszHCoP8OtAr7pKwdPOc5cCKGbV1yyWN
	hXDTHDdd6K1HRmZ8lr+6RWTU6i0W1F5dluGxhR5T1Qyo/43o7cfHQNcB3A==
X-Gm-Gg: ASbGnct0W9vPDQdaWcFaK4ZUXs/4Ps2SEJsq4XkSc5sYBmZdoBquOCmLTlX+MUHxU/S
	UWvEhv2VPXEkgQptC7l80w/ZxTI1M7jLJ3xMiR8ZFFvWXvUQvwYxWUbwqz9vKDtOwHc1MPKtf2n
	Ust+EQk0EyEVlU0+HPuUVH7PJvMrsC1OG73hFJZYm5mdyt/RkzU3NAmdCmxPZelA4H83i2sN/lE
	eHbuufcWXPHL4pY81/5adNlYCbw25A2RBmQwIqZIYVHi0zOaexTYGsbO0vXK40E6V15C2bziSOv
	hoTkcxmovQknsQOiYbe8LaKt6C6EWJ459VI=
X-Google-Smtp-Source: AGHT+IEyhFFxNT973+KOiga1qXbFQL+QMQd/h8IkLIrjmUOuH9GNJOpaVe84GeLDNYOfOvyRdgs8kA==
X-Received: by 2002:a05:6512:3054:b0:53e:2f9d:6a7b with SMTP id 2adb3069b0e04-54229524d49mr1587491e87.10.1734736746265;
        Fri, 20 Dec 2024 15:19:06 -0800 (PST)
Received: from localhost.localdomain (81-227-45-223-no2667.tbcn.telia.com. [81.227.45.223])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-542238137f0sm583733e87.164.2024.12.20.15.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 15:19:05 -0800 (PST)
From: =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 2/3] asciidoctor-extensions.rb.in: add missing word
Date: Sat, 21 Dec 2024 00:18:17 +0100
Message-ID: <5ebeff3ed9d3b3ab80cef5c77b1254f6793c59fb.1734734612.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.48.0.rc0.241.g3cddc25e2a
In-Reply-To: <cover.1734734612.git.martin.agren@gmail.com>
References: <cover.1734734612.git.martin.agren@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit a38edab7c8 (Makefile: generate doc versions via GIT-VERSION-GEN,
2024-12-06) stopped providing an attribute value "Git $(GIT_VERSION)" to
asciidoc/Asciidoctor over the command line. Instead, we now provide the
attribute to asciidoc through a generated asciidoc.conf, where the value
is generated as "Git @GIT_VERSION@".

In the similar mechanism for Asciidoctor, we forgot the "Git" prefix.
Restore it.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/asciidoctor-extensions.rb.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/asciidoctor-extensions.rb.in b/Documentation/asciidoctor-extensions.rb.in
index d8d06f9a57..fd1b84c2be 100644
--- a/Documentation/asciidoctor-extensions.rb.in
+++ b/Documentation/asciidoctor-extensions.rb.in
@@ -32,7 +32,7 @@ module Git
           output = output.sub(/<refmiscinfo class="source">.*?<\/refmiscinfo>/, "")
           output = output.sub(/<refmiscinfo class="manual">.*?<\/refmiscinfo>/, "")
           new_tags = "" \
-            "<refmiscinfo class=\"source\">@GIT_VERSION@</refmiscinfo>\n" \
+            "<refmiscinfo class=\"source\">Git @GIT_VERSION@</refmiscinfo>\n" \
             "<refmiscinfo class=\"manual\">Git Manual</refmiscinfo>\n"
           output = output.sub(/<\/refmeta>/, new_tags + "</refmeta>")
         end
-- 
2.48.0.rc0.241.g3cddc25e2a

