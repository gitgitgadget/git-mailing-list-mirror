Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A842765D4
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 21:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769461663; cv=none; b=DasmXZmwoefp2ajTg+vKstIV8MCfMFQByaW/M2UVNhDutoAit6hev0pT0jvl9xoUetRAeMBm15iLJxiUbKJewaKZuRSWbTWBEhe77pDnCp+1gBzWsZZ2sN7OAt6eBOHvkGqW9CokdsqISkwJq0Kl71Xzjy8DbgmRennJC/QL1FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769461663; c=relaxed/simple;
	bh=bhPOazzBZwyRE5Ii0hv6eBzjihOKTyGHpUHWxWpWGlI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tqRq5XVdtEwvOJMSPujMecdAZ3ahlx5WB0N2WXaIHnfXGk8EJVTuWp7Wh+sYtBRGqKQEmzWB69Gu/sUr8FC7UKzRycE0zoAt+HV2ZUjHgHmV+R5i8u2jvfUPmdDs+bCdRdVsHJhyziLemVn8VdZCagiSDKNASBbY2srtwKEomGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=a/+BhLz8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MazRE4y6; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="a/+BhLz8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MazRE4y6"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3C36D7A013F;
	Mon, 26 Jan 2026 16:07:41 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Mon, 26 Jan 2026 16:07:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769461661; x=1769548061; bh=lHBfVD8s37
	fjxR5FwDQ/O9NBE4RAwJxBN9B8gdgxHe4=; b=a/+BhLz8N1OX8fD2JwJ7/MtMIb
	4YW+/MWVVGEIteerT/kAVHYWB+3CJfylM5vxoolb7PQTTfY6TXK5yNZmQwDDCDhG
	TA1bdv1cjKv1KWjBqCGB/43NlExc1M6oaCYU7nCA8qaZ1oUdqGIHpunhSu7QgsZS
	GMIqN1LhGTC47Pe5BkGJ43SZZvYWOauOCb/ZopGmpHbaKvU4b5J+9nP8VazBR/g7
	Catsu/3Cd6mRxGjmbnkllGgExPHVn8PV12d+a0MRMysj9CLKtzg5QvIACxrl/8c3
	USed3R06/pq8bTzBT3ubnRcIcxpS160dNeSvENMX5Jd7npOMwHHry/CznYeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769461661; x=1769548061; bh=lHBfVD8s37fjxR5FwDQ/O9NBE4RAwJxBN9B
	8gdgxHe4=; b=MazRE4y6pmhsaPcqHrBHjXo8dxQBT1i10Nbm9uyBv1T0TKd92PX
	Gw2bqdn2X3roLlFJxIFndjF3gfpXCXayYrqEW1lGGEMRpmagitLqEgdm+5jMFMSn
	iEQJcWE/IQoUIxrgd9GmoJY+VpjexGkmm+6MQUTeBiy9gxiTW2fue8vMhjiSAwJh
	CULKE/7kMyUP7GPhqVn/ylTXUNAbzE85pkoX+f7Ep6KLeV5rOYGXy6IE9NSE+32u
	s9GlUaiAbxuEfewd30OSxhf2RnhiyfQnfEcp7AutJPf2IFtrtvIio+4P8ehySAVU
	WrPdRRhOiAbYgfh5ja5LfvMcneJCUUSDOHA==
X-ME-Sender: <xms:nNd3aTDxeRVYOhZiX_RWXnvlLeZNZphQX4l4StE54_fnbrcfaIz4gQ>
    <xme:nNd3aQiSCw9bX9VXyWfi85FQ_cD3Imgez-9Qh1UGH75A3WRD_Wj_pYYXWyNdlLPhg
    R_qlWfcd0P9NegFpHVPYUZkTmzgdOGOXCQRZol2Y29lxucUB5fFoNE>
X-ME-Received: <xmr:nNd3aTlrasrjDLTGrXVFBEmm0KUCLJz36zcJ5fZK_kYJKsJNNyqxaapim_-v3R9Gy66Jh1phfQ56t6jINn023BNIiKl2Nue3dGmxvXo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheekjedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:nNd3aUrrUOs1-9-wXRjcxAXAqGVhY7pNcCdvwDNole4Ux5QNThiSAA>
    <xmx:nNd3aUHgUabufOeFhniXFo3u0NXjqN0qZFkPGpthL-IWANVYzVCDCQ>
    <xmx:nNd3aYwv2chihQM_tn77joiGX9nXiL1i3ZBQIutw2GVPxL0MdtI3WQ>
    <xmx:nNd3aRoaLGq_SvQGfX2tUbmaxmQ2QnhbgwADmHA32hDp4ERhXlmvjg>
    <xmx:ndd3abFyNSkBqbqs_Hxz6uSddKlJB0ZsO6Gks6Z8CQR2mCerThk0lCBr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jan 2026 16:07:40 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 1/3] builtin/backfill: fix flags passed to
 `odb_has_object()`
In-Reply-To: <a5b456dc-2158-4f9a-addd-12fb9f408edf@gmail.com> (Derrick
	Stolee's message of "Mon, 26 Jan 2026 15:17:45 -0500")
References: <20260126-b4-pks-read-object-info-flags-v1-0-e682a003b17c@pks.im>
	<20260126-b4-pks-read-object-info-flags-v1-1-e682a003b17c@pks.im>
	<a5b456dc-2158-4f9a-addd-12fb9f408edf@gmail.com>
Date: Mon, 26 Jan 2026 13:07:39 -0800
Message-ID: <xmqqwm14gk10.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

> On 1/26/2026 7:17 AM, Patrick Steinhardt wrote:
>> The function `fill_missing_blobs()` receives an array of object IDs and
>> verifies for each of them whether the corresponding object exists. If it
>> doesn't exist, we add it to a set of objects and then batch-fetch all of
>> the objects at once.
>> 
>> The check for whether or not we already have the object is broken
>> though: we pass `OBJECT_INFO_FOR_PREFETCH`, but `odb_has_object()`
>> expects us to pass `HAS_OBJECT_*` flags. The flag expands to:
>> 
>>   - `OBJECT_INFO_QUICK`, which asks the object database to not reprepare
>>     in case the object wasn't found. This makes sense, as we'd otherwise
>>     reprepare the object database as many times as we have missing
>>     objects.
>> 
>>   - `OBJECT_INFO_SKIP_FETCH_OBJECT`, which asks the object database to
>>     not fetch the object in case it's missing. Again, this makes sense,
>>     as we want to batch-fetch the objects.
>> 
>> This shows that we indeed want the equivalent of this flag, but of
>> course represented as `HAS_OBJECT_*` flags.
>> 
>> Luckily, the code is already working correctly. The `OBJECT_INFO` flag
>> expands to `(1 << 3) | (1 << 4)`, none of which are valid `HAS_OBJECT`
>> flags. And if no flags are passed, `odb_has_object()` ends up calling
>> `odb_read_object_info_extended()` with exactly the above two flags that
>> we wanted to set in the first place.
>> 
>> Of course, this is pure luck, and this can break any moment. So let's
>> fix this and correct the code to not pass any flags at all.
>
> Absolutely the right fix for this case. Thanks!
>
> -Stolee

Thanks, both.
