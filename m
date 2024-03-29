Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E733A27B
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 04:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711685998; cv=none; b=PxEyq3lgVk4zYB2qgmMyJjDVgAVDpbjeRb1r/OIKpUfpaQdlLdCYJGGVd1+sOgHyE+hJAzKC2603Zu2e6gZEh5Vf7Db9T6Amn7zIRTRoSZH53/luiSlCs9Zn3jtfKSjq/oVCz9+rOad2UABaoKHAbkbzpvUCxZggwqEBZP5H8/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711685998; c=relaxed/simple;
	bh=MRQdN72M24OB7+CrnXqYOSglAHlm2kSp2wjUrB5snDE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=N2hw1CsOCzT/Zhyq13LLKhzMLr0h27+oXT1CbQhQ3P/LkOQPJkEZac48kohX3tr5p+7l9Va3tzsPHTKPp/sUmrbyhT4v04HWVrrGXiXhb+GbbaqELM5qVNELlngghSNHbv1QyTpUr7OXM1iDGH5X/BMubZjVetnP68jNkA/dsNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lke/Y3J+; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lke/Y3J+"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-341cf28dff6so1157750f8f.1
        for <git@vger.kernel.org>; Thu, 28 Mar 2024 21:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711685995; x=1712290795; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qC5Th8ds8UoLUX1MIgsX8AgT8pa/0WTpmwJhc5L0oTs=;
        b=Lke/Y3J+I6xWegzgYG8qxkvXrhq7QdUEKbSEmQDOWQv0z9YVrbUwZhzu/sfCx9DmWp
         /RWleeR+DGXJqjv2SFS6xQ4hDTms8OQuC+KMQZX1R7kldev2DLipLA8IeWXLa7tel0Eh
         /mniIPD0mD0ygastBVHZG9XBZ34DT9ERUUDSPLaweESDSuWdemC1Hs27ulPXGQcW2R7D
         MD7TxgUU936Q+1/r/s/ThE/V1/j7gpW7dBEgJMeD0YTq0JLfoGpnz06xZtZ0WwuOLT7j
         ho29ZayybkEOWtPIHUajmkXdioTy9kF9gbGH2MOXgNqD/UYGkOva3CGburwTLMHcWHdq
         kaYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711685995; x=1712290795;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qC5Th8ds8UoLUX1MIgsX8AgT8pa/0WTpmwJhc5L0oTs=;
        b=F6s7TYJPjyp5IZypmVbLiMc6HDZxx56dBremirHdfLeOsOaLZrIhNbuJiNqE3+Q7du
         Dcxh5qsHn8Y56SRRjOy1yO8mp8Sbe9I6r99snCuaFDwppkTklGtDqJnVkKkhh/pQSfKc
         pNcgz7h9hg0CxLGV/FrAhhJ339AhR5AlYsIObcrILetR/HiYKgVm3CJaO0wTbgITZBUD
         jX2Hi5+YeO+gYMLzRgYCh0za9lllVOzOYXCpMh7iufj7M56Ia/4W+jMXaWpXqDZSgZtT
         kutF/g6jmQj2zNylj8x21TPyjNCa86sb0q6Mb3Vlak3t3jy55EQUjLhdlHabvz2De8AR
         MD9g==
X-Gm-Message-State: AOJu0Yz/ONhinp833r04aPsJofJvqc1nSv+yGo4OSXNzKm33iS2Be2zK
	2Bzq+Ulew9kmRiKIqfG4us2SLBTP+yMELurwG99HUjch4R3NEZBNznzOJQYj
X-Google-Smtp-Source: AGHT+IEdUjjlxYZt4A2U33BzbTS+zFduoS4UoAhoEbaGPxRte0BmljMlAeMSONACGHIf77Ubeu7Yow==
X-Received: by 2002:a05:6000:136c:b0:33e:1a98:46e2 with SMTP id q12-20020a056000136c00b0033e1a9846e2mr537213wrz.28.1711685995287;
        Thu, 28 Mar 2024 21:19:55 -0700 (PDT)
Received: from gmail.com (220.red-88-14-47.dynamicip.rima-tde.net. [88.14.47.220])
        by smtp.gmail.com with ESMTPSA id m11-20020adfa3cb000000b00341cd8e04a0sm3193835wrb.105.2024.03.28.21.19.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 21:19:55 -0700 (PDT)
Message-ID: <0e38da05-efd6-451e-bd8a-b2b3457c0c75@gmail.com>
Date: Fri, 29 Mar 2024 05:19:43 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 3/3] add: use advise_if_enabled for ADVICE_ADD_EMBEDDED_REPO
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>
References: <06c9b422-b22e-4310-ad5b-1686616ab860@gmail.com>
Content-Language: en-US
In-Reply-To: <06c9b422-b22e-4310-ad5b-1686616ab860@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use the newer advise_if_enabled() machinery to show the advice.

We don't have a test for this.  Add one.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 builtin/add.c  |  6 +++---
 t/t3700-add.sh | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 289adaaecf..e97699d6b9 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -310,9 +310,9 @@ static void check_embedded_repo(const char *path)
 	strbuf_strip_suffix(&name, "/");
 
 	warning(_("adding embedded git repository: %s"), name.buf);
-	if (!adviced_on_embedded_repo &&
-	    advice_enabled(ADVICE_ADD_EMBEDDED_REPO)) {
-		advise(embedded_advice, name.buf, name.buf);
+	if (!adviced_on_embedded_repo) {
+		advise_if_enabled(ADVICE_ADD_EMBEDDED_REPO,
+				  embedded_advice, name.buf, name.buf);
 		adviced_on_embedded_repo = 1;
 	}
 
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 681081e0d5..2b92f3eb5b 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -349,6 +349,38 @@ test_expect_success '"git add ." in empty repo' '
 	)
 '
 
+test_expect_success '"git add" a nested repository' '
+	rm -fr empty &&
+	git init empty &&
+	(
+		cd empty &&
+		git init empty &&
+		(
+			cd empty &&
+			git commit --allow-empty -m "foo"
+		) &&
+		git add empty 2>actual &&
+		cat >expect <<-EOF &&
+		warning: adding embedded git repository: empty
+		hint: You${SQ}ve added another git repository inside your current repository.
+		hint: Clones of the outer repository will not contain the contents of
+		hint: the embedded repository and will not know how to obtain it.
+		hint: If you meant to add a submodule, use:
+		hint: 
+		hint: 	git submodule add <url> empty
+		hint: 
+		hint: If you added this path by mistake, you can remove it from the
+		hint: index with:
+		hint: 
+		hint: 	git rm --cached empty
+		hint: 
+		hint: See "git help submodule" for more information.
+		hint: Disable this message with "git config advice.addEmbeddedRepo false"
+		EOF
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'error on a repository with no commits' '
 	rm -fr empty &&
 	git init empty &&
-- 
2.44.0.371.gf9813d4ed5

