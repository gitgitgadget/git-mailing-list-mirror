Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5776912CD96
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 13:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744635856; cv=none; b=Asz14k86MIKt/Rsm/9IkzQffm5Any7YYLcAokdIwLXIIMD/Eyruws8l3nq6wVl5gt01iP2oJRmTR9u4dOBaH6+7ReCpbJ1shkuaLttuHirREp82vQ3lS/tcCwao+GvNz9B1hE9EgFTbygGEc2AHHUUvohs3LsVLUVas9juuOVVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744635856; c=relaxed/simple;
	bh=fyxzHSg5H+oiKZNpSA631D8e/zxjqaQag6BeNkR2530=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FGBUnTyqIU2iu+9lKm8BE+WRuk+NT3egGdNlGy+ymfw+s1PwGge1Ckzs1xlqWFLCZ7E6N/6u/oWLRlweQRSy2T8JuNC+RI1zmebIYOg+Qb5Eob1upE4FC0HcddZzpiDeU3bX4zq51S4grmtB5ZC66IkTYdBnTlbvRzuVB3r2c1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RCt249Kw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=w2qM8edj; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RCt249Kw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="w2qM8edj"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 4C8A31140117;
	Mon, 14 Apr 2025 09:04:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Mon, 14 Apr 2025 09:04:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1744635853;
	 x=1744722253; bh=ccfhkPn+au6yYpzzvf9MRXsGom4Ap/i9WISCO0NNo1U=; b=
	RCt249KwVYXZDCfspkSGYSRNB3ngHmcxnTw+enjRfs5cArdmqbAGnrutzkTh6d8B
	/pPmyoC/V6gpXA/Fpr+13McAyOc08tEMfSoVOhU9XgzlBYO0aszuk9J+TcOWukzr
	46gthikD//S6mYBrjsLIIE87mdYK4/+wbXiRyFVrIVIIg7M5iw318YROznd5mPns
	GxpI4Leox9FoUy5s6CISt6X8H2jsmYRz+IkrZT9sgxChnk5NOcwEKM0UH/xQqLeF
	tou9e+qoA3Mo3CA1UJLvpefA0U/zkx39FhY3+UHV+AwjzXY6Kyhtzn6VgKp1bZ+u
	QU+wtoW5gyo/L8m7BN5f1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744635853; x=
	1744722253; bh=ccfhkPn+au6yYpzzvf9MRXsGom4Ap/i9WISCO0NNo1U=; b=w
	2qM8edjEY/tcn5vzPQXDEeIbeQxXbg3Wgj6TIxLexoREXOxLENoHYiZnB4esjH15
	xbboSyexFxdlcfPkPTrFmZX4Whs4Ac0sN3bUuttFkfR1deicntXJM1jBxIgHkmHU
	DjNsDgGl/Xe6gxNXKwF6uFHA6EvViCCvm8EOQ6d/Mg9PebiRsjQHBlY99SLDO/4w
	LHSyQu23P5EsuoODOZ1J8hmA/R5LeKybnZmPBAMNa/MmLjWC1x6PNSytejkfE/a+
	eTg+xKf/Mm/347qZIJgcmH+XyNpQBSosl8QCUgm158UFNZzAzUJydaAL+vQ7nxsm
	6NWYivkGriIK7uZalIMMQ==
X-ME-Sender: <xms:zAf9ZwPsYsSCTM1ezlIr5VnigiOpEJBuR06OKENdwSFHWs7dks2yiw>
    <xme:zAf9Z29L4_J6sBmr0CGnwR9t9JdnFGe2j_GtA0wKs_dmqLyHYjO7Edmcqi1b9owJk
    19b6hWA_HVSje0G6A>
X-ME-Received: <xmr:zAf9Z3QwQWQP-0Gx2CVX5KC2irbijsrfPj-F3GTdQyKf3E0-gAKervG080vyyJqGB6xpTU2kGRU--EBbXK6zKnQ_rs2xcndVxnxX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvddtiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefg
    keefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlvghvrhgrih
    hphhhilhhiphhpvggslhgrihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:zQf9Z4tFHcnXtFlMiP8e1GbvQDLJdCcYud79Bu9I1qWxXIhyBhWEIg>
    <xmx:zQf9Z4dCWdATfvA1XlSwfHI0ssrsNOQ6_Hqjna_8wwSewjf5tCcMow>
    <xmx:zQf9Z805Ic9Nh7vGmEZ1uuzPJLSu13GjyNMBr2xr_rQiINdZI28suQ>
    <xmx:zQf9Z89brYwEcf4HGjIK0ZSjyY_vOoSeoJj5BAl7SPr1F09bXoR-RQ>
    <xmx:zQf9Z-q3psK2Ygi4yh5YiOUtwuCibdRKRTVWMvV5gbmZvQFIy5BZd-SI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Apr 2025 09:04:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Philippe Blain <levraiphilippeblain@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2025, #03; Fri, 11)
In-Reply-To: <5a257012-39ff-80af-7d65-029ec250a321@gmail.com> (Philippe
	Blain's message of "Sat, 12 Apr 2025 14:03:54 -0400")
References: <xmqqmscml2zq.fsf@gitster.g>
	<5a257012-39ff-80af-7d65-029ec250a321@gmail.com>
Date: Mon, 14 Apr 2025 06:04:11 -0700
Message-ID: <xmqqikn6sxmc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> Hi Junio,
>
> Le 2025-04-11 à 18:58, Junio C Hamano a écrit :
>
>> * pb/perf-test-fixes (2025-03-28) 2 commits
>>   (merged to 'next' on 2025-04-08 at a8aaeee41e)
>>  + p9210: fix 'scalar clone' when running from a detached HEAD
>>  + p7821: fix test_perf invocation for prereqs
>> 
>>  "make perf" fixes.
>> 
>>  Will merge to 'master'.
>>  cf. <Z-pD1puYT87YKAd4@pks.im>
>>  cf. <Z_TAtJ9LEeHo2AQN@pks.im>
>>  source: <pull.1936.git.git.1743181669.gitgitgadget@gmail.com>
>
> I actually found a small error in the comment at the top of p7821,
> I'll send a new version with a 3rd commit on top.

Thanks!
