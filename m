Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A6113EFF3
	for <git@vger.kernel.org>; Fri,  4 Jul 2025 16:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.18.0.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751644992; cv=none; b=NMl0i2kny6dk5WhULE4VHkjTE3CWiyx3aZK/yBwbWXptg5alNd5+kZIT3YllqX52MT2Fsg++LJo9QxxbkZPpsv+ZyAKxtqeHEWB0RGxklr0WuGSTztztwzjVl1aURmqwATuAyNvpvCEblOnJjeG/22lqQLIZB75CTxMVHcdfzns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751644992; c=relaxed/simple;
	bh=vK9N3m/BeCcP0C8Vyp80AcAxuWVfK5eGYr2dmQIwQRk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XmlD3mXtV60pzIhvP/R/K8MxyKi9UiaRahow6tOo/ecqiKgcEDPZ4VBNR/YujlhGUnb1OzFf9EpaOWsphavKWEYKvOQ6yYssDtcxpZTRWoz7BSFvPCzTKVoyvkQjVIiHdtgOG/+qH09bOzavxh84ZqXppf62+azDRQToqdMq2Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=nefkom.net; arc=none smtp.client-ip=212.18.0.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nefkom.net
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4bYdWs600mz1sFNb;
	Fri,  4 Jul 2025 17:55:37 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 4bYdWs5cn3z1qqlW;
	Fri,  4 Jul 2025 17:55:37 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id wXtpPgFv4Klm; Fri,  4 Jul 2025 17:55:27 +0200 (CEST)
X-Auth-Info: e+U3zXuz+uIxeqGx0pcJbtezzJ3qZVZLUR2eP4NGjv/An1AarlG0ldoyun2CbSvH
Received: from igel.home (aftr-82-135-83-93.dynamic.mnet-online.de [82.135.83.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Fri,  4 Jul 2025 17:55:27 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 9DD1D2C1969; Fri,  4 Jul 2025 17:55:27 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  gitster@pobox.com,  ps@pks.im
Subject: Re: [PATCH v2 0/4] for-each-ref: introduce seeking functionality
 via '--skip-until'
In-Reply-To: <CAOLa=ZR2=5iZzUVTS1o81a5NhLLiyHLiJfznz2Us5q0VLU74og@mail.gmail.com>
	(Karthik Nayak's message of "Fri, 4 Jul 2025 07:58:14 -0700")
References: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
	<20250704-306-git-for-each-ref-pagination-v2-0-bcde14acdd81@gmail.com>
	<87ms9kcbtq.fsf@igel.home>
	<CAOLa=ZS0uP+5xso_SEG2GJZHeac-0F2_wMJKtvbFj_wROKbBkw@mail.gmail.com>
	<87ikk8c8jr.fsf@igel.home>
	<CAOLa=ZR2=5iZzUVTS1o81a5NhLLiyHLiJfznz2Us5q0VLU74og@mail.gmail.com>
Date: Fri, 04 Jul 2025 17:55:27 +0200
Message-ID: <87ecuwc5n4.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Jul 04 2025, Karthik Nayak wrote:

> Andreas Schwab <schwab@linux-m68k.org> writes:
>
>> On Jul 04 2025, Karthik Nayak wrote:
>>
>>> Consider the example
>>>
>>>   $ git for-each-ref
>>>   refs/heads/bar
>>>   refs/heads/foo
>>>   refs/heads/main
>>>
>>>   $ git for-each-ref --seek=refs/heads/cat
>>>   refs/heads/foo
>>>   refs/heads/main
>>>
>>> You can see that the reference doesn't have to exist.
>>
>> That is even more confusing.  What is the first matching ref if none of
>> them match?  Doesn't that mean skipping _all_ refs?
>>
>
> Well the idea is it would seek to the offset where the reference would
> fit in.
>
> This is to ensure that seeks to references which were deleted
> concurrently doesn't leave the client hanging with no results while
> paginating over all references.

Then don't call it a pattern.  Pattern matching is a set operation,
independent of sorting.  What you really have is a marker that divides
the sorted list in two parts according to how the marker sorts.  And
that makes --start-with more descriptive and less ambiguous.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
