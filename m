Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553E6212548
	for <git@vger.kernel.org>; Tue,  2 Dec 2025 10:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764672511; cv=none; b=ljkvIaYefBch31lbaYsUUU5DqrXOWjdX6Y+KloIPQ2CaeUzW5Mg3U5vwHZ9XA4Kd62y5ZBO/EVwTscR2X43LwPTuBMAIqRQnDTbmROxinRsp5f47+Dw8r50UKgTOfkGLmRjIiNhR2Dvs+U39YErfEYVuWZvsbK2mQDyePlcn7FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764672511; c=relaxed/simple;
	bh=9RfNHkG/bR8q/Rd9kG0Yo+2/61MGtiJgFUxlS0X0oFA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iWY9CS5PnMe/mbmcZVgffsGu5R7EtByQsXYAsOI/TncKbTYlAHl7bWQgJ1Fn48LMpwlFDJpdCnM+0v0RAfN9mZ2pFwjKvhq7RnGNWhmRhVz1drdLsueMV6qp80csj3ny2Yl4cND4DJVdMd8IXAo1Sf1NpS3y2fvUaYlbMJTEPqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=kMd4qk+I; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="kMd4qk+I"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1764672502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=b6crH0qTSRmNd8mCmTXZccuWhUZmu2q2xFoBgcelTKc=;
	b=kMd4qk+IaPsLifBmpILA15YB8LKBmk/uLRm7heuFJiYz2hKkE2Y5EjOwr9JThyN45H3atG
	mN3Zf4lGME8QR2dYximeyef2htj2o/iLiWpE+mctkdDwH6FZwLaYnE+fptywocGRia8w0E
	bJl5lA6cL9IlpWym0daQKc17Lf1dEe4=
From: Toon Claes <toon@iotcl.com>
Subject: [PATCH 0/2] Few fixes for cross-compiling with Meson
Date: Tue, 02 Dec 2025 11:48:07 +0100
Message-Id: <20251202-toon-cross-compile-v1-0-cabc8bce529f@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOfDLmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDIKFbkp+fp5tclF9crJucn1uQmZOqa5ZsYpKUZJlsbG6UpATUWFCUmpZ
 ZATY0Ora2FgCyRTQfZAAAAA==
X-Change-ID: 20251202-toon-cross-compile-6c44bb9c372b
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

I was cross-compiling for s390x. And while working with Meson is very
convenient, I've found these few kinks that could be worked out.

---
Toon Claes (2):
      meson: ignore subprojects/.wraplock
      meson: only detect ICONV_OMITS_BOM if possible

 meson.build            | 2 +-
 subprojects/.gitignore | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)



---
base-commit: f0ef5b6d9bcc258e4cbef93839d1b7465d5212b9
change-id: 20251202-toon-cross-compile-6c44bb9c372b

