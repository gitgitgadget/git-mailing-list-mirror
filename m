Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394CA1DACBE
	for <git@vger.kernel.org>; Fri,  4 Oct 2024 17:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728064498; cv=none; b=jq3KBRDvfhx0dAcSZVRpBP2GVMut//TD4Ew+ZKKzG/DEkpc3AVrkRjPUp4KBqftzka3DKcqZdZDl+DJmGQzYaIis+e2H2yfQhI9FxoIW3/clFxECO7msRffD1/rOny5WPjddbldSM/VqPhhdSDqyEsu/XvGlo/sXh/xhRrD8kHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728064498; c=relaxed/simple;
	bh=4VIndOCRK8gjE4sxyRs/CLvYnunbLEBG9/1hgi+PVIQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E6+V340iyE7yJzoM133wD6d8JBqyfFd/85zngS8q+dEwraiwjdNw5cWXilQk9VnLmpUcKoPwzhgBIwBh5MgxZPh7CuYh8nbuK+KaCSORInZLKAhGbL61gwWKzJDZ59pkZD71nbblLSU1YbvdHZMZzCzEYV7Rf5NJjqk3eyn+Jlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YtTHfh9V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EsOJJh9/; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YtTHfh9V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EsOJJh9/"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 549BE13802C5;
	Fri,  4 Oct 2024 13:54:55 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Fri, 04 Oct 2024 13:54:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728064495; x=1728150895; bh=I12CQTbF7V
	DR8Qoman/+7/5eq+JEWs1UarNQvRQ1YJ8=; b=YtTHfh9V8w2426SKF9aHLOz1VK
	K/IqRMQNzEmfd6TVgwL4GzSvthDsvvIdCqJwGV1eF1s3ZXpRcf+wQ9cf8Jp9kV3R
	H+edeIGTVx7/BYhdpehciigaSebhqtuH2JzsHu4/NqBexeLlfuyWTvU5LnyqlIZN
	q7DuF7bwMwOGiIY0jlu2YT6K0QzEEk1ktxgbrI1D7XX9Lb0m951cRdaHhoO5Ye8S
	v6whFDD5OTUr7BXZsVdR786Jj0xgVy72lEBo6ZahEhG3g6Ws5LFy4Z/mT3tJy6Z9
	jXuw37PFCGGOCk+fSTOsgA8FnbaS/airBWYJa8qCY1BfuKsFv6hZofAevBjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728064495; x=1728150895; bh=I12CQTbF7VDR8Qoman/+7/5eq+JE
	Ws1UarNQvRQ1YJ8=; b=EsOJJh9/Rfyj9Quojxizjc4iDVxcdftqGnD0wusDKhU2
	stS/GjGl90sWjzNsYgCDoqGoeFn1kQ+Yk2u3o5vWVLw29QQvXfIq1m2jh/fZei21
	h+Wj6TU2VXpTLwo5NzEFVMX/bA43fgR6Ojy9Ku5Lasheou/x091hZwy7VyCBNBi+
	Ii0vUkGWN/zt8TmwXvqmYROkplfa7IoRmZmMySfOc58OmNSHPcfLu1Ji3uq/zHUb
	R5RHGJ7Oqqg07Ql3Jq98TvVM3w107z9j+TUNoFfnKElsHVQfTKojOrey9mObqb4B
	iFYRMiKKy/POElTcfdUbkDLefNA8IUZEhs7/NJBbtQ==
X-ME-Sender: <xms:7isAZ4mqctBhpx357l3JO6cL68dh39Vw_ogdsaPRdJfvl9us4aM76g>
    <xme:7isAZ33OSxJxjoo81nEMwr8hUKZzxsmimqn30xLm3AtqIVUmYhkXLO-a-vZpv-bGH
    HR_6BlF6mqYAcSy8w>
X-ME-Received: <xmr:7isAZ2qRZ57Q1F70fUbV1g8pgxLWWn83e4myg1syimg0Nstv-3SiRIfAwKsdveiJhewrOKJl62nz2LpXUwcPy4VAtUb5ISHov3EvPkQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvfedguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggv
    pdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:7isAZ0mSWb0pZ5e8-U2hp9JI4cHsFqWNG4wW053HfznoAaAcOFTKng>
    <xmx:7isAZ22jIH5eFSwoja0GkUlmCuHX5XNQRkIcaGjUjYMnQJDaIXaHFA>
    <xmx:7isAZ7sfHLYwypTRjX0X-E1F4AJ9vudr8HUgTkbeagTvNW81LGSXrQ>
    <xmx:7isAZyUWfavsmZINXfhaD66Bg-fUsFb8LWcH5h6-BVwZ4Lg0QGhslg>
    <xmx:7ysAZy_Bj_aCJBiKqT68wRTa5DJCZeBFR3PtpjlqwnDWykLmVRaUCxWo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Oct 2024 13:54:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Ramsay Jones
 <ramsay@ramsayjones.plus.com>,  GIT Mailing-list <git@vger.kernel.org>
Subject: Re: v2.47.0-rc1 test failure on cygwin
In-Reply-To: <ZwAiXuNPK_SdnfEz@pks.im> (Patrick Steinhardt's message of "Fri,
	4 Oct 2024 19:14:14 +0200")
References: <b1b5fb40-f6c2-4621-b58c-9b7c8c64cc01@ramsayjones.plus.com>
	<Zv9oIrKveu-JAGQM@pks.im> <Zv-HbT8qrM6IYKb4@pks.im>
	<8718c5c4-1d0a-104b-eb39-6338ae9c5dbf@gmx.de>
	<Zv--68J5qv60IuQz@pks.im>
	<f29241a7-aadd-e824-97f3-a95ac6619951@gmx.de>
	<xmqqbjzzg89u.fsf@gitster.g> <ZwAiXuNPK_SdnfEz@pks.im>
Date: Fri, 04 Oct 2024 10:54:53 -0700
Message-ID: <xmqqed4veosy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Right now I don't yet have a good idea for how to fix the issue. I've
> been trying a bunch of different things that, according to Windows docs,
> should've made the renames work. But they didn't, and I don't really
> have an alternative right now. So I'll need to keep on thinking about
> this, and maybe get some more help from people familiar with Windows.
>
> So deferring Git 2.47 because of it probably does not make much sense
> unless somebody can up with a solution. Also, as noted already, this is
> not a regression, the behaviour actually improved even on Windows. Not
> to the degree I was hoping for, but at least a bit. So that's another
> reason why I don't think it is worth deferring over this.

OK.  

I was thinking that we may need more time to cook the real fix on
target (read: not Windows) platforms, but if that is not the case,
then let's stick to the original schedule.

Thanks.
