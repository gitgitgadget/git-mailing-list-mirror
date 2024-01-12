Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C1116408
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 20:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uCamyxc9"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4347D27ECC;
	Fri, 12 Jan 2024 15:18:57 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=gdSPO7BiiJC3g+9G09p4NVBJiqlDpClfvz15ox
	fSL/E=; b=uCamyxc9DHrm13rE3q+l/uKlMpw2I0l146EErbw8Ybku7OZM4qz2+R
	uZ8G8CYDEX15OjqZbrF+4IKu4dmgxze+R9IDD4Ib5elbDLxomyFIin5mtH/aRfwZ
	0eIGXHTeBXbAlPXXI7ezaxXIOOBMyydgA2ernMkP1K2CxRucuFjEQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3B7D927ECB;
	Fri, 12 Jan 2024 15:18:57 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7D83727EC9;
	Fri, 12 Jan 2024 15:18:51 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Michael Lohmann <mi.al.lohmann@gmail.com>,  phillip.wood123@gmail.com,
  git@vger.kernel.org
Subject: Re: [RFC PATCH] `log --merge` also for rebase/cherry pick/revert
In-Reply-To: <ce46229d-8964-4445-9a17-cff40aca1cb4@kdbg.org> (Johannes Sixt's
	message of "Fri, 12 Jan 2024 08:35:50 +0100")
References: <20240111233311.64734-1-mi.al.lohmann@gmail.com>
	<ce46229d-8964-4445-9a17-cff40aca1cb4@kdbg.org>
Date: Fri, 12 Jan 2024 12:18:49 -0800
Message-ID: <xmqqv87y9ufq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CD2133C8-B187-11EE-8F61-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Johannes Sixt <j6t@kdbg.org> writes:

>> What do you think about this idea? (Or am I maybe missing an easy way to
>> achieve it with the existing code as well?)
>
> Ha! Very nice patch. For comparison, have a look at my patch to achieve
> the same that I never submitted (in particular, the author date):
> https://github.com/j6t/git/commit/2327526213bc2fc3c109c1d8b4b0d95032346ff0
>
> This implementation is more complete than mine. I like it.

I like the way your other_merge_candidate() loops over an array of
possible candidates, which makes it a lot easier to extend, though,
admittedly the "die()" message needs auto-generating if we really
wanted to make it maintenance free ;-)

Thanks.
