Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE14288C17
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 18:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748974959; cv=none; b=UXGKUGa88/ltZ5wsVntm3jTStd5+qnfksMGghM2OGWRbNUMErw08wiqJ/v8ZW4GKg5/Cokb1lu6Qql5SXrSMm6/4CPAtiRDQZqH7fnLPlAT7mNAkMwt6oJqCmllkUgYS3rpXcFUNwNHOuZUBb6RfzXbbrWQSz0KrrqRR/tshtW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748974959; c=relaxed/simple;
	bh=PHjlpDKvQcjZlCZvsRGfRZDB5Grg4oMdyz2AhftvjUw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fKGQI+6Cj8kZs96srL2o/A7HjlFkb6PRWj0CfxghCBqkoUkDWF1eqBCJ0nomrbrZ6fjfq/zA44gw8U9EtCmcAKBpOhaFvZUeuCO0zZ9UTW2ThI0xGlqfYlGBXTafEWsIMqFvEd8wmQpGsUg1QDeHIMVdwoJ5Wk/3I/TSatQ32Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=S+g6JxrI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IYuu1M6G; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="S+g6JxrI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IYuu1M6G"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id EA50B138031B;
	Tue,  3 Jun 2025 14:22:36 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 03 Jun 2025 14:22:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1748974956;
	 x=1749061356; bh=W3/zxBM54HhmGV7a5LxROrpoZYHTn6TXXzS1xqdmlTs=; b=
	S+g6JxrI/yy0iYqYn9h8Y9H7ju3esfNnRjfn4zgXO9UDqOjRbxlbRpkZuR33K0tA
	KoWWDauNH4p397YORRq2zCbuk363tJKXsxTIkUMplbmkw7BCW944/opC6TmRMyCz
	2BUoszdat+C3AtFhKqHlnHof9ahdcKmqSoAk8fpmESwLRvBAWpvAFWkDYBWcEr1t
	SAHHSNwfES/RXqQN12AStsBww9TFK5FnofBOrUhWurNK6Vd5If5BMSueahI29XYY
	B0e4DwyJ6t1Ehd7noXW4M8NYT/Fhpc8SSmDboIdqZL2VM8/CSXTPr1zQpBu3xs6m
	npKzVxODYLAbjOYQiEvQfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748974956; x=
	1749061356; bh=W3/zxBM54HhmGV7a5LxROrpoZYHTn6TXXzS1xqdmlTs=; b=I
	Yuu1M6G7qksWAK8J3rTpuYiDmfSF8n+9vpSsQxuzBHBXY0qMaUmN5Qgyla+Tc+jc
	senDh5aLBYHaebVbvDKi7vd79O8tWulRIY+Lxmcw85vh1M1G28KdCi0dnZKSTyhz
	WzSoqnncISTw2/bbR6S+IPhIQ54cAoVleJCjjfaGk5y/gDI9vw6UQe8oUiMrCQsy
	1GfO+q2T5jjuPyxdd8ZLxXJo3fextFBe8/ftRTtvlgcO0mPj2hmjFDfJPY+Ghnii
	69AlhccQEYanM6acDnLC8PdXa20ig5+rQ8p39bNdMjOM4kg1cjwpW/looDY4MbOw
	wApk+8IujAj9HS49Xzbrw==
X-ME-Sender: <xms:bD0_aGx6GB2h7A_981Owpvxd3O6zilXTMSGhvLuVXsiB7Cl_3H8S-Q>
    <xme:bD0_aCRE7yx40U-Rg_L8NAEHTkBQ4XwbTt28gwtd9xIGPiqfQprrx8DszxztZs5jQ
    ZqsrQN9gXdWYef_SA>
X-ME-Received: <xmr:bD0_aIWzqBlNuB6HJZzlnlgHvbNdNRtZ_gMp19xQdTrHVZg34vuXlfVxtBV4183GaZjgsdhnNHoePOkcPMXJgxlBHz9G05oqRbwo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeen
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfekfeeh
    iefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrrhhksegthhhroh
    hmihhumhdrohhrghdprhgtphhtthhopehtsghovghgihesfigvsgdruggvpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsuhhnshhhih
    hnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepshhtohhlvggvsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:bD0_aMhZnZdyOMl7rHK05niaqARAJmk3oGljNUg1jd5Co0hAy84R6A>
    <xmx:bD0_aICuTF1i4IFs40Iip6Gjphs3sWBJQ4d9DD1oQll8ZbqDojXESQ>
    <xmx:bD0_aNLoU_0-fLk8zCnlVX9WSvzPYHZc0kcMEOt-Vv-eDdfu71edzw>
    <xmx:bD0_aPBeHHD0MvVfS5PFOm4HpFuReDvWq9YkkJQuh0s_5bD850YujA>
    <xmx:bD0_aBa2HKJokcYi9MKfkoTvQnxZOlxGePclQDApEK78Y9hqc2w2FhWN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jun 2025 14:22:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mark Mentovai <mark@chromium.org>
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,  Git Development
 <git@vger.kernel.org>,  Eric Sunshine <sunshine@sunshineco.com>,  Derrick
 Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2] t: run tests from a normalized working directory
In-Reply-To: <08b9b990-9ddc-740e-99ab-82d09fb30ef3@chromium.org> (Mark
	Mentovai's message of "Tue, 3 Jun 2025 09:15:54 -0400 (EDT)")
References: <20250523193722.68344-1-mark@chromium.org>
	<20250528201737.55268-1-mark@chromium.org>
	<20250528230804.GA16856@tb-raspi4> <xmqqfrgmhep3.fsf@gitster.g>
	<20250531054618.GA30443@tb-raspi4> <xmqqcybnxvr2.fsf@gitster.g>
	<f0d4c85a-b833-c52d-b54f-77ab81f22451@chromium.org>
	<xmqqy0u9subw.fsf@gitster.g> <20250603050256.GA9449@tb-raspi4>
	<08b9b990-9ddc-740e-99ab-82d09fb30ef3@chromium.org>
Date: Tue, 03 Jun 2025 11:22:35 -0700
Message-ID: <xmqq4iwwk7mc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Mark Mentovai <mark@chromium.org> writes:

> Torsten Bögershausen wrote:
>> On Mon, Jun 02, 2025 at 02:32:35PM -0700, Junio C Hamano wrote:
>>> ...
>>> Yes.  You need to specify what you are canonicalizing to, and once
>>> you are going to do so, there is no need for that heavy verb, i.e.
>>> you do not need to say "canonicalize it to realpath"---you say "turn
>>> it into realpath" and you convey what you want to say just fine.
>>>
>> Re-reading the help for realpath() and pwd, would this makes sense:
>> t: run tests from an absolute pathname
> ...
> Making a path absolute is a different transformation than what is at
> issue here. You may have been misled by the fact that pwd -P and
> realpath both make paths absolute in addition to performing symbolic
> link resolution. The latter is what's operative here.
>
> As I've explained, the paths in question are already absolute in git's
> test suite today, even without the proposed change. It's not correct
> to summarize the change as making paths absolute, when that's neither
> changing nor the crux of the problem.

Absolutely ;-)

"normalized" does invite "normalize to what standard" question, but
as you mentioned in an earlier post, "realpath" is a bit dense for
those who don't read realpath(3) manual pages, and "symlink-resolved
file path" is quite mouthful even though it might be understandable.

Let me merge it down with the commit title as-is and then cook it in
'next' during the -rc period.

Thanks.
