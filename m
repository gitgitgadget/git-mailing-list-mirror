Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F7B1A6814
	for <git@vger.kernel.org>; Sun,  6 Sep 2026 00:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788655529; cv=none; b=WyJLQvUKup2gxEdSQUPWRyhRlMyUTkh8SAPpCvAP1Qlm8V37EDub8qORXo5wYc63mGE7Aom2z5xllTFjSayfTtzM4MCWaRdl7FKZm4KKCXFI5AWjvpQby2BCwPP4NXX4UWHsvOBkHi5u/Ph1+UV8FOgaIW+4D1ryY7M+SQ08zzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788655529; c=relaxed/simple;
	bh=fYIacR52KZlWmmJBqv2i/+R5xBUzr5WgroC6EtFKtuI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QNapZVqTO2HWMscRMztOkQCqcFJdkJ2BCp+sa74rpgp1J2UE20YRhTKN92Wf/JekLzKDwf6k67JVtQzY7Bg7/kGaiBGhy1dnwTUNPmCaaXC9RwZmS5dLMYbrpTPqVdiM/qtjTtHzVRi+EQqxqM/kkIR5eL1/ka+Q1sPXdie1P/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vZDZRIb0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TBniOolL; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vZDZRIb0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TBniOolL"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id D1B4AEC0014;
	Sat,  5 Sep 2026 20:45:26 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Sat, 05 Sep 2026 20:45:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788655526; x=1788741926; bh=a/9eEBzPCu
	2l6kC+mm5wy3Y4VecUF96ad/NPZWoGy7E=; b=vZDZRIb0eFUS3ChCcvNjoQG3U2
	/9BYFYzjjM6coZQ/RpHQiJgT8Z5ItYyPbTKljgNZ2BsCFqizqKdhSR0xlU7wlQJx
	0kVV3g+gfxuauuqyKW10YMxgcru1hjXnfCZuTH8GI9ZAZzn0cq6SL7BWigjEk8Jp
	JTRPxqVq0ArxufBh9Fs3Q6MN2wXZqFiXkWXWkEhzpKoc68+jdw+Pcz8NFMIHKYKR
	5msAMvUW3TcsYrfNJmhFnhwQHQxBf3c1gWk7zcVKtP5IlA3Fw9sV7cNgSutcvmLl
	S57NH71Bsjo7k7sJS5N9LcAz+mykx2Nv2S+1W7Wrx+xqxhQBxD1G2ML4qUVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788655526; x=1788741926; bh=a/9eEBzPCu2l6kC+mm5wy3Y4VecUF96ad/N
	PZWoGy7E=; b=TBniOolLbZvUcTgP0TYOp+2oOVcRQNZw2eO9onx3qSW3qANCkZo
	wQaehpW4gM6uusBSFQnaXlVEw6O0Xcyw4aorxj4XBzuhf0OUmkxNj+IW5MVr9ojf
	p5NDaKrsJV/+pjsogz85Xf6P3zpEqhB2/la328o0SKLqhYQEd7tnVAr9rkr32KbW
	Qw8s5phZTLS7EGABaLJL6xFqmjhQxgTliQiaGDWhUwOYNcBunVbifn+8gepmnd/y
	oCXjXD25J0yw8d2DeTis7AYjRZ4CNx4ShOdcC1vZuKUXiPTQ9r1lcjaL2lS2PGWp
	6cBxab2jrFawKUbP6mfkt7CgoykMfZ2O5ew==
X-ME-Sender: <xms:precajsiXnnlsf1lXbVPhAbgZE-oVtVmIhT0n1uwtFRDmxMKChHiKw>
    <xme:precar6MC6ol6MCOx9Uu7XD4kdtAo_mH5LsSKmcveXs6ft2I4g6xxUOnDYjGxo22R
    H0CH-KpHG65w60b7585GzQeL9MDIcmKz_uKCzfB-B-IHlbJCP60eNc>
X-ME-Received: <xmr:precakKpA3-7ykvoym39kG8_1SrjI-eyS95f_D3ky8iqic98N6vVx-ScOS3nCs20kk13NP5dcPZOamoYQHy3Q0ShJrt-B7GltlO9>
X-ME-Proxy-Cause: dmFkZTE0DxKWoQHbvMQHeqH1qu44G0XElrdDJEuOgr9LokD8mCy0ee6LurQ4v8GoPK52TO
    HnSmlhhGw7aQmTq7p6GTWu3uHISSzf0ajL+eYAq0XW9KZHGG25K9KgIvB9KQES2u7CuIGN
    bjb2ATBqZH1EYWomAGypzMCRro52AF1vQgZvQJhwuDSiJEHC1kAfX+yBIs1HqQDOl/eeoO
    REFXmFwZHX3vPE/FphTuGCkzrhjbjDmpqRUyLiFVUBxGA/Wnp9Ik1pmTYnUUsWSuBwuTGA
    nWO8+A/bh8adv+2uzBpVj7yDGq8ZcjKfXys1RQMGapotbJZN3M9wQbFCk0YHWo8+u1WeKL
    FWlYTCV/mDLHl7ssOIxnp0+o5t7ojW9OjUPKKjYGWJPCwzIYUL4HE6D4dvCbJbXVJY69BI
    gQTlKgo7RC2Ym5n5bUXjVx3dKu7mhVHmzY3h2GeVZepINB68u3QGX6NLqyHlMxhJgDi51C
    Aij6OXRp3QzAJE3iw44QtuyL2iIGwtivB0L3HNoVc7eJU4LO2sxzFhRIdPiICrc4molqMU
    4zgzliFhrqkWuDZ/EkIYzKuYD7bKRQTYjjQv+w27GJH19K3R9xuHjunRzMw6nCCEXNYof4
    iOUFQyiXiLgypBlBQZpdu2wx1kK0m1irhRvrxakBpjya4E9NxDUbhusTLtUQ
X-ME-Proxy: <xmx:precar7gQoy8QJtzzcPWYdv_no0gdbOKnWyaJHX6F3hiTYS_in-Nfg>
    <xmx:precanzg7Sshi79JkYZLXplVONk1-y-_mXHlaAwL_NdBq6U8GoumiQ>
    <xmx:precavZ92fAFcjH6Boxdd9UAnO9TN-1z2X7qRkenDgdBf_48T9BTug>
    <xmx:precapSvYNQXgwQ0qPpa5uH-K_hEsBLPZUuC5lse_2dlkabZw6elOQ>
    <xmx:precan5Q4-lZdWIucPNFVchym0LZQoKym3NLYQ2-r-401oslsctWGCXf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 5 Sep 2026 20:45:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aleksei Sviridkin <f@lex.la>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] push: fix --force-if-includes when remote-tracking
 ref has no reflog
In-Reply-To: <xmqqzexx58hc.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	04 Sep 2026 08:42:07 -0700")
References: <20260903010547.85469-1-f@lex.la>
	<20260904124433.12840-1-f@lex.la> <xmqqzexx58hc.fsf@gitster.g>
Date: Sat, 05 Sep 2026 17:45:25 -0700
Message-ID: <xmqq33vn5hsq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Aleksei Sviridkin <f@lex.la> writes:
>
>>  static int is_reachable_in_reflog(const char *local, const struct ref *remote)
>>  {
>> -	timestamp_t date;
>> +	timestamp_t date = 0;
>>  	struct commit *commit;
>>  	struct commit **chunk;
>>  	struct check_and_collect_until_cb_data cb;
>
> This gives a known value to the "date" variable, solving the issue
> of using an uninitialized variable.  But how do we know if "0" a
> reasonable fall-back value?  Why is it better than "now" or perhaps
> "2 weeks ago"?

Thinking about it a bit more, let's imagine that we had reflog
enabled and did not have to suffer from this "uninitialized
variable" problem.  Even if the reflog for the remote-tracking
branch were enabled long ago and had plenty of entries, it wouldn't
have any entry older than 90 days, or the value gc.reflogExpire is
set.  Which suggests to me that gc.reflogExpire or 90 days ago would
be a lot more reasonable than year 1970 to use as a fallback cutoff
date.

Thanks.

