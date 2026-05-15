Received: from 19.mo582.mail-out.ovh.net (19.mo582.mail-out.ovh.net [188.165.56.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B793AC0F1
	for <git@vger.kernel.org>; Fri, 15 May 2026 08:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.56.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778832428; cv=none; b=XEoRYNdmC4eX8Y5cUBKWXDPyuqUIJkTj9jLlYV7h1qXcJiBRNQWabTVeiI9O15aMFLEjZMSuWqvWx8Cc5dllP/K6ZPAJpdMyRNjCpgvYCYAUkG5MKFg8k9Vay7Cc1r2LEXVu2iytmcv5x2iSpv4ndbgWuceeCtjgEeRBdohqVRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778832428; c=relaxed/simple;
	bh=3Yw5ZmKPpbl1QOb/P8J9VOzig0cjxTYwGI5GJ+mSeQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e0S6Lgoa1Joth+7qBsXe4ks7LFroCwqqO4uByyrsBt7Tl2WSI7nfppj+YG3KAVKTglug8Ow+nRRB0imRv6mOxvDQy2jTpSpRmqEcYJJVz2bbpNYLhxgpDs1fAfCxmQafQD9mo0/G20Gf4UTjQEVUPobJKsLowTKDK5+UnsmuC7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schlaraffenlan.de; spf=pass smtp.mailfrom=schlaraffenlan.de; arc=none smtp.client-ip=188.165.56.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schlaraffenlan.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schlaraffenlan.de
Received: from director5.ghost.mail-out.ovh.net (unknown [10.109.231.137])
	by mo582.mail-out.ovh.net (Postfix) with ESMTP id 4gH0Cq1zFYz6V87
	for <git@vger.kernel.org>; Fri, 15 May 2026 08:07:03 +0000 (UTC)
Received: from ghost-submission-7d8d68f679-5kd7c (unknown [10.110.168.168])
	by director5.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 9F1291001E8;
	Fri, 15 May 2026 08:07:02 +0000 (UTC)
Received: from schlaraffenlan.de ([37.59.142.110])
	by ghost-submission-7d8d68f679-5kd7c with ESMTPSA
	id fuppGybUBmo1AgIASZLh6Q
	(envelope-from <kernel@schlaraffenlan.de>); Fri, 15 May 2026 08:07:02 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-110S004e5c8f898-f44a-4e29-afff-1c66d94ecb33,
                    57998E88DD9B97C8C3149A8E9CD5E39ED8EFA964) smtp.auth=mail@schlaraffenlan.de
X-OVh-ClientIp:95.90.63.4
Message-ID: <074d95ed-001d-4d8d-b899-b3fd172185fd@schlaraffenlan.de>
Date: Fri, 15 May 2026 10:07:01 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] Avoid hardcoded "good"/"bad" bisect terms
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Chris Down <chris@chrisdown.name>,
 Jeff King <peff@peff.net>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20260514-bisect-terms-v4-0-b3e3cf1b06ce@schlaraffenlan.de>
 <xmqqv7cpepec.fsf@gitster.g>
Content-Language: en-US
From: Jonas Rebmann <kernel@schlaraffenlan.de>
In-Reply-To: <xmqqv7cpepec.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 15287187461219189727
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEznMJpbcWAibM765yc2zo3E4XhQtR/XxpHOJJwXzAba6XzxRiK46fe7+g0myWxve8MaBzh9hgE2fn7f616lW21YdXEW5OqhwyRKWmtpmJ2TZFYMdvLcxv3mkuEL2lMhygOCrrXCoFsYRDCljH9wVV8wFB5PXt8REEcg928jWZRj5Qn5hSkfpbyPFSmo+R1vKDErm6Zl6Q0SKZn4G+m37su+K7eiQMbwlU/W5mrwx9Jtwd5Ak5qi/oDKwZtfef//dH7P+qwgRZs1D+3nv6kDInnObyGf7c6K5VqDMc1cNb2mw3iiK52sPWgxPB1nLkUOX/wprgE7VXEZUgvBNSXDxuek5l7KJvKwPOPR6F1AcCXpH2b5Tao4af9C+w3NHSJNb61wCxQJOYpDi92TuIg0tEBpz3DOAC0+wyTqbo84fz6aGvoCBAo4S9AwiEpqtiEzXA+ilGn8L+BdL5UVjTIarwHNQsYYK9Af4eWoMdS9DNfNoEcQf0TePX4maXNIsb6YIQsPZV7/9zhrtq5TC2sGnzA3GoWColjLehExAGAUJ9nxVspGkYTPDxp/84EfXG9933omJ2wctwPD3fbs5W+SGqq2xbSY08EQUvyDdotcQbIH59NVrbXvtj6HU/CpI+4WhS9rzEt/a6FoXfwqtsgnBVWeauQ+UgiYCYDvWWorb4oxw

On 14/05/2026 21.56, Junio C Hamano wrote:
> Please make sure that your cover letter of the (i+1)th iteration
> [v(i+1) 0/N] is a reply to the cover letter of the i-th iteration
> [v(i) 0/M].  With that, anybody who has the i-th iteration can
> [...]

Thanks, I never knew! I've now set

   git config b4.send-same-thread yes

so b4 will send future rerolls In-Reply-To the cover of the
previous version.

Regards,
Jonas
