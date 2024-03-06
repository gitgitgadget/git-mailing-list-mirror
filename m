Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAC36FAD
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 01:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709686830; cv=none; b=RYz2cSEGNGEANXHThYX/u4sumfXm3gUMa5WG3F1fTuHPaEHDzAIpdpbx9jbumvVkAkQzikR/o8XrApMSlX3wTlhgffXVN2VgPk0nywWdoW0fkPgLnCaWBcDdBHncNFFxPO91Mz2qFZbmAuMbK98xYVjsMrbRUhyTbzoz8yoQOWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709686830; c=relaxed/simple;
	bh=SY2OBAffV0mYD03JyqkEhBszQji4AQcjgro87qBUtgA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ForxeBExIwDw3icP9trKP0ww8Iuegnye/Jl2pxp4JdxvbCo1ujMCV5Fyi1zgS2v0TPwTCnK4kXwUKzIrqlUHFwr7LZzd0prr+8KbccUB0k0/pVa9asxSMkDBsIFWrtZMrE4I7DOX/RzuUZk4khxlES6bWBrzyIlxUdLaT9pZ9qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=h9e+IQjE; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="h9e+IQjE"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BD3A51D18D7;
	Tue,  5 Mar 2024 20:00:27 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=SY2OBAffV0mYD03JyqkEhBszQji4AQcjgro87q
	BUtgA=; b=h9e+IQjE5SDrC7u6BhTX6TI+UJTlZfo16W3rMkvMjXxOaMXK4Q7hSM
	++JdBPwDXrN5hfUFzjdOftKIrnhIwMEAFghhztJ84biHQtGTEXyF9HBkrKCJxuBx
	cXvXD6w1L9B5tuF3MVrqOqGWIPHNnhXZnPpDvkCeOrcP3Q2tHWMHI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B2AFB1D18D6;
	Tue,  5 Mar 2024 20:00:27 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 141781D18D4;
	Tue,  5 Mar 2024 20:00:27 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Beat Bolli" <bb@drbeat.li>
Cc: git@vger.kernel.org,  Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH 20/22] t/t9*: merge "grep | sed" pipelines
In-Reply-To: <20240305212533.12947-21-dev+git@drbeat.li> (Beat Bolli's message
	of "Tue, 5 Mar 2024 22:25:19 +0100")
References: <20240305212533.12947-1-dev+git@drbeat.li>
	<20240305212533.12947-21-dev+git@drbeat.li>
Date: Tue, 05 Mar 2024 17:00:25 -0800
Message-ID: <xmqq4jdkw4wm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EB923AFE-DB54-11EE-83C9-25B3960A682E-77302942!pb-smtp2.pobox.com

"Beat Bolli" <bb@drbeat.li> writes:

> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> ---
>  t/t9118-git-svn-funky-branch-names.sh | 2 +-
>  t/t9350-fast-export.sh                | 2 +-
>  t/t9824-git-p4-git-lfs.sh             | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Looking good.  Thanks.
