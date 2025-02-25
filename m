Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA30266EF4
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 12:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740488014; cv=none; b=oV0xfANfHczUqJEoxWiVLllduLkxM3sTi2DjTqrBtIn/VcjSnyt/06Xje4GGio8wViXhdoqFIvcl/TT3sXryMBHw6SAx9QtbAFsLWfNt57WiYrCt0abrDhew3/C5XfWenvUSrEfyKbmuVQyCwTg7nuLp/U1TbZ+0z/ut2el4x0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740488014; c=relaxed/simple;
	bh=6w3VGmCi403XYusU3ObMucQAGvJEORTd9az5al0pYU0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FfwjWjt0Q526NAPN17BVF+RokOlEt2ZAFVkjmQ29xyUZ0AUVwxUUaZh0dzA/6h2SL/vz3jJ9rNcvf8XmV9zsLXgpLLzkggQqvnILi18GOKYcRf5OjCYKvaJLsXzXsCePVJ0axutw+gWLfxlTMDCALSv5EM1+kgs8uQbyG0cGpiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=V00+gmpa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F6bj3ZyT; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="V00+gmpa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F6bj3ZyT"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BE05F25400A5;
	Tue, 25 Feb 2025 07:53:30 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Tue, 25 Feb 2025 07:53:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740488010; x=1740574410; bh=0jTp+AGI0j
	aEiyjTPy2PH/aCF6zmDfdvKmnXb4KElX4=; b=V00+gmpaQSxjfJlASehO1mtq20
	EBwrKR6O3Y9YEce/JD2hFoovpfh1ctilkqPhDWZx2JBO5tI+BVCo+N/mLi7QUJA+
	rjBktwlESNZdopW9UUc36REs8MIFCf85QtWQTEYKIT1U7N3U97EEkWF6bivmpftk
	xjd749hj6uKXruytbObmE68j8fXkbUHQxRtXBiVOn8TPelLCVrRnPM5XKvR3yLXI
	LODpDD06rjAODoh+Pag7PHchwj1Nc5Pe6hkuZkD1IajVXQoc5RyV0HtSPxM9jMuG
	w4faOB6+5nJvVxgLdWl9lgyQl6t4zKSEcA4O9IeAtcE2DEOns2WM+5T85alA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740488010; x=1740574410; bh=0jTp+AGI0jaEiyjTPy2PH/aCF6zmDfdvKmn
	Xb4KElX4=; b=F6bj3ZyTL1hVyou3Q/XAWFkkfePnRt6GzvOSX2bdp2YptIQb4VJ
	5Z4GMVW24ygdpwHV9pXHni0H9PcwWn3yG+pwJ0ol3wBaEoUh4jWKcK3qNnvfpI0V
	rniHhl/03i3oPKYWW8Wt0K/zelUtJDlzlFZgYOJimFj+rznybOWBnOrQOuFQArIP
	w/WrGUPHcLaGL/NzK4okBx2y2LJrynZ5a3SL7vlXcpYWUN8SvA1QPfIJ4bCifSCE
	y59MXesUxD2/HTYxvRvMyjG02sytN9P7c2X1IiMToKpypLilOctlOcajzhskuHsm
	bo/i3Si0cTVO0LjNVIX+PqJDvvbQexnJweQ==
X-ME-Sender: <xms:Sr29ZyB1fO7Pk8NPB7fqe2rPebVoatIn2oQtGE-dbe-6rscQJ7WFEQ>
    <xme:Sr29Z8i6rl1vfk9E3AcXiRYZWHEgSeK-NfLm4OUcMFjjRS9I9t6U6o2_JWufGe061
    LZyPiNV130HnnTccg>
X-ME-Received: <xmr:Sr29Z1mP9XZVpWnvEUIaw6zWpKhIYbaD2awt-PKDy1riY_clBoxqKPyYs2b7eX8wSwG6TUpTtFPJ8tM3qx1UQfQpgwD8zue-TT8g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekudejhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenogfuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughr
    pefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevuc
    fjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgv
    rhhnpeegueehleevveelffekgeehvdfhveefkeduudejheehgeekteeuteeufefgudehfe
    enucffohhmrghinhepghhithhhuhgsrdhiohenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjvghllhih
    rdiihhgrohdrgedvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Sr29ZwxrR97xDtJm0xBpmW8CnpGzhBYjWi_BqJkZJUkAa6Z5tWd6iw>
    <xmx:Sr29Z3Qg6SHX_zw7rJadDxe2phzAdHVfVeG8c23m5UvhelpxTGShsQ>
    <xmx:Sr29Z7alQecJq8BKYqZSkfMq3sf2QyjANmhByoMMqYj37143BL-4Sw>
    <xmx:Sr29ZwSkOnxYYmoAsHrxvV0Xs9sLs06uhd2YKJEslHCGlejXbGRRqQ>
    <xmx:Sr29Z2FicUS8jnK5GaTUUjpxiH6ePd5q9Dat51i4AMu4HyLd-Tdayt4I>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Feb 2025 07:53:30 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Zejun Zhao <jelly.zhao.42@gmail.com>
Cc: git@vger.kernel.org,  karthik.188@gmail.com,  newren@gmail.com,  ps@pks.im
Subject: Re: [GSOC][PATCH] apply: address -Wsign-comparison warnings
In-Reply-To: <20250225032444.9901-1-jelly.zhao.42@gmail.com> (Zejun Zhao's
	message of "Tue, 25 Feb 2025 03:24:44 +0000")
References: <xmqqv7sz76zl.fsf@gitster.g>
	<20250225032444.9901-1-jelly.zhao.42@gmail.com>
Date: Tue, 25 Feb 2025 04:53:28 -0800
Message-ID: <xmqqseo2kwxj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Zejun Zhao <jelly.zhao.42@gmail.com> writes:

> Thank you for explaining. I'll separate the desired changes from this patch to 
> another since the topic will be different.
>
> By the way, should we remove the idea from the microproject list now that we 
> may not want it?

It is not like we do not want it, I think.

If you read https://git.github.io/SoC-2025-Microprojects/ (the first
entry) carefully, it does not say "find anything that -Wsign-compare
warns about and squelch the warning by using widest type common
among the quantities involved in the expression the compiler warns
about" at all.  Most specifically, it does *not* tell you to achieve
it "by using widest type".  You would squelch the warning using the
most appropriate type, which may not be the widest one.  In the case
we discussed in this thread, it was line number whose type was the
platform natural integer, but mixed up with other size_t things that
caused the compiler warning.  Blindly using size_t to squelch it may
not be what we want, but that does not mean we do not want to
squelch it by doing something else (like, by not bringing "size_t"
quantity into the picture).
