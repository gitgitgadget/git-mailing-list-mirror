Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2B916F0E8
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 17:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728495193; cv=none; b=AvSejUxUTpxg+qZbf4FlcJSrd1eH4mDRGmg1WNynWvk1G7KXdB0Bf5Vfw0gjjkZ013QKMqU5LD8VnjFqxzSlCYVrdYsVm7+9AWeX/REXaixusM+6zkQe7pB8Mcai3VDwG3iuWHEF4/HJcClKEAUW6YhnYqyeuVwDAVPdybAPCW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728495193; c=relaxed/simple;
	bh=wCeSGotoFBCyIqonx3kaAOIFqipzPaRjYAcY4+vrW0Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DHKafDUD6NkpLck2voS7HXUG19Jo3QDqjnrxGsfrZuyKlV/eyeWd80fGKbINELKJVDt0uu5pmq0FcjKoOjZOCEdxvAv4t/sYD1EoK5HP9wgESKnF0hvQpMiBFlBLyeeHjXn3PdtCu7w/MG7GVRbLW04FPn8eeLpzK/n3MOchZX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nCG72hjP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iyq3p7MS; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nCG72hjP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iyq3p7MS"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 77DC1138014F;
	Wed,  9 Oct 2024 13:33:11 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Wed, 09 Oct 2024 13:33:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728495191; x=1728581591; bh=b77sO8ZaYp
	1zBmUujLhzCio10GR1udJqKDeEFIGSOfY=; b=nCG72hjPfanBGxZqR4mPG/YZla
	Glu8At5vpGDkBOnAmftdZDsC67Xrjg2KpY3HpseWJ+Hoq78bFl26vvWM3iI1WXUd
	/Q5stxseI43ENTYKr6SGxBZYTYSIGRX8/blaLZhFe5yOoaITQfZaNjNsLfWVrXSU
	wLIUO6tZwWI+t2dJDQl1tcF6Lv3bPjJTginSHVyoHEiYo5HOCg+qIsX0Zjok2F/v
	4hdvSgPZYHaIb/uPP5syTGF4ABq35JhwMm9ZOzyxphXwhKXNs2IKF4r3++TykYnz
	9iYy0emyCFlkYLXnHH+u3U0jCNCEmx4z4WFPJnQxSLEefWnh8Ig0MyYahgdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728495191; x=1728581591; bh=b77sO8ZaYp1zBmUujLhzCio10GR1
	udJqKDeEFIGSOfY=; b=iyq3p7MS/S+gEB+DspcR9gyCm2bdpTgp718FGRZ6XFME
	Y/9+in9dDdcFlUNAPiJwsSrP8CDToh+A5kimjsI1MpAi6CHRdeF5+AlsgSYMzZdH
	P5qvxZQs+xKKQBRH3kirPiQ+nGFqy4uhcHB5IyWboJZs/MA7ZeWWj9DPXRDhyOxJ
	11uZrq8BG8/WloDQQFXTagel2eAB1oxMyDWHdvVAxV3MO1sioxyEBPn9Rb3AYvPp
	j3kENKGRimhdo7vaphozL3GAxF5xqLFD6C1eJGj57vX8KItxmV7/+HLQoLQnSm65
	BeiE6S8y8pK1gXEuLbVnfXPInH2649+nDWFhrCqz0w==
X-ME-Sender: <xms:V74GZ5jgo9BGy-7nChizO_2wblHuY4n_6qvc6w_r1kQcTQeqYKY9zw>
    <xme:V74GZ-BMpTXoHjmI-QBdzyzmX2LAX4kM1G7PyE7B0jfqI4jKWAaOTeStOLLlCzrBF
    BMYY7YKoPaNHV0AVQ>
X-ME-Received: <xmr:V74GZ5FTU3AC81e-y2ons1GT0Xo69B4_SxpHRqAk5ydXrv6pyDUWbfncodrkqiCMWdwHzknyB7BsQpJOrQe9-dRXt0zSk7DwDlN_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlh
    horhhrrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhes
    ghhmgidruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:V74GZ-RGHr0wvVGg_xKkE6lsl9At7xL-Mkj-8q29PmD4LC_khRp_8g>
    <xmx:V74GZ2zLCAgFj1pbFlv6qXoCzKvycvGDMEc7jN0N8jcJDAYhq_V2jg>
    <xmx:V74GZ05B-ALamhhDv-PlEl0FJ5O8woAp30_R0QQvQhYKToLjqYtoRw>
    <xmx:V74GZ7xz5ZiHrQTgMUaNTsXixQ-Yz5xnZs2J-5dtq74ArqboKF487A>
    <xmx:V74GZws-kwtf6ddPcF2EECfqc7Cf-qQUJe3KMbISzY9FjjRq1ZiQOXu7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 13:33:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,  git@vger.kernel.org
Subject: Re: git-scm.com is now a static website
In-Reply-To: <Zwaqy3oh83tuM3m6@nand.local> (Taylor Blau's message of "Wed, 9
	Oct 2024 12:09:47 -0400")
References: <c3e372f6-3035-9e6b-f464-f1feceacaa4b@gmx.de>
	<ZvM65LqtFW8f9uqC@nand.local> <ZvrNmsycmamx2dcR@nand.local>
	<Zwaqy3oh83tuM3m6@nand.local>
Date: Wed, 09 Oct 2024 10:33:09 -0700
Message-ID: <xmqqbjztuqp6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> On Mon, Sep 30, 2024 at 12:11:06PM -0400, Taylor Blau wrote:
>> The only thing that is left is to actually delete the account itself,
>> which can't be done until our last invoice is cleared, which should
>> happen on sometime later today. Our final invoice is $61.86 USD. Once
>> that is cleared, I'll delete the account entirely.
>
> This settled yesterday, and I have deleted our Heroku account. The last
> traces of the old Rails site are now gone for good!

Huge thanks to everybody involved in the effort.  Thanks.
