Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch [83.166.143.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F2B71733
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 21:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712266684; cv=none; b=afYe1T25uKDME1ipQeWARcBMzls1SIAYj+n7ppRLOQpZXhH48z7X4K7vDdkHu+VXr/z/zpVnhnKYSgSLgIWO9YNXPO1WdJC+7EGFmbFDDnw4Lsm3WZVuuP2ZrUj0TyAKZHReS/oLxDfXGsdjbcCOlkS4dA0pSEr9/acv5hY+BD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712266684; c=relaxed/simple;
	bh=ImlHVbEcu2+DaRMdppBxCCHS8unO2qIpsg64Iz82xMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ez+wtk0iLe7Qmw+2edDDGqOa/pxGsR2SQhMSpe7EYIlvat00hJ3NZP9JsXVvihdMpAYS3RoJX4YoluJIMxXcCiFI2T3nYUH3KnUNAjje31jAiS0HEUNyjIoUOq6zns91Lbq39Q22PUBjIwsUNkceHKKwN2O7fJvezmvjcPcB8Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=badez.eu; spf=pass smtp.mailfrom=badez.eu; dkim=pass (2048-bit key) header.d=badez.eu header.i=@badez.eu header.b=nTHFWL07; arc=none smtp.client-ip=83.166.143.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=badez.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=badez.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=badez.eu header.i=@badez.eu header.b="nTHFWL07"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4V9ZjH01Wtzj85;
	Thu,  4 Apr 2024 23:37:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=badez.eu; s=20230704;
	t=1712266674; bh=ImlHVbEcu2+DaRMdppBxCCHS8unO2qIpsg64Iz82xMY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nTHFWL071sPkDqWzQNDZfqTlBGEyTRgVx4shJrd0SeNR2WZS1zcOYx7Ff1wXRZ4pe
	 rZq16LW3frdkiiJR/pQbK5+y/yvEc/X9yBeuGIMyc6q9WAS5YGihv5tHorlGdGM00l
	 /ov5julTa2Y9R4nL9yECN60vPr7vp6psaohBRxwiI+9E29uMTIQoNQMXfhO1xZ1Luw
	 btinqxGbMYtW3Py/b0Cf+MCA/toB+zx25oBk70OnN7NXvvHUPIWZuZlLK2FLz8j+vu
	 7kvmFQoWrGADZr9FqPQfrVzPt5yM6qQMCnptOQgX9n5nGa4YNfuGVRZaKVY8WHLmif
	 YUhouGhNdtXtA==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4V9ZjG3MHRz9BQ;
	Thu,  4 Apr 2024 23:37:54 +0200 (CEST)
Message-ID: <a8c030bb-b7ff-4628-a104-65e64a1feb93@badez.eu>
Date: Thu, 4 Apr 2024 23:37:53 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Git log --decorate show prefetch objects
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
References: <5a16d4e3-6fa4-45f3-ae79-576f3fa80d44@badez.eu>
 <xmqqh6gh12yp.fsf@gitster.g>
Content-Language: fr
From: Alexandre Badez <alexandre@badez.eu>
In-Reply-To: <xmqqh6gh12yp.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha

On 04/04/2024 18:56, Junio C Hamano wrote:

> Alexandre Badez <alexandre@badez.eu> writes:
>
>> # What did you do before the bug happened? (Steps to reproduce your issue)
>>
>> <on a git repository not fetch from a "long" time so you have missing
>> branches and/or objects>
>>
>> git maintenance run --task=prefetch
>>
>> git log --oneline --decorate --all --graph
> I do not use the prefetch stuff, but unfortunately the person who
> was most familiar with "maintenance" are no longer active on this
> list, so let me take a crack.
>
> I think your complaint is that "--all" really means "all", not just
> "heads" and "tags" but also includes "prefetch", while the prefetch
> hierarchy is not included in the "--decorate" sources.
>
> What does
>
>      $ git log --oneline --branches --tags --decorate --graph
>
> show, and is it closer to what you expected (note: this is not a
> direct suggestion of a workaround---trying to gauge what the
> direction is to move forward)?
>
> Thanks.


Indeed, I missed the --branches (and --remotes) options; they do a 
better job in my case.

Maybe --all have a "legacy behaviour" so it's on me to move to new and 
better options.

Thanks.


