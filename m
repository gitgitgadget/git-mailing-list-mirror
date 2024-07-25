Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5EF7482
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 15:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721919794; cv=none; b=ZtUu6TZ9D2G4E+V+XV2R9njurdyDYdYXBKVDKBvzD9M0gTN414JICA3fLig4l2UWiGXJWLiBcFEi/MpAEF2orHICvjiBM2xHMreWgY4UpbV4OciGGiF50RGTlPkRUWpQieG/VaUt5vIecWu0/fEfbTFLa7rid51eoyNZTmi8ffg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721919794; c=relaxed/simple;
	bh=dn4MtSpDA6lHICXufhJWGTpPSMu6wp8WsW9UzZKQvJQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A2eN3A9ftBL+3U5MjbdlMBR/C53yq28EvLEeG/+b4+7pH+7m8oqySHxsbW9Lq3llog3k5766rLnI2W+v1zgUHgDtyPWbqmqmwTTcyEYBjmHw3mukf4bk+yGPNwM5KT9lhBz2GMNJCVOSAnJYkgiQAupX3KAttcYD3SvIM3VBJdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=jDWAU2Te; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jDWAU2Te"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 46B98287CA;
	Thu, 25 Jul 2024 11:03:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=dn4MtSpDA6lHICXufhJWGTpPSMu6wp8WsW9UzZ
	KQvJQ=; b=jDWAU2Te9Bse2ZRAVNPRXXtGs3tRyBs3iC+oz47pnOe4pRMimTc1jt
	V9trUg2B9Xg0cfE6iaeriDQGqbIzZBFMuISTXUolbiNF2lar9d5nQvi9sLW3OJTd
	f2WD5lD/pEbLHmd/LD9yHhdIk3qXS05WepiaGlJCsB7BSfE2/S0D0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 3F116287C9;
	Thu, 25 Jul 2024 11:03:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B87E7287C8;
	Thu, 25 Jul 2024 11:03:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Alexander Shopov <ash@kambanaria.org>,  git@vger.kernel.org,
  worldhello.net@gmail.com
Subject: Re: [PATCH  1/1] show-ref: improve short help messages of options
In-Reply-To: <ZqH7mDh73vkX4bPT@tanuki> (Patrick Steinhardt's message of "Thu,
	25 Jul 2024 09:15:36 +0200")
References: <20240724111116.91615-1-ash@kambanaria.org>
	<ZqH7mDh73vkX4bPT@tanuki>
Date: Thu, 25 Jul 2024 08:03:06 -0700
Message-ID: <xmqqr0bhldjp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 00EB4218-4A97-11EF-B036-9625FCCAB05B-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Agreed, I think that this is a sensible change. In practice, this
> feature can also be combined with `--head`, so in that spirit we might
> even change it to:
>
>     "only show tags (can be combined with --branches and --head)"
>
> Not sure though whether this is getting too noisy?

It is somewhat an oxymoron that "*only* show X" can be combined with
"*only* show Y" in the first place.

For a reader to accept it without finding it awkward, the reader
must understand that

 (1) the command shows by default everything, but

 (2) if any of these "only show" options are given, the command
     stops showing everything and the user can pick which subset of
     "only show" options to give, which work additively.

But if the reader knows that much already, it is redundant to say
"can be combined with", isn't it?

So, I dunno.
