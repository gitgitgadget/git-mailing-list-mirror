Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEAC438010
	for <git@vger.kernel.org>; Sun, 27 Sep 2026 19:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790538730; cv=none; b=k+xm8zHhY+UJ9MQGFhtzGwxGowksvbgtzRHQydaEgkxQ3I9fqM4WNYe22DbrctN7+9pEXksvUaD67piTEbAJc4aJhl9AHo01zYO+qrxbhNZwYO2bmHSFxrU1ODwn7fuQTbFsCM1nxxg9xnJ/Yf/roiNTh7PZPdMyB83kUzocg0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790538730; c=relaxed/simple;
	bh=4F7LuyiV71sP8/u0RQqWY3Kzfea3sKr6h0riI4E6zHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e/P5xSwhwLBkVNfeXiAAY+P8Fs6/WLMpFY/nAbqae2A9duSYUE78JTJAoYN7g5eZHdjN43O/lWtTGQ0uWYd2n5CPlZzrV15Dp2UQs4cjjNPi8csrLMT6Sdr+QSAWveeowBEECz8YzLBFB2qIBYQbsmrSLpREwwh55HAvvyau+jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NkS7HqGo; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkS7HqGo"
Received: by mail-pj2-f41.google.com with SMTP id 98e67ed59e1d1-3a0bd71827eso1257150a91.0
        for <git@vger.kernel.org>; Sun, 27 Sep 2026 12:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790538728; x=1791143528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5y8lFJkqUP7afT17JpD4fPb9Gyr9DJCU5NJCBJ8qCgI=;
        b=NkS7HqGoJwZqIGpwUvsZHDN/yF8rCoofLRQksE4wrqjdklt9eIjgbl5KzT5pY90aTA
         lBhMuca/uKT6tG5Y0t3/roHllm0Bus1wWvGH7fNixtFb34q8XiCaQulFLz3OocHaaEKo
         3PqdUJnNo4t8ZeQ1OPuCVVD+u7NLvtQvPj1IqeWYfQeUTUbqPEyfoAv6ZE/oiuXafqRj
         DBFbY+6iupZwGhqrcTePy7F2BXnTK9qQIaBJ9rh7ZBKVASmvZqz3IzeSQgofCHQc3THy
         FUbPuCWiDuPW6lS836puwOtzExoj7eLyryzsc2ziGJCwp5MNeRvtKIKrdWEos74oC3WR
         nwog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790538728; x=1791143528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5y8lFJkqUP7afT17JpD4fPb9Gyr9DJCU5NJCBJ8qCgI=;
        b=uWPaYviTW/2mpfoVM+cMqqvwfzxiTDPJKg0WXc1tyCT43IPkz4eViZwLT63EevEAXP
         hADjZXBnFkOYgzHUN1ZpdEvi+RA6DDBkQA0g8gksthiWCzDeibTBaxzC7GQxgnJ4mRmR
         NBl1wH3n00/zofHuHgGe/QLRoeFTM/BmbH8ujOxfa53m+33nIt3c99MVYNQ1am06W7wf
         l6FbQ1NoigDGN/tTJnWi50PhZ/LXBORvaCtvr5WhU18LpQWERcJ5dRNWQNa5HwcsMx7+
         TT23SPjQIGAxNev6Q8acDmr/31hv7ehJHH27CuGqM4gbp8HNIt/5Mh5C4EFnJJy3XU1Y
         CJjA==
X-Gm-Message-State: AFq9FYI3kOCWYwGD0GV+yGvr4x1ZuyK+JqY6zuA5iM2VVrxxCydCtSC8
	HCu7sneyzvQ3LU4Ox+CiQS6LUYAPwg6KEKgOh8PYbdLcTnwI7VtsVEU9fkq2OHsj
X-Gm-Gg: AYBFou1hg1Jh5fWhRqXoTojQ0/T0JQ6FvrlsqQzpD6kOlXNSlNbAINk1c2Bm98cN437
	AHOR/3yF4vjeSCU5otNqzxbzK77VPg3LBvCf28s4suNYSyusELBWeXuAvPaH0Z3rLo/deJN4XpE
	ZyqnPG20X0Ud+Vlj4a2yqluD07t2Hhr932q3B7kiK/JiztaeLFgawTjgVzh5LhvIudxZHgyDmoJ
	+IqG8vzxdS0fbtiNFSDstrV2jpyHrHQxDEaFIgE29BCnSi74vKohFTIt1Ul7+Y8E3zXAwoJ08W6
	kD8QRJvQq1fe1EBO9YUTN68BMT5QwIjiDO7pawqt9eHFN9VTQGvQoLh+6thJRO+fbdeuq2bp/AJ
	Ew5nSmNFHU+8vKXA7nv0JJ1BFV+k0iJqwQvddacRN2oAWH7OC9AdHjJoyQZt0YcTDnAukOhReN/
	yGSv7fClp1tf2xmHv2WQ1KY9JUST9LJln66qVmaKN0e+Lsn3p5/Brwdrw1Cqqp4CzgMdlmbd2lk
	4D4Br0NWEA8Z70=
X-Received: by 2002:a17:90b:17c3:b0:3a0:bfaf:2ae with SMTP id 98e67ed59e1d1-3a0bfaf039bmr6046955a91.43.1790538728065;
        Sun, 27 Sep 2026 12:52:08 -0700 (PDT)
Received: from aegix.lpu.com ([128.185.168.198])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b4983f43sm6255027a91.0.2026.09.27.12.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 12:52:07 -0700 (PDT)
From: jyotish kumar <jyotishkumar725015@gmail.com>
To: git@vger.kernel.org
Cc: sandals@crustytoothpaste.net,
	jyotish kumar <jyotishkumar725015@gmail.com>
Subject: [PATCH] name-rev: update hash descriptions
Date: Mon, 28 Sep 2026 01:16:02 +0530
Message-ID: <20260927194602.86750-1-jyotishkumar725015@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <arkfFUpCskucD7Nh@fruit.crustytoothpaste.net>
References: <arkfFUpCskucD7Nh@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The documentation for --annotate-stdin and --name-only refers to
SHA-1, although name-rev handles object IDs according to the active
hash algorithm.

Update the descriptions to refer to object IDs instead.

Signed-off-by: jyotish kumar <jyotishkumar725015@gmail.com>
---
 Documentation/git-name-rev.adoc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-name-rev.adoc b/Documentation/git-name-rev.adoc
index d4f1c4d594..9837fe59b3 100644
--- a/Documentation/git-name-rev.adoc
+++ b/Documentation/git-name-rev.adoc
@@ -43,7 +43,7 @@ OPTIONS
 	List all commits reachable from all refs
 
 --annotate-stdin::
-	Transform stdin by substituting all the 40-character SHA-1
+	Transform stdin by substituting all the full-length object ID
 	hexes (say $hex) with "$hex ($rev_name)".  When used with
 	--name-only, substitute with "$rev_name", omitting $hex
 	altogether. This option was called `--stdin` in older versions
@@ -72,7 +72,7 @@ while its tree object is 70d105cc79e63b81cfdcb08a15297c23e60b07ad
 -----------
 
 --name-only::
-	Instead of printing both the SHA-1 and the name, print only
+	Instead of printing both the object ID and the name, print only
 	the name.  If given with --tags the usual tag prefix of
 	"tags/" is also omitted from the name, matching the output
 	of `git-describe` more closely.
-- 
2.43.0

