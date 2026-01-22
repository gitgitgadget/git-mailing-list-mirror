Received: from sender4-pp-e109.zoho.com (sender4-pp-e109.zoho.com [136.143.188.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDB534E768
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 09:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769073729; cv=pass; b=iIWpUCuvVIW/CDpr9dCm/ZTnTnTdtRnpeNpH2XGkGIVvExKsnjWhmwr1o5xaCSta3YV6NqznnxhjMhNOq6Nmk9WvKcxXYXahH3vUMVOl22YOa15Hnym465BBO3s/7eITxBB0DCeVBF1tNV4Yzu0TezgOGePv6c1k4iVNUSA+H1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769073729; c=relaxed/simple;
	bh=ULC0IwMeUDIJfh0wdCo+w9b1sudBI2uHJA2zJ1g3APA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RsGFMv00nzsm1Niq69FdUKP++Mj2lyCAhU3I/4gacyKRBfICSe2B2qH1KkZ3lC3cbEwLb+qQY6MnYW+xxw71YaNw6IBGO08PF0jX78O2ze9PaEj+2N+OMEmc1/xDcdv7pGig3W9s5QN9EW0AFuPStAtqMAndXPW96r0EgbDBl8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=HkZ4HlLw; arc=pass smtp.client-ip=136.143.188.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="HkZ4HlLw"
ARC-Seal: i=1; a=rsa-sha256; t=1769073713; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lRTpfYRnR2lm0byj2NfREHr58ISpxczceSXSFoTAzuPGRbjwR5EpI0KSI2pcFK+Ckoijv+WAw9Vh2VlEn5uPoB7a4QMgHckGQzX7K4zRPJXNtZJ2PZQMyFYESkFm4DoOkf8cJiCgV4LrcMTw7wQcT8YW7I+Ka9KfaAznYd1NKGs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769073713; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0IjsEcC/gpIgh2Vx7HdXAP1xNEeVQX/cbXHh3PQnA44=; 
	b=UTXRtXf90EC0203UfLMKF/sryDSjepT0tdGp2MzBa0GJ7PhVpa08Fuwrao0wo8UtFdvliuTgsiECmF37vL1MnrrQC0vysLeABbw1AccUQ1IAkqmWubyqEUsEmrv81n48giI6J2gCiOF993ecYuwjvT9WwPeh9Bk9ouQzpjCAO8U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769073713;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=0IjsEcC/gpIgh2Vx7HdXAP1xNEeVQX/cbXHh3PQnA44=;
	b=HkZ4HlLw58caGO7+6ZAOThU3NPPN8b24lY7wGZTLq5Gh4tSJuqlaWvbjjay2YZVs
	Ud5MHFVs45BEMEUDV5Da2LlrWDZit5muWoo8mBtUCyO24gMGHPqwiCAMKFVT0IXhOB7
	epi2n6/J9MzLHh1uLtNgU4mYngoYZBGpW+Kl3O+I=
Received: by mx.zohomail.com with SMTPS id 1769073710126801.3696342274295;
	Thu, 22 Jan 2026 01:21:50 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Emily Shaffer
 <emilyshaffer@google.com>, Patrick Steinhardt <ps@pks.im>, Josh Steadmon
 <steadmon@google.com>, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v7 02/12] run-command: add first helper for pp child states
In-Reply-To: <xmqq7btar2n3.fsf@gitster.g>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20260121215436.1473800-1-adrian.ratiu@collabora.com>
 <20260121215436.1473800-3-adrian.ratiu@collabora.com>
 <xmqq7btar2n3.fsf@gitster.g>
Date: Thu, 22 Jan 2026 11:21:46 +0200
Message-ID: <87fr7yq9xx.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Wed, 21 Jan 2026, Junio C Hamano <gitster@pobox.com> wrote:
> Adrian Ratiu <adrian.ratiu@collabora.com> writes:
>
>> There is a recurring pattern of testing parallel process child states
>> and file descriptors to determine if a child is running, receiving any
>> input or if it's ready for cleanup.
>>
>> Name the pp_child structure and introduce a first helper to make these
>> checks more readable. Next commits will add more helpers and checks.
>
> I needed to read this three times to understand what you meant by "a
> first helper".  In the bigger picture, the helper being the first
> one you invented does not really matter.  Perhaps drop "first"?

Yes, certainly. Will fix in v8.

When I wrote this message initially, I thought we would need more
helpers, however it turns out this is the only one.
