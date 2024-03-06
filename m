Received: from mail-gateway-shared03.cyon.net (mail-gateway-shared03.cyon.net [194.126.200.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FEB819
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 21:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709759003; cv=none; b=Nos85k0QUHqNmTnTe1VEwApee5Nicuos6A0lYjHSl+CdKgi1T5UtRqfifyFhZGNWd3jmnpbFId3TL1q+WYRbMyzZ5qFvXlxO9J7YVKO/ElegXBL17vSFz/jxHQs5EzbQljn4lnRiJ/iisell6kusiyz4v5qekifq7EsrN7Fn84o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709759003; c=relaxed/simple;
	bh=7zMAwZUdBlmLldaK8OKfz9gmi0DZonzASsJBf0fB+58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bsiq+CJQ/b4Ucakd1QkCkcSLdXf4J3zkBLryr5HoENQQEpFQel9H3cvE9cPDq768I3RnlAQBZ9XsLvte4s9Ouos68lA3X7XWaVSIdiUjtOZhUNmRu8ENZYfbfyTVIGatpraEwHKEJdsQSutXGPxiRgoWqrQVd2Vv4MfYmFoKn2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared03.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim)
	(envelope-from <dev+git@drbeat.li>)
	id 1rhyQ1-000000000t5-3I9U
	for git@vger.kernel.org;
	Wed, 06 Mar 2024 22:03:18 +0100
Received: from [10.20.10.231] (port=45256 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.96.2)
	(envelope-from <dev+git@drbeat.li>)
	id 1rhyQ0-006c4f-29;
	Wed, 06 Mar 2024 22:03:16 +0100
Message-ID: <6571138d-16b0-4c59-b6fe-a256b1c7e37a@drbeat.li>
Date: Wed, 6 Mar 2024 22:03:16 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/22] t/t8*: merge "grep | sed" pipelines
Content-Language: de-CH
To: Todd Zullinger <tmz@pobox.com>, Junio C Hamano <gitster@pobox.com>
Cc: Beat Bolli <bb@drbeat.li>, git@vger.kernel.org
References: <20240305212533.12947-1-dev+git@drbeat.li>
 <20240305212533.12947-20-dev+git@drbeat.li> <xmqq8r2ww4xg.fsf@gitster.g>
 <ZefSPAiTLrRVeXm6@pobox.com>
From: Beat Bolli <dev+git@drbeat.li>
In-Reply-To: <ZefSPAiTLrRVeXm6@pobox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li

On 06.03.24 03:17, Todd Zullinger wrote:
> Junio C Hamano wrote:
>> Isn't -E a GNUism?
>>
>> At least,
>>
>>      https://pubs.opengroup.org/onlinepubs/9699919799/utilities/sed.html
>>
>> does not seem to have it (we may need to fix t6030 to rid its only
>> existing use).
> 
> I _thought_ that -r was the GNUism.  The GNU sed-4.8 manpage
> says:
> 
>      -E, -r, --regexp-extended
>          use extended regular expressions in the script
>          (for portability use POSIX -E).
> 
> That doesn't mean the man page is right, of course. :)
> 
> https://www.austingroupbugs.net/view.php?id=528 suggests
> that -E has been adopted and, importanly, is more widely
> supported than -r (if we were considering using that rather
> than rewriting this to not use ERE syntax).  MacOS in
> particular supports -E but not -r, according to that link.
> 
> It seems like the documentation hasn't quite caught up to
> reality yet, perhaps?
> 

At least macOS Ventura and later supports "sed -E". I can't say what the 
more exotic platforms (NonStop?) have.
