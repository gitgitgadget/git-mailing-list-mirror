Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEBB5B698
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 16:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711126119; cv=none; b=skGGUlj/vvR5Z/mT5KEte65TUmZCeB09w/4yGgGnERB8GeiMh6A+x3t0KTtOThYcTR+APOJUgR2Br//FniHe5hkRv/xIT/M/XumueVpqOmazG1mEkJLmExOnCCA4gR8wZzWZowUy17/df0yUG6WH2kDlMRF3apeeF5xwfycH2x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711126119; c=relaxed/simple;
	bh=fUlbZFZEn0IcbMVeKPz+NlVyu/DNUHpUafn5JJlt1tQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BiKzcmJ+wx4lzuN8jzTPfKjl2z9+tCELcuRlaGbNZM3V8DryDWaIo0inVmrGP79/9+T/43ebyCzehT8YaCBkiIHLHcJ10ge5l3QwuBMnbUUTMYkP9QBvxY7oytJH67Vuur2VMekaDe2jc4nmTUji4bbs6lVeuQSrnh5wUI/cIFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=mnFCyuZu; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mnFCyuZu"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C00C719A02;
	Fri, 22 Mar 2024 12:48:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=fUlbZFZEn0IcbMVeKPz+NlVyu/DNUHpUafn5JJ
	lt1tQ=; b=mnFCyuZuydK+sSs3pu8l7yqW92RXYOkqrO1dOLDXp+FaA/I01BPbld
	AnocicJe8azuDL0BQzX6/NemaWo6vXykNtIC0+v9JjVlJ3oWDBiclH7aejlgbeRz
	+eO/8/4C5nu7fqCPq+fMQmb84o07UQKtd9WM57m621uZ8EyIWTqIg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id B8D8919A01;
	Fri, 22 Mar 2024 12:48:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 343FD19A00;
	Fri, 22 Mar 2024 12:48:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Stelian Pop <stelian@popies.net>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Jeff King
 <peff@peff.net>,  Matthew Rollings <admin@stealthcopter.com>,
  git@vger.kernel.org
Subject: Re: [PATCH] contrib: drop hg-to-git script
In-Reply-To: <37e4cd61-b370-437e-bd42-f98f47d3ad32@popies.net> (Stelian Pop's
	message of "Fri, 22 Mar 2024 09:36:23 +0100")
References: <20240320094824.GA2445978@coredump.intra.peff.net>
	<01de5e16-a4ee-47df-03e6-67f5f0d601a7@gmx.de>
	<37e4cd61-b370-437e-bd42-f98f47d3ad32@popies.net>
Date: Fri, 22 Mar 2024 09:48:32 -0700
Message-ID: <xmqqy1aa1acf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 058CB19A-E86C-11EE-AEF9-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Stelian Pop <stelian@popies.net> writes:

> Hi everyone,
>
> FWIW, I have no objection to this removal !
>
> Signed-off-by: Stelian Pop <stelian@popies.net>

Thanks.
