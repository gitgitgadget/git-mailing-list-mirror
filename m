Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC701E489
	for <git@vger.kernel.org>; Sat, 12 Jul 2025 13:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752327324; cv=none; b=ogsodqwT8XCAj1dkplHTxJl6mcbWfVaLOurCGVKXiVRILH6FoKinvKqitS7HRhcqlBP41e8YquzWzbEG6H3RXDQPQpL4qxwcydqiybDOOS8lhPMcjq495i/he8ilHuyRLN+ilOZPfydxEOVFwV+0uPwBGYesJAetIU7r0XstB/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752327324; c=relaxed/simple;
	bh=5HkbtOmnA7QN24BCQfyJpMGI8Egxipl+KBaC32Jh6Gw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=qCXkE30Y7qOOKm/zkJm75hje0I+YcsZB8fiCBEnWOc7Iton4LY8ABrPfBSJbCRtlJu8DZHd7S37u6PCJe+UDhblj6gvXYzvOPaSptGEc90Sv9ACnbortsJlcyOOkEq4GTlubeDGNokWGlROIUHLot4hbZQeNhf4/cBjCghlP/eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp2.bon.at (unknown [192.168.181.105])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4bfV296NF0z7QVc3
	for <git@vger.kernel.org>; Sat, 12 Jul 2025 15:35:13 +0200 (CEST)
Received: from [192.168.1.102] (089144220187.atnat0029.highway.webapn.at [89.144.220.187])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4bfV214GYzzRpLG;
	Sat, 12 Jul 2025 15:35:05 +0200 (CEST)
Message-ID: <23f2bbea-1294-4773-89d8-b270e2c3bb52@kdbg.org>
Date: Sat, 12 Jul 2025 15:35:04 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Why doesn't git core.eol=lf work?
To: Jason Cho <jason11choca@proton.me>
References: <8jPyf4EU-z7W6OHX4j_kba2G-1c2RIDtgBcSkFjWSNhMuE6pxOOyxSGBnguoZvuDQSaJPypH0u1vLJf6FBX_ahUn3bBO_1DVscfOQm4Jovw=@proton.me>
 <QcbAE4JJXpU-NcQ1loYdHthi-nYA2ZXcuuetCHE_0N0fRi0mdaf90VaLk0Y2ehrnVzoZraYO7jLhB7Pl68_k4l3HCqkFVGuMOzZ26cHYkfc=@proton.me>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
In-Reply-To: <QcbAE4JJXpU-NcQ1loYdHthi-nYA2ZXcuuetCHE_0N0fRi0mdaf90VaLk0Y2ehrnVzoZraYO7jLhB7Pl68_k4l3HCqkFVGuMOzZ26cHYkfc=@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 12.07.25 um 11:45 schrieb Jason Cho:
> ```MINGW64 /tmp/summer-temp/dbeaver/docs ((e4219ccb38...))
> $ git log -1 --patch license_header.txt
> commit b5121d4a6e8f3f21079920180b0fb14ada6d3349
> Author: serge-rider <serge@jkiss.org>
> Date:   Thu Jan 10 21:56:55 2019 +0300
> 
>     License header update (2019)
> 
> diff --git a/docs/license_header.txt b/docs/license_header.txt
> index 86de505a18..d75b48e98e 100644
> --- a/docs/license_header.txt
> +++ b/docs/license_header.txt
> @@ -1,5 +1,5 @@
>     DBeaver - Universal Database Manager
> -   Copyright (C) 2010-2018 Serge Rider (serge@jkiss.org)
> +   Copyright (C) 2010-2019 Serge Rider (serge@jkiss.org)^M
> 
>     Licensed under the Apache License, Version 2.0 (the "License");
>     you may not use this file except in compliance with the License.
> 

Since you posted `git diff` output, may I ask if your concern is
actually the ^M in the diff output, which you intend to fix with
automatic CRLF-to-LF conversion?

In that case, the simpler solution is to set core.whitespace such that
it includes 'cr-at-eol' to convince `git diff` not to mark the CR in the
CRLF pair as a trailing whitespace error.

-- Hannes

