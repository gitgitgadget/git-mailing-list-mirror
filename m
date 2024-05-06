Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF89A8494
	for <git@vger.kernel.org>; Mon,  6 May 2024 18:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715021107; cv=none; b=FzpxpoPOmBrNY7vqxD3DapZsGIe2zba7+Ge+lBo9qwwJWjLctMINEr4OH8GZbYpCO2/5CS690+zmKpiaJVyljfrsinU7jxMtbAsLnt1EWiaDlFNnVUNOv3wIm+QRryOSaXfG2d0NEAPe20QlrFv/NRIhqH8T92yMosDDSUa8NMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715021107; c=relaxed/simple;
	bh=n2gg4Ur4yjUeZ5peVoqYbcdYIXleM3glJZF1xzguhlM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=fXNng3r2E+byyVQHKl3UPpKS9iBqj954AyVEMAh1vzSfunzfl+SnfO0EY32HEklm0B+MwQzgKHbSqPM/e6q4ovYZ94owuo2kw9tDWC3NJveaKdN5TxWOEvhO83UDy3PZfoM+ljy3+xk0ykDhmg7yyy/IJmCNAjMr8J20sFI03O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=NnCNocGD; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="NnCNocGD"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1715021101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f3P1LVyKOcvyBRHNVEfUAdVmjGq4ZrEz0diGKXpnXEg=;
	b=NnCNocGDZ2pcyCkgXo8gpVI1rQe1CKpAv786Pdd4Qmz/5XYmtDQDVXtJAeczwwEf0k63MC
	2xe5bpw3vkLQT/RIieGwtvrrLGJ9+I2huwNp+iF/T/Tvfb08lardXMmf4mXRl4CR4wk8/b
	AMbdZ6rrqPqgUyjiSm4lyROhoU1MK2Bm7xwtnO+62plY6PtD4Dz2WqSMYeW2WxyyBcHdeo
	EKkHQHF41J2iBnnQswc0+uw35J5GTieNfv+tZQzin5xtLum1iiOv9mgt8btTJmuFLruL4J
	6PJpWIs+4SZ/I/1mnKYmnlcoD4vkVUqCyC8q0/q27Qgs5ri8EVKM5fH13ixkxw==
Date: Mon, 06 May 2024 20:45:00 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: rsbecker@nexbridge.com
Cc: 'Junio C Hamano' <gitster@pobox.com>, 'Patrick Steinhardt' <ps@pks.im>,
 'Karthik Nayak' <karthik.188@gmail.com>, git@vger.kernel.org, 'Kristoffer
 Haugsbakk' <code@khaugsbakk.name>, 'Taylor Blau' <me@ttaylorr.com>,
 =?UTF-8?Q?=27Jean-No=C3=ABl_AVILA=27?= <jn.avila@free.fr>, 'Eric Sunshine'
 <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 07/14] builtin/config: introduce "list" subcommand
In-Reply-To: <04d001da9fe3$e9c2eef0$bd48ccd0$@nexbridge.com>
References: <cover.1709724089.git.ps@pks.im>
 <cover.1714730169.git.ps@pks.im>
 <b3f3c3ba6ab33d269f7a707eae1456c87cdfeddb.1714730170.git.ps@pks.im>
 <CAOLa=ZSNbZPByO9QyeAGaR1pWXMB7ge_GF7M5fydxP-cse-X3g@mail.gmail.com>
 <015b01da9d5b$bbe59120$33b0b360$@nexbridge.com> <xmqqjzkaanr1.fsf@gitster.g>
 <ZjiL7vu5kCVwpsLd@tanuki> <xmqqttjazwwa.fsf@gitster.g>
 <04d001da9fe3$e9c2eef0$bd48ccd0$@nexbridge.com>
Message-ID: <3d84f2eac9b03eda814332d73b5d5ba6@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-05-06 20:33, rsbecker@nexbridge.com wrote:
> On Monday, May 6, 2024 1:13 PM, Junio C Hamano wrote:
>> - Declaring that "git restore" and "git switch" were failed
>>   experiments and deprecating them.
> 
> This restore and switch have broad use in my community. I do not
> consider them failed experiments at all, but essential in scripts and
> usage. Removing these would block migration to git 3, in my view. I
> have actually been thinking about doing a YouTube video on these
> commands.

Huh, I was also really surprised to see "git switch" and "git restore"
on the planned deprecated feature list.  For example, I use "git switch"
literally all the time, and "git restore" also sees a fair amount of 
use.
Thus, I think that deprecating these two features is a really bad idea.

>> - Declaring that "git submodule" was a failed experiment and
>>   deprecating it.
> 
> This would be a very high-impact decision. Aside from my community's
> use (and my own company's dependence on submodules), this will break
> large numbers of GNU-based projects that use submodules for
> distribution, including build-aux. I would suggest staying away from
> this decision. Submodules have definite value. Please keep them.

I agree that deprecating "git submodule" isn't a good idea.
