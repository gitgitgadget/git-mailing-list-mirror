Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF8B41F34F
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 14:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784212142; cv=none; b=iVddz6+YIVRKmisvvbEvEdNHSKY9Ee6wJnpLj70QKfIdL7o5W+vUuFasSXQB7XjfTjdLmD/HY0EDR/+8Nu9S5vnNvfBkkTgLVQMS+fCD2Q89N1KM2l5UBKgUSqb9NgCBsMC1GpiTU+Zh6XiYCgkvVRwFNbQpwgQ5Sp3hPqBoDPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784212142; c=relaxed/simple;
	bh=pw79ZQoZiLtEj4b5JKlEDSGM1T3TzHu6yEBQPM1JXG8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kHHkRzU79aC6kQNVG/77OFWGW9clnPgV9LRioYmr/DY8V4g/wOPpjwmOX5wQua/klVZSy6OfBeP8+XVpokEbvABUkkqEMJTMbuc7ONwPqumUyevKxxAI5sfgA6c4szKWeK7tWXNsG0JzAByzLGID0RE6A3jhniPwYpIrRiXZOPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=emyiHhL1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WOuuyPRX; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="emyiHhL1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WOuuyPRX"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F378214000CA;
	Thu, 16 Jul 2026 10:28:59 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 16 Jul 2026 10:28:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784212139;
	 x=1784298539; bh=Ss9fIeMQe2RmIVg8WCFKmmQkQq2rwADPMlwx7w9cjiM=; b=
	emyiHhL1pjEKnctx9Zgue2sGFmtTMh3uDfpqchhis79SM6k8JbDwlEMWYGo4Vsr8
	121BS43oxkYxfd+7v4mq5y1f8TZK5eppfzZKh1eNKz/eFBL8xXukPhvGG6Daol15
	LKSu/2BVdU6LUeClWnnyziOTQPf3kATg7L3SIXDxTKlrFgFT6QG1pjAa5mezBfHa
	Urlj3L6bxlxaQxLyyYLSOZBk3mU9sSqQnj1KaNG0owT8I+LGBfXRUSULqpMvr0uP
	kej2xXh6NOAaSo+OinzApVRjs7BBg0WfL1dTDaPW1BoKjs3JhvDo/5nt55Ayxig5
	otG6ecjFKu7rYQHK8F/DMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784212139; x=
	1784298539; bh=Ss9fIeMQe2RmIVg8WCFKmmQkQq2rwADPMlwx7w9cjiM=; b=W
	OuuyPRXBI/Qj7ohRvBTbxLVyaqPu2YlX6eF08WmsUzODbwLEOObDLsWPv3X128F4
	KcXTWfGQowCseWxSOmC8sFUypGwvvDTbrE4KkaEJg1nJ5o/96AM6m6D5qaYpSLBD
	noQXa0VpClKIR3NqPlHGposFB9t3gC2mNqbeQgcT9Qia0MxtEmB4AHoNE9aYNNad
	gnFHCaEpVopFaoh1/USNwkeEVayk/nG3keYFdnNNNPwuRM2WsQiUPY4cz/DPEXvP
	LatdJ94/rxznA7xxIA9YxFcQMFIe2JgB0fKnRS87Y61pt//JAgoQvWyd2wxu5nEo
	6i0Q5Y/1te7bsmQdv1Ykg==
X-ME-Sender: <xms:q-pYasH-M506JNgmkdPnDweqIPF8pQ3LgxsD158fVx8exGEpl9jKMg>
    <xme:q-pYasWeH0GIBa7EAHfQFTycrCSYvK-zc7kMgO5SknA2breCRFAAlu0k5YB2G7Ssf
    iAzkn8lagwz2zG3U8KLfvKE9MDAncdsOgkO6gAWx1cpKfMEewp19Q>
X-ME-Received: <xmr:q-pYarKlocTt3z8I8sY8ZAuI0rl3yKDQ5uXhyZnKDZT_US7iXJdS085_kXynjHx-nr_v5Hg9RRfStlWhH9hshbLXUaW6ARR8vBiQFXE>
X-ME-Proxy-Cause: dmFkZTFyD/tNQABRydfrq7nMlh/16j05yEOoMWbAgiqI3/GQ694Em6i8Ibd4jtjGuGpt+w
    y9H/HVVVyoZkRLoFGOJLesC2xfDcx5a4pkUDOlerP/s2QCja9JW9Urlyw35RxS0P3xgmGE
    el/CaYDWaKl6XIzG9uFEMjbjgYsJctfuPuJB7l2c+lV5VD80OlAQh7rnbBOhC65iefvT6l
    SOPYuiS2cYvu/cHRk0GlV2GcWroWCgd/6s8mOuTexbhyS1jkrOVmOSRLhMrbxLdL8hYrlB
    KfA6CmU+xjix1Yg8sI8BR+gha79Ne/TQ5GEkHEdWzgJj0iTeUlPNCsUhoGhVrtdzHwLbCt
    2G/ZO7DCe/CQrXDGBEv5fj/S8BJXI/CAX6ZdOAGWzQfciyxTx9XlsX5uoMFOxmEf+/l6ip
    xLjqQfs3H9p07AFnTJrjxmI4KBbcnNT9ylne6uuTMaZPDLfpYNFrtjOc7woYU7m8Y4IWhO
    zEf0kf1xbtvJhIpV19B58A7a6pIrZEsJDxAWJwyHDg6ayvDzI6zh2okcK8mernlVgtwUVR
    edNFp3BTFhhJ7VUKWUoO3adJUhmaHn5gfJfizCzc+EoFjPQW0iOEMjG/StAfJS1Pfn+AFY
    GefeGE7Alr0pxVeSXvPKtz6lPqI+cx/NhLuW+7/Nm1eAbscFXwRlsO8LmCrg
X-ME-Proxy: <xmx:q-pYas-G6eiX71Z_9ASCIJbllIjBENN16lIO0UJOUCQuGeklfzhP-Q>
    <xmx:q-pYauKVoXCKJ0xJRyirnGB1gfDbIUYVXhgx5woqFBhRIxjQYEgzCg>
    <xmx:q-pYahkrZJiFRPb-8kxR06xd3TfQsoYOA9cyWzfPpw8qYAl0khx_IA>
    <xmx:q-pYaiPjVdK3ufC42mFGnUyPiqPQmgSRFpLixhIXiwW06bB_BXUcqw>
    <xmx:q-pYamFyAODpP5KNrJUMbLO1NoJKSiVPoSA2ig9iYBi7yN8__Gm0YChj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 10:28:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Git List
 <git@vger.kernel.org>
Subject: Re: [PATCH] remote-curl: simplify passing of push specs
In-Reply-To: <alhr2bb0lUTHtvjO@pks.im> (Patrick Steinhardt's message of "Thu,
	16 Jul 2026 07:27:53 +0200")
References: <935883f3-3be4-4c51-9711-5208b9ef9ca1@web.de>
	<alcrhGUCVMCnm2-i@pks.im>
	<3b29757e-abcd-4235-a829-ea67c19e71d0@web.de>
	<alhr2bb0lUTHtvjO@pks.im>
Date: Thu, 16 Jul 2026 07:28:58 -0700
Message-ID: <xmqqpl0nhutx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Jul 15, 2026 at 05:39:51PM +0200, René Scharfe wrote:
>> > 
>> We could add one.  Not sure it would make a measurable difference; if
>> the number of specs is huge there are probably other costs that dwarf
>> pushing them to a strvec.
>
> Yeah, I don't expect it to make a difference here, either. But by having
> it we could use it in more places going forward, and that might lead to
> tiny savings here and there that ultimately add up. So it'd be nudging
> folks to "do the right thing".

That's a sensible thought.

>> I have to admit that the simplicity of strvec_pushv() nudged me towards
>> using a NULL-terminated array here, though.  So just having a
>> strvec_pushvec() available could guide towards using the length-limited
>> strvec instead of a simpler NULL-terminated array (which explodes if
>> left unterminated).
>
> And that's not a huge issue by itself. I think the version you have here
> is totally fine, and I won't insist on a reroll. But I think it gives us
> a good opportunity to improve the status quo, if we want to take it.

Yeah, strvec_pushvec() might be a worthwhile thing to do, but that
can come independent of this topic.  The output from:

    $ git grep -n -e strvec_pushv\(

is easy enough to look through to find which callers pass a strvec
as the second parameter.  It should be quite straightforward to find
conversion candidates once the helper is actually implemented.  It
might even be possible to use Coccinelle for such a conversion.

