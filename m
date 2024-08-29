Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BF01BAECC
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 21:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724967848; cv=none; b=IWy+2Xg51Z4W4SENKhfxyCTS5MgqR+3LtRQypbGrlSA4RSrCRMQZl27ZU9e8Sw6VxUTdsw+wA3pT+/PVXijXeZCcMNi5nPWCDPfEWrPyacO6Cm15XF5qKwU/7vcPTe16li0A1QcWyta5fQSZsdDg6xGlukVSGhydAL1ZfDB5FnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724967848; c=relaxed/simple;
	bh=RqyNEZuHI8uzyLOd2+G48zd8GBY7H4N8T0iw4vTxdS4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c84aF23KzpZnmB709iOfVKpdsxNL95nn7g+j/q26UxE2vN7nuDU33zb6p/kkS5gK6uTEbytpmowCTXzBf2S0UOjYPnwVGXcHaNUozoqTTAcRniIC4oxMUjnMUERKLo0/L4fCjfYeQz+J45vVdquw8zJ6i9PagvSG2WC3p4po/ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Kpk1V7Hu; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Kpk1V7Hu"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4009735A81;
	Thu, 29 Aug 2024 17:44:05 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=RqyNEZuHI8uzyLOd2+G48zd8GBY7H4N8T0iw4v
	TxdS4=; b=Kpk1V7HuJegM10CBcLr7eR0c/MRNyQrXPI1uF16lrv5REx/DYdoAAj
	PqXGd7xPKE+1YQtPaIQQVixVOjVBDrTxw6UQ7p6v9n24vMX7Yu/uLKA0GugggvF+
	vq1MZ9DW14ZEsfIQTZeObGBiQkN3mahakV13iipAPp/P3SMeDpung=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2562C35A80;
	Thu, 29 Aug 2024 17:44:05 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2FB5F35A7F;
	Thu, 29 Aug 2024 17:44:04 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Yukai Chou <muzimuzhi@gmail.com>,  git@vger.kernel.org
Subject: Re: Tags auto fetched by "git fetch origin" but not "git fetch
 origin main"
In-Reply-To: <ZtDo--AY43-bPTHG@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Thu, 29 Aug 2024 21:32:43 +0000")
References: <CAEg0tHRbGBBq7i78bTSfws_WZO=2W7xuDwiT2qFA5iOza8qDDA@mail.gmail.com>
	<ZtDo--AY43-bPTHG@tapette.crustytoothpaste.net>
Date: Thu, 29 Aug 2024 14:44:02 -0700
Message-ID: <xmqqy14ft36l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CF8CD536-664F-11EF-A9D8-9B0F950A682E-77302942!pb-smtp2.pobox.com

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> If you want tags nonetheless, you can use the `--tags` option, which
> should fetch tags in addition to the refspec provided.

But doesn't that grab _all_ tags, not only the relevant tags that
point into the history leading to the commits being fetched?
