Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0FE481D0
	for <git@vger.kernel.org>; Tue,  2 Jul 2024 18:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719946522; cv=none; b=YtQM1cmmQ9Rdl/FkDFTGiQH1edxCxWT8k4yNUipwvX3ryJlr0rnuWJphTmy+XvpnDgoRvcInNP0vWltb2W/l5bxQhXcD+EqvP5X4sV3oHYTOZNyl9MH/A3ubM2c9/3+ppUJXeJbHo/za67wMg1NcBho5vMEBAR4w41pLgy+fHQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719946522; c=relaxed/simple;
	bh=jQ1BgqFOlyvjhKAjYlVxymujHid8ULJ9jfw+wTOAoQw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ntUHSreDRuqmuZHalm4eduiptR2fYgPIrgUiKFGoUvZKZQBaOEeeDVK8ZjG6+XNTOUjAgZFdxQVRauZB1mmTeceWsB7VvawPYLcBaoH7Y73RE4xYhYTeCLv7YUEifvUJWZ7X+tSWhFcDG6yoWL9LhghURd685v0uNx5fh6aVrGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ENt0KKTO; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ENt0KKTO"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5A95B26747;
	Tue,  2 Jul 2024 14:55:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=jQ1BgqFOlyvjhKAjYlVxymujHid8ULJ9jfw+wT
	OAoQw=; b=ENt0KKTOOVDLxMxpjG4PwjPecox+6KJCst0NiwHwevkUIAvQuXILSA
	kO2iJsGWLR9iUso96YfosVLOBrUMCICbp2AvFNekf6Bd/TMuzX82AMijcvVAO5xR
	TP6KWbQu6oiBHIGkzKqSUfW3R496LDu05HB9irZHFFBye6dC1j3qk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 52A6326746;
	Tue,  2 Jul 2024 14:55:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D2DB426745;
	Tue,  2 Jul 2024 14:55:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,  git@vger.kernel.org,
  Jonathan Nieder <jrnieder@gmail.com>,  Josh Steadmon
 <steadmon@google.com>,  christian.couder@gmail.com,  Christian Couder
 <chriscool@tuxfamily.org>,  Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [GSoC][PATCH v2] t: migrate helper/test-oidmap.c to
 unit-tests/t-oidmap.c
In-Reply-To: <16e06a6d-5fd0-4132-9d82-5c6f13b7f9ed@gmail.com> (Phillip Wood's
	message of "Tue, 2 Jul 2024 16:24:54 +0100")
References: <20240619175036.64291-1-shyamthakkar001@gmail.com>
	<20240628122030.41554-1-shyamthakkar001@gmail.com>
	<16e06a6d-5fd0-4132-9d82-5c6f13b7f9ed@gmail.com>
Date: Tue, 02 Jul 2024 11:55:14 -0700
Message-ID: <xmqq5xtnsjxp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9F37B2EE-38A4-11EF-9FB3-C38742FD603B-77302942!pb-smtp20.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

>> +	}
> 	check_int(count, ARRAY_SIZE(key_val));
>
> to check that we iterate over all the entries as well as checking the
> size of the hashmap here.

I think check_int() macro wants the comparison operator in the
middle, but other than that small typo, the suggestion sounds quite
sensible.  If the iterator does not yield anything, the current test
would still pass.

Thanks.
