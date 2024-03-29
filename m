Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92124AEED
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 18:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711735889; cv=none; b=aO4oY+5DiK7lZGIO7YtZ9OAFd67Hq7SGJ+ayjSs1MhJGD1+QaqRnMaPhbAvIbDnv2nFzxSHtGJlFeTGIFaVCywnxtMZFX2ag5mT9rtSyE/eFFvZRusmWA2uTXELOv4TTWIvfFC/lKjRV1XojCzWYpzF5VfK56hFs6kETwpS0EGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711735889; c=relaxed/simple;
	bh=TFtyTBRo79tB99DnAI03kMSYaF7y7mkZDXZT3ykuzLs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m7O5iqirqEvnQZgKnAdWbUvub+Zu1Y8R0xXkiAMmiZq5bvIRTEWOTYdIhKZJh6aw9vrlLL2eO8iyNvCq1rMreMQXsjyHvNQ+g4tWqjrle8me1W0ZymN3/em2nDPgV7VhRTf993tULaPuktMZeEydrGbeZrmu1vjWLed+AIEngyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=aHnNhYW9; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aHnNhYW9"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6D4B626A51;
	Fri, 29 Mar 2024 14:11:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=TFtyTBRo79tB99DnAI03kMSYaF7y7mkZDXZT3y
	kuzLs=; b=aHnNhYW9+N0n0hcnLTr/4pLZKzUYQVvP7NecdoGQoBM2EmJ3xIUg1m
	vjCbMeNl6cphGQEnD54yGOkJryYYhMNL+KHItaKPoqeLW3KNaz8+hxGtd7MV/8hz
	v/aBXIcW4qhP4kVJeCyd7LeeTy1Wteo+SnvJyR3Py46+QOkxgXSZo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 66D0D26A50;
	Fri, 29 Mar 2024 14:11:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0249B26A4E;
	Fri, 29 Mar 2024 14:11:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Olliver Schinagl <oliver@schinagl.nl>,
  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
  psteinhardt@gitlab.com,  Taylor
 Blau <me@ttaylorr.com>,  Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 1/2] cook: switch unmaintained GitLab mirror to new URL
In-Reply-To: <d9515be6f21a8a95de3319e1046e05606cd91d55.1711723543.git.ps@pks.im>
	(Patrick Steinhardt's message of "Fri, 29 Mar 2024 15:47:10 +0100")
References: <Zf2B5oksaJRDH5WT@tanuki>
	<d9515be6f21a8a95de3319e1046e05606cd91d55.1711723543.git.ps@pks.im>
Date: Fri, 29 Mar 2024 11:11:22 -0700
Message-ID: <xmqq8r20zz5h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C0AC3082-EDF7-11EE-BC74-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> The new repository has now been registered with the GitLab Open Source
> program. It has been configured to mirror [1] and CI pipelines run after
> every mirror update.

OK, thanks.
