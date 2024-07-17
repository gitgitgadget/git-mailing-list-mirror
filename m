Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD840947E
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 22:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721256688; cv=none; b=lRzIF13Hn74pia7/6mJSJReA0xUPQ6uOwlaPv3tjjmBlf8WSd3qcvgCsL2p/wwNqayX0vPLhQN9VpfFJZs4Cju/IlnmMTwMahjEclIrnaTV1m6EwyjxlsIjEfpD2N1tdKc8IpdUDV0roLc5zlmn6U5mmMtG7l5eO5ie45AgLD50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721256688; c=relaxed/simple;
	bh=vFChBUdViMLUGO7xl1yV094juZutD+VSokUL0lqGfTk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Goe36TcXJAa+e7mSnmJwWduOPhoUdCmdi7q+nyPCTONL3W/sdaeunzYu3vT62LUd32irrpKgPnXPttx6HhVgOpZs6RPAmnUQ1O//bV8oy6/Vivnuw1MvabV9/7VgLjlcBqh6hQCT8ygLz9I/ET88zYjacH3eA8Q5HeRy9YwbjcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=NafVUJ0n; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NafVUJ0n"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 932DC2358A;
	Wed, 17 Jul 2024 18:51:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=vFChBUdViMLUGO7xl1yV094juZutD+VSokUL0l
	qGfTk=; b=NafVUJ0niQqJVHhBrTTnXF0ZBfN62vRVa5EqxHR2zxxKGeFiTCmAZM
	jpKUFvg+LUQ/qMbcBAZUlu9HFyNZcC64PCS+sl1AKvxPrqCHC87VU8nRhsfonGnS
	9rhHfbpcbZwWW0ITVmLM3onoxU+eEpvJ9H4hFdK4HQDUUktSgy0OE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 8BAEC23589;
	Wed, 17 Jul 2024 18:51:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 19A1B23588;
	Wed, 17 Jul 2024 18:51:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  Johannes
 Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 0/7] var(win32): do report the GIT_SHELL_PATH that is
 actually used
In-Reply-To: <ZphKBe5gmWKJnrqm@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Wed, 17 Jul 2024 22:47:33 +0000")
References: <pull.1760.v2.git.1720739496.gitgitgadget@gmail.com>
	<pull.1760.v3.git.1720904905.gitgitgadget@gmail.com>
	<ZphKBe5gmWKJnrqm@tapette.crustytoothpaste.net>
Date: Wed, 17 Jul 2024 15:51:16 -0700
Message-ID: <xmqqa5if3a57.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 142C119E-448F-11EF-BD30-C38742FD603B-77302942!pb-smtp20.pobox.com

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>> Johannes Schindelin (7):
>>   run-command: refactor getting the Unix shell path into its own
>>     function
>>   strvec: declare the `strvec_push_nodup()` function globally
>>   win32: override `fspathcmp()` with a directory separator-aware version
>>   mingw(is_msys2_sh): handle forward slashes in the `sh.exe` path, too
>>   run-command(win32): resolve the path to the Unix shell early
>>   run-command: declare the `git_shell_path()` function globally
>>   var(win32): do report the GIT_SHELL_PATH that is actually used
>
> This series seems reasonable to me as well.  I of course can't speak to
> whether the approach for finding sh is the right one, since I'm not a
> Windows developer, but I have confidence you know the answer and have
> thought through it fully.

... and the series will be in 2.46-rc1

Thanks.
