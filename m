Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FF1BE6C
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 17:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712423340; cv=none; b=RrbQk0RJM2y9WDmszuFiyuVdCa2kZY3rnkwl8SXoNV07BWF46kGTsvkhIUOtWU/kBaen3PRMAR/Sg8Nl/yKjoOihp7tjl0RPr7NH/V/e4wzXH0byxLb3vM9KOrS2rhNze07+7loll5zUH2WQL6b8Q2lF4mh1mC1FxxpLO5UX9+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712423340; c=relaxed/simple;
	bh=MKexqY+3+CBUjF9yIV1Uy1lFHRyz9xqovLhrNbONGsk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=CGAOwh/xB9xLqlJX+HAIR09Wu1gZiR8gE9SEZTChu4+tFMDxSpGu17cNHyfjbS2l/kAfjpowPn4h4RLFCaE31MpfNlsboFn1Mis3Qfs+ZOvEymxihsLm1o/RT06LqiBa0y6Pxs4zsHK8QxvZFumHBnolHCHmNxzLfpgxNnZ4dZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=xfLFCZN1; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="xfLFCZN1"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1712423336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QbkgA4fW3itToPZtxupFz3/jTSRS1X5bzxVcy3Ywzuc=;
	b=xfLFCZN17JQMXbXl09LS/93Br6fychdVuCMyKyNYQtt7BbyIPg8EGpH1lU3JGTjEdWMMwk
	edU06QB8M0LsaNPJuV28cjsaWha+ep8stZd+bthd3+EYchCVPBfTrtH7HZg0eo4abQ6SmC
	2hl+liQMndun4oR/IDhrdADGYvvHpgOA5jLPh0/lgN6Lc8XLN9D2PgH3tiyEVJq12hCnxv
	qDB+VAslFjBOwJD6d22ZvKQS95OkJhjnMhki+kdyfRiyeLnJCoWenjcoF8G87ZBhkdaiSi
	G8krulBMM9c+uDMC1WQD/vJBuxrV+YW2edQDdGQjW8rLpy3o4KO87UyUzp/OOQ==
Date: Sat, 06 Apr 2024 19:08:55 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, code@khaugsbakk.name
Subject: Re: [PATCH v4] send-email: make it easy to discern the messages for
 each patch
In-Reply-To: <xmqq5xwul8vn.fsf@gitster.g>
References: <8a9f4927aab96f2f62e2467e59fb6150d7e931fc.1712367983.git.dsimic@manjaro.org>
 <xmqqwmpbm4lp.fsf@gitster.g> <xmqq5xwul8vn.fsf@gitster.g>
Message-ID: <6cd48321180195e7070825dbc3f49578@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-04-06 19:05, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> The whole thing deserves to be a three-patch series, the first one
>> being a preliminarly "let's move the final newline out of the
>> translatable string" step, followed by "let's have a gap between
>> output for each patch sent out".  Perhaps another "even during
>> sending a single patch, we may want extra blank lines when use of
>> editor and other user interation is involved" patch on top.
> 
> Or the latter two could be done in a single patch.  I'll have to
> re-review the thing (if I were the only reviewer of the topic) so
> doing so would delay the completion of the topic, though.

Huh, I've already separated this patch into three patches, and IMHO
they look nice and make everything less error prone.  Would you agree
with the three-patch approach, please?
