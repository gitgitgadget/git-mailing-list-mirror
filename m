Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC53529A1
	for <git@vger.kernel.org>; Sun, 25 Jan 2026 11:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769340317; cv=none; b=m903e/Zu0sxXXDsqffbUvUgSBgax+FlJAXNGmzbFUvFHJWLTQK2f/X10vJYsXEgrdnmMARAlhNG0pjLBYGXaz9uev5cGpMQwkYVkf+xzTac6upx44mjdCIfnyfYp+DWDsdPp+U+s32OdvZxP5h5SpI/ucWGTpYXthlnx2mvY2xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769340317; c=relaxed/simple;
	bh=8k5AUnFcPiLv3/AsKb49fRJjThjv4FynlwK8HSuPLdM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Su/U40AczV0XbmqSztZMjDWZ85CnKRxz7p9VpHLaa/9W4BKQqQnb1HaLBjvY6VgB7kDq6LtwGTjiY6HUKYE2on+yV44W5WMEoGwj1ElAzjv3rm7+bh3yxlX6nU7Qn64RdPsXD40xto6EV8X+2TvtTsGyuQmkwXeWZYxLbQgFVCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=cewq0PID; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ys5VIQSp; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="cewq0PID";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ys5VIQSp"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2A9197A0103;
	Sun, 25 Jan 2026 06:25:15 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Sun, 25 Jan 2026 06:25:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1769340315;
	 x=1769426715; bh=6+Z4L2cp340pxibVO+/0dlKQjptKqnD1YBMMdOa/66A=; b=
	cewq0PIDwN+CsPQPHyhsk1pgD7e2UmF6W0bhjAoh9nBE+bfa9/o7CTy6yPtM3jiK
	HG61qo1Mj6o0kykbUE4BZ6Lvr4ib7u65uF4YLwWX0eEnoph5GOWc7tAzk/T/rDDq
	IVlCdKYP1H+VDx0AB0VDSLugNfbc/EdaOKMrr+ralnGwZnvcJYXxtyWQSIGu8L+D
	G3MzWBnnNG7S9E/opw7ycQ9k5CQ2lMme2UytWW9hT1EWoN6jrQVR1e/sosOoiydv
	l3z5/j+Qpl2bvXAIJ7b5wdfWzciDpp9NzGi95GyQGiPePb7LMn95DAN0g7bFY4C2
	fygIT5g+CwVuL9B56bxklg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769340315; x=
	1769426715; bh=6+Z4L2cp340pxibVO+/0dlKQjptKqnD1YBMMdOa/66A=; b=Y
	s5VIQSpTUjdHuRapj1WlFia/oJbCj2pTcipbMeUWd443bq1Ls+st2a4E7ltmxzK9
	P3+ETE/CihqLJcA9CMa/5PW5/QZVWRhrwALZIYyJnS/QClwub0FtYfzP6V9gdqGY
	Q/UgdKHka2pcUFBnyNaL5jf1Yfe7TEpsw4/RZsJzIkSbAwl/mv2EzXJtG79CQyfW
	+wFF+ipYCA3FROI0oJSQykZSDWKQ8KeMq08TRvKshpBhteGCfOFGEOibgZtDC/w0
	NeV/6monU8ggzx2Lx4eAU/kHN4iiBPWPQwbja01xyB4SiXKQ2688tA4ZrzOMifbP
	/vXRO6NPcniLSXtGtp+Ew==
X-ME-Sender: <xms:mv11aU1zL4ZplBpf50QckiU2JarXZTTqra8jGKVZfLT6i8IxO4_LsB4>
    <xme:mv11aZ4ZVrC8IOHMW2U8BR0smxhSeL9Uqrn0LpSE7EghI4qd29nIrokLafIGamnBO
    C9RT5-OHJruYmIF5eeYv-5RP_JsbE-0ONrV1Iq8myzz8WGo1eDS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheegieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgedtjeeiteeg
    hfeutdeutddtiefgvdegteektdeutddugfekleeugfelteffjeffnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehguhhsthgvugestghouggvsggvrhhgrdho
    rhhgpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:mv11aXzRFXGuih2swJzpPiMhyWapA6RyoHYWyMwqCBKzkq0y7o_MbA>
    <xmx:mv11aXAdmk-L2ea8VkWj7A5IL6uWodB-ugImzodgeWTvV5JyhVVodg>
    <xmx:mv11aUaksgjiNNILAdN8xSffJ3xX7950sD-ehop4cs0fjK6nmBwtEg>
    <xmx:mv11afhWwGKP65DQ-CsW8uLcZxRHXpOuk-09-FhzqviTTLgXAYrXdA>
    <xmx:m_11afQzEi5gu8gvUthvKn4kEpLmsCaVEod-NktFZh1piT966iIvE03J>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7F1811EA006B; Sun, 25 Jan 2026 06:25:14 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AOZQmOW8ie0Z
Date: Sun, 25 Jan 2026 12:24:54 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Toon Claes" <toon@iotcl.com>, git@vger.kernel.org
Cc: Gusted <gusted@codeberg.org>
Message-Id: <0b97e8fd-1dfc-4a38-9c77-22467f38fd3b@app.fastmail.com>
In-Reply-To: <20260120-toon-last-modified-zzzz-v3-4-9bffd4968b0e@iotcl.com>
References: <20260120-toon-last-modified-zzzz-v3-0-9bffd4968b0e@iotcl.com>
 <20260120-toon-last-modified-zzzz-v3-4-9bffd4968b0e@iotcl.com>
Subject: Re: [PATCH v3 4/4] last-modified: change default max-depth to 0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Jan 20, 2026, at 22:47, Toon Claes wrote:
> By default git-last-modified(1) doesn't recurse into subtrees. So when
> the pathspec contained a path in a subtree, the command would only print
> the commit information about the parent tree of the path, like:
>
>     $ git last-modified -- path/file
>     aaa0aab1bbb2bcc3ccc4ddd5dde6eee7eff8fff9	path
>
> Change the default behavior to give commit information about the exact
> path instead:
>
>     $ git last-modified -- path/file
>     aaa0aab1bbb2bcc3ccc4ddd5dde6eee7eff8fff9	path/file
>
> To achieve this, the default max-depth is changed to 0 and recursive is
> always enabled.
>
> The handling of option '-r' is modified to disable a max-depth,
> resulting in the behavior of this option to remain unchanged.
>
> No existing tests were modified, because there didn't exist any tests
> covering the example above. But more tests are added to cover this now.
>
> Signed-off-by: Toon Claes <toon@iotcl.com>
> ---

Thanks. I think this makes more sense.

>[snip]
> --- a/Documentation/git-last-modified.adoc
> +++ b/Documentation/git-last-modified.adoc
> @@ -25,13 +25,14 @@ OPTIONS
>
>  `-r`::
>  `--recursive`::
> -	Instead of showing tree entries, step into subtrees and show all entries
> -	inside them recursively.
> +	Recursively traverse into all subtrees. By default, the command only
> +	shows tree entries matching the `<pathspec>`. With this option, it

This should be s/`<pathspec>`/_<pathspec>_ since this is a `[synopsis]`
doc. But this is in `next` so it will have to be left for another time.

>[snip]
