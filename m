Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710E65381E
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 17:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728668971; cv=none; b=ikrMizvq/jj5dkh413GfTCzAAXxjuqvZ7hoP38+4CClM+NjwivM6IOBTuiyMlVHXjqMEHWb96m+7Q9hXmJCQkyfjLGIK/7YdgclmpA0T2JrDDfBUmqX+xaT5DyIbhk87/jUk8baHahmsoive1k7h9L5vw29XPjpPbrftC98bNLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728668971; c=relaxed/simple;
	bh=YEX3DVb2395X07zJb7BhnoMpd6hxqC0KrS/WC3xsyYI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DFPzq/V3A4bul2cskdSPONBz4sScLuZYM5NqN1tjX0LZY5aFbFwphuFaZLFcYSinyoTANRwXj4jOn+cSeYonOhjagnmxBG5154Ck2DrRu8y+srN3cNqZe9uoZK7aHaddMQ+mbFv9VH8ENz5WsNq+Kt7Mw/YCQ/gBb3xWYXzCfpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=wjotx1NN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=irUpRTKE; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="wjotx1NN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="irUpRTKE"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 94B881140207;
	Fri, 11 Oct 2024 13:49:28 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Fri, 11 Oct 2024 13:49:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728668968; x=1728755368; bh=YEX3DVb239
	5X07zJb7BhnoMpd6hxqC0KrS/WC3xsyYI=; b=wjotx1NNlCtbpnHGOz39uzBOXD
	Hf2PFYUTBBZIPWG0janFsRjwq3r+bIXaXIOY6q4mvjFXVeG4Buur0dh/yJ0LVmfk
	Ky9FTye4K47BUy4Dji3W1n3rOjEhmts0bCMhYTXwpGm0z/gUlSGWULCJYr1AoZSH
	kr7EvZuSpNA1o1KkAHkK3hydStFO2Nk+MvqjFlFAcm7uLNZoejjAdmMDk7CeoVYf
	L+z6cGjrCH9NrAfBnjfGXnk9WkES6+DX+1/PBQyLU8N8pxzIadj/T6plHpgSIj12
	9b66edMyx7N62VZhrEiegxH1HlbDE5sOeePinLkemN7dVI8O/rCM7A3/wetw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728668968; x=1728755368; bh=YEX3DVb2395X07zJb7BhnoMpd6hx
	qC0KrS/WC3xsyYI=; b=irUpRTKEOi7FaYy3Ui8VaRXxp+tIvcWNNfTMqTY1tOz4
	7Iv3OlyvLsyBpC4XP0e5eNaWqGynd7B+b+1ODH7FoCc65Yl7XzuBCf22EgTF/AU5
	+2sMC9PkHrGF1jXA08iHmYoBizxnyzAXYCNaVZIDjtA5gBrP0pg6b4tT+gg/AYfh
	x1fXwwpG9+ZVTzHrvNisbUaCA9qRTRjKrdJvk/n9WTUW9zXJLl2X7D/xJwg+TNM3
	i3tRdE81rk2vCR/wvUg8kHa8H0kG3R+ngZh4MfAdDYfJjJU9E99P5lJzZ/iNUVtd
	+kFeJNqv9UeclQN6SvyhdDePlU7012FVyxJV2QF8ag==
X-ME-Sender: <xms:KGUJZ2WtY7afPqJPLhivJXWShosUqijiDdGia-dNLSoQVzbI3Yp5LA>
    <xme:KGUJZymuS-1x9VmrVuEkzqFattqmO1VH6gwXGXILnOKCwyApPofNR8lhdRvkvl25W
    8-F4EAT6NUjMeeAog>
X-ME-Received: <xmr:KGUJZ6ZV3hpMd6hP692UnQGTlv9e8LyixB000eeru-tMt3ztDnsADt46DwG-0ST5G1aWicrOON3-RGTzJysqFMLSPf49OokBpDjK-ug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefkedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlh
    horhhrrdgtohhmpdhrtghpthhtohepshgthhgrtghonhesghhmrghilhdrtghomhdprhgt
    phhtthhopehnrghsrghmuhhffhhinhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:KGUJZ9UHiV8fPcJkmXCyPxWW6_mx4wzgL3cQ9Mi0FLQ43WrrTtq7lQ>
    <xmx:KGUJZwl4AfUO4V-K5TNQ-XbSyb_G6kBvjlji94xglmsMPn2SFB3pvg>
    <xmx:KGUJZyfOqppwoVOrlc21-fCTWS8fhcBYGi4GDyk9jlA3BZsV5JHJkA>
    <xmx:KGUJZyFigqAxnDLGlF35zzyw-adAPqjemP9fMh9THq2pV36c7a0nQg>
    <xmx:KGUJZ_sAx-cbOlfE8AQaDufJ5HuOXEUF_lkU1I-wSh7DWc3pLEF5lI19>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Oct 2024 13:49:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Scott Chacon <schacon@gmail.com>,  Emily Shaffer
 <nasamuffin@google.com>,  Git List <git@vger.kernel.org>
Subject: Re: Interest in a Git meetup in Bay Area, California?
In-Reply-To: <ZwlLgJ6e5aWQKJgm@nand.local> (Taylor Blau's message of "Fri, 11
	Oct 2024 12:00:00 -0400")
References: <CAJoAoZ=UyfDjAvG0-kC++R7fpR871Gsi4crR=o5F3PvNfB=7Uw@mail.gmail.com>
	<CAP2yMaJc8ZDiyZrxym-azUpkUOCTjLWEkv6gO_hJ1TqU==Bdcg@mail.gmail.com>
	<ZwlLgJ6e5aWQKJgm@nand.local>
Date: Fri, 11 Oct 2024 10:49:27 -0700
Message-ID: <xmqq4j5ifs2g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> On Thu, Oct 10, 2024 at 08:53:18AM +0200, Scott Chacon wrote:
>> Or, what also might be interesting is to do one in the evening on Mon
>> Oct 28th, as there will be a lot of people in town for GitHub
>> Universe.
>
> I'll be in town for that, and it would be a lot of fun to meet up with
> some CA-local Git folks while I'm there, too.

I may be interested if I were nearby, but unfortunately I won't.
I'll be back online at the end of the month, but not in California.
