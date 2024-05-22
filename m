Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B2313FF9
	for <git@vger.kernel.org>; Wed, 22 May 2024 20:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716410734; cv=none; b=oKwJBhxxkGUU1mxZrKCrWlESeM6ObB74JCb9gb2y56E9URbs3RdLoy5rocu8ZPWrCBPEAAfkZEDpAm5rEJWl0qzkxvzvK9/CXvggdpWhEUm0OX3h9dYeGl7mSjiOSehRW7DI3eu85zKZ0Ce+4rfKmudk1nBINg4rL7klCMR2IF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716410734; c=relaxed/simple;
	bh=+g01Rvj7+Uy0A/kq4hHufkWbQUwNmuNJlBa/nTDz5eY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qZkBiAoRecMFR8JOW5pAM5G7lS+4UsrLxpP2SCSFKMwYwo7Vk7tKyXOMgEhhkb/vf7iRbG2iJLH5BxWS45qnizedif0W9HK+VEM+wvP3BM1c06b+KNitzQQj1psFGOKABaYADyeBpmlTslHBRvEJcqF2EiKwM2SFTLAK8CHvlbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ebI7cHh0; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ebI7cHh0"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D6B712B0B4;
	Wed, 22 May 2024 16:45:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=+g01Rvj7+Uy0A/kq4hHufkWbQUwNmuNJlBa/nT
	Dz5eY=; b=ebI7cHh00fFPBvTUUJDej5rTdXieNEcdfmaBXzDRyeuVwxP3UDMzNN
	RACbjHG6vS+6YTQ7S/9kgYSeoTg/T3u66MozP4s9amyxpoo/aU9pUqxY1jtbPcGh
	9jcwQjpyHPBNfcxpxFYdf/qGmLPz9t/SEaWX4jdWtLUEudTSRuhd0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CE4002B0B3;
	Wed, 22 May 2024 16:45:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3CB8A2B0B2;
	Wed, 22 May 2024 16:45:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] doc: note that interactive.singleKey is disabled by
 default
In-Reply-To: <54c318f42ce63f0575ea48f3dc1e8361@manjaro.org> (Dragan Simic's
	message of "Wed, 22 May 2024 20:52:43 +0200")
References: <3141fe9f7328a97bf3818748421f6ae929120626.1716363167.git.dsimic@manjaro.org>
	<xmqq34q966qq.fsf@gitster.g>
	<54c318f42ce63f0575ea48f3dc1e8361@manjaro.org>
Date: Wed, 22 May 2024 13:45:30 -0700
Message-ID: <xmqqttip379x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3AC2CC42-187C-11EF-8CC8-25B3960A682E-77302942!pb-smtp2.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

>   interactive.singleKey
>      If true, allow the user to provide one-letter input with a
>      single key (i.e., without hitting Enter key) in interactive
>      commands.
>      [...]
>
> Thoughts?  It would be more consistent and a bit more clear, without
> putting too much stress on the actual default value.

"When set to true" or "when configured to true" is much better than
"defaults to true".

I am ambivalent about "If true", though.  It still leaves it open
for some mysterious "default" mechanism giving the value true
without user doing anything explicitly.

