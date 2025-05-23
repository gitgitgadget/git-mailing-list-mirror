Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA3218E1A
	for <git@vger.kernel.org>; Fri, 23 May 2025 17:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748021090; cv=none; b=BPLdyt/ndqxTlwV+ckwrTzwTlzcvWnvWDO8FyPlQdFuf1Qwa+ulg8e4wW4JSKztsn4+1j7PT2ladqZ5sj6kTUEilLDQxOyrdij6s8j0BVFz0YJ8BzogYNMOxiLuuo28fjU96XbaEZRlJPZYYCnyZP/Ra2MNn6s1g7ZYN983Wjfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748021090; c=relaxed/simple;
	bh=EhXeB/VxkHEemYQ/etlNlkxCgHxjAZrpchpe8WeqQlA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jOHBEOyOfmW3RXjK26+CTIBbTbSj5Ff8Fi0be3hsMIs9PtUaZLAKCyOcfJGT8OrL8LuUVhI+wkbBcCRK9aV6pe95dSbVdusT8VdIvyKVtZQ3KFLF+wfaY5jIUk0c5Sy16F1oIL4ZoFkE2Pluw+rpnzXsEO5B1sUT4yXLCN8qZ2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bZh2sOSC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KMlMlaOk; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bZh2sOSC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KMlMlaOk"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id E918111400A4;
	Fri, 23 May 2025 13:24:46 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Fri, 23 May 2025 13:24:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1748021086; x=1748107486; bh=cxR2IyY4sA
	aM/+iMNwWsVr7WwheCjcIXSyBR2ZRDwVg=; b=bZh2sOSC3SJo5XUGqhYZ7qYOyU
	qm6ZpN/RGau0MFRUyvxAbJ322qKeMO6zQz/U2A6w7m0eHSr/tWkTwWz+A/2sQULZ
	qeUimIv/ONcCIOnMOzrp3oIwzTCIkOI0f9D6eBBBST9s1/fjz3ZuYp756363Y5Wf
	YNJEqy+OLkQSClEo0HsmKtaIQI+xB/Hr3m9FyMvnAMxXmxYlZnnmqNcmk8t2RnZ6
	IstNA1p9d6o+i+PD+6O0hp2Sm8JZ8kRlRjRz7XUM8TSF4n0C7Wh4imQDvYhCiDzs
	HVZBYLI7+0DYqdc0IthbdVf87DFL/8HO45BBhJrF8RWaEPXqnScqg6q1YUXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1748021086; x=1748107486; bh=cxR2IyY4sAaM/+iMNwWsVr7WwheCjcIXSyB
	R2ZRDwVg=; b=KMlMlaOkRtlWZSBFS5MbsigMn++dYo1a4+cXYyfidjhg+IaYqkx
	QKIsCWcx91KY26IbLLuq9QWryJHwYg96wDPQmgT/EhHV8UHSvuR0DnlHjaQbWlKm
	eJ2ktNXA5GdnwUpU5XMz+dpQvjHvUIsDveTUDSHKkdhqG/vfRzdNi4/I/MTCp0/X
	8XQm9Ps0O1tFGMxUh+Ba8TTstAiV+hd5fqZB9bYZH5dJ4WDrJWDZmdWyxPsMrehC
	9wx9YDY58xzJlyINQdpCYxQGo8EaB8vGn+XPwdusCKQwpg6V4movI8TkXp2pae1B
	szMOcBMj+LGXklfHSZvI7mWvjMJswrzOxDw==
X-ME-Sender: <xms:Xq8waDu_4kn_FS5U7a1seA0nZyQSyilyB3SjXALu4hfxp_BhFIoWYA>
    <xme:Xq8waEeKtOliCBIlV4wo02IkRjK0Cezq8AyqJcfFcwj6_P1tw4NjYkFNyfiWRqoZO
    GB5XiSLOAWAvG4n5g>
X-ME-Received: <xmr:Xq8waGwC77iaIQzo4QIzzg3_X4Gi00CTg10PZCdSmN_s1rBu6CtOzvMO-u-L5oLX9dVbVp7h0vmG9RGH7laAUkASfoJyd7Gl1BKFlYs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdelgeehucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtreejnecuhfhrohhmpefl
    uhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpefgteehueekjeekffehudfhgfelgfdvvefhleeludduudffjeej
    gfetledtieeuieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehmrgigsehugidrshgvpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Xq8waCN8ZKIw6viQFN4PY1dRsSCcDi0CK2nFRLEYpUhfzHqXp0DQiQ>
    <xmx:Xq8waD8R2HJncQxSq0yJMXXYji7nuxU0ZsyNShLlKLdmEsuyZnsocA>
    <xmx:Xq8waCWOeA6TWrr6adRxDFLt6l3Jvwqt85nmvwJMgyN4OnbOtzd1gA>
    <xmx:Xq8waEdVwws8NzteyxiKy1z2hFjUQcxxmot5BNaL_jcrmLpsBPcdFw>
    <xmx:Xq8waML0Eb5Cb7G6G7z2hn34GT2mPYm-1AoUTqtKPGAFwqXchZXBR2_v>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 May 2025 13:24:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Max Rhodin <max@ux.se>
Cc: git@vger.kernel.org
Subject: Re: [RFC] git-ghost: preserve =?utf-8?B?4oCcd2h54oCd?= on deleted
 lines
In-Reply-To: <CAOc+UT0n9pRGur0d4cORU0SMQY-PNs5ekLd=LX9xc940Og+nrQ@mail.gmail.com>
	(Max Rhodin's message of "Fri, 23 May 2025 14:32:28 +0200")
References: <CAOc+UT0n9pRGur0d4cORU0SMQY-PNs5ekLd=LX9xc940Og+nrQ@mail.gmail.com>
Date: Fri, 23 May 2025 10:24:44 -0700
Message-ID: <xmqqh61bxmsj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Max Rhodin <max@ux.se> writes:

> Comments?

Would running "git blame" in reverse work for your use case?

Tracing deleted contents is much harder than tracing contents in the
current revision, simply because you have to find where to start
digging.  In order to find where the contents were removed, you
first need to know what exact contents you are looking for (which
by definition you cannot do with the current revision), and then you
need to know what revision had that code.

What I do in practice is to randomly check out an old revision to
find sufficiently old one that still contains the contents ("git
bisect" can help), and then go from there.

