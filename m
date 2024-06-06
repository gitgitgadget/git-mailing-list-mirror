Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62BC1BDEF
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 07:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717658627; cv=none; b=TTaZXgMenAZJLds0HjRdj0zwggXf0v3q0jeWsn3tU9jNaXrn+ZgB2rcdZZdp+qLJdO/5bra4NW6gq7RdidY07ymdZCk87jfjvZ+mOQ+SgsHMzyJGe0YnoHyQImIirurN8spggINuTV8n6tzm6eqlvTusw4swvRoMciHBFbeR1vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717658627; c=relaxed/simple;
	bh=hHF0+bNRmg1uZkC2+gjlT7qbKxznC1QLvJ0iNfglJoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fVOzvAkHUNq7A1y4WpsjLu1NOJLen+WsKQgS6gQbuAb6DNzF42uuddEC8V34xnGaP/ALLFX0aXJKsaDH21fVvFRiIiftChDUkvGb8/Jv5K3jN5enydOn1zri1r4l0oYdOzRHQcW6tiI80pdvWfh2aqtGs0Id/NyI0bcZZdpRLjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp3.bon.at (unknown [192.168.181.107])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4VvvnW6yhhz5vZ4
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 08:39:27 +0200 (CEST)
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4VvvnL12QlzRnmT;
	Thu,  6 Jun 2024 08:39:18 +0200 (CEST)
Message-ID: <1c055e96-76b0-4174-a8e2-cb6df041fabf@kdbg.org>
Date: Thu, 6 Jun 2024 08:39:17 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] diff: let external diffs report that changes are
 uninteresting
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: Junio C Hamano <gitster@pobox.com>,
 German Lashevich <german.lashevich@gmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
References: <CACDhgro3KXD0O9ZdE1q46jmXE0O=vf-Z+ZX50WMqmRHAeowGAA@mail.gmail.com>
 <82561c70-ec33-41bf-b036-52310ffc1926@web.de>
 <e2e4a4e9-55db-403c-902d-fd8af3aea05c@web.de>
 <6fa51a62-5dc1-4865-9f79-eaf7d65189ab@web.de>
 <99a99e5c-4fe4-413a-9281-363e280716b8@web.de>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <99a99e5c-4fe4-413a-9281-363e280716b8@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 05.06.24 um 10:38 schrieb René Scharfe:
> +diff.trustExitCode::
> +	If this boolean value is set to true then the `diff.external`
> +	command is expected to return exit code 1 if it finds
> +	significant changes and 0 if it doesn't, like diff(1).  If it's
> +	false then the `diff.external` command is expected to always
> +	return exit code 0.  Defaults to false.

I find this somewhat unclear. What are the consequences when this value
is set to false, but the command exits with code other than 0? Is it

    If it's false then any exit code other than 0 of the `diff.external`
    command is treated as an error.

-- Hannes

