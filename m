Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E3D334C1F
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 13:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761052445; cv=pass; b=ND54dQ63QEpcio7Pt9XHwUFHODFlDoQ0cyHgD44lu7WiySrjN5sGmeiqO1gGApWAfuM3XTrl5Wm4va3lx5LMHmpiqWLJLIDNOGMXJ6/SNlCzV4EWIY64WBe7PjllnA6ilTcFyBTM/OOVaapQRj4qO2TlcNSC9ZekKe1+vH1I9cA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761052445; c=relaxed/simple;
	bh=hhIfXGET8Sj8qQA0xbMNl+XtYun09ctmJv5owZtjQQU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pLA27jXwkyzHjVlHZ2Kz3bfTl3zsNccCKWR9NoCYFuzn2MHeJ3m0+v4YcgwXezg4ypRBLk/evDC2VEUTM0gobV9+cbmPRmck1+28cyxFt0BKCldfvMn/HkfvKYRZhmv4VZQ5Kwev/Gu/JnhkI6gY1620/Fd9uEDWITKjSdzDsiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=e+1ONcfX; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="e+1ONcfX"
ARC-Seal: i=1; a=rsa-sha256; t=1761052428; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GWuR6TDp+vwQcevrs4rNgDktY2NM9lhCdsUZxEGbsIis+VAu7G0PnnUzc8ts2UjsTdfuhexwYj7NzTs+oWQXXHDYYPYW5xx46ZTz/PeVQNXmlrYaDpttJXB53snpzdUc4Z8gjksGvHteVgFzEwOjYmlXe3WA2qZ6tSxdW6xTgdA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761052428; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+BZD4X/iBh9fU2NupF9dgp3o+zyKdpC5MpZQTOH0EaE=; 
	b=OyvTIm++mZbjr7tDv5m6RsrL/cEmp0hd3OqV7IoiUvt2bTAcYU2zZRA9Gqkfh+2Q6UY7RKo/jD08q34aaQONVNF9VchYbK7k5K3eTQG68h6bVYPgT0w1bVnxkiQTE+axMyq3I9H0bxmMEA9xR4lkVAe7xuJ9Fl7MhfMMUIdysbk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761052428;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=+BZD4X/iBh9fU2NupF9dgp3o+zyKdpC5MpZQTOH0EaE=;
	b=e+1ONcfX7/+bs8TcqB2VfE/EBtlKMpHdjSgOYsR1YhC9GLVtTLBtz0+pp2tWBtBe
	q+7PMfgCILs94DCQyKTpo5kZXc1XSb9gBjVnangV/zB3P9RFpO50teLv0NsXPKdNCuc
	xOhTOfqXMfH0oHLi5K34yN3P8pfw+EGB6WLqddCQ=
Received: by mx.zohomail.com with SMTPS id 1761052424059100.23385021145907;
	Tue, 21 Oct 2025 06:13:44 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Jeff King <peff@peff.net>, Junio
 C Hamano <gitster@pobox.com>, Aaron Schrab <aaron@schrab.com>, Jonathan
 Nieder <jrnieder@gmail.com>, Josh Steadmon <steadmon@google.com>, Ben
 Knoble <ben.knoble@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 5/5] submodule: error out if gitdir name is too long
In-Reply-To: <aPc-79_XLyTjA_w0@pks.im>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251006112518.3764240-1-adrian.ratiu@collabora.com>
 <20251006112518.3764240-6-adrian.ratiu@collabora.com>
 <aPc-79_XLyTjA_w0@pks.im>
Date: Tue, 21 Oct 2025 16:13:36 +0300
Message-ID: <871pmwqtxb.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-ZohoMailClient: External

On Tue, 21 Oct 2025, Patrick Steinhardt <ps@pks.im> wrote:
> On Mon, Oct 06, 2025 at 02:25:18PM +0300, Adrian Ratiu wrote: 
>> diff --git a/compat/posix.h b/compat/posix.h index 
>> 067a00f33b..aa050fd58c 100644 --- a/compat/posix.h +++ 
>> b/compat/posix.h @@ -250,6 +250,14 @@ char *gitdirname(char *); 
>>  #define NAME_MAX 255 #endif  
>> +#ifdef NO_PATHCONF +#ifndef _PC_NAME_MAX +#define _PC_NAME_MAX 
>> 1 /* dummy value, only used for git_pathconf */ 
> 
> Are there platforms that have pathconf(3) but not _PC_NAME_MAX? 

AFAIK no, because they're both part of POSIX and in all known 
implementations they are both defined.

> 
>> +#endif +#define pathconf(a,b) git_pathconf(a,b) +long 
>> git_pathconf(const char *path, int name); +#endif + 
>>  typedef uintmax_t timestamp_t; #define PRItime PRIuMAX #define 
>>  parse_timestamp strtoumax 
> 
> Let's adapt this to our coding guidelines to make this easier to 
> parse: 
> 
>  - Nested C preprocessor directives are indented after the hash 
>  by one 
>    space per nesting level. 
> 
> 	#if FOO # include <foo.h> # if BAR #  include <bar.h> # 
> endif #endif 

Thanks, however I'm inclining towards dropping this commit in v4 
as Junio and Peff suggested, since it doesn't add anything other 
than the nice error message, so we can let each OS fail with its 
own message like they did before this patch. 

We could bring it back when/if we decide to implement sharding /
trimming, i.e. to address the TODO in the patch, that way it's more
useful.
