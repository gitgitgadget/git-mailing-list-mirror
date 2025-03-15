Received: from avasout-peh-003.plus.net (avasout-peh-003.plus.net [212.159.14.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EC32E3392
	for <git@vger.kernel.org>; Sat, 15 Mar 2025 02:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742006910; cv=none; b=Julsz96TUOi0ODURzlCRMvUNgr6hwaZ9cvfKKyzAd8yFRauRIdO11lm1DNluUjvJ2xUTAbwvxLAa1yw3ITf60WJQ5d1Uw+wGanCQvCoTjrJzBI6T5Uq3XQ6E7baAGC6etcLMDdxaggLiREWAznzbEJRf/Ig4rPEHVTXdHfgrqKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742006910; c=relaxed/simple;
	bh=/VGWRd7GxLYcAIQ9tIKiHz0eKtdVQbWvvXovB5wBGnk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=NRA7YPpp2W4CQeXftJyrtfjNKQy+wLADFRSWbBUcbUn8hXYItg+ZaBDjKfIbGt+AUXi4idbdP3dBGGi8+Ibi8XH4NoCK+oAD3odGKmXdxsQKzM5YYU6k5O+xT5lfdhvi9UOHn9UXdccNfwM9fuZbFpoGU17sVak8qZLLvHZWd5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=YL5FJYRZ; arc=none smtp.client-ip=212.159.14.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="YL5FJYRZ"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id tHZZtGMyKvxWAtHZbteQCF; Sat, 15 Mar 2025 02:48:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1742006907; bh=w+ZjwXtxmmmBBDPM76O3MtXLt9ek9EMbUNMxEWdLyww=;
	h=Date:To:Cc:From:Subject;
	b=YL5FJYRZADmV6YirwG4HbstD+FbFCinIWsQ8UUz5Do56T3vzmILaWiTE2DchYdy8Q
	 beNDkNJckBGjuHPZkt9Ngav8Zrv5ogiTxLMY4zT9if2BdfOxBSftc10Yq4Lq3vcIDF
	 xFveW3jc006ACWZ4F6YyplrrHnCLlKXy98QIKM3TdPmTMop77vdRHpwh58waRtd7nB
	 7+GPmetizI8c7TgqqaaHfcrlKHVZ2yjkUz9aEBarum80vb8+2WAemgSQUaZYt3dI6l
	 5mnwntgkf9kN1c5pAcKDAhO6ZhVDGaYhI6Fu+AkFHxc7ejV5DUWtOsY5wENOAqCbyC
	 mHTYZtsMSdHkg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=QbDFvdbv c=1 sm=1 tr=0 ts=67d4ea7b
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=eTvDwwv87Y-7DfItWLMA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <73a5aeaf-6636-4f52-a6b8-3fb1f2c53fcd@ramsayjones.plus.com>
Date: Sat, 15 Mar 2025 02:48:25 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: GIT Mailing-list <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>,
 Adam Dinwoodie <git@dinwoodie.org>
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 08/12] config.mak.uname: add clock_gettime() to the cygwin
 build
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfLFeG2j9DsfydzqsluIK7R0XiQfKkHhNpiypIfQxpnjs+3q1m4AxYcOpAs7ULXrIT4tsskMRm5b44JFpbbb7daTzjtcBGJ8upkNc7bxRalvV71wwpbPy
 1YKdhs6EL/vPfPD+kWt0zKpYijACaW7fZMD2FAa7F69Nl9gmLJ9i0gLcsbI2bNS3TK5nOt67LC2PM7m4Bgo8ap6JFTQcILvIHQc=


Cygwin supports the clock_gettime() function, along with the associated
CLOCK_MONOTONIC preprocessor symbol. The autoconf and meson builds both
enable the use of those symbols. In order to have the same configuration
for the make builds, add the HAVE_CLOCK_GETTIME and HAVE_CLOCK_MONOTONIC
build variables to the cygwin section of the config.mak.uname file.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 config.mak.uname | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/config.mak.uname b/config.mak.uname
index 1b3ba8a341..942550fb9e 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -251,6 +251,8 @@ ifeq ($(uname_O),Cygwin)
         endif
 	HAVE_DEV_TTY = YesPlease
 	HAVE_GETDELIM = YesPlease
+	HAVE_CLOCK_GETTIME=YesPlease
+	HAVE_CLOCK_MONOTONIC=YesPlease
 	HAVE_ALLOCA_H = YesPlease
 	NEEDS_LIBICONV = YesPlease
 	NO_FAST_WORKING_DIRECTORY = UnfortunatelyYes
-- 
2.49.0
