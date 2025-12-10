Received: from mail-108-mta188.mxroute.com (mail-108-mta188.mxroute.com [136.175.108.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6800A3242C9
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 12:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765370304; cv=none; b=GKx8KG9JiV5/RdscZNh2mSvqQFHIBh0GisM9djiofqO8oHiLvigrx0E6TPIog/btuRgu8hPLdDVYThU5+ftz25WGdhxXu/Yk4OJAU0H5zHQb5HmCoyQXxFKV4bS9MkoRgvMDHSW+stnG6AiqP+xn9KHsum5lyJkl3CDVnQ9WqOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765370304; c=relaxed/simple;
	bh=8K6NVqQdJukaK3wtaL/ULJm5F9OewPxvKCyjxqnJzu0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=XDAwATLeTUxHPM/7YmUWTnqD7vFfNdonQKu7Qfoenq3seyPqCL5ElPE60S0+nZOO6D0ig1x4uwwl4Ixq68w9ssHicuRL2Gt0I5IFfgC3C/oH5hb3GEIZGWq7szRm8Vy7y5YSc/nmS/TcQS/LAShIp6fFZVs+W4Odg4H3o8Izor8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ashlesh.me; spf=none smtp.mailfrom=ashlesh.me; dkim=pass (2048-bit key) header.d=ashlesh.me header.i=@ashlesh.me header.b=arANkwYq; arc=none smtp.client-ip=136.175.108.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ashlesh.me
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ashlesh.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ashlesh.me header.i=@ashlesh.me header.b="arANkwYq"
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta188.mxroute.com (ZoneMTA) with ESMTPSA id 19b08403a380004eea.005
 for <git@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 10 Dec 2025 12:33:05 +0000
X-Zone-Loop: e90454fe87591612e055e0d5674e48ab0fb2299f08d8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ashlesh.me;
	s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:To:
	Subject:From:MIME-Version:Date:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=IJ1wrh5qUf2MtsT6+Oly2krOy+dO8+anzEeJJfktTF8=; b=arANkw
	YqJy15WVKoPqbUylsLNNCktTNspMjArH1gRd5cUwYHjLpH8zEKug7xhm740yY84TIb3iOkdxi+ds6
	CKFGvVk+KC1SqPl0G/gRFjPh1t0zA5MtuJ1lfaV5UpOS3tT6BdT8E6QsbYWOU3ZIU3mw7rVTeLVbI
	IZYz7UG6GuUlRdoy3wvDfHB7e9oAY3htUIGuTal+PHWagovfgQ72eDXAjBAIPp2o4I8SC4pzSskC5
	GmkibK6cCEX0uFeYQVI7PequeU0SYW8u8T21iNaK2sXXwbKZhL2pxX+y7NBGnKAb93me+ebSNrptt
	Ep3Mhn1262DwAfNuIo72/W/luw4A==;
Message-ID: <82aa2f9c-9418-4d4d-bf4b-a813a6fe02d4@ashlesh.me>
Date: Wed, 10 Dec 2025 18:02:42 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ashlesh Gawande <git@ashlesh.me>
Subject: Re: [PATCH] http.c: prompt for username on 403
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
 Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
 =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20251014144354.1457818-2-git@ashlesh.me>
 <aO7Aqooz-0ppbcMP@fruit.crustytoothpaste.net>
 <30639771-4999-45f4-a8d7-1ed4774ffd8e@ashlesh.me>
 <aPAg3gYwzA9fHCC3@fruit.crustytoothpaste.net>
 <79d2226c-b568-4385-a618-f0d3c06cd0a8@ashlesh.me>
 <aTjVenutFBprwrrz@fruit.crustytoothpaste.net>
Content-Language: en-US
In-Reply-To: <aTjVenutFBprwrrz@fruit.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: info@ashlesh.me


On 12/10/25 07:35, brian m. carlson wrote:
> On 2025-12-09 at 08:22:49, Ashlesh Gawande wrote:
>> I was working on separating the tests and thought about the original
>> proposal a bit more.
>> To stop the credentials from being erased on 403 could something like the
>> following be acceptable?
>>
>>          else if (results->http_code == 401 || results->http_code == 403) {
>>                  if ((http_auth.username && http_auth.password) ||\
>>                      (http_auth.authtype && http_auth.credential)) {
>> +                       // Do not override existing credentials on 403
>> +                       if (results->http_code == 403) {
>> +                               return HTTP_ERROR;
>> +                       }
>> +
>>                          if (http_auth.multistage) {
>>
>> So then we would prompt on 403 only if credentials are not configured.
> Can you tell me what file you see this in?  I don't actually see any
> place in the code that has "http_code == 403" in the latest version of
> the main branch.
>
> I wonder if your issue may already be fixed in a newer version than you
> have.
Oh, that http_code == 403 is my original proposal to prompt for 
username/password on 403 (I did the diff on top of that instead of base).
But you pointed out that it would wipe out existing credentials. This is 
an attempt to fix that by not prompting on 403 if git credentials are set.
So when credentials are provided through default netrc file (such that 
http_auth.* are not set; git credential helper is not set) then we can 
still get the prompt on 403.
