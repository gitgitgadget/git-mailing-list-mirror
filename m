Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.57
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795613055;
	b=mWXl6vqj5mpAXggPq3Wm1y+f+J4s6jobvsSR5oCefEgN5HmKpYDnO+fis3RzVRirjpRE
	 XqeAR1vVfig9i1ZqHSnr4Ok6PW7bNZa9WcbiAK+4ztO8jRKqu0uavGNUKUWYypkS8CvYu
	 282Tta5vE6s853dmZYTrPphGgPbXqDjL/PTRBLuQrbRdM+yYPCPlUTmXcGXiSDjaipRiL
	 O9RLGwzJHlKBfn1i5uyIKX5D0cEm9w6rCrWy/3Rqia00uJMuWoMrxUrtMIGf/q+SiLfEw
	 KvAa/VKKXHIp7SYVD34NEX6pKWLWRZZRqgQEKyCBujLsIdHjn2R1TsLC5xajkj0fGaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795613055;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type;
	bh=V+2NNULgUXrqJBGFS79arWpSbZBoeY6G8XGAQzaKH4w=;
	b=D9zzX5e2ih3P9L7V8WUdvlryWfWR3V6z+SOcwiyFAeM2OVdso/5N1KfXACZH/I7X0Yf4
	 HmRWxj40TMJsma+N4CUai+sDfX3+YJJq3ig/pntyq25ByyjQ+9pw++S26+UVbjMIAjfIl
	 NgjAg9a7Qt2u/gQKg3DMwMTy/PHSBV4IWPbpmWxFF380SO3iArDX/St9qJOgxmt7jYieq
	 CJnnPNDT+NC1xcga4pizGKgp4TEzqUhDpAbzzUEpELsPFl3rS8h7ljt3t9chssONHAfn1
	 R2YZ2JDZJFqLDtl5Rx+3EiTqv0F7kxzG/9AyZuentMqBKiwAjDnR8M2+oA+1aMCd+pQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iotcl.com;
	spf=fail smtp.mailfrom=iotcl.com;
	dkim=pass header.d=iotcl.com header.i=@iotcl.com header.a=rsa-sha256 header.s=key1 header.b=IOpEabtV;
	arc=none smtp.remote-ip=91.218.175.57
Received: from mta0.migadu.com (out-57.mta0.migadu.com [91.218.175.57])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D872606A689
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 13:24:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D872606A689
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iotcl.com header.i=@iotcl.com header.a=rsa-sha256 header.s=key1 header.b=IOpEabtV
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=nsxzcc41EmjlrCAKuAsyyTvQXFYbUdMvwSho0j5C2bQ=;
 c=simple/simple; d=iotcl.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795613051; v=1; x=1796217851;
 b=IOpEabtV4LeLR55/r12o2FiVYUtTkhJ/VgdpdB7P2Wl/FCIooLHr9v5qKfeB6gSGmjK2PEab
 ZfB2HNKyFMzduo3Vtc48I1Jk6p5hlxWugg34LLAclfW6EL5YWNLuDLt9iXmHFOSFHq58mzaSfIy
 fQKm0n+jfnUXYGoSAwbquFpM=
X-Envelope-To: git@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 524d9514612be94f;
	Wed, 25 Nov 2026 13:24:10 +0000
X-Mizu-Trace-ID: 524d9514612be94f
X-Migadu-Flow: FLOW_OUT
From: Toon Claes <toon@iotcl.com>
To: Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Johannes Schindelin
 <Johannes.Schindelin@gmx.de>, Jeff King <peff@peff.net>, Elia Pinto
 <gitter.spiros@gmail.com>, Karthik Nayak <karthik.188@gmail.com>, Junio C
 Hamano <gitster@pobox.com>, Shuqi Liang <cheskaqiqi@gmail.com>
Subject: Re: [PATCH v3 3/4] convert: use size_t for buffer sizes
In-Reply-To: <1617177880b7cbde051bc4295f1fbd6ea2be457b.1793439137.git.gitter.spiros@gmail.com>
References: <cover.1793352943.git.gitter.spiros@gmail.com>
 <cover.1793439137.git.gitter.spiros@gmail.com>
 <1617177880b7cbde051bc4295f1fbd6ea2be457b.1793439137.git.gitter.spiros@gmail.com>
Date: Wed, 25 Nov 2026 14:24:06 +0100
Message-ID: <87qzg9rqmh.fsf@dev.null.iotcl.com.invalid>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Elia Pinto <gitter.spiros@gmail.com> writes:

> Use size_t for all of them.

I checked that read_blob_data_from_index() has no other callers than
the three converted here, and that read_attr_from_buf() already takes
a size_t. With Christian's wording tweak, this one looks good to me.

-- 
Laters,
Toon
