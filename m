Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EC2429004
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 19:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790798070; cv=none; b=TZJVAwEH98fZSIN8L8S9tp4UEQj5MpFerDTp2p+JFLfcORoOMSgkyXxb83kiL/7rPYkFYkIk8ok4JJy6pxgv4LsmGONmooiaByZ6MsekEWIapSACnlJ5735FChd+zgh4GUhpmua1nUzc0kRvN7wdvlVkLy0jNWcXdU0/5UCfH7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790798070; c=relaxed/simple;
	bh=ZvmYbcu0e6lU4iyCOYMq2k8f595F67EFONdSKOvqEE8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n7FZnioybSTDk80O3JxQJqo9noVRCBHdPT75f2AXndKT2wJX6aQeqnYj+nxBpcz3BQsx0YOOW6mE/c+tm32S/MKww+nueuoiOOAvGerT1yS/xy6D2ohPYL0Y9MZDkt37pJS4LYhRsQsJCo4T5Y03u8//4BorkHkC033yVJ6DY5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Q6/Ql7RF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tLdYfRgo; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q6/Ql7RF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tLdYfRgo"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5AD901400090;
	Wed, 30 Sep 2026 15:54:28 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 30 Sep 2026 15:54:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790798068; x=1790884468; bh=7BUBDfGner
	bU269fMdlE8zWYsqrkH6ml5+VdYLQzOMI=; b=Q6/Ql7RF57uBkpgV5KkL7Yj/gk
	kE00FOJmIwQJEqSTXUy8e+Rw2da+MSwa2rJNejPwZE23i2HZ2DZzmCyevm/2LvkP
	kxJySq1/yB+jv90dEsPCFTyY0xjcp0hUTZ2bBfEP4hIwFw8i4MZ4T/3JVpKxITa3
	FxWGglbb/+PNLAbK6LxWurlUN7eceMhTS+zDxpDWVgj+r4GxJ7t+5r/Jk/RqbWpe
	VKVOFJsBdmaR6SJ7KZSd4F2qm9UCAbkuCuix8qqR7xOjUrzfgWIxBxLjmSqKM/mP
	Bf+qPbf/o4M2m4Cl5N97AGkA+v8EE0ZGdbrKyNt+Pb+fAbCwbddeNZCYNRJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790798068; x=1790884468; bh=7BUBDfGnerbU269fMdlE8zWYsqrkH6ml5+V
	dYLQzOMI=; b=tLdYfRgoUmMfKzacLawu3FilrzX14jV4uEIHE4Z4Lv7Z4znKxno
	C1hNgqyMW1JkTGWDkcsCXcg6zPdDR14XUFtujzclK94zoEW57WDxpYK9k/ARKeve
	/ieq0gXjHloFjwsPv6II8zkUwFfPt20+5BHr0f62kryro5MfQwHlx+9tIBbKxsUb
	wzAHWzuB7rN7Pyxxx+SggvJF4hseqVFnLSkh6gjSHoni6nMZloadfoy5GxpglRbo
	QUkSK6gZPSqLIIuXBIUKeAV1iv68mHvidus+phbLkm6xBtw9DOjwxESbIqrlCJWj
	KoufTfXfHhzmbfdxEGUJ8Y+nMJjutn02GcQ==
X-ME-Sender: <xms:9Gi9amf_rIQkXCADPibpzdlMqyWmXYwmoAld7dJLXoS79XHS9NNl7A>
    <xme:9Gi9ahtztDWjOuiyCLAAPKowaTOkH98IHfY3q8RFOTFP5oPm32yoxtEt0mkT4IKM7
    OOMmzpnOuyzG24cVV3eDHGgjcN6Hsa2HUkOU20ju3mIqbhvqcW0iw>
X-ME-Received: <xmr:9Gi9ankBObkHgM8puePnlkDHZgNcsjrJk5_Netf0uA0fps015T2l6w6bgj31bSvlbKKfC2ZIpKaG8UZNvCd_9S3it9Kk4_sFWhzF>
X-ME-Proxy-Cause: dmFkZTEcANJvkeGbCWkmxMjqBoe0itZicu2NtDBjHF3Bc13dtda+Pz2vUiN85bBixZeZbf
    q5bQhygRl1hoII6m0uTkUS9fBAELT7qc9bdjvA/DIpUjYfRmbGLZ9Y14mA1sfYGMOh9vE1
    Eli2T5oWDT+MPLLUgNP/LkQTH9HkcdKI0ncFfGfsZ+ioGeBK1k2er9i9T57Us+ed4eCKMc
    KAE2czCNZ0qD6kUIGoS6ZX2LjRozFgUnDzzp9k8FE61qIRIqdXeEPLZUkOTjClBtR/Mn8s
    v7h1m+J/Llvfvt6w0gxLOWEH1tFq8nk7xyaieMgSqdTMR2AwOZUPowRYfRFel/ylAlIxaG
    bKCl6Gh1jfh983J9G1M6CXtE79nA7DYdy8ojdMB4rvxLoUlIsGrLyK2EWGCsSuPomhVovm
    e0akT1b25ucbUofZWK6W10Z4OLDxBPPHHQtVMnvZN9G8Lrom3BAsT5m4WsjZZP2xSa801H
    QJlmnxqs4mEaM1aoEcoc6Hl89lXtMaefAdrObIuufJUdzhaUXLXI8ofivTaLIa5QLhc/du
    wrakNDQL88WRmutdqgngyt7Jk76Ff7aFuVE7jTOrTlLRekaantzB59s0DGzbQl7vpYL3Yc
    AVB8FCJT2UJKr1aldMSxWREZJ6kPFoXFHBrkgaCU8pNEVdAm+ufEgswGxB5g
X-ME-Proxy: <xmx:9Gi9ajywIGKz7oAdS_GZUCT1LtqI2jOV1KR44IfBeH-i8XBzhgNFbg>
    <xmx:9Gi9apM5yvuhWBZYZXN15LRPuz0W1RNcvJ02Ee0EayXhff77GU_0rQ>
    <xmx:9Gi9avrWyWmtmFdvpODwrgKBb_Lxi9rm_iZnaSBDEyIF7C6DC9XUHA>
    <xmx:9Gi9aiF_UKUS-65EVrbfoUIRxdYvBqp0qZ1daJu6AY059xxN0ygPBw>
    <xmx:9Gi9ardN7f9mTN3prQvi0oHYGTUAPkd6UVJiIdEiSIS6xm4iBMiWcPro>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 15:54:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Josh McKinney
 <git-bugs@lists.joshka.net>
Subject: Re: [PATCH 1/3] date: add helpers to convert between "+HHMM"
 timezones and minutes
In-Reply-To: <CAOLa=ZQRDVL2Djh4du1zWGg_ABZTyzaWDYYb0PDg3EXAfpn7bA@mail.gmail.com>
	(Karthik Nayak's message of "Wed, 30 Sep 2026 04:47:02 -0700")
References: <20260929-pks-reftables-fix-timezone-format-v1-0-3df105a95ed1@pks.im>
	<20260929-pks-reftables-fix-timezone-format-v1-1-3df105a95ed1@pks.im>
	<CAOLa=ZQRDVL2Djh4du1zWGg_ABZTyzaWDYYb0PDg3EXAfpn7bA@mail.gmail.com>
Date: Wed, 30 Sep 2026 12:54:26 -0700
Message-ID: <xmqqa4oya51p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

>> -	int minutes;
>> +	int minutes = tz < 0 ? -tz : tz;
>
> This is the part which we could skip as we're C99 compliant, but keeping
> to be on the safe side.
>
>> +	minutes = (minutes / 100) * 60 + (minutes % 100);
>> +	return tz < 0 ? -minutes : minutes;
>> +}

I was wondering exactly the same thing yesterday.

As written, it is clear even to those unfamiliar with the C89/C99
signed division rules, because we deal only with non-negative
numbers, which is a plus.  The fewer things readers need to worry
about, the better.


>>  	offset /= 60; /* in minutes */
>> -	offset = (offset % 60) + ((offset / 60) * 100);
>> -	return offset * eastwest;
>> +	return minutes_to_tz(offset * eastwest);
>
> While mathematically it's the same, but shouldn't this have been
> `minutes_to_tz(offset) * eastwest`?

The way you suggest is more faithful rewrite of the original.

Thanks.
