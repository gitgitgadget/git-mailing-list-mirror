Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01370AD48
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 06:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711002346; cv=none; b=u8zkEAkNRho3U0eK+bTDS+s72Zmd52U4M82nDNRzojlPHYwsTaxc+kDTraNttLPNL1TzC+3fBtM9wxdP7qVcgfmRI9sU2hEcCr6WIXU7DpmL/fsSy//ebYUa1YSAwkFzlJ3kawerh1ed9CzxgbgXfXH/NuvqJMPDdafU8lHSC8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711002346; c=relaxed/simple;
	bh=B87ilUPtOMIyPAuiffB260gZPfyNK/yNsODw4p+v5Rs=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=hY+xwdT/7/8pyiTdkHNoG+gBZArP5CZ8MLPOTqcksv4ccgxkuzlT8Nmd3jXoPNE4GtVpI5jIju/S7uzcOhOa5HPz9MRWqR3sXhhBYt5wpc0Krsmu4Vw1y0E/KRt2b1fK/qr6agvEW06PctOSstM7NO6LlwDx274Gz3GaJ/VcD14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=jd5YKVlC; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="jd5YKVlC"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1711002342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EVl+HKiQHsxC2awlCasCQvykdEAd9t/REXm2kf/aqZw=;
	b=jd5YKVlCICRdFTgKkgMb6K+kRO2tze/9F5z1ZJDD9/mq+dJgTE1FAJDnRkMDkxv1Jny5q1
	9cCYoAk7GX9ICbWDw+bhAh8Qgp2APZQar7RZ4hhl24veLJu5YZCI4WoIcPebZKuE0CeFJJ
	4n3J5s+9VkY/6UP7eHsIUaiGq1SrqtyE+m7DlLpu1NyvNS8W5Tb0p/0gMfO2XA1HEVKaR6
	nMYa2M8Z5GsXwGL0z9gtzm9cfRF3bPAAxlgrjnkVnxJSBAEgJGcJP5zVCDvTS6viiIO0V1
	lBl5USRqc/6c+uJHd31uh9tudfs1Y5X3t3n3WdK0dKBAREvMoKYA84uH8Lx1KA==
Date: Thu, 21 Mar 2024 07:25:42 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, gitster@pobox.com, rsbecker@nexbridge.com,
 github@seichter.de
Subject: Re: [PATCH v5 4/4] config.txt: describe handling of whitespace
 further
In-Reply-To: <CAPig+cToaiCzj2XwNSeStx7p7ZPn7=a2nKZBFLwX12Uj=hJ7cw@mail.gmail.com>
References: <cover.1711001016.git.dsimic@manjaro.org>
 <a75a5eb8793f4ae6eb6e7cf0e2fd017471fefd0e.1711001016.git.dsimic@manjaro.org>
 <CAPig+cToaiCzj2XwNSeStx7p7ZPn7=a2nKZBFLwX12Uj=hJ7cw@mail.gmail.com>
Message-ID: <4e816c433be4205c83a20c8a4c97a8f4@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-21 07:22, Eric Sunshine wrote:
> On Thu, Mar 21, 2024 at 2:06 AM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> Make it more clear what the whitespace characters are in the context 
>> of git
>> configuration files, and significantly improve the description of the 
>> leading
>> and trailing whitespace handling, especially how it works out together 
>> with
>> the presence of inline comments.
>> 
>> Helped-by: Junio C Hamano <gitster@pobox.com>
>> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> ---
>>     Changes in v5:
>>         - Rewrote the description of whitespace character handling 
>> again,
>>           to eliminate ambiguity, as suggested by Eric Sunshine [3][4]
>>         - Extended the improvements to the following paragraph as 
>> well, to
>>           tie it all together, and to make it less ambiguous how to 
>> include
>>           leading and trailing whitespace characters into 
>> configuration
>>           option values, if desired so
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> @@ -63,16 +64,17 @@ the variable is the boolean "true").
>> +Whitespace characters surrounding `name`, `=` and `value` are 
>> discarded.
>> +Internal whitespace characters within 'value' are retained verbatim.
>> +Comments starting with either `#` or `;` and extending to the end of 
>> line
>> +are discarded.  A line that defines a value can be continued to the 
>> next
>> +line by ending it with a backslash (`\`);  the backslash and the 
>> end-of-line
>> +characters are discarded.
>> +
>> +If `value` needs to contain leading or trailing whitespace 
>> characters,
>> +it must be enclosed in double quotation marks (`"`).  Inside double 
>> quotation
>> +marks, double quote (`"`) and backslash (`\`) characters must be 
>> escaped:
>> +use `\"` for `"` and `\\` for `\`.
> 
> Thanks. I find this discussion clearer than v4.
> 
> I don't have any further review comments on v5.

Great, thanks!  I really appreciate your prompt and detailed reviews.
