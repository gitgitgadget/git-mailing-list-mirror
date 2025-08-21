Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82108327793
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 13:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755782089; cv=pass; b=MXmcrGwd66VDEF9O2HvRxwN+66byBIatSsZWOqHLkGR0upuRFRiCjqTl6BBs5OzLClI37Q2hyewrNPIYLfRGXdYvAUga4RYYj5XWTsZyKQvP25FKylVhOhABmpDtzw/d1yXKRPmk9OdSKxznB8L7Yc9MfprlMsMJjM4iV3dRfWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755782089; c=relaxed/simple;
	bh=ct3Y6APOax4NbVMP2QhmtVRENhecE11asTvEW5kco/w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AzQYdDxSy7WuJYg60SetfRW0noxkm8WprydukPnSI6U2Gcf0fYe8t/LMo6UuCHhFI1SW3D0QywtFKkOAmruZ8/Yo3AxmS6W1hq/7RIZJoUL5/T0PbthxK3cf0PdIadlyMUC0uAg75Tct+CrI3Xuazc4fIkh19g2jQSKr+jPT1ug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=JEDJ/iGY; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="JEDJ/iGY"
ARC-Seal: i=1; a=rsa-sha256; t=1755782071; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LGV/PIORmurUtecfOfoaccrGxxTMldFxb4N7suYO09I5mCr52mz17tXDMKRctZuAQ4em3nI4pwCVzYt2JFfFXXnYLsQiHv4NyI6CCmBAsu1xY9ozmFwYiqhNLH7ve0hQYJcU2Y7/x1e0qUsvBDU0WXALqYONu7YEvAcTvBG18eE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755782071; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=GVB7zAXjkdzho0QVcpo0BudhoPrXYcYhGTNuj7AJT+Y=; 
	b=i9eBSq3OpCiVtESa1sGfCa4smFG7VYDmeLHYhuGXwsjLbUFfTPWSU73KqBOSWqlwT8P5qaZbXMEicE5ohOoVeSpHlycdLYL/e6O0aZHjlj9SadOkFNJDIqzXCkJNvwQLJZ9HU8SJFOSObMA//ueRv5kQ4s9SHlXyC41lLGAXnJ8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755782071;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=GVB7zAXjkdzho0QVcpo0BudhoPrXYcYhGTNuj7AJT+Y=;
	b=JEDJ/iGY5a5SAmA39Hk01zJ8WG3PfxJ7cr5hCKSckc59tYTMU9eP7m1AZ4VqxwOi
	tyV2kdYWGY12YxKwglTBkLVnEoWInDW4riTFp1AN6e1ENTsXBgo4oLnkL/tz3TtVIN6
	gfyuCS706r5YxvqdzlcVmULm9iwtGq4PWlXMTwow=
Received: by mx.zohomail.com with SMTPS id 1755782068862436.7786363576788;
	Thu, 21 Aug 2025 06:14:28 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Junio C Hamano
 <gitster@pobox.com>, Aaron Schrab <aaron@schrab.com>, Jonathan Nieder
 <jrnieder@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 6/9] submodule: encode gitdir paths to avoid conflicts
In-Reply-To: <20250820192947.GA1663047@coredump.intra.peff.net>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20250816213642.3517822-7-adrian.ratiu@collabora.com>
 <20250820192947.GA1663047@coredump.intra.peff.net>
Date: Thu, 21 Aug 2025 16:14:25 +0300
Message-ID: <87sehk7r66.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-ZohoMailClient: External

On Wed, 20 Aug 2025, Jeff King <peff@peff.net> wrote:
> On Sun, Aug 17, 2025 at 12:36:39AM +0300, Adrian Ratiu wrote: 
> 
>> @@ -2632,5 +2633,23 @@ void submodule_name_to_gitdir(struct 
>> strbuf *buf, struct repository *r, 
>>  	/* New style (encoded) paths go under 
>>  submodules/<encoded>. */ strbuf_reset(buf); 
>>  repo_git_path_append(r, buf, "submodules/"); 
>> -	strbuf_addstr(buf, submodule_name); +	base_len = 
>> buf->len; + +	/* URL-encode then case case-encode A to 
>> _a, B to _b and so on */ +	strbuf_addstr_urlencode(&tmp, 
>> submodule_name, is_rfc3986_unreserved); + 
>> strbuf_addstr_case_encode(&encoded_sub_name, tmp.buf); + 
>> strbuf_release(&tmp); +	strbuf_addbuf(buf, 
>> &encoded_sub_name); + +	/* Ensure final path length is 
>> below NAME_MAX after encoding */ +	name_max = 
>> pathconf(buf->buf, _PC_NAME_MAX); +	if (name_max == -1) + 
>> name_max = NAME_MAX; 
> 
> This patch seems to break the Windows CI builds, as they don't 
> have pathconf() there. I guess we'd need a compat wrapper that 
> returns -1 in this case. And likewise protects _PC_NAME_MAX from 
> being seen on systems that don't have it. 
>

Ack, will fix in v2.
 
>> +	encoded_len = buf->len - base_len; +	if (encoded_len >= 
>> name_max) +		die(_("encoded submodule name '%s' is too 
>> long (%zu bytes, limit is %ld)"), + 
>> encoded_sub_name.buf, encoded_len, name_max); 
> 
> It also complained about %z here. I think you have to use 
> PRIuMAX instead. Likewise size_t is a "long long" on Windows 
> (LLP64). So "%ld" probably also needs to be PRIuMAX. 
> 
> I also saw failures on the osx jobs for t7527.62 (submodule 
> absorbgitdirs implicitly starts daemon). I didn't dig in, but I 
> can guess they may be related to this series. 

It's possible. I'm so sorry for these breakages and will address 
them in v2. I'll use the GitHub CI since I don't have access to 
win+mac systems.

Also thank you for your patience, this is my first git project patch. :)
