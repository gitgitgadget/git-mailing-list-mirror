Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15F34D8CF
	for <git@vger.kernel.org>; Thu, 30 May 2024 21:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717103868; cv=none; b=FIqcxk9TW9LPkE8eMYnkzTNDdv1pefT40/PJ6nlcQmPVyLAeMFFUywlebBRhxnlyShEue/iu2m0TiQHi8+8WmIJgjwaV26sy2v0IO2xpef1x7QzBSlTFguHLtF+xKCdUAZDvpiNmoajYvv7irHbQidGyI53L5tBXA5owSRA3IyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717103868; c=relaxed/simple;
	bh=owfBfAdbhWgFSked55J3g5SeEcHae9WUFjedVMggavo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iLfyDPyKWERjQnm0TvP0Z/YbY/DfazGxIgQIWjjSBYaZ2gyM7eY5NboC6htoai9t8Xd4GkusojAdw9y3IR7ANBFloZaGApH9ANnijBRqtV8WlW/DPBzXSrE0TKtrKk2sTC6fh7zmvyBSZqKEAWheHsGZZuLyHiuvqpkr/9O2mX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=fz9xo2KQ; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fz9xo2KQ"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 558583D115;
	Thu, 30 May 2024 17:17:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=owfBfAdbhWgFSked55J3g5SeEcHae9WUFjedVM
	ggavo=; b=fz9xo2KQxkHjayazMMw9aLvty1i5Td0BSf9b0U/6CItgmPiNl1+rez
	dDATVgxR2cSl56ZEiUq1CvrXn2uH31POS7/dy9yExfOUtY48Iyo2MBNvkQ5+rfE9
	rotjONazKGYgijxNyp+bG3kRsxEMGyz3HlvgVJGvDg8llQSHHrGF4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4D7023D114;
	Thu, 30 May 2024 17:17:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B0DDB3D113;
	Thu, 30 May 2024 17:17:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: Marcel Telka <marcel@telka.sk>,  git@vger.kernel.org
Subject: Re: [PATCH] scalar: make enlistment delete to work on all POSIX
 platforms
In-Reply-To: <v6q5pahyzcoa7c6tp2x63awvtc6xvjjpi4kl5okgk5qi4god7f@yg55zwwmcuzt>
	(Josh Steadmon's message of "Thu, 30 May 2024 13:57:13 -0700")
References: <Zkds81OB7C5bTCl_@telcontar>
	<v6q5pahyzcoa7c6tp2x63awvtc6xvjjpi4kl5okgk5qi4god7f@yg55zwwmcuzt>
Date: Thu, 30 May 2024 14:17:37 -0700
Message-ID: <xmqqwmnbngni.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0AEE2BAC-1ECA-11EF-9F0B-B84BEB2EC81B-77302942!pb-smtp1.pobox.com

Josh Steadmon <steadmon@google.com> writes:

> This looks like a straightforward change; none of the formerly protected
> logic uses anything specific to Windows, and tests still pass on Linux,
> so this looks good to me.
>
> Reviewed-by: Josh Steadmon <steadmon@google.com>

Thanks.

With Dscho's Ack we saw earlier, I should have marked the topic for
'next' already, but I was placing a lot of things on back burner.  A
gentle nudge like this is greatly appreciated.

Will merge to 'next'.  Thanks.
