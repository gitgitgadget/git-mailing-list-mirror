Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5B61D278F
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 15:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725635588; cv=none; b=YxcbJBi9JspLDxydHxY/uEAPadBjWPSQDD8s26k3mNY9YaVRk29SpnzFQdkD0BjKiNosxxMqvHpEdawirvoh+tOp0J73/ncuIVcxsOzvDiLh9gy/PkdG4mxX0cPs/5z2wECKMEDrH/tzqp3RFXQsColrEriWfzodCql7R36e0J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725635588; c=relaxed/simple;
	bh=Y0uZ9m4zh0271vaw/Y2uXL/+TlVaDQuIQGXR6zQeoAA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DMf+MA5UlXe/IjY98pGzQbvcxCZL+gcahsPPMkCAOuqM819QJaH6WoSvhFOT5RUA73ACJKVCxO9MXCOwkyyIWMvv72ws2kYYbmjHzj8bq82IXzxnsh5pKXNrQDMXEanjTU/ZKTboAAOwAAU8NGRwWPOJVtHXQoVUaNw1mwYDrJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ks1x8g7F; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ks1x8g7F"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6B3DA35826;
	Fri,  6 Sep 2024 11:13:05 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Y0uZ9m4zh0271vaw/Y2uXL/+TlVaDQuIQGXR6z
	QeoAA=; b=Ks1x8g7FxGtC2Fbo+g8OFZTFSQKWw6f/19aTfU7XQTXWYEoIGpVP8T
	3DI1ECZZ/ChrdRA8SmYLwQk+orAz2qefmwb7DoruSiO2yWpTDOMMCWPnQwxCyZsE
	NNqS0E+S2NoWQy6wxVjrocolyLi5ANbfQibLDqMgbHfnxgXJIAeNg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5D99735825;
	Fri,  6 Sep 2024 11:13:05 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 29C3535823;
	Fri,  6 Sep 2024 11:13:04 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] scalar: add --no-tags option
In-Reply-To: <58ca5257-2e56-830c-c85f-79e4c9e80858@gmx.de> (Johannes
	Schindelin's message of "Fri, 6 Sep 2024 09:23:49 +0200 (CEST)")
References: <pull.1780.git.1725545614416.gitgitgadget@gmail.com>
	<58ca5257-2e56-830c-c85f-79e4c9e80858@gmx.de>
Date: Fri, 06 Sep 2024 08:13:02 -0700
Message-ID: <xmqqwmjoyfwh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8394D35E-6C62-11EF-88AA-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> None of these suggestions, in isolation or in conjunction, seem big enough
> to me to warrant a new iteration; I just offer them here in case you want
> to iterate on the patch. If you want to keep the patch as-is, I am totally
> on board with that.

Everything other than "prefer repeated use of -C instead of a single
subshell in there" (which I think worsens readability, even though
it may save one process), I agree with your suggestions.

Thanks.
