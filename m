Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12324D90CD
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 20:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786047986; cv=none; b=d8+rPHF65GhPDFw7EYhRA1ATjEdIHKm9ING8Fh7BcAIGUZppuLleCmPLl5eNQU5w2MATo+mFwTa0PIeBztpRa8dMxJluoSP7AXOjvwKLxLmBtLQlAo/7YTQNYVr+wmqDBntoSvzJuOuyux/aS/APNE5G0ANqFLde1IcXWqIx6nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786047986; c=relaxed/simple;
	bh=XdXWOMPT2imtkAiFWi6XZeymtdFCN7QBUKL9yq8qITM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hrvhza5u+ASx2UhQlq2pP1FK3sCMhr8hdbqe78fULrE20go14ymsQHdMrQtlxcnovpuz7aYkcIa3VFpq6duxDmVa+CHn09Nf/68eWSCvBSIW0BNH4XxOr5s4boDe+rf2xe/M6lhYULOzl7O7Znb6Fook9vlaM5MO1PmXcJb2aIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rFP0cyuD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OGRr+TVE; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rFP0cyuD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OGRr+TVE"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id C89861D000F7;
	Thu,  6 Aug 2026 16:26:23 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 06 Aug 2026 16:26:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786047983; x=1786134383; bh=MmGxlV3Lkt
	miwxY2BHMI/XBofhbnJdsvTJEDcL43ZeI=; b=rFP0cyuDJQG3WOyGyNc4mWJl2f
	ocPk6Wrw2edMdb4FnXosgKrcoNdEjmzArEGrFy0MLLLxWU6g2DPb4JMduTa7CiYk
	/FGuBKv4RwAFIT4+3myit6FlYs6Y9iLzSbycA6yxFkqppCDUK1nKNWWVMZy/iZQ3
	bUlKqCWMG9FgzdKieeIJSZh5js9Vtyn3yKYMxG8QCSljt6vO7PjA5D8rLuh7dz4f
	i6Ly84YSXQlKLJ6VPB8CAXc4KMLLa3aGae3kO4qnqzMiXoy49zYqPQK5PRCVZIi6
	6tDFJW7Gv8JqdOsrdVst94uceZ9ezwuV48GNpAwyHgcwwRSj5iThfG2WQ/WQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786047983; x=1786134383; bh=MmGxlV3LktmiwxY2BHMI/XBofhbnJdsvTJE
	DcL43ZeI=; b=OGRr+TVEG7EBKMrpV+mqtadRDQ3bXrLAaE9SLa4LwdaqtjePcC4
	NsjVoUmzggo5nZ4HGGnh+rRpj4S3xRivPUqHuc2nIYm47JJ9jRZvIhhmLQURGc+P
	gyHTxSi1Ua4um9J4Mu0CIKdNQ3OHts5D5mKj3seUVgX3twWcSfeLjAtehysSYi9B
	N0kes918xUCCqOGCF27oJzuaHF4xj9uIY0fREeDLxmKq914JeOHbv0wX3y//E6CQ
	I75a265IwsWbWW6bPK7yGoDVt+uYd6p/+CFWgRO5yo3EHN3pDAiiCbE89gN4gDBc
	CaJFfWoiTN8mMSk0VCUBffJJItBge6N12dQ==
X-ME-Sender: <xms:7u10arP9xF_zr01wKSEM69EmT8O8oGazNzYqJ_qL04urwXj9yrZbHg>
    <xme:7u10apDYRw6Q_Jy66QFLqIUUeLJqwWlHCrJKJlZNrN8f5ntHgEPd2rNHa1PmJ_Y4c
    IQnYIkzJ9CATPoZHA2aVqVpxbVwQu_sYJZQeUCvxSXzV1gcKjlESQ>
X-ME-Received: <xmr:7u10ak5tBoLZaSlqRl81yIwbRyHcteRpOWDU6PhKcAsAwafHzwpETiBtTFHYJcKYDwo3NvSz9hbUfprFvgmzkonPZd38Yc3EHg>
X-ME-Proxy-Cause: dmFkZTF4ipjblrwmJoenfCnnH6GLlxFq+QgV3zetllyyylRsPqnzo9J6V8oo72Z/eqvTDr
    a605QypEDUNagONeN64h5O4r5d95CT+WGDu9TeZMynfmAtWGyOE6iTFfhQUo5aHkEEFHzY
    Lp18Kx7NgK1/onUm55jA/l5e37kDiPzW3kY31OV82uMxuzq71Gb22visl40UspPbsFjtPJ
    7X0flWQBA0GI9ERnSpV7s5+rWlgpxCnL1qcQtrO40G48Rco6LsQHgIubzG6esjSpOsCqnV
    XvNfE4AzIp5YuvF79DPDDWMyVypsXIh7vd/5KH2d7Io5BA+7ZvU9sGarMxibXKrl6kxYnQ
    +3wuTOD/gd+ohXh+Eiym4g7kh8DRoC+dGJuGIpmc6FHanNOCjdveURwzLSKb74/isRHUrP
    89ZvfLQj4rEZdNoaKkzCBSym5ZMoMY44FFdybaKcxBF5DOC8XkPk2m5yl9o/PUlXHyvSnq
    9Tot8e1DlBjGRSHJdeB6AFQMUamUzq64CzE21KDHbDxLYiiKhDAH6beYVBL35U8VcPNWdn
    bl6a6CIX37OmuZJ362UW/nKU2D+TIBfU1xVEgZFE5jkPbByXA/fAiwiyEyTVw9S6epx0pm
    N31bwoh5cuLQigM4Jf4a7/mB3dd+2o5m2VQIDlOIiZtc7B3J4Mvk2tYNavmQ
X-ME-Proxy: <xmx:7u10ar4V22ME-agW3IT9fWslJePhWYqboiNpiUBlIe_vPI4gqAplkA>
    <xmx:7u10auReubw_P2qZHwgILOJadCDtRuyQ5uAoS8VMDrWlCnwSkypqqg>
    <xmx:7u10ar9P0Nomp_CPIbKvpXSAy0DNWVBxyd0WFeorF8iRRl80Sy38QQ>
    <xmx:7u10anZQ5gG1S_nIvDHoNCp0AvKV1PH0cULtYQhYqdRsH9yEHWAImA>
    <xmx:7-10am41dY8ocgj74efFsFCwAzcLvU85BkHWpmnEIVvK-88sgYCRbgPd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Aug 2026 16:26:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Johannes Sixt <j6t@kdbg.org>,  Ben Knoble <ben.knoble@gmail.com>,  Jeff
 King <peff@peff.net>,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  "Randall S. Becker" <randall.becker@nexbridge.ca>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  git@vger.kernel.org
Subject: Re: [PATCH 0/5] Reintroduce writev(3p)
In-Reply-To: <anQpop92SCAA2C9z@pks.im> (Patrick Steinhardt's message of "Thu,
	6 Aug 2026 08:28:50 +0200")
References: <20260716-pks-reintroduce-writev-v1-0-ea9038c884bc@pks.im>
	<f8050598-392f-44c9-8d66-0454740a7a12@kdbg.org>
	<xmqqo6fso2s8.fsf@gitster.g> <anL0nIk6uzkYR9Oc@pks.im>
	<xmqqy0ekr0bm.fsf@gitster.g>
	<2952d9a7-c7c0-44c0-a321-7ddad6497a6e@kdbg.org>
	<xmqqpkzwpg1g.fsf@gitster.g>
	<8ff3c3ea-2604-4d65-8a7d-6acd6218b7c2@kdbg.org>
	<xmqqa4r0payv.fsf@gitster.g> <anQpop92SCAA2C9z@pks.im>
Date: Thu, 06 Aug 2026 13:26:21 -0700
Message-ID: <xmqqcxvvhu6q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Aug 05, 2026 at 01:29:44PM -0700, Junio C Hamano wrote:
>> Johannes Sixt <j6t@kdbg.org> writes:
>> 
>> > Am 05.08.26 um 20:40 schrieb Junio C Hamano:
>> >> I think it is OK to explicitly document that any writev(2) emulation
>> >> is allowed to be non-atomic, and it is also OK to declare that using
>> >> writev(2) in this application to allow competing writes to the same
>> >> destination is a bug.
>> >
>> > These are fine.
>> >
>> > But I'm not worried about current uses of writev, I'm worried about
>> > future uses: "Look, we already use writev elsewhere. Let's use it here,
>> > too, where we can take adavantage of the atomicity of the write." It's
>> > too easy to miss a note about non-atomic emulations when the function
>> > name advertises more than can be guaranteed. For this reason, I strongly
>> > suggest to use a different name.
>> 
>> That is why I added the "it is also OK to declare" in the above.
>
> We could of course trivially restore the non-interleaving property by
> only ever writing the first iovec. POSIX doesn't guarantee that the full
> iovec is being written, and write(3p) is already non-interleaving. It
> wouldn't even be less efficient compared to the current implementation,
> as we have to loop around write(3p) anyway in our compatibility wrapper.

OK, by castrating the writev(2) emulation implementation to write
out only the first iovec[], we are making the emulation "atomic", so
there is no need to say "your emulation does not have to be atomic"
and we can rely on being able to pretend that we have writev(2)
available everywhere.  Also, it is a bug on the programmers' side to
assume that their writev() calls will not result in a short write,
so it does not have to be spelled out, either, which automatically
means you'd better be calling writev_in_full() and not writev()
itself.

I can buy that.  Clever.  It means we'd need an update for [PATCH
1/5] 1ed0bc4e3b (compat/posix: introduce writev(3p) wrapper,
2026-07-16), right?  The update would be a simplification that loses
a lot of code (and overflow check), which is even nicer ;-).


