Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DF82586CE
	for <git@vger.kernel.org>; Sun,  2 Nov 2025 16:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762100304; cv=none; b=GOXhpHZhts650GGJHsaiuKYDuRGb6qdWlFg5YkZZftFFYr0J6ROyg5149egSGg0ooh7jc6lnci93gtCH+qNQ5dvaPM46IKWCIxz7hQbyv9D1KoDftOYFYMdVlr3ogO/wNY7XvFt0AwJHNLt+exNw9hp6UrHMvupDtr4G718hg+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762100304; c=relaxed/simple;
	bh=LspwbcDvjCJn1ZVvVz6X7EfJnh44oAm1Hshw1mmzEdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PCRH4zSOTRXTCF/uH7fC4VmT4V3GMkjI9EK2e13njLbgz97y4QAUlHWlSC54YaXNl8CgKBU3FakSuFihItKkUgJpPup3TehhKk5/KuIJ4G36Pgd/lWCTPREXkHf93wWqKRt5AAQUwwnoL3SROP/BWdO78IuFzmKqMgDGaWIOcN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TSCBlJnc; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSCBlJnc"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-63cf0df1abbso4020081d50.2
        for <git@vger.kernel.org>; Sun, 02 Nov 2025 08:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762100302; x=1762705102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PHnSEjSGjscpiwGoENLyVB+50AOTGhqfgQhS/YOjR4k=;
        b=TSCBlJncQ4j2HOTQrUle/i/hfbv4/jE7v84puPIOW1cZO9wsTjmqoRRbAkwmbDD3OW
         MHyRO4bIjNR9kax0hrXwMWJP0BbV1RVQsBgZZiY0JJTDW88/kbGmqGhIg7FOnWRJ8NyY
         T8p7UKPZ10E8XV6+VJK7M3Cz67hgjK4/awNzUarw9M+pX/mm8x95QAnpO/dl6ADgLfiB
         TrZ3QsuxXqYS9wzCCBbbIFkOnpMp+CeIS6TV9TW0mfXLqwrV1K7BMKTlbmLhMPzZHZ+B
         JZKv64GVtqmDQkKX7+wpmeoF57mnJQeral3pWjqSQFeYL8KaRO2swEqQK8BQmmrBWZyc
         TSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762100302; x=1762705102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PHnSEjSGjscpiwGoENLyVB+50AOTGhqfgQhS/YOjR4k=;
        b=ZxVRnGsjId0g1DaZdENZrIUTZhCZQfvQzbT60Y5SCWb42DKcyi2IkUQb+E/B0VlRGy
         RfgIWNi8U28260dZdxlzZgNuDpSBRuFFf2MGcdquQBbv+gqcyBTYL83Oqs4Q460fnjFN
         01CtMdy6UZnCO7uBPZSq8PVGw3M4HHgMvRursyb4EH13jwI2v9n0o/A16YlecxP9dvTm
         09ZCicDc4Kvp1R3rcoFhawKISm+nURcgBIqmG1IbDd630xADvrWrJxczAgjWt1gIlPjL
         RVqNhk89gfjtlMM7ldrX/aaGYAZb/on/vD7qtYYA8DDEcYodnLhCybHXHvUrwCBPWYzM
         Scfw==
X-Gm-Message-State: AOJu0YxVRZ8w/HPIbo0OgczDanvEXKOw+A+oBibbTQyButzWtAwWuUH0
	DZ1Yam/3mVF2gpeVGkWnsfy2NeAms551LwmfutL83ud8j0BYxGOr06ehqU2Gp1EElq8=
X-Gm-Gg: ASbGncvLc6b5Yl6V4mkC4T3hJfy2gEmfa4FynKkIZyebmDbs22IlMGc0+x99ouzWGV+
	5Q1t9uHWB391U0drrdLW8koOsbvSl3y6cq7SrfZXcApfEED2fKzVvgrtxjA1UhvPywTahEsa6ll
	crMgjP4GAecK/wrtSe5pVvtLrbEBaIcg5hLZ7+yattwejLcX6eU5QJaUCDRYhpG68BAIrHe52Nc
	sRmFSqYoOK6tWO9zVzDL/740piTNEejb4JG+AQbVcnmFwBpeDyzv8+ujQyW4NIy12lCOdLzZsji
	1PJG3CIveqBQ/VCYe6xhu8gTR8YnpxHs0ZPNec6fnmIzphOGvTPfPfofVdmlR/2Utr3E83fCION
	puNJs4Z2Jd1Nzg+ShTzZsDtkS30Eq39nCQg8P+pjnjkJX1JN3650QZ4BAEPh6c6pOfOgwaSGPNl
	ICX7P4Cgln8lw0IX4NlA2znewYqINUmiOs9qviqA==
X-Google-Smtp-Source: AGHT+IF9zUAxiEdXv+ph60N++9wEFihF60c4aewc+WPrH5j42NYADO8MTS59rD6nFuHTTEb4J+J9Mg==
X-Received: by 2002:a53:c386:0:b0:63e:481d:a6b2 with SMTP id 956f58d0204a3-63f92320109mr6001554d50.58.1762100301690;
        Sun, 02 Nov 2025 08:18:21 -0800 (PST)
Received: from macaroon.lan ([2605:a601:90a8:8b00:c038:e715:f394:297e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7864c6185c5sm22626967b3.32.2025.11.02.08.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 08:18:20 -0800 (PST)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 5/5] parseopt: restore const qualifier to parsed filename
Date: Sun,  2 Nov 2025 11:17:48 -0500
Message-ID: <cedd4c3dbf448ae479bca109f74e1dd6f64cac72.1762100242.git.ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1762100242.git.ben.knoble+github@gmail.com>
References: <cover.1762100242.git.ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This was unintentionally dropped in ccfcaf399f (parseopt: values of
pathname type can be prefixed with :(optional), 2025-09-28). Notably,
continue dropping the const qualifier when free'ing value; see
4049b9cfc0 (fix const issues with some functions, 2007-10-16) or
83838d5c1b (cast variable in call to free() in builtin/diff.c and
submodule.c, 2011-11-06) for more details on why.

Suggested-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---
 parse-options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parse-options.c b/parse-options.c
index 197c01987e..be3d8f6599 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -213,7 +213,7 @@ static enum parse_opt_result do_get_value(struct parse_opt_ctx_t *p,
 		if (unset)
 			value = NULL;
 		else if (opt->flags & PARSE_OPT_OPTARG && !p->opt)
-			value = (char *)opt->defval;
+			value = (const char *)opt->defval;
 		else {
 			int err = get_arg(p, opt, flags, &value);
 			if (err)
-- 
2.48.1

