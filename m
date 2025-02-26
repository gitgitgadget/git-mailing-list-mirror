Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C74A2904
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 15:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740585314; cv=none; b=PolIEp2EeiU8IE4+ycyR2obwMZHPQv4bJpI2WOb65akxjZMQwKDQwhMO2YhJE24pyLgwBVKwNs74BGMnb8ZsRMUxG7XYsx8K0Plqefu/bZsJTp8M6xoXQldCEFwxHOPhN2E/sjmBASVKMcFs8nueBSGppjfZSGv/9sdurv3QlO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740585314; c=relaxed/simple;
	bh=avaJIy9FFPQNKGbsX87wVt/VDITuxKWVrUwPk7KaZeo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qc2xTKJNXR8HFgP7GoiQEOeu/6VtslETZhFrAa7/IuqM+sb1xNjs52Xnoujk3r0Ouc0tgvW2F6iqvCNpYXue1JWsqD/hGjNitBPAkKDBGTYLrSb9Le0Ac+VnQSNyatdEipRoUOpwKUYIQkmtqdOJjVMEZYbL65AJ0t+4+gmHsgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=B3lrOt1o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=quuVkL5c; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="B3lrOt1o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="quuVkL5c"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 6C4AA1381122;
	Wed, 26 Feb 2025 10:55:11 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 26 Feb 2025 10:55:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740585311; x=1740671711; bh=IX0XnJksL6
	jR1qtaW2SS34kjcjcC27okZ1t9tczYJrA=; b=B3lrOt1o2vGVQFs9/Wgv6f6sAL
	E5xgJHYgErrdanNuNQlfWYoPTDcsHeqf3SAPATJASIpCnmRESB7bT0E17PhSIq9y
	k2+1o5h4VS1TLugFv25diAl7mVazexlnsHUUXYWCJnReKBuIsfqIPXgHsmoswzQZ
	PpJRzOJhwbXibJoK4lM+SXJ9D55cfPHvoYmAd2mj5035Vbl1P4Ky94i15OVAFq66
	PD9Os2MS5ZcGz9sDQ7GXT3ZBQJfeFn+oAgxEZrTOdjGivHSHbIqEhyUFPjG0GJ8D
	DZvZOT1hyRIqulEC5P0LWCgCl1IM35Tg9R55GiK/QhrMccdFVop1V9HqDAfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740585311; x=1740671711; bh=IX0XnJksL6jR1qtaW2SS34kjcjcC27okZ1t
	9tczYJrA=; b=quuVkL5cd/ObUcKxx4AqMU0l6v5Hr9ov1B0N+Nvb56dVQb0d5cf
	/0lDdvIOqy/tzbZ1AWuQGXqOhtuAaTp8QHDwEqEMELDZfEt6wdqF6uA3yUocW4wg
	53elVmcZJwYZwz4iDW6AadiKQa7vLWiaeYcQKNj+l1t3jlYZAFd0aZ8Q0H22c0dm
	cX1UZEcXTFNqd5kbRYla/0BInzctVh1kCKFJa3gxHIv2hxES9hTdPTLaeSrHtCH9
	tWbtbcp1aHOE6rpoH22Tdrya1RPaIWIZIglIurPVzADoF1G28kWaPTVgXldr3D9l
	XJmxXD4yiu/ywvimoX29n/Akdu8185U0Hdw==
X-ME-Sender: <xms:Xzm_Z4rC7aKwNK66qeGk3A7YSiUK0OimBSXmcD7frbjtdF_wkKe1lw>
    <xme:Xzm_Z-rsMUcLe6FHLsTiWv_oUvgHn-8Ao0SY5UB2Yf4YGM-UhLCV6a_RG4JlLjS5R
    pKPaA5th8gTqzfzzQ>
X-ME-Received: <xmr:Xzm_Z9NzNHZZKBPgU8jxzUiAbNaI1gRFSGilqHtw2qVzVq39oa88I2jFPihgkcidFODeAto7CuwHtUIoFAlqYgeMdLWa18IhfA0k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekhedttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Xzm_Z_5OzHkIzdoLOUrbC5vfiuBPDOe-iHVfSeB3etn3XHshz4tUeg>
    <xmx:Xzm_Z36aYb2z9i6QXvsP2fp3C63raLbSXt97TJENZ33Va61FO4zlVg>
    <xmx:Xzm_Z_iXaoSJ4ZiL0iXF61JfWapbkGmSlnXJTYdffsXEEyicHss7hQ>
    <xmx:Xzm_Zx4WKcFMhJhXpE_qLVhIY69Xeqs4htVyoL2j-FwcUY25i7CkOQ>
    <xmx:Xzm_Z5kEoSoxVf1Ps7ZPdUQlpFrk8FC0aa8SB6ZVsoGCyIifnLM2PtCB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 10:55:10 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: win+Meson test failures due to ps/build-meson-fixes-0130 topic?
In-Reply-To: <Z77EJRJwPDGUglLk@pks.im> (Patrick Steinhardt's message of "Wed,
	26 Feb 2025 08:35:01 +0100")
References: <xmqqo6ypiz9w.fsf@gitster.g> <Z76qYgV7B2eUJHiP@pks.im>
	<Z77EJRJwPDGUglLk@pks.im>
Date: Wed, 26 Feb 2025 07:55:09 -0800
Message-ID: <xmqqh64gg0pu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Okay, the issue was in 163a3e97ac1 (meson: simplify use of the
> common-main library, 2025-01-30). In that commit we stopped using the
> common-main dependency for a couple of binaries, including
> git-remote-https and others. What I didn't realize though is that this
> also made us not use the linker arguments anymore, but those are
> required on Windows when linking an executable.
>
> I've kicked off CI jobs on GitHub to verify that the revised version of
> this patch series works alright. Once those tests pass I'll send another
> version of this patch series.

Thanks.  What is a bit more worrying is that you earlier said your
other CI didn't notice anything funny.  Is the reason for the
non-breakage also known (like: the two CI jobs build things
differently)?

Thanks.


