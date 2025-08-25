Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A8CAD2C
	for <git@vger.kernel.org>; Mon, 25 Aug 2025 22:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756162343; cv=none; b=dF8U0pAl1oR5BMF0xs8nmTCtOwEgxbLO88pFJaYnMYe2hCC53xLTWkJcE7/Hl5j8uZBycbIfTS1ZBnpaJrOhLo23zl1WSY1fEdBYB1fjbC37hQXNMZ579Wv2WrQucB5XFcNWDYd7Mhdm57mNuz/NV/JSjsxfSvw5trEwzsKPBNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756162343; c=relaxed/simple;
	bh=nfWJrhhlqEAdwnQiq0Yo0qVUWT5TML/+V1duhJ0sTq8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X0GR8v/4nUi2yIJ4VDEd4WmN8ji/wS6xF4SbVT+joTWgf+zcn/rI5aFt3pRh6z/SsAN/LaT9Yx5tUbCn2ZdHuwQb3fgHjkF2zFL2Mi3Y1ZaBKXjG8oHNRjT/idK4Rl6P+LhrarhEVmZFTSIJp7DOMuTUH57Gyfdpboi6ZYRx1rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fSB7ZU+I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Oxxdgz4O; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fSB7ZU+I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Oxxdgz4O"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 3AD1CEC042E;
	Mon, 25 Aug 2025 18:52:21 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Mon, 25 Aug 2025 18:52:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1756162341; x=1756248741; bh=Q19WHiaJMy
	/iNCUG8LUq22eC/JrRs904I9AUQ+qCbpA=; b=fSB7ZU+I6/8aHDaB29hYzU9Fkh
	oM33nhvdGdha8qsiv5VTDjzzuFzYP/0euRPV7D82J42TJlkIEePpjOSvoB3zKQ9l
	wA8/RWl7ZzRlWyvclqeZiGYV/hHyejTB7GkE7waKklm06xDIrcn5SfHFBk9qo6QL
	lgmnwQ/k0qvBV2F49LJEaXqIlyeDA/Mnkd/fGHugmmH3j2Xag6bWdwY7rnOkucS7
	uL7dUv27oHmP/+eyKFxQxK0V165DCRNlVlbZdyqfh7nOc+zD6Ewx3wKHmGVYOYm8
	M5JXk++lIaeEVdl2jR2QARUpMbUnYei18LDsKtwoK7CqgKmWpLhyarNZC9Ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1756162341; x=1756248741; bh=Q19WHiaJMy/iNCUG8LUq22eC/JrRs904I9A
	UQ+qCbpA=; b=Oxxdgz4O/kb7AHA8KwFBXdiHqHHjpYMu9hTYf8uIb2k0iNxvTKW
	CPs43MW0+JnIjt4i6tc+G0Ol8vXmhUOLT+C+Orbk+layziaK3++Q5v+z21388ZOs
	63NQ12T6YbKPsOlZBlL6w6r7OZJoJ1NV8PaYdKpt+fp5JcPfACgH5eTYyQF/fiJ5
	iAHaOu/nJdPA3TEV4OX1Y6FFe2HEX82qGiXOsf8J1HmGIm4sfE8ie+Se+j7XTqaA
	KE830TETnMLN9HJ442PPykt/9JW3h8g+6zWsywQYQexQRzv0lwqyC8fiDW5vtYd3
	RIr6dOa1NkKJEpZ9O4Gfqw6uG/fTz6JbekQ==
X-ME-Sender: <xms:JemsaFanciC3zyxNIklqpoVLchoR4VxXMyha__oqNcBwee5-xIdhMg>
    <xme:JemsaE3eM_NnyqUUw8_u1tAnzoxyWLVawcPd2R8b8ZUY6yD5m8CHUXDxf_11T1Poq
    yfsWjl6vMR7uONZqg>
X-ME-Received: <xmr:JemsaIZEuL99aoqIN_8VrL4VqxITyHBDzEb29gAah9N-BG-dKAierfBG394NEB91_BVwXNpa1aHIJRlH9PFZa4Hp1KXmlx5OnBy_FjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeefieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtoheptg
    grrhgvnhgrshesghhmrghilhdrtghomhdprhgtphhtthhopehnihgtohesfhhluhignhhi
    tgdrnhgvthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:JemsaEJgA_Xlw9yxmIMmC5OMde4-XDSPjWz6XVeZM7XUGL3Rgs__Bg>
    <xmx:JemsaPFm8-I8r06q9J-E9BolQ-I_1Ngz93oKi_XyFwK93HYO6TtvVw>
    <xmx:JemsaDvRU0IpAc7S26pHH8hMfRm3SU38w9S1sopjhcrdxcQC027eRg>
    <xmx:JemsaGsc3ZZm7ekF-CLcz0DJW_Cp7AezrOE6Fqued1ohl09BHOlHww>
    <xmx:JemsaAjTNdNBWqBPa0eSg5dUpm3-r_hR37ksc5ueffeGLDPdPRZhklsP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Aug 2025 18:52:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
  Nicolas Pitre
 <nico@fluxnic.net>,  Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= via
 GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v2] progress: pay attention to (customized) delay time
In-Reply-To: <7b848623-ce64-4679-9b5e-9d91d947b269@kdbg.org> (Johannes Sixt's
	message of "Mon, 25 Aug 2025 21:16:12 +0200")
References: <pull.1960.git.1755955377.gitgitgadget@gmail.com>
	<86bf04c7-6315-46ef-8297-42efc3ed322d@kdbg.org>
	<xmqq4itxvi3z.fsf@gitster.g>
	<08f405a6-fd2e-40d7-850a-574356b4009e@kdbg.org>
	<2d56de10-f829-4bc8-9c76-76eab6b137ae@kdbg.org>
	<xmqq349fs5ee.fsf@gitster.g>
	<jq5ul4zwdex6peuub3upwzxz3d5zcnuh7adseyg6wa6dpiu4ci@fuwe2t2vbguo>
	<xmqq8qj7qlqf.fsf@gitster.g>
	<7b848623-ce64-4679-9b5e-9d91d947b269@kdbg.org>
Date: Mon, 25 Aug 2025 15:52:19 -0700
Message-ID: <xmqqh5xvnhek.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

>  Compared to the first round, this replaces sig_atomic_t by int. I
>  didn't use bool just in case the patch goes on top of a maintenance
>  track that does not have the "bool is allowed" policy.

That's fair.  I happened to have chosen v2.51.0 as the base for v1
during today's integration, but as a fix-up topic, you are correct
to point out that I should apply this on top of maint-2.50 or even
older.

Thanks, will requeue.
