Received: from mail-108-mta26.mxroute.com (mail-108-mta26.mxroute.com [136.175.108.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69B21DF963
	for <git@vger.kernel.org>; Thu, 11 Dec 2025 06:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765433445; cv=none; b=oZthNkWKuQdoP20PQ8d15/9Cj6+9DyL9gySvwoaY0SGQNDQ48ASlkeDOpavyzuph4VmNklVraeXMed6dDxD83JdhSuX2gEvRAlNrfFOGTtDAs/W03GugNj1gD0bslnLwFPgMRPpA18QZbQkj8cUahR3xSXRFBTplMZP5vAFyws4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765433445; c=relaxed/simple;
	bh=zLYIz6reNTP3zUSa7leO9VYAXGRaV6LAwv9ltwij5N4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TJW82A156oFo3ss+qoQ8nFpGj76sz/rZz35/psV+sLCX9C/uf32GcBrbzqcTmPf2pkP+ZmYvI29imwZ8XCxa4oOFDRO+NT8+TeHPT9OSkavNOajRrprQyhImJX4VjdyQXxK0TmYsknUA8iUxP7k2DSyiDLt96di88V927zJbHf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ashlesh.me; spf=none smtp.mailfrom=ashlesh.me; dkim=pass (2048-bit key) header.d=ashlesh.me header.i=@ashlesh.me header.b=O8JWzmAp; arc=none smtp.client-ip=136.175.108.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ashlesh.me
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ashlesh.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ashlesh.me header.i=@ashlesh.me header.b="O8JWzmAp"
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta26.mxroute.com (ZoneMTA) with ESMTPSA id 19b0c03d2510004eea.006
 for <git@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Thu, 11 Dec 2025 06:05:35 +0000
X-Zone-Loop: a1f6b3e2094e194b5ca757bff4f08ddb00b02512859f
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ashlesh.me;
	s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
	Subject:MIME-Version:Date:Sender:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=nlvyeKyFEijuuqKHjpd08Wk1oZ2Pr14JAvClW9jdpLE=; b=O8JWzmApwYZ/p4JetAgnwtFNt7
	nncj/ENsTKeuA2tX4cmS2D/9pp7HiUdCqxl6SZFFuRfCJUwjSIwSr/vtjEHin+1duYrpmWthG2Qll
	iB/e52FrFc25VQNzpReYUWFTbczL6E2hnKidCIwKbaSj3MTtLWcJJ6Of85Ca4E3RRx4GypxdBO4Hn
	s4b6t1fisKhTvLXCvs9WMHmo09U95FsAZ7sArqpU3C2YcTx850JxXb0hTEF9CCC8C2UdoLtsnhbS/
	WUCUZIvgHzOpSwfxdP5teLo7yZiHfwmIm+tEN67Ng8zQho7ijE6Jc/z5FWmmew+XPPFU1Ksuq/O6W
	UZ0Al8Wg==;
Message-ID: <888e3dec-e279-47af-8a91-04a06f6eb0af@ashlesh.me>
Date: Thu, 11 Dec 2025 11:35:11 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] http.c: prompt for username on 403
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
 Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
 =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
 rsbecker@nexbridge.com
References: <20251014144354.1457818-2-git@ashlesh.me>
 <aO7Aqooz-0ppbcMP@fruit.crustytoothpaste.net>
 <30639771-4999-45f4-a8d7-1ed4774ffd8e@ashlesh.me>
 <aPAg3gYwzA9fHCC3@fruit.crustytoothpaste.net>
 <79d2226c-b568-4385-a618-f0d3c06cd0a8@ashlesh.me>
 <aTjVenutFBprwrrz@fruit.crustytoothpaste.net>
 <37c3b31e-900e-4df0-ac30-284e71660487@ashlesh.me>
 <aTn0BOM07Lyphq_1@fruit.crustytoothpaste.net>
Content-Language: en-US
From: Ashlesh Gawande <git@ashlesh.me>
In-Reply-To: <aTn0BOM07Lyphq_1@fruit.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Id: info@ashlesh.me


On 12/11/25 03:58, brian m. carlson wrote:
> On 2025-12-10 at 12:30:27, Ashlesh Gawande wrote:
>> Oh, that http_code == 403 is my original proposal to prompt for
>> username/password on 403 (I did the diff on top of that instead of base).
>> But you pointed out that it would wipe out existing credentials. This is an
>> attempt to fix that by not prompting on 403 if git credentials are set.
>> So when credentials are provided through default netrc file (such that
>> http_auth.* are not set; git credential helper is not set) then we can still
>> get the prompt on 403.
> As Randall said, I don't think it's a good idea to do this.  It's a
> major change in how functionality works and it will probably break
> users.
>
> I did mention before that a better approach is to add a config to decide
> whether to honour the netrc and I think that would be the right choice
> here.  That lets people opt into different behaviour if they want it
> (and, to be honest, I _do_ very much want to skip netrc for Git
> credentials since I have similar problems as the ones you're describing)
> and avoids breaking things for existing users.

Hmm, okay I understand. Yes probably good idea to skip netrc for Git 
credentials.
Thank you for your input Brian and Randall!

