Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC68E372B3C
	for <git@vger.kernel.org>; Tue, 12 May 2026 18:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609433; cv=none; b=OHe5pQfKUc5A3gWPbAr60fddlExkHXjxpwtvBeeVVYGsWj78K8tC3obIJZWhr+fIYazaEhQ6APrRgPBwVXqbI80TBenrhGcd82dzwtJbgyV1sYWbT8guDVfBQaxIXvZPVOwCxNTPbhvBldWXH3pIwfvwLbumIVa+a7/NHzsUMQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609433; c=relaxed/simple;
	bh=MHS6SwBwkELwSfYj/eg1jplSW8hzTqIYjQ9Bfq7/948=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=spZa3+EhrgwwTAS5I9BGvh9NXcB4HP3UZYXz9QZHkCeLWp8tlkwMZTTF9Q/zqRUS6br7HkLR0HlP1UczvVoPlo57kUnJsICL/82Acca7+Vpey32F3VjoIOhbxMD5QuwbtkqfidooZOojIN5h0/4Nb50yrNPJVMwxn729WeUb1Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ob7nDJ6Q; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ob7nDJ6Q"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1332772f6b3so3203686c88.1
        for <git@vger.kernel.org>; Tue, 12 May 2026 11:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778609431; x=1779214231; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KnmGdtjMa5I13rbmQlr11Ezfk+zJqJ89kDboKZFtg18=;
        b=ob7nDJ6QfIlxOzZYJxypIAP4hVVzosZBKad1t043wAtVMVAWTRZXQPEbTmciDXr3vf
         DWe+fRDc+H9ZHggO2AeEDYwcBdE343DVuP74xfJr6QVy0gHQabTAj62s6wWPvzuwPLgy
         EqWMLVBWnPnYZSBGTNlByjsXTkMpKkV1ZetXyMgk5ufQTq0OnYXUhTAmySdUrcsEtCOH
         MdMpqecdbspxAMPIiTJGs9Nld5NVbKL+m9NbP/TjwHAc9UBREgfvG9kMMQZo9zZdQKSV
         f64eSvY/B/EXi1CY/pHfKaUGuYnkvL7ctlEpToZpR9U7+1otDAPs++EDtQk96x/8X0DK
         oU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778609431; x=1779214231;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KnmGdtjMa5I13rbmQlr11Ezfk+zJqJ89kDboKZFtg18=;
        b=lQL3gI+OZrY0BXvO/fWrTfXQBnTs2gSWpI91r6I2p9Qp+UXaK3yOrdEx+axCa+g3oU
         sY054xsRCQWEbVkBah85W7aXIL5DpyrCb5bI53LaF3IIeJpGHfpzQEn3lSQ6I9YsZ0Gb
         ykcc5tfWrzgZLIsmsHeZ5opC8w2qHCW14C3e8TOmLQfwGpXKnSXsTxr7uH6ryeCae/F3
         RcP7mRpYjPLWXUe/c+AvODjB/OkmC0oCYH2p62x+c8TuOlMvTtEwCyUw9evLxdZzedS1
         0b2DVdzEDgwgobtOz4RI3naYUbZNmper+jCB+r54XhFswPYnpLTaSW6B/RwSxaa3H7++
         eg/A==
X-Gm-Message-State: AOJu0YzjIcVkcTlpO2qbOIGZS6s1f4VvpCdIv6lWAkSO+XxXxKv7Z3Ij
	KpSpxm6Y47ravBiLW7Ekrv7x0vc1UMoRnG8k76pPZ4LW+5hdaoXHZKAkNYfrCA==
X-Gm-Gg: Acq92OFUcTiIBHP0cmplgtsTfkCW5/QVAIzBmK8dDSYrIihy0plbbinzuRsuUtxPA1a
	LBaFPXFIU6FIUsRI3enimAFhMbO3fzZw4/cchOpKz4MKK5M7tZCG1P1zU9CrwTChqrlgwpcH+7b
	tMV0jJT0i/0O2stKBOpCRx4ww9cDK8RT/j8yV/LwM2YEd4e6Zaww6j2XSU5O3pglrR3mIVlbyfh
	G/4MujUexY2gP6xa61ZsC0KwrGhVWjPLj8+wTklM3S1HIGFKbP7FretH+E31n5ENEXCZfAC6DZj
	2Aw9bDGnu0aETR/98MZDCKF1QQ7Og9vT9/PrwVxB3OgoW31S6TWLMABK8KsK5HqP4iChxAWzclW
	IJnnSYJCYffMKw97ugjCFmsfAzVRhQK5ZgDP5c35C0GSqpzKcNnrciAgLZhwy+/eqx+vZxhTbz4
	qDD+OLFTzkPXQsllgrLn2r/6l/Clk=
X-Received: by 2002:a05:7022:6709:b0:132:5d42:55c3 with SMTP id a92af1059eb24-1343677e63cmr17825c88.14.1778609431091;
        Tue, 12 May 2026 11:10:31 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.128.208])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-132787673ffsm25675936c88.15.2026.05.12.11.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 11:10:30 -0700 (PDT)
Message-Id: <3a656f8c0fb52a2949041dec55619acea9c117df.1778609423.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2105.v2.git.1778609423.gitgitgadget@gmail.com>
References: <pull.2105.git.1778022144.gitgitgadget@gmail.com>
	<pull.2105.v2.git.1778609423.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 12 May 2026 18:10:23 +0000
Subject: [PATCH v2 4/4] parse-options: clarify what "negated" means for
 PARSE_OPT_NONEG
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
Cc: Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

The documentation says the flag prevents an option from being
"negated" without specifying what that means. Add a parenthetical
to clarify that it rejects the "--no-<option>" form.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 parse-options.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/parse-options.h b/parse-options.h
index 706de9729f..0d1f738f8d 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -117,6 +117,7 @@ typedef int parse_opt_subcommand_fn(int argc, const char **argv,
  *   PARSE_OPT_OPTARG: says that the argument is optional (not for BOOLEANs)
  *   PARSE_OPT_NOARG: says that this option does not take an argument
  *   PARSE_OPT_NONEG: says that this option cannot be negated
+ *                   (i.e. rejects "--no-<option>")
  *   PARSE_OPT_HIDDEN: this option is skipped in the default usage, and
  *                     shown only in the full usage.
  *   PARSE_OPT_LASTARG_DEFAULT: says that this option will take the default
-- 
gitgitgadget
