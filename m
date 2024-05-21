Received: from mail.aixigo.de (mail.aixigo.de [5.145.142.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE6A12FF8F
	for <git@vger.kernel.org>; Tue, 21 May 2024 14:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.145.142.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716301526; cv=none; b=PwTJa+Tf4NouQS9Azq6BFWPSwBV6AyxGOU4y1kWwECgM3OKupCpofw+Mf95sYKcMmYpeCl1iZvYLH0EWLjrZCX+GHMGow11UK6Ms0xE/jrmqrpq1t6pUplvciXoSHzOxPi9k9aZLSX4jS28eYn79JWkVHJ38/GOMhu/tcvWkI+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716301526; c=relaxed/simple;
	bh=wussDGK9kYANPIoxX2fzb662WEZuE2877F3MQiNA7jg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mTA3g7iFmj/Lr2/cikocFkQSCgbjuKiHr67mEo5bTPXP+V23Qy4BZG++yH6nl8RL+MHEs4loqI42aOKKU+BrHWej45RvDCB8Jrg8ZoOkdJ86/XXNSXJjkUOccCj8xUIt4J8w9FvTv8wHiO9+ElMySAuTQhNCBGLDwzRsZSF7yQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aixigo.com; spf=pass smtp.mailfrom=aixigo.com; dkim=pass (1024-bit key) header.d=aixigo.com header.i=@aixigo.com header.b=kyLy8Rt5; arc=none smtp.client-ip=5.145.142.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aixigo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aixigo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aixigo.com header.i=@aixigo.com header.b="kyLy8Rt5"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=default; bh=wussDGK9kYAN
	PIoxX2fzb662WEZuE2877F3MQiNA7jg=; h=in-reply-to:from:references:cc:to:
	subject:date; d=aixigo.com; b=kyLy8Rt52IIaWTdrE6h236PyFOs7P9lIGGjZh1M/
	OQcbD6aG2RWkhKnrn1m4s3YbRfC54tIcXfxWPJrQm9V05fHemdCZj1tIBzFKU4DNYERO80
	f3W4WR9TpTmcG5MMoPqWjYADkyjKJYjntZd6c690l9y6VdRJYdHioHVJm7yCk=
Received: from mailhost.ac.aixigo.de (mailhost.ac.aixigo.de [172.19.96.11])
	by mail.aixigo.de (OpenSMTPD) with ESMTPS id b3feb9d8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 21 May 2024 16:25:18 +0200 (CEST)
Received: from [172.19.97.128] (dpcl082.ac.aixigo.de [172.19.97.128])
	by mailhost.ac.aixigo.de (8.17.1.9/8.17.1.9/Debian-2) with ESMTPS id 44LEPH0l838356
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT);
	Tue, 21 May 2024 16:25:18 +0200
Message-ID: <d71c7dff-46a7-4ac8-a8c7-ab4985458071@aixigo.com>
Date: Tue, 21 May 2024 16:25:17 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: How to disable safe directories?
To: noloader@gmail.com
Cc: Git List <git@vger.kernel.org>
References: <CAH8yC8mPP_2jv8HDBdMxWv6TbiLXeDnD=KmNRMbno2bHQtfH1A@mail.gmail.com>
 <3e4a7071-60b0-4f7a-b347-d584d5eb076e@aixigo.com>
 <CAH8yC8mNns_XiQHp3=q_tYr03Q+kR1r=2WOYha1XMp+cYs9WDQ@mail.gmail.com>
From: Harald Dunkel <harald.dunkel@aixigo.com>
Content-Language: en-US
In-Reply-To: <CAH8yC8mNns_XiQHp3=q_tYr03Q+kR1r=2WOYha1XMp+cYs9WDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 1.0.3 at srvvm01.ac.aixigo.de
X-Virus-Status: Clean

On 2024-05-21 12:45:18, Jeffrey Walton wrote:
> 
> Thanks Harri.
> 
> Would that be something like safe_directories.enabled = false? If not,
> can you point to a setting?
> 

It is possible to disable this feature globally using something
like

	git config --system --add safe.directory /somepath/.git

Some say even

	git config --system --add safe.directory '*'

works, but I haven't tried that.


Regards

Harri
