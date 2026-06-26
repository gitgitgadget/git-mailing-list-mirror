Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0D92D5C7A
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 15:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782487260; cv=none; b=dm2W/212CfA5Dyvvs2+oNwOr+uIqazu3qrVtKyKbx/aHcm664+4WDc2GFRPQTbBkDC68j//zYw2RsE0BaFOUhF89+lpA6+OTUAVA8U3emuVJVykfqTYm6KJxR10cyLV66duIVEOhFVI2uNSSauf/aRUSIjeitXo3bzgqgXR8mlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782487260; c=relaxed/simple;
	bh=NrS+Zj++c76a6PTYaoSxJO9L1g6fPqMG15oi+9cbXkM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=euzcq/7fs23A5w46ekIIR/v3geGc4UmESbz/dD8w7I8rcij5Df+GCXbmXo6PHSE7nvNeA4xzGVF5GEPyiuT60gT9nZ7NapGj3JNZptwDWRXPRmffsmvVh5uUwVOfPyx3ta0xgxONyNKkrgYoBsIuPCpoLoleamg5/jV1D1m3vEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aKQhgK1j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ALEhW24A; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aKQhgK1j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ALEhW24A"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id D3B961D00123;
	Fri, 26 Jun 2026 11:20:57 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 26 Jun 2026 11:20:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782487257; x=1782573657; bh=0h9HtB4Qp6
	55Bqu8CWuN+VTjwdLEIcaXHvPR3YLYl88=; b=aKQhgK1j9A43czWlepLO91lG52
	v6baRyrm3rXR5gw1ary4RNkuORHBILPv/FdLt1xECAm5KQyUnAl4UYIHkSNO32w1
	qX5njCBTb0JnYExJ3Lz9SL8aBlWsawLoCI6nm6udzgTAKunvjfz/dYuJDxvQ5TPu
	Zx+NF+eyqlfD8b7R2ZpjNiWPI5G0UQY4cYSTyTA8q0BboWSLVd8gEP35UnljCsat
	HL5HvTgHaAgTrG5pBXoTW0BHNph0R9/fo78ILjbZXTMqrj1D4g0VOwpX4IeJ4S7l
	yLXCkEM6tIOSxk2mzCFdns8anYZPTdi7yjyV9419ldVEU/aolUMMNdofWnfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782487257; x=1782573657; bh=0h9HtB4Qp655Bqu8CWuN+VTjwdLEIcaXHvP
	R3YLYl88=; b=ALEhW24ALCUe1s9X/DA7yFDseI59j8lmPcMV+0koyGBQQloJR/y
	tWrrroizI4Ic+Bjl3SaBnca2Ffzavioean4g6Q30VLIcDdNJc7B1Nd4/LUQjVMKw
	1mSua1C81mlaNz3lhMiJltP3lOWOgF9lW9e5A/7plo8bAlzkvvi+JHaVYNDwLRGR
	xcnzTZBH26WBlM6hK8ds4rbz5yU9ZDJgkNyKxS5TQyNDhddVYNyZ3ROxH/Eh2Xbb
	Ab1CS7zh/qR6Dly86kvPFSIn1Y4EAeN/eW9I6eOgQE2X4btBOhu5x4UCidE5I3cN
	g0FDjCdoZGqn+IHYsQSwEDEJZpzfhUldbUg==
X-ME-Sender: <xms:2Zg-atvX-6sYePYKiegXqX7BA5QEpqkSIzYDYzuF69IUVupA1CkYuA>
    <xme:2Zg-aqLrfl2777LBk6dhKGvvok9vmmN6y0MPBedi2TDteyAqVeIqdaGD76Smi3Y7Y
    xbJkwBeH3QuOEMyicf82OEv_IIkfPR5JOa9EDS0LrKIacsDlF-MWg>
X-ME-Received: <xmr:2Zg-aqk62dQemjrjz2KCuS3--LpFtdoE05qO1fqO-gbmEJEhNXcuWUFA9hROe5NW5qihoop51Q7dGcpt2EXVNUkVOTWqPQsXp_I85Rw>
X-ME-Proxy-Cause: dmFkZTGh1tMcOQPQ0/feEdNrZdF0LVBjJsa69UikE5QuIkOmVgRjJrVuHoxCvhWAIAGR6R
    Yi2dvFToVzGNg6uCVyshNc8lJ6NOVL7n8EB6rhqFsFORQ0ZkdwLdF3G4MTQpsecXUV7sll
    wDumWpyRZG37agjTlGtEhnPOL/pUAP9jiAGA4eCTq34SsaVADOZs2SdDrnhgPQoH3I++ns
    gHM1eJlELPauheD7M2T+tXYkELB9SWDwl3whB7uBE1X6RyoefjaZ43S36G80JFOJZkBKvZ
    JhZoEfOQV02lAHZc9m4NP0ugRtlv/Hmszh7N5/dLAUPYF+hObFgwBb1+6nmrWKpCR+FCYY
    kSgtAih21by7SUGU9P1F727nSViDf+L50+T/YOGriyf0YOYH1yrVkgA8xa/PWtkRhyfTVt
    /PGeobFkqaNVgjyhHxlC6gSgDo4T7Lne3N5Abj883a9BWl1Y/aKgsXT2nFBjlzzVjZCc7B
    zQYKYBmJptl9xs7ivmlA4JVo9W6qxOoklVgTRNcBu6yCiJSArt38ij3g2rTR4hqfuSCnHO
    5qIj14LwsKdXgxmBVm2dq4CSTOzldNjIJbMwSghv6KAtmqCrtAD5Go5xTna0y1F9vqPlDY
    XYBYnmSeYr5ML1XyD9Bz7h5Ds/NKpmHeCvLW7boVYjFjdfZzy4aNCfPtvYxg
X-ME-Proxy: <xmx:2Zg-arI_61CshKDkZeYUb2Kgfgvu62vsGSkb6i9VK14hsWDoblUg0g>
    <xmx:2Zg-av7Z8UlMKzstaslwM3FFGr-9Jl0mErSBsAu4dBPiWldvxzsX-g>
    <xmx:2Zg-av0jLI9E7Nmgs25ecaDT_DYnVce2TmqXg8vFSUh2g_paMeRt-Q>
    <xmx:2Zg-alcXZT-y1Uosc5OZ4Avs9GGk4vOHWtxgtlYsVu4lzEbFETAHaw>
    <xmx:2Zg-aqfJMVngBWRYJru40cFWceEAyUHFkz_U0Ftys7X2WIYhaksnMdvU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Jun 2026 11:20:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Karthik Nayak
 <karthik.188@gmail.com>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 00/11] refs: fix "onbranch" conditions
In-Reply-To: <xmqqse6ae45i.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	25 Jun 2026 13:50:01 -0700")
References: <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-0-56c864b01c43@pks.im>
	<20260625-b4-pks-refs-avoid-chdir-notify-reparent-v6-0-41fbca3cf5e3@pks.im>
	<aj1DuUzusBUqmF_C@denethor> <xmqqse6ae45i.fsf@gitster.g>
Date: Fri, 26 Jun 2026 08:20:55 -0700
Message-ID: <xmqqmrwh9vl4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Justin Tobler <jltobler@gmail.com> writes:
>
>> On 26/06/25 11:19AM, Patrick Steinhardt wrote:
>>> Changes in v6:
>>>   - Drop redundant condition when setting the default for
>>>     "core.logallrefupdates".
>>>   - Leave breakcrumb for why we lazy-load write options for the "files"
>>>     backend.
>>>   - Fix commit message typo.
>>
>> Thanks. This version of the series looks good to me.
>>
>> -Justin
>
> Thanks, both.  Let's call it ready for 'next' then.

Ah, before I forget, as the focus of the topic shifted dramatically
between v4 and v5, I think we should rename it to something like
'ps/refs-onbranch-fixes' to reflect the fact that is no longer is
about chdir-notify-parent but to fix "onbranch" chicken-and-egg
situation.
