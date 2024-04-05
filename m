Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E77171078
	for <git@vger.kernel.org>; Fri,  5 Apr 2024 16:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712334107; cv=none; b=C64znqwfN6i2lOzsvdkX87d09GlgRfay2AREOU6NAWAHb6tzB9SR5Cy5S7AThkQrhAa23BxSpVEV8/iQKlr841gzfXiaIGSQuwCdDPax69EXtJ44ij8Exj5crEwL+WNbCO2GSK7L/hvaG5X7yjmz2RumfB9qguROIl+8S6lQm8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712334107; c=relaxed/simple;
	bh=Zax7Oz434u5JamtWeTsdpoQ90bySrVywjCLa17VGxpc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EloCinPTmlLrmU89/V/kHdsjphBG6Rpqg+XghvmQd1wUJL6ZHZJZVhTPVl+5PqpzZNcdb5N/KDyCaI1OplcFq/choA6cyXz2CWxOfuv0MUGLyVpSvfXlmlFSfm26VxAV3GlmxTq57u8hl4J14cuEVCb5tkZ31xV5JUQN8mDCk4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=uWKa5O80; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uWKa5O80"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id F153621306;
	Fri,  5 Apr 2024 12:21:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Zax7Oz434u5JamtWeTsdpoQ90bySrVywjCLa17
	VGxpc=; b=uWKa5O80qf7W4pE00vb9fLXXifyzeD8zZ1rWZJTCVVV4xl3QWLL/1c
	2+t3E9fujdktNJ0hKL0GjA0I6sTC1YH9T/sjoeso3wzWuXeeWd21/Lc0OQicolnL
	b97KAAB2jakU/F7ZE8KQlO3z9FJHHAzHK4SRTN4NGHPPnYdNwJlGg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id EA01421305;
	Fri,  5 Apr 2024 12:21:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7D26D21304;
	Fri,  5 Apr 2024 12:21:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,  Eric Sunshine
 <sunshine@sunshineco.com>,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH] CodingGuidelines: quote assigned value with "local" and
 "export"
In-Reply-To: <xmqqbk6nyej1.fsf_-_@gitster.g> (Junio C. Hamano's message of
	"Fri, 05 Apr 2024 09:12:34 -0700")
References: <cover.1712235356.git.ps@pks.im>
	<c2c2747ff57f68ccad8b509af037e1fc4a524fa1.1712235356.git.ps@pks.im>
	<xmqqmsq7yezc.fsf@gitster.g> <xmqqbk6nyej1.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Fri, 05 Apr 2024 09:21:41 -0700
Message-ID: <xmqqwmpbwzje.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 96AF6E5E-F368-11EE-BE43-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Somebody may want to inspect the output from

    $ git grep -E -i -e '^	*(local|export) [a-z0-9_]*=\$'

and fix those that can be used with dash.  I made a cursory scan and
removed obviously safe ones whose RHS will never have $IFS whitespaces,
and the following are remainders.  #leftoverbits

t/t0610-reftable-basics.sh:	local actual=$(ls -l "$file") &&
t/test-lib-functions.sh:	local file=${2:-"$1.t"} &&
t/test-lib-functions.sh:	local basename=${1#??}
t/test-lib-functions.sh:	local var=$1 port
t/test-lib-functions.sh:	local expr=$(printf '"%s",' "$@")
t/test-lib-functions.sh:	local inc=${2:-0} &&
t/test-lib-functions.sh:	local inc=${2:-0} &&
t/test-lib-functions.sh:	local ret=$?
