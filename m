Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD723451B5
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 20:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782420608; cv=none; b=ChsD+O47WEzQpXcuA9llSx3vIRMomNr9gZHSTbHhgclFnA8fXIbvMc/9fgFSul+MeGhg9bWOpnNTRalTR67B2QQkBy2wxGVEdj3PIkSAS1k7ob9C9rZp8WhNMv/5caszOMepKln5HpX98wzmomQlN010j3IKYAFSPHabPACcWYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782420608; c=relaxed/simple;
	bh=PoX+hlTAEd5YA6chUzIB2TiN1+tx7YtnE7N+wogOSpA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uSJbAiyj9CgIfWnk4VcUc4Y89qojPy/GniZBMfZ3lasyJXUNUkvJyrWjci931TupHSLanUvS5qq+B1kIbjfWk93ruT381DRBE8iYot3fnuGvr6Z6NbHhInNMKdaHL3b57jyVSyJcz/V962aFe1/87nPIAycsHrrsFVrGq588J8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KnNo0mOr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JO5UYpVn; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KnNo0mOr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JO5UYpVn"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 8CD41EC02B6;
	Thu, 25 Jun 2026 16:50:06 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 25 Jun 2026 16:50:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782420606; x=1782507006; bh=6DJVUq3oWe
	gMfmLoroeNGY+pIUhkZoLjvN8iPe3+FcE=; b=KnNo0mOrDLvE+kdhWNAEARoCtV
	SzWUtE8BV7uqnWTkHdE0JFOdAmRPt/huzIWU/2Oc0iiL8XbHNY/MkPq7OMIEwMIy
	L0FU6ZZGuXHlQN7UGsVuF5UfbRwvwfzA16wzEchFDieys9WUSCqET26JuX2WdSGb
	uW0ISnuGARrmaQwTjOhxZMMjb5Bjpg/XcbLvOXvREcdWZTYBeUdgqqdFaK7WEqMJ
	Ra0JVhPQ2bNVQbR414jSUnDeLNIBRgu0nLdFZTPfKQPMmZwNXFfqK4Dw701TJ8EH
	IZ3pa6howyQRZVBJANbvuH1ucuUZYtsPU/HgLD9bcff1JhMDSu1/Hcb5F07A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782420606; x=1782507006; bh=6DJVUq3oWegMfmLoroeNGY+pIUhkZoLjvN8
	iPe3+FcE=; b=JO5UYpVna5414hpSVlOQfdSchPd4wRnZI/0aXyaHkIPAN7ExK8e
	K17hA0qQ1NN/APlpwOHh9OIK98Tf9Q4KIEdXd2yf1VktQe+RabUI1XWLYeqeAMQ9
	B6GedSmMb6d6ozRWIfqz23g4pKDGSkLajWJX9iPW4Cm3FpXNameFzM1EEuOPZxAq
	SoGTMwLtPcdlqY1TRtlPYiCzO5m/KDTDnOqLmETiX6Gfos5FrgnztYxmkxKM8Qzl
	K+y6EyrKlZa+jPrZkaKSdDQ1j2ctSPkJbNUibvoc6d+tsPZc9NxoUoZ5FpdJxF8s
	aDEYR2J07wr3/fy3s7zv/9VUBqPRFqMFgGA==
X-ME-Sender: <xms:fpQ9ajzWwkou3KmnrzUFaW0A-6L6VwpIKv_jFez-yJiKl1DLcAn93g>
    <xme:fpQ9au9gMGD5YpRn2lrGZrAL8osVr8AWbVOKZFBCiMQzD3li49WEX1v1NcJq1s_BE
    42HZU_LdU58YpcUuKAkmNYLBFhNNVnJ_thPsmSfV4B7m_B-W_jzHw>
X-ME-Received: <xmr:fpQ9anJax1Itm_w06T_9hisN7N-5U99WCXimuO_OOKMDSHbPXdo1dRfk7EB9zEK9ZARat-qy9wNyqez9SLKiCr7hf8lAbaeARubNWe8>
X-ME-Proxy-Cause: dmFkZTEzSsQgY2BeKTR5gpX0VLBBW/TIFOl5Uw/34DwNMq3TCbHdpFC7XRm+rN3Cnb7IF2
    QdNaaQR35g1f4vwWubgImq1poWykoYQOXTI+2wVR4z1bbD+r1T1kUXtfLU0VVRdI9lo24O
    ixXi9V/ILpHA1bRJa9XpEtSZ4oAjTDOq89n1SwmVB/m0TfxjGBUz+y9cmuUDChMt5RPJci
    NVzNrjJgjY3Z38FGZeVivaPg5iKZ6zucJhzAK4Az6nPHNtzT1wgEJYvp25fQQxYfS1sKRn
    Pre3RXF88rZeJ2+QxQ+30wcy3tUGFEdaSoq9BtVpVOrVnFnMB/Mm4rXo12Yswfwu/KByas
    IokNjaY9GC8tWw7ugujvNW02ciPmn1wU7w0uOHGLl4Ihha+ghEai+pbBnjYpyPivR7XiQR
    qGDmGX6d6mvnFawJbyIjcgKrkyuasuIg9SyPK/iqGEL+ooEsWElooB4OxNzQlVlvIDtX5S
    FrYft2NnQBySEquQBFVlpt10UWrljRGhMObS2wjgNPPmjmY6SPOnGmlBKUf2ChSy545XND
    g/a8Nl/2GeMiV8UOZuIpaNBf9T2NllhtGt40CXlVLzhROfkv8KyHTtMI77f6qA/JCCfYt/
    wRCGsYWn6C+AT52Gvt5yMuOeXIjah5FoCLbhSp6im4Ig+l/cUS987UfvDHHw
X-ME-Proxy: <xmx:fpQ9akdeKXsHCgzExb2hmOMXJYP87_5F6LAgMnS3DAapEgcaBzTUbg>
    <xmx:fpQ9am-9On2X3TkqsLEERrb_ecNqyiclNNGxZdNbewXi0yhNgLQqjg>
    <xmx:fpQ9ahqBuIs1v1rvz07xjxPQnYmSQsWxyQaMqcBpNvpZiNVkAVzEow>
    <xmx:fpQ9arDKjN8PsSXuKLuQcepVDZae4sInWvdE1Y38QZw-1qB_0rWQjA>
    <xmx:fpQ9anhJrr-vITizd0ZR13Xc3FtphDurZbquHBphFvRnw2Txe05eUmoK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jun 2026 16:50:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Karthik Nayak
 <karthik.188@gmail.com>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 00/11] refs: fix "onbranch" conditions
In-Reply-To: <aj1DuUzusBUqmF_C@denethor> (Justin Tobler's message of "Thu, 25
	Jun 2026 10:06:47 -0500")
References: <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-0-56c864b01c43@pks.im>
	<20260625-b4-pks-refs-avoid-chdir-notify-reparent-v6-0-41fbca3cf5e3@pks.im>
	<aj1DuUzusBUqmF_C@denethor>
Date: Thu, 25 Jun 2026 13:50:01 -0700
Message-ID: <xmqqse6ae45i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> On 26/06/25 11:19AM, Patrick Steinhardt wrote:
>> Changes in v6:
>>   - Drop redundant condition when setting the default for
>>     "core.logallrefupdates".
>>   - Leave breakcrumb for why we lazy-load write options for the "files"
>>     backend.
>>   - Fix commit message typo.
>
> Thanks. This version of the series looks good to me.
>
> -Justin

Thanks, both.  Let's call it ready for 'next' then.
