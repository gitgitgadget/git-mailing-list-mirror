Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6130924FC04
	for <git@vger.kernel.org>; Tue, 11 Feb 2025 16:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739292626; cv=none; b=LfJjDKvAuPcwoB7Ri6jYCfU8Sa+D9jiULQyD+rijKmlLFu4TbG5bh4RB2P+DC0EGga0Ze8vhQ6hFExDG8JqkAeek0f9cRtaqfqUaAyMziorZ9INpMBhV+LKqT7CE+63emUdRe3W/SIQer0eWOrvAVKcd+VQBH/IYC3C3HMQK7LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739292626; c=relaxed/simple;
	bh=UwceUnjHYtu3TzxUd/aPKC5t2cVGj/rJIeAOOJ92rjg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M1OqEo93pGRsQA33pEJUD7Jw32MpzyPvZniwMElq5AHWLSJdPtsCIh6ipG9WiQL8VY26q8yqeothKPRAibtxR3420G+nnltyJobRXhnk6bwi+SLChTw6Jw/JVfdksPHIsYKs4HXuY2mBvcg1TPzY2Sg/uOiOOG2/WbWbhIIpQx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mxRKyOCH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Fc6R3Gw1; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mxRKyOCH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fc6R3Gw1"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 52A4C1140196;
	Tue, 11 Feb 2025 11:50:23 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 11 Feb 2025 11:50:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739292623; x=1739379023; bh=sHxCM6BS9V
	r5s1WTuxhsZxKScyfnlhFBwA5YmslZTGc=; b=mxRKyOCH6EArJ0mIDobtys1pNR
	n5T0XjVQRwezdYqoKCImbgzfPG4sGglUcYJodhJqn3W8WgESS3OtSGrwet2lXihi
	7N8/ar4/CKxahqolpcqAW0o9r/YC020u3Tjgk0MyErNhEOQy6cstNQ87IPoxRT8L
	2G0Y1q1tQW/vILm9SAaHHQ+hq0DcIiGIN4PLXrLIf5w+WIO/4M0xFWdcPcGnj5lH
	gqSQ1B2hWRhTrk5MPMxmwSIqQTOkTuQn5n35lxxIfsLyye+slK1OaYNetkoY4p5k
	Kg911YGT7Aq/KD7cF5+sq51j6efrDPKqwdKNFWkbASsdx5/j+V8leajVJMzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739292623; x=1739379023; bh=sHxCM6BS9Vr5s1WTuxhsZxKScyfnlhFBwA5
	YmslZTGc=; b=Fc6R3Gw182L2WmLNuqbpjILqzEs3vN8aZ72+da249NyR5Tb5lbO
	oH82//b/Sl/rYLXCNEFRkEOUns1f3djWlrjGoDN09LNeuj1p2oKbYmoOQ9m3xoiv
	F4sjRTcWuP0ZxdyU3ZtIue0fdDjOIsn2DXQtPO/t0eqt2KQ3ExV2n+rnIN8bILPA
	PDgdyti3nKZQen/OF9lYaDHaRUeROre95luHX0ZOAAo5VDCy1ZubgfCPDowdDVcl
	gD2EFoMpN+/tjv7ztEBhkZPvFCnMtG6MQGzPYVqre7VSQ6nzYUJ6FCypkvVkwj4R
	DCggWtgz51/a7ZREYJIV9ZN9A0gq7bbbJtw==
X-ME-Sender: <xms:z3-rZyoYjiTDLCs23-m3EDL1VGu_TpAwOr4KoCHdQGHfJVXZwWZjLA>
    <xme:z3-rZwoi5DTAvS3LfIHB8awHxgyhRxoraAZK9xOla4ta43IvVyj0yq3780tyIjg2i
    hFgqYd0EP0N14U8VQ>
X-ME-Received: <xmr:z3-rZ3PST4CvBbaDGT5PGYuEijasIZn-QQODUfpz6QPptXmaMRjIdj_eGz9mlhP67mbQpt6ajbxQdALnOVCibIKmn5RCRjgsDdfAOQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegudehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehinhhtvghlfhigse
    hinhhtvghlfhigrdhnrghmvgdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhtohhlvggv
    sehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghlvgighhgvnhhrihgvvdegsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:z3-rZx5Z91kDsLQN3J5nwVlhpCJSrkYJGOQW3xKQpCDNYSpTEVQrQA>
    <xmx:z3-rZx6qTfCXu_TYOijrANiHEPVX0aAmPpvtUeYWuzFXXmIrtP2fTA>
    <xmx:z3-rZxj_dnCOy76SZrlHKffUf66ljHY01wZCTGPzw1I9W7aOzNfvyQ>
    <xmx:z3-rZ76-lzg7-9eTh5Dgng9B5xgKdNDM1J-SWz-ZHtEnlp0DNlqlOA>
    <xmx:z3-rZ8ZCIlWlr6I0fMrFnGj8qz5GLNGFGK6uln7TdhMHix-kjmopGZFS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Feb 2025 11:50:22 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Ivan Shapovalov <intelfx@intelfx.name>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,  git@vger.kernel.org,  Elijah
 Newren <newren@gmail.com>,  Derrick Stolee <stolee@gmail.com>,  Alex
 Henrie <alexhenrie24@gmail.com>
Subject: Re: [PATCH] rebase: add `--update-refs=interactive`
In-Reply-To: <bc0de52b59f289e1388f1581fcfa49453365e21a.camel@intelfx.name>
	(Ivan Shapovalov's message of "Tue, 11 Feb 2025 15:33:15 +0400")
References: <20250210191650.316329-1-intelfx@intelfx.name>
	<CALnO6CAM7WCOJV8s8ZARi3BAFwkh0TNTCod_YH9s+EpO7t-Qtg@mail.gmail.com>
	<bc0de52b59f289e1388f1581fcfa49453365e21a.camel@intelfx.name>
Date: Tue, 11 Feb 2025 08:50:21 -0800
Message-ID: <xmqqfrkk1l4i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ivan Shapovalov <intelfx@intelfx.name> writes:

>> >  --update-refs::
>> >  --no-update-refs::
>> > +--update-refs=interactive::
>> 
>> Based on `git grep -e '--.*\[=' Documentation/git-*.txt`, I think this
>> should be more like
>> 
>>     --update-refs[=interactive]::
>>     --no-update-refs::
>> 
>> But maybe that unintentionally suggests that `=interactive` is the default?
>
> Perhaps --update-refs[=(yes|no|interactive)] then? Or is that too
> verbose?

If `--update-refs` does take values that the git_parse_maybe_bool()
helper parses as a Boolean value, I do not think the above is
verbose at all.  Rather, it is a disservice to the users if the
documentation does not mention yes/no in such a case.  I'd say
listing other Boolean synonyms like yes/true/on/no/false/off is
too verbose, though ;-).

> Anyway, I don't have a preference, I'll just do what I'm told

That is not quite in line with how we'd like to operate.

It is your itch.  Others may give suggestions to help you polish it,
but ultimately, we would not want to accept a patch that the author
does not agree with.

Thanks.
