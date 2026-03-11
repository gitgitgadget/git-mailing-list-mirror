Received: from mail-gateway-shared02.cyon.net (mail-gateway-shared02.cyon.net [194.126.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71425126F3B
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 21:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773265775; cv=none; b=mZuIyqZ5f0lZv0f0G2AfcTlGuP60iPUmnpBYKSYAIVUwd1hJvVeXJGc4Xlkjd1JJ6lMzVCFYX28R/DA6A7j6OGbJ5xNHYPHE7QRq2V6EtAOZXcOBh+/Hc9m3uqVSa0OM6+NkoeWtg8UxfXwupGZY8XIp0MJt1NpV7OnTPa84wOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773265775; c=relaxed/simple;
	bh=fqo/l+Esal0ffzvr805KBtBBCnUNlvM304FHfX7D86w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tN3lHdQ3iE5jtKmexXzUARor2a5ueGVHd+Bdy0fD6OoQZLGYA408MyPER0QT5m3pS/pGcU84gZkQBXr80jKtrhezVfIMTIU0HV9SdPoa48Q7PKwTWj2aW6Ax6GTXZjfBGYsMvVhwQaPxkNbLHSfq8x2NAQvPfha6etZKkDRG7ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared02.cyon.net with esmtpsa (TLS1.2:ECDHE_SECP256R1__RSA_SHA512__AES_256_GCM:256)
	(Exim)
	(envelope-from <dev+git@drbeat.li>)
	id 1w0RQn-00AZTG-0O
	for git@vger.kernel.org;
	Wed, 11 Mar 2026 22:49:30 +0100
Received: from [10.20.10.54] (port=39004 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.98.1)
	(envelope-from <dev+git@drbeat.li>)
	id 1w0RQh-0000000FYDq-3zrC;
	Wed, 11 Mar 2026 22:49:23 +0100
Message-ID: <a64f450b-1044-421f-86ca-aa523608911b@drbeat.li>
Date: Wed, 11 Mar 2026 22:49:23 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] imap-send: remove two string length checks
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: git@vger.kernel.org
References: <20260311121107.1122387-1-dev+git@drbeat.li>
 <20260311121107.1122387-4-dev+git@drbeat.li> <abFw7FMAwHPPWOBT@ugly.lan>
Content-Language: de-CH
From: Beat Bolli <dev+git@drbeat.li>
In-Reply-To: <abFw7FMAwHPPWOBT@ugly.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li

Hi Oswald

On 11.03.2026 14:41, Oswald Buddenhagen wrote:
> On Wed, Mar 11, 2026 at 01:11:06PM +0100, Beat Bolli wrote:
>> At this point, these two checks verify that the ASN1_STRINGs are
>> internally consistent. This may have been ok when the fields were
>> accessed directly, but now that the API is used, is unnecessary.
>>
> that argumentation makes no sense.
> the purpose of this check is to ensure that there are no embedded nulls, 
> which the matcher would be unable to deal with, which may be a security 
> hole.

Thanks for the clarification; this was the piece that I was missing.

I'll send a v2 shortly that removes this change.

Cheers, Beat
