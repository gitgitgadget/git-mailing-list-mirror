Received: from dd36226.kasserver.com (dd36226.kasserver.com [85.13.153.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEC41A38F4
	for <git@vger.kernel.org>; Sat, 23 Mar 2024 14:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.13.153.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711202459; cv=none; b=DRCBdFat06HBc9NJyigDqk1G6HjU5RLudF0dB+UQV8qEhkHzXD/3OXOyW54EZ/XyFfCRtsO59cALBGpXmzFcBHgiVYEKZ+srXpKG+yIAEjphRCF9VLumi6D2fHTTCsByY+OExCzlAlwyn8nBBpROXmwXSUWhS4RG585TfTox/yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711202459; c=relaxed/simple;
	bh=z6ZJm8TZCFMesUbPAI8xuIHxEdov/hR15CrN/RjCg6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rrxDRpr6XjywKgM2q+fDUawNgmCymI7hp6neyEKwQJrsXCje0z/Bm0AO3ZkF8ZNTwnliPDPuU3Hy/aCqMYUDgbFa/WTF1fgPUmGOwpzcwTyFsgndvi2NA8g1kZ2ZQPIvIYKIQWTwKf2K/Bosmu13BIvBhG3EORtk78nH8D+zeb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haller-berlin.de; spf=pass smtp.mailfrom=haller-berlin.de; dkim=pass (2048-bit key) header.d=haller-berlin.de header.i=@haller-berlin.de header.b=Xz+2Anoo; arc=none smtp.client-ip=85.13.153.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=haller-berlin.de header.i=@haller-berlin.de header.b="Xz+2Anoo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=haller-berlin.de;
	s=kas202402191026; t=1711201882;
	bh=z6ZJm8TZCFMesUbPAI8xuIHxEdov/hR15CrN/RjCg6g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Xz+2AnoolyoJZTUuKQv1i7yUneLKLFryJjJWEFRSLDB5Dte6XRpLzgt+++GKnTeD5
	 P9yVYFIq7HVD90oB4vTWasoeLgm3B9Ge6GaI7Kbc25uGSzBuzAFpeGzwRca2ufJ1Uo
	 nmnQA2h0NIrEoAw5rOaZLTK0QvLD9glUPZI52F/j9m2+qIjiuXLZO4jtTjStSSz7Gz
	 HPKTkLmWPuMiHr/Fv5dqsCfQxveIaI46IVfuTXPLmeEQUC7GI/iiNQOHj4LU0QtRwQ
	 g7VzLntwETjGo2cTe1Y7EKE5AwZwiVv9FUSLybXsKJGw41TUwLE592c94SV+O32c1r
	 d5vmwIBchRAVg==
Received: from [192.168.42.22] (29-99-142-46.pool.kielnet.net [46.142.99.29])
	by dd36226.kasserver.com (Postfix) with ESMTPSA id 975463C170D;
	Sat, 23 Mar 2024 14:51:22 +0100 (CET)
Message-ID: <01e09c64-4d62-406d-85fe-9fb77939cf63@haller-berlin.de>
Date: Sat, 23 Mar 2024 14:51:21 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Allow git bisect to auto-skip
Content-Language: de-DE, en-US
To: Junio C Hamano <gitster@pobox.com>, Olliver Schinagl <oliver@schinagl.nl>
Cc: git@vger.kernel.org
References: <3d835c4b-d026-4c6a-b68e-6989a7a2065f@schinagl.nl>
 <xmqqwmptzyny.fsf@gitster.g>
From: Stefan Haller <lists@haller-berlin.de>
In-Reply-To: <xmqqwmptzyny.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: /

On 22.03.24 23:31, Junio C Hamano wrote:
> It often is discovered that a commit
> breaks bisection after the fact and it is not feasible to rebase
> all the history after the commit.

This reminds me of a similar problem with git blame, for which we have
the blame.ignoreRevsFile config to work around it. Couldn't there be a
similar mechanism for bisect, e.g. bisect.skipRevsFile?

-Stefan

