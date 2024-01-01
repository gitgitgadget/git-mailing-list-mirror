Received: from dd36226.kasserver.com (dd36226.kasserver.com [85.13.153.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E90120E8
	for <git@vger.kernel.org>; Mon,  1 Jan 2024 11:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=haller-berlin.de header.i=@haller-berlin.de header.b="hCoaQVjU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=haller-berlin.de;
	s=kas202308231025; t=1704108641;
	bh=Hy+rO+C+nx+roR1b/x0wKRJ+shU5LafF9fzwoT5UqT8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hCoaQVjURaBIimigl9bNOvIr7xDRXsiEUqDM0KcaU4oP2gNxgYwKbDbfBAH4m3un3
	 B1SZJPRdP9CCt9aYlPCH7Z8drwhNIbLq201XEfGjNvveJ9JnRlqG6qjvAptG1ybSjp
	 Zp6NowTlGLEJwg/dnI9v6gGLIBXkFbt99awnrztBiEXNo1+NH2VRZ7vj4OtFbL5N4/
	 p/x0oVH/A53oi9jCJFkNoqUkOceGSnl/9MK8z5/BZP/sGBjXgMPQWnjWc5QEvzkq86
	 1gR81c+EM2JV6K/q0E8gRrOWO5fkcWw+Bnw71V1kng6IPaROHj23lS/j8W1XI8s30S
	 nTZo4fNdG4UTA==
Received: from [192.168.42.22] (195-97-142-46.pool.kielnet.net [46.142.97.195])
	by dd36226.kasserver.com (Postfix) with ESMTPSA id 01B0D3C030C;
	Mon,  1 Jan 2024 12:30:40 +0100 (CET)
Message-ID: <9b5ff583-f8b9-42dd-8829-2fea74bc2057@haller-berlin.de>
Date: Mon, 1 Jan 2024 12:30:40 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Concurrent fetch commands
Content-Language: de-DE, en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <c11ca0b3-aaf4-4a8d-80a1-3832954aa7aa@haller-berlin.de>
 <xmqqy1daffk8.fsf@gitster.g>
From: Stefan Haller <lists@haller-berlin.de>
In-Reply-To: <xmqqy1daffk8.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: /

On 31.12.23 18:27, Junio C Hamano wrote:
> How this _ought_ to work is
> 
>    ... it should notice and
>    barf, saying "fatal: a 'git fetch' is already working" or
>    something.

Interesting, I had expected this to work somehow, e.g. by sequencing the
operations or whatever is necessary to make it work. Fixing the bug like
you suggest actually makes very little difference in practice, it just
gives a slightly less confusing error message.

> but it is a crime to run them without the "--no-fetch-head" option.

Ouch, I wasn't aware we are committing crimes. We'll accept the
punishment. :-)

But it does sound like --no-write-fetch-head will solve our problem,
thanks!

-Stefan
