Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F251A6803
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 15:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781797625; cv=none; b=IPSF6q7XsUbarATqEJx234yyZxURQhEAGdcVLtmQgqFQAPkvE4q3a5ly4vkCS+G3uo0m+hyiprIi7qxJjIEAFZ+k5P3fkTo2EAWOVJNUUDvBV/MVJWY3DNPZJfOs0t7EkZizbo77hhvUE+wICP4ZxNCGL04HA9JxvCDbsBfRN2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781797625; c=relaxed/simple;
	bh=9l8GcZ3OtCqW7I8OEmOUkASyo56B5CerE3fuZtzlSDs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mrxyEquxvy4awkzZjZD9GOaFeyR94M6ujvv3xWQ6kL5z8Nowj8q+zVxgQ76Re4ayrf8BATHINQAR9pCULLl0h3zSFhvh/qTAk0ffBTD9FdmOIbGOZ6PFnqD8802SG9zFNDx35/1km6lS4DCKs2TC1TeZwawXX+PkRzVoxYWnFYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dIkfva2b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b9MLsl/g; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dIkfva2b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b9MLsl/g"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7953C1400144;
	Thu, 18 Jun 2026 11:47:03 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Thu, 18 Jun 2026 11:47:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781797623; x=1781884023; bh=IQzJlxMN2J
	a6u6phzw9+7RayYfHdhzKy4LcYOMebIY8=; b=dIkfva2bKje09b21J+F94O1bj7
	AdE85eBwkE4ALX4c01fLKQjrJ80txb8StVVuEg0g23IYd+v/BVmFQEGMkzwKM+hq
	dqOR3bMy8rooEOCrTliiUIH4kzNBiPgWu5QOgQfd8TiPZBxCAfEe/9nN8Xe0c6TS
	EnVTRA4mz3EkGo/CULdbBBc+alBAZKiSpIAFe0mMHiUIGdGDuWVo8jhMy+foFE+7
	IHfr/wGd/v6FNe3Wv5oDqXIq3KEhyNa+nu/jFo1Go7W2opywHE9VVLQvDiXQOy80
	Jcuh6KJnZ4r34x+XY5b1Ma5CxsYEpSFcNrPEtUovmlrVXTLqx3+PSYTzZseg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781797623; x=1781884023; bh=IQzJlxMN2Ja6u6phzw9+7RayYfHdhzKy4Lc
	YOMebIY8=; b=b9MLsl/gY9v5fiAx72BKZML9PxfDkuw+WE6KtWyrpWGaKLKyNN6
	zCTgnfUXeO2DTSoHGyoxM6SIQrVqlLY3IxSZQ5rJr1zqwWhrGekRW0ctEYHCtzTf
	Y0SoP0D5GPQ3FXGb2sRjbf3uqbEmr4VCWNPsgbZwTF378Vt0P6FGpS9188rbUh93
	wHrZbmUxwHjss4337KcbCOiEiUWUR1BliXSGvp1mG6oT+sCntdlqBdn1vr/Y4jkg
	BhO5z9Mdg06xEzxrAzhE/tW+7RoanmHAPe9pEJMO1SH8pGXuMfuzOOyfJUrrpqBJ
	yweVwO/HR1uTFa9joid9nhpS58jMk7QMAVg==
X-ME-Sender: <xms:9xI0aqof6ASfs6hOtf6Wo5ckhnJWDuu7uLYsCkCXdg4BTxtF03YcyA>
    <xme:9xI0avgdLVvHEYUmafctGO25-FOf7ydF_j2Gniw_gNl4iqas37FpyBO-KZIbDVdY-
    REUCoZ-CnZeurvb5k5xsam6crXKPgoofpfIoYY8a-atfwAdkemf8tA>
X-ME-Received: <xmr:9xI0angl1a6gizAaUJtlDw1l_94KFSnjsJLokujoxrViWb53RLRyUxZgJKDEkaycs4F7qJMIESjuH6hiJYqnbHiQV9LsEX9TAI9f>
X-ME-Proxy-Cause: dmFkZTEBvvKqtFJ3Ua8L2mYVQB0hmp/TBg5He1/aZbpJAT2N+C+pl3CerX9hIpUK1Isaf2
    wTFp1UWuZIbgA+noQ+FPIa7fyON3qsxP02Iz/g0dO7TCGLDsl3N/VkMY9PW63Q+C6V0uQF
    8nZtbG149QSjZEyM+waTk4fEQuR8Masdsa9uyohBW/XsbKmzgPM03tL/CVJhtiZl4pHquQ
    kTQCBYhyQr8QC/OhjAXfEzdKcM7b1hEJlYycR1ezeEk42DI8kshIOQ1t40qCoLXTxFtNXl
    lvbuPEYuRIx3OyBDzb23ckpTyH2/+SCBIDw53p1wIQDcgKgtkow+JAcKmVv80acEJuI2XV
    tUMHfnXbmMZTAkIvJx4Cb0C16OrzlMaF7Gq4hRsZ8POM7fzD+24nO0kovfA3tcN+DA5qfN
    0tGV9JeaqAggCgCz0KDeLLFyoWb2C3/nwHa0w0w/Ey9k37ql7dxWY9qEoYbAg4tAaJMS69
    hmXHQV2nW+d6F4NI1JgOjwEVT/OUK2KUi/XPx6W6VuTxmW63DabC8c/hF0a+fv8s6omZ/x
    MguLs84KmpChb4tCVB8dRW/pK0H3U/lL5WoH26iPmR7DcxUU7ov3wPbBwnPXHOuB1W6L0J
    F3GGqbJvOgOAHuPXApcjjI9njZXw4IYKAwK3H0ur43Ej5QkCEZfFofaGpixA
X-ME-Proxy: <xmx:9xI0aljuqxDqG1-vg1DZMmi2sPbbDM7N3c_Vt3HBRf_aVfRRhOIaow>
    <xmx:9xI0anJIjc-bUcU9nDtDy30ULUJ3pqh5PRgNXStCxu5crRMbxqlADw>
    <xmx:9xI0akGeUvdAR9lKiGCloMHEytmXL_9YeDv7VIHPBmV2usAFSXINIg>
    <xmx:9xI0arQPgSBFekeNeJe_wKB0fHbmimdkX7Zhy-Tr4qr6CAUgtOg_3A>
    <xmx:9xI0asoW3-nbTDS2sV2nLPVrWBD73D1i-AEJWF-UrDIhlR3Prpv3n_dh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jun 2026 11:47:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Matt Hunter" <m@lfurio.us>
Cc: <git@vger.kernel.org>,  "Bence Ferdinandy" <bence@ferdinandy.com>,
  "Jeff King" <peff@peff.net>
Subject: Re: [PATCH v2 0/7] Introduce fetch.followRemoteHEAD config variable
In-Reply-To: <DJBVYP58YNTU.LQ7VXFIQE84H@lfurio.us> (Matt Hunter's message of
	"Thu, 18 Jun 2026 00:21:33 -0400")
References: <20260612055947.1499497-1-m@lfurio.us>
	<20260616222606.1003521-1-m@lfurio.us> <xmqqh5n213bw.fsf@gitster.g>
	<xmqqcxxp1j2t.fsf@gitster.g> <DJBVYP58YNTU.LQ7VXFIQE84H@lfurio.us>
Date: Thu, 18 Jun 2026 08:47:01 -0700
Message-ID: <xmqqmrwrsvey.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Matt Hunter" <m@lfurio.us> writes:

>> Other than that, this looks excellent.  Thanks.
>
> Thanks for the great feedback and consideration!
>
> If you like, I can apply the appropriate NEEDSWORK comment, possibly add
> a warning to 'fetch.followRemoteHEAD' parsing (matching the 'remote'
> side), and we can call this good to go for now.

Sounds like a plan.  Thanks.
