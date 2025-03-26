Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0D13D984
	for <git@vger.kernel.org>; Wed, 26 Mar 2025 02:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742956681; cv=none; b=ayCkgH/2M16SyjqFz5AJge8IvOVAQAQq+v7AC3kGJqgGUfZVIBHj1hQjdQZhNgQxxnqsEFIU5T2fd9NCsSM3ATT3ObUUVC8I/LQ74YC8cYZUzAVmh8k3SDX8YnZRcesIjNgWrLF7vG8CRHm+wjBB6ODi+RR43JO/a+XcDlbUtkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742956681; c=relaxed/simple;
	bh=mkLxfmPblUiWfCEJR0Q2E/Diou9KE1F9D7FYwkDSkaw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qFkGdFCI4W85Y2N5ktXxqrqZ3G0K6l748mQT3Dz8G8IfFR6VFo5yOWse4OW9H+C/ggyoLo0gg1F8G/xXnvxK5ycZpWp1oV/IoiENjZhyowFRBFHra0xZxKDkwg0G3qaWNaqFyqpEVl5/vjWVl+FAiYRq4/8PGEU4kfuyoYDhGoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BiLrUp73; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MNc/QTRW; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BiLrUp73";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MNc/QTRW"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 32BC925400D6;
	Tue, 25 Mar 2025 22:37:58 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Tue, 25 Mar 2025 22:37:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1742956678; x=1743043078; bh=N6r0Txe5RW
	6Q5POwllzckOdDiQqoMR6TijJc3MGBm+w=; b=BiLrUp73qtPRi2MD+8bUUGxd5r
	L43a2ThGWfBfIqTzrAfIz8Pj4aQoRIk2arDj3kWbYpQrobOR1K/aLF15le4PztT3
	97Wu+GckRTj25DC4laistryzZP+emTlwr1RbYpVJJKmf+m4h8rjSO7TAK1iL1HGe
	xKzFHwM8z+3h8uPbyACRNtvAoPEzR4S0K6/WGobF+1mmxRIv+sFHNhiyxAoIHkKE
	6ZoH3CzKOxI7MsxY+zOmfIfmi1VTTG/GxCWSa0EuZNIIEq5IqOMwnrbet9GMUYLL
	xAg7lHN6ktN5iv/8wtSu3ruVbAQvxiUN+DHKEgIiJR2C4dNVlnwkALhu2i3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1742956678; x=1743043078; bh=N6r0Txe5RW6Q5POwllzckOdDiQqoMR6TijJ
	c3MGBm+w=; b=MNc/QTRWWzFbqQTDSwoDnwmKL5hyL56oJg1uz9sUEUuOYtHDCI4
	VyJxmciqVbLiulePHl0wveOJf8oje83Ytngu3LwTTvzexxkNet6Z8FiJ4yR5e6iY
	CbFfUHKNfhAdlQT3k5leuilpwfNX7XlMBXZ4u1jTo99C6RscwXhq/6K//oUXQ2mZ
	BAT0A9jzhQob/V1RXv5Tt59YZMmBxi3x5ah9g0sGHPI6tmSNjb5M5ZJbc6H+/hOe
	sEW4yvMqXP079KiK0zYWlcaNdtPr6p0a6gAhrqSF+T0mKbSSdzZ8PTz0V9VezShA
	mMYOO2xfrV/jVFhiKTIOialAVxeSwDBR2Ww==
X-ME-Sender: <xms:hWjjZzhyKT0sCLpE_xFeQOsgkx8iHUfB7qmqYl0AioULu3gFiXGACQ>
    <xme:hWjjZwAO2mqbvyfIMpFZYA6qkD4hi7XN1ky5OZBJMXueSH-dL5UbAnWT2OlIpKpfT
    9k32QSgT67acxWheg>
X-ME-Received: <xmr:hWjjZzFOzEYRTFfOEb-G2bzYI_3GZj4iFteoWENuZ4v2KS9ENfw2U-kXNyL4mjT21Wu1Z_5BRRAg4yBtOcD1NxGpQ1Bt1ZBsRJaMRw4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieegfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    eikeeufefhtedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileffudenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehjrgihrghthhgvvghrthhhkhhulhhkrghrnhhivddttdehsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:hWjjZwS9TIvW7qENT4yvhDYlBstJx6LNOcUTJR8Pm9ce-d33TijpUg>
    <xmx:hWjjZwzXcTXtedyqn_9C6mlGBiwPMx3bf0IksXKJdvtnn7JPUtx9rg>
    <xmx:hWjjZ270ozBHU3ihvWOkaPzOMFckkZCnmRZiGyyBUXwa3nM3-6brtA>
    <xmx:hWjjZ1x4by891kUvQXY9D3lWPYJA1H9NKeQJ4aV9ME03a2rA9lOq5g>
    <xmx:hmjjZ6s2XTelmHpSUbWpBdZnUqmkTBUtE06Zc65qM7wzp4iBouCQJhHE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Mar 2025 22:37:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org,  ben.knoble@gmail.com
Subject: Re: [[GSOC][PATCH v3] 3/3] docs: replace git_config with repo_config
In-Reply-To: <CA+rGoLf7R5BmpN1E+AXYhEKz=Th2TcpfDr0NxNma54GR_X_K-Q@mail.gmail.com>
	(JAYATHEERTH K.'s message of "Mon, 24 Mar 2025 18:40:12 +0530")
References: <xmqqa59evffd.fsf@gitster.g>
	<20250321143022.5406-1-jayatheerthkulkarni2005@gmail.com>
	<20250321143022.5406-3-jayatheerthkulkarni2005@gmail.com>
	<xmqqiknzqu2h.fsf@gitster.g>
	<CA+rGoLfALoTvQuAzQPx7rqd-Zy+wMiyEbF5Y8_-2Yi-yE-2qpA@mail.gmail.com>
	<xmqq34f3qbna.fsf@gitster.g>
	<CA+rGoLf7R5BmpN1E+AXYhEKz=Th2TcpfDr0NxNma54GR_X_K-Q@mail.gmail.com>
Date: Tue, 25 Mar 2025 19:37:56 -0700
Message-ID: <xmqqiknwldob.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com> writes:

>> ... better to explain _why_ each change is made in the text that
>> precedes the sample code.  E.g.
>>
>>     Add `#include "config.h"` because you want to use X and Y,
>>     and `#include "repository.h"` because you want to use Z.
>>
>> ...
> In the latest patch version I've removed the comments, since we
> already added a line above saying the user has to include
> `repository.h` I don't think we need to go in depth into that, do let
> me know if that is not the case, looking forward to any more feedback.

It's your patch, after all.

But if the reason why you added the comment was "this is a tutorial"
as you said, I would imagine that it would help readers to say why
a particular header is needed, when the tutorial text tells them
that they need to add it.  From a quick look at the patch, it seems
that the updated text says what the change did (i.e. add a header),
which is rather obvious in the sample code, without saying why the
addition is necessary?

