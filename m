Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2612FB975
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 11:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758800676; cv=none; b=OIcOUqWJWz2M1F2+HgsyH97BzMZUL3NY0Xw16vDG1jC7P0UW1MjQb8bAh9BSVb4cR+JSS+9ST8Pd8ae7QNQLj2Xux+AgyY74u1G8SX7eXyD3nMwDU1yReVvw0tcGTAQYYbRBwH1aZ1vMATUfUeh685K1DX4wOi/LTbCfGghYKuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758800676; c=relaxed/simple;
	bh=rwixZ5310GB1yWYMUco5cwCkSGj+L7ibVrC8UHnHRN4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=opeGrjeGL4YhUqOhnJC2bdWaeA3g8GnH385uoXDQhlvIt9jbwcF3tLfntFfYTBAAEuxoQX/GhLkMV+bW3unDcjCYKg0XdCOxMbkajaLCGBCfuVIRNjX/5ZWgruEATcND4tKakNM0CeguA2C1e4Qd9q3wPsZDJLDcqmWvsFDcHIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7dPVH+0; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7dPVH+0"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-85cee530df9so48716385a.3
        for <git@vger.kernel.org>; Thu, 25 Sep 2025 04:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758800674; x=1759405474; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uxoFNfmxJNaO8HV39KBL3+UwvUgT52a9pCMuGP/Z+2I=;
        b=k7dPVH+0oCR3/zc+h1AlUMwHayN5b/8aB2t776Mb7M2fQpZ/AP9BmO2RmLpiNrCb1U
         rdmRx6xBONC/fE+jf5fDQlVkE33EN0XT2EaUjZQ5epOdgrSXe+pIM0godTf0a2QQPr5A
         QmiYDia27iUwMgVMzm+OwY5JyTLUBLbU16Bq17reuZTX9swoMHpraQ7r3mE5BBMYLyi9
         TdUMwXP26aYpBd+QikVmc2LZowWJqEO/8xCoxrTLr5GYz9IS6aXnm7dXEuiJo0LeBIpX
         0lfEnlpW13YlA/QSmCC786cdVyrf0ADgT2Wk0ejvsInZOo/HXYYGRZXydH1NF642Xk9m
         uIIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758800674; x=1759405474;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uxoFNfmxJNaO8HV39KBL3+UwvUgT52a9pCMuGP/Z+2I=;
        b=jWLqQsyB6jOd8EbXSec2rnCT4KObFoWhI3VKLuuLhnSAvbNHO/To+Vc/TjJeiWwhv/
         s/qG0ZTV5J+g/AntSVgEsfuFMaJdlcZaTRIqpQnnJNBAWvyqvNllLCmSiynhNzqpVK+p
         zR/Iq5x8Krg03R8PFZdVZHeWvdhuGRNVw14dkYaKggkMrL7wjxpqu+FDWK/TnSlqRnFY
         WZ2wSdzroNn8Me3IXilADxZ8VKMAxlVKkBGIhu1whM0r72yDmN23shU+sRssXM6JIwo0
         y9RabuK5LAbwqIKZkWS2c+norRfRluHRapYgmSchVas+yim0Q5NH7SW6bdj04bvMmZ+W
         czLA==
X-Gm-Message-State: AOJu0YxBO/PaIxZdU+Smisca7gQwmuwb96jop5avWV+xQ2sQMyWxehkh
	rgRUYGNFjf/FtfRka5Npeol/OFIVqtbeH25WkhgEQDhyrswx5AfBCtcRUURfjPgK
X-Gm-Gg: ASbGncvCaTzy8qcwiVyGuEvHJqLOGqHDjaGFeQ9biiVutMb7F+rcdx37cg9SIC/cHzn
	kVtGoZFMpDX0O1pg6t3r4j0FQQvvTEh7GrEF5VPxTv83uYqPc+pfL7RvP3j+lX/X8HfC5j3zPI2
	yShiECJdc0HQwVkdSYMIcFNwBdwFRB8EHxvW+y19L18x2Jw6kYbKnFNNEyJSiHEoPR0aDGSUSPf
	0JgpGqpvi58ma+YPeY+6K5+2o2IuECKpkipndNt6ZkU8hBhbbOvTUrZkskXlPh0TXA+FkyZycXO
	8Mt1qZ4KCpdVcPT5wXwWcAnoPTmztEfNrMbR1cixkIg7hi9CnU6tCzpeXNA9W03rm7VDwDZtgj4
	ZekOBPwcIDGCLg7Drb2tvR1QFcg==
X-Google-Smtp-Source: AGHT+IEG4edXk93d+MDMz0RjDP9GcPYVWmxmhMs5LLEtzzizmaAkVoYCif8i0zHEy6yFG7mcVlmcDg==
X-Received: by 2002:a05:620a:31a0:b0:835:f446:e255 with SMTP id af79cd13be357-85adf7bb86amr391793285a.4.1758800672676;
        Thu, 25 Sep 2025 04:44:32 -0700 (PDT)
Received: from [127.0.0.1] ([172.174.167.23])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85c34ac3bf8sm96304285a.66.2025.09.25.04.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 04:44:32 -0700 (PDT)
Message-Id: <d7810781fc3af1902c99cccbd50853dd630a0080.1758800669.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1977.git.1758800669.gitgitgadget@gmail.com>
References: <pull.1977.git.1758800669.gitgitgadget@gmail.com>
From: "ionnss via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 25 Sep 2025 11:44:28 +0000
Subject: [PATCH 1/2] po: fix escaped underscores in README.md
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
Cc: ions <zara.leonardo@gmail.com>,
    ionnss <zara.leonardo@gmail.com>

From: ionnss <zara.leonardo@gmail.com>

Remove unnecessary backslashes from language code examples.
The underscores in "ll\_CC" and "zh\_CN" don't need escaping
in Markdown.

Signed-off-by: ionnss <zara.leonardo@gmail.com>
---
 po/README.md | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/po/README.md b/po/README.md
index ec08aa24ad..d7757bed4e 100644
--- a/po/README.md
+++ b/po/README.md
@@ -13,9 +13,9 @@ We will use XX as an alias to refer to the language translation code in
 the following paragraphs, for example we use "po/XX.po" to refer to the
 translation file for a specific language. But this doesn't mean that
 the language code has only two letters. The language code can be in one
-of two forms: "ll" or "ll\_CC". Here "ll" is the ISO 639 two-letter
+of two forms: "ll" or "ll_CC". Here "ll" is the ISO 639 two-letter
 language code and "CC" is the ISO 3166 two-letter code for country names
-and subdivisions. For example: "de" for German language code, "zh\_CN"
+and subdivisions. For example: "de" for German language code, "zh_CN"
 for Simplified Chinese language code.
 
 
@@ -126,7 +126,7 @@ you add a translation for the first time by running:
 make po-init PO_FILE=po/XX.po
 ```
 
-where XX is the locale, e.g. "de", "is", "pt\_BR", "zh\_CN", etc.
+where XX is the locale, e.g. "de", "is", "pt_BR", "zh_CN", etc.
 
 The newly generated message file "po/XX.po" is based on the core pot
 file "po/git-core.pot", so it contains only a minimal set of messages
-- 
gitgitgadget

