Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071E02E0923
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 21:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768512306; cv=pass; b=qWKPt/PuH1dsKIucNFw/cjDc9HiSLNu2v36/BHoed/9nPN8UkKENeA8B7QXHRWUtlg3ws2/DK94VO7QDKqL7hZziix4DsMWMWasKgRDGdzTeeSV5SQjkRaKtccr30IFv+JGqIyqn8meDvhAcuYWBprLykyayO0daMGnUs3ym/vg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768512306; c=relaxed/simple;
	bh=rRhx6vIJ2GCICsKecnfoKptGm30TuGYKVkr9BJy5TIU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S2TDTwm0KsVX6CnKQmvJPwgBiuyonnb8/68u+/2fYJuRWw5KniRoX9SvOWAjB4bZ9tJlkhLlK14YO8wXKSUQ3stQXZGqtB7smTZkudL4PZv25oSKGf/327QgNQJJNngPxitS4KDtFlIF/bF4yig1N2H86LHKkQF54UHs8zS/98w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=IW8T9/J7; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="IW8T9/J7"
ARC-Seal: i=1; a=rsa-sha256; t=1768512283; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MSESEeGHGOCDhKy1jHYo7bqF+CzFQrte7270tmMZqJyxzqY7vmZIPtm+h6eskWa0LXzGZmvb3OSG+LDqBGoSB+sGFWN/yoWw1oM5s8+RRigAXIiOBmtm53dZ/bNbt/Mzu2SQFBo5WtmywFjosVLKtoWFJbPnmxXmAmnfDiyJ4vI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768512283; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=VxKJwcr3+5G7D1ATlp61aiDahiFK73ORCd6NOroQ6Mw=; 
	b=Zixm7nA4wNWIRLGbi7l8+DxXFheGFu82flaDhTbh/m0WHRV4oXdRgXmrcq+yEeGoeraClzDahdwpyxApkNuGRQ3rZ9ER1eL6Ze1ddQa75p47uaYJVuqBuWYRLln3+51mqXtXkLryyFlF4MWTXDluHBeeWx1HOPxwyiQtVJ91BVg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768512283;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=VxKJwcr3+5G7D1ATlp61aiDahiFK73ORCd6NOroQ6Mw=;
	b=IW8T9/J7IepRwMTaedcQ4ItTqXg2nwCpkzy2r+y8lj7EtbOXYaF3YcrCzT9tphsu
	2m6jZyd112UWxMadwaO+zG7qphUCppQMkNmPVjOSzp31MqPnF72lQeuiqF7sTpI0q/9
	A2euNREtrVPmmdonNicGhlAVqQIL0fdSaQDyyato=
Received: by mx.zohomail.com with SMTPS id 17685122813521019.1472340049761;
	Thu, 15 Jan 2026 13:24:41 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Emily Shaffer
 <emilyshaffer@google.com>, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, Jeff King <peff@peff.net>, Chris
 Darroch <chrisd@apache.org>
Subject: Re: [PATCH v3 0/2] Fix two hook conversion regressions
In-Reply-To: <xmqqfr86bp0n.fsf@gitster.g>
References: <20260113115633.230479-1-adrian.ratiu@collabora.com>
 <20260114185731.2381550-1-adrian.ratiu@collabora.com>
 <xmqqpl7bc68b.fsf@gitster.g> <87o6mulrnq.fsf@collabora.com>
 <xmqq4iomdbn0.fsf@gitster.g> <87ldhylq4e.fsf@collabora.com>
 <xmqqfr86bp0n.fsf@gitster.g>
Date: Thu, 15 Jan 2026 23:24:37 +0200
Message-ID: <87h5smlgbu.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Thu, 15 Jan 2026, Junio C Hamano <gitster@pobox.com> wrote:
> Adrian Ratiu <adrian.ratiu@collabora.com> writes:
>
>> On Thu, 15 Jan 2026, Junio C Hamano <gitster@pobox.com> wrote:
>>> Adrian Ratiu <adrian.ratiu@collabora.com> writes:
>>>
>>>> I agree with this.
>>>>
>>>> We can't let these two regressions enter a release, so we have two
>>>> real chices:
>>>>
>>>> 1. Merge both fixes to 1.53 or
>>>> 2. Revert the 'ar/run-command-hook' topic merge.
>>>
>>> Hmph, at this early point in the late release cycle before -rc1
>>> (yes, rc0 is scheduled for this morning, but that is not really a
>>> release candidate that counts as anything), it is tempting to take
>>> #2, actually.  I just do not know how much damage such a revert
>>> would cause to the tree.  I'll experiment after I finish cutting the
>>> -rc0 preview release.
>>
>> I do not expect any conflicts and, if there any, they should be trivial.
>>
>> Let me know if you need any help.
>
> Thanks.  I think I got
>
>  - revert of ar/run-command-hook directly on top of 2.53-rc0, which
>    would become the tip of 'master' tomorrow.
>
>  - rebuild of ar/run-command-hook + two fix-up topics on top of it,
>    called ar/run-command-hook-take-2
>
> as the "take-2" topic is totally outside 'next', we can rebuild the
> entire topic and get it right the first time, instead of
> incrementally fixing them on top.

Cool. I'll integrate the fixes into the series and send v7 continuing
where we left off.

Though I'll send the new test separately, in advance: there's no use
blocking the new regression tests after the hooks conversions.
