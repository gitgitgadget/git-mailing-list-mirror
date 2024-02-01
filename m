Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5690A3FE24
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 22:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706826342; cv=none; b=HIButS4txdvf05sJKtWF1qd1Jk7mMXnK4XgInz7EAVMhsuYE5lgoQGxJbGED/wJbekwKxtqqKCxB5+2VfZLMv7BtcRvQVUiGZ8jM7OKSdyFReOegwH0YuoX2ceivT7DJG/ysqK8x31rTVh8DwklWEHqb5/bVH4Ao/Kf0uH/dmGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706826342; c=relaxed/simple;
	bh=0Fwq8h9M1ML65qIMJ8kPOVwxeExttcwpkbUKpuT1Mrg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GBnP8WYqXjwvKsWS2fNJcpTN8FgKONATFy23F5DguPgMQvUw1Que7x086SUIQpTKKMplxV+FhEjtRRIukiHF7YHBXfZd0WT4AjhFvjD1GJS+YxjP3GH/glXbnIWSRgGi8XyR4Z8P1inp3tlLQrxNPLRydKLULP+you9E/ftyLsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=A5tNVoY0; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="A5tNVoY0"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id BFD423D4B2;
	Thu,  1 Feb 2024 17:25:40 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=0Fwq8h9M1ML65qIMJ8kPOVwxeExttcwpkbUKpu
	T1Mrg=; b=A5tNVoY0zSNHUpj3t/uMRoI2Tf4QavfWt5F6YEVHEmQzAQD/tnLVd9
	TW+gFKyC7qvTj1KWxBiSQOJ7u2K+tqBHT0P+NuNzylSwZ9MWNFRcuPRjLBnkb85n
	XvQnHS1ddZXY0eVCQx4NuKQwo+VvL+k/LWl64tMX28e1/+Oh/Z3Qc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B8EC13D4B1;
	Thu,  1 Feb 2024 17:25:40 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EBE033D4B0;
	Thu,  1 Feb 2024 17:25:36 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Christian Couder <chriscool@tuxfamily.org>,  Emily
 Shaffer <nasamuffin@google.com>,  Josh Steadmon <steadmon@google.com>,
  "Randall S. Becker" <rsbecker@nexbridge.com>,  Linus Arver
 <linusa@google.com>
Subject: Re: [PATCH v3 09/10] trailer: delete obsolete argument handling
 code from API
In-Reply-To: <885ac87a5447e54139171fb3eda62055ffd517cd.1706664145.git.gitgitgadget@gmail.com>
	(Linus Arver via GitGitGadget's message of "Wed, 31 Jan 2024 01:22:23
	+0000")
References: <pull.1632.v2.git.1706308737.gitgitgadget@gmail.com>
	<pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
	<885ac87a5447e54139171fb3eda62055ffd517cd.1706664145.git.gitgitgadget@gmail.com>
Date: Thu, 01 Feb 2024 14:25:35 -0800
Message-ID: <xmqqplxfx1nk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D2989E8A-C150-11EE-AFD0-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Linus Arver <linusa@google.com>
>
> This commit was not squashed with its parent in order to keep the diff
> separate (to make the additive changes in the parent easier to read).

Hopefully we won't see such an artificial separation in the new
iteration.  As we saw, being able to compare before and after images
in a single patch is useful while reviewing a change that is supposed
to be making things cleaner without altering what they do.
