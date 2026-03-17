Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C68179A3
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 00:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773708443; cv=none; b=ZNj3I2FeQJPXhqI/9Qi5rS66ETD0ILtfkJtK5Xv28Ldo2iUN+Wh1qjSW2pQ7snH8bQXnpdRqHfVJ7ZimeeySg/34ScOhVoBQVcTEfeJn7xNBnl6IoNqCdb26hHtdpqmaL5F+zRr0TDv/fQsz+t27Zfv5Kxj5LrteebWB0yGsG9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773708443; c=relaxed/simple;
	bh=vdXnqgDXVt8ncNbY5qg63fbjj27JY0ztbXN1DKmu81k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DNBsC5i8Xwbxepd5za6U9haTSqUiimtxZ5cXBs8s9pm5EStkv5kNjxkcjGjqj+QxtwSSkvj/GE8A0ux3xNXhTCTvi2O1PkUYS5yILL+invjjlI4jHz4ByPAFa3CVyD/WvldrJWRwby8T8R4YoOyj4u3rcj0mtKp+AUqzZlWD4yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hMFWZLEy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=10CuwpZJ; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hMFWZLEy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="10CuwpZJ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 3A1B41D00067;
	Mon, 16 Mar 2026 20:47:21 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 16 Mar 2026 20:47:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773708441; x=1773794841; bh=hizo0jubQf
	3AS0fRm3KDELE3TGEKBLCbSvVKHarFS7A=; b=hMFWZLEyB7HD55wG3+LGStkKyM
	D5U5yCdCetVuujj567EHG5OZqD1/ezbtL9czEglGWrK9ZfsjnRblbGlky1dJ2emq
	0RWYcXZMDEC1I8+O4Uz0BAjMcx+D4IfFISZi2fk+iUhfVjfiP7VwnqNXdOnl4M7U
	iC0WXjlTt384kaAgu3GmqiGKRro8FM9jZhPOe96jq0TvGgpWpm1oxMl8fvXkb9dg
	4BztLhotebwykkr+cn/62uVVmuH/lN414wBH2tM+sV0q5vpOlUFK4IiBYkqtsoKg
	iHOdEnfC34ljRrzDyqtIa83Osdc6+1m7kjZq552+U+fXgaEzBMKSA+NUTRFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773708441; x=1773794841; bh=hizo0jubQf3AS0fRm3KDELE3TGEKBLCbSvV
	KHarFS7A=; b=10CuwpZJuKWmiNOh+BcfCoLNeUy7Udrmgm5YhRjHS7mfLmh8w/a
	OyT8nJXD1ebxeIP9Y3ht9ynGR1B5oZzgGUIU2XXuJFD5c3juApx0HEwEgUY+tDNX
	HeTLxk+xMZJb7mKkVfa78oNN1prcMymty8LsJ3pa+fqcLcFNnfh/Dj5/UlvKEhxL
	OqYu0jDNchg8upCQahoBcC16aGrHMr2BTj+L77I6LaQ8kIKjH3uB6/yhQOKV8FmK
	S8sCa8DYr4T0avmtWTTPpPGp5Bzo3b0XXuy8dodHfp4U+s+n06fCeinmxhuIgNn6
	pjAoR+CmQKEtcb1P6TKVXnjMU/hPUXENQTw==
X-ME-Sender: <xms:mKS4aTlUXC1kgc_vDelkXsZulBr0MXqBtiDwjNY8zIAjPcSWiF__sQ>
    <xme:mKS4ad3StbnysR_z2iredJ_eBymugxIbYPmhtBzHL1F-0vVxV0ysUos6wXGQy58HV
    lWMjLwoJE5vhMjmkfbU7evQHYooRk4Pns8AJqKUPwmpfaNLIQvoHg>
X-ME-Received: <xmr:mKS4aepjg-WnaMwxPQQ9pW9fasNUDb1goW8oMoBayM3GBKVxLf1tzMYua12RkRBLrRhK5LVrlLRZSv5EjMVqDKG08zWlWpwzbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleelkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsrghnuggr
    lhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgv
    thdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:mKS4aafUjaXQm8rLfpQlZ928710lF5SeGZ0S9bymoDQEZYdiJyCCEw>
    <xmx:mKS4adrKpnP5HSnJ9lrFzvynlu9DcpbfERA6t2SlIKg-anPWUuEgqw>
    <xmx:mKS4abGI0nPRTLISuOVmpZdwo36EzBn2ZEDMm4QXR8Uc0G2hlP3qFw>
    <xmx:mKS4adtMioCxxw7vSaa8PHuJ-bg9Ce1wTjV48kqFGcdiQMNNj5Y8kg>
    <xmx:maS4aUr-OV7_dcqLI2me8O7qQ3OuwBcxOadB_9RUs2schERNg2FsNusS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Mar 2026 20:47:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH] rev-parse: have --parseopt callers exit 0 on --help
In-Reply-To: <20260316220742.1286157-1-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Mon, 16 Mar 2026 22:07:42 +0000")
References: <abYCxrEEPaI21g3H@fruit.crustytoothpaste.net>
	<20260316220742.1286157-1-sandals@crustytoothpaste.net>
Date: Mon, 16 Mar 2026 17:47:19 -0700
Message-ID: <xmqqcy13mgdk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  parse-options.c               | 2 +-
>  t/t1502-rev-parse-parseopt.sh | 9 +++++++--
>  t/t1502/optionspec-neg.help   | 1 +
>  t/t1502/optionspec.help       | 1 +
>  4 files changed, 10 insertions(+), 3 deletions(-)

Has t1517 passed for you?

Queued directly on top of v2.53.0, I am seeing:

>>>>>
expecting success of 1517.169 ''git instaweb -h' outside a repository':
                test_expect_code 129 nongit git $cmd -h >usage &&
                test_grep "[Uu]sage: git $cmd " usage

test_expect_code: command exited with 0, we wanted 129 nongit git instaweb -h
not ok 169 - 'git instaweb -h' outside a repository
<<<<<

