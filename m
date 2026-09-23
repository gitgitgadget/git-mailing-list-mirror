Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F0F2F60CC
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 17:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790185517; cv=none; b=RgzEeJ+Ln8G0qyw1cvS6KOhfdssvlV2DYrVVlOZzBO5tMcJnWO95DpsJxrNYWoEUWXFQDdlX3rv1dG5f2eLDSfopBD5+9VtezUTA2TpGsGDU4U0lj8ohw07Ma08ZMUAY9426rEWqKVzI+5JTv0wxsWgtjJ1VgA26L8L0B9SbVDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790185517; c=relaxed/simple;
	bh=LN7HTjJppl0aVQaL2+jIyw6kWPiWuzE5x0MquHgr7Eg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G75kMcDdNwCBiVunisGKwvL9MZMrMIjtv5AQG88RhuDwXleB4cXxEOlM5fJmeyeAy2SOo/LYxSZafRrTZzrL7myDdGXS3DcMlR/CPlZ2r7gO8Z8sK9pLRrMJq0sss63xm+1tbjXoDUUjwwma0RgvmehDPd1idfABelYL+F2wFMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=m8qJQzfY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gLKFSute; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="m8qJQzfY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gLKFSute"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D48EF7A009B;
	Wed, 23 Sep 2026 13:45:15 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 23 Sep 2026 13:45:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790185515; x=1790271915; bh=Gbze3XhZjz
	PrFiKJz02K/STQftBcw6VajPqTZEX/x4A=; b=m8qJQzfYm2ftdZcuVMXLd8KvUj
	NfV4xeRp8ysfKm/OYsqlWetbmQfiB+I8XQ+1XAG91UvFWOSJdd9ZZPLUYbTOl/6e
	Y8ydVBWE9QZJpIIVBvuS5RzEHzI84htQXDsMvN9Kyx3/yb66FuC2wb2AFAZEPWb9
	0HeKt6OpnrCqWTLKfAKgzUW8qsoi0+TJNdpawLsJrXxYH9CHjv73mRCldmSyF/dq
	Deu9cbHi3r1o/iuJ1a/lK+hNrr6VmBZhotaNFeKxH+4SC3F1uEh+mIWmu/w+fWna
	TDwN11iz6pz0BdQAon3OKHLAg331hMxJE/GTAFy5MXzQsEtom4W4kBzQKIPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790185515; x=1790271915; bh=Gbze3XhZjzPrFiKJz02K/STQftBcw6VajPq
	TZEX/x4A=; b=gLKFSute22YsNy59XEF696V08lA7aOx++OJWYmBrgiISHdEnS5/
	+/7895pFSIeAT/k+Q3h7AEZTxvKVNItczzIjGyfNJp0dSOWZYbHwSpUImdYbtINh
	UEXyIvgd7nNO/DMdyPGklg/0f5S9h2KBmrl6yMLS+GpfD5RjAt5QM/DF2czdFIDA
	YrKy3zKvyvtaw4lyw5HPqWKtDU/Si8V/xClhJFeSivB6e5bAG8GDkoQUGETbUotn
	BA7cmd9zNf/k21nYgwgpH1ubdXqnUHhI2E274zUhhLWXoOWc7ScBwvdbnGz48JCk
	qXwfR6BMvoxHlqPXI68u+5OczukfMxXBcRA==
X-ME-Sender: <xms:KxC0ah2GcQfkbVe7jgn2i8UbfbGwbSk-MgA5jGI13K-WekPrrjEoYg>
    <xme:KxC0arxpAepJjsYyhOzmj5uTEHUhoNayQ_SDykT7SRHZmBmssb1lneYaS_oLp0QYY
    Pi6fuV-tzyIiioXxLDMUDzJtxpDSLqSCGjjoynL-iBcA04GxcwTusE>
X-ME-Received: <xmr:KxC0artHrLE0RvI7JMMYuaBqM6W5MOcU4Xu0PpNEiSp4tc-9gDxmxgym7e9Hgrkb1JW0OOnYCP3qROeu4zG3vM3cwLc6Bb96rSPE>
X-ME-Proxy-Cause: dmFkZTEaI/KWtInpt5MPrPhi3zWsUdwWlzR0s1Md7TDtr2skA18wEoe+3w9pD6RHgMfiOw
    n6/MfhdGAZnMqSahAOJsZidyJ6Yqz5lrweMAbCZ39TWlVS3Y6tcLupstNhdXRo6LPkYr7g
    xmqaRVlOf/f6kOzBN3co9VQ9MpNalYLL2Uue5Ht3HvMDy7pUkcIRIFNtGh5nSNvq23t8EM
    kpDkbeFxsHam4DL9tDWS3IzloZbKdzb2gRQx4nHonJbxgMgu+J2GRknLdQSnOI58xngzL9
    gAmLxJJHY4zBqkkLRy3OVK2SYw57WVabuPyxQl9A99qxDAz/ZEgKcnvUpyLkKvO0soAMo6
    +v43fc64jJc/cCtwZ+U2oB9XVhZSEzm+G4v0bqC+NKTvRinTOMVh8NRhGpArp/zw8lNQy/
    SacKnvs5pWj7NFUkUlyC5ZmdQYihEYaSnF9jLYti92vHbCn4HpFrc0INYe7r5wDiFUyFRt
    unGbIO1RaKffpyUR18/DYLQrZ9cy2+SIg6/FHPRqf6vLL8wmAt1ueqJmWk8LqE/N5Hy+k6
    mIwQlCPOyQPYTYtZh0ZZ1wKWCUwwogXKteNXCy8MxJ9qJFwgS7gYgFxuNT/o6tQO0rtkKZ
    iTxJYhtlwvaV87SEryCJajuQnOqtzOkdrpdSFPLzSgbXzTm2DOUKFyLDDfkA
X-ME-Proxy: <xmx:KxC0alz8HZ31gyr-w6C6WItqVV0F5jBb16yTqkhFMy5DC0ICR1USIQ>
    <xmx:KxC0amDqxKm8NuZYoLfp2d-xe5bQqFZkDV7XTX_ZuXaUzng_ccA_gw>
    <xmx:KxC0arcpGhNKvXdfW9L4MoSkwjzXO9CL61cm0K4xojfOy19XR53tjg>
    <xmx:KxC0aomjWtjJ83QlS5g4kFk0RoczlhqbiEkoa2rCGD5vTJ_OyE_Edg>
    <xmx:KxC0aprg47wxmGQ08ehcDKnnR-3rFZkhoIeD7dnHhOdFKpgvdz58EDXZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Sep 2026 13:45:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Qin ShiCheng <qeesung@live.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Taylor Blau
 <ttaylorr@openai.com>,  Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 2/5] pack-objects: reset kept-pack cache for cruft walk
In-Reply-To: <SJ0PR84MB2993BE38DCAD2ECA5159EC24DD822@SJ0PR84MB2993.NAMPRD84.PROD.OUTLOOK.COM>
	(Qin ShiCheng's message of "Wed, 23 Sep 2026 11:08:00 +0800")
References: <pull.2219.v2.git.1789700615.gitgitgadget@gmail.com>
	<77aec8941f5d17654f58956c7c643b47dd5a8d93.1789700615.git.gitgitgadget@gmail.com>
	<xmqqjyocdijn.fsf@gitster.g>
	<SJ0PR84MB2993BE38DCAD2ECA5159EC24DD822@SJ0PR84MB2993.NAMPRD84.PROD.OUTLOOK.COM>
Date: Wed, 23 Sep 2026 10:45:13 -0700
Message-ID: <xmqqcxu3c15i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Qin ShiCheng <qeesung@live.com> writes:

> This does not make the code work with another backend -- nothing
> around it would either -- but pack-objects no longer gains a new
> dependency on the files backend, and the downcast sits with the
> others that will have to move together.

OK.

>> Do we need a similar
>> rearchitecting of the code here, pushing details like packfile
>> management down to the files backend layer, before we can properly
>> fix this?
>
> I hope not. Without this patch, a cruft repack with an expiration
> drops objects ...

Ah, I think you misunderstood.

By fix "this" I meant fixing "the layering violation" and not what
your topic originally wanted to achieve.  And as we agreed above,
these downcasts that sit together with existing ones need to move in
order to avoid layering violation, which is what I meant by
"rearchitecting".  Until that happens, layering violation is left
unfixed, but addressing the kept pack cache issue with layering
violation can be better than not addressing the issue at all.

In any case, my original question to experts

>> This question is primarily meant for folks who are pushing different
>> ODB backends, but I am not sure this is safe in the long term.

still stands.  I think we between two of us agreed the answer is "no
it is not safe in the long term", but others may have ideas to solve
it more cleanly, hopefully.

Thanks.

