Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FA5219E0
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 21:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750712435; cv=none; b=a+VuJm7AZ1P/liIN8DkQtH5yZ3f6ejhnjaZttcdAFSLnQFoPkrMI3i6ouOYw/EJDA7dHqk82+oVjAjDggP3Ihun4YcdEOGBo9M9djIFTiJetb3+4Z2L/RJDXujhts85Tci6g8dfCua1lGP5MD2MAfTI1unRzTzj4/XoS2GdPiss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750712435; c=relaxed/simple;
	bh=F7gl1JFMBR/fPRoOhR+YhmvvIEG9Jk90pX462n/BEBk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NNJyRI7IrmojlDk+fblqjtiS2ZOI8xyKvmUQhaerFsK9zhYksRgC4lSS6YEcQdmF0/l0qNt7oRl0Z8AgANVE7vdjr17AyB9ZI8ktAidzWu4TbdyrV1ecljiaoJxf5X0TtVjhHPa8aRt6DoXc2gwhfPTywNS7F+TUSC7RCh3JX48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PEE6vJMQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o3HjCFOz; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PEE6vJMQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o3HjCFOz"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 2ABCF1380DB4;
	Mon, 23 Jun 2025 17:00:32 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 23 Jun 2025 17:00:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750712432; x=1750798832; bh=50NGseunFV
	Drjb/5iupCAVmrOxt5E8KKuxl+0d3Xz7M=; b=PEE6vJMQ3Jt4lm+3I8Nq0ztqWP
	E84+x2HzCyUDPO8DQNwL7s68tnIDLyN12usFJEsTxKv7gFFiDkirfSkx49iTp23N
	yFEkfX7pW5gaKlDD7aognP3wU9ae8LNXCeO6nsaY3FVEPb3MHtIBuIcmnWtCTxFk
	+6eUZL7mY6uDvhoC3DaRTMtC6yQg7o9RU2QmujESAtGbeB5d4NpqHsA3TVK0TCG9
	Woeh+3kID6uldnscjrVg6Y+27/br7fP6hDAcrRqmp0LA66o5bjG04qsvpXgw9zMS
	yupALonf047xtkEw1Wy+COuNHQFauo74klRL044SmLJ1fTYY9Sl8ogL0Ii1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750712432; x=1750798832; bh=50NGseunFVDrjb/5iupCAVmrOxt5E8KKuxl
	+0d3Xz7M=; b=o3HjCFOzSJJ/311au6lSgn9v/+ZV4dqin4tWVM+hGLNqFlbCWto
	bzQ4bp3SgUHCzmUg11ZCTMgYwsaHkB+xH00Cxg8GmD/muQz+ElY7GLy15mNLyFba
	+b04v7JaGILqrPSYcZjcbQoenUqxcPLMBsGkWynfysiLDZy9LlbW82Rhrdz+tep9
	30/QnVL2Enr+I9KLwl57Tifi75+6//SWJsMrr1pRBnPZYKiU/XBpM1fXLaBIx6wv
	wb3Z9mUwDKfWSkq1q57BpuXhsyDLUTf0s82+ovBn3QZU8/Apb+gB8QC9QHNt81xA
	9Shb/IrXKw3eavIEcF3MR7lMqyztZ1kcJag==
X-ME-Sender: <xms:cMBZaFN7ULNr5oQikdgmBGvlUA7VKkwBX4V7vdldWDdafNLUC0QvLg>
    <xme:cMBZaH8wi5rppiv1DEWh5odPkFEqol-jZlHhxo44zpP7jn-K91owe9jWRBJ4ssdrW
    BWFkf0E1dF5jf1wKQ>
X-ME-Received: <xmr:cMBZaEQYSqlu7MxyGBe1OkrDKSKFTMjaroPtS8PhAN5qwFtAcNj0hADhWOwFlh62sXiqPrq43nYjfDV8zZQbR47rbnbKwD9LNC3e0as>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddukedtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrghikhhophhonhgvnhesghhoohhglhgvrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:cMBZaBvZ7EET9p6-IitLVjvE0bUcMzuaak-2Xa9mnP_vnWGHlq3VZQ>
    <xmx:cMBZaNd2DqiQgbWqP4VX2p7Ynmau3ZZBNeASY9f1Ajvqn4XHmHLl3w>
    <xmx:cMBZaN1fCA4pUWqvuK5zj5Zc8KTRbVygfJqIujZkbAYhV35BaQ2VUw>
    <xmx:cMBZaJ_wCvjq5OQ47Ajtl-3fYntmiym672hHfq65cXIVWAO-ExHPWQ>
    <xmx:cMBZaDHndNv90hxcBh7zIYwvgEuXoK3uhaagMKq1A0xSSVtDDop72EL1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Jun 2025 17:00:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Kai Koponen <kaikoponen@google.com>
Cc: git@vger.kernel.org
Subject: Re: Perf bug: rev-list w/ 2+ paths relatively slow with commit-graph
In-Reply-To: <CADYQcGrR0mKLEWSYZCrL6b7NYLGfdsZsuKCCFQ_ptpMJ8mofmQ@mail.gmail.com>
	(Kai Koponen's message of "Mon, 23 Jun 2025 16:19:13 -0400")
References: <CADYQcGqaMC=4jgbmnF9Q11oC11jfrqyvH8EuiRRHytpMXd4wYA@mail.gmail.com>
	<xmqq8qli5jyi.fsf@gitster.g>
	<CADYQcGrR0mKLEWSYZCrL6b7NYLGfdsZsuKCCFQ_ptpMJ8mofmQ@mail.gmail.com>
Date: Mon, 23 Jun 2025 14:00:30 -0700
Message-ID: <xmqq34bq5g29.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kai Koponen <kaikoponen@google.com> writes:

> I see, more of a perf FR than a bug then.
> I don't have much expertise here, but on the surface of it, it doesn't
> seem to me like there would be any reason the algorithm couldn't check
> each path's bloom filter in turn while searching, other than that this
> would be a large and annoying change.

It looks like that the necessary changes are probably fairly well
isolated to two functions, i.e., prepare_to_use_bloom_filter() and
forbid_bloom_filters().  Right now, for a pathspec that has one
element "dir/file", the code uses two bloom keys for "dir" and
"dir/file", but if we have "dir1/file1" as well, then it does look
like a matter of using two more (and the bloom_keys[] array is
designed to be variable length).

But those who have more intimate knowledge in the area than I do may
point out what is missing in my "it looks like" gut feeling.
