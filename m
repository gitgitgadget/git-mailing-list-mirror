Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165791C6A8
	for <git@vger.kernel.org>; Sun, 14 Apr 2024 07:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713080390; cv=none; b=cx045Vsb0Q3OahtSNTbXk4wAJc1hMXTcqwAhP5L4iu0t/CcMIYCk2XJzhb6l2TYiOkns0OJlsIs5vDSqLgcpSXKC7QZGKp84ggwhCacuWTIDzP3Gk7cEVeRAg0+87swJY3Abv9P9N26MTIrPE2vHXDBAgvUoRUYqQf8eiBO4vvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713080390; c=relaxed/simple;
	bh=+o88yCM35yDwAGsFjyHA7VYcTLLFkk6wBUkEvwyCOJU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=XTGiHDfvjSu8Ge+xUQJrWBHIlpOdH6lqv3VxmpldSP/n8gr9Jf7WFrE91iPbViliWNYWoXCMHX3E7GLSVun60vVgVVUG/5uDDKJlkaT+tD1HSwM5RpWuRM4kSHDK7/8CRvi5FA3fqhlUQF0YVwr9KJcKPFPFBRnc2UIidl1xgPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jpnukXXu; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpnukXXu"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-343d2b20c4bso1649938f8f.2
        for <git@vger.kernel.org>; Sun, 14 Apr 2024 00:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713080387; x=1713685187; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wAiTt8bXJya5R3vXctQ//hB2zYKtntSTMtJuyWZhjuA=;
        b=jpnukXXu07rjlpNNnqLXRb8KWTxq+nWgPB9SIOkagpj9LnY4R37GBZMQqnYfcLBvpD
         T6QwlFTvLP/WvXZ+d01QD5M/H3wBV9J4vVDNDrUD3prdUuaIC0NThBwr2ldM9CF26ttN
         MC+6KFeObv+UHdCPmbUIyLosWYLTsh6VI7lgP50KAAHT6fPuxSaAQUkP8NBcxtKkzs3x
         hGfEIsHJdizReYyUk6EeHWW1i2fpa5MTRVigVmGTn69VTHYsYcl3twhhqkEm7GkSqT9O
         NDuDntOUEO7BrNR44usAc5vmF71ncxDnKhPfPZ7/19GebeMEcfumNPwvOFpwf5pxOebJ
         3ppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713080387; x=1713685187;
        h=content-transfer-encoding:in-reply-to:cc:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wAiTt8bXJya5R3vXctQ//hB2zYKtntSTMtJuyWZhjuA=;
        b=SGhXNTQoNO8oTtlMw+u60jMvMJhhYS1heXPC4dyGDg3cSI63laCJwv3UAVVCQMaQqF
         aTCL6eAH0MGJfHz0JUznIGTMAb2zToFoDrUrN1HzY2Z7jaKZkvzbgZ6Ac+mvauFkAJnF
         0VcpWGidc221ZPL7Z4iDnYx+QTcl9oC3kGNP+yAky8VzEs0dr+aZbQ0lcEMHAxruG3/N
         Vlv/HNKLskmoW2m/8JqQDKyNyw0WNVhZjwkzQEzWz4RMbmB/zVfM0xeSr7D+XOkuHLRR
         a+lxPTc2ly0r+IxVRCgXfQ+FaFiOBpPVHVtPas1KEizarlCsHeKP5bHXvG13vI+jAYxs
         yM7g==
X-Gm-Message-State: AOJu0YyEugvr3OoSZPKgsKksNgcWNaQo6UFDKCv/tyrNBOWbLwMv7GEt
	u/kCCfNVNqLsKv+t/jEHJTfqg6fTigmTjy90Qgl+P71M7X/xkg5W29u5Lw==
X-Google-Smtp-Source: AGHT+IGOdw9B67GtbhQYkyIzlfOOS6BulgdLKzK9aW26SIpslVAq0EBRcMaF22K1WMJTE1hS6Oe7Wg==
X-Received: by 2002:adf:f305:0:b0:343:3eb9:b287 with SMTP id i5-20020adff305000000b003433eb9b287mr4406297wro.36.1713080387165;
        Sun, 14 Apr 2024 00:39:47 -0700 (PDT)
Received: from gmail.com (91.red-88-14-45.dynamicip.rima-tde.net. [88.14.45.91])
        by smtp.gmail.com with ESMTPSA id di7-20020a0560000ac700b003439d2a5f99sm8388308wrb.55.2024.04.14.00.39.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Apr 2024 00:39:46 -0700 (PDT)
Message-ID: <e208da74-8f16-44ae-912e-ae968da82057@gmail.com>
Date: Sun, 14 Apr 2024 09:39:44 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4] launch_editor: waiting message on error
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <e60c1217-aeb6-48ce-9aa5-7c0b13396e33@gmail.com>
 <96bef5f9-1286-4938-99ec-6beed13ee68d@gmail.com>
 <0258a583-a90a-4434-bb4e-a1672d574b9c@gmail.com>
 <ccbd77a1-d334-4d8f-8de0-b542c79330fd@gmail.com>
Content-Language: en-US
Cc: rsbecker@nexbridge.com, Phillip Wood <phillip.wood@dunelm.org.uk>
In-Reply-To: <ccbd77a1-d334-4d8f-8de0-b542c79330fd@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When advice.waitingForEditor configuration is not set to false, we show
a hint telling that we are waiting for user's editor to close the file
when we launch an editor and wait for it to return control back to us.
We give the message on an incomplete line, expecting that we can go back
to the line and clear the message when the editor returns.

However, it is possible that the editor exits with an error status, in
which case we show an error message and then return to our caller.  In
such a case, the error message is given where the terminal cursor
happens to be, which is most likely after the "we are waiting for your
editor" message on the same line.

Clear the line before showing the error.

While we're here, make the error message follow our CodingGuideLines.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 editor.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/editor.c b/editor.c
index b67b802ddf..d1ba2d7c34 100644
--- a/editor.c
+++ b/editor.c
@@ -104,16 +104,15 @@ static int launch_specified_editor(const char *editor, const char *path,
 		sigchain_pop(SIGQUIT);
 		if (sig == SIGINT || sig == SIGQUIT)
 			raise(sig);
-		if (ret)
-			return error("There was a problem with the editor '%s'.",
-					editor);
-
 		if (print_waiting_for_editor && !is_terminal_dumb())
 			/*
 			 * Erase the entire line to avoid wasting the
 			 * vertical space.
 			 */
 			term_clear_line();
+		if (ret)
+			return error("there was a problem with the editor '%s'",
+					editor);
 	}
 
 	if (!buffer)
-- 
2.44.0.782.g038d277106
