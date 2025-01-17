Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3AF1A257D
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 19:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737142323; cv=none; b=VX/JXEWFp7lD1ml2GGxGizSuCrgVAXlTbGwc5bx1TqzBQxnHJHD71+LwJWZe08do4i58T9Ikdq98XQx9aaE3sD976wYEeftJ+0HGgRR8GdLUDLe8ii3WpWbNFiOxD/pZ8ZLDWQscEF3QNOofzpgz2OlSMd8J6mbex/9VeAc8Jvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737142323; c=relaxed/simple;
	bh=EuIjKa8Sf5o45oAQumMpYFR9E0ch797FQCFCjsLdgR8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MfzUNxTco8v9niZxU5q6yafIFqWVpOZkWOuXnk74KKT0yPgAmwAE+dRlmNKfHWIuCzExTPToQSWMK0JYIsAEH2zd8vaDhPnAgSXVerYb0gGvQMOCrl4isH3mG3HYmsF+J5IqKGFrMkXR/kxHQGEH0lkdgvL+twY2N4I7IqlW9gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=0uDP92g6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HmKdqVjD; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="0uDP92g6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HmKdqVjD"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CD62611400B0;
	Fri, 17 Jan 2025 14:31:59 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Fri, 17 Jan 2025 14:31:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1737142319; x=1737228719; bh=3Dl8EmYoAZ
	Rzfp+UI0DJSUMAgk1NeFYPz3WlweNm694=; b=0uDP92g6nucuBZHLdI9h0UKdJI
	PK3BP94xysqkz5HGDUKiiszHB7vaVM+/oSKk/qsIP8q9raSsw3vMZt7NeyNOc5LK
	smuFOLRKxl5VX0EbeCSn6EURRBmio2bPwMDBnMc28Wcno3FIVx2xWWUsLDQYsqcc
	ZjJ2hQcmrx+geL6VdczkKnxR236fSyR6s4MT6G/QeOHM+Z8higD8Q+KqM5DgCpBl
	HCzeya0r3Cx7Y27kaOPNCwwbBbIMyZBXM6+QKHwAUFPfwuh4s0W1MLSW/P5kVOWI
	xnT4N+uHMuSuxQptTsevzMppH7wtLM6ynz6DW4aYjIG+2PEggPlIvpW9WayA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737142319; x=1737228719; bh=3Dl8EmYoAZRzfp+UI0DJSUMAgk1NeFYPz3W
	lweNm694=; b=HmKdqVjDVQzQltqnnS7zYGEys1L9FXUXmG539lNhlzHvhoUKJUX
	/IZfuqRRnzm4a4kKgmieINdHzqKTF9QPmS0ZyaL+6xz6Q7gvSidjFgY1re1z11sw
	rGyWgnXOexjCDsMzG3DACGhq1po7eaYbYRUlEdF0yPbE/v1HPAnpfSypyZqjBvZt
	laQ0Y7tDEymogf7f/wDNTShQO5zqUAQLp0MTUs0ejHIv4bfX768uhNOa/0TZ/fUd
	g6xtwlzXBxdxm9jgQoOzwPMdQL2E5H4pSyGS+RnjgL9u5fdc+zFBd1Az/+ThCSnx
	OlGnMgZTs2m0cG6YLuYINbbCY0u3uZpOBmQ==
X-ME-Sender: <xms:LrCKZ_y9_lQmHEdo1EOHvrHBQ49egbqmJw7Er4IzAsMB1apLHRistA>
    <xme:LrCKZ3RobQO3DI_IjQ4ezYBHkET9IhK1qmns3M0EvL62mmZsFpNgLukdzmzx0fWd_
    MGK7fLmVrWhBamKqg>
X-ME-Received: <xmr:LrCKZ5UJvptRtdVjh_roO-Pb82uMkwiwphzDF40k-ww-KDSqyVpjZgiE9OCMn3cesdrc1denCulO8BfGOj_Ou-jly1ETWV0OCAak>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeifedguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuhhsmhgrnhgrkh
    hinhihvghmihdvtddvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohep
    jhhohhhntggrihekieesghhmrghilhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvsh
    drshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehmvgesthhtrgihlhho
    rhhrrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdroh
    hrghdruhhkpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtgho
    mh
X-ME-Proxy: <xmx:LrCKZ5hexVz-KGzfwlvhPPUaA2O9Yw0PFR0B5N_jUhJcA_lWyxMRTw>
    <xmx:LrCKZxCbaROS_biCNlnAc7-B5GMJ8PjglW0fOEervVkcvpwCPueJHw>
    <xmx:LrCKZyIC7nijz-3xcMSIyLB3w7NCPjLUWk7JCCzyRKgat8cPOoCIeQ>
    <xmx:LrCKZwAGNzmhMXlZrMzf0yXrupW3daKNyjqOv_FZi5E8TgXFEOMmFg>
    <xmx:L7CKZ16GsFNyjSP9Xc5Be4C069cLEhh6x8AgB30zAO4t_RZkZY8n1wMf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jan 2025 14:31:58 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  ps@pks.im,
  johncai86@gmail.com,  Johannes.Schindelin@gmx.de,  me@ttaylorr.com,
  phillip.wood@dunelm.org.uk,  sunshine@sunshineco.com,
  rsbecker@nexbridge.com,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 4/6] t5701: add setup test to remove side-effect
 dependency
In-Reply-To: <20250117104639.65608-5-usmanakinyemi202@gmail.com> (Usman
	Akinyemi's message of "Fri, 17 Jan 2025 16:16:16 +0530")
References: <20250106103713.1452035-1-usmanakinyemi202@gmail.com>
	<20250117104639.65608-1-usmanakinyemi202@gmail.com>
	<20250117104639.65608-5-usmanakinyemi202@gmail.com>
Date: Fri, 17 Jan 2025 11:31:56 -0800
Message-ID: <xmqq4j1xkzir.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

> -test_expect_success 'test capability advertisement' '
> +test_expect_success 'setup to generate files with expected content' '
> +	printf "agent=git/$(git version | cut -d" " -f3)" >agent_and_osversion &&

Is this required to be "printf" and not "echo", if so why?

"git version" could contain any character if the builder gives a
custom version string by saving it in the "version" file (we use the
mechanism when we create a distribution tarball, for example).  What
happens if it contains say "%s" or something?

If you _really_ need to use printf, you'd want to do so more like:

	printf "agent=git/%s" "$(git version | cut ...)"

Is it required that agent_and_osversion lack the terminating LF?
The use of printf without terminating "\n" at the end of the format
string hints the readers that it is the case.  If you did not intend
that, perhaps doing

	printf "agent=git/%s\n" "$(git version | cut ...)"

would avoid misleading them.
