Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A05A355030
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 11:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761047431; cv=pass; b=eoAGZgRAvjfopV834mjkwwrvoV01tBgTg8mHFreJixiN+j7P7+7hD85TuyJxELVAGTN8U5yCcmB39BEA+T+1EOhzTN1y3MBVJQ9bqf+i5b6gpjwKdWoJEexTUQ0QN3UzEbZkCesQrzZP3UOQ0XeqL8IhOo+hyx0Dci6aix5JXKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761047431; c=relaxed/simple;
	bh=7ARpkRsRwOds9CnNOvlkWlpUqm0imkARnxZxvdmVH28=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eyiaAlWqxMAZC6WbAwKyV1dRW7ZZtGCI6O5f1jJt/6ekRWv/AcWJlR8GAnbxW8wN4z/Ox2qROOnyezydzJiyNW5VgUUwhhCLHcF638C0L1011/YokKdyb/7CGDgu6syGojAIcYaWzG2Vmq/0ksfrjkgZDDUTcUpeaE3wLPsDaoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=APXYXijU; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="APXYXijU"
ARC-Seal: i=1; a=rsa-sha256; t=1761047413; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BvpnXw+KyUmgJKNeNnssvzl+pO5WR2s9/VOGCmXuO8UvJaBrYVJeZUDFpkcpT3eXOnN9EcxxF4Nq3mvIOe6aomit1s+M+6b/XHhBCU/Qav6Nz9vVyulALvb77wb4uH6wk1+V0VB5tZCWdOH2MwrFWJdB2ml/nzqL8ZTUhj0VnZE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761047413; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=sbg49rluvvQaKAIBLQ8u45HuIb1D6sZ/tjZP/l727os=; 
	b=Vu9QKuAYSeLnsUNRQ3WWtVgTjDw7sXlpqqIinZ/j8+q6ZozWZffao34+GKSu9z+WRSVrpI7CJW1pgPbABB1pWdM0VKQsYCc4vW995w3Wwy33s6iDNvFNsmcJ+S8pe4ejBBGqW77tGi/EiOfCm88oSxS+7HoqpRpxEmm35IS00Dg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761047413;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=sbg49rluvvQaKAIBLQ8u45HuIb1D6sZ/tjZP/l727os=;
	b=APXYXijUJTTsN1oDaqu2Dk/3+wJm4EJDnJLuCXCgMFjXd/gOLhumaK6bBIt/OoPc
	unc64QZGlcCZ3IggvkGO4XiZDKdPjJrHuGZt7fSsowKxnfqQSdPu1nODnQH7bYOxgYy
	0zQJizHRBfGxeozUAg8PVMAEpshIP8WgUW4T52kY=
Received: by mx.zohomail.com with SMTPS id 1761047410242934.652774201715;
	Tue, 21 Oct 2025 04:50:10 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Jeff King <peff@peff.net>, Aaron
 Schrab <aaron@schrab.com>, Jonathan Nieder <jrnieder@gmail.com>, Josh
 Steadmon <steadmon@google.com>, Ben Knoble <ben.knoble@gmail.com>, Phillip
 Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 2/5] submodule: add gitdir path config override
In-Reply-To: <aPc-98ps84R45MBF@pks.im>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251006112518.3764240-1-adrian.ratiu@collabora.com>
 <20251006112518.3764240-3-adrian.ratiu@collabora.com>
 <xmqqcy70q8n7.fsf@gitster.g> <xmqqzfa2lnxi.fsf@gitster.g>
 <aPc-98ps84R45MBF@pks.im>
Date: Tue, 21 Oct 2025 14:50:02 +0300
Message-ID: <878qh4qxsl.fsf@gentoo.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-ZohoMailClient: External

On Tue, 21 Oct 2025, Patrick Steinhardt <ps@pks.im> wrote:
> On Tue, Oct 07, 2025 at 08:41:13AM -0700, Junio C Hamano wrote: 
>> Junio C Hamano <gitster@pobox.com> writes:  
>> > Adrian Ratiu <adrian.ratiu@collabora.com> writes: 
>> > 
>> > [jc: brandon removed from CC list as the address would 
>> > bounce] 
>> > 
>> >> This adds the ability to override gitdir paths via config 
>> >> files (not .gitmodules) such that the encoding scheme (or 
>> >> plain text name if the encoding extension is disabled) can 
>> >> be changed via config entries. 
>> >> 
>> >> These entries are not added by default for all submodules: 
>> >> they should be used on an as-needed basis. 
>> >> 
>> >> A new test and a helper are added. The helper will also be 
>> >> used in further tests exercising gitdir encoding 
>> >> functionality. 
>> > 
>> > What is the use case of this?  The only reasonable use case I 
>> > can see is to set this to all the existing submodules when 
>> > you are switching the extension on before adding a new 
>> > submodule, in which case the old ones will keep using 
>> > unencoded names, while the new ones will use encoded ones. 
>>  Two things.  
>>  * I no longer mind this setting existing, but I think it 
>>  should not 
>>    be a mere "override", but the authoritative source of truth 
>>    for all submodules (see my other response on 0/5). 
> 
> I think making this the authoritative source of truth for all 
> submodules in the case where the new extension is enabled does 
> make a ton of sense.  It makes things way easier for us to 
> reason about: 
> 
>   - If the extension is set, we know to always use whatever is 
>   in the 
>     gitconfig. 
> 
>   - If any submodule path is missing we know that we are in a 
>   broken 
>     repository and can abort accordingly with directions for how 
>     to fix things. 
> 
>   - If we need to enable the extension we can trivially migrate 
>   all 
>     existing submodules by just writing their gitdir 
>     configuration. 
> 
>   - We can change the exact encoding going forward, as the 
>   extension now 
>     only indicates whether or not submodule gitdirs are tracked 
>     via the configuration or encoded "live". 
> 
> I think especially the last point is a big win, as we are not 
> stuck with the current encoding schema in case it proves 
> insufficient. 
 
Agreed, as I also mentioned in replies to Junio, I will follow 
this direction in v4. :)

Thanks,
Adrian
