Received: from mail.aixigo.de (mail.aixigo.de [5.145.142.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7051E87C
	for <git@vger.kernel.org>; Tue, 21 May 2024 14:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.145.142.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716302997; cv=none; b=ICaHghadgWx6M7vQwL4Yh2IFz0Qo1OQVPBEqIQvFHEtx29g/eugtcKqqTR/h/4MtTGpDmiZ3KEZIY+w5RtnMoP67aqysCNbW9FXtsGd0ACkC14Nn2G0sl030XoYYawqDkrnM4BYKnHxAS7WiFsDZN0MdQH33F7NZLFq4JD4Ykog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716302997; c=relaxed/simple;
	bh=sMyTlnH1vXBgKjNOG4/iThaRGsvfYCh4XkI5e51GdRA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=So4DIg93hyNg7TCDe9s0C/Z4taEEm4/RZyhS3OxoIluTpiuEfodhR3ytzX3iRc6xAmUYI+a9hOAFDle3feYSZIavq499U94Zs6XQszgHEo2vmasDzmzzXzyp7VLIApSAa55AzeOlpA/aOY6tz/4RoHryRPLElqE9iH5rfD3c1ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aixigo.com; spf=pass smtp.mailfrom=aixigo.com; dkim=pass (1024-bit key) header.d=aixigo.com header.i=@aixigo.com header.b=VFva2VWo; arc=none smtp.client-ip=5.145.142.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aixigo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aixigo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aixigo.com header.i=@aixigo.com header.b="VFva2VWo"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=default; bh=sMyTlnH1vXBg
	KjNOG4/iThaRGsvfYCh4XkI5e51GdRA=; h=in-reply-to:references:cc:to:from:
	subject:date; d=aixigo.com; b=VFva2VWo8bswJi+85hofZoe0CtHsF3owx2fvLqHf
	LtK66ooZMN8+PA1IPyT3IklMrC+Nr93yXXl8KweQkjuMp88pj9miQbRKelNIdJXBM+gk18
	UHOQdor3fT1Wfoyj/S+keH2DCXdj4ExYRx3YGgD/BdivKBqI46Qg2cUrd2iEw=
Received: from mailhost.ac.aixigo.de (mailhost.ac.aixigo.de [172.19.96.11])
	by mail.aixigo.de (OpenSMTPD) with ESMTPS id 29f7eea7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 21 May 2024 16:49:50 +0200 (CEST)
Received: from [172.19.97.128] (dpcl082.ac.aixigo.de [172.19.97.128])
	by mailhost.ac.aixigo.de (8.17.1.9/8.17.1.9/Debian-2) with ESMTPS id 44LEnkdC843797
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT);
	Tue, 21 May 2024 16:49:46 +0200
Message-ID: <98381fb2-5110-4e7f-a504-c5ff75dcd050@aixigo.com>
Date: Tue, 21 May 2024 16:49:46 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: How to disable safe directories?
From: Harald Dunkel <harald.dunkel@aixigo.com>
To: noloader@gmail.com
Cc: Git List <git@vger.kernel.org>
References: <CAH8yC8mPP_2jv8HDBdMxWv6TbiLXeDnD=KmNRMbno2bHQtfH1A@mail.gmail.com>
 <3e4a7071-60b0-4f7a-b347-d584d5eb076e@aixigo.com>
 <CAH8yC8mNns_XiQHp3=q_tYr03Q+kR1r=2WOYha1XMp+cYs9WDQ@mail.gmail.com>
 <d71c7dff-46a7-4ac8-a8c7-ab4985458071@aixigo.com>
Content-Language: en-US
In-Reply-To: <d71c7dff-46a7-4ac8-a8c7-ab4985458071@aixigo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 1.0.3 at srvvm01.ac.aixigo.de
X-Virus-Status: Clean

On 2024-05-21 16:25:17, Harald Dunkel wrote:
> 
> It is possible to disable this feature globally using something
> like
> 
> 	git config --system --add safe.directory /somepath/.git
> 

PS: Its obvious that each peer running git can verify only local
directories for dubious access bits. Working with shared remote
repositories you have to consider setting the safe.directory option
on the remote server.

Since CVE-2024-32004 assumes an attacker running its own repository,
I just wonder why he should use the most recent, fixed git version?

Regards
Harri
