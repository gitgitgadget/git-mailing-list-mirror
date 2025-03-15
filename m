Received: from avasout-peh-003.plus.net (avasout-peh-003.plus.net [212.159.14.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110892EB1D
	for <git@vger.kernel.org>; Sat, 15 Mar 2025 02:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742006872; cv=none; b=cgP4tcO6k/bUzinOoSiqtkJm2+DX6UC4f6bBOT7MtIwoLKdRBRGgqF98Xb3hb/vE7RYtMwxgh/EdK0cGBcgrxQs8gzLbjKhD9JDVPAxpqeJH3v+uycBeDrzdt1nc5gseZV2StK5KxsL7ilYh5el6TZQpWh69m/+MZ1zgS4yx8po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742006872; c=relaxed/simple;
	bh=n5pszrZJLmuFE6ReA219ojxPxVsq4Bi6hYP8rvl07ws=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=O3LG+geE+SANnWTv07NpZaTFkwyC4Doda6XOnsLj7D6UvmFztJzrHhgqLjfdhz7IwmylJlwYIrNmrzp+M7+8l1dagf9S9OGVM8z4wyJCQdU6nMwa7qaWsj8bZJhiVzp3Xbvpv0xRtM4JakJ01OU+Xee+DnFXt+S0OTZc2HjUSD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=nEwrJkVx; arc=none smtp.client-ip=212.159.14.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="nEwrJkVx"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id tHYvtGMuevxWAtHYwteQC0; Sat, 15 Mar 2025 02:47:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1742006866; bh=7Ip2jX5ojmIyIRj1sjKJXheJqs0bI/Ab4S1YGMLyXw0=;
	h=Date:To:Cc:From:Subject;
	b=nEwrJkVxNzjoxUl5d+ACwHbJnRjkNiamnyWxPnB/SXlJsnwkIO3+1WQQ6EH5FuyDy
	 LqLBPpVvEjfw1Ex/kXaKGfK5Ke7akKX9sZURZcHUvdO+zzwMvOvW/QAnzFztfeB4cN
	 LGd2J2bagJzzI+mprzFCipF5RI60H2jhIrV4K02zEKFqZaUUSZy2kaS7UKIPhaGR4m
	 I9bNZ4082g4jg8X2MRcHOhg3yRLVUZwDPUi4MpGIlQ5/kXsvKMUImpOTNm7b0yG2l9
	 JLVyuixeKA/v/c3QKJAR2N9716GJC0wIpAc8yTHWuJl/7gRUrH6DuIXPsh6gsKxvpa
	 sAcRJesyJd6Bg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=QbDFvdbv c=1 sm=1 tr=0 ts=67d4ea52
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=-MV70WsdUszZJaylRL4A:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <a4272c4a-7073-4671-a883-50e9413b0384@ramsayjones.plus.com>
Date: Sat, 15 Mar 2025 02:47:44 +0000
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
Subject: [PATCH 06/12] config.mak.uname: only set NO_REGEX on cygwin for v1.7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfBxUBVwGjxqdGaAJjrAJfpyhlFmpfIWdZyQHvlgzo/nGqeNjMZ4EvUtO/ZBNJqG4y3bnZ5O5s+zdSQvQeEWgRbw7l8/as8/Ki94lCDfDrI2sfWVZfjTE
 kFLujacQ3P9ppwacy2K8Bywocdn6QQdUyFRLgV5q/Lmd/5xLMjs3lZA8V3Z9lVVBFME7fQWZpLV3VlMmvh+H1Kw6lFKXeMXKBNk=


Commit 92f63d2b05 ("Cygwin 1.7 needs compat/regex", 2013-07-19) set
the NO_REGEX build variable because the platform regex library failed
some of the tests (t4018 and t4034), which passed just fine with the
compat library.

After some time (may a year or two), the platform library had been
updated (with an import from FreeBSD, I believe) and now passed the full
test-suite. This would be about the time of the v1.7 -> v2.0 transition
in 2015. I had a patch ready to send, but just didn't get around to
submitting it to the list. At some point in the interim, the official
cygwin git package used the autoconf build system, which sets the
NO_REGEX variable to use the platform regex library functions. The new
meson build system does likewise.

In order to produce the same NO_REGEX configuration from autoconf, meson
and make, modify config.mak.uname to only set NO_REGEX for cygwin v1.7.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 config.mak.uname | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/config.mak.uname b/config.mak.uname
index ae6ba15586..b6adce0bc4 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -245,7 +245,9 @@ ifeq ($(uname_O),Cygwin)
 		# Try commenting this out if you suspect MMAP is more efficient
 		NO_MMAP = YesPlease
         else
-		NO_REGEX = UnfortunatelyYes
+                ifeq ($(shell expr "$(uname_R)" : '1\.7\.'),4)
+		        NO_REGEX = UnfortunatelyYes
+                endif
         endif
 	HAVE_DEV_TTY = YesPlease
 	HAVE_ALLOCA_H = YesPlease
-- 
2.49.0
