Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D724235047
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 21:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753306481; cv=none; b=LPnuvhPMDoWVPEpcpaiboGcqcnwzYGYaGuOrvbhOr4M+HPeQNEBAFK7shj/p9p1tbAdNsTIy50e6m+9kebLptRwnUTau+zMjIQWtYgVrVPRcZPTCMxHucHIcINmelRDPtpY9cqXy/ZVMcT5DEBm0QPB+3o6xDafK86ioSwqTjD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753306481; c=relaxed/simple;
	bh=ty1NCEcw69TNwRFkxHIGE7q2FUnq2hXpinXQBNzdVHE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VDYa+Z6TPxnoTLG8MFeLfXVLWQu8EEkynRYvfqe8wh7qstiNRFesyiJmUIbh26vjffwIC4KTVfvSXnZ8k6MjGjb4t/oF/WTUa5f3lpWxRvcJz+XU3x8n43jawnj5gmDydbzmlpKuhH4kOByP3KmZk7zqhLweSp8vpjzLOYSPVUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KN6g+u9B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L7yRbwDt; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KN6g+u9B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L7yRbwDt"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 73511EC1698;
	Wed, 23 Jul 2025 17:34:38 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 23 Jul 2025 17:34:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1753306478;
	 x=1753392878; bh=OJFgo121/vl0eo8e6RYCyms8K/ERglfYwSdm1LRLOfk=; b=
	KN6g+u9Bvuw4BEZloL+J0QPw8D4cWBssgK4YiN0DfVmenf7TkAZg6x190LZKPdFt
	eYAtTXl19MBHw6okBpjoXLppfH/V8s1ZmIRBEsJ6XQKo08vgX0BHNEsiNtlm8ZHe
	x62Mfzar3n9a+HBqya7fRN+L5M3NbkUVNB69p2VDfX2rLSHQv6yW/3KhMzQZBXsk
	8Yz6JsOOmJ+56BX+/evrO/dEs4EHI3pBHmLh9kLW331xUUx2U9HOa/+5bOiXk9Kv
	x9iNdl94B2Jq7i7iOGuCQQfCfP2SMur1L4ci+yjlUtfbVUux1tTG2rHQ+/Kbyawj
	pxz4FyZpIBYH+MvvgeBNAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753306478; x=
	1753392878; bh=OJFgo121/vl0eo8e6RYCyms8K/ERglfYwSdm1LRLOfk=; b=L
	7yRbwDtWlLZOuZnxo+g8Y3VbjrpO+KcLT+BkTlFTbHBExnCYNKaIaGK3fmd8jbIX
	X33e0mRTRn8F8gxI29EO15TWf82oVWAz6s0Bj3t/KrZNQB5lFJ4/L7XpcbRAvaBR
	DlQo1j+0gtYmLv555jOiG5PS/V+cl2m4Ik4/7W0fG1YQv9IeOz2uPXUmQaOVmi0v
	PB9xz2hpr4IGQ9mIBFt0VjJFoQO5OTK5FORwwHwaGq2G1vSHIKfaJZV3cQAlvBZd
	URb1AXtAAzIu6CQRQ7ZUOfjUKVRe3Ad0mNnT5tfFYrfQHfg3Ff/vsv1e6627mtis
	mkDU5IbKLrhWTEf4mXR6Q==
X-ME-Sender: <xms:blWBaPJLw3uJhr_NfQyqyB980uLlLc2cEy0LZ3aIzn9MAs1P26BEzQ>
    <xme:blWBaNvPZHXbXfVLDXEtBZgRKhW8mNplTA4eAiKsWEe86WqmhVz9jTjrysRBXbU2c
    VeBjLxqscHMMMOXbA>
X-ME-Received: <xmr:blWBaERQr-83WOunJ38erSXWHboKgtQVa8_eNmeR7dMoxoHHsE0_KeY6Fm3IXJjztCk83__moq7KxudgDe8yRjTSHeeSV0TwqD6ieuc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejkeekjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgfgsehtkeertd
    dtreejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevle
    fgkeefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehohihsthif
    rgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:blWBaLN6szMX0HKDHk5bDMW0HI7WJwtQOcVuG01AWrxQxmaWY4JuKg>
    <xmx:blWBaBZeQunIf0KSdN2xNDEu5l5Xdgkkdb5h2_x1C4uwTqgrSMI_sQ>
    <xmx:blWBaNzm_EmizvtgqZIqo2dR-sk-Z4s2yhl_oDY9jIKAXYhB-RUMoA>
    <xmx:blWBaELaFG7oz-30RJ1Qd22B0Id7IRJpUdAVPRP78Q48psdRjXkK9A>
    <xmx:blWBaA77Z5U2H5p3q9AHOvBkMyeLJQPAQESe9SNO7blwOnt2VBbwkUxF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jul 2025 17:34:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Cc: git@vger.kernel.org,  phillip.wood123@gmail.com
Subject: Re: [PATCH v2] rebase: write script before initializing state
In-Reply-To: <20250711203615.9982-1-oystwa@gmail.com> (=?utf-8?Q?=22=C3=98?=
 =?utf-8?Q?ystein?= Walle"'s
	message of "Fri, 11 Jul 2025 22:36:15 +0200")
References: <xmqqfrf6qkyy.fsf@gitster.g>
	<20250711203615.9982-1-oystwa@gmail.com>
Date: Wed, 23 Jul 2025 14:34:36 -0700
Message-ID: <xmqq1pq6mw0j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Øystein Walle <oystwa@gmail.com> writes:

> If rebase.instructionFormat is invalid the repository is left in a
> strange state when the interactive rebase fails. `git status` outputs
> both the same as it would have in the normal case *and* something
> related to the interactive rebase:
>
>     $ git -c rebase.instructionFormat=blah rebase -i
>     fatal: invalid --pretty format: blah
>     $ git status
>     On branch master
>     Your branch is ahead of 'upstream/master' by 1 commit.
>       (use "git push" to publish your local commits)
>
>     git-rebase-todo is missing.
>     No commands done.
>     No commands remaining.
>     You are currently editing a commit while rebasing branch 'master' on '8db3019401'.
>       (use "git commit --amend" to amend the current commit)
>       (use "git rebase --continue" once you are satisfied with your changes)
>
> get_commit_format() calls die() on failure so we cannot handle the error
> gracefully. By attempting to write the rebase script before initializing
> the state this bad state can be avoided.
>
> Signed-off-by: Øystein Walle <oystwa@gmail.com>
> ---
> So sorry for the delay. I saw that the signoff was missing, then saw
> Phillip's review, decided to think about it and then life happened in
> the mean time...
>
> This patch is identical to the first one except it has the missing
> signoff and a few typos in the commit message corrected. Phillip's
> suggestions are noted and appreciated but unfortunately I am unable to
> work on the at the moment. And I do think my patch is at least an
> improvement albeit perhaps less thorough than it could have been.

I am sweeping my backlog and noticed that nobody chimed in to help
improving this topic.  As I already said, this would not least be
moving a step in the right direction, so I am planning to mark it
for 'next', but thought that I should check first before doing so,
in case you are back on the topic and cooking a new iteration.

Thanks.
