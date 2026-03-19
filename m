Received: from avasout-peh-004.plus.net (avasout-peh-004.plus.net [212.159.14.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2813603F1
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 22:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773960740; cv=none; b=Ru63itYjKrobB52rLfjhvUgSduOVJrMJf6Vvn3Bf914+lsIhbQzTSVndGuDRHFb+pfuzhDp3zoFmEj2YXCAThJ1NVAod9n6hjFn+HF5WH8uzRzOXbSC4kKhFdhbPe5Rjz3OYujGp1LQCFMxsg7WVEvvN43kxHw2UQ0mzDYbM4KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773960740; c=relaxed/simple;
	bh=QB32e0LdK9NMorMHiwSgtukDeaK0qoDN7AWD3AFVmXg=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=U0pBGbiooMtCbCKtausU9j6Ls6SgctyGl2p1XXwkTjYICHuT+l2PNeVsrxC7ta31ERfrATxw6h171MPzMrIzVGfeY3IreyfY2bdno262mBSreBd+l6Eio3Gwuu4TJoNrFqf2OXZ79117/FR3RWlhNPBkNR+3mrmd4WNaXQ6qzlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=pKz4eT9j; arc=none smtp.client-ip=212.159.14.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="pKz4eT9j"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id 3MAswBq6S9Rfh3MAtwZSBC; Thu, 19 Mar 2026 22:49:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1773960548; bh=1eDUxRRMU5DC4wNrV6VWKjWRlVFbp3YHoxBE9USTt5A=;
	h=Date:To:Cc:From:Subject;
	b=pKz4eT9j8aaMrRIL/vXeUTue4rQw/2TMIeI66+TpsmNV3Mv6tPmFODHCeLqIfgq0v
	 Ri7s83kpLPqYCmapbOsECa3FMoCYStTNve+TNJ7EbGfOG9ueDpPUSItBN7vBCOZnAP
	 L+8V9Gh459k9QTS+nWPruT4ew4EAPDpId3zbK4LiCrLoLhQNsOkIxbWaCGkhXsarZ6
	 HgXP3xUQ7Jj6ptb875iFwfBoyXWLaFn32ggACnU7l9kmfidbw2M6iBc6moPkUhhxNl
	 gO4kOU7nj0m/43D7OdI7nD7FDaLVxskDXRB/C25zEW+a2VrX36gcSE8Z2NXCOtlBpG
	 +F/EvYX3TRshg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=S5R6w5sP c=1 sm=1 tr=0 ts=69bc7d64
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=2YfQnYkBRGfBZRT2O0wA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <97c623fe-4e03-4fbe-a6af-9c01c101bae4@ramsayjones.plus.com>
Date: Thu, 19 Mar 2026 22:49:06 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Patrick Steinhardt <ps@pks.im>
Cc: GIT Mailing-list <git@vger.kernel.org>
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Subject: [PATCH] object-file: fix sparse 'plain integer as NULL
 pointer' error
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfKbQNZ9SZxaFtdrlnIO8mokwrUd/uIs/17dRJHavalt+MnZqbKSnsw0eBOADsxiu9cbGHRnrNW/NnJ4XfbySsvkXUjxsFLWbnGmCxC+uUgCBFjWpsRLv
 BlNKh74s4ANSGp+U0hrrqrCMpS0qgALS607bgZ6Y0e1NeS3sUuHP06TG94CZS9aMcTGbFfLSNrnS7LDRqtox8M+ZnxGwh8/lsyc=


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Patrick,

When you next re-roll your 'ps/object-counting' branch, could you please squash this
into the patch equivalent to the commit 2b24db1110 ("object-file: generalize counting
objects",2026-03-12) in tonight's 'seen' branch.

Thanks,

ATB,
Ramsay Jones


 object-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/object-file.c b/object-file.c
index 35be7e58cb..3708b8f18d 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1941,7 +1941,7 @@ int odb_source_loose_count_objects(struct odb_source *source,
 	} else {
 		*out = 0;
 		ret = odb_source_loose_for_each_object(source, NULL, count_loose_object,
-						       out, 0);
+						       out, NULL);
 	}
 
 out:
-- 
2.53.0
