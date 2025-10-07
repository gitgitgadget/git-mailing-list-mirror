Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78CB2DCF41
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 12:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759839101; cv=none; b=soMb/NoSpZ+oPcTmphMDTL/c6cgWZZGzMXUeNkaZkjMRQvtvF15tl7Yex0rQW4+9SOzgx8/JMkK2akY4PCxrzJZpPDGelfPmB47CMVPi0AmruNhsTU7tDRrapJ1o6+I1keBExz2fdUdOb504wMOeuyt8ywNd+Dt0ByIK9o5jcdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759839101; c=relaxed/simple;
	bh=NrJUe2zo/755ziLfa/YcRS7uqgD2cBYrUKpni6pfRH4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jsnagiFNPHDTQUGVQ0fWP6THciEhLFdcQGHmqu4qA6GmvLg5ibzyAv0nL36GP+wQRcoheWfc1eD6SeMnxljS/5hHLb4UoZoCSumgMN58K4doTYS9qjD4AGRl68mXb0NrlMKpg6JsoEcqNCmXJdJ0zbXMtUxgJKGFCvWNKcFE5o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QTWYHCkJ; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTWYHCkJ"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b3e234fcd4bso1012183866b.3
        for <git@vger.kernel.org>; Tue, 07 Oct 2025 05:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759839098; x=1760443898; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cvm1oKFZ+vpkVAHmHsvyiZuwnhtvDFDUJacA5oxlAME=;
        b=QTWYHCkJiuBg8hPTuDh2jB8MHbMLGBGBNw6lHvjap4Bdixax6uYodAQB4JJwh7xJFK
         XLz9sGSDntcjQGjmOW/1/Jl5MZBFFPQT+6Fjy5ruZ/x3tnBPWZJQnhztAEjQaKtzVQW7
         7Z/dgRz0jr9vVv/G8+2tAh56VczPyvvDYFy+TGo8SBm3qOoWpBOc1P3qlCQigiCINb5W
         2EOX7qQtICYh1nvIq28o0rlWzRFgvZXTjMRJkQy5r3aWnIBvF8YplOCNkJG4VXNGypeS
         ODnEZ6RyQxGCqAoDCJaT0LPHTczriU4Izcnh+745Mg/bzl7sIlKu64l7axpq8V9K9cX/
         3oMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759839098; x=1760443898;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cvm1oKFZ+vpkVAHmHsvyiZuwnhtvDFDUJacA5oxlAME=;
        b=eJFC0RitT9ALXn8blTsfTC+gfXajAxymVyO78bEnpvTyo9dfl7u9kKDOJXriWfR6XB
         XGlCjj+QQb9Y5o8+Cm0OU3D6Ehz34TV4V5t9/AcZSNulBKTJUV0LaBfjU2tLXMKN9d7S
         MMuuZ8HCp+lQr5CTsBZDGOXP6MxkA1Q8vUIGLzMpLpvRDA/BK2DcVWmdnLsEGIz8XvBO
         yGgqT3RFJ+QGwiZVCpOLYb1ISSl2n8bjarlulMvtyrQSprItmx1jyq0hBsaIW1QIBxy9
         cTapa2qeOUq/9/uhSys0Nnu3ChI0JFvA+Yv5qDtLn14stHMSepdGGQKF6DbIMvszSrcs
         OrIg==
X-Gm-Message-State: AOJu0YypzRSLJqOYYV7VjumU8mHm0Xj+VlMd+X946uGQXgqX17UdgnuB
	O/UQyfpS4bBzFCbMXAK+DZDMaeQgplkkMc11DeoKzwX4fJGQs1tQN7H0
X-Gm-Gg: ASbGnctOsgdXwsEKbDA8M3lWNP5b7X9uOTO5v/+sQZ8QUfOt6t4yiEXf9PuwNCP9DsX
	N5xNkNG5lM5hqYlLS4/WnQsV+VDZewpDqD5jg3lwdb6Jjb/Ho2iIaN3KXPghz+Nj5yQv/ybHSbK
	jChjRB85PyBXGzFNlvYA9WUyB9r80y5hcFOqwxze6jhBxe5qEiPySgGSULLYkd3aRzF2azofkrT
	B3PddgCEiQXj4UrYCeNZUsyoOxqfFWBWxpI0Mokj81RE6B9BubBnIHzFJDd0CKWKX9b4bOBYfrb
	Q+y5Aj8j7HJdMU/O2R3Bd2h395qfvrXNLR2MEUSmtRfXf4suwR0JBRjuDKsmJMY0fivTe9RUx0f
	owKmhGDN/uwmwhkcBTqi6aVrAhBoJQIyxG2K7JXYCR+EIuxHs
X-Google-Smtp-Source: AGHT+IFRkLHiFwh95S3sKh/04orrekeO7wwAxIZavuZ7UDjUSzaHLI2Ax2qPWiJR7yNcNmo8dVm7tA==
X-Received: by 2002:a17:907:3cc1:b0:b42:365:3199 with SMTP id a640c23a62f3a-b49c1d64957mr2093174866b.25.1759839097800;
        Tue, 07 Oct 2025 05:11:37 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:406:6e87:ed:4c93])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970b36fsm1367386866b.62.2025.10.07.05.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 05:11:37 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 07 Oct 2025 14:11:28 +0200
Subject: [PATCH v6 4/7] Documentation/fsck-msgids: remove duplicate msg id
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-228-reftable-introduce-consistency-checks-v6-4-638cff42f0b0@gmail.com>
References: <20251007-228-reftable-introduce-consistency-checks-v6-0-638cff42f0b0@gmail.com>
In-Reply-To: <20251007-228-reftable-introduce-consistency-checks-v6-0-638cff42f0b0@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, gitster@pobox.com, peff@peff.net, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=649; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=NrJUe2zo/755ziLfa/YcRS7uqgD2cBYrUKpni6pfRH4=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGjlA3SXobSQUeGq7Jd7aIxtEz+OFdXL++aAk
 A38aZQfW+pxJ4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJo5QN0AAoJED7VnySO
 Rox/emIL+wVreRzw45UJnSMCjDl8yZGeqouKyFQ7TS3vKQw7a/72EeiPUahVPOEU1c1GH9H98nY
 d/pWfSdTl5I7RNmcuxulWc98TClQTMzRniSeme+6t5a5b8rfnME8QIoSMYGKfnGZC/qOfz7hB3V
 qCm2eGIksK7FcBrDpx4RV2VBnUdeLFdARdAINIo2jxXJS6mZaGzOQADYuAJ0BxXVRIR+n9gB0VP
 wxYQ+C75GnC0x6zSFRtq0BepkaeYTvSWGKDkLUOWuToFDfrFOyz9G3g50AATsUOBCZB3ExCwBKB
 t5Z7W0g/mYQFGIFActpqirjyvKxA/dpiwWVTeBsPqJiIOKzjqVYP3f9feWX1NVXzSGrqWwx8C1W
 aQUbov40XPC4ZwF5oMiMcp25bEFxiUrLwgOEZ8sd6cy31U6VsaE1w/06NOiAEKpnF+oI0wErkBq
 4CV4dGljxeeoCJdeDGmUqiT8SQo+ddbWubOBCv41KEsh8VCNqyYpvj4GRtd/FmsUixKVQC2fRU4
 yI=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `gitmodulesLarge` is repeated twice. Remove the second duplicate.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/fsck-msgids.adoc | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/fsck-msgids.adoc b/Documentation/fsck-msgids.adoc
index 0ba4f9a27e..1c912615f9 100644
--- a/Documentation/fsck-msgids.adoc
+++ b/Documentation/fsck-msgids.adoc
@@ -104,9 +104,6 @@
 `gitmodulesParse`::
 	(INFO) Could not parse `.gitmodules` blob.
 
-`gitmodulesLarge`;
-	(ERROR) `.gitmodules` blob is too large to parse.
-
 `gitmodulesPath`::
 	(ERROR) `.gitmodules` path is invalid.
 

-- 
2.51.0

