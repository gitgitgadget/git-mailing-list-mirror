Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5C915250D
	for <git@vger.kernel.org>; Thu, 25 Apr 2024 21:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714079634; cv=none; b=saO7CSl0J0qSNUpYT6K1QQCo27X1Uo5LQ5LyRobgtITwkgUXEAWoQjixgouEPRj7NZsxE5kEnKWXhryodthd9QByX6HTGUwA0c/sATIFwpH324dvJFdL8wDq6RrUSpyu/JsD0TWByXPoE9RSg00BC1+A6nLdLMPiOJZQ6NU39nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714079634; c=relaxed/simple;
	bh=uqPcOWCHYKugbO3SAaF4uq5fLNGyD4PtNaQn5oDr8oo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GbnN4VWqdbA0QftX8PllYFe6tjjbYEn4IAG+4hj3rkx3TWU92ooWUcTxSwX9wmQ1hK6jx3Od1JTayRr2afpIlieu69lvYR/opRtmSnsFwzzK579VuLL8u0DlJQIo/AoB7rFwmqBdINBUK+YI0dl+kzvXK8ax2c8oE9EaNdCW1sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZP1tK+zb; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZP1tK+zb"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 086EF3EE92;
	Thu, 25 Apr 2024 17:13:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=uqPcOWCHYKugbO3SAaF4uq5fLNGyD4PtNaQn5o
	Dr8oo=; b=ZP1tK+zbhjM/NNcaB7USqoeHCOs59HB6Jk3JMskS6aKk453ErrLQr3
	yxO2X3FTsViY45wGuNNG/0zxjfljM4ZxlcwJ0XdiSgZbkkBL4c4nfXhaSBZa5ixs
	G6vUAuo2ZmFh68L57BVUqfMHLfrlPqduZsXFj9iJjFuf6x9OVG/UI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 0017F3EE91;
	Thu, 25 Apr 2024 17:13:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4F1333EE90;
	Thu, 25 Apr 2024 17:13:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Jeff King <peff@peff.net>,  =?utf-8?Q?Rub=C3=A9n?= Justo
 <rjusto@gmail.com>,  Git List
 <git@vger.kernel.org>,  Phillip Wood <phillip.wood@dunelm.org.uk>,
  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4] add-patch: response to unknown command
In-Reply-To: <CAPig+cRerw2SnkEK4-_wiPopGii+Eq92UiBmqib_oBgArty-Gg@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 25 Apr 2024 17:00:27 -0400")
References: <4e2bc660-ee33-4641-aca5-783d0cefcd23@gmail.com>
	<6d421c67-9e10-4a7b-9782-38ba8e9da915@gmail.com>
	<db1d540f-30ae-4d4c-883b-088bcfe68140@gmail.com>
	<b209a2b8-f98f-4f14-a687-9022d30968dd@gmail.com>
	<20240425014432.GA1768914@coredump.intra.peff.net>
	<CAPig+cST4_hUwWg+P_drqT-mv8+eLAzBmuMFXm=Dui14kfYZzA@mail.gmail.com>
	<xmqqedatfay3.fsf@gitster.g>
	<CAPig+cRerw2SnkEK4-_wiPopGii+Eq92UiBmqib_oBgArty-Gg@mail.gmail.com>
Date: Thu, 25 Apr 2024 14:13:47 -0700
Message-ID: <xmqqr0etdu2c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B5BD911E-0348-11EF-9453-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Eric Sunshine <sunshine@sunshineco.com> writes:

> That was also the adopted solution to the cited similar example[1];
> git-worktree was changed to send all its chatty output to stderr[2],
> which was appropriate for that (non-interactive) case.
>
> [1]: https://lore.kernel.org/git/CAPig+cTGq-10ZTBts2LXRVdPMf2vNMX8HTuhg_+ZHSiLX-brOQ@mail.gmail.com/
> [2]: https://lore.kernel.org/git/20211203034420.47447-2-sunshine@sunshineco.com/

Hmph, what I just sent out tries to send everything to the standard
output stream.  For an interactive sesion, whether the interaction
is done over stdout or stderr does not really make much difference,
but I have a slight preference to use the stderr (because I view
prompts etc. in the same "chatty" class as the progress bar), but I
do not care enough to go back and redo the patch ;-)

