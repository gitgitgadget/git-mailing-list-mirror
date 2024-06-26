Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081AC53364
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 22:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719440934; cv=none; b=o84OGTf9Hrvm1WR+OGeuyHofbbAeh9UJW8jSmQMVt9Vg/NLB0II46H8X0yqmMsI0pjUwCP2WAr5Dq3bADzN2/BBCooXYbCUpk6/LHSlPCjDfYLeQ2WwKIoQxPYMyhieHEAyMyE9E5HcP10xqYQyBs/muISlXsc50QIxEbOtyu+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719440934; c=relaxed/simple;
	bh=EuLoY/f9gMOS1gJ0QWSuy5Wla3zK0OVxU/RizlDatGA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LSckjPz/bxS1JNckr86JrwtlURtKflCbDmSsI2Zi4sVHzW78mRxuqFmdDIvZ3/lwX42pG84e4APHMC8zPNSl7TOJt0E/rYFMYaShXb8xWBL5ToUiC/hMbA7iLMeHGg0rOk4k8b0hWgn0TWBMY7HPO3804/5Ykgv65RGgJa3Dx04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=DTJf2mZU; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DTJf2mZU"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5AFBD3507B;
	Wed, 26 Jun 2024 18:28:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=EuLoY/f9gMOS1gJ0QWSuy5Wla3zK0OVxU/Rizl
	DatGA=; b=DTJf2mZUE6D3JaZktq27ub2sdb/RzDmGMkKYawJf6I+XBJ2krnCeDw
	99m3+D0XUGOO+4hnxe6NFmgiRcvHDBZGKVXY+QZLTeaoPB5wLn3D/XxXOaEtZRJJ
	4WB4frxoQYEPuXuY11AVzXrUbvPpEjoTLgnzSZiWYG7avA5RALwms=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 514953506B;
	Wed, 26 Jun 2024 18:28:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D5C3335060;
	Wed, 26 Jun 2024 18:28:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: rsbecker@nexbridge.com,  git@vger.kernel.org
Subject: Re: [PATCH v0 1/1] Teach git version --build-options about
 zlib+libcurl
In-Reply-To: <20240626204232.GD441931@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 26 Jun 2024 16:42:32 -0400")
References: <20240621154552.62038-1-randall.becker@nexbridge.ca>
	<20240621154552.62038-2-randall.becker@nexbridge.ca>
	<xmqqmsnekvir.fsf@gitster.g>
	<016501dac409$7dd5bc00$79813400$@nexbridge.com>
	<xmqqwmmijf6f.fsf@gitster.g> <xmqqplsaje6z.fsf@gitster.g>
	<xmqqtthlimtr.fsf@gitster.g>
	<03ef01dac735$f3496ac0$d9dc4040$@nexbridge.com>
	<xmqqmsn87n9x.fsf@gitster.g>
	<20240626204232.GD441931@coredump.intra.peff.net>
Date: Wed, 26 Jun 2024 15:28:46 -0700
Message-ID: <xmqqbk3nwd7l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 74B26232-340B-11EF-8998-C38742FD603B-77302942!pb-smtp20.pobox.com

Jeff King <peff@peff.net> writes:

> But that may just be me being overly conservative. If nobody looks at
> those symbols, I'm not sure what harm would come.

Yeah, perhaps on some exotic systems it may cause problems, but
until we see such a system, or we want to extend it to do the
curl_version() call for runtime, whichever comes earlier, I think
we can leave it as a (#leftoverbits) "future enhancement and
clean-up" task to be done after the dust settles.

Thanks.
