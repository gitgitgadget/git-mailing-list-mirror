Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DAF18787F
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 17:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728669002; cv=none; b=lkyrox2UMy7Km5zI9o3GQxRcRYg3hRfYLlI3D3vEjhtl0sVvxHjEG0UfCQjXWxBE9GHSDek1xYNXnz8w7oEBJNLFvGy3WeekqCxDuQfKzBZKJf0xt45B4JUNosAw4CiSMbVByICxTjLUX+O5EM8gpWS71wePUE0sywnXQhDUqL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728669002; c=relaxed/simple;
	bh=iexG+jP8SudStonkWzbDBdONmWd5oMiF5mda+QHqx70=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dNAxV3+FO8G7jHxJmL/bS7y7gsqaBkz3nePQZNgOnzToVOQkG6FMYc8ph7f0qrBVo6tB0ETnpPM5UXq5pm87JoTMm5avPZulHmdSjZpDjgOBOkLdOwoljPv7ITG7Wd71C0Eqk51Ri+UROysfpUcEwDSHOdAkpLRP37DotpCaTrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=C7nAa93E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RofoaO3T; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="C7nAa93E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RofoaO3T"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 842EF13800E9;
	Fri, 11 Oct 2024 13:49:59 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Fri, 11 Oct 2024 13:49:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1728668999;
	 x=1728755399; bh=3lI07JLDHIWKdfeGU/oc3vlb1vPV4kYYtq+GgKu2mdo=; b=
	C7nAa93EfYVC6QEGanqjW7lf3FfDeVJT0f8897PmIEUJG3qgI3QWnXyMBdhZYd1m
	EpD/QJ2nEHmpg9DoOzy/zYUBKOQ0q1Lpy/CfNEBes/0O8R4VSwA9t+YrZYxHw+Wp
	L09cvv7hXEKEiR2dZbCPK2HUSltccf3HiTJUjfBc329QCgV3lOqZoKnmcTY4+ynN
	pLpRsuVtN4ryVMyFSOX9F8+AWkMWG6rjnIqksTKs2SHbhe6C2k1ZkG+30kWM5Gbw
	0jagcVGeaEL3W923Z6XTIWFqYbc7/xWtFl+wtdlTYc7SWvU2nmtMpziDiYsFr6F8
	w/ImbcojluerMA9EoDeY3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728668999; x=
	1728755399; bh=3lI07JLDHIWKdfeGU/oc3vlb1vPV4kYYtq+GgKu2mdo=; b=R
	ofoaO3TRkrWws6Vu/qqETsFfz417LXDXQ/q9TuDgAL9F0PFvR+Rv5vR8HZKiAtPq
	PjLIEJi+gZ90zKfXW5g9kUjIscpxRUmvM/dEmUK0SaR1VCClwdfrTld4/wUkUw6i
	bvMB8lCutC2yy5z3+bUEGcSt4mg6+Oz7Kyao2ARtVPSVRjBosPi9oTQeEW/1fgNg
	TaDgCVEZeORw2k7O8+YjJgUrEPyzt4WgxV2pgZo/zPB/w8ZutJRwCjlgbUqG+ivD
	yHTIbNVaVEilmfSkEeB4KenjWYGCBE1fOhvfgmSnDbJL+pd4/pmKrziyF3QXBcla
	YYLnzl7HyRkVfh8E/yXpg==
X-ME-Sender: <xms:RmUJZ1Lv8tqBI0qI5NeuqLGlyuhaS6YslBSqSpsKlFRcVC4v6CSNnw>
    <xme:RmUJZxKuAYAosogSnxRRRouevFjZF1GQy1T4yHcH67BEa05JR6GF1fddfCBPQmI7C
    bqi1l8ZByYWKTzAFg>
X-ME-Received: <xmr:RmUJZ9uhEw9Cl2OuabLPTD4TvgBUYUciLfbmUBJ4j2xWndZqs-LcuoHAt-b5CXX3r7O1rwRGaPPQOCEMf_0YstIdIFFEIgj8YmAF228>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefkedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttder
    jeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfek
    feehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhunhhshhhinh
    gvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopegthhhiiihosggrjhgrmhgv
    shdvudesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhr
    ghdruhhkpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:RmUJZ2YYjnNOVnaUl4efXA9QQST_FDjugnuSpBRq_hvlB6LXGX4eQQ>
    <xmx:RmUJZ8bLtwscBRnNn36sP9NJ15PPcrg_6WjztHAo5ePRAFDJU5xVjw>
    <xmx:RmUJZ6BDxC2feL4rTrCBH6fAfWGEoAnQ7xMkeAr7tDHHzAgvv6KiMg>
    <xmx:RmUJZ6YccFtgApii58uHU_IMQM9D8XUmCYgDH4hzJykHj6ZJLR_Lbw>
    <xmx:R2UJZxPNIlrcu77jEyqtuMoKH0ZbCUGUn2X297WLVnfsIYvheMi_u8eG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Oct 2024 13:49:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: chizobajames21@gmail.com,  git@vger.kernel.org,
  phillip.wood@dunelm.org.uk,  ps@pks.im
Subject: Re: [Outreachy][PATCH v3] t6050: avoid pipes with downstream Git
 commands
In-Reply-To: <CAPig+cRLdzAEA-G=L81yR9dmm8Y-5VEU7ybyohKmbq9=0bDUaQ@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 11 Oct 2024 12:03:14 -0400")
References: <20241010063906.51767-1-chizobajames21@gmail.com>
	<20241011154555.584917-1-chizobajames21@gmail.com>
	<CAPig+cRLdzAEA-G=L81yR9dmm8Y-5VEU7ybyohKmbq9=0bDUaQ@mail.gmail.com>
Date: Fri, 11 Oct 2024 10:49:57 -0700
Message-ID: <xmqqzfnaedh6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, Oct 11, 2024 at 11:46 AM <chizobajames21@gmail.com> wrote:
>> In pipes, the exit code of a chain of commands is determined by
>> the final command. In order not to miss the exit code of a failed
>> Git command, avoid pipes instead write output of Git commands
>> into a file.
>> For better debugging experience, instances of "grep" were changed
>> to "test_grep". "test_grep" provides more context in case of a
>> failed "grep".
>>
>> Signed-off-by: Chizoba ODINAKA <chizobajames21@gmail.com>
>> ---
>> diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
>> @@ -344,7 +374,8 @@ test_expect_success 'test --format medium' '
>> -       git replace -l --format medium | sort >actual &&
>> +       git replace -l --format medium >actual &&
>> +       sort actual &&
>>         test_cmp expected actual
>
> Isn't this conversion broken? The `sort` command emits the sorted
> content to its standard output stream; it does not sort the file in
> place. So this is doing the sort but then simply throwing the output
> away, not capturing it to a file for comparison via `test_cmp`.

Good eyes.
