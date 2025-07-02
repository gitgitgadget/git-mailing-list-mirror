Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A142459D1
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 09:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751448210; cv=none; b=jzlekdniIYj6kWiGF+a0szjptuGc3AJTUrzWp4n+had03wMUYW0fzoXR3S9eZ/0lpSfktCwoFoar80O1Uy1FST2+LvJv+SghlYzbtt4ZODOX8kqoIz7YJ1geSGlr9WQ5ILhNdcOFPzzXRbEleo0eDlfFfuezDDTrwk80TbFncz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751448210; c=relaxed/simple;
	bh=Vpr5WoPO3M/MxPwIqMvnnQ1IcEiCXJwPanBnVoizRiA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pmOdvM7HSlF9UbiQ8wLAUZsPpkVZmed7kzsB6a13yqLupydbj+ztotUNRqKAM0kggSdRVEVhS+fab+K6pDoQIhWXI2wzG2ySmfxgU9pXW3Wpr4eFLj0KX0fFj/gXguztKGqqV+5zfHTS/Wqw2TaWjpFVBivOBrGtSRzti/ixfA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X53lSi/l; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X53lSi/l"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-604bff84741so12237308a12.2
        for <git@vger.kernel.org>; Wed, 02 Jul 2025 02:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751448207; x=1752053007; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RNkJJQLZapShHWYzzakLNBH+zq/DJ3E+rG+hUd/in/k=;
        b=X53lSi/lY6CB5ZONaevKr9gQVd7n1vuicd4zRPyR7zovNSTBM8AE2Aqe2AAwVIhs+k
         xwYrDdkM5VeqrNI3hHCRsFqYsw0Mr1lSZOjWhgMK3rE8n4kIkzD/OgHBh5CmolODSHXf
         NcbKNfZ7yc50kRkJa7pRqAQU6F/RXo/TxX+qD92AvB0dgifpFb2AFsAUVu5tZ6bu8xAm
         sLRYCLs/2Pyy/oD12ItrQrixhepnHCO53rwnOZaJyi+mwxVWqrd0P68xfEt+v/mPNex6
         /i4vzQRziXttAvszYesQnH1fQ9ggprrFlCoPlajsXmo8EUIbKkp9q1F4oGKi4BXGe045
         PdBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751448207; x=1752053007;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RNkJJQLZapShHWYzzakLNBH+zq/DJ3E+rG+hUd/in/k=;
        b=X/OqRDOUwXEyFbBgCqitvwfp5FSGnDXB7cQFihfcc5mrIIJBDDaGvV8VZBXzytue9Q
         IxZ/wfMoiv9PPmyQveEA69sVs4VLzaKM6DJhHrQ7/pmJ6PW89+80o+HobkAoEjt4gu2c
         EJw6+dpw+lAyISAwBtPJpGL/2EXSEYHokLm+4SFpQ+krTg2rYTQ9F/L6K7CWZYLbswyg
         4o8FxtmDkTpOEv09ZoFvnWUdSCfD4vCwb8C54Gkochazin/AEBAnp1lCbIzEFNqlm++V
         pY6t1u0sBkdwvwgPyv9zn1gNO7I0o90MQxNm+iPEjBS0J813jN003m9T6NICGlAo7M4X
         WAzg==
X-Gm-Message-State: AOJu0YxECo3L+PbX2A2cvHx43JtyfKVDkm+c8ny4jrkDTRmy81trO0oy
	R6giTlrLfUDxCS5TgeRJgFXIqQLIGDTPIxiAZgueOmYJdzvsxXHMMWhP
X-Gm-Gg: ASbGncsW5zyWM6GZG0vpyENm7gWHqbqk1hjuy8g5cxQg49GkPqGZeP3x9uO2AqUzut2
	oJAp0OXiilakXzE78zPIfHWzPjhkbG8JC5srjDE7C+E6YA9G8tx5/1K6PYlBXzsA8oxyoSIIMy+
	IkxBALqpmcqpOwRXR1iaX/8mkUYOEMaF19Si60h0wSJsXP6/Utf1fbocI1SJkjZ+mtjhIa5KGDg
	PS5Hm1nTiL6gVmtO2qVYLHKRUV4f4XQXZv3a21iU17g9R6Y+3ufTweRzYL6r0tSQ4vFqTEl50Pu
	WHDNroRXAHoDGw/n0OFNZxpKyTT5PaLxnoy880KmXFLsRv4b5hoo8LMU
X-Google-Smtp-Source: AGHT+IG/XZWiFeiVfOMWXcXSTXKVUqZyOqDBMdOh7P1Apu1BZCLt8p5dowbgZR8ofnFjwMXk/hWsGw==
X-Received: by 2002:a17:907:6e94:b0:ae3:a71d:1984 with SMTP id a640c23a62f3a-ae3c2ded2abmr218226766b.57.1751448206984;
        Wed, 02 Jul 2025 02:23:26 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:56cd:2345:b424:ce97])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35363b1b9sm1052809066b.12.2025.07.02.02.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 02:23:26 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 02 Jul 2025 11:23:18 +0200
Subject: [PATCH v3 1/3] clang-format: set 'ColumnLimit' to 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-525-make-clang-format-more-robust-v3-1-705344f30580@gmail.com>
References: <20250702-525-make-clang-format-more-robust-v3-0-705344f30580@gmail.com>
In-Reply-To: <20250702-525-make-clang-format-more-robust-v3-0-705344f30580@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com, chriscool@tuxfamily.org, ps@pks.im, toon@iotcl.com, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3027; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=Vpr5WoPO3M/MxPwIqMvnnQ1IcEiCXJwPanBnVoizRiA=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGhk+owaKRpwUAwOmUT2bTgWboGkNIQuc4P8+
 IfaI46q9XgtsokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoZPqMAAoJED7VnySO
 Rox/SMsL/iDC6kHbYtqm7rWJv29H+iXg7p+kM3fc9cSW6A/bz3ApdeFXfA+FXlEOIWuhGNym0t1
 RPxbv/H+A01/LRi0GmxTJZpVCTXf0vKS6HcZq9ywPd2l4fMOTF6uI9+k0f8AFYNo9mDotWBVnvn
 xjo8jhnlhhs/NyPeohZMHL687aOf1+eoP4pDgwa+Grod8pjKdEHow872YLJg6tmdmxD2RByoe2P
 lUE/sBQAbI3ZLXSiUlJtjmQ0+bth4nCrZA93FP1rMr4oKAuCQYPSAOWFrxBKcn+xFD0jin0Wze3
 c94rfHemRMrmV1gCglhZkH5e3LvKGl+Pn9xlu/BHrh6CeKDoRp11uZyN1Ys0yVIgOXAa+O6i92y
 LpQiHxog4NlEplTGI9GtGxsyIgZPFnQA1sYxeo6UMNq4S+xlIkyzEomeIvV2mArbb2a8ifYosKR
 6cnp3EnIqKop4o2R4fkC2Eug2vMh1mS5fOtEGygIK9PHhNd/QHIhjiEPbOdxd9lLMmi7l2qq6m7
 HE=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

When clang-format was introduced to the Git project in
6134de6ac1 (clang-format: outline the git project's coding style,
2017-08-14), the 'ColumnLimit' was set to 80. This is inline with our
recommendation in 'Documentation/CodingGuidelines', which states:

  We try to keep to at most 80 characters per line.

However while this is recommended limit, this is not the enforced
limit. In some cases in we do overflow this limit to prioritize
readability. Setting the 'ColumnLimit' also means that shorter lines are
concatenated to simply as the result would still be below 80 characters,
which is undesirable.

In the past, we tried to adjust the penalties around line wrapping, once
in 42efde4c29 (clang-format: adjust line break penalties, 2017-09-29)
and another time in 5e9fa0f9fa (clang-format: re-adjust line break
penalties, 2024-10-18). While these settings help tweak the line break
penalties to be more in-line with the requirements of the Git project,
using 'clang-format' still produces a lot of false positives.

So to make 'clang-format' more usable, set the 'ColumnLimit' to 0. This
means that line-wrapping is no-longer a concern of the formatter and
something that the user needs to take care of. The previous commit also
added a more flexible guideline to the '.editorconfig' setting a
'max_line_length' of 120 characters. This should provide some guidance
to users.

In the future, it would be nice to re-instate this limit with adequate
penalties which would follow our guidelines, but currently, it makes
more sense to have a working formatter which we can rely on and which
doesn't create too many false positives.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 .clang-format | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/.clang-format b/.clang-format
index 9547fe1b77..19d6cf4200 100644
--- a/.clang-format
+++ b/.clang-format
@@ -12,7 +12,15 @@ UseTab: Always
 TabWidth: 8
 IndentWidth: 8
 ContinuationIndentWidth: 8
-ColumnLimit: 80
+
+# While we do want to enforce a character limit of 80 characters, we often
+# allow lines to overflow that limit to prioritize readability. Setting a
+# character limit here with penalties has been finicky and creates too many
+# false positives.
+#
+# NEEDSWORK: It would be nice if we can find optimal settings to ensure we
+# can re-enable the limit here.
+ColumnLimit: 0
 
 # C Language specifics
 Language: Cpp
@@ -210,16 +218,5 @@ MaxEmptyLinesToKeep: 1
 # No empty line at the start of a block.
 KeepEmptyLinesAtTheStartOfBlocks: false
 
-# Penalties
-# This decides what order things should be done if a line is too long
-PenaltyBreakAssignment: 5
-PenaltyBreakBeforeFirstCallParameter: 5
-PenaltyBreakComment: 5
-PenaltyBreakFirstLessLess: 0
-PenaltyBreakOpenParenthesis: 300
-PenaltyBreakString: 5
-PenaltyExcessCharacter: 10
-PenaltyReturnTypeOnItsOwnLine: 300
-
 # Don't sort #include's
 SortIncludes: false

-- 
2.49.0

