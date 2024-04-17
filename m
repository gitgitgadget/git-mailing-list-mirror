Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860098F4A
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 21:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713388149; cv=none; b=hzedcCU1sn/FgLixTPLNsOJ8e2CcFWzbN4IPPe7SmmAfmuFUySqiPk22lZYYAD3en/wMxoDZWSHd723Jq5QT+Pf8SRX8+nBKLQRMMyuH0uq+J3g7MaoMLm4Ok3RyEi9N5/HN95wVKufdp1CRCm6tvaIGsIB8vcGjUSdEw2x4GgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713388149; c=relaxed/simple;
	bh=x0YJ1y6uw7EuaQ/8mF3jUrsOISjvpnXdmrwekjOWrjI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=AUXb3qjFfagm7jRXQwY6vmqAK36DxwRUK/dKg1EjS5jvvfk6ebPoBzCbvmLRawo4E1HNZuzkdfN+kpc3iNko731wu5PeLIQv8scD0jXyZRCjIUHwEyeX4cDWoh3iOfRQe/CUs1PN6+D1+qUGihUxmwm45LQC7JVapplN1mzGcBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=hRTxgA5r; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="hRTxgA5r"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713388143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d/UBFcegjRaD2tlnsEFr7M7FutXqUljKKMWA6Cc2flA=;
	b=hRTxgA5romWEzQ4+zr8vYRfG9PUqpThtg+j7KPvADreNYvYd8DB1aByfOJq36MsrGRNzb/
	nQTo2Uc7+Q/18/wlYcGXotSsSiMibe8TCS7NmYieJeqp8p9Qkiw36mLBdYYyW84201cfzc
	tiAOkBlPBOO2mToM/gql43GNUzjFcO7yhJ2/EagUPDORDTUvS3ZZf/hQDeWEf3+a7mi30k
	FQ/YW3rP5vJeyHu21GcXFrjGNQUIX+k9lBgmTtOJ/J3/y2KFYIndnRTb/mLAScVP00hMxO
	0LLfkxYwYWbxtUmeJXDe9nIydW2b1Fe/oiG8wr9yztzW9X2+OLFG2HMmCf+fJg==
Date: Wed, 17 Apr 2024 23:09:03 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/4] format-patch: new --resend option for adding "RESEND"
 to patch subjects
In-Reply-To: <xmqqle5b66sr.fsf@gitster.g>
References: <cover.1713324598.git.dsimic@manjaro.org>
 <1d9c6ce3df714211889453c245485d46b43edff6.1713324598.git.dsimic@manjaro.org>
 <154b085c-3e92-4eb6-b6a6-97aa02f8f07d@gmail.com>
 <xmqq7cgwau1v.fsf@gitster.g> <c2cb9268c29ae4a5cac34383b7443763@manjaro.org>
 <xmqqle5b66sr.fsf@gitster.g>
Message-ID: <19d5f3d4c99fc1da24c80ac2a9ee8bf8@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-04-17 23:03, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>> With all due respect, "--rfc=WIP" looks like a kludge, simply
>> because "--rfc" should, IIUC, be some kind of a fixed shorthand.
> 
> I wouldn't use "should" there.  In any case, we are not going to add
> unbounded number of --wip, --resend, etc., on top of what we have
> already.  Introducing --something={WIP,RESEND,RFC,HACK,...} and
> deprecating --rfc is not something I would object to, though.

Good to know, thanks.  I'll drop the patches that add "--resend"
as a new command-line option, and I'll think a bit about the solution
you described as acceptable.
