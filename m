Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E7F19AD89
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 14:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753972208; cv=none; b=LKyrprRn4B5ZkiMpiXJqPT04WXolmvvyfkjnO/N0HTAe1QEe7/BlAT7QnYt2QROeS37fXrFJAckp+52SK7V+F/MQ02UgkPVj21Nw5+Bdak2onpE3PsGwv7rzBitYrtolc5hyPyzIdD4Vqo9P9F1twgvtwkiB/hYsuDzfXtyOzjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753972208; c=relaxed/simple;
	bh=y+oEADY82I1jrG3BLeSmoXtl6xRSY6FxOep1Bw/mLyI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fEaxOI6YgI6f1kj+fhjmfZAQa7o1WefjPX/s+abN5HJ8HWh4upE/JILkKtehcyzQ+3lxWjfzsQqPZX/hKfzQ/puqLiFoF3gQpRj0uLH3NxIWgwVBE3QZZE8cgrFxFMHylqVF4g8hdd6rHV8PCLCYjz/rKTmR3U/KVjUDWAiBq00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Fw+Dl25A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fFShy49J; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Fw+Dl25A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fFShy49J"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7A04B7A23B0;
	Thu, 31 Jul 2025 10:30:04 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Thu, 31 Jul 2025 10:30:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753972204;
	 x=1754058604; bh=y8ocCYV/1LdrkDjcsyPmrUfoy5jEaoafUiU6cjTf4c4=; b=
	Fw+Dl25ADSenyjely/Psgg9mD2bhob7hC9IfDEsjn1cQSCTtz3Y/SXEOpCSsWKbG
	C2NL4HBH/T75pbArxsLD11CuNXHpanjOHtARW/OlKxdMTCiL3h0p8oBmTPeMUfWM
	uh+f1Wt+NQW0a0p/6np7ED5JlmvkljgG38xMICLT++0vlWQPHTXPKoQ7pvKsoDcw
	dgPdgTeFM7dVNJ9IWdOw1grIuAfGKVLYRv96Alf3e4QRbj1bbtEZtsBNnE7NB2dM
	sSP/WT0+FQznBTjlcREXfiCXCbpV5tuzJJ6ILDwm3oUzn4Z+XEVo24QHNXdg4SKU
	BYY4HXgEhF/BlVl8gy7UrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1753972204; x=
	1754058604; bh=y8ocCYV/1LdrkDjcsyPmrUfoy5jEaoafUiU6cjTf4c4=; b=f
	FShy49Jn+ENGUQE/9QZUlioBqxVL0UQkJHEIQ6ztY5rTIyQdG8NP1zDPuqfAROiQ
	Y5kUx2RPzMCQ/SJGjbH+mnNCjjuU6dEjVVmoluxjF/14K9OUJhjCVwF33z5GFkn/
	gG5N0KkAvdkfAy1LWJ3lUsKBAd4iEg3oyYTefqoAZCG+M6+GzmU2voVKxnIM2f/O
	Ewv7MJ60P214JJz0YwlmO88KWRJ8O5UATSZOe4lq2/3uKJjTOygu05Z4N1iHqqo+
	yfFdFZjhGREWCRKY1AcbGo003718m2w1B4FJUxdlX8jrqnSZPt/PogvFNtxXksAv
	9JQhogsEAHq8QMhfSRuCA==
X-ME-Sender: <xms:7H2LaMRTwqZ_VbDqjPMIOR_xEtRm3c1LNGb6k_62gcWQzQTCpMtwXQ>
    <xme:7H2LaNDKLf0fc8dzlyYB2pnKj0XRCcSkiBZ51aEIU3bRpM-fhrd_SulkTjMz98YIX
    TMicEP-3-LyQGmVaw>
X-ME-Received: <xmr:7H2LaDS-QDHg6HfsYEGTeTTIey4PsoRQ-XYsGgDkNH55Mc5eSXvEPRfGDVCURmipfYE-hLtZOTUDS8C9barp_B_Iryida4JFYhE3aMc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddutdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:7H2LaLovxf3CdDlqfO1VLWBg7qUa6mgvrs1JcuhFBOtl6jNDiw6ogQ>
    <xmx:7H2LaFzv34tTxkFrytfOLlm2F7Bi60y8tv9TiH2oPgbO6d7DdOU3ZA>
    <xmx:7H2LaAKcCJ6DN0cPB1ouKyDfAJHBMIp2lqnFCxYj29kr--TKZPIbwA>
    <xmx:7H2LaHL52vZOyHnJ6d3avSWZ7KYfLw2r6fEn-2AF_T8yE3-YhCMKKQ>
    <xmx:7H2LaFrjLfilwHcUe95nYLyXWJMidvBOxm1CHevK3fq1HO51778kGWSl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 10:30:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 9/9] sub-process: do not use strbuf_split*()
In-Reply-To: <CAP8UFD2qAOhRN=b9PB_eXQS1PntZKX95ZK=V4G=10n3iU2xtbw@mail.gmail.com>
	(Christian Couder's message of "Thu, 31 Jul 2025 10:50:50 +0200")
References: <20250731074154.2835370-1-gitster@pobox.com>
	<20250731074154.2835370-10-gitster@pobox.com>
	<CAP8UFD2qAOhRN=b9PB_eXQS1PntZKX95ZK=V4G=10n3iU2xtbw@mail.gmail.com>
Date: Thu, 31 Jul 2025 07:30:01 -0700
Message-ID: <xmqqikj8touu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Christian Couder <christian.couder@gmail.com> writes:

> On Thu, Jul 31, 2025 at 9:44 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> The code to read status from subprocess reads one packet line and
>> tries to find "status=<foo>".  It is way overkill to split the line
>> into an array of two strbufs to extract <foo>.
>>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>  sub-process.c | 16 +++++++---------
>>  1 file changed, 7 insertions(+), 9 deletions(-)
>>
>> diff --git a/sub-process.c b/sub-process.c
>> index 1daf5a9752..de3235c15a 100644
>> --- a/sub-process.c
>> +++ b/sub-process.c
>> @@ -5,6 +5,7 @@
>>  #include "sub-process.h"
>>  #include "sigchain.h"
>>  #include "pkt-line.h"
>> +#include "string-list.h"
>
> Is this needed? It looks like skip_prefix() (not any string_list
> function) is used instead of strbuf_split_str().

Yes, as you suspected, I initially rewrote strbuf_split*() with
string_list_split*(), but then realized there is no need to split
the string into tokens in the first place.

Will remove the unused include.
Thanks for carefully reading.
