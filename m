Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B0D2BCF4C
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 16:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782145593; cv=none; b=GLumXhcIBSmJh98TYzMwnWbWhc9/ULJd68G67fZamgvwvKsyAdKkUcywQVv5mPwisBroMREPhYuUMjFmOU9QKPIWguCO5iyDayAjT5P+7voSjVq71H2+okfJYI5kJ+U8CyXEAm794SD2PuC+JcTlXsF6I8MhX2apTQuocnEj660=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782145593; c=relaxed/simple;
	bh=m37UmVx+933u0zXXQdKsuEfswUw0uSVAnvYEDvZfCTg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iw7jItws17W6Q7DUOejDKAm9bp1cTsQ1LdkW1y+Eb5pF+rEwLMP+it8dm8xbTPZmdBIxxyX0l2tai3eXss6Vz3BvcGlj5EP5o65XnGWkuDiI6nDuDbFMvMekIsO5TSmXTRC/voBLLKZv4iTBuL+sr1cFnIFJh8S4l6WXT48y+D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Aaqbdlc7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V36pCVcL; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Aaqbdlc7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V36pCVcL"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 2CCD0EC0169;
	Mon, 22 Jun 2026 12:26:31 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 22 Jun 2026 12:26:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782145591; x=1782231991; bh=Eatm6wO3WL
	aDVF+OLtaGdzZZ6TN5ZFqgftze2repBpM=; b=Aaqbdlc708ohEytsKhgFHBmSUr
	y/HWfKgi+jwN5SclklGLKmXneAKsSc+yUFPJ6tHc8fGPRfPL6cDVvtWD2UgCk94i
	sOhDDHOTaOvpnb+jslCutCyTeiusjBY4wC0WNsC98ii3HsgYE3+3eLjw+eQjZvts
	dZHskpQr99F8xrRYx0+h5MYYv215vejimMw/3ZTxdp3sEhhhgqNvZJm12A39kedr
	Qgr4nAPUD2MilYEtCAUK2lpims4002uUmQ5DBdPjPMwznDnbSyb8E9uRmBjySHW0
	ViqVMglFD+wYUIOPW/SGo37u25gdU/1sZ/I2BTDAVDoZWiK9IgC5Bp/2tYng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782145591; x=1782231991; bh=Eatm6wO3WLaDVF+OLtaGdzZZ6TN5ZFqgftz
	e2repBpM=; b=V36pCVcLIkRH0adPA6Ig0qTjcW/M6e5hbXgPzmJ7fA4R3BWbUSw
	saDguraPHsov/Oudl7e4AwdDItGecqUrhR05TPrmgrQ+hTotcNkd7X0p3rV89KH/
	HLc1HKT2BIGOiuRo/bqJxAQ0XVDGB+nW5T+uKrU+Za1tPnAUYIIbMXoyr9qpo3AF
	mFEqoBIp3w2xUHUgFvENGZS9GDrz/l/+lxKf6vu2A2BYKOf9DCws0WgwDM4qHpEW
	8ciK3Aq4w5osllIEYoeDzoBnwy9jVkQxP1rLYkDPP2EkPnzrgzylVtdf89qRWXdu
	kY+Xz5/lkVNq7SWRiIvw0moiUZOKbW7d4Mw==
X-ME-Sender: <xms:NmI5amB_JaRbHc6cWwKg3aKAngX9UL_n4L8uuyZWAFLl6Q_OKp25Ng>
    <xme:NmI5akO9WDgQYAzMWUkGrXksSyw2xDw-K1BJwX8C6g64H8peLNy7yhuXbnT1dQiMP
    gmzQBA1RTDJNnYsseotk-baue4y1g9axR-_rAPvGI_1LVpOTY5xzQ>
X-ME-Received: <xmr:NmI5ajYiWpQJkGvaXKeQqrz3RupJ0YmQiBaTmqoxr1SoAbkTyjgUTPOxgR5ejUFsq7LXc1-F9RbDDQrKRpucAihaf6OiHdU4HoqPyJo>
X-ME-Proxy-Cause: dmFkZTE8MAjoFaGp9a7nB9FPnOQ0aQik29dyOFr/4jGj9pXizVifBBTGgHeNdGLDgyi2sJ
    iQhLDv4jMmN5PZzzE90nqeVEV+EkHfjtss7EHp7uw0nCpvjSe8U6eL8fYdkv3QTyNJv7Lj
    R0Dcq0OM3dTUpNEL7WYN8FmkFKBQB1JOTSXlb+zhGeh8CnakY2B4wJ8YBHR/if1zLOoa+M
    uhJt5Sbui1iQkY8p/q8UpIH6uqwuEZ/xopKV1K615n1R0fLaBdrwt7bkw6jWO3BQrf3esN
    +RdUjkvWoMP/XRmcJP+Puebc0+G+MvjWdXuAzz66iS+7xtIzP+oiWAc+rpgnXljaq5kvKL
    g03LtDvreEzXsnenHebsK4mZ6SIahg75kgCRKU388ulqTG2Zj1cIzUvE+Pe4tNowiAYfCd
    lv5E1CZrbWVxrDMliwsQ2svdk1jmMsmnD3iAEV9dJdEL7adYrGbtgfBgTeBoKiaynK51Al
    T6EOUE1l4Ma6i6dyArK6oc60Dccocj/S5+kGE/WuvrWp+WuZyZJG2g+K7u4WCV+WLOqajn
    +CE9w8axvCOzHZfx9OsL/2Iq3U/GDi6J1jWScWrH16kVDcxWwt43i3c0TDV+B1vxdEN2jB
    e+r59s7kToAxAC8AFxMCjXr75ixSszMSotnnkwsvSYEoHIMrMYa6OI9FOr5Q
X-ME-Proxy: <xmx:N2I5aruE0mbop5voZOCB649Nyb9pdjBkRec-MsfwUPku7U4MzxWsHw>
    <xmx:N2I5atNUvNdNJNOaT2qZwo_hcDkV0-sRlVKtTHMgPqaxyIx2os-lfw>
    <xmx:N2I5aq7OGcv-b4duoRTEmKFn11-GtZrdoQZ_n7eyUUhRVgZJ0NZzAg>
    <xmx:N2I5arTKHSR86MSCeHFucWAdY4yiwSsgxhrqOfMMyihw_dbURP_SdQ>
    <xmx:N2I5arc0aYgjKxlVSEASAVurWWoobHgBEtO3g1PqpIAmEf5sxOFhfO_A>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jun 2026 12:26:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org,  Jeff King
 <peff@peff.net>,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 0/4] pack-objects: support bitmaps and delta-islands
 with `--path-walk`
In-Reply-To: <b6ed816c-030b-400a-9fb6-6671fd3cb0b0@gmail.com> (Derrick
	Stolee's message of "Mon, 22 Jun 2026 09:36:02 -0400")
References: <cover.1779923907.git.me@ttaylorr.com>
	<cover.1782082975.git.me@ttaylorr.com> <xmqqmrwn3u4x.fsf@gitster.g>
	<b6ed816c-030b-400a-9fb6-6671fd3cb0b0@gmail.com>
Date: Mon, 22 Jun 2026 09:26:29 -0700
Message-ID: <xmqqwlvq1qyy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

> On 6/22/2026 3:35 AM, Junio C Hamano wrote:
>> Taylor Blau <me@ttaylorr.com> writes:
>
>>> Outside of the above, the series is functionally unchanged.
>>>
>>> Thanks in advance for another look.
>>>
>>> Taylor Blau (4):
>>>   t/perf: drop p5311's lookup-table permutation
>>>   pack-objects: support reachability bitmaps with `--path-walk`
>>>   pack-objects: extract `record_tree_depth()` helper
>>>   pack-objects: support `--delta-islands` with `--path-walk`
>> 
>> Very cleanly implemented.  I am not confident that I have followed
>> the detailed logic around delta islands in the last step but the
>> earlier three patches looked trivially good.
> I've been happy with the code, subject to the new data that is presented
> with this version confirming the expected performance benefits. I also
> lack confidence in the delta islands features, but based on my weak
> understanding it looks correct. I believe that Taylor has the right
> expertise here to make up for my lack of context.

Thanks.  Let me mark the topic for 'next' then.
