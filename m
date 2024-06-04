Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8470D7E2
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 17:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717521402; cv=none; b=motLgwIjruvArKuarjHiKzvqhL0PLuTUNpBMz0G6JBPpbGtO/Y22zlTxUmKEu9Qzk6T+ykE535rqUWsIXu1NmhiOZYUzKRZFw9kHnZquh/zIocj4HgSam6VeyVEYeSTwV+8tfNcruH3O2AGklcXQaWKaf94gFREQQtHwP6ZyNHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717521402; c=relaxed/simple;
	bh=zxGZuwlUtG8XTVN3PEZXxpR5cSUX6Ggc0EY6KVUYDcw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y/xztIl8YA3LqXnls0VrZcya/ld9xGYcE+Kghbuzr6ErUZAd/mN2jYzDYJc5MBael2eemxiNa4FzqoGMPOCrJd15Y75T/0JXdA3CDniXsqVoRs00sG3rD4e+IS7o22xSWhcNVHLmD4SKZmNp4u92MhkwauEpB4rmtPPBZCX93vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=q5AIIkqC; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="q5AIIkqC"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 652381CDE8;
	Tue,  4 Jun 2024 13:16:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=zxGZuwlUtG8XTVN3PEZXxpR5cSUX6Ggc0EY6KV
	UYDcw=; b=q5AIIkqCLqBAlop2GBbSxMT7+2kFcejdk1B2TAl0otEcHgXNVuyGhk
	jnOMDEQuI7dNg7rOExZpMummbGlCF214oKWs4q7JMbZb43xhzkDiiOCIJrQdlOdj
	viEXk/zC6uqwFammZInEnA66+Ifx2nnP+QZCUwUZkz/39JEsSx/kQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5D8481CDE7;
	Tue,  4 Jun 2024 13:16:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CA2491CDE6;
	Tue,  4 Jun 2024 13:16:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Phillip Wood <phillip.wood123@gmail.com>,  Justin Tobler
 <jltobler@gmail.com>,  Dragan Simic <dsimic@manjaro.org>,  Karthik Nayak
 <karthik.188@gmail.com>,  Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH v5 2/4] BreakingChanges: document upcoming change from
 "sha1" to "sha256"
In-Reply-To: <Zl682Dk6RcFOC2rA@framework> (Patrick Steinhardt's message of
	"Tue, 4 Jun 2024 09:06:00 +0200")
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
	<cover.1717402497.git.ps@pks.im>
	<b36ffcbaa67dcdada630e2d582e75da623512743.1717402497.git.ps@pks.im>
	<xmqqfrtu56fo.fsf@gitster.g> <Zl682Dk6RcFOC2rA@framework>
Date: Tue, 04 Jun 2024 10:16:36 -0700
Message-ID: <xmqqtti8wruz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 343A5858-2296-11EF-BBB1-B84BEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> I agree that explicitly mentioning (1) and (3) is sensible. Is the
> second one important though given that this is about the default when
> creating _new_ repositories? I don't think interop code is a requirement
> to make "sha256" the default, is it?

Let's drop (2) from the list, as I do not think there ever was a
concensus on it, and also for the sake of brevity.

Thanks.
