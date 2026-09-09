Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C2E3BA22C
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 19:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788981449; cv=none; b=HeI4d4p2Eo/HTsTUayF7pdwgNCpA4vqHbkHNQXfm3cn8flumCaZSWPQHujFXM2ZVD2N41L9u7/6dd62zrY91HYfJlJWQo8Pnw4lJVDN1h2tRQMb7tAB/Cacs89MTT/9+w1dF27qD97TBE9llNIDnakofauCQQ9uAVeLAslpsMJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788981449; c=relaxed/simple;
	bh=Aq/afT/Zb1a7IfMLveiEW+HqgjjJmt2Rfon5Fw//hIs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=LCSq2svw9UKcbmjEnxO0NshgQiwkkJQDTe3EvbFKmLUDHtZ+9EADUxPzcIqxnZj/HLOJWBDSIG9SUSvbZ0R4E7Con9kwA3nqLeORVCC3yCTRZFZiZrZaKvrq/Yx69bgzXrHFu84Z9sU9NQfRqgMy0rpuvN5LPw70urT5BHEdPZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AxfyHO5m; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxfyHO5m"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-39b24d114d4so6734299a91.3
        for <git@vger.kernel.org>; Wed, 09 Sep 2026 12:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788981448; x=1789586248; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=g7E3wQTEdKBjMqPPvjDSF9+Z5KZwdkzoAta5RUW8r5U=;
        b=AxfyHO5mENtvyHo3lt6IVrVM41w6eF/euX0nWdZZnz3/a5Ztg/Et0VtDZ4vPhmLGrv
         oFvRCeN1XNszRkvDAa3gNvgvbTi3hWsg+YfXYnqBtA0lilkVC6kTwpw5Jtz7A6+TC3X0
         OJJExjR8IVlfnFkzZoIa+ENr56tn7PCQHkwEby7K/V50ARso6JHoy2NGbfzazXw0R3rg
         RRGuvRLNGZkrGMqpeb2yBcKmIuLmQ2xxj9Y/E7zb1ynmauJwcvdF1+LF2oh/2lT56Fgc
         5HAxiTjwvQebWYpWWd6v1fqU5s1v2SipTO+EHW33q1TKq5fl+FXzOkPyoLT+JgJgz1IM
         LVcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788981448; x=1789586248;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g7E3wQTEdKBjMqPPvjDSF9+Z5KZwdkzoAta5RUW8r5U=;
        b=Hlbnq2lp2Lbw8DYO6lHTgMWp+2RRwkpb7QOMngzExtl8op5R3Exhh3c+9SmExK01av
         SjA552U2ZWuE31aS9ceRIKgdkyVXlmDbF+qxj7KzMLESBc2RrsbTrT0z2DjCi2JuoGjF
         0EJsAneWZPHKxtuf8x1unp4TnEObYFqgpqKBjrsBHbuCwfbdllCwiAza3ombiF8Uuwuh
         1bMqYF9SdS7DI/Lnf9xb/f/L98Df3gHdueUnn0rUTZwKz+6WzXOdEp5rpbGHihw854I6
         qf1zlVM6txv6uDKZBN1H+E9k/l2TlwNAFEiBfzuaSvc2g4XT9/x+VFJBR08x3hqg5a7k
         01jw==
X-Gm-Message-State: AFuF++lP5Ew4WjongDYHgPfwVVXIn4ILQ6UCOP5HC18qi4njGMvUTyFm
	HiCsMHb/LTFK7aB/Kbl6/Qg9iry+No1iFlONwUgG+8c4i7Lk8Ci2YS8n9wt2jg==
X-Gm-Gg: AYBFou3oq9U43sMDegm5wP9jZENzsLekNQWLIwCJIw7XH7QNog2uN5lvbTQGl7VLfaj
	wNmkKZQ7ZDETDxlHAs5pVDVQSSErptVYzdPddbK/Ou1pxginY7fJrcX/1MUeXVlXFVEuACd+LFp
	atD9WHB0GZNq7QagLPRZ9uzjUyjBfKNdtrhvsZfaRGreh/OHp4h78TUhy/abaTGxJ2zzJZDf84T
	UwqOG9YM9Zi3lRanELFN2DsPbuvHNXk1KrdKIMw4EPWKTHTGQ4MyXBPokrgcyY3yb8j4jfKGmHs
	3jd3M61GGjA1QQh2Ma9aKp9ccBg2YDzmxWRuLdVm0m16CE4Pbk27H04iofgCGsl9/1CpLGXSNRZ
	gIL0FHC/mrdYWUtvwLfMtY85tbylsOEqSwY+ZY11l8cXuzmIhKBJXi/PecZrmAF9YcD9BzqL+J7
	HHnX1AGlFjwJs7kUaUQtvuvRVJvmgpr5b1SppsCBIGv825IFEqsQCZ6bnw9Jr4KkwZnIFwJtHP
X-Received: by 2002:a17:90a:2c9:b0:39b:2b5a:8dc5 with SMTP id 98e67ed59e1d1-39b2b5a9b24mr35002605a91.6.1788981448004;
        Wed, 09 Sep 2026 12:17:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.83.161.18])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143243767e1sm39091054c88.6.2026.09.09.12.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 12:17:27 -0700 (PDT)
Message-Id: <b49c42c50d0fdae43224b711ae740097e9343d53.1788981436.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2195.v3.git.1788981436.gitgitgadget@gmail.com>
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
	<pull.2195.v3.git.1788981436.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 09 Sep 2026 19:17:10 +0000
Subject: [PATCH v3 06/12] mingw: set the prefix and HOST_CPU as per MSYS2's
 settings
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

MSYS2 already defines a couple of helpful environment variables, and we
can use those to infer the installation location as well as the CPU. No
need for hard-coding ;-)

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index f6387f4c7b..8363239513 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -754,19 +754,13 @@ ifeq ($(uname_S),MINGW)
         ifneq (,$(findstring -O,$(filter-out -O0 -Og,$(CFLAGS))))
 		BASIC_LDFLAGS += -Wl,--dynamicbase
         endif
-        ifeq (MINGW32,$(MSYSTEM))
-		prefix = /mingw32
-		HOST_CPU = i686
-		BASIC_LDFLAGS += -Wl,--pic-executable -Wl,--large-address-aware
-        else ifeq (MINGW64,$(MSYSTEM))
-		prefix = /mingw64
-		HOST_CPU = x86_64
-		BASIC_LDFLAGS += -Wl,--pic-executable
-        else ifeq (CLANGARM64,$(MSYSTEM))
-		prefix = /clangarm64
-		HOST_CPU = aarch64
+        ifneq (,$(MSYSTEM))
+		prefix = $(MINGW_PREFIX)
+		HOST_CPU = $(patsubst %-w64-mingw32,%,$(MINGW_CHOST))
 		BASIC_LDFLAGS += -Wl,--pic-executable
-        else
+                ifeq (MINGW32,$(MSYSTEM))
+			BASIC_LDFLAGS += -Wl,--large-address-aware
+                endif
         endif
 	COMPAT_CFLAGS += -D__USE_MINGW_ANSI_STDIO=0 -DDETECT_MSYS_TTY \
 		-fstack-protector-strong
-- 
gitgitgadget

